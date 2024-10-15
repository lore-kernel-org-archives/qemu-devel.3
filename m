Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382DD216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNp-0007xU-5z; Tue, 15 Oct 2024 10:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNg-0007f7-WF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNf-0003OO-Jg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeVedSaUox6qACtW8EJ28JkUgbK5wJIqAzjoh6ebcek=;
 b=APlVjvTEGJXccC/Gf6Z9DzzrjInwlm7v+ANJ0DmGyf/AWFXO6ZcumXS5q3o5t26n8gPKLA
 9/KtqNj6vbhpPW7kP7HrCCk9OYv2wDQmhh6zhzaIq9Il1c47FjalqvEGLQSuxXv5aYTrNe
 8PBp4lasPhM+MRH/hTQdN8FaIzlKD7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-3dvW4gGTNLSnd-VH4FBHOA-1; Tue, 15 Oct 2024 10:18:32 -0400
X-MC-Unique: 3dvW4gGTNLSnd-VH4FBHOA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so1876054f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001911; x=1729606711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeVedSaUox6qACtW8EJ28JkUgbK5wJIqAzjoh6ebcek=;
 b=VmgC9zHtIH2ji8JYf++JkBdPMC7SL5f9wAADv0FgSv/IqVfW3OkzuqX/xTqyMbRNj7
 fpU1TGUStxUDwMp8HT7XaLWlYfE2hx5wVC3ljOqmy/8aVngGlhRLLuZt8ZLekE8U3TJU
 NW9tVisg/cFVt3Cqio6WGdPNg3JUykOLE9jjsFXUuOlDqesue0mjLWZXlYRt+1fbcDMH
 6IkYvsInlM5M8EivhxqYgQoO6/Y1lEhJ/KXNnTVKidOv2sUkIqcv7mkAn5IUoItJ5/6s
 Zzt70siOs4+P3MmJapqwwn7Pw2tKjuZ4RHIWwB0wjB6s8FQFG+6eyIaiSiMCL43N5DM3
 ZTPQ==
X-Gm-Message-State: AOJu0Yw50WzeI3KkQC0/cBpJkB9w9pNKQ1ucGnn6rJHrn7lvXt/3EZjn
 /kMdOfKiJtHgeRrz3D4fZW0oTxmQ8tWNY02+K2lmK2EBOngtLG4nOzO5+1LaI+w9njK+ddExnj2
 YazYaWG06DIW4ks86ix2loestv9JwTKUuhpGpO+K98LbYeo3pH85hU59J6JpKZrqUIq6gcgJ/x3
 55S2L1fFhqNEL4VZR55MASUUyjxUvrqvo+Jc1/yYY=
X-Received: by 2002:adf:eb11:0:b0:37d:53a7:a635 with SMTP id
 ffacd0b85a97d-37d86d6f26bmr364177f8f.51.1729001911053; 
 Tue, 15 Oct 2024 07:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe2Y9IyefHzCuHiZoRS/NTtqO5M1M6IZ/m9ab222ydF7y6UolyPpxcXfh0RMKlYlVIvDaXJw==
X-Received: by 2002:adf:eb11:0:b0:37d:53a7:a635 with SMTP id
 ffacd0b85a97d-37d86d6f26bmr364157f8f.51.1729001910511; 
 Tue, 15 Oct 2024 07:18:30 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b3362sm19086145e9.38.2024.10.15.07.18.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm
Date: Tue, 15 Oct 2024 16:17:09 +0200
Message-ID: <20241015141711.528342-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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


