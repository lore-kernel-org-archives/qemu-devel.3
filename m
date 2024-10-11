Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E16CFD2FD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBVD-0007lo-Rt; Fri, 11 Oct 2024 05:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBV5-0007kd-Fc
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBV2-0008Jf-6Z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728637191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XeVedSaUox6qACtW8EJ28JkUgbK5wJIqAzjoh6ebcek=;
 b=NhfJwcLXuPpsyD6Gvg3GlHnqK7mg4DX4w6ChYVUiwLgml90GSjBMqMT6B21z6nfZhgkwUi
 pSQ7AAojFmyWQT8VHWSnTgFFZCUYaM3TrPgBSKOy8rZBXVaLD8OlNvGuNFFJOwdicx0HeR
 WFxjHBQc5GiYEBYiVc4lcyqfsv4uCPo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-8zpnXa8_MueLSkfNV8uPZg-1; Fri, 11 Oct 2024 04:59:49 -0400
X-MC-Unique: 8zpnXa8_MueLSkfNV8uPZg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c93479b1dcso1287580a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728637188; x=1729241988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XeVedSaUox6qACtW8EJ28JkUgbK5wJIqAzjoh6ebcek=;
 b=tezHKNhgwC1EoAfkxii6xmXGOabIAM36W9Vhiv/n0EU8X7XM0daaixnTVixMceJXZO
 /t0T3uoRg5q1nn3uej8EncjUavZsXoe49X70CuVmD0NbsJgZUDyisy7A8U7PX48Pu0S4
 bk1kpDfh5CBFA2ko/GJT0vx0BelqaTslCuDhJYuc15XmndWQ1JZe8W1L7HIH7FX0iLOq
 z6b70MQAGLEpLpHetBym7EltVIALdvCPwKM8KJUH6YvQOgopHbOz06ya9brIEsOYlQT+
 kNTRqKKQR2vbCj6e62apqrVOuRRDC25bXfqXt5QINoNYRnyax7IkiJd1T+wLueGpXtKt
 fFHg==
X-Gm-Message-State: AOJu0YyyoK4kQpwd/6lx6vRy+tJFSCFVnRmqN1H7oakJHLZPAExpHp3a
 VRyrwcSg6s/l0bgtQTFJUV6bpCccQYS3mb/mj2HvwVQozJeXB+gHKOsrrAz3R3yXLy8hthr7VZA
 pKjpgqYgCpE517PYh+7mkyqdlRAAfcf6FIOJSIJVzQ0wkmHj9isM3ur22K3vRAF5RXSh+WkgWxP
 7xC8EyBl/IR8vqV1jgwBqHa6IU11mVoyUW3JBB1vw=
X-Received: by 2002:a17:906:c14c:b0:a99:435c:89f2 with SMTP id
 a640c23a62f3a-a99b95f5f72mr184633366b.63.1728637187733; 
 Fri, 11 Oct 2024 01:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAu9vxzWaI+gDIbQ1AVvPP+ep+9xwQ0ezCRMHhUbnRmXfATiRm2D4hNC1Jkjdj0/iPsVvQSA==
X-Received: by 2002:a17:906:c14c:b0:a99:435c:89f2 with SMTP id
 a640c23a62f3a-a99b95f5f72mr184631466b.63.1728637187303; 
 Fri, 11 Oct 2024 01:59:47 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f266e8sm189152466b.63.2024.10.11.01.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 01:59:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: erbse.13@gmx.de
Subject: [PATCH] accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm
Date: Fri, 11 Oct 2024 10:59:44 +0200
Message-ID: <20241011085944.25815-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The exact set of available memory attributes can vary by VM.  In the
future it might vary depending on enabled capabilities, too.  Query the
extension on the VM level instead of on the KVM level, and only after
architecture-specific initialization.

Inspired by an analogous patch by Tom Dohrmann.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4287e254df8..482c5b24cf6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2604,12 +2604,6 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
-    kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
-    kvm_guest_memfd_supported =
-        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
-
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
     s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
@@ -2723,6 +2717,12 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
+    kvm_guest_memfd_supported =
+        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
+        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
-- 
2.46.2


