Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3549AE8B37E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOI-0005wq-Ia; Tue, 03 Feb 2026 18:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOG-0005wi-TE
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOF-00069Q-59
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so53772665e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159657; x=1770764457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SAI5CZ2z293FmxWzKC2635Ol8TJX7t4lgR8flSAttno=;
 b=Z0P8QdI1/9WCbunvpTlPFRyo6rDvE/Fh5GsqmF2mwxxeRhcqmF15BTtguDcz9R4fsg
 AkgmAYf/UafaOmebOzIvMRfMJ8T1Hj9FICxJSohkaDfMmOa07lHfaZPm6SEvNuKjZeNQ
 qrFynHiY1/AGfIELaOGek3rB3AUVkkKLl6I41DZh9dizuTrQUu4lleX7hf00/PYws5Bp
 Vgj+k9d+vYeNlI3gbeUVw2Ld78pwO45w1L2WA6P9r0IigTsU/dkskVZZqsi9P2U/KGY/
 sB5Th9G8I5j5SYeDGMG7psi7p8RZUoVZ/s1JZE44M9jEWeersdUxe6p55UqZFTGgv97s
 zUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159657; x=1770764457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAI5CZ2z293FmxWzKC2635Ol8TJX7t4lgR8flSAttno=;
 b=D6dC36ybovXPXBGSvamtKpctAiPOSx0JaNHA6tjY73aktkd84wJYVFOyjP4xMHddqQ
 jRAfGb6urh9SMczoEsLz1xBuRsPdlWOF2xVVszgiNFRfGDhoBF+OXN/RXOBm8lpAV6Gs
 4Qcx4Agqo5lPZA+Q5t6YawMbg6+uGHRTgPjNbuO0i2gt+YR+Xd/BBFx44OYX84l1AHzD
 MKH2C9oAF1UlVS/gZvyyF9FinjNaeHrJPveQNzHCxsQ8J8+EBkzUDaj5LwKFTIarLEE6
 iX5Nmk5zD+k6mlDjWkN/d86GHzeyHZ1IAF2KOWM9jP1vSlxHkOaPjptJAdf98IVqOhT2
 vZHA==
X-Gm-Message-State: AOJu0YzosmyXVUKmpojyHsszRi/3kmIy6c6zUzBFFxt/ddlW16ybHU6m
 jGaMXhNz0v1+ActNY96oZPpFRAtvg10onF9lcQD/pTOOwK10hH31QMla8hWrU5EPHpalmN00tnf
 xXbhHCoo=
X-Gm-Gg: AZuq6aIJZWmhV9co4ggrmQkzosiS1p6ly0g0n1aNij45pvPiSPkW0BwSq/Hfa5vCmgb
 aY3dXP7w2aUQMYA1TG42gfMn/QE51yj65CNykcft9dpq980cTdL1Xe8tf5JAmaR3Ev60zTWHbqE
 YV1+KdLdyqanyBEjLv/RBD5d2GVipR+K7enXXoO/OxORCSJDlb9b4tDd19YE1Am39L/T7CGf1Fo
 7T15OtOsGkP/mRc4MG3MSV5ae2GoNEBvmn1fK53Sk6I7gQo811dyf/BW+9pmpXPN11a6UnJyss5
 Bfo5djL1TqlauGfmFW2qsZDJOFuAiaZALSqtF6uQfC+fSi3ounFRFqMh9cnUCxZGzadl7rysd6u
 pzQTU3/Uak7P6i1aYRBc0I9lEEW4v360cHj31jqRGjgB8EByn8SLtSmj97/oI1EDMyrdTB1YCKD
 Ks9XmYLMcMxiMFi7V2HlYzUrJ4A5ybmNEXhM09cENnPCANPeo1OX/uQVLbpOV0
X-Received: by 2002:a05:600c:548a:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-4830e99dda5mr15416685e9.37.1770159656776; 
 Tue, 03 Feb 2026 15:00:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fe69e9fsm4312825e9.6.2026.02.03.15.00.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:00:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/5] target/sparc: Use explicit big-endian LD/ST API
Date: Wed,  4 Feb 2026 00:00:49 +0100
Message-ID: <20260203230054.23667-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v4:
- Centralize sign-extension (clearly out of my comfort zone)
- Remove bswap in LD_code()

SPARC is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

Philippe Mathieu-Daudé (5):
  qemu/int128: Add int128_signextend()
  accel/tcg: Have cpu_ld*_mmu() methods consider the MO_SIGN flag
  target/sparc: Remove dubious swapping in LD_code() helper
  target/sparc: Replace MO_TE -> MO_BE
  configs/targets: Forbid SPARC to use legacy native endianness APIs

 configs/targets/sparc-linux-user.mak       |  1 +
 configs/targets/sparc-softmmu.mak          |  1 +
 configs/targets/sparc32plus-linux-user.mak |  1 +
 configs/targets/sparc64-linux-user.mak     |  1 +
 configs/targets/sparc64-softmmu.mak        |  1 +
 include/qemu/int128.h                      | 10 ++++
 accel/tcg/cputlb.c                         | 37 +++++++++++---
 target/sparc/ldst_helper.c                 | 18 -------
 target/sparc/translate.c                   | 58 +++++++++++-----------
 tests/unit/test-int128.c                   | 22 ++++++++
 10 files changed, 97 insertions(+), 53 deletions(-)

-- 
2.52.0


