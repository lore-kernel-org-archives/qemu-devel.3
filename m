Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327C3C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgIMY-0002bZ-Dy; Sat, 02 Mar 2024 00:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgIMX-0002ax-FJ
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:56:45 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgIMW-0000kF-0F
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:56:45 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so304446b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709359002; x=1709963802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2XfMnQP2A5uod6sG4fZIHBgAmcjlbrOKxKv4ikXrnI=;
 b=dLg67cpJZRK99nu7iL+WezQ5/rjVJWTvuqsmryYn5h3N8BPQsAwzlAc9AFilYEleOI
 9wZdLSJls2horMxNhfTRQkD7LnxhswIyi6WjDy9/aV4u46ulvYLyIdmcW1Z2ZMbq21Kj
 WRa8GPwETJyxHWZpiPHLpo+Oyi/eUrqV9U+jE6GC5OrAhLOZUDkdrmWKygK0Lu/b8nbo
 d3HDKq+21buvMoQI+uuzKCyLNcTrJk1p0z2Z/HVHb3JJsvaO3TI+31YvpncHtQWOps4U
 Cy1aA2HX21KZh83FgqnS2wllrYx2kFugMnvAtd0Ik7K2kcmOakIHtqGx77Hrs/ET6NrZ
 HaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709359002; x=1709963802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2XfMnQP2A5uod6sG4fZIHBgAmcjlbrOKxKv4ikXrnI=;
 b=cVHp+Cz7EnPMB+xBWQcPkszcSH1YkeViT2/uYkBQPTIeaVaVrm4U4vGR+Uwom0S+l0
 iVgnDRW67dCFcaD6Qo4R/uhSPcgSiwvRxCr8Ste6+0hIFcZKMJVLxazS+fT2OfjBJcMi
 KE19znJTDgAGa+s+4siHlgneUPGpcB1WSsuCEe+wxwF0Ar03+fZNrABJPIifeA7+KKvh
 5JA5x90o+TzxqEUJKB6s96NFNGtfbKP2LrScyqVr0a0MsEdz1aQxdEQDXAsAOSMG9MoA
 HlFaZbDOloJNg06jqPtzBxZ83G9igh2vsUr0zRxf/jPkRNC3Cy/NetPkykaBK1p6SBWo
 SW2Q==
X-Gm-Message-State: AOJu0Yy40tvaEvWdOcKDNOqvgSKACX5rR9+b8xL2JdYfskmxug/zwmRL
 QRxh5GXJlOzQ4GupUmBLCAOXkfutmBN9SFxXUqYNblpD3TUnimaiVEuuKhCoILIUPVPNyxDjdQ0
 q
X-Google-Smtp-Source: AGHT+IG2jZrp/CfFoYAoQGmNlIOSxHHdl4ELeTHQdD5FMU175yoOX4d0UdZNwmyFb0jqHS9iosuq1w==
X-Received: by 2002:a05:6a20:d906:b0:1a1:18e6:c8ec with SMTP id
 jd6-20020a056a20d90600b001a118e6c8ecmr10995232pzb.0.1709359002059; 
 Fri, 01 Mar 2024 21:56:42 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a62e10d000000b006e560192a7dsm3830448pfh.105.2024.03.01.21.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:56:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 41/41] target/sparc: Enable VIS4 feature bit
Date: Fri,  1 Mar 2024 19:16:01 -1000
Message-Id: <20240302051601.53649-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 18dfd90845..1ffac3dd8a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -554,6 +554,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
     [CPU_FEATURE_BIT_VIS3] = "vis3",
     [CPU_FEATURE_BIT_IMA] = "ima",
+    [CPU_FEATURE_BIT_VIS4] = "vis4",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -882,6 +883,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS3, false),
     DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_IMA, false),
+    DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS4, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1


