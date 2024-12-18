Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5F3E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhI-0000dr-Ca; Wed, 18 Dec 2024 05:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhF-0000dd-W4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhE-0006n2-6j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zvokl2JFZjrf2TkNRlzgYIlGm36Z91ZjxT6UTdHIqvs=;
 b=QCKeEICib9Fdroke1YGnFp53+yKTF6Ec86sbgUCVn2OlHtRtVntfB7vzqxLpjysX+JTpBA
 AZc4wwdLeT4H3/KCMNtSGvlIbN49KSmHtfm/qzm9g9hgrZKJDlOW0O9UP7rC96TMaXq1q9
 3+rLld0wRHenzaex+oPygK0ReaZUBR8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-HabVR3UzPQq-p0f9FJb9vQ-1; Wed, 18 Dec 2024 05:53:20 -0500
X-MC-Unique: HabVR3UzPQq-p0f9FJb9vQ-1
X-Mimecast-MFC-AGG-ID: HabVR3UzPQq-p0f9FJb9vQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e9c698e7so362679f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519199; x=1735123999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zvokl2JFZjrf2TkNRlzgYIlGm36Z91ZjxT6UTdHIqvs=;
 b=BRSArODTVQQywPL/FldAG7UWpCzaBpAnsUgmmT/YjTwRPRPW6exj9Hj6IIbOMW4cB1
 7P35JZv3dJqL9nhROvtSAwZuMTKfiCMr+tXDnarmfolBOrh70uXRBmpPxUzoa47RlMZy
 DM8Yi0+H8hX+Eq5gMEGvbYa9Hc30i247Ce3pQD67qQhW98lnA25g8uAaDrhrAZTgY3rq
 JZsLLmNnDxzzPB/wyzkj/XZKiuJwrsqb7be7xz7/hjJlntVP/Q4JXezetW6PckMtXIfy
 U9KZ7b8jn0+OGhQeNJZBnrW/a7dT6S/OyM3IhZPIN4CnKO91zw1nc+Y88tGsK2ebgaB/
 +pag==
X-Gm-Message-State: AOJu0Yy4ZjUGALV96N1aKGPT5lMr32IBqN/6CtWVm8hFSA5EWUw572W4
 eUO0rA2TzDInw+tfNpe2t0/eEouBl6VKz9L7LPKhkyFwDqtLJcDtWh6dC562fMxYyWY86cr7Phy
 OelBFMzfRfiarsFBTLW/n+S6qyD/LWYbG8uNQuhibgtgPzVBnHdZnu/8ZDsEi5vZZiRbbQQFubu
 FNt9dBpS4jzeErUNsN4dbJbLork31t0nTje3I=
X-Gm-Gg: ASbGncvlUGVCRWC+XRoeyFo9gCu2Jdx63RQU+Nh6TeQR4eXKH85PrdoUOiba4HQBMhy
 0RqVof3C405qGEhKpO1htcnFsvo5J9SUPvA5WTY+pKY/yhGTBNb9pv0gaikmh3Xd9l40Lz1O7B8
 m5UctyGyRiW8cXXMNoaOYOdW08VT1nSOM1y+FVaWmjff9PX319eN97Bw/zrIODoVe+PsuzLE+kX
 0NzvxrTQ+hYDfBHuOeKoWCJo+rph0Lonb+KbdraOMkUZBXLeWxBpcxbT4bESMZYjxyWiXSk8kMD
 SJ66oaA0duSwJux1lVk0/I4A/3Iy0G+QmSVkzt33GQ==
X-Received: by 2002:a05:6000:1ac8:b0:385:e95b:bb46 with SMTP id
 ffacd0b85a97d-388e4e79255mr1488520f8f.22.1734519199113; 
 Wed, 18 Dec 2024 02:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEngxYrOZ9O8x5obWISSGDHmBHNXG7U1bKMTOcXzBMprW2ys74s+PRO4w+pQACLPWt8wRpVA==
X-Received: by 2002:a05:6000:1ac8:b0:385:e95b:bb46 with SMTP id
 ffacd0b85a97d-388e4e79255mr1488495f8f.22.1734519198770; 
 Wed, 18 Dec 2024 02:53:18 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-388c80473c6sm13910919f8f.80.2024.12.18.02.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:17 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 05/15] s390x: rename s390-virtio-hcall* to s390-hypercall*
Date: Wed, 18 Dec 2024 11:52:53 +0100
Message-ID: <20241218105303.1966303-6-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's make it clearer that we are talking about general
QEMU/KVM-specific hypercalls.

Message-ID: <20241008105455.2302628-5-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/meson.build                               | 2 +-
 hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} | 2 +-
 hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} | 6 +++---
 target/s390x/kvm/kvm.c                             | 2 +-
 target/s390x/tcg/misc_helper.c                     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} (97%)
 rename hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} (86%)

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 482fd13420..71ec747f4c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -12,7 +12,7 @@ s390x_ss.add(files(
   's390-pci-inst.c',
   's390-skeys.c',
   's390-stattrib.c',
-  's390-virtio-hcall.c',
+  's390-hypercall.c',
   'sclp.c',
   'sclpcpu.c',
   'sclpquiesce.c',
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-hypercall.c
similarity index 97%
rename from hw/s390x/s390-virtio-hcall.c
rename to hw/s390x/s390-hypercall.c
index 5fb78a719e..f816c2b1ef 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/boards.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-hypercall.h
similarity index 86%
rename from hw/s390x/s390-virtio-hcall.h
rename to hw/s390x/s390-hypercall.h
index dca456b926..2fa81dbfdd 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -9,8 +9,8 @@
  * directory.
  */
 
-#ifndef HW_S390_VIRTIO_HCALL_H
-#define HW_S390_VIRTIO_HCALL_H
+#ifndef HW_S390_HYPERCALL_H
+#define HW_S390_HYPERCALL_H
 
 #include "cpu.h"
 
@@ -21,4 +21,4 @@
 
 void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
-#endif /* HW_S390_VIRTIO_HCALL_H */
+#endif /* HW_S390_HYPERCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 9fbb7db163..7e4bce5337 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,7 +49,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
 
 #define kvm_vm_check_mem_attr(s, attr) \
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 0ab2bf36cf..3732d79185 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -36,7 +36,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
-- 
2.47.1


