Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD9CFD2F5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBV1-0007k9-Ui; Fri, 11 Oct 2024 04:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBUx-0007jk-0d
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBUp-0008Ip-Tx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728637179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pffMq5HlyyQSLR32u36d0WlErfpMZsApxMOlecv7nh0=;
 b=fuTNhMZa0IiBMgK86Ch03p3j482dydFnuuR5+inZPh9AomuzSUnzBfUQp+DHxVqC4xHt0L
 b0j5MFSnSqa9gzIm3Twvqhz8tbApNmzbf6ccNAyQgAKt2XjmmbV7+OrQrqZR+3GlauVXzQ
 4gJLt3ZO1zEjH7Mn/7hHrE7865x+lDQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-NoUyWImmO_2suPMjpUdjDA-1; Fri, 11 Oct 2024 04:59:37 -0400
X-MC-Unique: NoUyWImmO_2suPMjpUdjDA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a994e6c8244so123365666b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728637176; x=1729241976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pffMq5HlyyQSLR32u36d0WlErfpMZsApxMOlecv7nh0=;
 b=Ap3CDelBS4XO6AsIThgRyWaDbggB0Z/IqRsRuu7VBH7zTqzVlmtsnjuQfnvVN8BoQz
 NVRdeBtsrx6D4IXiMgC4OajWaKyBhs+iJIec8II7nL0GeW4ZWnrZ/IExuYeoWwGZ0Kby
 60Sfooj7n7d7mjtYlzDa84m+1TcW/Fvqgzkoht5C3SSZOcm7EJnt1aJ/T7bJuhN23Rbc
 olFi3eeaPxQrYL4vUVYlQid3mIghDnF33CQRVXCDphNQGeoB2S6VUhJ53vPnBLTaGydu
 KXdzn0HeR0Kf9M9OCPdhECWAVTMX9r+hLbPL8aT9QSWLPs1qAFMDlC/OfsqS7s9jPsoi
 PNbA==
X-Gm-Message-State: AOJu0YxhP7sv5ulLReFdtNbf0SV/R8zF7fwINORrbwYO7QdjALCY8VE2
 plWC1+O/qG2IhpmfrgWPkE2kUdZ3lVRRarVIBsK8lLxHBLpQMSsp0p1I3VYzF6ga3Z0kHttKRtf
 UzcfQ89E4t5VvBgbnwWBsoovK9/fK+Gcft+mBg9ofa9WYiEshOaY+AnOo19npHtQTynWuUdwm1i
 bvIitmnBVrX7rF/+Eh2kvA7HSx0xt7wEO7oOv7TvQ=
X-Received: by 2002:a17:907:d5a8:b0:a99:36fa:9575 with SMTP id
 a640c23a62f3a-a99b93ca377mr150750666b.32.1728637176055; 
 Fri, 11 Oct 2024 01:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHotiixSOgu0+XIcDa9SGzndsQXI9WuJxAfTsOxKTRoa4uKEbAvD3aodi2spJXDHXumE/A7g==
X-Received: by 2002:a17:907:d5a8:b0:a99:36fa:9575 with SMTP id
 a640c23a62f3a-a99b93ca377mr150748466b.32.1728637175602; 
 Fri, 11 Oct 2024 01:59:35 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99c0c89bfasm24070966b.162.2024.10.11.01.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 01:59:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: erbse.13@gmx.de
Subject: [PATCH] accel/kvm: check for KVM_CAP_MULTI_ADDRESS_SPACE on vm
Date: Fri, 11 Oct 2024 10:59:33 +0200
Message-ID: <20241011085933.25760-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

KVM_CAP_MULTI_ADDRESS_SPACE used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, the number of address spaces
can vary by VM type.

Query the extension on the VM level instead of on the KVM level.

Inspired by an analogous patch by Tom Dohrmann.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8be731cfeed..4287e254df8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2618,12 +2618,6 @@ static int kvm_init(MachineState *ms)
         s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
-    s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-    if (s->nr_as <= 1) {
-        s->nr_as = 1;
-    }
-    s->as = g_new0(struct KVMAs, s->nr_as);
-
     type = find_kvm_machine_type(ms);
     if (type < 0) {
         ret = -EINVAL;
@@ -2637,6 +2631,12 @@ static int kvm_init(MachineState *ms)
 
     s->vmfd = ret;
 
+    s->nr_as = kvm_vm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
+    if (s->nr_as <= 1) {
+        s->nr_as = 1;
+    }
+    s->as = g_new0(struct KVMAs, s->nr_as);
+
     /* check the vcpu limits */
     soft_vcpus_limit = kvm_recommended_vcpus(s);
     hard_vcpus_limit = kvm_max_vcpus(s);
-- 
2.46.2


