Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5171D64083
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 07:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVlga-0003mF-3O; Wed, 17 Dec 2025 02:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1vVlgX-0003ls-Pm; Wed, 17 Dec 2025 02:10:57 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1vVlgV-0000J6-Of; Wed, 17 Dec 2025 02:10:57 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 64E9E7A01C5;
 Wed, 17 Dec 2025 02:10:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 02:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1765955451; x=1766041851; bh=X+
 71vWb1XfXWzj4F2b7sjtBRXUgUZs3OF3KMjNiwC8w=; b=3RxtWFyqvdyk63+MvO
 +i+kVaf2QfKIpIwUqH+cX4Qlo6kBQxnSlnb+YVwNcSXBdjDpZcBVSBIo8sTii2Ob
 WHXB6UVU860jFvBo1huDzvAEf289zVu4loVwloZXPEduqoYH1ulKutebvqr10IdT
 +YmpbSz1Sjds6mtzkZ2mEY2XBajJWO8vfhBVQRR/keDhJ2rSmtFZMg+edSSrvTFt
 FtH6WhAyiSoWzb0S4VV10YpeNqgjJbUpIqvZn4USaf7oPVpc5QuPhXLyEEqmucK4
 PGuuAM+jboZ+ZCU/JrpRu6Q1tRNSqe6lEJ7qNV7pblTqMHTkqtQWUBTqIigZWvMG
 N59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1765955451; x=1766041851; bh=X+71vWb1XfXWzj4F2b7sjtBRXUgU
 Zs3OF3KMjNiwC8w=; b=jjxwU+cpeV7JYBwhvJcshqv6gDvm+gN0aHogf7VnW6n8
 gDySVTJDSB4tvRhsNY6OvMYBrQeTk1+3UUP3fmcd7ntG85za1WuquAYnVJJhSNG9
 7eXxsSuh2/b26llCrJs4lEIm94orbWX7c8FpSYpsKJo1EE25YMqKfQXUy6D4O6GG
 POE/Mz5HzA626Q3NhEACCbsi+GVYotNiPjcGnNQwslxRxQ/CVq/2KqHy2YDejFOc
 xFP+B9Xo2MQpxLP4D/KtU5DQhln2zheqfNCDAuJtmfkOLsKin+M3X9UiIR1RAlIQ
 +jXK0L1VSuc0S91dbPK4QSaLXLDZdzn0CnP44o1HiQ==
X-ME-Sender: <xms:eldCaWPt-8KdWfuXd-55hjAowI0-noOuxu80IyPHNHOPb1Fby0sIhg>
 <xme:eldCaS5NCGSm6bXQLWgX-uJ9owQUaZ3G5x6hGmA8vw_LMMvPr5cxlSQZqnP4ENYvH
 oHjtWS3vRzear7y-45vMCxAVMzqqQRpzD_oV04snYHHuLQhmSEM0tU>
X-ME-Received: <xmr:eldCaflxuQ4PdJbDurQzZRDN52DW919IYeZgXnhph1fZGXhg8ooaDrVEqxm9EkuRcWSquO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudelfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepjhhulhhirgcuoehm
 ihgunhhighhhthesthhrrghinhifihhtrdgthheqnecuggftrfgrthhtvghrnhepfffghe
 eujedvlefhffejgeegledtgefhteejtddtvdfhveelteeuhedvvedvhfehnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhiughnihhghhhtse
 htrhgrihhnfihithdrtghhpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmihgunhhi
 ghhhthesthhrrghinhifihhtrdgthhdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlh
 hlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrth
 drtghomh
X-ME-Proxy: <xmx:eldCabSXqimAVx3vLmu_eW6sWF6hrbyYPmH_53yREzVSAC5mOUTdcg>
 <xmx:eldCaWG_y9e81qUvmm3XrJWFvx3JdjFMXuFHtl5mi8GTDf3L2RErAw>
 <xmx:eldCaYFxk-EZZrEEiYgItuF0GiVDk1KmH3AvobOFeY6N60gOPya8zA>
 <xmx:eldCacRY3ZO4N3roA5_lu9vNY6r_VRyuo40AQF-zLEqvZkX53PSiAw>
 <xmx:e1dCaYEIPz3lq50SBGkhlZn4q375QANJvRhBketxgEO9c8w0QLVCf0K3>
Feedback-ID: ib36e48e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 02:10:48 -0500 (EST)
From: julia <midnight@trainwit.ch>
Date: Wed, 17 Dec 2025 18:10:41 +1100
Subject: [PATCH] hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to
 disabled uart
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
X-B4-Tracking: v=1; b=H4sIAHBXQmkC/x3MwQqDMAwA0F+RnA20wSHsV8RDbDMXNutIphuI/
 76y47u8A1xMxeHaHGCyq+taKmLbQLpzmQU1VwMFukSKPabF8wM3tjdmdZ6ekvHDVrTMhCH0xF2
 XSDhCLV4mN/3++2E8zx/SUJK8bgAAAA==
X-Change-ID: 20251217-cmsdk-uart-disabled-warning2-0072a44c2ea1
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 julia <midnight@trainwit.ch>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.159; envelope-from=midnight@trainwit.ch;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I don't want to admit how many hours I spent trying to figure out why
nothing was being printed (as the enable-ing code hadn't yet run,
even thought it existed).

Signed-off-by: julia <midnight@trainwit.ch>
---
 hw/char/cmsdk-apb-uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 32090f3516f6accad32bcd9fe9b10d572f17ed12..26931ab6c5d36f0ec5aac7acf3677855a6dd5f22 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -159,6 +159,10 @@ static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
     switch (offset) {
     case A_DATA:
         r = s->rxbuf;
+        if (!(s->ctrl & R_CTRL_RX_EN_MASK)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMSDK APB UART: receive data read with Rx disabled\n");
+        }
         s->state &= ~R_STATE_RXFULL_MASK;
         cmsdk_apb_uart_update(s);
         qemu_chr_fe_accept_input(&s->chr);
@@ -248,6 +252,10 @@ static void uart_write(void *opaque, hwaddr offset, uint64_t value,
     switch (offset) {
     case A_DATA:
         s->txbuf = value;
+        if (!(s->ctrl & R_CTRL_TX_EN_MASK)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CMSDK APB UART: transmit data write with Tx disabled\n");
+        }
         if (s->state & R_STATE_TXFULL_MASK) {
             /* Buffer already full -- note the overrun and let the
              * existing pending transmit callback handle the new char.

---
base-commit: 7154e4df40468012fccb6687ecd2b288c56a4a2d
change-id: 20251217-cmsdk-uart-disabled-warning2-0072a44c2ea1

Best regards,
-- 
julia <midnight@trainwit.ch>


