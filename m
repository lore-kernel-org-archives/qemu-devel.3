Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=GNphpGHl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb4w-0002HL-AO; Thu, 29 Oct 2026 21:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4e-0002CL-La
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4a-0006E2-5w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so602485e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322382; x=1793927182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=71SB0FrjFwut8s/0OfdT1uGzvIsW+clScFF+JCSKOjE=;
 b=GNphpGHl+pgVUE1oG1HATk9vhu1aOq6bQBC9jgpmKdkDwxK53a+S1lz7BwWfrxEbh/
 FTpEgZ4qmTcmB7ODSTN+OPs6gG+DbWF5pnzyd79ncvH6M256Pe+WCSKPTWqAHPvf4n0Q
 zBmL/uj/H5r6s8TgRDiIhFFm4liKs0wf4S2Ajp+XLnHU59TsXHMzngl2PtLpu5ebjl8N
 VDCy9VdL8965I8YAMrGmMpNezbwDZyU0o6i0Q415ATU1iP0UhYAct9j+QC+Y5iASlN4d
 a/SUkZubVts8v3Df6hj33mVo6/XJnpaTKKK0/CF/kYS2P3YBbcvmx3yau70+0WRzK/+3
 TuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322382; x=1793927182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=71SB0FrjFwut8s/0OfdT1uGzvIsW+clScFF+JCSKOjE=;
 b=da1qtbgc0nZ1iMNM6JTwbU9Vi2nWtnwh+2pw17baG8Ko15LFTpTNYWTK1EpsJFJFGC
 MVPzwQr++I/n6FyM/PxvptrTMuZOnI0Gra3nDk6g8zO+amhOhSo6IjHo67WM0XCY3NQQ
 qJQQWEpF0MScBJjJq3M1OA4oHj5943sXklrrZRddXXRmHSbybeFdUdXDlLIQl8V4XlxO
 kcd9hebdaFmmFxC46SGm7GaLA/yLZezuhwPRn+RFgZcaiH15Gsw+yF+tTE+Zc5+nN4tA
 hbr3eqEqufL+kQBqqysoYHNSlwmbpCom4kI3ays/yVIghD0pJQ89aiW1nMFB9luOaxdf
 hN/A==
X-Gm-Message-State: AFq9FYIKPP9YExhM80yQzihdcUYlnar0DYDcD2JhzVXXa0xaI8k7BqKO
 fk1cnGhduVPtHQHqUt02uFZsdqXKsTovtZ/vBfp6/ZE2ZQLBb95hz8M8q1tKuHgQoebRkATup81
 ymVZm
X-Gm-Gg: AYBFou3n325aReJ6ULbN/Ufoj4bY5mZrsT/H6/gqNMbBcKOgL44FIrF66ZabRiocQFc
 q73czCQBqDjtt7eoMLGfZmEjBp2/2kyUmVirEtJ9gnvXa0QZjitBteaT+IoKq3qglGHd4cVmk1o
 V2MV4eG49a72XjwdqYLZ1x3QqZs93CuFOggPOVLTnkv3dxAsQTR4ihgx5OfVRpOuoQ8EdjLuvSo
 knx/ox5H+8ur2MSFViboEICRHzDZ+oXsplgMI0+NM5GC5BTdxAVaqRUmYUiPlvRU7XiUZ8E4N8o
 MUQtzprb+dDCAssh/5Ve57swFgVUalnIhm2B2SIRAM+lKSyVLQNr7x08zNUh6Bej8HI91v+G1NR
 9FOl7X1dS/+KAF6x+CSKrvNqCC3DlcZyLL0AXkQCdAIJN1fbokFW19h/0SeZ9RE6UchPBSsB/Ny
 8wP0CC5eBk8dfapUPXp4GfWfHAq9j8xl/Sw8qnHpKC46B8it1UoOVLEhV03yGqYW2N3SOqDsBuz
 jIxFl0jXO8gzKzKDYE4YI9zJ0nHSvP9wACUYEwWUouq429MVZ7prqC9weeqLB614lIdGYOVZH7/
 8G3skPOTQJqe6FRDHSO5XCmRBy+DEl2EnA19Gk4=
X-Received: by 2002:a5d:5d06:0:b0:48e:2a04:4ea3 with SMTP id
 ffacd0b85a97d-48e6e2c05e3mr2283359f8f.8.1793322382350; 
 Thu, 29 Oct 2026 18:06:22 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 01/12] block/commit: pass BDRV_WANT_PRECISE to block-status
Date: Fri, 30 Oct 2026 02:06:01 +0100
Message-ID: <20261030010613.1612771-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

From: Denis V. Lunev <den@openvz.org>

c33159dec790 replaced the want_zero bool with a bitmask of BDRV_WANT_*
flags. block/commit.c was missed and still passes "true", which is
BDRV_BLOCK_DATA, not BDRV_WANT_PRECISE. Convert it like the other
callers.

Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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


