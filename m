Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C2CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w9-0005eS-UY; Thu, 23 May 2024 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w8-0005QM-56
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w6-0004pM-9n
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjC9jCKLkNDsyMvB5gIqtNiqr/gW7pKk6sCvaBJmOQo=;
 b=FijmG45uHnipUJ+jYa2pSFgJjxBV0Yt8GCIKNzleg8VuYGfgSeXD0mNvOZkfvV/5K/34z+
 2uXQA8RcygO9Awaa4yIFcg3TGc2TS8DHr+Q2hiQ5LvJHn6Se5CcbxXcF4FO1FtIJTMsBu3
 Bmgm7WUQKh8f059AFti9tzTpekaTHA4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-RCDOEWv5OQyN3xQzqLPrpw-1; Thu, 23 May 2024 11:00:52 -0400
X-MC-Unique: RCDOEWv5OQyN3xQzqLPrpw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2e952e85d80so7063411fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476450; x=1717081250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjC9jCKLkNDsyMvB5gIqtNiqr/gW7pKk6sCvaBJmOQo=;
 b=g1UA+1qKmdp9t9jIk9RwDJVVMXosKoAYPWy0/4s1hc819Rncd3ZE4E8uM8BHmIqelj
 tepiL3ZL/fUg42qlQ6RX1DgeHwFct8IhAEGXAnpuo6BTPPWOdhaS+jOmqBbUL76G7IMA
 woZ2eLtoRCiKy4Yuvy+Xw8F8dHsX0jvSxhxpyCSgsiENRH1EhHRgsz3k9jkZLc1KQsoA
 BUFZM5l62dHE1x0Ubuoy2DxAFxWmSZkwIFbTpo1tjIqiQsEdVN4vwILBc62DdMw39Ytl
 CbOXXvO55l/MuAyEGfycUotXBmv9ILTUw0ZmgZppJCGCUw9sQ6Yz7R5pSeHY5pWJ043i
 v2fw==
X-Gm-Message-State: AOJu0YzqGcZGAQQZ0YQ2VewolrTgP5LP1hmtv1VPk3CAujrHWazXf56m
 AJgOBF2lsp8jxjYQvG0U26csl5GCRbBzifrfSofBbnEjY1uieYt39i/hNYr9Lfruj1zBh0ROzGm
 5iEqTLLmn2IzhViHOhHiDJedQshUrlMc4dwq39k7cRFlofAR1GW58JjjVREbS/DWfDNZZJTaLAV
 gxyIIb4PhCyXZ8T0GKQGy6ACUzGyQnlLlLvLil
X-Received: by 2002:ac2:4154:0:b0:523:97ee:c1f4 with SMTP id
 2adb3069b0e04-526bf545f4dmr3424933e87.56.1716476450172; 
 Thu, 23 May 2024 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm1M09VvNVArFCumNveWJtkXO3dKW0qJg/6a/ry97/O/Nziuf/a/Shg89WXuDgWHcOGfykiQ==
X-Received: by 2002:ac2:4154:0:b0:523:97ee:c1f4 with SMTP id
 2adb3069b0e04-526bf545f4dmr3424907e87.56.1716476449667; 
 Thu, 23 May 2024 08:00:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a8a55f2e8sm1262018866b.126.2024.05.23.08.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Xuelian Guo <xuelian.guo@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/23] target/i386: add control bits support for LAM
Date: Thu, 23 May 2024 17:00:18 +0200
Message-ID: <20240523150036.1050011-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Binbin Wu <binbin.wu@linux.intel.com>

LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
LAM uses CR4[28] to configure/enable LAM on supervisor pointers.

For CR3 LAM bits, no additional handling needed:
- TCG
  LAM is not supported for TCG of target-i386.  helper_write_crN() and
  helper_vmrun() check max physical address bits before calling
  cpu_x86_update_cr3(), no change needed, i.e. CR3 LAM bits are not allowed
  to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update cr3.
  Allow gdb to set the LAM bit(s) to CR3, if vcpu doesn't support LAM,
  KVM_SET_SREGS will fail as other reserved bits.

For CR4 LAM bit, its reservation depends on vcpu supporting LAM feature or
not.
- TCG
  LAM is not supported for TCG of target-i386.  helper_write_crN() and
  helper_vmrun() check CR4 reserved bit before calling cpu_x86_update_cr4(),
  i.e. CR4 LAM bit is not allowed to be set in TCG.
- gdbstub
  x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to update cr4.
  Mask out LAM bit on CR4 if vcpu doesn't support LAM.
- x86_cpu_reset_hold() doesn't need special handling.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240112060042.19925-3-binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h    | 7 ++++++-
 target/i386/helper.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 107f263429a..ccf6811794e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -258,6 +258,7 @@ typedef enum X86Seg {
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP_MASK (1U << 28)
 
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
@@ -266,7 +267,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_LAM_SUP_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2563,6 +2565,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        reserved_bits |= CR4_LAM_SUP_MASK;
+    }
     return reserved_bits;
 }
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 48d1513a35a..f9d1381f90b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -219,6 +219,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_PKS_MASK;
     }
 
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        new_cr4 &= ~CR4_LAM_SUP_MASK;
+    }
+
     env->cr[4] = new_cr4;
     env->hflags = hflags;
 
-- 
2.45.1


