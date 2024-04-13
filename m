Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFD2C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVrf-0001u5-H9; Sat, 13 Apr 2024 01:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrd-0001ta-8i
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrb-0001da-HA
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso13204925ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985822; x=1713590622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i3GYPODdGEunG05Dn7518COsozxbeHPzw45fI5pR1c=;
 b=VNApF3/hWFHop3H4G2rHERoXM7b22zAN6+1OnAOZSUQ0vRmBA/EKJ0FYfQmd39EmXK
 WPlU4MeOg1m16VCrA/TiWrfjLVzdcwj01kPA8rkSI9CaVId1ISjHHXh9JRIxz7pUCEA7
 +tGhoIjSEwRZitRXpcFyWjjqQTwrD+19UdfMTrGq5eQdDUZxSj2BBdoyGAPuMgad21Qt
 M6RQRDltUMtZXWDJtxpPVeCKiNH9jBN3USdPMdqkFXY0Pk4tcIaKvdaDU9zkZmWzdn44
 Pzb2ngOXNYJdJfu3a8KrfFeZmBZV8LEMFoIlk7r9yjB0dti4Pcm8lEVByyqWl9AAz35O
 5hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985822; x=1713590622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1i3GYPODdGEunG05Dn7518COsozxbeHPzw45fI5pR1c=;
 b=vbgVlLd5RhgKcWYsRt3gzrsSewWTqO55QRN2PomGmbeekU/8YCgJ/hWLOqXwr4HNTn
 OBiOZl19lwVIWD+44r0Dyw5tvWiH/t4uwtMQzelZB4zGSRSZsj41eDqRaEfBhMzUWpkz
 NDPz7vDoIP9R4HRhAO8r32PYqfJtlSc71hy9tFbMwrxqsVnHFjRsQIj/v3c51VLJ1Hn1
 HeSSlxvdddF0B0n+Rs7ucYf9UPougIpUKh0gQ8w2fkwGeTmwiuEpmne+37eAcJHfWGr1
 IsMSyeFn9eVOcoCsJ+h4/XyloJ8U2J+842rGaUMZyDan6J6JDivKPbNYHjep0+7jvbL1
 b9ng==
X-Gm-Message-State: AOJu0YwU6cOBZW6XuRenl5JyNdPo/QB4a8UfK3ialSqw9EHnm8aje1BA
 YQMyv6EtRgLna7fW6EoU7Tz9kRTkNMrscCkZwBHwXVeetRXds5l3cUPSvg7/FijkAQHD2ixTpHB
 t
X-Google-Smtp-Source: AGHT+IGC78uYqxyTgow5ZpgGrA5vO4+oDzbQp5d/T/Jvjdm81AEEDXml1BmiZpixiFFJAaQVnWnXDg==
X-Received: by 2002:a05:6a20:5648:b0:1a7:47ff:5f3e with SMTP id
 is8-20020a056a20564800b001a747ff5f3emr4370168pzc.9.1712985821960; 
 Fri, 12 Apr 2024 22:23:41 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 6/6] disas/cris: Improve output of register names
Date: Fri, 12 Apr 2024 22:23:33 -0700
Message-Id: <20240413052333.688151-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
References: <20240413052333.688151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Add REGISTER_PREFIX as a string literal that may be concatenated
with other string literals.  Use a table of the 16 register names
instead of using g_string_append_printf.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 71c292188a..01ea63c428 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1234,6 +1234,7 @@ cris_cc_strings[] =
 #endif
 
 /* Sometimes we prefix all registers with this character.  */
+#define REGISTER_PREFIX      "$"
 #define REGISTER_PREFIX_CHAR '$'
 
 enum cris_disass_family
@@ -1669,26 +1670,31 @@ format_dec(long number, GString *str, int signedp)
 static void
 format_reg(enum cris_disass_family distype, int regno, GString *str)
 {
-  g_string_append_c(str, REGISTER_PREFIX_CHAR);
+  static const char reg_names[16][5] = {
+    REGISTER_PREFIX "r0",
+    REGISTER_PREFIX "r1",
+    REGISTER_PREFIX "r2",
+    REGISTER_PREFIX "r3",
+    REGISTER_PREFIX "r4",
+    REGISTER_PREFIX "r5",
+    REGISTER_PREFIX "r6",
+    REGISTER_PREFIX "r7",
+    REGISTER_PREFIX "r8",
+    REGISTER_PREFIX "r9",
+    REGISTER_PREFIX "r10",
+    REGISTER_PREFIX "r11",
+    REGISTER_PREFIX "r12",
+    REGISTER_PREFIX "r13",
+    REGISTER_PREFIX "sp",
+    REGISTER_PREFIX "pc",
+  };
+  const char *name = reg_names[regno];
 
-  switch (regno)
-    {
-    case 15:
-      /* For v32, there is no context in which we output PC.  */
-      if (distype == cris_dis_v32)
-        g_string_append(str, "acr");
-      else
-        g_string_append(str, "pc");
-      break;
+  /* For v32, there is no context in which we output PC.  */
+  if (regno == 15 && distype == cris_dis_v32)
+    name = REGISTER_PREFIX "acr";
 
-    case 14:
-      g_string_append(str, "sp");
-      break;
-
-    default:
-      g_string_append_printf(str, "r%d", regno);
-      break;
-    }
+  g_string_append(str, name);
 }
 
 /* Format the name of a support register into outbuffer.  */
@@ -1861,8 +1867,7 @@ print_with_operands(const struct cris_opcode *opcodep,
         break;
 
       case 'A':
-        g_string_append_c(str, REGISTER_PREFIX_CHAR);
-        g_string_append(str, "acr");
+        g_string_append(str, REGISTER_PREFIX "acr");
         break;
 
       case '[':
-- 
2.34.1


