Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F62C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfL0h-0007pR-IA; Wed, 28 Feb 2024 09:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfL0e-0007nS-Iu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfL0c-0000HY-P5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709130849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L9OD4D/YiliLw5BOpagMLvx6fzTv2Bm/GpDbaMLCoe4=;
 b=HsOw54mK5I2d6NX3NDMtQEM4JwJwkNBEhuYxqXzR6jXkjwhFCYxS6ex1dk9UivBISJ5U7i
 4W7oneB8nOKbuNup6VfmGD6FJdUie68wlhsEfzw5aYolmROiR+cScWICtnWSLBr/VpNAMa
 xH5cP/OPeyfdzugYQHlYh6A7e5yYmn4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-_2WSJyvtOee0wvUgBX8CMw-1; Wed, 28 Feb 2024 09:34:08 -0500
X-MC-Unique: _2WSJyvtOee0wvUgBX8CMw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299783294a6so4720463a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 06:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709130846; x=1709735646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9OD4D/YiliLw5BOpagMLvx6fzTv2Bm/GpDbaMLCoe4=;
 b=LiAw3k6/s8Rz9O1BgJI2g+CpBslYQu1OwF569rnjwnb7uqTly/WuJJm+kju8ZH6mnR
 gseGHtMKXRiNhagaPmpYF3mUi4kVQ5phqDe8vwx9WJDGTuci+IeiJIURr6r9wv2jxcHm
 3za/Q0IW41K8z8/PUfdwehkhRv9uSjIU4gW9lgDQHjano7/SjjE/9TTSGd8ETIqfvGY3
 BaUw9OiQ/OfLeLjB5HPHWDRu24KsdEbTXUVd9sx1q+tMzlKkU1kKTng5qkRM17uywy7m
 PvGpaQT0Mzuam6QLo+CzSLGvWy81px0VnYLBaMz/FXxXDMTw28hFADnDs1G/AnpMa/J6
 /lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnGpe4x5x3FWxWAezqkE7EB/m3BZ+JcoObIsvfPd5/dsN8dtPjWCxJBylc3EEHbrNNMR0nL5uBrbeChAaCB5AUn4NqIqA=
X-Gm-Message-State: AOJu0Yxo2yDxKvP0XA7qES4xdlvaYpbtObxvy4zmmALjZ0yX4zjFQMYW
 cPN04pHh6O27/Smfcz7PO/qXoC5wMQJmBQrpN7edUiwnRj+0+Q3QhPWjBSvYzcDUjwSpDXJTg49
 agQGtpieKKbVnn44qEAvCbENT8Qeg3GmF3oUgC6uO/3xupzxHPoFh
X-Received: by 2002:a17:90a:6546:b0:29a:5ed9:eca1 with SMTP id
 f6-20020a17090a654600b0029a5ed9eca1mr10360451pjs.41.1709130846046; 
 Wed, 28 Feb 2024 06:34:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbKsY5NOmXUVBuReJn5WfZqNbsikJ1fzyqlNJNRRgr4HF16n+2MhkzXDRjPN9VMcyCNrpXwA==
X-Received: by 2002:a17:90a:6546:b0:29a:5ed9:eca1 with SMTP id
 f6-20020a17090a654600b0029a5ed9eca1mr10360424pjs.41.1709130845636; 
 Wed, 28 Feb 2024 06:34:05 -0800 (PST)
Received: from localhost.localdomain ([115.96.143.215])
 by smtp.googlemail.com with ESMTPSA id
 gb15-20020a17090b060f00b0029933f5b45dsm1702703pjb.13.2024.02.28.06.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 06:34:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5] pc: q35: Bump max_cpus to 4096 vcpus
Date: Wed, 28 Feb 2024 20:03:51 +0530
Message-ID: <20240228143351.3967-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:
v5: mention the PRs in the commit message. Add tags.
v4: tweaked commit message as per suggestion from danpb explicitly
stating that 4096 vcpus work with edk2 fixes that are going to be
available in the coming edk2 release.
v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
See RH Jira: https://issues.redhat.com/browse/RHEL-22202
v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
the commit description.

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
2.42.0


