Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA4DC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 11:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLK0-0000XB-8D; Fri, 08 Aug 2025 07:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIw-0008FB-VF
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIu-0002yR-FB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b794a013bcso1533158f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754652630; x=1755257430; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GwpFYhGeznRr6+q3T7zVU58Gdck7R9DYOTkt4rNGfxc=;
 b=x44ktx+Wkr8zWx+/NcfasFSSvVaF9wCxqpjf9hJqv8Pq9XUe/YuvLmiewtML2wSclV
 Fs/fQpApMJgTfcHBEppMUC7VM3kJqgJHY1V95GB3Cdhve5tXhHTM3cP+eTzdNyQ5WTWh
 MsuS5Nb2+hwnZTy0b9xWJTLQy8N4Fev5KemCkIyMkNU/q0zeljdP0kjs8fl/pjpNZCoV
 sJti8jBI270iFerPj7CuB1V+Qhl+MFYS27OHRkhV+tXLnWUz6Quv+e34tDYQpe6MEKlt
 fwMMscjybQgcUyafi+yo8fTDFULpgvyCIAeoPL/ks1nd/JIJ9u0AtwQz9hxKrl/x1nI7
 /spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754652631; x=1755257431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwpFYhGeznRr6+q3T7zVU58Gdck7R9DYOTkt4rNGfxc=;
 b=nhQq7r0PjrGAFXrQr1iQ/iUDcH8cpz4o+AiQzWFLRAqS1UQJMCvpGuM14wON1+Mm5a
 jX7p+DUDLFnoBQOuOUWhciHqq+ibaBgRS7l/aBJFE03TUry+K32bxvodN2Ff2M7PSVhV
 UklxRhbiIsduZtI2YwUxq2zV87bF5xN6avXuh/fHORjmg8W7rNtWNn57TKKzWQ/ajKpr
 mtVJ+o8j1pNAlBqKudNid7NtBrjJ6GwyYHRmH7DE2Ux/jXuF+2OJp27oMfAQ0/H+L3+1
 xdpDdO3eQINsZfMWoH+E6G1EDb11ZkPr6jM4ps5uib3P7VlZFYitF2fKFN3h3Izsl/3K
 LCLA==
X-Gm-Message-State: AOJu0Yz5KeFjHIXCsyXIJDg+xCp6kIUXlRRmu/pXndUdJJf4bgRAhvwo
 JWbLTVYg1+6I6ujvdSGrSRlIoYSHBzVv7zMkPXwNaPsUnD5/lCXSPS9WPVSGBMm8BVM=
X-Gm-Gg: ASbGncu9cyU4p/U+856zZj9mqQD/lnzGwecVixsij6OvdxtlS5mL/4QXs1Bjtdzehmp
 Ayyyu75GRSf7d8Fy5ZT0B93wOH4NLGw9//Fy5puNSA3XMwD29h7HLR8kTVzvr/waoy/rK4HZGqB
 PzinVG3GPdfg8+9BRO+nYqAj15U7yBmzXIqwP03BjqBg7oTdwbEMhNwHBvCkedEGrRmG39Ljnw+
 MkG1fQH02FFQzIU+26HZMg7iavsyD8nvFWRW78U4Q7pWU4x7h4Jb20YIvCaUxeMRmNa7nr6UBGZ
 EegULFCiElbKS7tMxcoXEAEncVg+5uHFc1EmXlEz/ggd4macDqzu5F2vIipKTI7CbXIcuG3vuIO
 rgogy+ZrKa4Q3kfO2Af33Uvrh/Cq/wZ4JvgyORTjZYfmADJIaREhhjp4EaNPZt7rsZ4U1
X-Google-Smtp-Source: AGHT+IGN4QUS09lseJvhZXQxtEUb+QSmc/a4dzcpZQQ1cjD+ioi62Zx0FFDz0cunx1K+Nv2Vdd+zwg==
X-Received: by 2002:a05:6000:288b:b0:3b5:f0aa:b1e5 with SMTP id
 ffacd0b85a97d-3b900b4dac6mr1936506f8f.19.1754652630524; 
 Fri, 08 Aug 2025 04:30:30 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9386sm30034248f8f.18.2025.08.08.04.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:30:29 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 08 Aug 2025 14:30:14 +0300
Subject: [PATCH 2/4] gdbstub/aarch64: add NZCV register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-gdbstub-aarch64-pstate-regs-v1-2-14ba70be1b3d@linaro.org>
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
In-Reply-To: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=M+o0NxtbVX/WeQLjyp8sVxOp2zp/MN1L8BDmz068olY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sZC9SYkFDZy9qRVFKMTl5WTVoc0VINmVwV1ZWClBiMkZidm1heG5hSEtyUnBN
 T1NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpYZjBRQUt
 DUkIzS2Nkd2YzNEowSVB2RC85VHVUSGRLZ2FneFc4czJzaFRaSUlBZE5iTnZrZHM3YVZiM24xbw
 p6a0Z0VXhhcVBrWnBwR0dUaXIySlVQcnZRSk8ybmNaM0JMZWJENEFHUlp1MmFuQzF4VGhlNGxXa
 XRoQ3hNbEtsCnNnbkhZaEtOOWpjalNTclVLWi8wMlVTRWlqdzdId0d1b3ZNV1oxS0Y5UTVrK0lE
 eDZDU0RyVkdRL1pNLzVMakoKeGMvaXF6WDU2RHJhenhVaE41YUdvWkJpQjNzdnZJWkhEL2RhTFR
 OWXhKSmEvL21TR01CT2lUS2piSExYZXQyMgp1RVNhUXY0Q3ptTFdLNEIrQnk3TktObjVuZEtXQ2
 5Ua3VrWElZZFZ5L1NmQVROamVjWVpRUHN1dlRNVStwM2xsCkpvVytrWjdvemUrTW1xRWtHSTQyM
 DFkWk5DQ3RWZjlJTVBiaFFsVHMrUmFpSndha2VHOEgxV2dDTHNYR29ZWHoKY3YyeWZzaFhONkox
 bitlbW5maWRwdVJ0bnhMc3U0RXU3dTlGZmxjM1Zwd1JZUzRmUm4rS0NDTFZub0Z6aXlnaAphQlF
 nRG1Kd29LeldJTm1aLyt4TEFwNjVETG5kYnBIU09paG1xU0JqNUMzNnM0cXNoVW1nWHVKTkFuU0
 YvQzZ1CklGWmcrd2pqTEI0cWRzVEUvbzJGVzl1ZytpQVl2ekdxaEpwckVEMTU3Um9Fa2JMQTFtS
 1RKOVZ2QlB2b2lneUgKZ1VsY3M5aFJCVzA4WEJlKzBpZWY4S3l6bVBnWURFdTRPOTkyTVhUYW1y
 MmFhOUpYMFlCWUJrR213U0hYQ3hvTgp3T1o3V05aRDMzWjJBYTUvYTVSRDZiN3ZROEVQRldFL0c
 0RlRLckN6dFBFaXB3Mm51NWZUNUEwMURBWXR0dnBBCkgrZFk3QT09Cj1WMUxPCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 gdb-xml/aarch64-core.xml | 14 +++++++++++++-
 target/arm/gdbstub64.c   |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
index 19ad743dc5607b4021fb795bfb9b8e9cf0adef68..2b74b87f908f792c24f76f212e4f7eaf335ddbc2 100644
--- a/gdb-xml/aarch64-core.xml
+++ b/gdb-xml/aarch64-core.xml
@@ -95,5 +95,17 @@
     <!-- Exception Level.  -->
     <field name="EL" start="2" end="3"/>
   </flags>
-  <reg name="CurrentEL" bitsize="64" type="current_el"/>
+  <reg name="CurrentEL" bitsize="64" type="current_el_flags"/>
+
+  <flags id="nzcv_flags" size="8">
+    <!-- Overflow Condition flag.  -->
+    <field name="V" start="28" end="28"/>
+    <!-- Carry Condition flag.  -->
+    <field name="C" start="29" end="29"/>
+    <!-- Zero Condition flag.  -->
+    <field name="Z" start="30" end="30"/>
+    <!-- Negative Condition flag.  -->
+    <field name="N" start="31" end="31"/>
+  </flags>
+  <reg name="NZCV" bitsize="64" type="nzcv_flags"/>
 </feature>
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 16b564e1a970cb5e854a705619f71ffc61545a73..dd3c6222a577efa03753cf07371afdedeefdb771 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -51,6 +51,9 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 34:
         /* CurrentEL */
         return gdb_get_reg64(mem_buf, env->pstate & PSTATE_EL);
+    case 35:
+        /* NZCV */
+        return gdb_get_reg64(mem_buf, pstate_read(env) & PSTATE_NZCV);
     }
     /* Unknown register.  */
     return 0;
@@ -83,6 +86,11 @@ int aarch64_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 34:
         /* CurrentEL */
         return 0;
+    case 35:
+        /* NZCV */
+        tmp = (pstate_read(env) & ~PSTATE_NZCV) | (tmp & PSTATE_NZCV);
+        pstate_write(env, tmp);
+        return 8;
     }
     /* Unknown register.  */
     return 0;

-- 
2.47.2


