Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0016C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwH-0001Mw-Pq; Fri, 30 May 2025 03:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwC-0001Bx-Es
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwA-0006to-Q4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+fKfW+kt4kVgqGQSBmHl0QgHwifbapTz278DJ0gOG8=;
 b=am0uJvX3xOhffpktOKUIJrmQk9uut4KCSc9TLvpEwGJFBRILUPxs9Cj568O50H8k4JMQz2
 2cfwLW0ZNY73x+Df2EtHkDBluiJtcj9QQbio3tbUM0yQDKW5rP6MXbH/epr7Tsk3Ue0iI6
 Fy0JF7dJOKByiJN99wYMmdU1c6V2Mek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-zKXMRXxMPXaVROmy280LGQ-1; Fri, 30 May 2025 03:13:52 -0400
X-MC-Unique: zKXMRXxMPXaVROmy280LGQ-1
X-Mimecast-MFC-AGG-ID: zKXMRXxMPXaVROmy280LGQ_1748589231
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so177862566b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589231; x=1749194031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+fKfW+kt4kVgqGQSBmHl0QgHwifbapTz278DJ0gOG8=;
 b=cQzkSDFBYlGpZGM4mccqZpQ9GegyKAqnpi2iGDGSXRQfet7+h3EER9+HVcoW9iq4iP
 kFZ/i/W8nKxhjI/S1nL+jcczZ3lZnqJZynOLaXtFi1bs+XduiClztYxSCMhvGpJld9+G
 /FfATcJ5lm5jZUUdduSyRJapy0s0P6uzzBWW8soBpNtNYYmFEu5ZRnXoNUUV1gCCzx4p
 WefKE4NFqr3Y4BtnC7iI+BxiuEaE2XefF9QVcIgH1kBpSy9vb1oTUWtnJKq/49IGjYtK
 7z+xrsMcwRIHR7xYTdufViMUMcsDbEjzJzvWseFWuJo+tsYnYfjCp/AkT3zNRCZyAz1i
 AJbg==
X-Gm-Message-State: AOJu0YxgAa3RiPmM/j+3gzBBDaSO7VV5XMTXdKb48GtaYGczZyWhsknY
 zKoQcTQSEDu0KEtDqsCVrP1Dfx0rv+4lZPbsiYzG8aX0QUINADUo1CoOhYPl9HniNiltX2UmVwd
 QAlEu+lecXzAMLa81oU73DbMGT7qBcDWcA8dMToFZzLGI2kD8SiG0FBwlkvmDxiIKlPdkjfBkTJ
 5KHKyo+J7Af0Jjiea/aMeKBzofjBSD1DOcOIS/asB+
X-Gm-Gg: ASbGncsNEOLaUPl7FpoKdL48rrafGpAfSnRDTVKBnQNOeMd0l7XqL4n2YS8cahn1Bw8
 rzvUkI+Dx3ETJjOrfaGzy8mydXRkztcMvAuSBxDtTliJ4xE+L9Ft+mLryTrFL6cBLORYp0HFigg
 7Wb7LUT3aVrSk4SqIS805hk62gUEGqcJ8HR9qK136wZYfiQDDX+yG9B/ahajAfb95LPE2qQNiAR
 ay53/RYsX3b3m6khWJacPMBNJrZi8hT7yZ8A52MBX2C0HNBsnePvzrYCloNJRunhORu892gfAac
 Ebn08EpIWeh5iA==
X-Received: by 2002:a17:907:3fa0:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-adb32284f5emr209154966b.21.1748589231090; 
 Fri, 30 May 2025 00:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEtqM8gjmcBH3mxaynsU8ZEEQu8JmVog7tdZOlQCleRi75OyaKGMQgerhKut/MCf7xqNFE8w==
X-Received: by 2002:a17:907:3fa0:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-adb32284f5emr209152866b.21.1748589230707; 
 Fri, 30 May 2025 00:13:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fed0dsm277601666b.9.2025.05.30.00.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/77] i386/tdx: Validate TD attributes
Date: Fri, 30 May 2025 09:11:54 +0200
Message-ID: <20250530071250.2050910-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

Validate TD attributes with tdx_caps that only supported bits are
allowed by KVM.

Besides, sanity check the attribute bits that have not been supported by
QEMU yet. e.g., debug bit, it will be allowed in the future when debug
TD support lands in QEMU.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250508150002.689633-13-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 22d66bdb14f..c78a0e8b5ed 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,10 +18,15 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
 #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
 #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
 #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
 
+#define TDX_SUPPORTED_TD_ATTRS  (TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE |\
+                                 TDX_TD_ATTRIBUTES_PKS | \
+                                 TDX_TD_ATTRIBUTES_PERFMON)
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -153,13 +158,34 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
-static void setup_td_guest_attributes(X86CPU *x86cpu)
+static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
+{
+    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
+        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
+                   "(KVM supported: 0x%llx)", tdx->attributes,
+                   tdx_caps->supported_attrs);
+        return -1;
+    }
+
+    if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
+        error_setg(errp, "Some QEMU unsupported TD attribute bits being "
+                    "requested: 0x%lx (QEMU supported: 0x%llx)",
+                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
 {
     CPUX86State *env = &x86cpu->env;
 
     tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
                              TDX_TD_ATTRIBUTES_PKS : 0;
     tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
+
+    return tdx_validate_attributes(tdx_guest, errp);
 }
 
 static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
@@ -225,7 +251,10 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
-    setup_td_guest_attributes(x86cpu);
+    r = setup_td_guest_attributes(x86cpu, errp);
+    if (r) {
+        return r;
+    }
 
     r = setup_td_xfam(x86cpu, errp);
     if (r) {
-- 
2.49.0


