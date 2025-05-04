Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFEDC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRut-00020d-1E; Sun, 04 May 2025 01:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRun-0001xP-WF
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuk-0004FM-TS
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2260c91576aso30454995ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336561; x=1746941361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=DK5EXCDBdOpqJ/Y0yEOXTOV5HFi9J/+h6fDak49CwfokFk62mPToaxvmhIqSUCTav0
 XfTsn+hMNHPsPHe+KM3BOrVC+GiiMASTcDPUb36rqUBX48QmYZDrtyFHLM6nNNWgYjIL
 mICeVM9cmGT58GkFo+S1HCdKBe3SZMGc+tuLUSIBPLl1mQimd4Rm6aIOW93l0pGCOEKt
 VjMHLCCb+f2SIAkF+4u/Xqp3yzrhYUhAn7KdF5Bcke79mgMYNTv48v9BEB5xtSwZ4nV4
 jY/qIrATpGInPb/WmfoWxff920qPrLZ1IheLNvXYf8BC6MwpMY1Asp1svN7UGu7bhHtK
 +hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336561; x=1746941361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=XlmgaONDqxjIIe1IYrktvxdPHz2YXm7FMwVUmgXc3yTvr5Cnlsv2R0w9Sy6m/4kyBp
 AiQv6S1JT43yB4rsfW7nMbvAjfPdXUDRShdx3Rq4bUxjJLjfdT6Lj45Nz/VuBA02BNSI
 aNzl4g8jmWxyRGxneLXuljpZCqcvmgy16XZSDCIbGAzPAsT0t18zzutN86UW8/NbesL8
 T+LqQ0C5G5RBj3mxv/fQIQd7lxJ03MjSK325tyaX8AVNBWuFXEwpCk3pOTc1azsFIHyv
 9xtymrZ7HR2XX9lol7BC/bPNgqHBbGt1z3UDxkc27ulPhsa2ofdXxZu4v5v5ufgAQ8uP
 6Rug==
X-Gm-Message-State: AOJu0YzsQHryO8npyawl1otyPVqjl2MN+vR0WMUKoeQKng/GuOzo9hlY
 AVDNcj6YY/gxCGbh2hOR/8E/iDoDyyBaXYmW7wFpfFhNsgqXrw52F73wJMcGuV1nPPeUHJyJplY
 rpzo=
X-Gm-Gg: ASbGncuwWIxG926cSVrtd+9+Q1UUGHcCsjdAhXDEgZBNWzuvOtA13mz6ASxf1AbHAkZ
 tFtkDXkO9ObLhWZUBREhtHIwX9ZKkoweTZ6B7BW3BXS+o3CuH2xK+WSc/+KjdqpCuZZD3RRpeTv
 HuMAKk3v2Yr8s8spy91UZtGarxIvsMKMDTqA7bTbzn7VZ1D0nK7RWA3OEFdEZy5tqPJyo4EI9hT
 +97DQ/OIji+pSC5GslJpBC6F5i5IonKyEk5ycSfJJBeRSZFLdTn9XR5bFS/UhuifxcsEH4zFr56
 3GWuT+dCk245iTO6WEBJOKMLMhe8XNSnVT6fbaR4
X-Google-Smtp-Source: AGHT+IHXnjnzTW6tdaUx2wqRb/N+J0DcR77Y5QyXk4o/4S99YU+4N55bxZt8UGnvoRa5cSJGoQ9fYw==
X-Received: by 2002:a17:903:1246:b0:224:e33:889b with SMTP id
 d9443c01a7336-22e1ea3ced2mr48331655ad.12.1746336561460; 
 Sat, 03 May 2025 22:29:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 01/40] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Sat,  3 May 2025 22:28:35 -0700
Message-ID: <20250504052914.3525365-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

CPUARMState::pc is of type uint64_t.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffebd..c30689c9fcd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(uint64_t addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(uint64_t pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.2


