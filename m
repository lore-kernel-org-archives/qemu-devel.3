Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ED4C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom6a-0004aY-DP; Tue, 28 Jul 2026 14:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6W-0004Tr-Ca; Tue, 28 Jul 2026 14:00:38 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6U-0001Ww-BP; Tue, 28 Jul 2026 14:00:35 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D2A021400081;
 Tue, 28 Jul 2026 14:00:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 14:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1785261632; x=1785348032; bh=p3HPNeu+aHFrrJk+v9+jgkacqq2akWMF
 c3V3H8X2mkk=; b=rvDINbIZmhgsNeJGbuAsXFJAnjlNTShYU1lkuw5SB7UZeGgJ
 p8iON4cbfdIIVfLP6ssndyXn3IEWh8bpO3RZYPcw9fRWFr/2sBaJlAEJbKBJSkR0
 HfzZw7hYkZAxHx0qumLcxnKFTnkTI7+L/q6ukB1N5PXk5TdtmBhapk12cwLIR/Ak
 Z3Msk1ZkLyQrOOSywTnB/pm856hbJIzse/fBq+RYBiqaqERZ4UVfN0t9nS07QBiR
 Dzh66uymXxwfB+6Qz2CoUZKk3aScKIRX1c6Mj6Yxj5LqAvK4QvhxdcDJQL72g5jo
 +9aUR6aZVxG51TPnU5Xo4ZszJchH9RfC+SiWMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785261632; x=
 1785348032; bh=p3HPNeu+aHFrrJk+v9+jgkacqq2akWMFc3V3H8X2mkk=; b=j
 BLU8Megz/SNeQVRJRv2Fh0RmW86/cid8j5O4T1RR9xB8KqZrNW6tpaLZI5astGs6
 vOtnKHNTYyPcEKatKJuZHMyPCiDl6EeCW8xZ3i7G94UcTs6Xv5srJoInHEQ6VTtk
 CyZky8fhI8AIgktIbrVz4a17F8pgoASnWWhjckut3oU3bygAJQsYBVSedqpqFgmh
 fZgN1BaZCB1S0wnRZjND6JhpDbtbrUJzJSWkBZueDcwZgnirIU5eSrlYq8F+KT+Q
 5CxBI+jsIqiMDIRqHvuRyEm+YoqwQfA9/mH8XeIY5r0FuqXeLMdqWs0aZK4y76Y0
 sN4rBxUoyJe6s8JRQaIcg==
X-ME-Sender: <xms:QO5oag_jxjNsRZSjkaDgfzRrRzAz50KM2GK93GkiV8nPvhPho7MuDQ>
 <xme:QO5oav90-dYurKH9sAWvVzPeUFRCTIZqHaQLs0JSaXo1Pz62hKHJzxKwn7UidkSZC
 BDZdbputgqiK6wGJNwq8_LPzkR6eCQHc-sIa7UDQkhYgnm66EVxNtI>
X-ME-Received: <xmr:QO5oag4y6NSe627mYVF6Wrd0I5L0Wb6OfFRgNR7Q1DoP-pq2UDGuMz0Mfq-EFoSGlO_3lghCcoFt3bY4BRlZW8rlX6XlQqAlGcqNLQyTbAZJAV9_TxVJ7YEKdw>
X-ME-Proxy-Cause: dmFkZTFocshqA88LTMiGWBA+maAGF21oBkmgGwtu1yypWYGnE8uPdno3TETbWkuDKQRKSo
 pFNpFTZmZWEeewnA9ZsX6E0LhYgMh7JQuvjNs0HUf0kPqX/vwYYRprMdK3uFzdEXlpXhlx
 /DsbRDS4OzMi7LmMBTkGH/ytZ7guloixqKsdtiHOqYWwTyD13c2a4jFsq/CTFwSxrtJHs1
 XDSbpwRIh8VKfSs6MoIyfylsB15USzH92ZMKKbodtikHFKACmUPIvmDER0tSTmD5TJhBgH
 sCI7q0PYNzHmLlpZqhwgBeL87fulSHgWtT+8fhrop2C5qdTeadyZ+Pgh3bu7gu/ovwzvOx
 U1cI9E4u4+Q6HqA71R69G+/bDiOuJTKLl+oIVxwmQunEs5tOgiXlFqhdr2IfI3LISBXiJy
 9OzMecTqA3sxr1Z6FaPtIcVfrnviGQdw6RZAQynziFRiSCUNmVKLZmoeE5EMDwBPIIk3KK
 hHBMGssot4JZ18G22PNQdQCFOoguWfv172I2nVhqcSpvGNvXglVFuX8gVHj1GyW2g0L5o9
 o142FnyIWtPDlilWXQeUXkUKKMYYDZKcX5YR1LDHw1G5jhScrgk8jFZM1/DcIyjNg+ahRc
 H6KP8ofo2WGgHXozhN+Jt+Z4YcZZH2KGH/Vjj7NNkh0LscNUl1KdYnj+TWAQ
X-ME-Proxy: <xmx:QO5oagZsKKwapJJr5QKkn8ipKnKKcgZqKXNLctODvtxmMSij5TA2Fg>
 <xmx:QO5oaq-h6QUZ4JZ4LeSmh18KQjElhtXz0FTKmQRWRLM8DbA1X8owdQ>
 <xmx:QO5oavSkjB0WaKrhdxoMfZYTzkP78fCnHxyBwMHjClnslO_8DFK7mw>
 <xmx:QO5oatLz5dq5JHx1y5wCvCX21D6fGd8nHdvP6Hw0qJJkfcqdI0kFEw>
 <xmx:QO5oanLDt6KkGz0ZL1qVrwcxIPcJIsETVC8L2CArXN5uYlPnzEvqRYD7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:00:30 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jihe Wang <wangjihe.mail@gmail.com>, boy juju <agx1657748706@gmail.com>,
 contact <contact@xchglabs.com>, david korczynski <david@adalogics.com>,
 "Brian Chastain (off_by_one / Curious-Keeper)" <brian@scalingsuccess.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 3/4] hw/nvme: fix cross-namespace copy dif buffer overflow
Date: Tue, 28 Jul 2026 20:00:17 +0200
Message-ID: <20260728180018.3574-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180018.3574-1-its@irrelevant.dk>
References: <20260728180018.3574-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The NVMe specification allows a controller with multiple namespaces to
use different LBA formats per namespace. One implication of this is that
the destination namespace may have a metadata area for PI, but the
source does not. In that case, the controller shall generate the
protection information, but the bounce buffer is erroneously allocated
without space for that, causing a buffer overflow.

Fix the allocation.

Cc: qemu-stable@nongnu.org
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: contact <contact@xchglabs.com>
Reported-by: david korczynski <david@adalogics.com>
Reported-by: Brian Chastain (off_by_one / Curious-Keeper) <brian@scalingsuccess.io>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e1639b3839f7..acd10fcc67fa 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3210,7 +3210,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
     uint64_t slba;
     uint32_t nlb;
-    size_t len;
+    size_t len, blen;
     uint16_t status;
     uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
     uint32_t snsid = dnsid;
@@ -3331,10 +3331,13 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     }
 
     g_free(iocb->bounce);
-    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
-                              sns->lbasz + sns->lbaf.ms);
+    assert(g_size_checked_mul(&blen, le16_to_cpu(sns->id_ns.mssrl),
+                              sns->lbasz + MAX(sns->lbaf.ms, dns->lbaf.ms)));
+
+    iocb->bounce = g_malloc(blen);
 
     qemu_iovec_reset(&iocb->iov);
+    assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
     block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
-- 
2.53.0


