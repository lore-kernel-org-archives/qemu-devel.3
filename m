Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202B0CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNee-0004ZU-9t; Sat, 30 Aug 2025 11:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5No-0006Yn-DR
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Nm-0005GN-N7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756498054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ex70HvFHCA+0PjVijQlAjy4Lm+10k8XimyJ545WFrYo=;
 b=Amei9wlAhTIKjdktelf+u/yQsCYT6Li5Gf2AEI0puykzLMdmuKj96K/SmP+EyTyybkAL31
 uFaRKb0bOTtv8biymhLF4maOxIdFe88iyVAae9bYQxib314RjiQKmTgjiBMFAxwsb82lz4
 MKz4zpl2HoYr33Lu1Bc0UZ9FMrpbH0g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-wGGqY8wANeOrQLDnxsLz2w-1; Fri, 29 Aug 2025 16:07:32 -0400
X-MC-Unique: wGGqY8wANeOrQLDnxsLz2w-1
X-Mimecast-MFC-AGG-ID: wGGqY8wANeOrQLDnxsLz2w_1756498051
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3259ff53c2eso3591766a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498051; x=1757102851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex70HvFHCA+0PjVijQlAjy4Lm+10k8XimyJ545WFrYo=;
 b=ZZbQdWG4qP1azye1xu71DT6ubCv0yWr3MdYN5ssXyLQsa/J29F4J3xuyveaqPHxer2
 IDbUeI6Qebmu3OZ4SSujXlMFKSFM76tEerDN5URxBJnqUyzd6ylAaRI4moq2aOoRe2gT
 /IWk99hi02Yq4LJQI+QR5DgNBu7ikGDsHErgBYfiOYhsVZPoEthr2YYiTVkM4iyvbb8V
 HipdXx6y28a9yn6vpk80YMkTqomAs5Jg9VN4WmhdcIxNSCbupG1vpLXp+wsSyZjbgC+W
 HhWj6d0xRPP2zn0hAx6pMQCFCGayrMWz35ICHwk7LW8f/Munv54yFZdkBBLdQdCPPTPO
 87aw==
X-Gm-Message-State: AOJu0YwElU2Q9Si9eEWOKGkVSBVT0aM5e0qQI+BzmL1LYXLILkHIuHVp
 9ieHL8zc/FcFDPXkJhz2HySTHV64999VxHpyK2XTZ04hE/Vl7SmqkYouuynXm03evddSLWrUU88
 xxw0Blv+0DuwpnyAN1WbnRhRG9quQxpfOFk2+RP60nLSo/syKR8ZWK2vv
X-Gm-Gg: ASbGncvPN+csJJ9hzYm4J35Xbp9xLRn9O19ew2NeIwWOagsp8FBr4RphCOoRKeyuJDF
 lglUgsrVAXGr0CMcc0aPcCJWeBvozpddhqddSL8zx0BikIQ9gTYm6Xord+xqNqWgDtasmlmiild
 r8kIRLfiOVgew4BPKJaoLt0aGcqRmnaS6fMOYmbpq5DuQCHhT2y9NuOf57zpCeGhacQfmvM3IXe
 itdD3SXXEhbrBjJQiBjIRWllbX+2NS43Vu9fgXLHchIywORYLNAyMjfvFxoF0j0/iDlddwz0VYt
 MxYDF0pQbmlUqmhBrqKYULEaEaSscC81U92uCW5XVUpiGroWzmHVOA==
X-Received: by 2002:a17:90b:2f84:b0:327:e9f4:4de5 with SMTP id
 98e67ed59e1d1-327e9f4506cmr4193729a91.23.1756498051465; 
 Fri, 29 Aug 2025 13:07:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRwbcsjVEx1dz1w0nWHcTpvNQLW93gmAhnSc1tPMLDrZo+IZNZizujRtPAZz9Vsrb4ds8I6g==
X-Received: by 2002:a17:90b:2f84:b0:327:e9f4:4de5 with SMTP id
 98e67ed59e1d1-327e9f4506cmr4193695a91.23.1756498051064; 
 Fri, 29 Aug 2025 13:07:31 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:07:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:32:03 +0530
Subject: [PATCH v13 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-23-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=armenon@redhat.com;
 h=from:subject:message-id; bh=dpJRFzd7gm8KScLE3AM8NwdARIO3OP6+DoU1jE8PGBM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdj+hxWJtefONk/7cWr6jvmz/lTtpd55YFAkuaeKzP
 V1fsfdaRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIn45jP895gSmx2wP9Doypft
 bznup3yLvLzp1RPNPYm/2LgYd4q6tTIyHFZMVZJi28MT+Ty6mDuv81KQ1rxPbqxs+W28vbn+Dgd
 YAA==
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b0fd51d0f142c30ce21bdc02204ce947283fea49..71f4d8399349934134c2c02609d3ede6f61754f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.51.0


