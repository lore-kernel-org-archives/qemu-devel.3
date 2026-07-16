Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9EBC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNIw-0006j0-UF; Thu, 16 Jul 2026 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHM-0005qZ-9r
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:43 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHK-00074w-KQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38175907a56so302718a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212890; x=1784817690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=pFkLSBJxvycleYeuqPbFsa7qlnEYNaP6ld1HCm94OEMWpd8Lb1Tk3EGok3BYz+PYpj
 M15FddwB2NYy8jnjmFhC1ImdZWa86spVdWlWl/YoTm5LcCNhJuujiDg+zJ1s5qidPN3s
 tT72o1Nii2Kr4MkHYCyh6rSaaqREj9KwxJjJi99/JcTy/wYHFEVINYJI2sJ0h9qlgtuO
 jMcGWcFGt7iRR9tlnGTvnyuYhGE1iM6SeXctaU7xovF9DK8S/+vDjnoy6N1cVyBFPS+8
 VaS7rd9MuysYLqppwtlwz2Y+yaMLKa5ibsL7RNWNRMCuhGrBgRX9oEL8hasvvyNUxFeP
 PYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212890; x=1784817690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=QA/BWCJs0xkCGpxpSzHjZq5dxcJQQRI58yVablzrGlYZ1DSeCwXT2t6qqxpCadQQ/E
 I9UPzVL494ljglrmLwV3ezHLmLKTBxPOZW/uH+UbQKykxJtSWdB7QlnJ/8j0hIMrAPUD
 4ZCK9VgQqZzEH6ZhfMDzBLNRRHN43gczD5A8+TdG3E33mUqEISCsW2c5CE4W5nhZ/nz2
 RcwrIJCM6RIq09BLTfw8UfZM1kQ8qIOEKAnlWNOW2O1WmW/sSm3B2mpmJhkXVqHHuJr7
 ZOYO8So0+uiXfC21AtNpkf8NOxJXh9yrtI38wZKM367mxLjKhvSQD/p7SrV2YjkZxvSR
 Ygkg==
X-Gm-Message-State: AOJu0Yx8U+aeLYNJgtH9aHaHv/whLMd3yAOvHao15Uzlrs5JtzXmc6xl
 h7BCMva/FJ1hPJ8hm4wsablXWPaSnl3V6ExbQf2uKSwqw4ljmbbP+WoaC9/WMzYKRVk=
X-Gm-Gg: AfdE7cm5IZ4brABwhvD8V8VWU9SeT8+XHqjIJ6BEQAk6x2mnzCuZyinAnEJP98vcvPy
 52xX+cJa3YVwEoWX38jMLvIAPM2YpHgDO97lqnMxs7z0FB1oHv1hAFuy4U6mAxR2n4xr4jag71O
 x6h7xYl84GQj381EvBvdelALwr2XuxRC54XZv76YXdlSeMBEQLOgSpgCn18oZ9lHuocqPzouIQF
 l2N/gNYLzkhOkq2FZT3ahAt+ZFi8FZgHQ33vihZ0+iSJF2rHWeMcEL51gJSb8rkL+/d7ME7XFXu
 G8i/ozRYvbyB05gbYr/VxRmCab644HZotRtXTCHyNK98XOxvCv9uUKnaDazJngQcbkpWWQVlOZU
 svD39a5q5xA0ZElfMoW4+4N5lYgdJckwqLEvWW0BtaA5UQ3bZU+FfTa/yaF5kQF1gN7I0ws8ftX
 mi4dofw40zstK/9kLyarHTvfDzXhXO6IsHZsTelKPn
X-Received: by 2002:a17:902:ea07:b0:2cc:841d:cd7e with SMTP id
 d9443c01a7336-2cf1f5710f4mr32356905ad.21.1784212890179; 
 Thu, 16 Jul 2026 07:41:30 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:29 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V10 01/15] qapi/misc: Fix missed query-iothreads items
Date: Thu, 16 Jul 2026 22:40:26 +0800
Message-ID: <20260716144043.76414-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102b.google.com
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


