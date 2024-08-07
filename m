Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D87AC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbua-0001Bf-AT; Wed, 07 Aug 2024 04:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbuY-00015N-FM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:20:46 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbuW-0007G4-5b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:20:46 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4778IDph735187
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 7 Aug 2024 01:18:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4778IDph735187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723018699;
 bh=0zoLZBu6i+pYaksTM9d8A0bq3H7+OisO3/x/5JiQ+a4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cd6jmI6jkkbczXYlJZfYrW4d/1FOSL7BVPwDsAPiM4xkgGx04hou99Sw8KMcyJPLL
 OA9EwbwD1lFNOJst6T9Vn37YrEjIiw5hEBl5SZfU5JpHu0YpnlUsI7CEMHYiMV5DSJ
 zsntBo3SQU/fZOkiK7qnRdpoBvibSxAXSTjbmY05W4MRQLOyCkm44Ob8ftUZ4+zMW5
 hUCIWS5+4X6j7PziOhkv31zrHggoi4/ur3oi0JfCPpRUvr3rkS13pDm3GG53WB4EVS
 5fPhAJJxc7QJWf2u+m4b8A4jYbVMfcJbAojvTm7OMI6XKWlkzrrVGl9XMOJTlNwZHX
 1Cj7vk/cuDvNg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, lei4.wang@intel.com,
 zhao1.liu@intel.com, xin3.li@intel.com
Subject: [PATCH v1 3/3] target/i386: Raise the highest index value used for
 any VMCS encoding
Date: Wed,  7 Aug 2024 01:18:12 -0700
Message-ID: <20240807081813.735158-4-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807081813.735158-1-xin@zytor.com>
References: <20240807081813.735158-1-xin@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/kvm.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 118ef9cb68..62324c3dcd 100644
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
index 31f149c990..fac5990274 100644
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
2.45.2


