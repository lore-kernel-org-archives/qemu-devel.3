Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A3C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yB9-0007AO-Dy; Fri, 11 Sep 2026 06:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAv-0006cN-S5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:06 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAu-0007K1-8C
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:05 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eefadfso1420395ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121282; x=1789726082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=tAtf+C92GSnfQL3Litdjw5/Rj4XVGyqMSYVaHv1yffSg3Y9GMVozBugzk8Erw1FRtI
 9r+r7p4xTakQyG5F13hx50DbtTuv9kcBbzotVnUk5WgCkD3FcIqaeejwGCfDq0fccUX4
 zM56b0ZUO3P3djJgUAYsWaleGJMpOG1CkWypqrnBZyOsML/HyE1W/MFbZBl4BFGwhqO1
 p2OhG+ck0+r06AIy8D6OHDpnG1h77vkka6jO2wl+TLf8CTuF8E0HIUV8IgE3CqMPWcu9
 RN3g95AEk9R0IgZkNTOITGG2CHxtRT39axLAXnGnhVJkEfSk98Hu5QjQl6AHVek7CbZV
 hTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121282; x=1789726082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=Hv9pZC2bBmQbIdKdBmf4v4T6KvGDwqovSWBTyhJLmnjKH9BvyZM5wgWcRLNqudKJXz
 RCCvtDDjIqhoAplza3MoFgRXf6m7a2PfPGbaLEX//QR3kAvt/yv2gBnVC9w4LoQkbKVM
 xpYYzFdVJJkuwUsyrPhF7c6FRbJJwjhUVO035NvbDqPo6zAyfCuKSS+aDGTpNIDN+iVl
 mehbQ59/TbUd/v22eeV3PA7T401KHT1sGJQ2aFdK+UioE/LgfASg9myUzFpdWgzmRnsw
 vSrcKK6kynhK8tTWMP6Coq07TvsrflWPVYdViR+ssgWDsRqKSAIpOhTLnmrOvl3/0ljp
 CM8g==
X-Gm-Message-State: AFuF++nrFSec0L8KTfUXIh31vNL5pE7XN9+D8weQJkcF7i+wDvnGnRyE
 87eEmySldtDcZ23YqOZLNVEVHnaPcmU8Sa9bW7BR2vJHPU/TH/9q4tovSh91tTmGzNo=
X-Gm-Gg: AYBFou0InffUWPgneTKEZoCqxk5DrpZNMUuXeUCQYWgCqzlilOvEr+tDxowFEi55X+/
 Wg703TKWdZ5ioafchzOMmVyboSTO9G1nVechlfngPzTtc3VPPjevcmeUJJt3l/AjzBAfllbiXjX
 x2kL0EukDPeJ0pbWx7ZuA2F4bWKnYdaRlAyRemuJJ2G49ohVhw44nAd7jgair6TDtdjfs0PiKQ1
 ArqT+lbMqElmAQT6MIYcOkhY+hfmNgcPz1H9WsO11GxuRrcSi6HxHai9GVLrxKLX/HzPFITSN7g
 KIW8SM5BP3bKqJdwhcio2XY7lxW32nJC9XFOKD95drKteKQnY9jmWD0LbiPhe+KCcefh5t612R9
 uisnv/DY6KFfMxksJOzp01bnNzesAvH3fWg2pUPPyqYVG3pFZExy8UN4kg4xpILSaJhvVujfsKg
 DaSHHnYDf0X5xrJQM4UxnvAo0LVQCwTQeVKp2Uuu0ScYbf2H+0KjuzNUkcz1/PbBXJigDOH3ofg
 Zn1CUOjoumz4lkZI0P4tA6KIgs=
X-Received: by 2002:a17:90b:35c7:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-39d97eeba04mr3573329a91.6.1789121282513; 
 Fri, 11 Sep 2026 03:08:02 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:08:02 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 10/13] xen-block: Update tracking iothread users with
 holder name
Date: Fri, 11 Sep 2026 18:07:06 +0800
Message-ID: <20260911100709.726366-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
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
2.43.0


