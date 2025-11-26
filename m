Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C3D10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGIY-0000xG-UB; Wed, 26 Nov 2025 09:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@wesleyac.com>) id 1vO6pA-0005hA-KI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 23:08:13 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@wesleyac.com>) id 1vO6p8-0007tU-1I
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 23:08:12 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C8E0914001ED;
 Tue, 25 Nov 2025 23:08:03 -0500 (EST)
Received: from phl-imap-16 ([10.202.2.88])
 by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 23:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wesleyac.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1764130083; x=1764216483; bh=Xh+scfLymd
 oCuWFu5/Tkle5QpWNn2GqqlN1vrgBZ9PQ=; b=O0W4JQnsV1D3b6O/Eh4t8jbfXl
 xdi4bpJguzrwR7TnUTB1HGGtNDXc6607ol82Elr0Ynt7oKOwWFYtNS/PIs8LoasM
 K9hr1lz1/K/AnVfVTMIihFBhJ7b4uHJoWWFM4M9Qdb9jCtEdIfGT77Fcsd9cFERi
 5O7Z37C5KnZazoLmohbeLbWINu7vWyR1zfh/otQsLJ3nYRO7gNWxVIdsHuuR5bWy
 QOORLdU012G08ETBS0cuR/2Z3ypDQJpLzThvkC/m44zbtzw+TJMBqzcQ6i/dFQhG
 VuXw656b4MOtBHIMWlAfttzLuy7PkwAXCdW6QTh2Q04U7eogkCckKcjA/QIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1764130083; x=1764216483; bh=Xh+scfLymdoCuWFu5/Tkle5QpWNn2GqqlN1
 vrgBZ9PQ=; b=W9kr41tHj59uoHQhGiQEMTdUsGI/U+OdZ8Kis/TzpWj2bE1bbks
 rEjGBoFr92g2AbAHiHq+cQ40lRLGhnLTD8qEiMwnC0XXb3T360b4YyRYJs/ImrNV
 eeuxQdmV26KuN7qTyN/Jq2lgniB5bSK84DR85/JcB2bXjUTw8QfCNfoUc09SX57n
 l6XV7feTplCd2z6zsPtV7FxYFgzTHz5iJ0xXtdFkMcM1jcp1eACtk4BMrAT3UVe2
 Xct7XZbedi54W1e0mobe34mLW4Fejuy/5NC2lIihBL7u9bFcAHo9Xv5Bo1O8By0i
 wfsskQF+F0fKtE78jzkSLPxLkV1JPLXjXMQ==
X-ME-Sender: <xms:I30maXo40jHoIsaAaTmRxEl_joBb2jlaOlD6qV87fgGa2CPNrSD-1A>
 <xme:I30macd7Rs3hVHtgJq6-Qyx1ZeFVqYUt1F9c1dOpZcDLTOmug4B9hQC2BhJp002LS
 DKoY3Dtwwalewe_XYADeGFalY35fLDKR57oUPZnaiPq0Py-bp4fQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeffeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtjeertdertd
 dtnecuhfhrohhmpedfhggvshhlvgihucetphhtvghkrghrqdevrghsshgvlhhsfdcuoehm
 vgesfigvshhlvgihrggtrdgtohhmqeenucggtffrrghtthgvrhhnpeeivdefuefglefgke
 ejfeehgeeluedvfeffkeevjeehgeetffelveettdejkeffveenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesfigvshhlvgihrggtrdgtoh
 hmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:I30madPYLNm8_uvDuVQJejq2lM4P3NiQH1XympSTVKM_I9ImWpLL_g>
 <xmx:I30maW74CUaAJK5jZLZbV3GL72DuDCt2lRrkWM9JRJLW7POfqXypWg>
 <xmx:I30maR4G_Kw8pzwC_pubgKxYLqPDBvK8tMyuLjwZIoFN6Zt_vNoKUA>
 <xmx:I30mae0P6yR182ZV6Z43jdCs5jZXReTlqBWchZyy_rh8YZriOU495w>
 <xmx:I30maZFQ1-wFi5yzlvlXpOPzUCtFSVEN0EfpHnllpJeYuiqqBGM8QsXr>
Feedback-ID: i0c594533:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 7CAFA2CC0083; Tue, 25 Nov 2025 23:08:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 25 Nov 2025 23:07:43 -0500
From: "Wesley Aptekar-Cassels" <me@wesleyac.com>
To: qemu-devel@nongnu.org
Message-Id: <4156bca7-ef99-4158-867d-c41893f7c8e3@app.fastmail.com>
Subject: [PATCH] hw/usb/pcap: Prevent truncation of USB data in pacp files.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.155; envelope-from=me@wesleyac.com;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Nov 2025 09:14:44 -0500
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

Currently, packet data is truncated to 256 bytes in pcap files. The
original length is recorded, but the actual data is discarded. This
shows up in Wireshark as "bytes captured" being smaller than "bytes on
wire".

This is because DATA_LEN is used to limit the maximum pcap size.

I'm not sure why 256 was initially picked. There are several sources
that report 1024 as the maximum size of a USB packet, so that seems like
a reasonable thing to set it to.

It also might be reasonable to allow the value to be configurable. I
have opted not to do this, since it's more complex, and there does not
seem to be a significant downside to increasing it to the maximum, other
than the potential increase in size of the pcap files, which is a
tradeoff that people capturing pcaps are likely to want to make.

Signed-off-by: Wesley Aptekar-Cassels <me@wesleyac.com>
---
 hw/usb/pcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/pcap.c b/hw/usb/pcap.c
index dbff00be25..86eb603b5b 100644
--- a/hw/usb/pcap.c
+++ b/hw/usb/pcap.c
@@ -70,7 +70,7 @@ struct usbmon_packet {
 /* ------------------------------------------------------------------------ */
 
 #define CTRL_LEN                     4096
-#define DATA_LEN                     256
+#define DATA_LEN                     1024
 
 static int usbmon_status(USBPacket *p)
 {
-- 
2.50.1

