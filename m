Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4097606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xUnDzCPB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl8s-0004Vj-Ta; Tue, 10 Nov 2026 07:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8f-0004QQ-Tr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8c-0006bg-N5
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so18142235e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314384; x=1794919184; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y9hs0pjKN6Lzdc4BpIOVcC83ZdGSoWRrJ9jzqC8X4L8=;
 b=xUnDzCPBAfH/YFJ4d4vDEcxbARjYgz9vxAIvJum6WkRZuOrLEQD+CNAK3JuG/eOhAg
 fQFIZXJfL2Ufn/LnJnkDsXB512Gv5iiiUfbWiPlYA0lHuCsddyCKA18VVxq/+1ow77Hz
 +7Hz00YUroSmTi0sCFwXkWh+oAqqYTv0I31negCmd5cDdXxH8I2jU1Cnae56S/YPSyj4
 vXccovAtwlQxUvK/xKgGHdX2UtgDw/yU0qPUAxvt0mAEbEBIS18TAqEKVVkC5U5xEo9y
 kEWm8T0lyGnS3HkY4PRpY4iv5LuweYCV20a6WKHdq99WtQBaEzzwtvegKSIxyhe9mgYH
 3nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314384; x=1794919184;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y9hs0pjKN6Lzdc4BpIOVcC83ZdGSoWRrJ9jzqC8X4L8=;
 b=BegmAmASAeldKDm77f6PvRK+aZWlDRq119ptzbBs5E5pEaSRm/W+T/6UaWW4bmCw0e
 z9hCQEJjmLCipq00AitQsM9g+M5/DGkbQF2XYK6AKcFVGT8MbJJ9X5T85tap18JgxfZL
 iVHuOO0VpE0J+V+q+gyF2aPTxlLsRaVa8EYaaWYIhjoh9VZb5N/v4w+YoXtp85F/5dxd
 PY2P6Les1IDUce0tRacSvDHy62KYNOf8KggqgMKHr4VT34uVMsYH1onxQbWk5s3U2EIB
 cycba/SnlLOgaEGIWj3P2pfmyN0LXS7s5HTB/48UwiZghxIIUe8gq779NkF+pCmt1efg
 GZCg==
X-Gm-Message-State: APuU4Z90ym3UjatHUW3ZjGhvrdoOmhSPWJ7kU+kDe8nqv2Ntn4MXb59Y
 n9z4CaSzC0poAjoo6Yu+9l5q98tJefoyfv6/klf7z0BO8lZ+LGrKcp75kIJNgImmAx4=
X-Gm-Gg: AYBFou37MxcgklSOt0FIrn6Ls/XDB6U1RWtuqFPTIRpwWcBlcoT7sP+omgrtOzIgMTw
 sqQPmdqpZDVGqcUdO32VGs/qNK0/FBbiEG+fUZ7Vym6MiSdl5m7tZWv/buNcy0/iQX/sea7o3id
 447UxNOTa2QNLs7gKWWnrO0VDRkudYmwqLwAKPLenCbHjdGzxM4eK1WNfu6i1IpENlv7qgMic/O
 DSqR7e5hWsLF6L3Pb8P7UV/ik65ecMpH4JuYi0MW4OaInBv1mcomV6omhJAQTkR5ObYj9XVWmj/
 MGFUfr5f8xDZkrMqhNQjeC1RIagNIcL0fu6CEPJxAWD98mIqLv++tRE5RDdBeaRElBJtk/lZy8W
 hPRa9CghFJ/UnrFIgZRAhYVui2EmVtTXudCb5Ad+lXbfkvVFe8bI+g3csEV3aFRiq2qK3uC4/Qv
 ENbzYxvw3Ujx68zAh3E6TiTnOGGDIvwRJdr1Nzzv0n/krlo/iBSBFDjRLirmggbRfgwZwY8WuFF
 DDeq8UcZGUpQeWM5spa4YQvtJg3cZO/HZq/nE+wNyTE5X3q9++V6rhGYVeAydO2/Ca0zlumeD7s
 JjanvXnJOQNTathM+GWFPazGIDSVbR37Q5RaaYtyra5+mo0S+bFMy08xPnZNifYRVlsEhBKFEiR
 qQ1HNooi1oyTUORbBkb4Q55XxNkpH2oGUfQcqpUVUuzwlmVjPtQV15evYDDZFFbO/MMhytfGewe
 MXLz7XokSiFRIaIGiGPJHbniRl6iN2FXVJmj+41JYmZ72FedtNiYeUp+QKCRvUeT8=
X-Received: by 2002:a05:600c:1d08:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ba023044bemr42280585e9.2.1794314384400; 
 Tue, 10 Nov 2026 04:39:44 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:44 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 0/6] Various virtio-snd fixes again
Date: Tue, 10 Nov 2026 14:39:29 +0200
Message-Id: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32NwQ6CMBBEf4Xs2TUtIogn/8NwqGWBNaY1W2w0p
 P9uwbvHl5k3s0AgYQpwLhYQihzYuwzlrgA7GTcScp8ZSlXWWmuFkWVmj8H1OPCbAg5No4zStm1
 rBVl7Cm1Btq7dj8Prdic7rztrY+Iwe/lsn1GvvT/zUaPCY1X19dCSNYfT5cHOiN97GaFLKX0B5
 gBZucMAAAA=
X-Change-ID: 20261110-virtio-snd-fixes-f770a01c9960
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=+xaXdPqLi/mkv/X298QmjG0is2Y6LQoavXGZwsMwjdE=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCNTobHR5Z3eAjzBCBMcTDq+z7jUZ3osY5gl
 DldzfoB01WJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdArSxAAnVdun4h4S/ob+etaVNfXTGu09s0N1Vr
 xS1j98S7T0r0OoVaQoBmcY4JGsSkJW75c8fymvb/AWPBk8QIVnPLkH3XUuvZKnzCsY9n4SFEdJy
 XIfNKXWTF8Z19vN82+xTAytVr8ZaFcdyg6DX9WzCDqXEXgf+JXcO2jMS3PwbsTZEsbR4o/9C/u/
 KaVzHFFJ4jUtGLcq3CGvcyCsLR0D9OAzOfVpV/2w/uriye3K7lIxUaijobqoAdp35Ps+DpFjDdz
 3g860PZz+EqEluZEBjOb7FhP/py5a6L55CYy/HfzDup4NoZAY8s2aFzpNIYneuEWz9AR/2NQvEt
 YIFHfzECEEsUvT9tf2MlFP4KlEKxfheSKPulp9SVxRh41i+Sn7Bjke9O2u69iP5o+I2ulvx6GCN
 uXddoT6zbOpI2MGmdadIz+RylB5AY2nwMGBnbnKMAzVyVuaFyyVcCDp3/On36qYoFqGNxm7KwmH
 8HKYrL+72rQtExS88P+nvPNsc4NAHzDRMLa/IZ1h6XqbFEk+iGesm4lH0uh2wZFhVKW5l+v4dtj
 5PmaE+SIhgwZT2wGc4DBBzh7oxE7NZxu0oJOqd0lVTBlqaj2wn6aljnOJpkqfF3e1mmCXR82Z6a
 +9NTccMAnWiQgM+hdecybJc3akfMfAXvkYCyxfvQevDo3n3bGkjU=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some various virtio sound fixes.

---
Changes in v2:
- Moved fixup hunk to the patch it was meant to fixup
- Link to v1: https://lore.kernel.org/qemu-devel/20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org

To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

---
Manos Pitsidianakis (6):
      virtio-snd: convert virtio_error to error_report
      virtio-snd: add pcm_state_to_str()
      virtio-snd: reject invalid feats in set_pcm_params
      virtio-snd: don't allocate pcm_info zero-count buf
      virtio-snd: cap maximum buffer_bytes to half a GiB
      virtio-snd: period_bytes divides buffer_bytes

 hw/audio/virtio-snd.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 11 deletions(-)
---
base-commit: 723622bedb0b423de7d1c61ebbe6e7a71934949c
change-id: 20261110-virtio-snd-fixes-f770a01c9960

Best regards,
--  
Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


