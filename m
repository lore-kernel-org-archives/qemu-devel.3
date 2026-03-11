Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452AA112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KuV-0005vE-Rf; Wed, 11 Mar 2026 10:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KV0-0007Co-VE; Wed, 11 Mar 2026 10:25:24 -0400
Received: from out203-205-221-242.mail.qq.com ([203.205.221.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1774596582@qq.com>)
 id 1w0KUw-0000Ku-1B; Wed, 11 Mar 2026 10:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1773239109; bh=8b7SihBX8BbtdsXQqE1ZD4tPD47XInlkkrnuFAzhkok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DHuK2xhQwDVMG/hy+7vjJIfalriPx//lnd+aGtxFwoXkvWzmoXs8qyzaxSjUNumSw
 JLtCnH8nLS7vLtk1Te8xYZ8mwoYbhrFiaBGgMG1xGqfjqwilRHA+DIrCtz54hd8ZOX
 bj+9fMYyKVTmHNhtiLL0PmyrkIrkbtmo5JYSxJF4=
Received: from dt-VM.localdomain ([175.152.130.74])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6460A831; Wed, 11 Mar 2026 22:25:06 +0800
X-QQ-mid: xmsmtpt1773239108tfmx7w0bz
Message-ID: <tencent_7B1A04150B5EC83A51332D26AFC3EF7DC906@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/65xy4JbzP99Z//k2GG5e8sMRl/C8kKhCHiyj8sSJkFk3M+1I4MAm
 vQxzLfjlVXuEapkrrr3TTuGIaooR2IiOE4Y8M+5w2m5Ktls9rWiE4mKr3pK1Xy5TjVfGKW0jrdMY
 wgjW24/K0SnWjkJHcYzLdSGjcCp/U4ZFGRKPkW9ZAG6LcCo8fJL1NDZbPoyZipN8lJneZQcEqorp
 3vTDaOub25jEHLYELmeNujtCSBbNprHvV+uRwKpkxp2Q8sRHSVpQ9uG5Wg1jnghR9+ob567ZEOZi
 V8XL30ePc789iEokIh4jcYxZVIdxBTDpcRHOwdpm9Ja9bSDN1asL36X+qp/myQR3hEmMzgUR4g9h
 crS8WkTJ8AGKGrOHGRDOlb9RlD5vLbS3TEbcHQAQMERv0dJ2B58JsfznePLdxZ8Padbgl5wlsy6Y
 PJkGm3vfq0I2hSysnCMKPmvaC+wBMXAYbOF0Uw8I8n4v3/58V0w2aYjbi06snBHMTK3velYMu8MG
 yAa/MVqF/L50DyqMo2/A6kdr4MZHITbn/Uu7puAYNvV3kvp3LbtdW4CeyUlgDLAoY1DTSYVOrHQf
 wTlMTqG6VGL5zTG4aCAlbNnHW5SUC/Q0Qjwm1D9AJBMnrkmug+H6xxr1Lirlh4fRVlJXnFHdNHGv
 yNG06l6zN3Oduh/bDQ4XxqwcjAIoJTb1d9pkbriKliIIF5zflE8ItbxE7gSy9JPnKKSGq5NQI1XK
 gjtXXwaFEeGfecS6YNjUBtEyQpMjW6FO8RdpCvYVnjtMxNhnZDodm5cTFX4jfs3rlkUJmxRwgUmE
 8aA4bKi/Wc45jD9WWFL4jBar7ovtARFuiAKmbgN+k2Ec92s52Fr3yHbumlGPKrziOB4CP/qnGK5m
 XOE+L5z7+Pqw1WGstofvukU5Mcfp0UeeoJDXDeC9zx78vw4OzRKeoSXMHwHrUOGve3RwlyKYpVGN
 Xg34LjU1JortAp7gcWbxAAa0pMYNrMhhOnwW0Gv1g6fi6R13DoPR7gkMqILAeU4q6JyW430Pso9d
 07ryJUjpi8XubFCIsyEGkyPFAAL714MDJoyqvRDVYMOF3Ax7l0eb36juDzjniNL19U6yxU4KSJj4
 yA6bh9
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: 1774596582@qq.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	TaoDing <1774596582@qq.com>
Subject: [PATCH v1 2/3] The swidth and dwidth of pl080 are not equal.
Date: Wed, 11 Mar 2026 22:24:57 +0800
X-OQ-MSGID: <d149752c8bfa748039d42d2e5c8cdd5bed26d414.1773236195.git.1774596582@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773236195.git.1774596582@qq.com>
References: <cover.1773236195.git.1774596582@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.242; envelope-from=1774596582@qq.com;
 helo=out203-205-221-242.mail.qq.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

---
 hw/dma/pl080.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 1a39954f04..f8a0ae0342 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -164,22 +164,30 @@ again:
                destination widths are different.  */
             swidth = 1 << ((ch->ctrl >> 18) & 7);
             dwidth = 1 << ((ch->ctrl >> 21) & 7);
-            for (n = 0; n < dwidth; n+= swidth) {
+            xsize = (dwidth < swidth) ? swidth : dwidth;
+            xsize = (xsize < size * swidth) ? xsize : (size * swidth);
+            for (n = 0; n < xsize; n+= swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
                 if (ch->ctrl & PL080_CCTRL_SI)
                     ch->src += swidth;
             }
-            xsize = (dwidth < swidth) ? swidth : dwidth;
             /* ??? This may pad the value incorrectly for dwidth < 32.  */
-            for (n = 0; n < xsize; n += dwidth) {
-                address_space_write(&s->downstream_as, ch->dest + n,
-                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
+            if(xsize < dwidth){
+                address_space_write(&s->downstream_as, ch->dest,
+                                    MEMTXATTRS_UNSPECIFIED, buff, xsize);
                 if (ch->ctrl & PL080_CCTRL_DI)
-                    ch->dest += swidth;
+                    ch->dest += xsize;
             }
-
-            size--;
+            else{
+                for (n = 0; n < xsize; n += dwidth) {
+                    address_space_write(&s->downstream_as, ch->dest,
+                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
+                    if (ch->ctrl & PL080_CCTRL_DI)
+                        ch->dest += dwidth;
+                }
+            }
+            size -= xsize / swidth;
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-- 
2.43.0


