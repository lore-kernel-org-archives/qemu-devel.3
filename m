Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA396C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqI-0002fT-3u; Fri, 28 Aug 2026 10:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqG-0002eD-FJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqD-0000dW-FH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so7525985e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928359; x=1788533159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YEJDYv1NKzCxVU6hnQ6Czcdjfzbx6kLk6o9Vawi2MIY=;
 b=MUCFZ8kP0zNN93AlMdxDce6eHjSEbqbKyNOjAq1IYlNM9hTiWCADU6ROZr0gmwMMpe
 QiyvfgsH9hP+4JMf+heUVQPcd+37t4bmzij0g5vI5uBnoSe5ONSucXte7UudKgrlqXAN
 rO5/5uaG/vjX3/htRkjOKIyyD+ErA8Vnv3Ox+mEthHbQ7eJk5VyKOQtIWGQOOgJo5Idf
 RO9Qxi9tXuixdi9TOOfiVsWZqHmSZfXaMtUpmN5wZj7Yhex7ldlkAMVirMmf2eCo7j0T
 RBK/LID6ylQNH5JJj+aAVO1AB2US2H8T/g0j+PyjH6PXZBL5bC6OhJ1HEH8HGjmJ4wNn
 +mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928359; x=1788533159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YEJDYv1NKzCxVU6hnQ6Czcdjfzbx6kLk6o9Vawi2MIY=;
 b=AIR6WdlyJFLpOL7lWzNpQDMBWLnvzLXAMj4ZAmzyqL3KZ51F8aZxDRG9ma/YyMr3ew
 tnFLqR3JZ+jlUlj4/2vidzKRJYh5H0KfEHUrGad1lXcbKxMBXcuPc8LpVhMTLQD2oSmz
 aYktqBVyq2RsHCY1JJcWkmc5Aa++zqJE8pZiOeIY27F+haMbirucUPKClzLKfgRjqRjj
 vO0NuKjAo0cIYRvOijRkRD0Omq8J3AS3zdlkTZnLlj1cFTx2gwIXD7x0H9Smj7eMjvou
 i8Z0vgoYdwHatkTkuUfWfxTOPqrwRTS3+tACtNGl0VzMawsQxAToWhWXp0mfPxzkQEDf
 HfnQ==
X-Gm-Message-State: AFuF++mawQ4IIVNx/y5bqzA2+ypA/5My3wkArvKxzvuCtDkh7xOirpGO
 hNbM6ippGiRU2tKTkMjc5qamgBtL/7KHyeY2/g5n7tNQ2Cv2kT3olKggvFcnn3Wd56Xlf46oHPI
 P/76Q
X-Gm-Gg: AR+sD10H7L0BLYPH8lPdb2Xd8XQGXQ39E55fj7kuUF0YSIrdO6ubu+0rpjbS6WbB9cx
 qsbU6TtpR1A4TAvJQg2BaSuK99Gk60Cl0QgAeTSYFszDLOFhci2NKycAb740KOj1GLxccwY1DnM
 OIWLsErPZb213g966EQfrJqM95a5sxFye5sZNOpxnsi/eZM3dQpEKLvzrkcicn7PNS33f+7V9Ou
 WXWd+OdI7I8rERByZ/AganUohGbpBzB0Jw3njNz1rloz3+ygiBd2dK5HMxBdJJRPVjZMz+CiLT6
 9kDy+ZRPCsexPOf8Edq7e5UtSwK2D6O4VzhiTiP2o84p7mB5MCpHIQuxFTDGuVmPhc7EzuIvI/M
 nFg8DDT5DDqnH01fpFA07QoxkQaOMfJz+1FoT3hfCjhGS3Kg1+E8F/Y2/fxL9WQqF+yqNb5ZfjV
 6K8EdK4EBwGcmY/qI/s1Rv/ShDsm+bd9AxkbPaDdT313rpqznprcVXoaueouD5KRBD+KUJ
X-Received: by 2002:a05:600c:3b28:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-49b91c56cdemr107416475e9.14.1787928359517; 
 Fri, 28 Aug 2026 07:45:59 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:45:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 1/9] block/commit: pass BDRV_WANT_PRECISE to block-status
Date: Fri, 28 Aug 2026 16:45:46 +0200
Message-ID: <20260828144554.1741910-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
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

c33159dec790 replaced the want_zero bool with a bitmask of BDRV_WANT_*
flags. block/commit.c was missed and still passes "true", which is
BDRV_BLOCK_DATA, not BDRV_WANT_PRECISE. Convert it like the other
callers.

Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 2d52c39594..4e0b0f9029 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -140,8 +140,8 @@ commit_iteration(CommitBlockJob *s, int64_t offset,
     /* Copy if allocated above the base */
     WITH_GRAPH_RDLOCK_GUARD() {
         ret = bdrv_co_common_block_status_above(blk_bs(s->top),
-            s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-            &bytes, NULL, NULL, NULL);
+            s->base_overlay, true, BDRV_WANT_PRECISE, offset,
+            COMMIT_BUFFER_SIZE, &bytes, NULL, NULL, NULL);
     }
 
     trace_commit_one_iteration(s, offset, bytes, ret);
-- 
2.53.0


