Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB17C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrED-00081B-Jt; Tue, 30 Jan 2024 11:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrEB-0007yC-EM
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rUrE7-00070q-QV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706633085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GxeZ8K1V/jOJDYZ0KHs0QWtTyBu4+WNrnObPrwyAINo=;
 b=a1gAJy4TAF40+D867TPnEI9adUI0w7dOW9kLLezq2yQyqdriidq43kvAhFcO7uxkQWBKu+
 ZQ5E7J1qtTYMheFZn3bbdK5rsKTnjr0xM/UV5uROlXn+CmL7mcmYXmKRleAVdtygZ4nrx3
 sFVRoA5LPC8a2n1AKhkBZ9ab25JYHf8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-5mWKUCFDM4SAq34Ifz89sQ-1; Tue, 30 Jan 2024 11:44:44 -0500
X-MC-Unique: 5mWKUCFDM4SAq34Ifz89sQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c670f70a37so4445016a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 08:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706633083; x=1707237883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GxeZ8K1V/jOJDYZ0KHs0QWtTyBu4+WNrnObPrwyAINo=;
 b=mC49pg+Ix/BjFY4ebOuhjsjFFaOKdpILcj/7UJkmya5lYeL8xLjb0K8ZEyuisUv1Cq
 R3ORXtH5la1b/Cj1soos/oveztT1e2YEYs1Af4OBDiQu7IxecLDexiA1AtOA51F9YJvy
 ESQ9xPl1maunoZ9KC0eVDSuexOzcuqWW9MgWS70vs3bGa23ntzypgHOUlzgBU5cASTcl
 j2M5goCBlxydob3Sr5qfvnoVi4PwGi1aZ28i55zXzLmC+pdh1yErh7DD1/HFKXec/U72
 wkLf/ranixDsm9b4uB0X1OHd4hXI2se9okE9WV2KvS5Zg/Bxo2NAiFZFJKHLfIcO9/sD
 AfBg==
X-Gm-Message-State: AOJu0Yw9cVktp/VNlnV+/zAd8JXM5Qj+wbVPfbFoNkoHroZVcjH3ZDaY
 ZmW10fSdu5D1grnrzglVHH3igs0ua3ER1MLLwsCl2DJBAyq4AQLWHIRqMwY7c8qFxnVTpgcxdEV
 8DTuPZY9c3tKei8m9ChfwHROeKFZbN/8H2TgEzTCRqM9TMik5bAnh
X-Received: by 2002:a17:902:784c:b0:1d8:f112:ef74 with SMTP id
 e12-20020a170902784c00b001d8f112ef74mr2943054pln.20.1706633083225; 
 Tue, 30 Jan 2024 08:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV1XsXzQfkOa1v2ihN6Kp1wGGeU8a/4QElTTA3IRncjnYAnqR1rK8y7+65vwt/mEU3jOaYzA==
X-Received: by 2002:a17:902:784c:b0:1d8:f112:ef74 with SMTP id
 e12-20020a170902784c00b001d8f112ef74mr2943039pln.20.1706633082917; 
 Tue, 30 Jan 2024 08:44:42 -0800 (PST)
Received: from localhost.localdomain ([115.96.128.50])
 by smtp.googlemail.com with ESMTPSA id
 ml8-20020a17090334c800b001d8fb16118csm2400507plb.267.2024.01.30.08.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 08:44:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
Date: Tue, 30 Jan 2024 22:14:28 +0530
Message-ID: <20240130164428.35955-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
enabled in the kernel. QEMU has been tested to correctly boot a linux guest
with 1728 vcpus both with edk2 and seabios firmwares. So bump up the max_cpus
value for q35 machines versions 9 and newer to 1728. Q35 machines versions
8.2 and older continue to support 1024 maximum vcpus as before for
compatibility.

If KVM is not able to support the specified number of vcpus, QEMU would
return the following error messages:

$ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f43d5142b8..bfa627a70b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
-    m->max_cpus = 1024;
+    m->max_cpus = 1728;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -396,6 +396,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
 {
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
+    m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
 }
-- 
2.42.0


