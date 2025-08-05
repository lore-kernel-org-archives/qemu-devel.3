Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF1DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMOd-0004pX-OT; Tue, 05 Aug 2025 14:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOb-0004mw-II
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOa-0003y2-1I
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rPNTDVtiY7uPN48e8euaKCftyIHgbyMEJD1tSQQf04=;
 b=HXsdneN0LWSUCesVUAaTWT28bVx0DRpM4QyJlSj+GJIyHeqe2dEB8itXP1cjeRsi/OuZmw
 98V+WFRTitzxYAdLN0fGA0Hc3QLCw2xosdF9ze6IL2B0pMMKquI0N7W3dVzbalBCWnJyRT
 4Ty0J+xU7DsYNWAoPfrxwI1/jiA/9Nk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-mqiMiSHaOOSYfK91esdN4Q-1; Tue, 05 Aug 2025 14:28:18 -0400
X-MC-Unique: mqiMiSHaOOSYfK91esdN4Q-1
X-Mimecast-MFC-AGG-ID: mqiMiSHaOOSYfK91esdN4Q_1754418497
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23fe984fe57so65548715ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418497; x=1755023297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rPNTDVtiY7uPN48e8euaKCftyIHgbyMEJD1tSQQf04=;
 b=H6vfFiBi7IjoSewJ3LqV0aHDnRK5HH48NDkETKO2GLUjaKFitfuduNUr2Ol7cFndss
 QodaQEkbOyGMsS99tbx3dMol/dUSWDB2jbKxjH4sxMI9/3/99iTWQWfxC6qZCgwHryxK
 eq/TcOTSbRkHZ21scLTD2OC+J/ej0S0U/+ePhoWM9f/YOuvKfkE4V7NlUr6/YftwM6hL
 0KRxe0NIuB6tftDv3VPtFAK8g5EPXeSi47D++6ug7146YMy06iQpA/dfvyKIMb7slAi+
 dy8IFnNPzIzWPjnff0/FaI1r5qrC/hn5T+szxWzxCMqQny8WOPiRZOCKhoVuumG6f7+E
 196Q==
X-Gm-Message-State: AOJu0YypVyZydch9Tk4t31rn2HOpZqgtw6mvEhlBKdisbKeZ81Yf4l6l
 PmkSL8Iu/rwewLGjyL5esB/xg27vVa4k/E11g+AUrknCE5Trb6nQLmaXu37ARWlnGoQg9QsTys6
 nzNl8X/HFHC1zl2jm/YZRyo5g19T5w5Vyspqx+cziNbglnzNDWc5m3m2z
X-Gm-Gg: ASbGncs0W6wE6UG+nGy7NlB06377De9u7p3VKRXw+3/C2vzrVYeLk6vB21wGtH5YJ7U
 yTQmsFNIYWjlxOgxya9w1MhLbxR6R92vSoK5IsBvt0k122Ivc6sPEi7gAhl0mlFNgSKWHdPSwxi
 g7kIBIw5jWBuFCu9geZRUJsScQpzGSV4yNRykZ0KK7Xx5A29l8CxWwkTZXYkNFDYNXWbjMBXX5i
 PJvxpfkRAfc2th2X7Xjv5wqtNdlsfKwGEu/kHUW+4TYDlC58JzHfcuIzWDJnPY620FeVR9qDiUt
 3Y6osteXyIXH6ITbGw2FBM2wq5+fJyhhYp/9fRVKvJuZA7WPhQ==
X-Received: by 2002:a17:902:d510:b0:242:9bbc:c775 with SMTP id
 d9443c01a7336-2429f5c0960mr833655ad.56.1754418497272; 
 Tue, 05 Aug 2025 11:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGYI5PZuD7Qkwm8SVMgvEs91wc3SEH4wNI699ZeZR0DPXL4g+fn7XvPJTiIMpgJWWV7y9++A==
X-Received: by 2002:a17:902:d510:b0:242:9bbc:c775 with SMTP id
 d9443c01a7336-2429f5c0960mr833135ad.56.1754418496923; 
 Tue, 05 Aug 2025 11:28:16 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:28:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:10 +0530
Subject: [PATCH v9 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-3-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=armenon@redhat.com;
 h=from:subject:message-id; bh=tj3l0Usc1AFRWL0AZRnET/EmXPM64Mzi22SeHEMyWCM=;
 b=kA0DAAoWanolONkPMo4ByyZiAGiSTRujXmklzQ3hw2q0YRE3/KH6CeqrLtwwNoPPDXMBRTUvH
 Yh1BAAWCgAdFiEEgPVQHYJQcVhZPenXanolONkPMo4FAmiSTRsACgkQanolONkPMo5nJQD/c7qD
 HMNE/YNtcDSqXGI6RcV7FQ6DMlLRJUl9pGC2fDwBAPEoezm9bAgDUBjSG0U2FKh/1lqXmTWpoRo
 xKybWxyEE
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ab947620f724874f325fb9fb59bef50b7c16fb51..b517e3bec651cb5b4050564f7dcbbf34c80a5035 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
 
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
-                                 NULL);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -3119,8 +3126,9 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 

-- 
2.50.1


