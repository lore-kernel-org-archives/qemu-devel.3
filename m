Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA56C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4hA-0005Lx-PH; Thu, 06 Aug 2026 16:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gR-0004Ki-7A
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gM-00053C-62
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1829901b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048031; x=1786652831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xLe0/DHX80s0USXiFrzk4okArGfVrM8T/PSH/T6ddk=;
 b=GRHeOY+ey1gwdKCq6k/cjtuXLNWVpCEWleH93jvZWhgBRrE2QOBdK/AKtFuCiI1+dr
 1UTliIIKykNEI1/BGzQQw0TT+qDv7xKn1za6cTaNkHTkIj4zxgxdDNcRXcRIIK+SELka
 3u+wu7PKdaja+EVZQgzVqhxcZMGPTiud7q9wYdqVy55703Cg6aypXjAOvYsIPDu88JkH
 nUDzvVrCIOLj/lvxqTh2+XVtJpOaPPVG43J/IqtgVi53NYzbB6/8jzjAkHAiXpFxkIXa
 LXrA/ljjE+4aqiQz/LtJpg2k8dofuo7NtHuCp03sNAAOlU60V2abbtetZuZhrVwcVVD2
 wIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048031; x=1786652831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xLe0/DHX80s0USXiFrzk4okArGfVrM8T/PSH/T6ddk=;
 b=N1Y1ONdco0NUY5KNDxDT+AF6bLGJ/2S6pLfEsJM7XnnGN6u0n7qpTOkYmBfqhraYfa
 ubZP1OWKSXUPXEW14H4g4cuuTQwjEBevmGuSB1BImfRcLKImc/hObZUCns2SISY3R9lL
 UzQjMfNAxnGtKPo95P2OlivdLWE9kiq3JYpdf7uHZHGI0rk3Dj+R/saC3Me8Mh/fhqiP
 XgJHlyYnJjpVgqk+4q/V7hf49Fu/0aiQhix5+zVAIqx064y+BMHP1TQDG0FIPpAhy9iV
 pPBIk1zQPLzZPGEktc/PpUVwsS+1gQoCE1A2eyMR+1YsGfrc7vMJapZBVG7gZxSZPfRz
 FErw==
X-Gm-Message-State: AOJu0YyUQ7qhj/UaLLlSrIvCPrhZFA0x/PwMMb8UR4Jx6JT9xxB4UP/S
 sQGJ3Cn8Mde4wv58uo7YFrkIRyfe4p4GzA6CIRl8zN0GNDJwA1UqceuLQlCxfa3LZlheGiCM
X-Gm-Gg: AR+sD10CxAKE2THDArk1adHtJkxoOOlAgQKv6n+1cAAuAeVowGKEpYpChfPF8EhMgWm
 3UPbJseaaH+pJp5hcEpaUj4lXtm0YJw1DNqmuTpI2BLzVposhQYCB/16OXqAWBfZ6GK/reP45m/
 Uz23GZtXriMKwJ5FUIg3PWu3CTmBbfSYEsPGy9PkWjPrI8WwGOku1UFUkKseRnKsPpX5FJB1Hc6
 U4C6aYXY3DYtEgN5WigZ4nfNEQQM8R/IeS49UuE+74KNVyxyx3liuP8vtq6ZNvpCsQ6FN86gDWO
 TgIKlsOZXVpvANg5I14xHqcWAcf30eOM//ZXtRVpxNHTsSs8HL6fHNx0uZrBYRDDxLz/Ke34tim
 wQ/wp1PqPqaCZZ+1ap8FxE7t/E9NsNAbsDW/mxTr04PpZ289oq1pOHMsamf4ktrVS7k2xTG3bJs
 IDHiRKjLYMWqlffjS159716DeCieh3f2l2L9pviZ5j4KKtwRwoO8mT1UZrys0CohoR+joeteHv9
 HmRVd34nrN6Djli
X-Received: by 2002:a05:6a20:9c98:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3cbadc97c0amr5273212637.27.1786048030899; 
 Thu, 06 Aug 2026 13:27:10 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:10 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 12/15] xen-block: Update tracking iothread users with
 holder name
Date: Fri,  7 Aug 2026 04:25:21 +0800
Message-ID: <20260806202531.243806-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42a.google.com
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
2.53.0


