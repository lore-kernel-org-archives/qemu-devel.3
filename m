Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQN-00076D-Pm; Fri, 12 Apr 2024 03:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-00074k-Et
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQF-0007D3-DV
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3cf5b171eso5656715ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907246; x=1713512046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt7XTd0PVkVIabRbeCb1YqLB6pmup83tW4MV6eKsa+A=;
 b=VHio1MKAPNeHvgol8km1xhIArWWaWECtb38vXpWymSJsrkFWe/vPWgbed1WmHv+7pl
 X5g92+qaFIhzCabPh9CC74SvhK1Pegae2GuZA65vAi4E7Qy4lMGxpk0NaeOeZ6dAvNz6
 ewU0l2eudYVDUrOGHItGX0pLgVxZ9Gr1X/X+l4xs/UtKruO4R4vWgoaVIRu3lf5PAwox
 NlDV5hlTAMud5P3cHaX7TwFoAoj3YtSS/I3wiXpnv67Eac/5RXKblb3go3cRxeumeM8E
 U7IFXgXRrR3PqWTdlQLm1VDIpFzskm9wQDe5K3OlKAUijDcZEQ9JN8MRxA6i+E9WHfCR
 VwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907246; x=1713512046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt7XTd0PVkVIabRbeCb1YqLB6pmup83tW4MV6eKsa+A=;
 b=Fw3ZORSuFV0D3WtvxTFH1dNlpGip+CHLsrxU1OwLURivoHJCAnU2/2JgXcg/jzTeyy
 5ies9edKA9cIh+9TSJ7RiX7Am5OTvQtWM7/gA/mxOQSFDi/46i7kmgv5M7ES7q/ICaDt
 aNksF66jsnGEimeQr810BaH5zdx2bf9jlvX+O9ctACUFRWqSMahkSxpkQq/Q4nJhIWpw
 ylzulcsGJlDfNpR9DkvRlsFCAG1GSsN35j/YpGdY52ldzLgs642kWDfjJw2w15fhD6KU
 DaqFPhSwWgH/k0YR/fVHMvJRyl7Uw1AAyjSLRnDTrB4mRmUGXHVIaUGrueo0re9o9piC
 ydYw==
X-Gm-Message-State: AOJu0YxVbCoQcoOhsMIA9ekUF2gitc4AecQsUNMzNBcF8104TJk1IkGo
 Likpc6sVvb5w0kfNf5Hu9ayAWlQn/+LMBqEICNYlflWZDMDF8mQrGLKL9uRBqw9n6sb3RB8f24m
 W
X-Google-Smtp-Source: AGHT+IFZL5JxsmgYd738dc7lGyEGmsx/XulierN2ofYZTndjeKdOPMYIh5tXEAGGufE49LMYwS+Y0w==
X-Received: by 2002:a17:902:ebc4:b0:1e2:96d3:1bc1 with SMTP id
 p4-20020a170902ebc400b001e296d31bc1mr2001016plg.1.1712907245985; 
 Fri, 12 Apr 2024 00:34:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 23/27] hw/misc/imx: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:42 -0700
Message-Id: <20240412073346.458116-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


