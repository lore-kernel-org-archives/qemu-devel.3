Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50994C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH2A-0002SL-39; Mon, 14 Jul 2025 07:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzI-0000fR-BY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzG-0001ad-Nb
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pz8fqySqkEOpDmp0MxM3l6r2UVHcHahwTbwglxlBYJs=;
 b=a63lFUhXxvzpP9yjXMNz/vGBiHZcRwxjy5tLItdSmpccGLy6UJyMJYvHyd317ynAWZyth8
 JOPhnUb/vOMkqqb8Qfi9HzpSXzNOFPLhykbHn90P6ootfnp/fMMtKJHljhcp6PGc3X75b3
 FLB+0h0JuLI2cSlmDBlPTZ7sFu7QgAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-lXhQxZIbN_SHzsj6UX2eUQ-1; Mon, 14 Jul 2025 07:04:44 -0400
X-MC-Unique: lXhQxZIbN_SHzsj6UX2eUQ-1
X-Mimecast-MFC-AGG-ID: lXhQxZIbN_SHzsj6UX2eUQ_1752491083
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4831455e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491083; x=1753095883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pz8fqySqkEOpDmp0MxM3l6r2UVHcHahwTbwglxlBYJs=;
 b=cgBdmGx7eVnRdpJvGKB/ONh/4l2pMGdVwkNcoJq9AxIzMsvr453lE3Ad0/ldR7D6lc
 caRyzCYR97IYfNVcSbNXpMjqNj+URjX8YCemOx/TKd8sszvb4mC92v+u1QfLB3nsJFHT
 QZ4JLX/KAtthtTnzb/QNzOcegIgN5NgAoasKJitECojKsSROn6g7mF2BD1Wj97Wou1oi
 6IKNxLXNzg3a9g3QGcyVLCrERMS5572N0SJb4JPHi2o31jH+brosNJ44PHjyRreJnKGJ
 +gGTgQjntacOpqRNWF8Lzl/vNirTa1F24wh/i3kDwhlUjF7qIJfNh4NU2SCZFy5ySpGv
 cMdg==
X-Gm-Message-State: AOJu0YwdkMYb0RL/h+tAMVM3Za1TvKcKog19wJYomGW4/FSwW/M/pUfr
 y+402YkFlp4a6euvUHn5TVjFykV7qkg43eVMFzHKAC+am1VkftKxFDUCYckiTMChjLNW/8DFIKp
 P5+yyw3NU+TK4dD23TmovxeSWJDHTEm/+P1XON/hpHPCARx67TNp6lOEp4tSIHW9+/ibMMkuBqw
 KDRA4CBS/g/Ig+5yclkZKSPUlWVXJ5i1uBSFxBSA0q
X-Gm-Gg: ASbGncvolyYxyCPPOPJxIq3qK3qLU+vNqvSoDqGwNTNsxrY0rie3dPG6rfclGEZjIXs
 vOQn7rjlZvPYdQ99ooPUcHbjFq1wlIj12Rf3RKO5LbSf0y2pv3ZdfTOFrUqDlziClG1aG0+mb3j
 Yvikph7QB1q7iNP/h0W2W+gM05HIT8P0cAtVtnBrpq9FcFuRco7uI2RlsRSsc420Nvl4c4x5jQ9
 Mxtr810CFK2EDOiWnEyL+kiMhqO33LQldCl7+2Jze+mJjeHgqPlmcV5YuKyYKZLnEwQQjwQgald
 cgnn8Nb/5sus5EiqILwDvoHHQ6Iz+29QbEjQemzVVjQ=
X-Received: by 2002:a05:600c:8505:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-4555f895526mr114787085e9.3.1752491082531; 
 Mon, 14 Jul 2025 04:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCF1U4/GMjQgR+xSX+ElFMi+rQOKfH4ES83cQdWDVbK+ZVMplwsbUY4oeQlbInk4agyJdsdA==
X-Received: by 2002:a05:600c:8505:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-4555f895526mr114786835e9.3.1752491082000; 
 Mon, 14 Jul 2025 04:04:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561ccd6d44sm10899805e9.1.2025.07.14.04.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 12/77] i386/tdx: Remove enumeration of GetQuote in
 tdx_handle_get_tdvmcall_info()
Date: Mon, 14 Jul 2025 13:03:01 +0200
Message-ID: <20250714110406.117772-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

GHCI is finalized with the <GetQuote> being one of the base VMCALLs, and
not enuemrated via <GetTdVmCallInfo>.

Adjust tdx_handle_get_tdvmcall_info() to match with GHCI.

Opportunistically fix the wrong indentation and explicitly set the
ret to TDG_VP_VMCALL_SUCCESS (in case KVM leaves unexpected value).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250703024021.3559286-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h | 2 --
 target/i386/kvm/tdx.c | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 35a09c19c52..d439078a876 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -32,8 +32,6 @@ typedef struct TdxGuestClass {
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
-#define TDG_VP_VMCALL_SUBFUNC_GET_QUOTE 0x0000000000000001ULL
-
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e809e4b2dfa..8c661c3ecfd 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1259,13 +1259,15 @@ out_free:
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->tdx.get_tdvmcall_info.leaf != 1) {
-	return;
+        return;
     }
 
-    run->tdx.get_tdvmcall_info.r11 = TDG_VP_VMCALL_SUBFUNC_GET_QUOTE;
+    run->tdx.get_tdvmcall_info.r11 = 0;
     run->tdx.get_tdvmcall_info.r12 = 0;
     run->tdx.get_tdvmcall_info.r13 = 0;
     run->tdx.get_tdvmcall_info.r14 = 0;
+
+    run->tdx.get_tdvmcall_info.ret = TDG_VP_VMCALL_SUCCESS;
 }
 
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
-- 
2.50.0


