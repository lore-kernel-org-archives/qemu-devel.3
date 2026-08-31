Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B69C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14RY-0001qy-8b; Mon, 31 Aug 2026 12:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14RW-0001il-Dg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14RU-0001TI-SP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso7864595ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192062; x=1788796862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKPbyoUsJ8IzjDSZ/9gIj07Iz6lN96BBEtJXGjNiovA=;
 b=OwXLC/17X8jkAh2f4GTCH5flDjuxxU+27m0CBKF77ukpqZ8g2aBkdZU1YkSfGSKy2M
 HPN4Vj0UHkxrsAE62sMZxWgtvG1/XORRVTKYGCk81C4OD/7w1/+u+odU5qmBpc8pJGZk
 nQajFHYsRyko8V1pY7F1gBi4dwkAeJKxT8HJ6nh+QPp0wToKN9JhcVvyBEh/aKfIXfKT
 oXADsDj/oYJSoAgJVRMDsK4tELIMwHEEUWEUNnz98kI9qhgkjYmce0fRVEZjR016+HJq
 gpBhPtaXFNtu7bxdHF2B2hbyzIG6PlM6W9Jb4VC9V79ovDpRjzNltOCRqC+uRrTAuHf9
 t6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192062; x=1788796862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKPbyoUsJ8IzjDSZ/9gIj07Iz6lN96BBEtJXGjNiovA=;
 b=eePj9kIULBqoqbK0G9z8mKDFXKfzH4KBpBbsCHlvRIeewR+5mrv15Wyqbod9snNzSd
 zsm11fLlthc1YJToHSMpycNPpYWkTdI5LeTZby2sE8LYlXDqgWL1Td2HNghbkpoi4wmP
 b20UWUKkt0cfpBjp+M7Ks5ZH/PsvavIzp2pf6wELvQSPooE06rqU6fCNU1iauUeXko75
 RSZBPwGHTJkGMf9LYrpcnyNuWLi5WTJXgFXHfowItlp/of+gTYnmYeqIwfdHDC1KrVDY
 kAnCbB5N2Um2Zn6V1d2Za7/z/ARfME7dUxiwD1gVYkUPHrtMS6ur1X28AIPvEMj1XF3n
 lf/Q==
X-Gm-Message-State: AFuF++mHETF3apsm8VuUBDvT1mFQBF40P6gV8NrrAPfiO8h2bhIkyXN5
 GlJF8iNpNxkrji8pVHHmwYIO6E2riIv5KBq9SCUKDoL6Juuud50ZV3tbpSjX9WN9KF8tKybW
X-Gm-Gg: AYBFou0d9X5wxJwkbpxV64sKcr4PLRfSLT65w5MFdaCYmBau6JsKttUaGTq/05J35Ur
 Z7j/JSfDUh/Y3K7OJY/qtyASZaqO1HmE04Ro4eHEmIJ1B8yq0hLQykAHZus/14bgMlnWQz47m3L
 +rxkDbXtN6GDFfA0VvP9+1NRTznhFU6J5oCut6ZkHqNdhqAwsO/dVt1n00pdDfhEkmCj0LQUIco
 +t4Qg8FvsVrJ6N+f9MmCvp5svRA/wfk6/B84kEIyvtdWSHKBqLyKsa43+buD9JQN69ORQFb5jLE
 Ne7iT7nugx3aQDvye7HHDbEWGirp/Esw6wluO7bUO/mtvThconPIktmtv3YHshR1WVC32QXbY3q
 gN5FcflmS/IVIk2IiOThuwvK4P8K/e6wuHO/QQ5rpZPgu+aYUXA8sYJKG2ZpJMNrtIKXSwfiYV0
 cJ5FZQ8l8oAi9jAgMhHNMzx6Ro/O0bvPWLPo6xYwjVeNWwCR6oIXTtfL3tXbPQ73cwsFL+pMY8R
 uKLlhyB
X-Received: by 2002:a17:902:e74f:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2d75ebeabbbmr342355695ad.13.1788192062261; 
 Mon, 31 Aug 2026 09:01:02 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:00 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V14 01/15] qapi/misc: Fix missed query-iothreads items
Date: Tue,  1 Sep 2026 00:00:22 +0800
Message-ID: <20260831160038.221776-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.55.0


