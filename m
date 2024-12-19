Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIy-00039z-Nr; Thu, 19 Dec 2024 11:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiX-00039N-FB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiV-0002MU-Oj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqf6k3q8q/B0Mm1igt69ERgmFOVdeWHaULQ4Xn6JpyI=;
 b=NEs4p9zxMMltA1QLhVYk3OtDj+mQZwYED6e60QtucBFyjY54QJ47Ngzx4tSsBxmcjTJbiA
 U7gYsXCekDxJPdNkXJO6Xr7EqUuIp8EQ+WOVwxbej9D3qopFDv3Y2D/1snCZGpGdxAnMb9
 qv7hkwGx31YH1W8EOx3mDa7tCL4B0j0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-yNVKgkm1ORSzGcXJr0k1pQ-1; Thu, 19 Dec 2024 09:41:29 -0500
X-MC-Unique: yNVKgkm1ORSzGcXJr0k1pQ-1
X-Mimecast-MFC-AGG-ID: yNVKgkm1ORSzGcXJr0k1pQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso527216f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619288; x=1735224088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqf6k3q8q/B0Mm1igt69ERgmFOVdeWHaULQ4Xn6JpyI=;
 b=FQnWZwgbr5oWo41c5BMkGyNUiSWHMFlxE1BCtXVsgLH935KjknBVTlUWIv2mD0+qYE
 Y2xx1nY+eGZBcoX1ucOsASgfs3hWZ9I9lltt66hdTjQeiafEgWF6aWQH0JpVw8bse+EJ
 X+hftZISTCiH1LRaCpAitf/JeZjqe1s6AWK70fPcxXd8IdeEdCfjaLqt/Mdfyc7YslOU
 6PDQTCXzjGaQjuUA9TcRtQ5K5IlQ5Dvxta6ESGc+2IddjKMD3zkQyADZwqTo2H6ofXjv
 d+VAJ6V9yzGhRsJO3AftHfyCRVedYdPo96AZ3u/JxSYi507ePREfhjHAy0B8pxAcIG09
 wtYA==
X-Gm-Message-State: AOJu0YyaMsbJmcf3mhM9yzfldkBx+JYHOJXy60KbUBDR1emkkWdtrByK
 kiefLbnGq5XkVndfNpaRVuruea1bazRnYX8rViTmhq8Rz39cxLiZvmgRfLpxGzlCoae1gZu+gR9
 Ze8yRi1TKSgyKWVacs80EovY5vhAcVASekZR1yKBvXDuYQY4EcFYoWJo5Y4QvdT/PCpTyM0em8i
 Qni4ioziL2bjDpb8aJsiZb1IV6pSqywvSUtaw=
X-Gm-Gg: ASbGncssUvppoyevct1Qm36ukPqQs3xWuTeK9O+s0g8DKwQQyA09S58/JHMFlErVpfJ
 yw1Mw8cwFeZ+mI6sgOBz36Uo9BPFd6i0G3kA2acQCkBolViih3xvJrCdNUdb6E8W66tw5Vu9CiV
 VQmAQ7pXR6D1dWgbCzrDvsRg1cShjac+aMElQ1u4rY8fFYXpA+FX2g3kG4H/weyD6fTprTd1f4p
 foVjp+V9Y9FmpYpTyqv30GhWgUB2QGGgyuW8iEWG2x5gSJbyPqANGKqyO6UcyDZLUlv/mAgm10r
 HmAaI1cBcu8xCXJVNcR8WzCRGBPyeYM14wffAIyu
X-Received: by 2002:a05:6000:1562:b0:385:f840:e630 with SMTP id
 ffacd0b85a97d-388e4d8fd68mr6787335f8f.37.1734619288626; 
 Thu, 19 Dec 2024 06:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1pFzKjK+Z3mlcpD9cWIgAME8vSq/yi4VXzTxd+oWhVs8nWtj31upZLqkHDQHyZm4jIP/5sg==
X-Received: by 2002:a05:6000:1562:b0:385:f840:e630 with SMTP id
 ffacd0b85a97d-388e4d8fd68mr6787297f8f.37.1734619288219; 
 Thu, 19 Dec 2024 06:41:28 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4366128a44fsm19546165e9.43.2024.12.19.06.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:27 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/14] s390x: rename s390-virtio-hcall* to s390-hypercall*
Date: Thu, 19 Dec 2024 15:41:05 +0100
Message-ID: <20241219144115.2820241-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
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
index d6c8c33915..e344a3bd8c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -29,7 +29,7 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
   's390-virtio-ccw.c',
-  's390-virtio-hcall.c',
+  's390-hypercall.c',
 ))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
 s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
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
index 508403609f..7a3e1a8e1e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,7 +49,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
 #include CONFIG_DEVICES
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 2b4310003b..b726a95352 100644
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


