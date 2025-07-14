Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D00C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH6U-0007SL-EM; Mon, 14 Jul 2025 07:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzE-0000eJ-RM
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzD-0001Z7-5H
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CB+X0oKL0G0GBjxhvtx6dLGm/O/6KlgxKe/ThDuMvsk=;
 b=cCikgGNKMxBv4LBwHTaax7glzPL3tlQsPOgxVOZkam4Bm4IYuRfKFhV+G3n4fieV7Zak3r
 iTvo/4cS2dgaWFPibee5+IGRpL+wYyXi40gG/6uF+wnso7UFK+Gu1U8guQQJW4FOlZ6XlM
 6gxsUXlliLt/fZhpqyQBcBJTl7ge+Uo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-slW5GY8XOFykztV9WLAHKQ-1; Mon, 14 Jul 2025 07:04:37 -0400
X-MC-Unique: slW5GY8XOFykztV9WLAHKQ-1
X-Mimecast-MFC-AGG-ID: slW5GY8XOFykztV9WLAHKQ_1752491076
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so1623400f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491075; x=1753095875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB+X0oKL0G0GBjxhvtx6dLGm/O/6KlgxKe/ThDuMvsk=;
 b=isPT4Gkrx6twqmKMDTCHN+FuZ2AFA9PdLXpd8con89Fr7C10iSm8kMDpeD7xQBIASq
 ES4LDJ8+W6IhWbXz+/v6mSRIjRvtMCW4Dyo38szbJ3oeeWA9ibS4KzposzMNdUKy4YsM
 Fd/rIcQw69+viV29NiF7m8Qgmhpn/yd0nwWQqOpuU88pMdRIRtIV6E+sjMTGkWlh1U1t
 YGIeCI2j5B92faFTstTxnZZK98zMMa4vthR60mTVKncZQ37mr1oMZt14A/OCyrbqqUP1
 +2BE27lH2X+hqFPNWEaBGcbYw4ccbzaVlFbBMLvaxRU1mLPGzyeBJYkN9vo0vL3V+7R9
 rPpQ==
X-Gm-Message-State: AOJu0YxR8aHUpjR+ce4T1xHIVYzxO0ZohkrywDw8XlYKem9Bxy7nWdgW
 qJvS4i6g41qQ37/DfA0kYWFf2z5104YtBqByxDbcP7a4FJJXleCGIIyc5gIarIqJCAbs91lMMMs
 nJPRiQWRjul50/ng+ReLDmBMEtPqGg7TR9lI1Oc6UiMp1PK4toT12sE6hhrScVovaBq+FtL7OrZ
 SmNIYN/gwypExm3sandwY74XQS4fxousnCjVqpazCC
X-Gm-Gg: ASbGncvM/gkBo4Oek/mBfl8+bBATV7QFSxA1618lTxRiA4ASVLdZbr8bpOOv+0KsZUE
 DTdHSQGVMDgI6QhBCVQULzX6yZp7qx4qod0palutQ9AOzr7+oDWdgFAYrYzYrlU/X5rfyJs1vpg
 0PN74eylTU5zxYthTYmn/YwO3i68OmQUNcyd8DX6PGpzI4Fb7EPV2Zd5fn1ivW6pf0uA7Eq/Kl0
 O6dGYFCQdtNHJIwcKohlSuQjGXijK/aMcBCo/q/DQECrZKGwrZeDl3wlGab+/p/Ht8Csjwqckak
 f1QOHTS0xpipN11+pbvIGaX1urh835tijeNdv2td1wk=
X-Received: by 2002:a05:6000:2a85:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b5f188e9d1mr8205530f8f.24.1752491075007; 
 Mon, 14 Jul 2025 04:04:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdaJrAFm4W8M9Gw8cMwztJzLdVyMelXQNq96ku/clV/0jOkisD1qlKuu23mjtU02uzeo590Q==
X-Received: by 2002:a05:6000:2a85:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b5f188e9d1mr8205508f8f.24.1752491074489; 
 Mon, 14 Jul 2025 04:04:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm11942604f8f.76.2025.07.14.04.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/77] target/i386: allow reordering max_x86_cpu_initfn vs
 accel CPU init
Date: Mon, 14 Jul 2025 13:02:58 +0200
Message-ID: <20250714110406.117772-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The PMU feature is only supported by KVM, so move it there.  And since
all accelerators other than TCG overwrite the vendor, set it in
max_x86_cpu_initfn only if it has not been initialized by the
superclass.  This makes it possible to run max_x86_cpu_initfn
after accelerator init.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c         | 24 ++++++++++++------------
 target/i386/kvm/kvm-cpu.c |  2 ++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8fb74b56ddd..9c5cef2c7cc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6199,21 +6199,21 @@ static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
 static void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
-
-    /* We can't fill the features array here because we don't know yet if
-     * "migratable" is true or false.
-     */
-    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+    CPUX86State *env = &cpu->env;
 
     /*
-     * these defaults are used for TCG and all other accelerators
-     * besides KVM and HVF, which overwrite these values
+     * these defaults are used for TCG, other accelerators overwrite these
+     * values
      */
-    object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
-                            &error_abort);
-    object_property_set_str(OBJECT(cpu), "model-id",
-                            "QEMU TCG CPU version " QEMU_HW_VERSION,
-                            &error_abort);
+    if (!env->cpuid_vendor1) {
+        object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
+                                &error_abort);
+    }
+    if (!env->cpuid_model[0]) {
+        object_property_set_str(OBJECT(cpu), "model-id",
+                                "QEMU TCG CPU version " QEMU_HW_VERSION,
+                                &error_abort);
+    }
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 0fb88a239d4..6fed353548e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -111,6 +111,8 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
 
     host_cpu_max_instance_init(cpu);
 
+    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+
     if (lmce_supported()) {
         object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
     }
-- 
2.50.0


