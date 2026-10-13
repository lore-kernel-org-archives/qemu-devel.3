Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA0FCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGil5-000818-DF; Tue, 13 Oct 2026 16:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGiks-0007yE-Dj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:46 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikp-0003N2-NT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:46 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-35829219da8so322074eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921940; x=1792526740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAa9EYHeaBZV1We1wS0Pw4Gbkg3A4EQ75sck0EgY0ZI=;
 b=Dbn2O8tuavLXxzYmgn5hWXNTL5neApEWsUi1UMgJu9MNjs05dDPoEjImdvTynTy/Xw
 mX81s2hp3cnA9f4lpxMvLARwIpxbBuu0ucqlIxcmLKL1QOUDTbRR7CjLq0iLDjvxZa5y
 W0rvZ+no7lXw7bWDN0aOOfCB8cf7hKDCQP+q+pIwCJrk5Qvhqcj1RickmG1rQ9a0gnOi
 u1w1l/H1CKsrls8YdksLshmPRC6jS54Mrm+49zq30/P/WtiGioyP3Qt/ioQnn6J0pe0c
 /8IA3IVSoy1wzKEuW9R0wTenXLJ5QRmpbuPB7dnIgo8XaUb39+X3X3p4uhbv6f0lcZt3
 cmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921940; x=1792526740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAa9EYHeaBZV1We1wS0Pw4Gbkg3A4EQ75sck0EgY0ZI=;
 b=sO6+PhY8e9QgUzbQmIS50xd8pbxvm9Pp703kqHSpBrtPfL1MgsjdPcBeH+7215oB2v
 22TRmlj+EEuUi6zEmKRLFniKaIM4O/8uz43tq4fejZRof+hzpJG4QYa5IBfRB3UKkNeP
 +Lf9+Go0YrdHpTEsqZs1Cz8DZ1g9qIhCE54br0t/Ft439oOwsfvvSym+2siMBrGJFrfK
 UeQxPDC41OriSuQ9UMTdR4JZCL4AaztLOPhk7Eq3Cuj6lZwXItjXNC9oyGyC/HMVfnxU
 cZFfvQJGDKivpRZuWJdOPiTDS6+Yxb8EekU8V3YbNGon8qrWBpcunU5oBHcWhtFSDugl
 fuWw==
X-Gm-Message-State: AFq9FYJ2UB+Z2GQlOIqQRts2rzTqFqsFPzWzaxpfefwCZSgdcVR8IiPe
 96glD2DJcGEh/SZz0peXMbEP23MH/ZpMkHIf2mH2oQNIRY+ndJHIq8psCn8yk56f
X-Gm-Gg: AYBFou0dPRNhM6iEePflgEP5tVQ0fQE3mVgzj4v5rR+r4seiPwGscCvzFMtgSNdNjMV
 d/rSd4QwGsS+M3EM+ZnQ/UXjHtbb1LZO/DlT84NzyCedc9FTl+T+FME5QC6b+M1lHkfXvB+Vg+m
 ghDII85HsZ5Gdd4kxOEDjJwYXF7arXDeeY91mpi0ZdkpWOffQKPhSuuRbXTKfgfQw1cYS+n7Qdd
 eKFZ+1ADHiHiM+f7h31xz6OYhGd2OKzv7ytgOyyV31mf3ylapIq33MtlELfZj2f2F6Vj+WwJElX
 ieaMDKHw6O/PeZNaOweFEC2aXU1Uym7qVNvPx+HReFHnAO93Fk4nNIaLsNQ3GcL8W2mt1DedqsV
 0SoMluU9Vvde3SUelLVPJxCqU64U6r6d2iXIOkKV03vnPsdjTFjK5kfyPKNv6ckz/KbusnK0jL1
 tzia4ynhHp3hge3YKUIHSxfkaootwAuPbMycGEcTZw8jHbagJi0vAgq572/dj+vfsNDNovjCbvP
 2wEi9IJks38iN5IEg==
X-Received: by 2002:a05:693c:83da:10b0:353:804a:5e83 with SMTP id
 5a478bee46e88-353804a5fe8mr18223942eec.8.1791921940462; 
 Tue, 13 Oct 2026 13:05:40 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm25568233eec.11.2026.10.13.13.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:05:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 2/3] hw/scsi: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Wed, 14 Oct 2026 04:05:23 +0800
Message-ID: <20261013200525.1340-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261013200525.1340-1-luoyonggang@gmail.com>
References: <20261013200525.1340-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is for avoid call target_info() in class_init.
Now we directly guard in scsi_property_set_loadparm instead.
Don't know if its an API break, but the smallest change.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/scsi/scsi-disk.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index deb33ac1dda..276941ae537 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3179,6 +3179,11 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
 {
     void *lp_str;
 
+    if (!target_s390x()) {
+        error_setg(errp, "'loadparm' is only supported on s390x");
+        return;
+    }
+
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
         return;
@@ -3196,14 +3201,11 @@ static void scsi_property_add_specifics(DeviceClass *dc)
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
-- 
2.55.0.windows.3


