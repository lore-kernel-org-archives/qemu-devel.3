Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454DBCA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKL-0006sR-Bd; Sun, 04 Oct 2026 08:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKF-0006ks-DI
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:19 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKD-0007EA-8g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:19 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso8812575e9.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116893; x=1791721693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsQtoNXHepcqdbiiECLgoBh98eW9OVKqx8EHDUllHBo=;
 b=RmMKMxvLDmvJnDGLs9Dtod77voKBrT4VMkpAoUpsHVC6pN8meKFPL95HNy86mvq1xQ
 c5r/E8PB24DNaKhKs7Dh7MKJNn5RoClciPeuUFHPBg6ZD6MfceyXOqSvsvY2NClgLraE
 jEqqst6hkt6GiADoiF07jYteGYJIi45t246kfFQhsNrTI3/gwlC/jaZDTSCcsMBRbrkH
 67SbiwU4ZJx4796L4+aja9CfNUFcLv0dYvIZSgCVjzgJbXu215rAYw75yyNIbqsqsKJT
 GCFhnF1SQ6uejvHxaMYkoIceQHLh3OqZ+DZsxmI/V5RFHhmV9r9aN3cmml/fAqoO8jv4
 92LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116893; x=1791721693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsQtoNXHepcqdbiiECLgoBh98eW9OVKqx8EHDUllHBo=;
 b=VJc8UM8dc8nUHWpqyDmsOvp5eyDrT3J0d/qw836JrVkcg0nr7VYU7g0gEIdfedyYkQ
 3XnOi/snY0+dGLWjrEWXgvSwcaVsx8z1ynbfKq28ktdOYuepSWvdwonfRFWp9qtRoghj
 UbI1fEQv0iWzzmZvDFstYSgcy6t3RhBlr+Bye+KUhjlwaUq4G2dDVevmUlZTlepS9bF2
 ghEYqmM5iKv4DBcugN42SS1xdT0KAxaaFDLz1qkedJ7qI2yVWA5XQmal9yqSfs2RvXG1
 T5sH/Ig2Y7dyc+ejQddhROgsfuxKY2DMKTErV9fRvMw0jzJOsWii3ia+gGs+6rqaLQ8l
 8PTw==
X-Gm-Message-State: AFuF++mL82IJjB8wHdjjOMJ+6nMdcFbhvjdwCjNHimTRWrvp7rB6XgcK
 ecR1nXcXMYeRHADyB+rNYdvXG2Z3yWsqX/xwjGZO4ZdqeEIeaQW5FZRuh8qtqA==
X-Gm-Gg: AYBFou0bJqs/2GHWFl72/5LhlAKgpelQ9tZGc3ZLzDyYSe0OZ1iUMT3zd2im14Ogrcj
 Unv8C/eGzTbwZTaUUY5Z1NW0/c5zX5/eqcScMgXbLma6wZ5VguD+j9jYEFvW9Rk5EJUbv0IHzxa
 UTqHlEfcr+fszhJ54WDgGg+1AC9/KW/WRXdOnq7ZuGdu4uPeekNFzTJVVdSWjNtXhONVw6irC3p
 Aky3kSjTtIxxiwOOCDt6hR3YJzqQbCUKQ89BRrSp+nVJOIglci/ab4tNm+lJhkhGMW99M//iiKu
 kIXnEiDMO4wcfJc+qyc4gS8XJ5/5PpX1u4uWyxpSQHc2yQFPfEMizxYRT4/JrPUhNJ8isVMscZx
 rYaqFbKw6KHkFO/4Dyi3hKBuxrJzejl0qdEiQXoqPJ8/go2BPEc47KEzybRbH/vvQNGxlYhjUvY
 vlAMcxvU6jE7hU4bohBB0TVX+MCxpxmYjaVayKGbCl/nB7UKlNzDnbkl8ZgzSiquaqnAY6Rsbo6
 8KuK2vNLEFrBHosqTyFmKYWfCuBl/2BCcUJXg==
X-Received: by 2002:a05:600c:468d:b0:4a1:7108:c2aa with SMTP id
 5b1f17b1804b1-4a17108c49cmr15863595e9.3.1791116893466; 
 Sun, 04 Oct 2026 05:28:13 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 25/30] Kconfig: Extract config IMX_EPIT from config IMX
Date: Sun,  4 Oct 2026 14:26:41 +0200
Message-ID: <20261004122647.3913-26-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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
config IMX_EPIT to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig       | 4 ++++
 hw/misc/Kconfig      | 2 --
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index cb6e7056a5..1d3026dea9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config FSL_IMX25
     select FSL_IMX25_CCM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -499,6 +500,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
@@ -513,6 +515,7 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select IMX
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -682,6 +685,7 @@ config FSL_IMX6UL
     select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index a2095d64ae..dbdef58505 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,8 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    depends on IMX_CCM
-    select PTIMER
     select SSI
 
 config IMX_CCM
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 49a4d20e55..e098376d40 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -23,6 +23,11 @@ config I8254
     bool
     depends on ISA_BUS
 
+config IMX_EPIT
+    bool
+    depends on IMX_CCM
+    select PTIMER
+
 config IMX_GPT
     bool
     depends on IMX_CCM
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 477dd47486..e2bcdbdf65 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -15,7 +15,7 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
+system_ss.add(when: 'CONFIG_IMX_EPIT', if_true: files('imx_epit.c'))
 system_ss.add(when: 'CONFIG_IMX_GPT', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
-- 
2.56.0


