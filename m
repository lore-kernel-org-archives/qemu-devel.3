Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA322105A599
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fcu-0001XC-Cv; Thu, 12 Mar 2026 08:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0W-00048i-Lr; Thu, 12 Mar 2026 04:03:00 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0T-00030A-9i; Thu, 12 Mar 2026 04:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eL
 LvSQHU8ehn2m+zChvE8FY6VFoeK0GfhtPDMCP2B5k=; b=eJdSn0j7EVoA1lvxKv
 x86nafuApMyAtrgLki0JAQnlYya1yXem4PQYS3AxDt7Sy1vqjwzvkTXgyJxx5YKk
 zrxMIE/xq0pxUhYeptvAVFXmO3AooPwej2yiYL2NCErnKaO1Zp76XO31AhOIqUjo
 LGQt7yDz0WrvZcbWQUWzkcgEE=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXHlMcc7JpkIIcAg--.55484S5; 
 Thu, 12 Mar 2026 16:02:37 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 3/3] The LLI of pl080 should be aligned with 4 bytes.
Date: Thu, 12 Mar 2026 16:02:35 +0800
Message-ID: <cb35c1b622674da7a2b70691402132f691933f2c.1773301927.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773301927.git.dingtao0430@163.com>
References: <cover.1773301927.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXHlMcc7JpkIIcAg--.55484S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF17XFyDKrykXw1UWF1rJFb_yoW5Xw15pF
 9rJFsYgwsYkF15Z3W8XF10gr15XF4IyasI93y7Gr1qkrn5W343Kr1rCryxCrWjyrn7Ar4U
 tFyDJr4Fgrs8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcyCXUUUUU=
X-Originating-IP: [175.152.130.74]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4R3qKWmycx3oXAAA3+
Received-SPF: pass client-ip=117.135.210.3; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Mar 2026 08:58:55 -0400
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

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 4f97943b28..4e24f6595a 100644
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


