Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA749105A596
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fcw-0001Y3-7j; Thu, 12 Mar 2026 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0X-00049V-7J; Thu, 12 Mar 2026 04:03:01 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w0b0T-000306-ME; Thu, 12 Mar 2026 04:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=m3
 B5s0mSsbyEAlsaBtraV+HCZSPM9zkwDChmi3jzoZs=; b=iZLXkovTG/gTAc7+JY
 980dxp2UA7opX/N64dTycr3yrmQTGri1NJOuaTMrLI/SU2cDJhmkJG/8+BYvk3+d
 Vq2kDlZy6+hkgqVD94fnzITB7oyTQ71w5CRr0vglM8c8mwLS7KAqozQzZPIuiXF+
 /zxpJOUksuYkZa5viIPlg8GJg=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXHlMcc7JpkIIcAg--.55484S4; 
 Thu, 12 Mar 2026 16:02:37 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 2/3] The swidth and dwidth of pl080 are not equal.
Date: Thu, 12 Mar 2026 16:02:34 +0800
Message-ID: <97c01f634c255f3787ab8a71bfe8ccc03e8d353c.1773301927.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773301927.git.dingtao0430@163.com>
References: <cover.1773301927.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXHlMcc7JpkIIcAg--.55484S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWrury3ZFyktry8Jw1kXwb_yoW5WFyUpF
 9xJF1Skr4FqryfA3Zaqr48Wr13Xr4Iv3Z0g3srtr1DCrn8XFyagry8CrWxJFWYvwn7Zr4r
 taykWr4Y9rs0qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpnQUUUUUU=
X-Originating-IP: [175.152.130.74]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4h3qKWmycx3qZwAA3E
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
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

The amount of data transmitted each time is the maximum value between s and w, 
but it should be noted that the remaining transmission amount is less than the width.

Configure swidth to 1 byte, width to 4 bytes, and transfer size to 4.

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
    -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
    -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
    -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
    -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
    -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
    -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
    -device loader,addr=0x10130110,data=0x0000c001,data-len=4 

Qemu monitor
    (qemu) xp /1wx 0x00001000
    00001000: 0x00002211

The result correctly after fixed
    (qemu) xp /1wx 0x00001000
    00001000: 0x44332211

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/dma/pl080.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 0979a687aa..4f97943b28 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -160,26 +160,34 @@ again:
 
             /* Transfer one element.  */
             /* ??? Should transfer multiple elements for a burst request.  */
-            /* ??? Unclear what the proper behavior is when source and
-               destination widths are different.  */
             swidth = 1 << ((ch->ctrl >> 18) & 7);
             dwidth = 1 << ((ch->ctrl >> 21) & 7);
-            for (n = 0; n < dwidth; n+= swidth) {
+            xsize = (dwidth < swidth) ? swidth : dwidth;
+            xsize = (xsize < size * swidth) ? xsize : (size * swidth);
+            for (n = 0; n < xsize; n += swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-                if (ch->ctrl & PL080_CCTRL_SI)
+                if (ch->ctrl & PL080_CCTRL_SI) {
                     ch->src += swidth;
+                }
             }
-            xsize = (dwidth < swidth) ? swidth : dwidth;
-            /* ??? This may pad the value incorrectly for dwidth < 32.  */
-            for (n = 0; n < xsize; n += dwidth) {
-                address_space_write(&s->downstream_as, ch->dest + n,
-                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
-                if (ch->ctrl & PL080_CCTRL_DI)
-                    ch->dest += swidth;
+            if (xsize < dwidth) {
+                address_space_write(&s->downstream_as, ch->dest,
+                                    MEMTXATTRS_UNSPECIFIED, buff, xsize);
+                if (ch->ctrl & PL080_CCTRL_DI) {
+                    ch->dest += dwidth;
+                }
+            } else {
+                for (n = 0; n < xsize; n += dwidth) {
+                    address_space_write(&s->downstream_as, ch->dest,
+                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
+                    if (ch->ctrl & PL080_CCTRL_DI) {
+                        ch->dest += dwidth;
+                    }
+                }
             }
 
-            size--;
+            size -= xsize / swidth;
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-- 
2.43.0


