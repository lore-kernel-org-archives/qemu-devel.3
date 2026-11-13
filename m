Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA4606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NHh1+IuS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYr-0000hE-1I; Fri, 13 Nov 2026 04:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYp-0000gi-6I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYn-00061V-NL
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:06 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ed0e2015aaso4226655ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562023; x=1795166823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+ZI9HPiEEreD00eCRzRf4GSQf4yCHaMnrIQJkGq+YM=;
 b=NHh1+IuSi4RNXz1DP22aZGhEG59+BzedS2hWyco5SI7HctMohdEZPDKqX9FTqU56xQ
 z8g2GJoavmHENuZY3cT9GzgOsxIS/ULoPrKzMGugcU+JLMfKgqgry3mKd3ZdERFCN/+i
 tKtfwvGQgaNkgy20pbDPZTSbLkwN/CRxdowMO+rS+JHaofULQgS6rrcuncXqYflUXzwC
 /XvW4eb5ab8qbwwN6vjja3sbXE05RNJ4D5j6VoXjB7JjH0slY8TLUIljlXjIyut+5m6k
 1sVVe9XJZzDYZs7Ip3Zg65bXjF25D+KKLnX59WDMe4bGpgHCLkUbY5BOk2kRQJwpi4br
 4c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562023; x=1795166823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+ZI9HPiEEreD00eCRzRf4GSQf4yCHaMnrIQJkGq+YM=;
 b=IZkII/SkbcYJdh54AovxBDQSpFrDRWemxz2RCyTwiz3wXqm7PaI22UWwed9bpX8Z2+
 2AncT18N9RFRs7xVEGV1LtH28YRD4nhlxaUU50K8FhTVniIYjb+EvmRn4gRMe5AT3KVs
 PuYdqcwiK3XFMytC1okp2lIf5Ciomi2RTxLmN6QCCxtEzGk2nYuUaq5MlnDF4IhTSN7r
 jXux8zC8PI9JPYkChj7rSL01yxOab7V6ntz7vT+bigd/IBBA2bXmx8cQd9wpwlerrqrQ
 eirsYLFpPFMJlCLOlfvCyRMUTkGKSnC05DZeZ8VflO/Hiq0uI/os99WfRUY+ptiOe/6M
 KokQ==
X-Gm-Message-State: APuU4Z/zkWfVZ+kxkE9i4CamwiAFMlmFByJEo9PqFNa+cL/9wGV3uIrS
 gK6C6En/lZXafUIKz4obBxuB9jzGH6unfaafAA3glSBiucPDTD8fTP5wct7FPvz2
X-Gm-Gg: AYBFou1355s6KVeSU80CqTdoZgSPZfovj/Klt6WNw7zAbT+fHlCbb//W5UiqrH+UmLe
 mFTTLh7iJfIZxHlsXHXflNxIM6w5Y1whrfmXC/yq+m9GbviilVNZVVEZfN0T0mWNzYtmw5pcd/a
 Ruj756w1QdUpb9dwas64s3up2a/1wY+iOVbTMLRRA2MGyJnNMgT9QSSPavp+yjtdrw4vwJYtm0m
 CPoggde7muk0dS97KT9r8iuTxdBPZ1K1t1vlcUo9oRDFmiUgjOM6zQHqs0d8GbVux+jnkf2T/ce
 bMKzfJrmUqeTuYUwG59ZsXgyfRaFAImNPEfCrbAELjbqvju6JivI0TiJkIK/yQx3Q0nbOSMlVW7
 Y2isS7Blus4M55zgb+VQqu5M/jCezfjZlHVZHWgz0UL7Ywe++TIhOmhRPUbEAnDZv2ybFxVZyqp
 YX71+OO3nyLEBg3d2GwhcMTXdWUMcfwlZlBQPVLBhzXRkfMaMfP+GWurWnE4/Zlhj57SXE0vdGa
 v1w0wrovRPMSDIPA6/yDn26rWGnJXhZKAJh/0Md1AcjYcZNcdlgEl8+Bzgr3UDh3yE2kr7RsDCE
 XzOv82WNS1UVMBA1ayO1o7s8WppbpxijTazieGcr7P9jXRDbcqhx+MPsJI31Ay6TbhoVJcXOc/B
 zibMb8Q==
X-Received: by 2002:a17:902:db0a:b0:2e3:1ed7:d5d3 with SMTP id
 d9443c01a7336-2ee0dde7066mr19645925ad.67.1794562023290; 
 Fri, 13 Nov 2026 01:27:03 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:27:02 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 10/14] xen-block: Update tracking iothread users with
 holder name
Date: Fri, 13 Nov 2026 17:26:01 +0800
Message-ID: <20261113092605.942292-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.53.0


