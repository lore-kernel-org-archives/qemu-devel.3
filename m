Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE4FEE49A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXs-0004wV-FA; Wed, 11 Sep 2024 08:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXo-0004Zc-Ej
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXl-00011w-Ud
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/bQlCWHRUXU1TzSq1fa/WJJq3aN/po0ArhGdFaRGLw=;
 b=S0XrpTuT3OZjPuqU7ax4W0lMs9v01HOO7slMXyWpiJOTOmQIGqErBBzPtDHQiAJ42Li7rO
 p2oRGyYAbLdx/B+Hu4cfXFyPjajCNM95x5bQyOBHZQs0tKeAEyc8Up7aLLshsb919LE3Ck
 6nk7TtE+CSLzEzfQ65+9npc9n580yx8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-LlSaepYHOo-j9zdcuSFMrg-1; Wed, 11 Sep 2024 08:33:55 -0400
X-MC-Unique: LlSaepYHOo-j9zdcuSFMrg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374bb2f100fso2896713f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058034; x=1726662834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/bQlCWHRUXU1TzSq1fa/WJJq3aN/po0ArhGdFaRGLw=;
 b=WePwxSMdMg7xHvoFAWlgeEIatBixMwmBPWLvJ3IoIWZcgvTk56f9vG8NPb4O+ZLUzd
 RK/4PMGhQzp4fkgyVGDRUlYC9KxJe/tLioNMkVdz+HY2nTx6BDIxdYM05zRjXZQFRVtn
 luTUKgX3jtPa45ZhJ/rKXZXYgthgScsCuIQPYreSAryE25/NUs0qhDr+UPuVIqxDiAyn
 Xi1EKtFQuozmEM8s8TBka1XA4XmgDG0he5GYrw0N9ZZNJBH/Vj0mIxLbYTw0yYsBQyFD
 nuh19vEt2mepGR0sZGbSsRdeC4P5cO0GzKOP9NO236cGKCnvjjFOzUJ2tqPKADyMKWNX
 DADA==
X-Gm-Message-State: AOJu0YxswO1uxUQEZmGnyc+Z/AuHjhC5ZfH2RYHoRya2kou8HZNjoICw
 LgVMVYkZluTN856GJPhbbkzkMqr93/dHaW7lwvfgBoLEDv1R7oyufpnYTjLyGoLEyhKXOVx2k/4
 /5zgyDZz22yQGHem6lUIp+MeziPHRIoM8gYN60aPCXw0yjCEcJhaDQSFYk6s0ilYJOE+3aCc3Du
 ufS2EwBr2Xza49RoJ74AjfLCEQaOp6piTf8P//Oc0=
X-Received: by 2002:a5d:58d5:0:b0:374:fa15:a8b6 with SMTP id
 ffacd0b85a97d-378895ca2f8mr10905567f8f.18.1726058033894; 
 Wed, 11 Sep 2024 05:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGJVF8zBIN7L71MwlWFNzon39T5/XJjASYYZ/v56EQTQLyNfph/jJ87Yzi9MocTAA9cQWD9w==
X-Received: by 2002:a5d:58d5:0:b0:374:fa15:a8b6 with SMTP id
 ffacd0b85a97d-378895ca2f8mr10905536f8f.18.1726058033374; 
 Wed, 11 Sep 2024 05:33:53 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649b93sm11471612f8f.3.2024.09.11.05.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Wang <lei4.wang@intel.com>, Xin Li <xin3.li@intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 03/17] target/i386: Raise the highest index value used for any
 VMCS encoding
Date: Wed, 11 Sep 2024 14:33:28 +0200
Message-ID: <20240911123342.339482-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Lei Wang <lei4.wang@intel.com>

Because the index value of the VMCS field encoding of FRED injected-event
data (one of the newly added VMCS fields for FRED transitions), 0x52, is
larger than any existing index value, raise the highest index value used
for any VMCS encoding to 0x52.

Because the index value of the VMCS field encoding of Secondary VM-exit
controls, 0x44, is larger than any existing index value, raise the highest
index value used for any VMCS encoding to 0x44.

Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20240807081813.735158-4-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/kvm.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2bf37dd15e0..9c39384ac0a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1186,6 +1186,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
 #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
 #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
+#define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
 
 #define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
 #define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e37..381f414d1e0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3694,7 +3694,14 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR4_FIXED0,
                       CR4_VMXE_MASK);
 
-    if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
+    if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+        /* FRED injected-event data (0x2052).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
+    } else if (f[FEAT_VMX_EXIT_CTLS] &
+               VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
+        /* Secondary VM-exit controls (0x2044).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
+    } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
         /* TSC multiplier (0x2032).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
     } else {
-- 
2.46.0


