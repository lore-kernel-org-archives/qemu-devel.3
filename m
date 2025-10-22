Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A596CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTv-0002vU-9Q; Wed, 22 Oct 2025 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTd-0002sf-IL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTZ-0001UZ-MS
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpjAE4slBEhS+3yJmkKxJqSXI1XYW1Z8hdORf1mQ/rc=;
 b=bDMGOwCUeG4l1Kk8QfbkmWscE1P7w72siewj0QxY8ywoNAhRSI4Wsc9hYMUEImRk3Dh+PO
 hOpmPvwlNT0mCjNdMMnQEqUnvrjTbjj6byTJaQREsyJaYawobLpohgl8hBJiZReew1QElW
 9aIFIEu1XcXOYknZf1eIff9tfpShz1k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-EcmBHQtTNCKh7FxOi0o6fQ-1; Wed, 22 Oct 2025 15:26:23 -0400
X-MC-Unique: EcmBHQtTNCKh7FxOi0o6fQ-1
X-Mimecast-MFC-AGG-ID: EcmBHQtTNCKh7FxOi0o6fQ_1761161183
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8984d8833so65872801cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161182; x=1761765982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpjAE4slBEhS+3yJmkKxJqSXI1XYW1Z8hdORf1mQ/rc=;
 b=kJesnu8IsyKl9RAb1QyyoNp749QPFnipFaI8Tg8o13ZjI2I+1wcUfMbDuX5LmT8D+v
 qnEyL5BaEvPNS8TXH3oyNxU6kcC5rNstPddXtvr+TivnRqIrkD7dmF5PESUrgMW+/l8u
 sRZXRj+JfiwhwrnS1u/cZhFU8JKER4JlUzq2YzN6ObVMxuIM4y7jUNCkWMt9SeIMordI
 QpgQbB2iLkUVWvZ8HfWyglFX1E+n7jo5zRqoG8hfbnQ0m1h3GRgp7viCUlTHXHvPP/KX
 iiHMFyvihtNENqZQ0kORTpX1Vawy2o5xvQXDw/4YB43+OZu8mzCDW2De7fusgb6IAHYx
 WSsg==
X-Gm-Message-State: AOJu0YyWfQ2ETF6TTXOtlT95pUvF0/LwV7rbDKWXljwL5sPvnHcpPSqI
 hMC2TaI1Rq2tjx+JrDhJ06LvA1VH0YxrItStbTVdHFzsNQy/uc9z3PRk2aex7YlcI4R0IhiSXbc
 /d9zvhh/CXJSvFRdqWczKVJR4a1RbJa/oEFGGFdvImWVm34v4VrZ1c5ytqm+Vm0m08AFM/qvrcr
 9yBSUr3cRCklRmTeCokV+zquWxtqUjStBtER/mEw==
X-Gm-Gg: ASbGncv3Dsag47+GLdpy6z33WKSGOjgCjL4IDj6WKX68XIE/0cksMS75loK9GuajkYr
 bA+sUJt+BsDMdr6HXYrVSZBJ/V6UkXnOpVToRwV7BC2fv1hbz4LoBi3gGswPx913bgpxtbXwu/M
 pVaBEieIsPwIbnrbfiB4MNCzUcKVucw+18CtRUMW2Pl2yaCwtY6ayF/o4dconY7yXk9QMG0D2ur
 iZGvSVQilJftrWZjeQ8XI8N2rj9gE5s8jB1+dB6ke6SmkzHELG5HSBPlwN4weNqJfxs7/+xgeWJ
 Run0IYcHrXS+3dTyQyy0Qf5JXIeVSpYexqR/CKEKMxl5aKteJeNefwggKazr2sVS
X-Received: by 2002:a05:622a:40e:b0:4e8:9a7d:90ec with SMTP id
 d75a77b69052e-4e89d33641dmr302151711cf.42.1761161182307; 
 Wed, 22 Oct 2025 12:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOl+qm2DDhLeCPWyZmUZYzH2UBjRR/AyJkHtutmjxA6whe24rUS2klBRrSxzQJGTwAYdnsDw==
X-Received: by 2002:a05:622a:40e:b0:4e8:9a7d:90ec with SMTP id
 d75a77b69052e-4e89d33641dmr302151281cf.42.1761161181793; 
 Wed, 22 Oct 2025 12:26:21 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 04/13] migration/rdma: Allow qemu_rdma_wait_comp_channel work
 with thread
Date: Wed, 22 Oct 2025 15:26:03 -0400
Message-ID: <20251022192612.2737648-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's almost there, except that currently it relies on a global flag showing
that it's in incoming migration.

Change it to detect coroutine instead.

Then we achieved two things in one shot:

  - Drop migration_started_on_destination, which is not needed anymore, and
  - It starts to work in a thread when loadvm using RDMA

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e6837184c8..13dd391c14 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -357,13 +357,6 @@ typedef struct RDMAContext {
     /* Index of the next RAMBlock received during block registration */
     unsigned int    next_src_index;
 
-    /*
-     * Migration on *destination* started.
-     * Then use coroutine yield function.
-     * Source runs in a thread, so we don't care.
-     */
-    int migration_started_on_destination;
-
     int total_registrations;
     int total_writes;
 
@@ -1352,12 +1345,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
 {
     struct rdma_cm_event *cm_event;
 
-    /*
-     * Coroutine doesn't start until migration_fd_process_incoming()
-     * so don't yield unless we know we're running inside of a coroutine.
-     */
-    if (rdma->migration_started_on_destination &&
-        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
+    if (qemu_in_coroutine()) {
         yield_until_fd_readable(comp_channel->fd);
     } else {
         /* This is the source side, we're in a separate thread
@@ -3884,7 +3872,6 @@ static void rdma_accept_incoming_migration(void *opaque)
         return;
     }
 
-    rdma->migration_started_on_destination = 1;
     migration_fd_process_incoming(f);
 }
 
-- 
2.50.1


