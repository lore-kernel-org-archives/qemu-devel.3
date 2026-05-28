Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45529CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHa-0000Ip-9x; Thu, 28 May 2026 16:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHX-00007i-W1
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHW-0004vx-3T
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so139474935e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999880; x=1780604680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kdGc75OGksfHQt8Kqv+NMZwzXpujXfVkqyUlVI9MEp8=;
 b=hY0nNaPdbRTQH2K7MHIo7vO1fUu9dX3JU7UmWQDxfJV0iBFHFZOjc9t39b0MnKBkVp
 9JcV1YImybgUsCkoE5ViYCQtgXNzKTGcJX447AIYhFZ4NcPdvOx0Ld30L7nqADNDkKIn
 pIxAF2hwcmLX+Xw2r8o5bbQG3ws72dTWk9uHERmJPGf1lRkNBV/cag+EoOu5RY759FMW
 W58ICgFkbn5Wi5buIsU5R4HJUQ8HZH+cR6z5cY4pdvjUP6QBIWdJnyjudP8W0Dvi4m7r
 /1mkAgaguBRCo3unur4wdM3Nmh1k1pG9sSWVS/EY2f5lFvev7TLWd0YQTxOua3cpaUBW
 +CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999880; x=1780604680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kdGc75OGksfHQt8Kqv+NMZwzXpujXfVkqyUlVI9MEp8=;
 b=Syj70ash0PrB/WuST3wriQcQdiCR67NlAbIN46ndPbEm+DSUDrUoJrHiyeq1V4YirN
 QrPwcCPGScP4JSxqyV5PmwRjGKpnhEs9Q3eHduUJhndDhzniZXE8eeYsOSnlNzIMoEWR
 gbAKy9729aE8RBsHqBWUQC7X342+yzQepaCNEiB8xYM8QRnoASHxJj2oaKfg/u/KuE0V
 W1yw/lqy2ERME5xeH8HoawieYuRVCrvKHANGqXSDh7MzidDQU4YRx97aIWWGxoYzBoBZ
 0plGQNj6KhVbKJRimKbqHFUGRVWNMyTcxfxkNjilvPVBIizbq7ezBjNBe6gKzWYy96o5
 cngA==
X-Gm-Message-State: AOJu0YyJ5sBvGcMMjRgPLrvoKoOGZFm0QWZpyFN4OGkln8sxjQkdSjhn
 nEnXskxZxgjgzv92/SMWGi+U/SuTlUhoJvaHE5CVLk/pfOtPwpX0bqJNkJwBDgFR3E8z8RSOX4O
 X4jFqDZFOnA==
X-Gm-Gg: Acq92OFQfc6Eh9ZvFYT/dKYfVwhuC4z5pSXDkVjyaUjADMmcLAG5ZMyA/DaezwGpnwy
 ATvd/pCXcYKou7CIGVnNPRG+9EFeD5T3RaCH40sL4wjPmo2TbII9gnVoQiNviAKK58rnh5XHCUv
 yYiBlEvo0cxhEE6Ljm6QB+sNq09BmxDDWqsURZHiP/hpqJD0ZCp3+Z/oNJOn20FA/H7IxxviO8o
 0C4aZL2c7iNjL6QjkiFuu1PDF4czVKBIVlBio72wiK28wC2Z81NcR6OzNVGb0Xn4Mj8Z/hYP3G2
 pUI8z57Gr1UqQ+95k5QxZYNWRon+XuZ1arT6VA7DM42JRyZOrDIe4jZaSXlc0eZdtkZjzRWmWJw
 L8AIC3qO30uWA2OFkSuq2dhO6DaN3cBv45LETZutoDO3NC+2BY7L7DvgwvZfQbRovzGceZSpUrP
 n51bQrQkalK2zwXjNm64xe0IxewgDxsAhAW8tPC0CsGxrZxpn/LTYOfvLqK71stQuKU7aS8rS+E
 A9i
X-Received: by 2002:a05:600c:4fd1:b0:490:5527:3be2 with SMTP id
 5b1f17b1804b1-4909c0f1062mr71675e9.32.1779999880553; 
 Thu, 28 May 2026 13:24:40 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a817d3sm69631015e9.10.2026.05.28.13.24.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/22] hw/net: use stub_ss for vhost_net-stub.c
Date: Thu, 28 May 2026 22:22:44 +0200
Message-ID: <20260528202253.49122-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Removes conflict with several targets where some support vhost, and some
don't.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528051642.115721-7-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/meson.build b/hw/net/meson.build
index 31025874699..84f142df222 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -48,10 +48,9 @@ system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
 
 if have_vhost_net
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
-else
-  system_ss.add(files('vhost_net-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'))
 endif
+stub_ss.add(files('vhost_net-stub.c'))
 
 system_ss.add(when: 'CONFIG_ETSEC', if_true: files(
   'fsl_etsec/etsec.c',
-- 
2.53.0


