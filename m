Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB79CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlHY-00012x-HV; Fri, 04 Oct 2024 12:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH4-0008V8-BV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH2-0006Tv-K3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRvC2mnVWmRmKdKLdnn9nYwUy+TnAkjqCft8CNX5ggI=;
 b=ArzJk3s77tNl0biz4NSbnAtfOSZ0nK3RNCL9kghG11aqZ1SX7MXq7/JQWqdW6IcPnv9NNM
 iWooYdGH2Zsu0n0B3zJqAaM1Us0LNYC4dxIJzmuHhX7Jy8/IoWpToc318hY23N5giCLomY
 U4vffPN8zgy7E3PBUyi71ra+H85FqQo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-GgKRimlUNx-hNyryCpXzsw-1; Fri, 04 Oct 2024 12:35:22 -0400
X-MC-Unique: GgKRimlUNx-hNyryCpXzsw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37ccc21ceb1so1022037f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059721; x=1728664521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRvC2mnVWmRmKdKLdnn9nYwUy+TnAkjqCft8CNX5ggI=;
 b=uLVgImRrrpoInLl9NOe69lfDyuwhdjD0/Fz8MOEBWS+Jebb4Hbo3vxFk3YO+JKo7bj
 fgS1ToCPwfsy7hhkT9A2gfOGqpndGas5HTFHSPs23wUVeP+AGUsT+dcyWjehGjxP2pBK
 7vc+lOWaUN0bywX8k25xqn0lgz1UBByV88wCnqFxvIyi/Df221wtVZ0BoB+UDdlSDcW9
 He9eJsXC3mJ48EX6Wb5DUQAdi3KjZVL8IsAd0a6cF5cWjGIR+HMWFuK7TbNbycuqxqct
 qbZ0VR6SiCV9V1vubysdJHXT+I5P1AY49qw/fB11oDiIgWCwKv39gezt7jexPk+XNmj7
 98dw==
X-Gm-Message-State: AOJu0YzE8SwCPJ06UpUj6+2zj/Unp1e0XyeD5KHklv8QLOeiDSJdJiAL
 ChY/VPYZJHFyZW3wmu6LkhbxAoalaRGhUt2go5uvZL25/bg1KcOob6sI0FIIwTgco+I3YQuZord
 TabEReTkDtQSVlNIZaa4nRtTL0UzdYHGO9X7g0et3RwZFzBiwCa/8kMN08HdX4zrJdRiMp7j1l4
 TgA4ywkgBc9ZNgF+mID//vglZwG9scl103ZOwtmCQ=
X-Received: by 2002:adf:8b16:0:b0:374:c69b:5a16 with SMTP id
 ffacd0b85a97d-37d0e8de89dmr2082813f8f.50.1728059720672; 
 Fri, 04 Oct 2024 09:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHttAAS7WFdCRd0lnPyIqwC72c4U8D+Wb8GtiGTtzGKuEPe2HB8WuxzXTGE8w7cDwkKYO/EKw==
X-Received: by 2002:adf:8b16:0:b0:374:c69b:5a16 with SMTP id
 ffacd0b85a97d-37d0e8de89dmr2082792f8f.50.1728059720166; 
 Fri, 04 Oct 2024 09:35:20 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16921aa4sm34583f8f.64.2024.10.04.09.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 20/23] target/i386/kvm: Report which action failed in
 kvm_arch_put/get_registers
Date: Fri,  4 Oct 2024 18:34:12 +0200
Message-ID: <20241004163415.951106-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Julia Suvorova <jusual@redhat.com>

To help debug and triage future failure reports (akin to [1,2]) that
may occur during kvm_arch_put/get_registers, the error path of each
action is accompanied by unique error message.

[1] https://issues.redhat.com/browse/RHEL-7558
[2] https://issues.redhat.com/browse/RHEL-21761

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240927104743.218468-3-jusual@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0b03fb0577f..e6f94900f3c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5225,6 +5225,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set feature control MSR");
             return ret;
         }
     }
@@ -5232,12 +5233,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     /* must be before kvm_put_nested_state so that EFER.SVME is set */
     ret = has_sregs2 ? kvm_put_sregs2(x86_cpu) : kvm_put_sregs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set special registers");
         return ret;
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_nested_state(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set nested state");
             return ret;
         }
     }
@@ -5255,6 +5258,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     if (xen_mode == XEN_EMULATE && level == KVM_PUT_FULL_STATE) {
         ret = kvm_put_xen_state(cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set Xen state");
             return ret;
         }
     }
@@ -5262,37 +5266,45 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
 
     ret = kvm_getput_regs(x86_cpu, 1);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set general purpose registers");
         return ret;
     }
     ret = kvm_put_xsave(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set XSAVE");
         return ret;
     }
     ret = kvm_put_xcrs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set XCRs");
         return ret;
     }
     ret = kvm_put_msrs(x86_cpu, level);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set MSRs");
         return ret;
     }
     ret = kvm_put_vcpu_events(x86_cpu, level);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set vCPU events");
         return ret;
     }
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_mp_state(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set MP state");
             return ret;
         }
     }
 
     ret = kvm_put_tscdeadline_msr(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set TSC deadline MSR");
         return ret;
     }
     ret = kvm_put_debugregs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set debug registers");
         return ret;
     }
     return 0;
@@ -5307,6 +5319,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 
     ret = kvm_get_vcpu_events(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get vCPU events");
         goto out;
     }
     /*
@@ -5315,44 +5328,54 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
      */
     ret = kvm_get_mp_state(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get MP state");
         goto out;
     }
     ret = kvm_getput_regs(cpu, 0);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get general purpose registers");
         goto out;
     }
     ret = kvm_get_xsave(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get XSAVE");
         goto out;
     }
     ret = kvm_get_xcrs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get XCRs");
         goto out;
     }
     ret = has_sregs2 ? kvm_get_sregs2(cpu) : kvm_get_sregs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get special registers");
         goto out;
     }
     ret = kvm_get_msrs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get MSRs");
         goto out;
     }
     ret = kvm_get_apic(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get APIC");
         goto out;
     }
     ret = kvm_get_debugregs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get debug registers");
         goto out;
     }
     ret = kvm_get_nested_state(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get nested state");
         goto out;
     }
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
         ret = kvm_get_xen_state(cs);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to get Xen state");
             goto out;
         }
     }
-- 
2.46.1


