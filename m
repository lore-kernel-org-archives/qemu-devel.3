Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A94CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFz-0006sb-Oj; Wed, 27 Aug 2025 17:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFk-0006lb-SI
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFg-0006tH-UW
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgrB5bLxHrm1xpnWIfBaM4kPp921Ztrd8kQ2hHRTta4=;
 b=RhUUZX5PwqwwR/W0x53k8gLLeinoypKUgjpS+VsWqmNJpJYudWuSnT0nmeHdbOJ5mM0+mN
 44OhGmjHgXeA8YFF94nJosu7xGgJgwbJQ6wVbIR9iAbMTv8mAjqnAIEDoZRBx5w13m6PB1
 PMwtaU1oLXJxisrE/W+dvPG2/K3Lu+I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-y9YDj2vaMLirSRHdE5yEMg-1; Wed, 27 Aug 2025 17:00:11 -0400
X-MC-Unique: y9YDj2vaMLirSRHdE5yEMg-1
X-Mimecast-MFC-AGG-ID: y9YDj2vaMLirSRHdE5yEMg_1756328410
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e96f22abfdbso284988276.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328410; x=1756933210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgrB5bLxHrm1xpnWIfBaM4kPp921Ztrd8kQ2hHRTta4=;
 b=ZXTU5RdwrAxpmTKp73DFIdMO7j3salVNHixHMRAzIRskRLXOUM+8xvyWXcNa4BvyYe
 U3ZhUedBji94QsJLURReqgVpkwtkM25k/YDYy0kLPj0jZIiWScCUTncxbcMfdDq0dpHb
 G/5ka2cFMu6TTg8TQF5/PdGV8q7NpWUVk1fNj0f1xuip7WKebFjv2C4pmKMp9kuOVZZ1
 6LPsRsJHXsdcadjiwHeh4s8vpTjHNVLwt2k9SeE3cgz641blgEG64iSlklR3F7gvLDVG
 jnXGLws//ucAjsI+MgWjOkFgpXFVs4broN5RB2wPwgWItu0BOKhmexRSgZHiuIxDLNKT
 cDXw==
X-Gm-Message-State: AOJu0YyDd4dYHDiYGaUBFpw3Xkj9z8EkdLn8/ng6rUouuPBNoulNHjH0
 UE/KHAx7DV/LgUqqQ+qOgikFF3wZ0CS+nWl9pGtlVIO628KNCr3sAR8t+QbdDbvjNT7SkOjRGrl
 BhE6fIyOJjjMXaaJKoFx3tkcqNsu1tSzlGF/AI/QbX5g5QkZ0z7dRfYKczAVq0ILWFpsl3RB+H8
 A/Lqc7bcxqWN6S1UEyDdRrvrEAwK8+BMgoiDFSIA==
X-Gm-Gg: ASbGncthRPLAQWY8SeuNHdTl+eq3uuGWHRWph0qR5J2iKmdYB5Q79/rm2NvDH64d2sW
 kD2UI+D2UzFMMLSIby8j8157NmQ9rOCHSJIM2v9G8KGhL4p4v7ivz0C1v13A+6S25VWAS1M6i8U
 93hL32TWnoUj095qrHx/xLJwXbNxCTTGsSHfHfU6LJTpxLkzoJWhSfftQqbYnQ+q935GsloayTc
 7QL4VmfG17vCPPFbxI6/PapOC69gyM1pYA61xfXwgUj9Sl3C9KBCj+lagEvDHuBGK3i9iyyiCYe
 D5A4lX9hZL9ENp3pHlOE6uI7V/ZcyKSXNF6uTdma05EqinUi4Dsjqk18ZFXeZjQWGLUXZjjkFMq
 1OgmwcBd5Oa6jw4AFB/g=
X-Received: by 2002:a05:6902:6103:b0:e96:cc86:35c6 with SMTP id
 3f1490d57ef6-e96cc863ea7mr11007142276.4.1756328409702; 
 Wed, 27 Aug 2025 14:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0o+nCqM+esQ8D3PwolNaoc+8hlRauEMCjg08XSw4QO+27kXbVKe+KKeiN3J2VoDB1h/X/CA==
X-Received: by 2002:a05:6902:6103:b0:e96:cc86:35c6 with SMTP id
 3f1490d57ef6-e96cc863ea7mr11007070276.4.1756328409085; 
 Wed, 27 Aug 2025 14:00:09 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.14.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 14:00:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 9/9] migration/rdma: Remove rdma_cm_poll_handler
Date: Wed, 27 Aug 2025 16:59:48 -0400
Message-ID: <20250827205949.364606-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

This almost reverts commit 923709896b1b01fb982c93492ad01b233e6b6023.

It was needed because the RDMA iochannel on dest QEMU used to only yield
without monitoring the fd.  Now it should be monitored by the same poll()
similarly on the src QEMU in qemu_rdma_wait_comp_channel().  So even
without the fd handler, dest QEMU should be able to receive the events.

I tested this by initiating an RDMA migration, then do two things:

  - Either does migrate_cancel on src, or,
  - Directly kill destination QEMU

In both cases, the other side of QEMU will be able to receive the
disconnect event in qemu_rdma_wait_comp_channel() and properly cancel or
fail the migration.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7751262460..da7fd48bf3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3045,32 +3045,6 @@ int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
 static void rdma_accept_incoming_migration(void *opaque);
 
-static void rdma_cm_poll_handler(void *opaque)
-{
-    RDMAContext *rdma = opaque;
-    struct rdma_cm_event *cm_event;
-
-    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
-        error_report("get_cm_event failed %d", errno);
-        return;
-    }
-
-    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
-        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
-        if (!rdma->errored &&
-            migration_incoming_get_current()->state !=
-              MIGRATION_STATUS_COMPLETED) {
-            error_report("receive cm event, cm event is %d", cm_event->event);
-            rdma->errored = true;
-            if (rdma->return_path) {
-                rdma->return_path->errored = true;
-            }
-        }
-        rdma_ack_cm_event(cm_event);
-    }
-    rdma_ack_cm_event(cm_event);
-}
-
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
     Error *err = NULL;
@@ -3188,8 +3162,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
     } else {
-        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
-                            NULL, rdma);
+        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
     }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
-- 
2.50.1


