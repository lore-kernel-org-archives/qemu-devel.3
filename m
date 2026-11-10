Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CF606AA56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=EJrF+hhb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOX-0003u6-0g; Tue, 10 Nov 2026 10:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO8-0003BV-D2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:00 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnO6-0008V8-82
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:03:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1410460f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323033; x=1794927833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xyCVIEiWAWEWFWWLsQfxm3BQ7wFhpZ59Cs/kPlajGTY=;
 b=EJrF+hhbfDZ1jr2K1Bn8HHHyxDKWeaN1kDASTCUWuu47a6CY2RRK1ExiyU56MdVkEe
 ivXpVsTJOtFsCIzOEfSuXW4VlMPjXbLXzc55Tu/iO9Bcn8pr/a/yJZ5vhkqlmvvxXTyb
 hStFSL+1mcm5NBP5BRf7LOLecXDmbIzxyJICyLaQiOzf6kBG5N+i53TCAMfLTosWBVuM
 bNif4Vbot/WOvAnZPer+uF2HPw2ZWj5FeFeKLz/pU5uADMdIaiz+BglqUFc9YBW20+FA
 +HPnCmysfWUkH7xCdO1xIYZH6la8a4/1fLIkpm8yWnmYKkM+uqUS/MlPtspHfTUVrqCS
 NNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323033; x=1794927833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xyCVIEiWAWEWFWWLsQfxm3BQ7wFhpZ59Cs/kPlajGTY=;
 b=C70z9c1k+hhF1oc5EFxSb2nT3E1eM2KcuMcLt0raaoLjmZmjY+g0eN5OqYy4icT1/p
 DaKxWgGyshmYdb0liw8N2LSN7/hgbH1+IXDlXpgBnGhqpHI7+DmSvSE1nWNoIORGLyxW
 ZJRj8QDj0iDbIpanUP0plrQu1ZS1PNMYOI0HZ5wFo/zQgV1JbJ+m7fQMmikqey0yHcGL
 twiAsmsx+z3cJt8c59W72d5pzHzGmg5TOkqxGN8A8TT0m8GLqsKzUmXplJ/fOHFwwZ//
 pXE9pD2ZCloRRhbPFh0vbkGtzmkLIOeJHtnY7bzuHoEnkOTUjuNc6sm5pjVXSIV3/HsI
 HXXg==
X-Gm-Message-State: APuU4Z8ehykQi87o7SAu3/burIw+fqMs+AiICO/nT8jDJr1QPhBqi4nC
 GX3Gj8NqPwTWUfHLpm4y2GW8hRnrMuCHFtizDhbzHhjz2bI9op+4M7YVABKUxwROsK8kmIfA9Z8
 YAnix2Tc=
X-Gm-Gg: AYBFou3g6sTk688QEksUqWewWoR01Tak2+CD1wcHVWGz51d06LDwNsLTr9E4Y2pZ3Te
 /WP5JDLogcMzXFjiVlxPkR78L4tAM7WJ4lYec997Xrt94CMs+1O+YQUzxpYjJ1wOu2xFaGR8Q0f
 HWsPuHvMD/XUQBM8j4vpKkh4x+NW0mg4yrM9w5mN7ex3C5xWe1vK+etTCsfu7uQZHRu7hzu4kcH
 ux2cYiLheoQGL0VLtV45CalgCM1gDVVuTaMQlKw+IKz6o6UbfUB3TQ3TosEwePsyacRwuZnluma
 WjcqpE3p9ZVgBT7/s6gsGfv3B8hu39D5ThiPUkuYhA5J9KNR5bbUuwOZaGrpDxQ+CSq9J5Fl2Xd
 pE3zgSWYcUkyT0DFrixQQuQmtESdOua/NonftDfQjCpH7p8jVEJuA8IePJuJc87tSAoYk1YxBv8
 DGL7dwcE7nGFZ7yJfn2RAgEz/qSdMkx4MF3caNdNFPY0S/SuqUNCqY/jk9/PGl4cJrnOubGRj3j
 kMriKrpjlv3ETh8jusH5F9nU57E4dN0Do4aqAB9ES4FcoW2p9FBo9crQtFKNRFuHzQBrCGUrdNu
 y4t95CKZ+v9qQd9xG9bWBcitqDtG+oMD6krWq/TlilPN3ChswRbYDnUyocHDJXTX2kLVufJ5
X-Received: by 2002:a05:6000:4a10:b0:493:72f7:1d5b with SMTP id
 ffacd0b85a97d-498309aeca3mr5638197f8f.29.1794323032793; 
 Tue, 10 Nov 2026 07:03:52 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:03:52 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 06/13] migration/rdma: Extract
 qemu_rdma_write_file() and dispatch FILE
Date: Tue, 10 Nov 2026 16:02:40 +0100
Message-ID: <20261110150247.193208-7-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::42b;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


