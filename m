Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD83C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwp-0006Vb-6a; Wed, 26 Aug 2026 12:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwm-0006TY-PT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:56 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwk-00034U-LJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a5e866bca0so1483978a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763473; x=1788368273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AgMaBiRcFOPbEemdJbEgsISRcRJz2Jh2uGEXsfazQ8Q=;
 b=NNQ5PyQyxIfnytJL26w0RgLC2gDBmFvIIFpIZAMQlL6H2+w0PggA8EZNtUJxeZ3WQQ
 lqMFCdZCD/Y4mtCU9jUzX0Tm0D0RyXy/ZHFbFU+Hf0MKQGU6fF11acLN9A8LE22Jdoa4
 PLmSY5tW8jERWvsc4GWqbjwBGJh2GQAhbYOmB7hRd87t6H5v2r1AzUTEu5mqtC7WuVgh
 3zFtamfJAX8+zxm7JoKHG+eZBIM0jODUDJoLARsa/McQX1hr03IhnOgEJQN0cJ44RRny
 8Z3hPgRjr7H2Y0y7Lg2uIi2l79o6edLuyRvuVXSFTkfhKw2FO1fFDlmJDgsfSbyQeJ8X
 EsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763473; x=1788368273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AgMaBiRcFOPbEemdJbEgsISRcRJz2Jh2uGEXsfazQ8Q=;
 b=dOE0vMWBFGcwQ4f6lbulXbpTLy1XWlP3ohtszSzjUo7RCYXV0YS39AhO8UiD93Pyqw
 ju6/yt6CJoEbClFyfGeJTKapuC5bKXNRE0a2wrRMW8rc/pD20pdmYUBjlb0G6jHr2Oou
 jHQ0+osnLlaS8EHYd9foLuXJ0aWezJzckBsl6QMF2rOnecBoaAwR3WKMdI1V4PWncUYT
 UK16bJagA7349elgqx5uEMWc3qSdZXe1fHGSeTA2SzzE7luIpt5wpdzaPpE3Q57WNDcd
 ShKdH3ZuYwLFcUimdNOIzOOahtNx8Qmkh79GPs/zkuWzTMENHv3PYmaXcclfhjq5r0uX
 kqkg==
X-Gm-Message-State: AFuF++kEAuexLZqaECp7x90zgbBgvLjBvYafi67AJ+MhQXYCt9pmKEpE
 zu+7ZWFGFJl+ZGVLQTC10Liz7W/b0nrj/qVzMWAyIVmv2r0nA+PSaDXVs/aZGXji5FVzzM5BXrW
 XHflz
X-Gm-Gg: AR+sD11/mUcUP+OMM1jchiOVu5j8soqrhdtLdlnhZVEyewCAaJuznUO2e0qgAOtICUX
 BAXilZ3PnRC2dy6CAOol/7zDfJGJaGWJgylTKZj+O5hBcXO02mfo4l1Uin6SIEE+ED2rMtltS7j
 0+cgJuzkR+HkNDlA1/T7t64tgTzPBIwVQ89ZFkua+kpFBy3ruHBR0ZJ7yAV1Le9ctu+1nrjs8Qa
 tLxYYu2K7/KtZsy7RlECb0+pIYLo1+XN2M1STUP8OKO2IqzzNHJMBMwqc5xDznrrK7jTxrxg2Ib
 Fq0NgzCz2ACWkBHjXUGSycI+DLId/zUx8TTur6XmR+5Si5SWBF+FXe8R07rI+lZBy16pUYofK6l
 EdOlxbfoQVtwfulfabTg79CSxF41I11y8+D7eCkG64V22gg68XZisBC1YnLiriYGOgMo8NIyj6w
 cM/M9Lc2sd0fYpviu12L4UwWo1maUfsryMgfnEgVL44MoZW+4xRPeQG1iT
X-Received: by 2002:a17:907:7203:b0:c20:fda7:1856 with SMTP id
 a640c23a62f3a-c250bb76be9mr946057766b.8.1787763472935; 
 Wed, 26 Aug 2026 09:57:52 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/5] nbd/server: accept NBD_CMD_CACHE above the maximum
 payload size
Date: Wed, 26 Aug 2026 18:57:44 +0200
Message-ID: <20260826165747.3768674-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826165747.3768674-1-den@openvz.org>
References: <20260826165747.3768674-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=den@openvz.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

NBD_CMD_CACHE carries no payload in either direction. The request is
a header only, nbd_do_cmd_cache() passes a NULL qiov to
blk_co_preadv(), and the reply is a bare status. Still the server
rejects any effect length above NBD_MAX_BUFFER_SIZE with EINVAL,
which forces a client to split a large prefetch into 32 MiB pieces.

The specification does not ask for this. The constraint was renamed
from "maximum block size" to "maximum payload size" precisely to
separate payload length from effect length, and it says:

  For commands that do not require a payload in either direction
  (such as NBD_CMD_TRIM or NBD_CMD_WRITE_ZEROES), the client MAY
  request an effect length larger than the maximum payload size;
  the server SHOULD NOT disconnect, but MAY reply with an
  NBD_EOVERFLOW or NBD_EINVAL error if the oversize request would
  require too many server resources when compared to the same
  command with an effect length limited to the maximum payload
  size (such as an implementation of NBD_CMD_WRITE_ZEROES that
  utilizes a scratch buffer).

We already follow that for NBD_CMD_TRIM and NBD_CMD_WRITE_ZEROES,
which carry no length check at all, and our client assumes a server
supporting extended headers takes unlimited zero and trim lengths.
Handle NBD_CMD_CACHE in the same way.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 nbd/server.c                          | 4 +---
 tests/qemu-iotests/tests/nbd-commands | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 78ec984409..e6c47f8c2e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2718,7 +2718,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;
 
     case NBD_CMD_CACHE:
-        check_length = true;
         break;
 
     case NBD_CMD_WRITE_ZEROES:
@@ -2752,7 +2751,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         req->complete = true;
     }
     if (check_length && request->len > NBD_MAX_BUFFER_SIZE) {
-        /* READ, WRITE, CACHE */
+        /* READ, WRITE */
         error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
                    request->len, NBD_MAX_BUFFER_SIZE);
         return -EINVAL;
@@ -2908,7 +2907,6 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;
 
     assert(request->type == NBD_CMD_CACHE);
-    assert(request->len <= NBD_MAX_BUFFER_SIZE);
 
     ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 73baeb236f..d2715b59a1 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -108,10 +108,9 @@ class TestNbdCommands(iotests.QMPTestCase):
             self.assertEqual(self.allocation_depth(h),
                              [(size, DEPTH_BACKING)])
 
-            h.cache(maximum, 0)
+            h.cache(size, 0)
 
-        self.assertEqual(self.top_extents(),
-                         [(0, maximum, 0), (maximum, size - maximum, 1)])
+        self.assertEqual(self.top_extents(), [(0, size, 0)])
         qemu_io('-c', f'read -P {pattern} 0 {size}', top)
 
     def test_cache_past_end_of_export(self):
-- 
2.53.0


