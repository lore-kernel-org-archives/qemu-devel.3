Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA48C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEomv-0005TG-Lv; Wed, 05 Jun 2024 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEomt-0005QR-7d
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:39 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEomq-0003K6-PN
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57a68b0fbd0so3293188a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586795; x=1718191595;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jz+LXvXPAM70EjQQqCu1N8a5rP+u5jvbMbCKW1n/wvc=;
 b=2WPP6TDEFBXAvd1MKJqxaEn7PSPvvFOgkqouNb8N4T9U2nufVK/cic2XaUVrouU48G
 I7QDPJiGwBe8ESS2l334gWBGNVgPD1p7QS0cw1B8o+Z/x5NXsKb9/a7Xvyya19y4bd/U
 u4/0OIbkz4MCV1HxHBoo0KVRpxxZ4RzYxekXS2LJ58vsYvp+5suSZ8EJKJEobieNXZaz
 CfDWeGeKgWn0CURoR/CMkUHFpIwzoGtRWdTX/0XpGJT40ynIL2HUN+mV1LBPhIKfLy/W
 +NiHRVgaIIUgPfjZgb6I6SMwJKzm2DO8LznK1Urfmnrw4BLBMtKK6phVYvvk719NmJXl
 vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586795; x=1718191595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jz+LXvXPAM70EjQQqCu1N8a5rP+u5jvbMbCKW1n/wvc=;
 b=YvA7dzxntmzzawQvHK/28EafznFqOH+pnsrRhzPPnuWWDb2qLv1FNnmaPaHn9FZam/
 ElkUVsdb7eo/0vj5SYZ+kUPZeHwYWsn+khbhQZ0EQDddhK1W2XH2cWRh7bE1Bpg2gbee
 ba3RCWKFpyq+WGhUwhPgNZBCPDD/FS+wS+1ugHJ4+zQtfHBq50TOxZ/g22OwEgXfA1wr
 uXgZFIrq7uWjorYodW5L8oMXo4EDNwXMhLimQftjQz5M3Q+tUBs+0Ni/pznMXdnLFsE/
 58eDMuyF2VdVabBB9weKY+S4o9RBTQxgLtj9ZvZcn4S2b286J/OFh/CWHvLLi1exS+be
 5LDQ==
X-Gm-Message-State: AOJu0Yw/Kq+qE3c93xhyfuvKYeOtTJlpC1mYEDa7cKKnCXluw0cXudhb
 yiUCXq+XMntT0NOaq1SA9v+Mfi/w5sbR3Dx53SU4CjVcjglseX744Y/nANcU+8uJtfvBBehbcg4
 =
X-Google-Smtp-Source: AGHT+IF7bSB3b1MIka1x5hxtiRau/mQrhq/7XtAxhAWO22OVw1H0TP7TkE4mOa5XT045eDqd2DfMuw==
X-Received: by 2002:a50:bb44:0:b0:57a:24db:f389 with SMTP id
 4fb4d7f45d1cf-57a8b6b664emr1536760a12.21.1717586795393; 
 Wed, 05 Jun 2024 04:26:35 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:34 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PATCH v3 2/7] i386/hvf: Fixes some compilation warnings
Date: Wed,  5 Jun 2024 13:25:51 +0200
Message-Id: <20240605112556.43193-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52e;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

A bunch of function definitions used empty parentheses instead of (void) syntax, yielding the following warning when building with clang on macOS:

warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]

In addition to fixing these function headers, it also fixes what appears to be a typo causing a variable to be unused after initialisation.

warning: variable 'entry_ctls' set but not used [-Wunused-but-set-variable]

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
---
 target/i386/hvf/vmx.h        | 3 +--
 target/i386/hvf/x86_decode.c | 2 +-
 target/i386/hvf/x86_emu.c    | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 0fffcfa46c..3954ef883d 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -95,8 +95,7 @@ static void enter_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
     efer |= MSR_EFER_LMA;
     wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
     entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
-    wvmcs(vcpu, VMCS_ENTRY_CTLS, rvmcs(vcpu, VMCS_ENTRY_CTLS) |
-          VM_ENTRY_GUEST_LMA);
+    wvmcs(vcpu, VMCS_ENTRY_CTLS, entry_ctls | VM_ENTRY_GUEST_LMA);
 
     uint64_t guest_tr_ar = rvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS);
     if ((efer & MSR_EFER_LME) &&
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 3728d7705e..a4a28f113f 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -2111,7 +2111,7 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
     return decode->len;
 }
 
-void init_decoder()
+void init_decoder(void)
 {
     int i;
     
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3a3f0a50d0..38c782b8e3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1409,7 +1409,7 @@ static struct cmd_handler {
 
 static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
 
-static void init_cmd_handler()
+static void init_cmd_handler(void)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(handlers); i++) {
@@ -1481,7 +1481,7 @@ bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
     return true;
 }
 
-void init_emu()
+void init_emu(void)
 {
     init_cmd_handler();
 }
-- 
2.36.1


