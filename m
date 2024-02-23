Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51007C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY1f-0006Pz-KX; Fri, 23 Feb 2024 11:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXid-0005a5-A1; Fri, 23 Feb 2024 10:44:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXia-0006FE-5P; Fri, 23 Feb 2024 10:44:11 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so820656a12.0; 
 Fri, 23 Feb 2024 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703046; x=1709307846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO+f3hPKeL5HSk7HpmCD/7SFZU9TBIYTsIyIXJfwhsQ=;
 b=l7P2TXJWVa+kAXDw+z0HPgc0C/cpq1njmCeJ9drlB2VflZ6Nk9rp2Lw7UFuMByZqtO
 cvJIzUaqG4h0OOse/qVwapCIAUkHVy02YecW5Fbj5AVgEVLVSQ0H2C8U7zo2Ggu9JKa7
 SI+gN5lq7H59Ygz5UUQAeRhScp+KmJoPd95MM3My+iPRwLM348ERHtsI8dRraETfm/Fo
 PAKHuqjPeUuh+19HZc/zR0CXCqVnkPmNFfRSk7mmou5gY+6qpEb7KpIJs6dGUOdN2Xo2
 RoDmWkVtc2uuRatcJm12jvjrGSsDCAuuaJj1u46MFOkEqo94iwEQ8+gwRbhEf9B5aN+/
 8q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703046; x=1709307846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO+f3hPKeL5HSk7HpmCD/7SFZU9TBIYTsIyIXJfwhsQ=;
 b=v25YXhUXkdR8wFH55p3p+S6Qz7C4GDmb6jhzxl3huxdKHujV5j9B2EFczhD/AqS+wr
 8mxgM+Y62+u6Imb5pVK2Ca9as4nkSokwBuzbhznsHL2+ioyMuEbdxRy67MPeWUNd7q6n
 3InfRixEKSuvSrxNuPfE3ibR23/O8tolvKylbbXvZqIYuxIB9NsD8RQFBkkkf0jLPiOh
 tYBOdamCki8s3qlTsPq1NySDzjI2nXeD+iUfOMwAE3ohzucMx0CVmSohcoPt4YjxWDeV
 EaTsj+ejORolWoVmlRCNRsuwuQIm7dBgTPqXt50Mdk+pffSMHl93qQhPD5pHp+njklMI
 FMzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaVwSOIQ5+MdYcCuFQpeM+bTpAfv2vt61zIer+sIfkB8YXuRL+wEsphtNTvwXkMcIHI3O7unmZ4CAPsWXDPNicDGyO
X-Gm-Message-State: AOJu0YzWBBVKPVd3FOBb+biXyNViKM5gBctvddanEc7FVAViAn85yRSa
 woNOhzmhnesd8Yv+7ZJd2a8ZSOO2UQkXZZswd82VQFjMeQwW7y7Dba2d9bio
X-Google-Smtp-Source: AGHT+IEL1i3QVJX18FoUVcQrE2jBQoetHJ8mW5JEfNLw6YDOP/r2un/Glo8DgRfIMzQUGTsJZ4hKNQ==
X-Received: by 2002:a17:902:ce91:b0:1d9:4106:b8b5 with SMTP id
 f17-20020a170902ce9100b001d94106b8b5mr178262plg.11.1708703045756; 
 Fri, 23 Feb 2024 07:44:05 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/47] hw/ppc/spapr_hcall: Allow elision of
 softmmu_resize_hpt_prep
Date: Sat, 24 Feb 2024 01:41:32 +1000
Message-ID: <20240223154211.1001692-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Check tcg_enabled() before calling softmmu_resize_hpt_prepare()
and softmmu_resize_hpt_commit() to allow the compiler to elide
their calls. The stubs are then unnecessary, remove them.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c  | 12 ++++++++----
 target/ppc/tcg-stub.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index fcefd1d1c7..0d7d523e6d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -123,9 +123,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_prepare(cpu, spapr, shift);
 }
 
 static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
@@ -191,9 +193,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
 }
 
 
diff --git a/target/ppc/tcg-stub.c b/target/ppc/tcg-stub.c
index aadcf59d26..740d796b98 100644
--- a/target/ppc/tcg-stub.c
+++ b/target/ppc/tcg-stub.c
@@ -28,18 +28,3 @@ void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 void destroy_ppc_opcodes(PowerPCCPU *cpu)
 {
 }
-
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu,
-                                        SpaprMachineState *spapr,
-                                        target_ulong shift)
-{
-    g_assert_not_reached();
-}
-
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu,
-                                       SpaprMachineState *spapr,
-                                       target_ulong flags,
-                                       target_ulong shift)
-{
-    g_assert_not_reached();
-}
-- 
2.42.0


