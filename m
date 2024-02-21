Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBEBC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTy-0008Nb-MW; Wed, 21 Feb 2024 10:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcoMF-0000wk-HR
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcnBK-0005Yp-UO
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708524161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y6iw8XepdJmDZz9eEo/RYpCiBHA+F75egkY5KCzIztE=;
 b=KBvLoDY5e+omvt0GvQUF99bMcXCX/y+LHHnTK6u1BL5dCZSUMFHSaRWZwMJc4+ritJ9D/A
 o+vxt+91JdedWIIngtAHuyr/NRYn7PejnekChIzy7IsnPMLIPVSmg+R0D7Jp0zSMzz05gN
 NMizXxzIFB7tegkPgrgVGhgRCatIHY0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-k6Im3es0MU-B0u0pILIpwA-1; Wed, 21 Feb 2024 09:02:40 -0500
X-MC-Unique: k6Im3es0MU-B0u0pILIpwA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ca5b61c841so4125270a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708524157; x=1709128957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6iw8XepdJmDZz9eEo/RYpCiBHA+F75egkY5KCzIztE=;
 b=PNtAzPo4yHGYmN6lKJeVvaNCnLkqG2XlKJPJID7N4WHJJbxmJoeg31QF6r2Vo+zY8J
 e84TTi1drkZ65W8zxPdErDTePKwx49HbGSRquX5HmzAq9bKKOQUvXaGcCtJQxW0GwU89
 60PlPqRSQFsiQt5Yz/6leu0LowjpPej9uHfuJ2Tan26nBLrTt/AxkHpwhHE2WfMf43FH
 UVn5MdjjfHJnHHct9kHqOjI/iGWm052e+hmNW2tFdHG5On9QChjq40SIeUXmTcqZN6W3
 vZmZR3YBrZMTVUtJDd7lqWqQhVsIGCeNGhowh18pN2/3MaZkPLTqcom/3AZBcBuRJ0Zj
 sMJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ3iRJoknFTd6uJNh4/zJwkT34+CkdDobicYcapx3U7GiD/aW0mGVVIa6n55DBuTxLZ9k3hrLfkb//KHp68ZLqV0aekgI=
X-Gm-Message-State: AOJu0YymuEJccqAO+ekyjn3wlJihKZY10TPUZSvRsgtH8rlv9A7U6/ld
 ygUbWqV7sic8kSES6UvP+EEkvUkqsm116C91sxCbi+ORvFmJqtQ2U/YCJOYNVJLRIWtWNjxoJjr
 w7aLwmj+pE0vsx6FqKz86ShduP65H+Emy0pyx+XOZy+kkrEwnkzDY
X-Received: by 2002:a17:90a:4414:b0:298:eacc:682f with SMTP id
 s20-20020a17090a441400b00298eacc682fmr18411351pjg.34.1708524157246; 
 Wed, 21 Feb 2024 06:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbo8t1QOkq7TLIbTNSMeF7bk7ZBr4F1C7psgu5rbaVKCxQagbO7ACimN2VMcUiXlYHWsHdWQ==
X-Received: by 2002:a17:90a:4414:b0:298:eacc:682f with SMTP id
 s20-20020a17090a441400b00298eacc682fmr18411300pjg.34.1708524156817; 
 Wed, 21 Feb 2024 06:02:36 -0800 (PST)
Received: from localhost.localdomain ([115.96.143.141])
 by smtp.googlemail.com with ESMTPSA id
 w6-20020a17090a6b8600b00298f2ad430csm10571935pjj.0.2024.02.21.06.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 06:02:36 -0800 (PST)
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
Subject: [PATCH v4] pc: q35: Bump max_cpus to 4096 vcpus
Date: Wed, 21 Feb 2024 19:32:27 +0530
Message-ID: <20240221140227.3886-1-anisinha@redhat.com>
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
linux guest with 4096 vcpus with edk2 pending various upstream EDK2 fixes
which will probably be in the 2024-05 release to be released in the coming
months. With current seabios firmware, it boots fine with 4096 vcpus already.
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
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:
v4: tweaked commit message as per suggestion from danpb explicitly
stating that 4096 vcpus work with edk2 fixes that are going to be
available in the coming edk2 release.
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


