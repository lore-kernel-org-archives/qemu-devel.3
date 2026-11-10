Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yhOs9/6C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj8i-0007rl-9V; Tue, 10 Nov 2026 05:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8f-0007qs-JP
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:41 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8e-0001AM-0A
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:41 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2836635a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306698; x=1794911498; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=51886DPBP0hicUI87+SLmAQoiTQC7jR47naFAxew3c0=;
 b=yhOs9/6CpTBVvZ03BwzaeRnn/iYyDKRwoLzMZMeH3TRoq85NT4NUHg42KCRdhd6eft
 KyNGpvq4hqPWwfO+28CkwT1ErYk+cEsXBN8cQX17d+rYm3TmHNCt2L7oVi4KchP0OWsy
 vbK53INEOSiklP/Rr05vV/OJYmph/H66szYt6xFhmoEsnxLXWQhQtx2JFyswGbOj612Z
 HINyri6SqGc37LvhIbbUxZ6jTy5U9envEkBxwaoeNCHvaBD83v6hnuvqXBuq0MJ76Tr4
 aPttsNxunW0Y/Wv4uGX1P5+aaz0BUOrN4IducS9Pm1KWcnuTq903ttKjSag3m7PiIzkz
 uDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306698; x=1794911498;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=51886DPBP0hicUI87+SLmAQoiTQC7jR47naFAxew3c0=;
 b=QqizsPaesAfs89mPbtWQjpQQnZuXUWWh+WvOorY8b63jSH2VokhJS9dW0oJrC837zv
 tZ211PD6IvjGXzwqUJo1aEv4HhUPfksoe27U+jSXH4ogQVFq+YFDT5HoCYMw5XU30aMU
 TJfpA+O5vbOVmnYMAi+jFBdDLxDxmHZ1zKcYJbZFmI16zYZPTEvIvoD2FMVuBgBtZRyl
 seccCN6J489Tx2NDdDDqIS9vliybGss5mnG8O8tMZ+oB/djS2gg7Fi4+Ycmz13FJDppc
 mtb0N0M1e+e8xctompe4rY+KRRkqnnqVLAoc2fHRa6H8McTaQ3phlWi/cZxxVK9jQb2Y
 8UwA==
X-Gm-Message-State: APuU4Z/0UsAyUOTnm8Z6ggHm9PgRR0dG44QSb13qYJGcfx6ECYnHokCK
 RCiLFqmDUApsemr2gAn9VtKJkVdkUrRjfhXXdUc0pW/boRM1l+44HsOfu972hV9nMGRWH7bQu4g
 aFDYL
X-Gm-Gg: AYBFou2DKLTCICFKRySrE8OvmUaikSzpocCU6PjM/a863PQSQUwu0mmaby5Yra2N+M4
 xnkP/UiOJWKBBL+JRw1mHqHoYARKrxcpfVsWwfmpI1U6aeJxqJ2i0z/WdxZ5Uses2ox2VfYspYX
 earFIKMTF9/cU6NvdcJwgYAFmi8lnN4ExVLTI6Z0W8Nk2NpKcsTg/Za5UzemQfDJ52svuMlFQzR
 Z4lRkgxFoQLtwlk5DhuxfAsCPIPz2uS1/qMC/P2GDtgnpBtVXfyrF3Fy4L+jf8FvS8LC/JqyOCL
 I9Ye7WwW5xJZPxcJ4glu0JpvukCSDfgkeTtAj7uv6a1hxqLH6U/fZ6EQaZkpAb9nD1KAUGd/Hjt
 F/wZWU/MDwoN6Cn/z8wjluc0JGn4DcnQSliEsZ/clBG5kB/MQRppC6E5uy3QW6icNnJFXEfg2OU
 Pm8QeY90aU35eUIllVBBEmrvxSm6SN2vPXh+NDsX1LQq1kKL10uVj228ZPWQEldAirRJjon9d5S
 qEm+Eie9YkPmAxcwdBJiaERiZGbuyuM9QacHGcm6BWb1K2xoZNXjm/5aKwdvAUDpg+opviZD5Zy
 1o/ZoRpLX7lMHuvjJhHHV+ZQpPv30G/iwPI5bkuHuCf/KQMDhxD9YvK0saHi/PM5N6+wSOgTiol
 7WKI8UOTrn4val9m0Mlp6Oox1+W7KOY15d4BuXRqqmeY6Gc9VNonwdmHNHPsKSylZOkIEB3mk4q
 xq4XHh5caTmyyebq9WhtOCejUG24tW3fT9xrBUgWqJbY/1zCgOSdPRxXBgOPzkuB8=
X-Received: by 2002:a17:906:d938:b0:c46:a72:e0c3 with SMTP id
 a640c23a62f3a-c504952c009mr126006066b.16.1794306697915; 
 Tue, 10 Nov 2026 02:31:37 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:37 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/6] Various virtio-snd fixes again
Date: Tue, 10 Nov 2026 12:31:29 +0200
Message-Id: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ5AQAyF4atI15q0FoSriAWjqMWQKSIRdzdYf
 nn53wUmQcWgSi4Icqjp4iM4TcBNrR8FtY+GjLKcmQkPDZsuaL7HQU8xHIqCWmJXljlBzNYg3xC
 ruvltezeL294fuO8HWEGjCHQAAAA=
X-Change-ID: 20261110-virtio-snd-fixes-f770a01c9960
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=CPf94/Gdvd/r7z5kQH3/yv0QxbyGYjTUNgEM4/mxumo=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKHadCzUfUiKZL1/c3xfjI0uB1cEsM0Ppe4v
 hizk2/7u12JAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyhxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdCUUw/9F37K7wJcH++E4o/Azf0+FmKcMwamB5F
 MDGqFPdjTDINVsVIiWCHlqUVYLbYfxCSFOQSEhGDMxZsgsaSoZ51Ikbp5vzhNRx1Pz34LIojkCD
 E0r0lsxbukNlhesborfPrGOOp8KPxqQizWamkI9YnCIDl8dZ5ZIRdOToLnTALywr5+duEYI22Wq
 3B9V5C36WpL7S2NiZHQaGpbEpnKD5vgU8ystVzG1izoyof585vYUZhhndpGuSsEOEledtjOK4PC
 OSX13gtuy5lSG/jxgs1yqfdfmFQvLaadkRbFWapj9vVM43QOkIQAYgqF5tqspb0qNP4kVPQYd4Y
 T1M+yOIa9WvY8AB2yncneIZJ54G86w1gMQEQWwUy8TQjtvkXuiP52OfsmVj72I3s5b6l+TvTzK2
 L3fp3AzP1YEcotFuSpDm0yfJN9uCwYjKOAkJNJ07xxq9HAeNKz3kkk0I3B5uWA4f0maIORipi3T
 FFR5/HwHngrBSyH18Xfi3sqioc06ZNDsT+V9yqQVnKGPXs+5Th3Ojkeu8kwmjtuwqOol7FxK2uC
 6HVCn2UJoQNLIAaS5Ty5pCYku4M9VWj6QJhbiu16uKjJ/LkBBg00KI8udxjngypERkbuwlqQN9b
 ZjLwJq87Yp3wKi7DWu33rXgfdo6frUbwAKdGeccn4/7dlc/j/azY=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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


