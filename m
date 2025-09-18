Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E13ECAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGUn-0003YX-8I; Thu, 18 Sep 2025 11:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUf-0003Ru-To
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUd-0002Zb-1t
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOSafeLF/cdHj0WUrje7Rzs54rhm0NEYGyektqV3rfY=;
 b=IfxrhdCtRNriQJV9SU4Ct1CUIin9suHnRoNUxO9yaE4C/ysL2bPUiMUkVNUE4brrOPZOp0
 LsGQsg8bCGEp8qZeRmtHWuJW3koNk91t2j0y7HF3DpiU2/m0EKUSyILNfa+ZOEuan0abGy
 il9GTRyNQhz16QemuaOrW0HbZ/I4w3M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-1uTitq7yM568gF50foe0eQ-1; Thu, 18 Sep 2025 11:24:13 -0400
X-MC-Unique: 1uTitq7yM568gF50foe0eQ-1
X-Mimecast-MFC-AGG-ID: 1uTitq7yM568gF50foe0eQ_1758209052
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32e0b001505so1084882a91.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209052; x=1758813852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOSafeLF/cdHj0WUrje7Rzs54rhm0NEYGyektqV3rfY=;
 b=eDxyABl5rrL5j65JLrBsuyF8noEQdR9N1zWwoCMuGeV9zWN92RxtPexfvsKOS9yGjj
 Q5qGtmI+Lo8ZbGASBmMeAkwTBJv0xfIsXo+uycZhGuTvkN5LiIBULpDV0/FXx8JXs2l6
 QzUgc8usnzr3jtOjx/s26qzQT8EzqX+DJTmwVz1e52bYoqRl99+uqgxXQInMl6UWjm0l
 c9TFQBcIP7rxH5xh/9WY871OsNktknmWKqIaxpQeR1LIFN7pgAPc04/8T38VHJfBfc7W
 5p46L2epXqoQLLuQ0ykrar6cGDCHFuJjDr8J28wcNxk1G31avsBnvWVzwvbjR77Nr8vG
 Gynw==
X-Gm-Message-State: AOJu0YwCgHfKFZl9rZghhdWeGXEFebVlssVA+Sv0O1G0aiMTJ0CT9G4d
 4iIo69H2JYlzDVtPsTJzU+qe5/V1LxGti9oONgb1pNh7bsK+yoKmM3BjgcwkU8olB/1sJZveNE6
 a215ttsGMMRGJGpcCITImqzIR//88U41vH6lOi2hvtB8iGpKlnGp7ii1r
X-Gm-Gg: ASbGncs15dxYSTmKDobMUWQZHNCSRYIOKWJ2kaLdguTKQKl6gP3JxKJAICu9KhUXvPe
 nFFmj7f8507pZ5cs0F/ekcE09UlwXya0XN+z+Asmzx2YPBe7FaCLqOpBQ4I3Cm8nw83JhvDeWpF
 eZiatAkahS8BrCnvCWEpD7eyxCnYGLNPodErOPF3CPSyo7Jl0fSUCmDMKxoify7WX92ZP3gm6OU
 aoVfq4Df+PGR1PJAhIHSZRzSOa6ztGX78DRAsap1Bvp0qWEZjR1eLlZ6GF7yKY89wfbZcQ43db3
 Xjzaq5cJjluNw4hUvfeTjkAKfr4yC+gmQwK9xk4r1+bM2BFS8oFMwA==
X-Received: by 2002:a17:90b:4ccb:b0:327:b33e:39d5 with SMTP id
 98e67ed59e1d1-32ee3f99bdemr8527614a91.37.1758209052256; 
 Thu, 18 Sep 2025 08:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWX4/A+A1kzBc/JQ4ue0O12ISL0X/gY1NX1SFtsHecZmzu+1HpnYhQfg25rvr6T1adsL8WDg==
X-Received: by 2002:a17:90b:4ccb:b0:327:b33e:39d5 with SMTP id
 98e67ed59e1d1-32ee3f99bdemr8527572a91.37.1758209051817; 
 Thu, 18 Sep 2025 08:24:11 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:20 +0530
Subject: [PATCH v14 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-3-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973; i=armenon@redhat.com;
 h=from:subject:message-id; bh=08fs5yPRSN3G4fsuHEbQFA8WwDnIkqC0cHdPyjoW6j0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e9vJp0NlhS/qv1zTsmxqdMKH+SFfnnRpHPV77tZf
 IzampMbO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAEzEJ4SR4U+o0KJ9ie7WbzWC
 czi09/LO/W6fdj3TXmbrLZtdAUE3XRn+yjBZx2ze6pEyseOVvO8aDgfPzrt2Jtcmdrsb64o3HeV
 lAQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f5a1ab91016dba51f9cd1dee19a1c7ba31417423..0c445a957fc99f826e6753ed3795bcdd51f1e3f5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,38 +2814,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
-    Error *local_err = NULL;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, magic: %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp,
+                   "SaveVM v2 format is obsolete and no longer supported");
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 &local_err);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -3121,8 +3126,9 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 

-- 
2.51.0


