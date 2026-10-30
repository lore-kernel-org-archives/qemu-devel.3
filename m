Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64221606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=kV79nYd4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb55-0002Ot-Qo; Thu, 29 Oct 2026 21:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4z-0002Jx-36
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4s-0006H0-Vk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so89455f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322399; x=1793927199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzK/GS6n415GXdjNQIzyla58d/FKSuepRUvbDI0J/bs=;
 b=kV79nYd4s8i9FcN/Aa/ndgYVW7fmkR5jI8R6MVKRlbGNGXIxEoIUbhlQpZnULXZGG3
 KJv0Czw8TZOHjPtQTVfpKjULGhM9ndqKFhqLQIvO37durZoCuUfRq0fsxClbcwF+3pv3
 JSLRhnFQHkuOBHYZW2exnhROOnL96jwq2lTeiv7wRPhcgYJnKanGt1C/9zmtx+O9QYGt
 T971jw6f9MRqDXQIVHhkJizYy0hApxzB111FG+CEsAW0BPQ8OZnSc0Vi0c3P82m/4x3t
 4ZcGV4Q9GCCsw/dEKWGu0ZsxVZ/99AcC6qf/apLePDp8W+pMQB5J8A13ORH9mI1XoZ4v
 gWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322399; x=1793927199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzK/GS6n415GXdjNQIzyla58d/FKSuepRUvbDI0J/bs=;
 b=h0Yi7toFYiPXDGaK6G2SyJwhHeA5sMt8nudjyKctzkgfu0UGpNhR17TpHgzKzreRYv
 ygElfU8aBuHZLMkpf76LUhY3ZbVGi+zBAvpTvNo7AkkwUFFNcNm4dk0SgLjNaKKHdrSm
 fteWiY8UJ8JZTln5v5vgbq3frIRdHWY1SIWsQDyv7euobtAwbq1VC54izK8+Jh82HePf
 4iovE+Qd+aNqLNElV08JsKeuixMZsSILvOiylOhCfAGJ2wNC4C6J6+ZjKhNazTuthLda
 z06mRdCLhQpHrNyfUpTDCvQZJGlkRKX1KYkFLJKIjG3bLO+RKpq6EIs4aySIoAYbLKMm
 RXkA==
X-Gm-Message-State: AFq9FYJLtpjhupjv+02WLHqcYjS+wb04gIQnvmJp467IozI020gDqxy4
 zaCzcPT0OusZ3FXbfwZZbCUSiwrST6LLzrul+FUAL+pEJQKWH3aUVuXxtDgudLcUS71925fckoE
 gAZ87
X-Gm-Gg: AYBFou1Aa2pDIeh0DE9FNRdZYJ/1vC6ISsKJz91K9rS0gpkVRNIOIJ07O4/9995AZAJ
 z9ceHVPFB1TElEUgPykr9ysr1IHpLkRiCGSbV24u0vLh+/Z/74eRNGd8rZw0rnv0kSmKFGO8aXC
 noaEgcmPaaWmNTf6rUatifX5wIYNiwJKv97jjV37JldaVJn3Usj+3h7NFid5WYlDYaYJzrZtAzH
 aRrK/6EfFGEGzAz5QMflESLDQ7iKcea5nj2/AoW8vJUtBYM3S+shSkHPj9td5uZGyngifmZZ9oB
 RWPJp6GJ/JoX1KUE65DHRNjHGha1+jCVltv3pI1naDb81znypTyCvZHYiHxMJOzXGXfbS6AHT2e
 xhKqYVSRb2VWdNUIHaZkc8sLV52D54t7qPXpVQNtRSjXe+0jycMzvvWN0VbO6lsumzXNR17bVvN
 cE4qAP+MGk4YXlaTSDFSETF9RJLz7Ojdbvly04n/kdogVhEl1kwfPNCZt+vThCEA9jzfKspI55H
 puxHDzEI5wN6fviTRhQoK6XjkeKbfGpJ7uOQ+wa/wdsqvxs8hSkkePBvhdw6gNHvf8rTvpSn1/X
 dqDaaUz/Dfw5W7MTGlL3b819Tu+NnIS8T/omdBk=
X-Received: by 2002:a5d:5e8c:0:b0:48e:5c9b:f12c with SMTP id
 ffacd0b85a97d-48e6e2d4c32mr2533928f8f.16.1793322398780; 
 Thu, 29 Oct 2026 18:06:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v4 11/12] util/co-shared-resource: skip the mutex for an empty
 request
Date: Fri, 30 Oct 2026 02:06:11 +0100
Message-ID: <20261030010613.1612771-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
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

Getting or putting nothing cannot change the pool, yet both calls take
the mutex, and co_put_to_shres() also wakes every waiter to find the
pool unchanged. Return early when n is zero.

block-copy is about to reserve nothing for write-zeroes tasks the target
serves without a buffer, which makes such calls the common case for a
mostly-zero image.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 util/qemu-co-shared-resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
index 752eb5a1c5..f9b6af0072 100644
--- a/util/qemu-co-shared-resource.c
+++ b/util/qemu-co-shared-resource.c
@@ -69,6 +69,10 @@ static bool co_try_get_from_shres_locked(SharedResource *s, uint64_t n)
 void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
 {
     assert(n <= s->total);
+    if (!n) {
+        return;
+    }
+
     QEMU_LOCK_GUARD(&s->lock);
     while (!co_try_get_from_shres_locked(s, n)) {
         qemu_co_queue_wait(&s->queue, &s->lock);
@@ -77,6 +81,10 @@ void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
 
 void coroutine_fn co_put_to_shres(SharedResource *s, uint64_t n)
 {
+    if (!n) {
+        return;
+    }
+
     QEMU_LOCK_GUARD(&s->lock);
     assert(s->total - s->available >= n);
     s->available += n;
-- 
2.53.0


