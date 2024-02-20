Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D672EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSGH-0003Fc-Ov; Tue, 20 Feb 2024 10:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcSGC-0003FR-54
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcSGA-00019y-5W
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708443736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SSLdFxG3HoFwMkYCcqEKJGeeVNAi2EULDymLMtF1B6E=;
 b=PkFT14noLtdmC2ykuDnuiK91923OS3RXE2Se1zZxy9qQTtUKWgW1YZhAOyntrQOZC6meWt
 lLG9LLdx4ENowzk5tUz/BOJvyjR+jtvNtPsuF6JhRrIEyISmUYvgR3uBDj/hGNlis8UeGX
 Pf8ANIxK24iyNVUJPjYNmskm1WeQ+uA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-HhWWLfvfNlSO22H0ZqX6fw-1; Tue, 20 Feb 2024 10:42:14 -0500
X-MC-Unique: HhWWLfvfNlSO22H0ZqX6fw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59a38af7ea6so6536619eaf.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708443734; x=1709048534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSLdFxG3HoFwMkYCcqEKJGeeVNAi2EULDymLMtF1B6E=;
 b=pfcs07FNDtiAmXlSk/ZqPB1TECT6OEzXW7IgYsqC29cJ3Py7Fn29LvQqK3MNmv6eKg
 8Zl2wo85GD1/8CN9ipphq4MuCQjKSGZZEp55Ta3FZClv48LY72juM8LwZacXZoFOnTOx
 oHgTaICRrrwDbw8o4vJ89LhQabLmThG2hofRkNZ4MWHRhIK9+ejmj7Qck0ozLqi761FY
 bas9KMVhGxhONkl5NjOMz12HWymrRj7nzJ/CrQDOOsvtMk4WoMjzaAbxQj6MPRm7LZSr
 DwKhmr9BljSGs7C1KD5AGHq/Cz9a12Dw0+32lOoquVJOuQVY0d4CVrLkU/N0ExCk7wdK
 sQOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8C4hUgd2TC4SHuSqPkuQrisQoW1W9CxcWiICfOdjGd6X2JdOeuoMyMabVTmt43id/BrBBkCxgLmGWWQINvltSVbYpGuI=
X-Gm-Message-State: AOJu0Yw1DYspT9SV6suZCR6asVI7H0s/2U4KPnq9FPhxQOGo+QhuP+RY
 vnTxoqYVDHeqACrcDbU6lrWHLU8HCDNMR7TwZNQTGpIIilRpvLnUR9GfX1lPVQaSmLfhGxh7GQd
 NHa0iJdBZkvPBOOzBWEFvXVX7vlI0sY51Qxo5WVHKwCy422nTWuIb
X-Received: by 2002:a05:6358:f485:b0:17a:e627:9012 with SMTP id
 ku5-20020a056358f48500b0017ae6279012mr16845720rwb.19.1708443733954; 
 Tue, 20 Feb 2024 07:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFULnw5L4FlkZ4yzsTBZ26of+obzA/omVYUR40vDa6iFoaptRN6RVH6Fy7zhMhYi2zjhUBNzw==
X-Received: by 2002:a05:6358:f485:b0:17a:e627:9012 with SMTP id
 ku5-20020a056358f48500b0017ae6279012mr16845694rwb.19.1708443733603; 
 Tue, 20 Feb 2024 07:42:13 -0800 (PST)
Received: from localhost.localdomain ([203.163.244.72])
 by smtp.googlemail.com with ESMTPSA id
 18-20020a631052000000b005d553239b16sm6738702pgq.20.2024.02.20.07.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 07:42:13 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3] pc: q35: Bump max_cpus to 4096 vcpus
Date: Tue, 20 Feb 2024 21:12:04 +0530
Message-ID: <20240220154204.29676-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
enabled in the kernel. At present, QEMU has been tested to correctly boot a
linux guest with 4096 vcpus both with edk2 and seabios firmwares.
So bump up the value max_cpus to 4096 for q35 machines versions 9 and newer.
Q35 machines versions 8.2 and older continue to support 1024 maximum vcpus
as before for compatibility reasons.

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
Cc: kraxel@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:
v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
See RH Jira: https://issues.redhat.com/browse/RHEL-22202

v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
the commit description.

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d346fa3b1d..ae60e6b919 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -366,7 +366,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
-    m->max_cpus = 1024;
+    m->max_cpus = 4096;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -387,6 +387,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
 {
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
+    m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
 }
-- 
2.42.0


