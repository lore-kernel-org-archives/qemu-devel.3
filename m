Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKFpK81n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA50-0005FS-1y; Wed, 28 Oct 2026 16:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4s-0005BH-Rd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:55 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4r-0002Ix-8R
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:54 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36661f953e4so2233162eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218612; x=1793823412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BxuYkSVQHoTJF2qd9tWd22NBfHJ+CcSwy1napmBXH5Y=;
 b=oKFpK81nzKLdEtVaxqymiMPAbBYX4607d8hzayqzjzRzn/FY8ZFPdtSUp6+V9dsBsx
 bzhSX6vwl6qtyUyE73hwgypvJr9+EbWw+/fjQPi3M0TSPtRg1FUcopZ3rrPYFEBNWL5O
 1JC4lruXHNw73KzrbUUEiihU/ag+1jgKDVkNDu/UkUtKCEtQ7ysV73WcnKzwHU/0h7m8
 18wQN22nv47B5PFI+xfJn8+I7Uez+AL1l2gVxSKgOuKCHgNrRO1QhQzJ630b4WQ63sS9
 9mRSjq6SwimioOv34Hh0V2zdU5nPYmegjaG4pYRYc+LjMekGhIlUtnVShfycNMlItvQH
 Y+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218612; x=1793823412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BxuYkSVQHoTJF2qd9tWd22NBfHJ+CcSwy1napmBXH5Y=;
 b=ZSb3OANN5x0/GMSlJncRchPukpDQABsrHqWYkVQmlCaMwpOOmHikqXAyDRQ0u1M4a9
 bvrrwY9kl7Dy1ehau8qAz3EMoUklV7c+kf1acl5U3ZWP2N9+eEVy702JxaYuzmWV5KUd
 31q7nUWSSOyKO8iSti3GRdCLdg+6cuAT2a4ecsE1g3hSe46wuoxUCRL58y9FCYB1MFYG
 iY6+OEx4e/SMoCaoao63+dF3Vl79o8rQZbn1vrVXg8v66skhhMiF4cMFrj0u67z/kiG5
 KLWL2ZEvnHbkdCQysp8fxV7wIDpXhp/uWuSME4KOpLy36q+O/i7d1TV3ukAX0gp+UYVJ
 mjgg==
X-Gm-Message-State: AFq9FYJ1k9e+bIe6mOcTqk7gbN6zjCHrorlHq9NOQnGAbYDcZFcEP95r
 jS3As6qxe0AW6aCekOa78gyaIgQXTAHzT5seS2Cnu7rKISz6JdV7coZZpZpyKojc
X-Gm-Gg: AYBFou0pIXbAXyRsyLEwaQNmBMifU1DNFtwOCO1yexhDOqWraUewDTq+EoPt/a2+YlY
 OALRwc0nZGLEZzEdhjxsOByH3fA0WxX5MHwQL+A4a8TvlApcOt++8nsVcbDqtEuIrkbhWdnN+76
 vygTkdmgzh2QV9pEiyQ3NXKTtYh3vsGD3EbT/P7it2T29B1Oc4sYBDppxcaIsDGGFMop0d/Uah6
 TS49llyt2ivEodjkHAkkEybzudDdH530lUrKTmy8YIV5uJCNLFPFALYi95i0BDWaRmlf4ohvd2w
 wfXbK7qaMmn03tpj1WaccN/BGWF63KoH8dG8STU1iyGOU282gdX2PmP1JmSkMHjn+4EGHsHg9ne
 ulnZ54RZTkxMUm6HW+d/F7v965pASvKeXgQjOpsJveNdIEWsUY+YEVwpot4bEMvdTraoXNDaHzo
 UTaIRcB+OdYmZ0urLIj4phbTztWEl5jE3qXmEgcSuazn+Xcikyx5/3yUqoqfcABemcDwgvI6ZHC
 b1XYJ1RsL1Iw14XJ6pWswg++Hu/wcB9yozzxBgYo94kb8mlPfdKcqEtxm4CWmZ/mRDF2MgFGycC
 sTHeJn3mHZRwsUknT6gvnaItmhanP4Zm6FhcKIGq13x38Hx/mA==
X-Received: by 2002:a05:7300:7312:b0:358:ec5c:bef1 with SMTP id
 5a478bee46e88-36a204773c0mr6759571eec.39.1793218611743; 
 Wed, 28 Oct 2026 13:16:51 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/12] hw/scsi/scsi-disk: register s390x scsi-hd and scsi-cd
 variants
Date: Thu, 29 Oct 2026 04:15:51 +0800
Message-ID: <20261028201557.2688-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

scsi-hd and scsi-cd added the s390x loadparm property from class_init
when target_s390x() was true. Register a second type for each name
that always adds loadparm, and select the two with target_s390x() and
target_not_s390x().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/scsi/scsi-disk.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6341089ddf2..f981dc2c903 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3221,14 +3221,11 @@ static void scsi_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      scsi_property_get_loadparm,
-                                      scsi_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  scsi_property_get_loadparm,
+                                  scsi_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
@@ -3362,14 +3359,26 @@ static void scsi_hd_class_initfn(ObjectClass *klass, const void *data)
     dc->desc = "virtual SCSI disk";
     device_class_set_props(dc, scsi_hd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+}
 
-    scsi_property_add_specifics(dc);
+static void scsi_hd_s390x_class_initfn(ObjectClass *klass, const void *data)
+{
+    scsi_hd_class_initfn(klass, data);
+    scsi_property_add_specifics(DEVICE_CLASS(klass));
 }
 
 static const TypeInfo scsi_hd_info = {
     .name          = "scsi-hd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_hd_class_initfn,
+    .is_available  = target_not_s390x,
+};
+
+static const TypeInfo scsi_hd_s390x_info = {
+    .name          = "scsi-hd",
+    .parent        = TYPE_SCSI_DISK_BASE,
+    .class_init    = scsi_hd_s390x_class_initfn,
+    .is_available  = target_s390x,
 };
 
 static const Property scsi_cd_properties[] = {
@@ -3405,14 +3414,26 @@ static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
     dc->desc = "virtual SCSI CD-ROM";
     device_class_set_props(dc, scsi_cd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+}
 
-    scsi_property_add_specifics(dc);
+static void scsi_cd_s390x_class_initfn(ObjectClass *klass, const void *data)
+{
+    scsi_cd_class_initfn(klass, data);
+    scsi_property_add_specifics(DEVICE_CLASS(klass));
 }
 
 static const TypeInfo scsi_cd_info = {
     .name          = "scsi-cd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_cd_class_initfn,
+    .is_available  = target_not_s390x,
+};
+
+static const TypeInfo scsi_cd_s390x_info = {
+    .name          = "scsi-cd",
+    .parent        = TYPE_SCSI_DISK_BASE,
+    .class_init    = scsi_cd_s390x_class_initfn,
+    .is_available  = target_s390x,
 };
 
 #ifdef __linux__
@@ -3462,7 +3483,9 @@ static void scsi_disk_register_types(void)
 {
     type_register_static(&scsi_disk_base_info);
     type_register_static(&scsi_hd_info);
+    type_register_static(&scsi_hd_s390x_info);
     type_register_static(&scsi_cd_info);
+    type_register_static(&scsi_cd_s390x_info);
 #ifdef __linux__
     type_register_static(&scsi_block_info);
 #endif
-- 
2.55.0.windows.3


