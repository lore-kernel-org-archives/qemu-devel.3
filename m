Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275E606D821
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=QKZ3ASyY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4Dg-00088S-Si; Thu, 05 Nov 2026 15:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Df-000884-2d
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:37:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP4Dd-0008QW-2P
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:37:58 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1063022f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793911075; x=1794515875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zfcG2+oPVQmck7HZK6J6aH2yZSbbPQkZHcg4eUe9DY8=;
 b=QKZ3ASyYHftkgkkpQFUxDgKX7Q34MI6PO+1vyjrDfJB/5UQQAbvY+FBG0U4MDhPwYW
 ecz9aCgvcAYwTT0zU3hOoom9jN46L4z6nOc9wC5DK+3CBpRsYJKdqejEmNFCeOYjiymW
 uuZV2+drO96jub1oZyfwFIS5/55fSqp2Y4IOn4bYyGXclByq3e40sp1hr8/iuxzc0SCa
 09im2BfK5BKMeW5YhpjJqOetDdRwUL8jyG076qLuV7rk7ks8pWh0uUgOo2iSuXCvAiv6
 6ejU3gmdoie9FRPWTZ68eI50I3FX+YTSYgLnF1hwMe63AVjkhfAn4JwC9v2jKL5cvMAR
 +SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911075; x=1794515875;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zfcG2+oPVQmck7HZK6J6aH2yZSbbPQkZHcg4eUe9DY8=;
 b=tOCsViePokbfHARQ6tNbAEOuGj9TWc6QJEUnfY1eXzL3Z7Ohv3Oq2MRajhaQhyxX1l
 fYOh8HkEUP4k80xxogCJJlQ/5gJD2hMyzlXA3Zzct6ps0xTw7W6bIge2WHDCFt+h/onj
 q2v34kE/tEZAg2QXmRj1UURZVUOtZPs868ZgWI9JL5q901SQdXMfkyZ7RUB80SMrzyNW
 02tt1jVz5xcfWvn2TS2iLF3T/nK4GKEmkn3tBjAQzRr81F0B5sXABOhfhjynkMrY8sE2
 M2eDfHDfZQuv3ZynBTJq7SD6q6mq5ytFHXT8bOUMNFPzrZKWZGcA0I+DLaZefdbRO+t9
 /Y1Q==
X-Gm-Message-State: APuU4Z8A0fQMb/OQXtdbUK9PECXS6fW+8C3xyBxRb7ZXgF6m4DrDhXAT
 +cxPTEDxPSO9KDqYWaS5gqFiGgJy1q3Sser3dfBGZAzixFVEuJuTzicqF3fHxqXgkwMKpW9MU0n
 Iivzt
X-Gm-Gg: AYBFou1wnuJxVwrgmWtq71REqbxTSAjbH9XP9n1cf5NzNUSls/sS8yE3WvYTIGROdTP
 4PMSCRPJYKWOfKNY/6w8yCedo+G4J7YmYEI/qd5AK/t0+jMmR0vEHYOCQtupJTtamr5IWEt52W3
 b4ko0Ltzg4dfsM4MnU2Fnddtpw8EhVtr/DXHJLrM1L80c4SZAzZi7EOrHrAOXGKBDyRTn6KkXIr
 2s2x2wCmb3WZQfLXW5fULU0DkiJT65LVp6OgfJuP4DeStbyiA67hxJxEJq8scxwB1HfpFwFZeDB
 IaujIoO800GwS/Qd6yvwgrKOSQ2+ZogweH0xcLdTm+LfQ/U6WMwo0dzTW+i3RvJLaeffIpIpU64
 rKFPW1oTQG7QVbVGS7E2Mn8E4y9NMzLjNlLZHL6WA6/PgNBvD0jGQz021tDQHZofhIX1szCuOGj
 eVciMqB66f313Z08KDclokxs46e87YpimLvBLx0tj3ATiHl4HOHDRte1OFbopvW7Gnj9emLiOyK
 E+JSBUTpofwZkkx7ER3sJ7/HdjfzbzjKtlOF8t6h9ccqLEezdCPjnmM0hNPOmQ/8JBg5Wk7smBU
 l7+vhHEphcKqjMOFXpQMoAcxlw==
X-Received: by 2002:a05:6000:40d9:b0:48c:7306:18e9 with SMTP id
 ffacd0b85a97d-492760da2famr1431701f8f.43.1793911075286; 
 Thu, 05 Nov 2026 12:37:55 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm11867435f8f.49.2026.11.05.12.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:37:54 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/3] block: fix the size change notification in
 bdrv_replace_child_bs()
Date: Thu,  5 Nov 2026 21:37:49 +0100
Message-ID: <20261105203752.3169635-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
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

These address Kevin's review of the series which went in through
Eric's block pull as 8b267376df87..28fafb3147f5:
https://lore.kernel.org/qemu-devel/auyju4uLIBaCGPKH@redhat.com/

Tested with a local qtest, not included: with a second scsi-hd sharing
the new node, master reports CAPACITY DATA HAS CHANGED to that device
after qom-set on the first one, and with patch 3 it does not.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Denis V. Lunev (3):
  block: read the old child length after draining in
    bdrv_replace_child_bs()
  block: add bdrv_child_notify_resize() to notify a single parent
  block: notify only the replaced child in bdrv_replace_child_bs()

 block.c                      |  7 ++++---
 block/io.c                   | 14 +++++++++++---
 include/block/block_int-io.h |  8 +++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)


base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780
-- 
2.53.0


