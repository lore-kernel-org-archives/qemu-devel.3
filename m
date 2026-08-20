Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A66C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1K0-00086l-C1; Thu, 20 Aug 2026 07:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1Jz-00086N-9L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1Jx-0005oZ-CO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1229210f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787226752; x=1787831552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i9yCKcEcZgK5Vz+AEZtFJjOSOxl8OG9zTj4Fq1NEz/g=;
 b=hqKqKVeXXqzAoX/M34Bkm/znaw41jMhPvi4z1gkN2TRmyFj5cUhJvMLU1PqKTmsFLm
 vgh+V7NcU3sfu/sc5KLVSzeAr7Fs/YF1KWo62cQUeQGeMgqf+Rle0y81BsqWQiFBpB41
 SoMXz0/kHT/smfmyfGmfFueJBS55BQTof1QkW8oKBMpNjNC1z+MD6ju0Rz+B6JR7nU2z
 5WlQ5KeepGkHd3wkq6vaIxrN3F8Y5tUftUPmsTJjJVZgr4Yba/6bnQitV5/5PefItumT
 ngRtiSPOlUoYwcMqHLWaIbMMt7grUyheQFXL32gC17RHMXr/SIp+prPc0D42OeSO2KY5
 KJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226752; x=1787831552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i9yCKcEcZgK5Vz+AEZtFJjOSOxl8OG9zTj4Fq1NEz/g=;
 b=Yfm3DvXAqFRlfS5ahkv9Mqk4wYQQqzUes7Zu6Frv/yKD44HnsZUrfsnVjmg2pon/db
 EvqrbmtX1CzB7jaxBNjSV8nuZHktkZzWq8tCYliKHrgf6xkMTM0Up6mbsRNfdyoUJH5F
 D7IUDY8Q4B3bZLrMnv7Cm72TCZIxtOv/Smm3HT+Ww/feK9z3am9Pl67G2o/5vvt6L9hP
 OYHbmN0r7/u9O5YIpJc9hb/XGJeYzpk7yQ5Gor3mBUC/V49JvaURWOPyzzvE1LsFxHUv
 LjUb8yWt09hP4629pVNReNpIpv9F37VrcTJMXrTUk47U+0mBPs8m6snx24hIkijMdHZ2
 hrpQ==
X-Gm-Message-State: AFuF++kcjXqlWzgDVeu7rG7n8OKJ3kjk84T2pSzQjNQXQ6g9LG1VMCyh
 kuBF6p7QHLcx8xtMLCiuYzK0EtqsanYPZwOQJA7OM1Afkxe59gTe+002q8QbbWIWX/18/GOFT+Z
 f6nCG
X-Gm-Gg: AR+sD12pPVpIWcUrgWTDSQqYgGK6NJRQW/KDApr30PHDbpLO8iXjAL8mv19SQmsCnD5
 FCxRGf8fXtVShaJMyjTi+fLDDNB5W1BNqqUqK08JueM48VpfuZCHQygwqGSE8uvNhruzOeMyvAs
 yGYU8/NmYWsYF32PPyrxIdw2Aa7CIYVTe0E1poCmafPn2yO04Qu0tPdxAwO8DbLyn/jOGbV/cxP
 8Di1IvLRnRhe1RMuBQ4WLPV1ifhVwmwotZ4vVAwq9P4IuP57pb2xn+Ja4z5yz7hUhrWCFRXpXeJ
 2xcTstP0/EzXt+HxgCSvXUx9bVSQgjyA6FRoLzaF/Mebr/wts5wRJDLuqQk7MH7tPDRzaNEYw3N
 hEnnD8hquqaGOre1qKrAb3VXFn1fDEJYt3/L2iu9eM5H4ksyfVhDmbgYNA0kcDV+zn3Ju9OKm9/
 bFOJ7o4ATpK0f0ANSyLaKMzf0vuqPvXVsjPKS9NWcPrmVPUSnea2vxVxDEGg==
X-Received: by 2002:a05:6000:3c1:b0:47f:83ee:e56f with SMTP id
 ffacd0b85a97d-482b1fe2924mr23129607f8f.18.1787226751674; 
 Thu, 20 Aug 2026 04:52:31 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm13069627f8f.0.2026.08.20.04.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:52:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 0/3] block/nbd: fix a race in reply processing
Date: Thu, 20 Aug 2026 13:52:25 +0200
Message-ID: <20260820115228.587427-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

s->reply is documented as protected by s->receive_mutex, but the cookie
which owns it is cleared without that mutex. A request waiting for its
own reply reads the very same field under the mutex, and reads it twice
in a row, so the owner can clear it in between. The second read returns
0, COOKIE_TO_INDEX() turns that into an index of -1, and s->requests[]
is accessed in front of the array:

  Assertion `!s->requests[ind2].receiving' failed.

  (gdb) p cookie
  $1 = 8
  (gdb) p s->reply.cookie
  $2 = 0
  (gdb) p &((NBDClientRequest *)s->requests)[-1].receiving
  $3 = (_Bool *) 0x5555558416c0
  (gdb) p &s->in_flight
  $4 = (unsigned int *) 0x5555558416c0

requests[-1].receiving lands on in_flight, which is non-zero while
requests are outstanding, so the read comes back true and the assertion
fires. Without the assertion it is a plain out of bounds read.

This was hit in the field, on a virtio-blk disk whose backing chain ends
in an NBD node, with the virtqueues of that disk spread over three
iothreads. Two coroutines of one NBD node then run in different threads,
which is what the race needs: there is no yield point between the two
reads for the owner to squeeze into, so a single AioContext cannot
produce it.

Patch 3 is the fix, patches 1 and 2 are what I ran into on the way to
it. The order is dictated by patch 2: it routes every cookie to index
conversion through a helper which checks the cookie, and for the cookie
of the reply in flight that check only holds once patch 1 stops the
error paths from leaving a value chosen by the server behind.

Reproduced with a scratch harness which drives one NBD client node from
two AioContexts against a real qemu-nbd. At -O2 gcc merges all three
reads of s->reply.cookie in nbd_receive_replies() into a single load, so
the race is not observable at all in such a build; the gdb output above
comes from an -O1 build of this branch with the two scratch commits on
top. The report itself came from a build with coverage instrumentation,
which is the kind of build that keeps the reads apart.

v1:
https://lore.kernel.org/qemu-devel/20260812102906.894063-1-den@openvz.org/

Changes in v2
-------------

 - patch 2: the helper takes an Error ** and checks every cookie, the
   one taken from the wire included, so it is no longer called with an
   exception; the callers which can only hand it a cookie of their own
   pass &error_abort. (Vladimir)

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (3):
  block/nbd: clear reply.cookie when the reply is rejected
  block/nbd: never index requests[] with an unchecked cookie
  block/nbd: clear reply.cookie under receive_mutex

 block/nbd.c | 65 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 22 deletions(-)


base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb
-- 
2.53.0


