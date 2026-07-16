Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E6C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPn3-0006zV-4B; Thu, 16 Jul 2026 13:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmz-0006e9-MD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmy-0000Vz-8v
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cacf197759so60302575ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222540; x=1784827340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=kVOiPUXZZ8SRPpHMZIpYX3KU2ji/FuR39Yb/rCT9pnh4Bw8T7/VNez6rDR5kYUSXP2
 BSzIMyeKm7MsmyYlYtEPi4aON12Y38M9vhzQ00+s77DDZsBByGgiQjJh1zw6DA4y8bxe
 elqE3vEb+6o4oHUBLtfuhOxcNGWIoowVpOBy0eQtVAUvzaTIr1cjTin+xRJ7WPm1Bfvq
 bBzdcKHZILIOTB3JS9sqMSaWcQ6ow1Kphzcd4fd+n8DVUQxDrh3T/QTFJFh4q9GA5Euj
 Oy1KP2X5e7hAlek0Ej8ualYquDKD+V2wO2KRib9KJSAD/jK6pPikWV0YiB8RRqF+p8nN
 kYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222540; x=1784827340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=XxG+4LSn03FDuQ4gQAtDxGr9ozS9xwy3RP3UyZBu/eV0PaW29qxveWjPJsiRUBtupP
 zp/ZKv1AELzCxy0BQqiRuS2A+xm1C6koLsvUfCpcXj2BO/x+YB9P0Ur7JMwz/iHdWHWR
 J8lYSgSXLH/cb9equmPWueVDYKY7F8uzV6y1Wy3D9WhewffFXXEHRzZpFV1iL2/+tM3X
 dAZUwUVfoSuc6shcpGrS5NTk4HUcCDe+flBQndY2I+oCbpQYE4+x9tlIpo3Uu8ly93qa
 hF6Rr/KD/n19Sp62KV6sHmgT/r/VoApi3xqbY5u/qJfOC9/JJO5fKDAZbv60a+7yofyQ
 CRow==
X-Gm-Message-State: AOJu0YxmsSkUkFLWSIR7mew5NUGlMPrzVbcEI8RVdXJPM/F+afyWqCLt
 jUYw+PgVvZP6BqqHev6DSOrm8MZeynSp61QKbLpXLXmRMH4yb7IvqshzqRqQ4ycjGuM=
X-Gm-Gg: AfdE7ckE55XFFCo2Moqy4RlYDawf4/eT9vuvTP7hIbZi1/7EYYZ8Ehym84gIzvFR1H0
 Xc/aOMPrJG+FbUnjF6GXvwwgBk/WiR5qsTGy9eUdz2THAGQzvEMeB39KJMndZbH6YQwRBQUzz1r
 f5P/p9o5c3uy7Arp3d91VEamLwkPwoVt+IG/JvvRorDFEOFVTFbnfIyTrrO690wwPDdcSi4qv56
 N5hfpEFNw36ZzPkrDzM6ot1/pYFG6pPdmwe2dHy49TXvidp6XQ/OUx8zw/bZvLfFWr+vWfefW75
 aSNoK7BHcLutzI65NvOdQ9LMRVG9LQCm+9efVh5SN11V85JqRCaUvybqGIIZ011ibGCvhf5rREd
 0rmehx2MKcKoHyLFPSTezm4yKXFfvCvGILfLNrYQkQj2xls3+dGoGAbVpBVhiXl7nO9QJdeNJkH
 pP2BVoDfOwVU6cvGGXQGB/zDUVnlGuqA==
X-Received: by 2002:a05:6a21:9d48:b0:3c3:7d12:a98c with SMTP id
 adf61e73a8af0-3c3a5d796aemr38943637.52.1784222539931; 
 Thu, 16 Jul 2026 10:22:19 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.22.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:22:19 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 12/15] xen-block: Update tracking iothread users
 with holder name
Date: Fri, 17 Jul 2026 01:20:53 +0800
Message-ID: <20260716172108.87700-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..b5bf8d359f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
+        iothread_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.49.0


