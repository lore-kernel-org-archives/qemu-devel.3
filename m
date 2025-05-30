Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwQ-0001ZE-Ga; Fri, 30 May 2025 03:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwE-0001Mz-Ez
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw8-0006tP-Oz
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PMZx8CW/ZJ5L6YF0n/BoS9VKERI3wcezul0GBrsyAg=;
 b=I8Wo01iV/VgJjf8pr8mPpPDiK89nU9mS8MIwqYnXpY0WKYVpD+bVMdkYDM5i2QY0LB4TbX
 fH0B6g3afdMXT3apQ3q51nnjGdrNi/goU1KY4ogm7S/P7N3kfyFJZu5XVQQk8EtB2CR1sT
 0SnJI413TNlPCBrqg7hONF21tm4+XZo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hYtXLY4LNy6yxDyg5NEGKA-1; Fri, 30 May 2025 03:13:50 -0400
X-MC-Unique: hYtXLY4LNy6yxDyg5NEGKA-1
X-Mimecast-MFC-AGG-ID: hYtXLY4LNy6yxDyg5NEGKA_1748589230
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-604fe4c3130so1406475a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589229; x=1749194029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PMZx8CW/ZJ5L6YF0n/BoS9VKERI3wcezul0GBrsyAg=;
 b=ZbayWZV9P9SIEnMdIuBz9g6UgT+kGkmb60pHBFbQYa+SkWpTe83fkNqhmAMKUPolbo
 Femw+fF0jqmb3bbrUnEC6v28vu259zSzd5Heeq3izFn/Y310RHuOYLZZMBbpoI7KWbOM
 Il1MCmSO6TlZmzFoEJuC7YOHnfjV/fTHEppC9kfvrQ7X2U4XKT4JPNt/oV7HjUMCnNbS
 eEMlSnm1CmsWXWntxHna9NRXriJrKznfquLdzmkA71ssoOk2iGYbJ/mLbSUQtX6/BRxz
 W0MO5P+Lz7XHWNvJUeASkhsExxZEW2tlkJg0/c8p1d7UAn1loMGZePQu4pDCQ6/idzfH
 Se3Q==
X-Gm-Message-State: AOJu0YzMFqL1GwNSLDw+EJTmX1ifvpfWnd1nvCkjSV9PWV4u2KC0H4mw
 3g4zmyHfs9F3l/IwZghs+RFuJcreTD7eN4PX4zrGMFKjJ4f7GIU+Bq3I22TJhn2ZjB7KYmNSOHz
 vni04Cr/glFvza2/iUF2zr11bZ/BgLr2lZVaJL57A4NPeI69IyBP8XPfsk9XKFUFn1hEBJ7lX2Z
 ePF9xnGpSeAfIPbMmbjDeEYIaNYH9x9Daq7OmQNbTW
X-Gm-Gg: ASbGncsL0mNos/10HkL0x1OvXsQ7sof1vM9vkK61+Q1faerOs7G2VW8dmQnxV14Phrg
 lOT1LavpKNubDtXohjOMvdZf5FPA3gGTlbuIlcxkf/wc3fcheJU1iUAVlwf3loKLW6sS/EI5Bkc
 JN5UTrUADZrYQDaXeTrz/n9pEUBaJmWjjZjOb7T/bEbCqaPfFx0lp9T9c9N56mgRUJaOwbIPzB/
 AJYEvrS2bzOC2up4HRrNq0Ekz2fh+FdaC/Q7+ux7DSc+l3/8v8eVkcRGuDMZMsIj0DrSD5KrhSX
 y30G4YH4YZLqhw==
X-Received: by 2002:a05:6402:34c9:b0:602:4405:776f with SMTP id
 4fb4d7f45d1cf-6056ef01f87mr1598575a12.31.1748589228749; 
 Fri, 30 May 2025 00:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQ6kRYPtUhMR1aU8nvg7p8dowMTarXA2vm2wAe0kaINJx9TtVI5A6NZdeH+GQCpM4Gb7eMg==
X-Received: by 2002:a05:6402:34c9:b0:602:4405:776f with SMTP id
 4fb4d7f45d1cf-6056ef01f87mr1598549a12.31.1748589228245; 
 Fri, 30 May 2025 00:13:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c74ee7sm1222629a12.47.2025.05.30.00.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/77] i386/tdx: Wire CPU features up with attributes of TD
 guest
Date: Fri, 30 May 2025 09:11:53 +0200
Message-ID: <20250530071250.2050910-24-pbonzini@redhat.com>
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

For QEMU VMs,
  - PKS is configured via CPUID_7_0_ECX_PKS, e.g., -cpu xxx,+pks  and
  - PMU is configured by x86cpu->enable_pmu, e.g., -cpu xxx,pmu=on

While the bit 30 (PKS) and bit 63 (PERFMON) of TD's attributes are also
used to configure the PKS and PERFMON/PMU of TD, reuse the existing
configuration interfaces of 'cpu' for TD's attributes.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-12-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a30731b1a3b..22d66bdb14f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,8 @@
 #include "tdx.h"
 
 #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
+#define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
+#define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
 
 static TdxGuest *tdx_guest;
 
@@ -151,6 +153,15 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
+static void setup_td_guest_attributes(X86CPU *x86cpu)
+{
+    CPUX86State *env = &x86cpu->env;
+
+    tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
+                             TDX_TD_ATTRIBUTES_PKS : 0;
+    tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
+}
+
 static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
 {
     CPUX86State *env = &x86cpu->env;
@@ -214,6 +225,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+    setup_td_guest_attributes(x86cpu);
+
     r = setup_td_xfam(x86cpu, errp);
     if (r) {
         return r;
-- 
2.49.0


