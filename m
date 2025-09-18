Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1683CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGVr-0004qV-W5; Thu, 18 Sep 2025 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVb-0004Ty-0y
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVX-0002xs-LR
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsBBzucx8y5i9VHunk1XF83aX/5bi21WNzwEAMu8Vec=;
 b=NPr/WfwNsnYAV2F89oel53kGZnFVDY70AO9/2PAQ5YrvwcRIvdgp4z2BquAeExlQt1ZyXq
 4XlpB3cv7xXlU3DAmV++U7lSrPRssia2SizV+nAeR9ZN+NK4Qx49jeEx+cPq4ixL7Tu74Y
 E6Bf3E8vgAMrTvmWVKVVSSvaz11KA9s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-GN5gpzSCNcOdQmbD8KUohg-1; Thu, 18 Sep 2025 11:25:13 -0400
X-MC-Unique: GN5gpzSCNcOdQmbD8KUohg-1
X-Mimecast-MFC-AGG-ID: GN5gpzSCNcOdQmbD8KUohg_1758209113
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77cb7607cfcso1408277b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209113; x=1758813913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsBBzucx8y5i9VHunk1XF83aX/5bi21WNzwEAMu8Vec=;
 b=MPJmiuyL+cMmxB65mVLVwNYXD79WTSs1k2ZC1dO4pHLDRClYX/x33fvFsLl23hY9Zq
 14pAELXvRPILcn8Sc2BqFZitwL5UWbS81wo+Ab0vukEDuLiSIVtS1RmhhzOJMSkHRBR7
 PHe1adNib1hvaNTOHowfjJTyltNkoeEiGAI7kRlEiDRvKiK0TBXlp/aJXjSxbJn1F0/L
 /uFTRkq57K+7/4Q/xs+4By86LRq2os/7SCO6pIMmUsu0SGmOP88Cs45wwXHSJkGQLU6o
 JSxZFICQVhysL/mFdyN/S5yoRxUocR9J0XMVLm4TzlIgcxWJYtSCKgy3wSoRe4mln1DM
 hPzw==
X-Gm-Message-State: AOJu0Yy7anyUt76HAj9zlcIWGpu88XtLyo9jWPR59bX4EfrLvFxvvhDw
 uQpw/JhrOheOA+qtv3Hgu92C5FchhFGu0+X5sHpMtc88FFavT+JndueXemi8XErF7e/FpdzBkIz
 Sn/opzeSghY9cnJqSNoY50lIYKme0IrH1iaEDGEwo0WtetcjurLaIQOfR
X-Gm-Gg: ASbGncsThRJ8uXoywENebqSVAedJi/p8H8cZC2l/EAPl19FWxHd+ayttlYPuei25hZi
 UpBEornrXDCC07Uh4SCyE7T4E87VSFIojIlVUOX82RHGj9gOZJeRXKMgFNEgvaBt4WYbBusS5tZ
 bPp1Vr4geEZV5jG1+ZTXCFWKgVj8eBc0g2ljsNylxOKMvhwAhQQCuMXzW3CDAX0TQaNqoA52E2Z
 cZ5UuCAfije/6Poe+90PjPscuEKHTqy0roWPEUeawAvgoCuVM+ht9RkwJBa0pICd1sRRUrtayLz
 2uKFz6z3dqurvMB29w5ECdzfDlIRhzMoftkbrj8hTdw46x1waydqSQ==
X-Received: by 2002:a05:6a21:3983:b0:253:1e04:4e8 with SMTP id
 adf61e73a8af0-27ab730a545mr10628753637.56.1758209112558; 
 Thu, 18 Sep 2025 08:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmEmXEj1DpCBiBVgLWcSiF27Q+lvsBDXJw0zOwfXyhkfEQVnjKKHwa128pdgnS24XvYxn2mw==
X-Received: by 2002:a05:6a21:3983:b0:253:1e04:4e8 with SMTP id
 adf61e73a8af0-27ab730a545mr10628702637.56.1758209112208; 
 Thu, 18 Sep 2025 08:25:12 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:25:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:27 +0530
Subject: [PATCH v14 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-10-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4798; i=armenon@redhat.com;
 h=from:subject:message-id; bh=mjhvRtOfCNflzXKsd7LfnW6aMa0TrUuxLNhD6rtfZNc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e8WAsV+aubBiZyXTU/VLJbc2H1eNerNbdnJSRryi
 fnKa5g6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOQGKyNDY/esbzeEEgRnhHbk
 mU17dGBumvZXnfWCzsaKzS2CXN93MfxPc3RduCv9D/u/c6/eMrpOcGq2rBeZumXlrEgzp578N28
 5AQ==
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
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eccb3f63f8dfc070263a1d19ec3415684e8fa60e..01e1a9739aa784d90f80bf2b561fd62f5e4678f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2722,21 +2722,21 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
     SaveStateEntry *se;
     char idstr[256];
     int ret;
-    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2744,8 +2744,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2754,17 +2753,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2772,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2780,11 +2779,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
-        error_report_err(local_err);
+        error_prepend(errp,
+                      "error while loading state for instance 0x%"PRIx32" of"
+                      " device '%s': ", instance_id, idstr);
         return ret;
     }
 
@@ -2795,6 +2794,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3100,7 +3101,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }

-- 
2.51.0


