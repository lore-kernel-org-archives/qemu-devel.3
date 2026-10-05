Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CBECA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfp6-0004vr-LP; Mon, 05 Oct 2026 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmX-0002I3-5Y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:57 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmU-00010R-Lv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:52 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso9313985e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195529; x=1791800329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q18CxezF3O0NQZL4J8j8k8FGd9ovRcOXZH6XavOaHP0=;
 b=MjPdB06Lp/8jznCmMH9OzPzRpEO44CaJwVB1SPsrZMnrKNxMEQ5SBTDlEpbF8Bk4vD
 CAqXkPdVkyZ5Xjg/A1KkgieDvMFRUG6ZvVMWGISBVWX07siPU56Z2kkwnKnYhBRdEVw9
 I0s74gmplIUK0muARvfg4nkYoHr/bKFOW2x1IjZNha5iW04DEd4p6J9ZIvLpHH9EU9Az
 lmY5CY3mNFgIVN6Xt/BkcMswiLQRMMWKS2cRCQwYiV22iHpTJ7hM2+ESBJ9hiVlBMvkv
 74uavNdOkcXiVriGi3mJ59PVbum3AMMakSUfTQ5wDgEc1lN3hQieanMngt/JZ0UrjvS5
 c7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195529; x=1791800329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q18CxezF3O0NQZL4J8j8k8FGd9ovRcOXZH6XavOaHP0=;
 b=pV4WkOlvX1X83PHHksxIaELNNeaoz9Y3XQNa5OooGxecJ2VIzu3pV86cQ5C/WjIaYX
 z0aqZJw/1yI6jRxHMm7I5E51siutCWYHeJMTwC99vjg27Z2FK/y29dUiO4wkC0QO7hQm
 y0Laa3FTsrAKxxITLG8l+bpHVjBuJfhXkalK7P2YK4lpDdkrz7DFkEUCjwOF9gsHjwp1
 2UyT5UPweNe8PqJIbd0+Yix/Y0ZsWGA4feZk8YhDPW8B1nDJwJ3lUWSE9doUEHhU9+6O
 V1QH+MZ1FvaN7hHE4QkXjvjlBJUusbY2KdcDml9ER7AwXsZHIfPxEIiRtxFkzehtW3ei
 5ajQ==
X-Gm-Message-State: AFuF++mRSh5ytYg8ff8Dx4cNnF3uUa3ldcafXIXleiiC7lQTEq8EuoKC
 AUpyX3FgEvB0pKJS3ah+BOb/7Bl2ZHPZzbHUH1rSABvJEll65en0OhjtmD5aNQ==
X-Gm-Gg: AYBFou2o/GNDj4pIGmwZ9OdLZmn2teX6NTX4ht1+WcSHKuF7wsVDgISBvW44CbnsXtH
 BL+JhHtZOlCAbCaW88yaztUUyYMNRUbEwmYxYCGu4Uc8xniyF3MUT7v3qUb4QMqddvDRRdCI7hK
 VIb2Po4syKdY4jnTHSei/cImvyppGTN3vwlO5NYRiHBk3svDFvnfLguctA002bGDYqihUR8ENO0
 itsJ+pKf8ALcw82Ewh46z7EGOPJS0BKhIm6MmWjXBSca0LL/pEu58cNTtN/BvJQn8cPYp03/vTX
 Y6rtiWi7GWNNTdBEja0YY/V3b1vaykrm2AVgRu2KPwzWKLyd/W+toAxFRMvEEJ/j5OCZv4MCIbm
 0CEUosSTP9Oz+4lX57e4o99iSLV7ya057kDWcQbFuJfoHSIcSlKpazwxiBcBUp6xaxHR3CVdTzS
 GWlNKNZPfauRAAU55UIy5Xm5ysMKIOySjQh+DUfH+J75od+pjHp6k7EFbRqi85e4mR5MrkPbLVE
 3LKALgAKZTLJSLLbwZH2wq9JxkOGGcla6YHkw==
X-Received: by 2002:a05:600c:1f93:b0:4a0:1c10:1419 with SMTP id
 5b1f17b1804b1-4a1728f7420mr33131605e9.26.1791195529142; 
 Mon, 05 Oct 2026 03:18:49 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 20/31] Kconfig: Extract config IMX_RNG from config IMX
Date: Mon,  5 Oct 2026 12:17:47 +0200
Message-ID: <20261005101800.10821-21-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_RNG to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a33f5a46f9..2084813e1c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -483,6 +483,7 @@ config FSL_IMX25
     select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
+    select IMX_RNG
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d1711433ef..3f17d29053 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -94,6 +94,9 @@ config IMX
     select PTIMER
     select SSI
 
+config IMX_RNG
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9790afa104..61e128ab7a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
@@ -73,7 +74,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
-  'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
-- 
2.56.0


