Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08717CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurul-0002xr-5a; Thu, 11 Apr 2024 06:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruj-0002x8-2t
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurug-0004KI-Px
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-417da6ca440so3572735e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832252; x=1713437052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeYnoI7aOgEwL66760hzse5mJ3cb0VBg+S1wKs8bFQ0=;
 b=G5bDdycK8Ly0Pi6hc566NKP7L8l/jED7DIFXFYByOqqqLEwgrjdSHO9AHgGU+hNZ9m
 xxmdD1IFlkQ5QONWaVPFvCZGvUmflW7gganTiPa0i4o5hb1/MMIbEacA6jAkgbDWF2wi
 rTwcY5U9RmMLwRerS3J1x2LkEFSndt4OJGfWkfIxaDU1BniN9q6mgykaFMzopGeIFmrD
 rVa5mu7sguckJ/Q2EdG24xv2Zva4OFBGRY6qVE7GNEBY6XN8U87KQkn8bXj3zSmElcEx
 KuCUplLGv65ttCDk+sVpt/pJn58g5dyY1Vi14Vz0XsYQI3Nv0UqHXfmyU5MHNQ6OvAHu
 1ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832252; x=1713437052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeYnoI7aOgEwL66760hzse5mJ3cb0VBg+S1wKs8bFQ0=;
 b=TV1y6RfPIrzKuNIz7gKdQ8sFo16wII6dzYvWPAQaa49F5pC44PpUTp1LJuWeRJotiC
 UhgrrRlvlr2MoXx22WWuZXJ2XZNfyXlQw6JPnhKHcdQX/ctHO9XgPymwgLGOYcB85inu
 G3nEzGQBN13qyONRXqbfyvG4e9JfCS0RnDcJQdq9yiYyMghpqte2H/vnv5K3SITluhq2
 Ti6PkQPV8lUU1o1R6CQ5a90ryqwv/egFXfOGT8n+XcfXqY3a/3hVU7ss6jqPYrTMIQvt
 sMac+nz4RcqZdVQWQQZ/vLylbfk+FsTGqIMlF/IsLhtjA1GGjwG8S/SBf/q7cBMhT/Mh
 kZtw==
X-Gm-Message-State: AOJu0YwuGKZ8TSbRsZaMVpz9KM7rSv+MWWfu4cNVe1p6xNkZqkueOREu
 ziroZSFoQiYSfVsZOj69DbzMt1UfaZmxDkk70Q2RQuY6ATgjJ5Ca1VLGLbT0rWXeqPTUhd1j58O
 ap1s=
X-Google-Smtp-Source: AGHT+IHZwP4w7kgYlcRHvHPtn5xaFB3CMNvvDS+8wnLG/q7rQtgc/WRYzMesP2ko7FKOiMmKT9TvnQ==
X-Received: by 2002:adf:ce86:0:b0:346:bc1b:4e7c with SMTP id
 r6-20020adfce86000000b00346bc1b4e7cmr1325606wrn.35.1712832252684; 
 Thu, 11 Apr 2024 03:44:12 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adfc04a000000b003467a420243sm1485130wrf.12.2024.04.11.03.44.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:44:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 5/9] hw/misc/imx: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:43:36 +0200
Message-ID: <20240411104340.6617-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411104340.6617-1-philmd@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/imx25_ccm.c  | 2 +-
 hw/misc/imx31_ccm.c  | 2 +-
 hw/misc/imx6_ccm.c   | 4 ++--
 hw/misc/imx6_src.c   | 2 +-
 hw/misc/imx6ul_ccm.c | 4 ++--
 hw/misc/imx7_src.c   | 2 +-
 hw/net/imx_fec.c     | 2 +-
 hw/ssi/imx_spi.c     | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index d888966014..faa726a86a 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -91,7 +91,7 @@ static const char *imx25_ccm_reg_name(uint32_t reg)
     case IMX25_CCM_LPIMR1_REG:
         return "lpimr1";
     default:
-        sprintf(unknown, "[%u ?]", reg);
+        snprintf(unknown, sizeof(unknown), "[%u ?]", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index a9059bb1f7..125d4fceeb 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -89,7 +89,7 @@ static const char *imx31_ccm_reg_name(uint32_t reg)
     case IMX31_CCM_PDR2_REG:
         return "PDR2";
     default:
-        sprintf(unknown, "[%u ?]", reg);
+        snprintf(unknown, sizeof(unknown), "[%u ?]", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 56489d8b57..b1def7f05b 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -85,7 +85,7 @@ static const char *imx6_ccm_reg_name(uint32_t reg)
     case CCM_CMEOR:
         return "CMEOR";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
@@ -224,7 +224,7 @@ static const char *imx6_analog_reg_name(uint32_t reg)
     case USB_ANALOG_DIGPROG:
         return "USB_ANALOG_DIGPROG";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 0c6003559f..3766bdf561 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -68,7 +68,7 @@ static const char *imx6_src_reg_name(uint32_t reg)
     case SRC_GPR10:
         return "SRC_GPR10";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index bbc0be9921..0ac49ea34b 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -143,7 +143,7 @@ static const char *imx6ul_ccm_reg_name(uint32_t reg)
     case CCM_CMEOR:
         return "CMEOR";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
@@ -274,7 +274,7 @@ static const char *imx6ul_analog_reg_name(uint32_t reg)
     case USB_ANALOG_DIGPROG:
         return "USB_ANALOG_DIGPROG";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index b3725ff6e7..d19f0450d4 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -75,7 +75,7 @@ static const char *imx7_src_reg_name(uint32_t reg)
     case SRC_GPR10:
         return "SRC_GPR10";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index cee84af7ba..8c91d20d44 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -41,7 +41,7 @@
 static const char *imx_default_reg_name(IMXFECState *s, uint32_t index)
 {
     static char tmp[20];
-    sprintf(tmp, "index %d", index);
+    snprintf(tmp, sizeof(tmp), "index %d", index);
     return tmp;
 }
 
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index d8a7583ff3..12d897d306 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -53,7 +53,7 @@ static const char *imx_spi_reg_name(uint32_t reg)
     case ECSPI_MSGDATA:
         return  "ECSPI_MSGDATA";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
-- 
2.41.0


