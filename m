Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E6FC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMm-0006Fo-MV; Fri, 22 Mar 2024 14:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMi-0006FI-Pz
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMd-0006wg-Hd
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEJ0yKlHrmKhZxiI7OJ9cPT/90ybcJyHoiSWV5zSPBM=;
 b=ShxpxK1ijMJX4QX8Yi30HHt1fUi4YalhneocT4epiHgCUX3wZj3fUguBw23jMqytkTfFy/
 mBiwPeIVRYMzhosYDyh8E3ywsXXg+RpEqmNpPRGXdxtIe9nan90Xl+e8zI6lD24gwzBCW9
 kFmCOEYom+dQrZvYVyz5tEoG+zpO7Hc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-a9XBVqV6N-u7deljmJBvaA-1; Fri, 22 Mar 2024 14:11:33 -0400
X-MC-Unique: a9XBVqV6N-u7deljmJBvaA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4698fc37dfso153813866b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131090; x=1711735890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEJ0yKlHrmKhZxiI7OJ9cPT/90ybcJyHoiSWV5zSPBM=;
 b=feReehN3+la4BMekfeeMMlKftnvomB3pdu7iL4CZupA4uvqZqnY34/cZz4EPY4gWVS
 qwDtTGH5USbV9jyeJONNJl1hWBhYRszcPwinfnizRpwp5utAJH3SGr+RtZzaEgJv4Uht
 mf7r3g0ldjX1ZVu1rAwVdVN9a4RnxEtM8NPw5dUTosmZ6FhwYgLsP5iry2fyx542TQtT
 PCdgSDeTv/0GpiONK+439MWOenkaSUxPSa/wddOielFp1xWjQxPw7UIHYED5lkwzkALE
 8uakVvy2SX2xWQX3+xINADJrvI0UVLwSvPNdlOp18Z91oq/L57IiCgANC3iLMygAvpwK
 CxFA==
X-Gm-Message-State: AOJu0Yyrr2diD6n0XjWIY2nhsbpSyW97a/F9upButS3Nzb4AtE7DPQic
 3bz7GIifZrvu/VcBHux9llgUkdOiVKFqugRPIfm2QEOGvFefD48LSBjaJf+EuG6omrslmUpa+f6
 +zEK/A4gMuI5unjLSUabSik0da+D5AB8Jyn368YRQFHOb+HItuxUVMz4Eydb0D+H2csLzPt0fDM
 Bo0x5nw07TFbOjbI2Xu/pWjpM13OOPRlzKe4Eh
X-Received: by 2002:a17:906:70cb:b0:a46:74fe:904f with SMTP id
 g11-20020a17090670cb00b00a4674fe904fmr317489ejk.26.1711131090464; 
 Fri, 22 Mar 2024 11:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYx4z0ulwvcCfL3z2eLajGwC0mrdXPAQ0RZtcJfdHMS7piBuQSjxKVjN1AdQV2hlqxeRqB4Q==
X-Received: by 2002:a17:906:70cb:b0:a46:74fe:904f with SMTP id
 g11-20020a17090670cb00b00a4674fe904fmr317466ejk.26.1711131090017; 
 Fri, 22 Mar 2024 11:11:30 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a1709065fd200b00a46cf8aea7bsm78399ejv.30.2024.03.22.11.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 03/26] confidential guest support: Add kvm_init() and
 kvm_reset() in class
Date: Fri, 22 Mar 2024 19:10:53 +0100
Message-ID: <20240322181116.1228416-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Different confidential VMs in different architectures all have the same
needs to do their specific initialization (and maybe resetting) stuffs
with KVM. Currently each of them exposes individual *_kvm_init()
functions and let machine code or kvm code to call it.

To facilitate the introduction of confidential guest technology from
different x86 vendors, add two virtual functions, kvm_init() and kvm_reset()
in ConfidentialGuestSupportClass, and expose two helpers functions for
invodking them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/confidential-guest-support.h | 34 ++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index ba2dd4b5dfc..e5b188cffbf 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -23,7 +23,10 @@
 #include "qom/object.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
-OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
+OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
+                    ConfidentialGuestSupportClass,
+                    CONFIDENTIAL_GUEST_SUPPORT)
+
 
 struct ConfidentialGuestSupport {
     Object parent;
@@ -55,8 +58,37 @@ struct ConfidentialGuestSupport {
 
 typedef struct ConfidentialGuestSupportClass {
     ObjectClass parent;
+
+    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
+    int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
 } ConfidentialGuestSupportClass;
 
+static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
+                                              Error **errp)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    if (klass->kvm_init) {
+        return klass->kvm_init(cgs, errp);
+    }
+
+    return 0;
+}
+
+static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
+                                               Error **errp)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    if (klass->kvm_reset) {
+        return klass->kvm_reset(cgs, errp);
+    }
+
+    return 0;
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
-- 
2.44.0


