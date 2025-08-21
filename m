Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D560CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0yL-0008Qt-Hc; Thu, 21 Aug 2025 04:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xE-0004vI-V7
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0x7-0001Px-MZ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxdWT2e81BTfEG5avuaaGC8+ZJ+uzthEFyRkApZnAbY=;
 b=U4OLQ+Uvl5076XlMoRJChEiCkzqsMSgI2/dk/0h2OknsbKkkZ/zhUNXDd9mgpZyaBCe0R2
 MqXPFyYSVW+TdEhfhS2Ft8yMEPTRS5cVHGI6Dv9Ay2rULbyFlM6oo+lYnB8yvoM+YI9VQj
 Vw7+rMSaQNSsFL1bI38x7MpqTZqKjc4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-mf8H0U2lPBGSwdgdihXgjA-1; Thu, 21 Aug 2025 04:47:15 -0400
X-MC-Unique: mf8H0U2lPBGSwdgdihXgjA-1
X-Mimecast-MFC-AGG-ID: mf8H0U2lPBGSwdgdihXgjA_1755766035
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324f2d61681so610991a91.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766034; x=1756370834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxdWT2e81BTfEG5avuaaGC8+ZJ+uzthEFyRkApZnAbY=;
 b=U859GdkdDcIMDkNBUK5tSdWat4E0doaSDtl7VlV0VbfO0n2qcQ9bSuJfQtU29NYJ0H
 izDRW2WCK6FYFbmd4W2b3X5X7O/1COa1LYvpyon2vnU6yZE8xRlMhOVgOpkfCU3yT1j4
 dnYSYAKK2UCNuEGgjhFz0NiNuN8w/Kkwb8iHEDHElsuswW9Xi8WhB4GFrALImY0v0T+v
 crlARLdKyxmO3jAS9ETcruRH//C8cL9aUNI5f6jckWnbzlStobqu78MSLQf/U9WF92Qy
 PHyVjsJE/kG6G2Hq8r0jLUly0SI0MxlGjQ+z6hLp3kMoCZrTK6xJ5OAG8TVa+xplrrQT
 RfMQ==
X-Gm-Message-State: AOJu0YwtV+pJDjuuBJvOeq127xMSw8PI1PjKKqP3MeWdolz9VoBug13o
 IAkFC3wDLxCaUgDhLvGQ0JXlYhdTYkJ7QI/FIA/auDIiImvjn+BSZK/ZRd/0CFkL493KRGV46VX
 ofLrewbi+Khk6BMBKUEyk1/1/u9scJ5OY0+hmetPUGxMDNVNwfKvbTPa6
X-Gm-Gg: ASbGncsuYDsskihr931VOVEVExCdUyTf8KsSRB+zsEfwtaSEB0Ovgpxefs7snhf0WFN
 b+yXvJ+vkNRRmulhYMjrIxqicUi6BKop22abRl32q6k5k5mSeLToYLGW49N9w9IUy81FyqvHXNB
 u8cQi458CcQhV9myJ9c3TBhOTOQffesWRkIUAKgxmWl8SMg0fjd+pClw4EvzrTtYRnc3kNstZet
 G3/6/6JH/Ekko+heBRm7kKulGL+nKyqaIiluEzouSY/PtIskzcgnZDxIJe98Dj38YGxRRZ8qHSy
 0Sgjc6jB6pNYNoiOzdFOubHOcFQzf7hR8h8MiBQX/S5sUKmfhO1j
X-Received: by 2002:a17:903:198e:b0:234:cc7c:d2e2 with SMTP id
 d9443c01a7336-245febef6dcmr25061575ad.1.1755766034555; 
 Thu, 21 Aug 2025 01:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHjn+xXGffDmHxHiOoNKxf0qkIVXWrdvArZsD44o7HDhGXs6/lvnuJb1Yb2p5w0MXdwSLnvA==
X-Received: by 2002:a17:903:198e:b0:234:cc7c:d2e2 with SMTP id
 d9443c01a7336-245febef6dcmr25061195ad.1.1755766034168; 
 Thu, 21 Aug 2025 01:47:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:47:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:09 +0530
Subject: [PATCH v12 15/27] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-15-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4838; i=armenon@redhat.com;
 h=from:subject:message-id; bh=fsxfYriAPKTy/mJTkJeAmz/dQHM21bj/O8MQlA3on7c=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOymn+aVfbJlx+rH+5uAFHq4nKtaKO/jLTpl2yIM1i
 Xtd9u7lHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACbyl4+R4dEmC9vb7wJe2v6Y
 q+773cr/KM97aa+JMU53AnN+SDBJeDIyvGFItpk749c73+lxOzKE30xMmfYw82v92nm3/75gsru
 jzgAA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
It is ensured that loadvm_postcopy_handle_advise() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e65b9b57a7458d29956604da034f4c80b3bec3d3..b4a33fe740a21d4133d01ae8da8b8fbf792fc034 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
  * quickly.
  */
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
-                                         uint16_t len)
+                                         uint16_t len, Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
     size_t page_size = qemu_target_page_size();
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
-        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)",
+                   ps);
         return -1;
     }
 
     switch (len) {
     case 0:
         if (migrate_postcopy_ram()) {
-            error_report("RAM postcopy is enabled but have 0 byte advise");
+            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
             return -EINVAL;
         }
         return 0;
     case 8 + 8:
         if (!migrate_postcopy_ram()) {
-            error_report("RAM postcopy is disabled but have 16 byte advise");
+            error_setg(errp,
+                       "RAM postcopy is disabled but have 16 byte advise");
             return -EINVAL;
         }
         break;
     default:
-        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
         return -EINVAL;
     }
 
-    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
-        error_report_err(local_err);
+    if (!postcopy_ram_supported_by_host(mis, errp)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
@@ -1967,9 +1967,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          *      also fails when passed to an older qemu that doesn't
          *      do huge pages.
          */
-        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
-                                                             " d=%" PRIx64 ")",
-                     remote_pagesize_summary, local_pagesize_summary);
+        error_setg(errp,
+                   "Postcopy needs matching RAM page sizes "
+                   "(s=%" PRIx64 " d=%" PRIx64 ")",
+                   remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
@@ -1979,17 +1980,18 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          * Again, some differences could be dealt with, but for now keep it
          * simple.
          */
-        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
-                     (int)remote_tps, page_size);
+        error_setg(errp,
+                   "Postcopy needs matching target page sizes (s=%d d=%zd)",
+                   (int)remote_tps, page_size);
         return -1;
     }
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
+    if (ram_postcopy_incoming_init(mis, errp) < 0) {
+        error_prepend(errp, "Postcopy RAM incoming init failed: ");
         return -1;
     }
 
@@ -2617,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        ret = loadvm_postcopy_handle_advise(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         ret = loadvm_postcopy_handle_listen(mis);

-- 
2.50.1


