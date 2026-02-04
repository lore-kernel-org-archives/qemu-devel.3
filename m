Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FBCE9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1R-00078N-RA; Wed, 04 Feb 2026 11:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng19-00070F-M1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:16 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng16-0004Wg-Kw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:15 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id E46111D00152;
 Wed,  4 Feb 2026 11:46:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 04 Feb 2026 11:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223571; x=
 1770309971; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=K
 5/aA9d5hPXS+ho6+QcTzgQh4Tr8zwPi791ScgnSC+0B9Wjb9omoK9ByhvQJqIyOC
 Xs1xNWf9HFDbGtZ54bde+5Xb7XpA1YJitooJD6R+zfnhmf6bOR1+P75sPc2PgfHe
 SiKHmdVOmuROmFt7HvJ5fKhsifOh/nKOI1seE30d87S/1XCwcgB6Nk3Yrv2Ec3Fz
 SL1Yarhf+zAm4Y9aTRkA4MLy9Qf0jL/IajsyctHy9YDuL2TzG0s/IbzSsy5Ylipn
 rYFsxktJvWAsjA5C4EDyKu8Clfz2RqE5hV/kX3znTjawNidq7ipi8Sp+3JS+Yka2
 bExL21sgxc5hP1XzTAf3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223571; x=1770309971; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=ntYW9S4y0773yqld0
 y3JdhOPn4OG5pwithZHeC055PJAH/DcyCgT5139H5+1oYRbzV7YHNDcegHtH6552
 j9ynGgEKtr9pJskzUsm3foytzFZr7XOHAZH9y44Wx78HTFVA7VJZiA+3z/IGyUe3
 w2CUsSsOlTi0pj9B/HewJiSIKGeWG5ZfyqwbGeaTPfFfXcEzQBHCLrEMZGNBLuuy
 hEfR4PAZUYdgAkPYkBIezTKgsq2yPsVoQsAnoR+9Ha3woGDA/iyc5EKiJbTnNa6j
 qSxCf70E5QvWnEsxD00UQ9KhzWDBatXHbnLBa0/syoHhluFQSoGUAwe3RkvC5OLt
 JRWvw==
X-ME-Sender: <xms:03eDaULqDhHtEA063PbbQ5DCnYc9IS6HC04IrY5TPWCfFZy1jlXSIw>
 <xme:03eDabkBe4ymREi8n-VIKA_DU8erHOHBU5Onr3eSiAJQNBdIUfa7uDLYXlm0EMU7c
 tIsB5O2PG0WXqxNGlrnoUPybQL-QjOqLLQ9yOuccCw5kvGAHEEIhP4>
X-ME-Received: <xmr:03eDaSH69YyclJXYE8_hG0-wp3CrzOimbxu_TZpYJhGpxa-RfXacEC1VNJIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:03eDabGpqyBHJq_En2eDRUHW2enZmpGDj7wM7LnkF_td0TQ4ZFlLww>
 <xmx:03eDafPBGXt8h_y4Wu7hYaWMB41OQU-jHfNsVQufaVhoARRggibvmg>
 <xmx:03eDaaFnzR770FVRkhCnwu_OIMgR0p6ZB0kBtKr1QbnDMfMVS_qEEg>
 <xmx:03eDaWPPzjyYJeyJN4GgFaN1b9oNoyUyam5-KXP2DHSnp9e3uHI0cQ>
 <xmx:03eDaY7i8ckVm1DBGOHR7f20SM1Vjcb_C0scumrTyYobM4HX3_cucgN5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:11 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f1fd96fd;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 05/18] ati-vga: Implement foreground and background color
 register writes
Date: Wed,  4 Feb 2026 11:45:53 -0500
Message-ID: <20260204164606.3425246-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ce23e5e48b..26fc74b19b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -924,6 +924,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DP_CNTL:
         s->regs.dp_cntl = data;
         break;
+    case DP_SRC_FRGD_CLR:
+        s->regs.dp_src_frgd_clr = data;
+        break;
+    case DP_SRC_BKGD_CLR:
+        s->regs.dp_src_bkgd_clr = data;
+        break;
     case DP_DATATYPE:
         s->regs.dp_datatype = data & 0xe0070f0f;
         break;
-- 
2.52.0


