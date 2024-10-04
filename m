Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770B2CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGV-0006XZ-Aq; Fri, 04 Oct 2024 12:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGH-0006Lb-2q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGE-00069L-NT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpzQuUOK0nFh0jcyW4lxqmvDGPCRl433Pr2mfBKjlTo=;
 b=RQf+srIhuwFBX2cNBtHhUoTEBw4z6h4fQGG+sguo6Ah6eiUdx0775G+kX01SstCVTjV0A1
 Q4gjFWam4yLEXmRdVV1kuKVgBFbMfTyDakDKrnVQLqvT9qXoK/n5oxXXxlyfMLFVls36Mr
 dfZmonVGtrXO666dcmW5kvXDQCbgr1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-74TfZIqWPHuGjJ-fL7fNkg-1; Fri, 04 Oct 2024 12:34:29 -0400
X-MC-Unique: 74TfZIqWPHuGjJ-fL7fNkg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb5f6708aso13897115e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059668; x=1728664468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpzQuUOK0nFh0jcyW4lxqmvDGPCRl433Pr2mfBKjlTo=;
 b=NlieM9aDXkJRp8uP6LlLi7PAN3fmNX0bCaodntYh5DqwJIHRU5Kyv2aDZkcBU+IWkV
 ca2Djqtc32gRK9FovoV5PM12tZV4VlooaVEoiX1XRvSJsdXDvFbnWa3gHYGgpQWS57ZR
 NJJUwZmXYSHNE//Pvd9Wc10kzzzQ7f/d6ZxwXxJo0FZHTwQznQlmI3FMXfWz2IFy6UmP
 qR518rU7lsaSUkLH7PdG6jXvBJJBeZVztKUInxNUrBy73XLFkYj9gPDl9HRT7gT4Q6pm
 8IlxrzxTprRc2wea4ITlYvQpGTaRkclQc7/ShHZxV6DT3L4awpOt9xzQ87Bf4snBHaWW
 6RHw==
X-Gm-Message-State: AOJu0YxF4h11B9BerSWl+TFnnSQNpP+w4LR50Re+0MoZfSAlmeDXWmJJ
 Y+yLZTFMpPprXOadYmB/tzUmlSkFwrto1uQhsew4SoU1A2Ilh7ISwNGfwJWrvRwOKSkRYamLzf4
 F1nu7YT5pSE6+452zaws5W6VTV5FsgTpjao0aBpLvszVVl3ekl3Y6sXH8pUUiywiSBQWrHZVEmm
 O85V2qUsMB+6G3U69YQ3hyAMYKUtkRMdsDrhJ3gvE=
X-Received: by 2002:a05:600c:4449:b0:426:5dc8:6a63 with SMTP id
 5b1f17b1804b1-42f85af408cmr22759045e9.30.1728059668241; 
 Fri, 04 Oct 2024 09:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyV7nJ02GF+LaQA/J/pWS1H1TEDw7tflLvWmBOZeNhi6Yyw73yJq1PCLAGlDbnaew3r/0TdQ==
X-Received: by 2002:a05:600c:4449:b0:426:5dc8:6a63 with SMTP id
 5b1f17b1804b1-42f85af408cmr22758865e9.30.1728059667841; 
 Fri, 04 Oct 2024 09:34:27 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e858d2sm1612165e9.10.2024.10.04.09.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Wang <lei4.wang@intel.com>, Xin Li <xin3.li@intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 03/23] target/i386: Raise the highest index value used for any
 VMCS encoding
Date: Fri,  4 Oct 2024 18:33:55 +0200
Message-ID: <20241004163415.951106-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index c8056ef83d7..27a3d7626cf 100644
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
2.46.1


