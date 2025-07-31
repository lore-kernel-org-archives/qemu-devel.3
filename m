Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7EFC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU8e-0006XZ-RZ; Thu, 31 Jul 2025 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGD-00021x-5C
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTG6-0008KY-MJ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=308KU/Yor2fucYzWGHegCEq7pZRYSWVIFS9BSnl6OfU=;
 b=VA8ATFzYYT21OtYrWyg7YEh1kQqQVFbgZoIgL/GZjO3a6KdR6A3gEm0ChgJlMBOKt8pM/w
 fCQlMTnuDuyfGrJKdUjEIKeOK7jYvl+HL/7VTD3qWUSRbyk1HEC8oNcUUKeJZWobKNlDQD
 TbPcWb5iNLL5ZUG9T0Ml/t2IObazw3s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Y-aCMlzlPjGDw802DFdlRw-1; Thu, 31 Jul 2025 09:23:42 -0400
X-MC-Unique: Y-aCMlzlPjGDw802DFdlRw-1
X-Mimecast-MFC-AGG-ID: Y-aCMlzlPjGDw802DFdlRw_1753968222
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31ea14cc097so432089a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968222; x=1754573022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=308KU/Yor2fucYzWGHegCEq7pZRYSWVIFS9BSnl6OfU=;
 b=YpoZ7sybToK9DbLsgpcq5pQXsR70+A24kPDIbr2oVDo9WHMl4p8mV9fM3dkIGCRkm/
 MdJ5JRyXi3jGT6eytTLvsikXl3nkEqMZ8bks3FgwRZek+NmBLvN3d5ojvxrloF5x+Oyk
 V8EA94zPDs/ayQtlEIWW9DEqxze1H+7oa94yL226S/xB9AEn0dkgxRSg/bIlGklm/bIi
 6KFBJSFBn38ZOsK2zV4fkvq4frFT+7hZbRjl2GZlpUfYvsLAeTOGjEmNXLZy6DK/E5C7
 3wD4rfPfhrccCCqAp/Wo7kGiOBgtJfTnWTqQ+3pt9JCJR6SB35hDXAX0gW9SplaR/IM1
 ud8g==
X-Gm-Message-State: AOJu0YwUMfIgFHXv2jMLM2sq/oDsuh5bwpZyQwhhluqV62WD7RtB7DL0
 dinLWvkxf3GyUyGqd/tUDkRVla5+z8kR1R623gwqY3eOhVkeB+PIN+qG2adalIZN7bOunCx1hrq
 li6WJS425w1ngoXblHTrr2XyIrZi/gKyoZ/yHayKfoZyGc5b+55oKzPOWUTpFaX9g7qM/6bSc/h
 0KmbdHDbeW5f52V3dmq3MpxDi91aPbt+obCVy+oRFIpg==
X-Gm-Gg: ASbGnctDEokmG4c01iX204NPGAFzJSxxDp5l5ZMFCvBaMh9ZWu4mnt1mgdjXl24CfUy
 0kO1OfukjDzDZwIoVJI1C6eO8K8X9+A2AoZ5MGd0weCen3CypVvZy0oP2Bh7bRs59ZbXutt/0fg
 MBSBIz2+p/2DKLa3PM1oW1XfjECjx7hxL4cg0UryGxxLGlTv6qb8TYio7p+7td2PIR9Ki9oWybh
 v8g0Bu2H4cMDq5VbMu5oGeWEj6OmbpW6gJodexop9TMiccbYF9TV36MJShZcoBmpPk69CozRrQ/
 aX5JootkxyQY/LyXoSN61esoUEGCtrDJQcFTmyZVsfNalNEbrOKQ
X-Received: by 2002:a17:90b:2ecf:b0:312:26d9:d5a7 with SMTP id
 98e67ed59e1d1-31f5de2d561mr7184274a91.20.1753968221336; 
 Thu, 31 Jul 2025 06:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD9QCjsBkS/oQsfa5sLmZQlXIUqYBb/wbxX2zcaDthoTuPzSd/6x1GH80VszCY8LFtbLSV0w==
X-Received: by 2002:a17:90b:2ecf:b0:312:26d9:d5a7 with SMTP id
 98e67ed59e1d1-31f5de2d561mr7184150a91.20.1753968219936; 
 Thu, 31 Jul 2025 06:23:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:23:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:51 +0530
Subject: [PATCH v8 11/27] migration: push Error **errp into
 ram_postcopy_incoming_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-11-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4760; i=armenon@redhat.com;
 h=from:subject:message-id; bh=e6K2XVk2u1ogcPUqKXsJ3y71DmRHAySwomlEZiuuuIc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tP3C3om6t9X+1HpYMe46fMSU/6Q28weRvwCdSfTW
 fYHPBLoKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBHO7wz/lOO4Gac4LfxylnHu
 Oo/pc/YvmWN90EV4fvK5+eVH1a/IhTD8T4gK1pu8om7p26tObbZtTE6LJEr8y99mtGbcMtt10ew
 hAwA=
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
It is ensured that ram_postcopy_incoming_init() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/postcopy-ram.c | 9 ++++++---
 migration/postcopy-ram.h | 2 +-
 migration/ram.c          | 4 ++--
 migration/ram.h          | 2 +-
 migration/savevm.c       | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -681,6 +681,7 @@ out:
  */
 static int init_range(RAMBlock *rb, void *opaque)
 {
+    Error **errp = opaque;
     const char *block_name = qemu_ram_get_idstr(rb);
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t offset = qemu_ram_get_offset(rb);
@@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
      * (Precopy will just overwrite this data, so doesn't need the discard)
      */
     if (ram_discard_range(block_name, 0, length)) {
+        error_setg(errp, "failed to discard RAM block %s len=%zu",
+                   block_name, length);
         return -1;
     }
 
@@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
  * postcopy later; must be called prior to any precopy.
  * called from arch_init's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    if (foreach_not_ignored_block(init_range, NULL)) {
+    if (foreach_not_ignored_block(init_range, errp)) {
         return -1;
     }
 
@@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
     return false;
 }
 
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
     error_report("postcopy_ram_incoming_init: No OS support");
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
  * postcopy later; must be called prior to any precopy.
  * called from ram.c's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis);
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
 
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114fb5c366740db380ee6956a91b3871a0..6a0dcc04f436524a37672c41c38f201f06773374 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
  * postcopy-ram. postcopy-ram's similarly names
  * postcopy_ram_incoming_init does the work.
  */
-int ram_postcopy_incoming_init(MigrationIncomingState *mis)
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    return postcopy_ram_incoming_init(mis);
+    return postcopy_ram_incoming_init(mis, errp);
 }
 
 /**
diff --git a/migration/ram.h b/migration/ram.h
index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281ec268ba0db 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
 int ram_load_postcopy(QEMUFile *f, int channel);
 
 void ram_handle_zero(void *host, uint64_t size);
diff --git a/migration/savevm.c b/migration/savevm.c
index f0dac8b13c12a1785c0a293b8382641e82ce89d1..dc3f66f924dad2691bd87080fbdfb2fe3d95a51d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1989,7 +1989,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis)) {
+    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
         return -1;
     }
 

-- 
2.50.0


