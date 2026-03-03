Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DF8EB365B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFnU-0007pw-Sa; Mon, 02 Mar 2026 21:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnQ-0007nq-TL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:40 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnN-0002pt-KK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:40 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 31A1F1400169;
 Mon,  2 Mar 2026 21:47:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 21:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506057; x=
 1772592457; bh=ABtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=h
 aVHl+8nFjHYBiSgTT/ZMt2kYd/NHeci4EZmjAYkIb74o9nkMz7P5gUhiyxSpA0F0
 v/G+b6qGSDF7Ou/PsToJgi1WU1O3g6wX0DK0kLoJRCD4aWs7ZXzm/pn5w8PIPIoR
 z5GpJHV+nWqDh6phHinVnloTqY+iPzAit5QHtBGvCcbBs0MarC8TKD84Tmd8EYEg
 PqjadN/HxCe47/hW8YKt1qcB9lrJNC9P1hHkSmZMdbLzE6V0FAVdPhd9sSEQiWeO
 zwyoXynxt+Wt30Nl7tzlPzCV8rkmM8Q7kYzXUaqGgS9APwE/wgkkxJs9YANu80tX
 teuaSvTpzz+FdgM9QL7LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506057; x=1772592457; bh=A
 BtiVlaCZkrAUapG4ZkghRtl4BtewIcQLfaOOoKZZwo=; b=DAo0TNVgxEKh9Y74h
 hSmVj+P1XwCgqDnGJXuBZdL90QiotEECTR1QYjNB1FlotrSFR4DPe1BMEiZNeVmF
 HHT3lzStYjzDjp+oZ+TU+y9bqzoqwmev8uW6OdJziHYbP85oz/bcO4ieiKbSXAMA
 XcZtuoDb8sY/KGwHg9ywyI9dhPjFwDsa44oL5xck2+4tIyzmTdDtvGL8J/bs0rEv
 twtwdSxHbrmrmiA2G9F5bIkryYvqfqPrpxVvI4JsXrVFAu6GbO/MhRgYY7JdVOkv
 H4IHy4qPjCcrLY4/8e1UIVX9rWAt4Ko0mJhsKLqm+zY1rznxkkXAGnPd5OlBeu8w
 tco7w==
X-ME-Sender: <xms:yUumab6OJXgp2Z6hMxzT1_6LelHzAXI0xITNxSXmbvSlC6-fM-Nc8g>
 <xme:yUumaXxhkVxq3eJQF2EXEcwItpukmuFwja0fCS7YqiNeCWTdF3VW_nxhvs8c4lDQW
 lomtUlBhvn4y0RV4bAuYX0yzEai4DtDYXcBA0QVlkqD3-fJ2u-j4A4>
X-ME-Received: <xmr:yUumaax83hCeeEdvs-hXdzAyNGVu1dNMY878gxj7YR7HUdWdwljs_BBhx2R6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:yUumaXzH7q6cOsVBnJKZr54EmjAwG77CNVX-QlLfYgZRh9PI6eribg>
 <xmx:yUumacYUSqYrKe7Qrz1a26J5BwRwKK2Iy4FkDsrHa3_Jh5zoWVSlkQ>
 <xmx:yUumaQUWuTrPDl2DHegy6pRSj3vGrfsAFIt-nUdYC-5fwepzZLWrKQ>
 <xmx:yUumaSgmbEPzWjrY4vglBM-7b7vCNod_Wb1t81Ri_4L5KDcnGm7j6Q>
 <xmx:yUumaRcC_SzhvKOxd8TKv-WxPuLlSOOpg0W1u2D7bQ7gHhS6mKl3M6ys>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:36 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ca566190;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 02/17] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Mon,  2 Mar 2026 21:47:15 -0500
Message-ID: <20260303024730.1489136-3-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
handlers attempt to construct the value from pitch and tile bits in
the register state but mistakenly AND them instead of ORing them. This
means the pitch is always zero on read.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8438a77de0..777a6b0a2e 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -438,7 +438,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_PITCH:
         val = s->regs.dst_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.dst_tile << 16;
+            val |= s->regs.dst_tile << 16;
         }
         break;
     case DST_WIDTH:
@@ -468,7 +468,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_PITCH:
         val = s->regs.src_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.src_tile << 16;
+            val |= s->regs.src_tile << 16;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.52.0


