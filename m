Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbq-0002cg-Jv; Tue, 12 Mar 2024 18:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbS-0001DF-55
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbQ-0004Vn-An
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etBZs3HX2lGuBR1hbVUB0rO/sMf1IGM8GxytboDqRdM=;
 b=O1/1AcEyI9TRYBPOepTRs1L8Wnry4vD8MS8OMnWnZsXeKtkzv2wM8Sw66WqxhhODjw9a4m
 bOeXgf1S36VF5tsHYk8u410f90nlF2feWRfPoqgj6FNkT7XEJwAzxCYYWd/10SRe3oVjYy
 rZKHFSx28uRo0OlGs8y0HGrfZiR2S5g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-GzzxZA9xPHmCU2_lKKWONA-1; Tue, 12 Mar 2024 18:28:06 -0400
X-MC-Unique: GzzxZA9xPHmCU2_lKKWONA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513c65ffba5so471443e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282484; x=1710887284;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etBZs3HX2lGuBR1hbVUB0rO/sMf1IGM8GxytboDqRdM=;
 b=v8eGxFmZktfUtYCs4oqlGRYqrOauRWVhlKdJCHm95ht9lq7IVEyojfEPJ0KzWq47J/
 LAuB+gfh3kq9FcZWNfYPheBviSjuoqQa5LVLTwdDiHfJginw9E7hyWZ6Sg9Jg9IAJdeD
 Sf5sfhmM0APTTXJ9y16voJHGKDWnsX2abjlm8juTZyaGUYWqpKHm0MMBlPBO1K9Wune7
 hJGEnMmmy18i1+xKMzTUBlv6Ei7XZ351s0WDuDuLQ8B4wECXlIxrFETssIUUb3KX3Axi
 GHvkE0rDebrEDanBs+7n08FKD8tYvCmyJIW9arDPXj3o4w+u/Wd22RbEUWWYPMJ2E+NO
 bEww==
X-Gm-Message-State: AOJu0Yz4KLMhP2tF9GYyY9fgKH7Eln5HWyuvQkYfeor9xz7t/W0y8X6y
 mtyk8MyilzCM62euhKHvJHvzGhP64M7wh9LTAZnI3F9XTKwvf9tkqAOGE+wVQei56M1iDAPCCuG
 T2ww1Vg7ICoW2Ge5TL5xPf1SM1jsn0vZdyJz9M0XupY97so8yLNHrd8xx7SLFeEq7tz1e6wlpd5
 ZuHShOMl8Fr5joX51VaaF2N7tMJSvgt48M
X-Received: by 2002:a2e:731a:0:b0:2d2:869a:55af with SMTP id
 o26-20020a2e731a000000b002d2869a55afmr1159329ljc.17.1710282483747; 
 Tue, 12 Mar 2024 15:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSFqKvR2UcFJXgi5mGcjFeYUWNfakFoXm8r2jVygLNu+yNQcChYg+JznZMhc4eaNfM6rgQiQ==
X-Received: by 2002:a2e:731a:0:b0:2d2:869a:55af with SMTP id
 o26-20020a2e731a000000b002d2869a55afmr1159305ljc.17.1710282483136; 
 Tue, 12 Mar 2024 15:28:03 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 f8-20020a056402004800b00568550a0762sm2805946edu.6.2024.03.12.15.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:02 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, kraxel@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 47/68] pc: q35: Bump max_cpus to 4096 vcpus
Message-ID: <e4e98c7eebfab0f844784cdf5c108bb3d60ac9a2.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Ani Sinha <anisinha@redhat.com>

Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
Linux kernel can support upto a maximum number of 4096 vcpus when MAXSMP is
enabled in the kernel. At present, QEMU has been tested to correctly boot a
linux guest with 4096 vcpus using the current edk2 upstream master branch that
has the fixes corresponding to the following two PRs:

https://github.com/tianocore/edk2/pull/5410
https://github.com/tianocore/edk2/pull/5418

The changes merged into edk2 with the above PRs will be in the upcoming 2024-05
release. With current seabios firmware, it boots fine with 4096 vcpus already.
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240228143351.3967-1-anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 45a4102e75..df63a92b78 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -350,7 +350,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
-    m->max_cpus = 1024;
+    m->max_cpus = 4096;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -371,6 +371,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
 {
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
+    m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
 }
-- 
MST


