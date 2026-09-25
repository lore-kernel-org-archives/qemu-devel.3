Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF56C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8R0-00060r-2V; Fri, 25 Sep 2026 12:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dc-0007sy-Q2
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:12 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Da-0005yI-Vv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso9245785e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351529; x=1790956329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xyCVIEiWAWEWFWWLsQfxm3BQ7wFhpZ59Cs/kPlajGTY=;
 b=GqFM6Ma1fV3l2w8xpMoELN/n5to9c/1IFknjUIm6rfWD1rxvHeBFQBTpTTMXqXfkGs
 FuBUu31Ya/kSTxBaHcKNCWkhL6ObrApxZ10Pn6R0MA74zNsVFVT82Zz+UW8WKTO1r4m+
 e+6gKlwfsgyzOTs9nub3WdRzfk1J7JppBk/bXJqr/AB3AJIbqZYS+CJLqF5xSe0/e6OP
 gk5e76OODqULoLRxxM7BHKYtgrlc79VIIsU9k7zYSFtwdF3ptwNKQsWgSd0q0UBBaOtq
 8ue1yFqPG+ahEFcFXXP6hrvVEW1vL3kfZSbALPu6sNb+spwNRgj8tqd6H6A5hsXLkuOl
 K8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351529; x=1790956329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xyCVIEiWAWEWFWWLsQfxm3BQ7wFhpZ59Cs/kPlajGTY=;
 b=oq3ogn2ADZ8O1wyijRaUQ7SEEwqrmuoDFsiI95J9U2ZPSVI3KpNBWMzKduKUwp6JmG
 Gm4sHHrRHyOQGIcEuS1KwRnq2H37T2liTvAEVISOAF2mz4H9TbLaqbkTgBl5gYDQrASg
 gY3a9UtX8VxWyQjAgJKtddFPst8Lfyq8aiNKSk7IZMT4W/PKdzd0z66ytsPTtyNHOloy
 qjz4q6N/6jYCBPW/b28kdUGz4AlMRpaySCT+hpbqovveBn68z8ZHJXtGlaG76G40iK5B
 vF1vB+W7j8wKx8P+xKH1TSDQRyCCA9h1BMP7jV8hPRX4EwUA+KrjWQJp3yqPwgrug/fL
 G8ug==
X-Gm-Message-State: AFuF++k1GOhUSBsx7NETJJqQYv5FOxtRi2HqLu+NTnnKbI7nhHtU2EzG
 LwNPy+D2I+IzBtuchxIpe834s63XLHxJO8EqwTT+GLE5CnNGpzgaStGdc/SzU260UDXpIbu+MsH
 UPIJqiXP6bQ==
X-Gm-Gg: AYBFou18KeK/fm1UbXvfG+xfiVfRprfLvxEUCNUgPZLUtHAsx1GmiIrjaJ6n9S9B33b
 H2fbbRQCjVkRnuDNuJgfDqdehOobbpG6iPdcEVbBD84NM+DkIea/Ro2qmuz1H5I0/26Qdla0wMY
 9J/PStmiTSfjzXItVYxaPCRPlSisN8Ynz+dk9q6ycRzP4qUXGFvvBQSkDV7ala6RvDoiLZ56cIB
 q963Amh7e3T2iTwbUFfXAxpR6SpDu6unbx6YHMMr/zhwZj4CljG3cR1z3qlYSWFciUVXFc0/jgg
 kGt4OtQe4AqJoTTxUnri5aQTq+/qji3wM8k5iqgTAe6Wizx/CBG1eyZJOls1+xnUNrZ76ubKIa1
 5wI30QkBY50BbLYK07Uh9dxB/UNldBqCvoMvJ/tARZrhFNsZALr4dxVi1nzchkixLD6FebvQmii
 I6J9X1m2obKPZBbmsRuDE6mpN1VnY3XfCjSeh1NyZccSegQzjhsFNTnPyM89dgoqR8DMhhs1eGf
 r5sW9HxGtcolTEobko8LT5goliZp3B/p7rFxvtQkA==
X-Received: by 2002:a05:600c:630f:b0:49f:bd3c:bc1f with SMTP id
 5b1f17b1804b1-49fe66fd51dmr109898975e9.26.1790351529377; 
 Fri, 25 Sep 2026 08:52:09 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:09 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 06/13] migration/rdma: Extract qemu_rdma_write_file() and
 dispatch FILE
Date: Fri, 25 Sep 2026 17:51:41 +0200
Message-ID: <20260925155149.843870-7-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::11;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:00 -0400
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

Move the per-iov QEMUFile control-byte send loop out of
qio_channel_rdma_writev() into a reusable qemu_rdma_write_file() helper,
and route the consumer's RDMA_CMD_FILE command through the same helper.
No functional change to writev, which still sends inline.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 62 ++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d11f6e0da8..5ec6a87819 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2523,6 +2523,34 @@ static RDMAContext *qemu_rdma_data_init(InetSocketAddress *saddr, Error **errp)
  * SEND messages for control only.
  * VM's ram is handled with regular RDMA messages.
  */
+static ssize_t qemu_rdma_write_file(RDMAContext *rdma, const struct iovec *iov,
+                                    size_t niov, Error **errp)
+{
+    ssize_t done = 0;
+
+    for (size_t i = 0; i < niov; i++) {
+        size_t remaining = iov[i].iov_len;
+        uint8_t *data = iov[i].iov_base;
+
+        while (remaining) {
+            RDMAControlHeader head = {};
+            size_t len = MIN(remaining, RDMA_SEND_INCREMENT);
+
+            remaining -= len;
+            head.len = len;
+            head.type = RDMA_CONTROL_QEMU_FILE;
+
+            if (qemu_rdma_exchange_send(rdma, &head, data,
+                                        NULL, NULL, NULL, errp) < 0) {
+                return -1;
+            }
+            data += len;
+            done += len;
+        }
+    }
+    return done;
+}
+
 static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
                                        const struct iovec *iov,
                                        size_t niov,
@@ -2535,7 +2563,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
-    size_t len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
@@ -2561,29 +2588,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    for (int i = 0; i < niov; i++) {
-        size_t remaining = iov[i].iov_len;
-        uint8_t * data = (void *)iov[i].iov_base;
-        while (remaining) {
-            RDMAControlHeader head = {};
-
-            len = MIN(remaining, RDMA_SEND_INCREMENT);
-            remaining -= len;
-
-            head.len = len;
-            head.type = RDMA_CONTROL_QEMU_FILE;
-
-            ret = qemu_rdma_exchange_send(rdma, &head,
-                                          data, NULL, NULL, NULL, errp);
-
-            if (ret < 0) {
-                rdma->errored = true;
-                return -1;
-            }
-
-            data += len;
-            done += len;
-        }
+    done = qemu_rdma_write_file(rdma, iov, niov, errp);
+    if (done < 0) {
+        rdma->errored = true;
+        return -1;
     }
 
     return done;
@@ -2928,12 +2936,14 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     case RDMA_CMD_REG_STOP:
         ret = rdma_consumer_reg_stop(rdma, cmd->flags, &err);
         break;
+    case RDMA_CMD_FILE:
+        ret = qemu_rdma_write_file(rdma, cmd->iov, cmd->niov, &err) < 0 ?
+              -1 : 0;
+        break;
     case RDMA_CMD_FINISH:
         ret = qemu_rdma_drain_cq(rdma, &err);
         *stop = true;
         break;
-    default:
-        break;
     }
     if (ret < 0 && err) {
         error_report_err(err);
-- 
2.39.5


