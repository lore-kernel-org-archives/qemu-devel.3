Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60798CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNN7-0003cL-LO; Tue, 03 Sep 2024 02:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slNN1-0003be-EC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slNMv-0005mA-Ld
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725346221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MHqs+YS6/b7STpoCXDmibaNhuPWk00ztD0j0/H40oIk=;
 b=eqYegGKO+NS+piNiBO4iQYrgeV0ohFvlQnUzIkFXB7bhdXCgq/z7HRXZPimtbcTK7Zn/47
 w5AaAPW8aJdZxqiav62f+N4guIdMIh5gKu7sSak84pL217lLKtbyrERXVH5AMd/8hlVVG6
 Di5yxFzWMoLPY/NMI0Y8DkQja55H5go=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-U_40rXZIMEeZVQyKRH7ctA-1; Tue, 03 Sep 2024 02:50:17 -0400
X-MC-Unique: U_40rXZIMEeZVQyKRH7ctA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5daa71823e0so4735287eaf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725346216; x=1725951016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHqs+YS6/b7STpoCXDmibaNhuPWk00ztD0j0/H40oIk=;
 b=dWVKXYKwWWHdezLT3h9Aoc3s844bwDnzHlc7Rm9VI5nGQXZ4YYDAvYvcWGiBiEMtTQ
 D04l0lOqjvsSYPIixQeEfS4KqCZnE2/CLYGHhG3Kj1ypQJfqrNq5OEv7sCMejpg4AV6v
 /SMe8JyJuTKnwRLoToVXLNwynfEmk3zCRY9TQ5JB35kZE0f+iWKg+z2y5g61rkAD+TbI
 hpBceGo3HIYchanAOPwms8oViwNXVk7t1mfCu5utHi4aZlYMRz4SqBtZCq+k7gfH+nUX
 1vTilM4j0yukxMryBxx9C1nS18e4Ajl3eit8RDIGuZ4+BHkHSpL0aZrurVWVe0QfBwnt
 6Tng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF+Ra8gyA7SLAua6rP6iOXgpxmK66KR37itS4Yg1BpWuUgRR1DXcKzQeP8FsBHBU7JLXbn19aLQ1i4@nongnu.org
X-Gm-Message-State: AOJu0Yz6y+BXLa1Z7zhmE64LPyd5xFQK7XH6puHi6ibT+L+WfG1V4xGO
 6ggUeD7DoVnC+Q3WM3kBeRYfwl9WsqE3upMU4clPKeP0uqTBsfrrRZG50nNynDQfe00hYomjwdd
 MBmMTBvkCc8vPgCmjYz3ttQBtj8cDW2JnLeq6HcCaubuCPeKodwWS
X-Received: by 2002:a05:6358:9044:b0:1ac:f7ac:e302 with SMTP id
 e5c5f4694b2df-1b603c40028mr1925506855d.18.1725346216649; 
 Mon, 02 Sep 2024 23:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDtYxMXLuRJDtY5csiopW6kPGbzvKgGHPu7MUMQjm/EhG9u+Eyv7nvtPc8zH+3RhnngMO0RQ==
X-Received: by 2002:a05:6358:9044:b0:1ac:f7ac:e302 with SMTP id
 e5c5f4694b2df-1b603c40028mr1925505455d.18.1725346216333; 
 Mon, 02 Sep 2024 23:50:16 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-715e55771f3sm8098617b3a.12.2024.09.02.23.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:50:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] kvm/i386: declare kvm_filter_msr() static
Date: Tue,  3 Sep 2024 12:20:07 +0530
Message-ID: <20240903065007.31522-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
easy for developers to understand that its not used anywhere else.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c      | 4 +++-
 target/i386/kvm/kvm_i386.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e3..11c7619bfd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -93,6 +93,8 @@
 #define MSR_BUF_SIZE 4096
 
 static void kvm_init_msrs(X86CPU *cpu);
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                           QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -5728,7 +5730,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     return true;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr)
 {
     int i;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b..26d7c57512 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -74,9 +74,6 @@ typedef struct kvm_msr_handlers {
     QEMUWRMSRHandler *wrmsr;
 } KVMMSRHandlers;
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr);
-
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
-- 
2.42.0


