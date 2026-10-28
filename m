Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0586606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRXSdGX5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzw6-0007N6-Li; Wed, 28 Oct 2026 05:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzw4-0007JQ-Iv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzw3-0006iQ-0a
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso4228105ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179626; x=1793784426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+ZI9HPiEEreD00eCRzRf4GSQf4yCHaMnrIQJkGq+YM=;
 b=JRXSdGX5mKtKTS+h/5aX//Rmk9yDHIGHanRvKu/oK2w60JPIKfhgWiJEUsdzerz3Go
 ZzFQrhkBkKyAP5C2G72cIH6IEm/MqoFWNLYDoBjO94XkgR8GKxwpYc8tuPQpjMf5nUFQ
 hEAYUpT7QW6SE2tbY8ale3AjwIjzHGFC5hBgjAMmNijTLPZbayqsvXJXHZxmIQ/VMwOh
 vkhMQ2fAjGZGhGjSSjjhcONzGOQ36+C68s8ry/NW88dztAX/UuUyXALi3tnzRbL4LNil
 I+k2Ox5G7GE/dJk6vxpptLiTUqUCOg79l+qQrOpkSiR1enne6c2vugdQG1NhgxR4+Gkz
 R/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179626; x=1793784426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+ZI9HPiEEreD00eCRzRf4GSQf4yCHaMnrIQJkGq+YM=;
 b=MMlCsNpz+hoP2SntnH5igHNfznPitXMmrgqa6sQS9bsHhkJBY7+UbUGjZCZh1Ai96h
 nTfyMaeT5VuZKxaU2DOKF6KjPaaVxXqgBt6Ri8oF5an8J1SmYNuhFJ7JfXH1+pyyd09U
 Wrn9QWQMmIyby97jpYMlbYKdo5k7ZNGnzMnEfO8zsrgnR0j0kxYbH0065EI2gigWJcdB
 E4G/LHdyJhabznoGSvNWv+syevKTmx763mLvSoN/18pnG+gIEkBiOgpQ4OqVXtcGpFTi
 K/8tcoSNdJ3t3owBVWHr6Cio2x8KQqpxLUVASVUvdXhRT+RcO30n+LE2AYsd86McTZDf
 IFBw==
X-Gm-Message-State: AFq9FYI5Jd0LSEs/2ePa4XbuVCcpWQJafSVpAi96HsP8iPgxnnC4IFIj
 OrjGgwG1HjIoqPa9yPJSXIEYbfLx4ZH1Iyg0SWo6edvDFeDHSRuUC79r+JcmZQ/j
X-Gm-Gg: AYBFou0aU21P5Jtjb8gIOcEfp3DO6OMK+jXXBzRXVyUarjudnQKg4YofG0vJodkBRMj
 AAcAx+9dxnYoCouvRDlB7RLuCnmqd1eMHZsySYu4C/dB6LRrxzkZrhzmEc4XI22wWPym3kLqn8F
 /LNRAVapAWFb0HU3qHlALRvYgpu3Wgk+m0Bd9/15luA6vs7Fu/m5Kwd2PV8jPRJsSfr/echwuPF
 IVhDvVqWoHqMufcJPGoZn6hz05Ck7HS+mZvB/N9qyNsNE8i3quTeSDJCZJ54MQGfWNz5Xdy56/B
 7pLinYqcIDmsXzx2NWbVvm0QqN4o9Jblp8zqxVoZ7WEsV61mLE1/OkW6dWBGYD3fMS2aRyX4wol
 SVTsqrwn+9DDdNRXwdMAGxFyWXwimv3BkBIPJvzyaWAXXggigv29Q32Pt/432LZLaOg3d/0GBuC
 /Ybgod8WZUzGbqVk/eIA58IlSgIcPwOJ/NR/AzzUcScb10ldCgADOvFX1SiHhlAwGt9U6/HN1LM
 up6IrUJe2C0TjKtoqluWwfNCjDDh2zNTTjqiLW55x2UoNqg9tMruD2P2OT9ABbU+29gu4USI8z+
 C1V2NoguwMLHQtO/OkknrOpzR9Lx6Lv5eSGL5KN9cW1CqYy04hpUyK8GEEo=
X-Received: by 2002:a17:903:38c5:b0:2e9:61bf:6587 with SMTP id
 d9443c01a7336-2eb0042ae58mr17988115ad.49.1793179625585; 
 Wed, 28 Oct 2026 02:27:05 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:27:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 10/14] xen-block: Update tracking iothread users with
 holder name
Date: Wed, 28 Oct 2026 17:26:15 +0800
Message-ID: <20261028092619.1654474-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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


