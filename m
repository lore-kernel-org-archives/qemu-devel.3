Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB0C10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnY-0002oI-8f; Tue, 23 Apr 2024 18:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0001U9-1i
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmc-00066q-RK
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTRLhi2zlXx9/DhrFWTF0/FC5Bu0Xbkmc5xzMwyBC4c=;
 b=DJUXEWri6UnpWHnTWjw3dKeClF2K0Fz/88vg6gsXLOf3pT4SWhZwEcnlg/QGerfWKXSKt7
 WO3vTUkmOyELf77ofqRPES/yXTA+sepHwFDIOX8b61FhM0u7KuF2pUh9vfxYG7dqu0iue5
 taHT/8LL9WK+8wVrcCjf0BCCP9/CMiU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-6y2msx4vMZ6PKnDKRUzNIw-1; Tue, 23 Apr 2024 18:38:31 -0400
X-MC-Unique: 6y2msx4vMZ6PKnDKRUzNIw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c73b31c58bso464410b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911910; x=1714516710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTRLhi2zlXx9/DhrFWTF0/FC5Bu0Xbkmc5xzMwyBC4c=;
 b=MgYFGEoAbxBDQb3fAxfpNuVDEtMmCFKELgRxHhgKKoK3f09/RxsADeQjHQgWVUVGMX
 SS+R9tjRSQls9By5QhYB1i3MbNAfkalWL3ojNBcodb/OftJbisG5jr95ooNhhyPeU/Ub
 YBIYBnNh1Axig4XVwYJMuaJny/SGk6E66iDonRK1GUYMSlJYLADb+7iafZrI9ivKpUG/
 wSzI913TQ3w1kjEAvBhSiFaJWYcfXZT48jrwSG6TH1eQ4zgNczJpH1phkRENTKRkSWtv
 W/oSfWle6jyodC3RXrLJiK6bnaQBje5SK5HdoqNEF6GiJngFcFXzAIalm/X0tpUETUVb
 NdRQ==
X-Gm-Message-State: AOJu0YxS+bs+lihGSxdmLweOcSc6e46hixu2h0qkVZFF+IsT7wuoEAwO
 CgJmZHEJWb2mFamHbOXhWuerV4c0f5/a6YfPsbSRwPhGAQsZfNj+pO+tUOSZ+oudy9n3fdin4u1
 87a3SFdptqGVDKQjWBpgnra1WIJ6URS7rBLmsdq6MrHYfNWQNJ6sg+d3NwGtzTd9+JZpITdstPf
 QTbEFIPPYC4xwXt4hC7B2u/o1rkPeZ2Up9DA==
X-Received: by 2002:a05:6808:3086:b0:3c8:2f4e:ff64 with SMTP id
 bl6-20020a056808308600b003c82f4eff64mr802172oib.0.1713911910191; 
 Tue, 23 Apr 2024 15:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDlZAUyMUK2eFkp0VZITBNwVsCwb7746VvQjP8wojCQoSvdnQl8lZJel5YrVPClCzQQ++l/w==
X-Received: by 2002:a05:6808:3086:b0:3c8:2f4e:ff64 with SMTP id
 bl6-20020a056808308600b003c82f4eff64mr802138oib.0.1713911909577; 
 Tue, 23 Apr 2024 15:38:29 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/26] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
Date: Tue, 23 Apr 2024 18:37:57 -0400
Message-ID: <20240423223813.3237060-11-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
set_migrationmode() always sets a new error. See the Rules section in
qapi/error.h.

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-2-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/s390x/storage-attributes.h |  2 +-
 hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
 hw/s390x/s390-stattrib.c              | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 5239eb538c..8921a04d51 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -39,7 +39,7 @@ struct S390StAttribClass {
     int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
                       uint32_t count, uint8_t *values);
     void (*synchronize)(S390StAttribState *sa);
-    int (*set_migrationmode)(S390StAttribState *sa, bool value);
+    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **errp);
     int (*get_active)(S390StAttribState *sa);
     long long (*get_dirtycount)(S390StAttribState *sa);
 };
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 24cd01382e..eeaa811098 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
+#include "qapi/error.h"
 
 Object *kvm_s390_stattrib_create(void)
 {
@@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
     }
 }
 
-static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
+static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
+                                               Error **errp)
 {
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_MIGRATION,
         .attr = val,
         .addr = 0,
     };
-    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+    int r;
+
+    r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+    if (r) {
+        error_setg_errno(errp, -r, "setting KVM_S390_VM_MIGRATION failed");
+    }
+    return r;
 }
 
 static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b..b743e8a2fe 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -60,11 +60,13 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
     S390StAttribState *sas = s390_get_stattrib_device();
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint64_t what = qdict_get_int(qdict, "mode");
+    Error *local_err = NULL;
     int r;
 
-    r = sac->set_migrationmode(sas, what);
+    r = sac->set_migrationmode(sas, what, &local_err);
     if (r < 0) {
-        monitor_printf(mon, "Error: %s", strerror(-r));
+        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
+        error_free(local_err);
     }
 }
 
@@ -170,13 +172,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    Error *local_err = NULL;
     int res;
     /*
      * Signal that we want to start a migration, thus needing PGSTE dirty
      * tracking.
      */
-    res = sac->set_migrationmode(sas, 1);
+    res = sac->set_migrationmode(sas, true, &local_err);
     if (res) {
+        error_report_err(local_err);
         return res;
     }
     qemu_put_be64(f, STATTR_FLAG_EOS);
@@ -260,7 +264,7 @@ static void cmma_save_cleanup(void *opaque)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
-    sac->set_migrationmode(sas, 0);
+    sac->set_migrationmode(sas, false, NULL);
 }
 
 static bool cmma_active(void *opaque)
@@ -293,7 +297,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
 {
     return 0;
 }
-static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
+static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
+                                            Error **errp)
 {
     return 0;
 }
-- 
2.44.0


