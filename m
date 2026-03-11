Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF1A112583B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KuW-0005wD-NX; Wed, 11 Mar 2026 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUy-0007Br-B1; Wed, 11 Mar 2026 10:25:20 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUu-0000Kx-8w; Wed, 11 Mar 2026 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1773239110; bh=wj+VZ3AI48/P+TeGQUBVC57Az+sIg2h/CodsDOqOyZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ElpPaVp/F1n4QONniJAKz0hGIllVpHaPdclpJuq30EIhjxJBmKKSJ2Ab6SmRn0bg0
 9Te6mtKAjiNHvANfiKWi/rqZnVs6IWblUoHv3D6G/a0TlOSjYOl6N8q+3FNI4Ddg54
 xyjxE6Kd+oT84nuRYaLfJ/0+V9fzzUIWY/Iteqzg=
Received: from dt-VM.localdomain ([175.152.130.74])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6460A831; Wed, 11 Mar 2026 22:25:06 +0800
X-QQ-mid: xmsmtpt1773239108t115idvg1
Message-ID: <tencent_EB97E44208B1F887301229D056F0AEFEB20A@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5StURGviHjvEOXPyqW5Q0miKroqsJ6RuytshL9MaBDCYiwWj4kBg
 HTBfXsLtQWag8A3uJS7/hAgR3D3PAhHohGwH12HjyIvYXtrEbOB/rsBfB4OPaxOHbLytezhKOruU
 SrLVNQz70/z3aaILQ/zUVXIYIo6aSHoMlKA3w5tZk8gsORqvVCy4rmBnHfGboDxlKJWr/4psxaKV
 inzcLMDIh5FMoGQu7mh4WQmI9eyPmT+Yx4GNsKURm9t6uGmqTqXQMHmlGuIovZX+DBTRPnmrgLDy
 7s8RrUYaCjqLqNnWzxxRjybp+q90SrQaox1o41k7TXmMsOQ9AunbencAJEUiFzr4+xBLWIFC5g70
 m/2mTyu8FWq5wyLt4VM0WiYaOYo6zXF/pWdw2URMSEMR/Rx7JOiOBTNJYuiocnzVjvTuRxTSoBZP
 5ybqrUWXzZ3IPgWAL6qRya0ufViWkS/c+QdVZU3bSu/7g9VjdvPQEiyc403lGaGcTMSw0hfGiDNg
 aTch8+fh1geRVdCsdO+0kKC/VC11bmXtq2S1/P57HlklxCKw1y8kkIDoy4m9Rcez2C0L+DzqYqa4
 4F7jRO8CL4ZrMr9wyoLohB8kiC51VxVzWZbQV0qksYPyMRATiZrtVF6no15Ju8W7sTwnBiEey/nZ
 S4+szEejNIZB+Dv3S+4WK3B+c+Q6wK2/kEsY+HqIHiwEUYBEh35MPyf8YYvfb+fRLubb8zadtAzx
 tqkZ+pzNyHKpXzIjbOk4bC6VvdsSfSpUVil3fS9tucZRhHDDL+HPn5hxMy5g5yo3yarYqqnEY40t
 g9RCozR11Lue+bTvTPivsVQInxb3nVdUKW2E3TZevEyAMd71EYOanG/eNq8doJ5VWt+eAgn3KdEu
 HK15ARYhBeai8jFcAD1U7kSHaEBtDOEnTkkfUWVFICHVWyuIXzF6asI2WOH/cp16wClVDSROcLT2
 eINg3IcSao20ScRZziOo50amjaED/TOCVzNc8zwRGap8Ucz06lPCm3AvLRxZpuvtHqLV98qpOH2A
 MqR4NAiurQfdIbAw5po2IHXNl08fYXwRdZFWz6S4aegeBMSM616rmdqIR4y1k=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: 1774596582@qq.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	TaoDing <1774596582@qq.com>
Subject: [PATCH v1 3/3] The LLI of pl080 should be aligned with 4 bytes.
Date: Wed, 11 Mar 2026 22:24:58 +0800
X-OQ-MSGID: <71d57a9f29b73754ea54286b134b470c494cd620.1773236195.git.1774596582@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773236195.git.1774596582@qq.com>
References: <cover.1773236195.git.1774596582@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=1774596582@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Mar 2026 10:51:41 -0400
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

From: TaoDing <1774596582@qq.com>

When the bit0 of the LLI register is configured as master 1, 
it can cause incorrect data reading, and even lead to qemu crash.

Constructed 1 LLI item. The initial LLI register points to the address of the LLI item.
But the bit 0 of the LLI register is 1, which mean read from Master1 port.
According to the description in the PL080 manual, the address for the next LLI should be word aligned.

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
     -device loader,addr=0x00002000,data=0x00000004,data-len=4 \
     -device loader,addr=0x00002004,data=0x00001004,data-len=4 \
     -device loader,addr=0x00002008,data=0x00000000,data-len=4 \
     -device loader,addr=0x0000200c,data=0x9e4bf001,data-len=4 \
     -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
     -device loader,addr=0x00000004,data=0x88776655,data-len=4 \
     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
     -device loader,addr=0x00001004,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
     -device loader,addr=0x10130108,data=0x00002001,data-len=4 \
     -device loader,addr=0x1013010C,data=0x1e4bf001,data-len=4 \
     -device loader,addr=0x10130110,data=0x0000c001,data-len=4  

Qemu Crash.

The result correctly after fixed
    (qemu) xp /1wx 0x00001000
     00001000: 0x44332211
     (qemu) xp /1wx 0x00001004
     00001004: 0x88776655

---
 hw/dma/pl080.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index f8a0ae0342..980188dac4 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -102,6 +102,7 @@ static void pl080_run(PL080State *s)
     int size;
     uint8_t buff[4];
     uint32_t req;
+    uint32_t next_lli;
 
     s->tc_mask = 0;
     for (c = 0; c < s->nchannels; c++) {
@@ -191,21 +192,22 @@ again:
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-                if (ch->lli) {
+                next_lli = (ch->lli & ~3);
+                if (next_lli) {
                     ch->src = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli,
+                                                   next_lli,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                     ch->dest = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 4,
+                                                    next_lli + 4,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->ctrl = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 12,
+                                                    next_lli + 12,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->lli = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli + 8,
+                                                   next_lli + 8,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                 } else {
-- 
2.43.0


