Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A4BC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrY1-0001Ti-I7; Sat, 08 Jun 2024 04:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXz-0001GN-JL
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXx-0000Du-VK
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbOzsuorb9Pd+45fc2ZCOTvf1efxLkBGGt4FyFc06tc=;
 b=VHyrpJQ+IbhjGMZJfWvYm7cH1dJvysJ0kjOYPXaa/8iq+N2HSc8B0xz2HSDThRyEFldjjz
 8ChU4jtaSs7KpKmcYMHAFY/j0kAOtHmlSn2CoADyvSh6wpT/VDwJLDRwkLhPW2NyD2MiUj
 CHhaI/ZrXs+GOrW7WfIsZPfQY9jfuEE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Ydf2XdZsOyC5HW8EBY43gQ-1; Sat, 08 Jun 2024 04:35:28 -0400
X-MC-Unique: Ydf2XdZsOyC5HW8EBY43gQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6ef729b465so44595366b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835727; x=1718440527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbOzsuorb9Pd+45fc2ZCOTvf1efxLkBGGt4FyFc06tc=;
 b=IL4+GaXUThX5DN634s5gDO+h89ta4F2tK5oRdP+lF2mzNUCmmWt/F8401/elbNvoVS
 TDpzbj/a6f1H5SUHFSwLGKUQAF2Eaz0OFiH9A0TWNnhfDgwX+cWkeRMtigAQJH9cezdA
 qyP6UTGxRVV4qAlnjE5omJVUMsuuPbHXBJRnGZQyYSkPqpiYoa4gffzeKIOgt5Fckkgd
 BnzWGhkhDvaeJGkHTuzBs2Y3W5CYP7sPKRitdrFRw5+QYMSxPxptLbAwW+MWxH+lX5oE
 ZJHCK2dtBEqnJA9NKz+ZIX74zb7Cv3D/sFwNoq2y/KyslUGweCuzDnOVdd8epO74fVmn
 W1iA==
X-Gm-Message-State: AOJu0Ywd6g4UJRoVrcXAGpcl6U1GycJVOfxSkHfjEAl7kKpF77m+PbBb
 SYqzb5/7/CMV1VWVJA9D7hqu42kLDEO8YxveiKSZTJvtleiwYHSM1GLqCa8cc88ngM29dfn4KSA
 EqoBicwFmEOfKALnSM1YNxmq52DiQ7ds78YujVEr1UKyQKDVg/y02x3Hs76hOzEMKj2xs2tGF+P
 6QNqow8QdbQFgbQM0leBhj/kal6eTSWJqtzvwV
X-Received: by 2002:a17:906:f10:b0:a6c:6f0a:e146 with SMTP id
 a640c23a62f3a-a6cd5616bd5mr310145566b.1.1717835727276; 
 Sat, 08 Jun 2024 01:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHweymnykigqlbOgJfK1QYei1niqOJxji225vD2eohSRkv+fFu3vIRvlea0yv62fMjWaB0JaQ==
X-Received: by 2002:a17:906:f10:b0:a6c:6f0a:e146 with SMTP id
 a640c23a62f3a-a6cd5616bd5mr310144066b.1.1717835726751; 
 Sat, 08 Jun 2024 01:35:26 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c969asm354491466b.55.2024.06.08.01.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PULL 26/42] i386/hvf: Fixes some compilation warnings
Date: Sat,  8 Jun 2024 10:33:59 +0200
Message-ID: <20240608083415.2769160-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

A bunch of function definitions used empty parentheses instead of (void) syntax, yielding the following warning when building with clang on macOS:

warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]

In addition to fixing these function headers, it also fixes what appears to be a typo causing a variable to be unused after initialisation.

warning: variable 'entry_ctls' set but not used [-Wunused-but-set-variable]

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
Message-ID: <20240605112556.43193-3-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/vmx.h        | 3 +--
 target/i386/hvf/x86_decode.c | 2 +-
 target/i386/hvf/x86_emu.c    | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 0fffcfa46ce..3954ef883df 100644
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
index 3728d7705e2..a4a28f113fd 100644
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
index 3a3f0a50d0b..38c782b8e3b 100644
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
2.45.1


