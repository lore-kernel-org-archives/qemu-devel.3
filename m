Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC10CEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNyT-00073c-2u; Tue, 18 Nov 2025 10:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwv-00050y-FB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNws-0001wT-P1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 9C0E51D0021E;
 Tue, 18 Nov 2025 10:48:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 10:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480913; x=
 1763567313; bh=A8sw6P8KaBIyjivBG2shWLAUOqou6GlRKEBs0zT8izs=; b=Y
 4IOEFflW8NZaYl+p62YkrByj/D7j8cgOYPuzqb7B2URVF/tx871+yi2t4PQuizs2
 W/QuBiyym/eTcjoe5+OjPc6pabW5OfXQkNRn3SQLWNMJ8Eow6FHA4uJxITLONgey
 6Sjc892XGLSEmhO3pFhTG7HFs+WE2pVqjfR9j8KRGfBjHG4fwSlqg6GGj9sMokCP
 C6LArdOsjW9K6tKYJJJxIoKhUEeQWfmVmAPFxzZs46F08L4/K+ebgby+5+GI1/EQ
 bPjikYOFuwEjhguFI+eZrrYE+PYkpfH4tvnP0h1AP9S1SFPMWLtt5OuiqjNuOkSQ
 858kqSQ+C0HA6Zwdwb3iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480913; x=1763567313; bh=A
 8sw6P8KaBIyjivBG2shWLAUOqou6GlRKEBs0zT8izs=; b=ZIuaAbyay18J8O5xu
 MWXRAvVDumgpj/EHCYo4Tohkixxbhd2yO1pm6oKT4TVVLqt3KJOcyPkPqSsJje8U
 QJ/IcPunow7nY2bZlarUmWFX63Ghhrwu/F/Gka5Kir/I9M0q8dSyEoGrAdHL063V
 iirR+w5iNkIUBLGhiQRsEhsAgtlBmF1ETxcEIHmhwCfwCQVGoZS5IoX6ZdGGjnpU
 y32w4mMWN+dv3FA97+hE5ODRJOpHaj2s9517VJcnT8vWd/vSixcjQMvkMdxjLrW2
 c9lqwzs+0lq2LetV7tSgX0zG+gqzv3vHUllWrT6b9Xyt79b5xJrstpu/pcqmAiej
 +z7dQ==
X-ME-Sender: <xms:UZUcaYUqAezfnllbbWOw51yeRTOD4X0R0m5buYKer1iiC48VAtBc6Q>
 <xme:UZUcaf2gzEUfpXfWNbVbi0eX-2N-WEsCzWQ05VUFiI4X4GuJbA-T_hh7Ob5lHHdBR
 v0i2h1Dxz32vPjxSRfUarz7FSZiynilaPZKam1kXAdWrmTy8_wB>
X-ME-Received: <xmr:UZUcaV1dykiYE1NQSfVgVItuep38NC7SIQmKlH5WA-QwLYYAHXsbef3KWhqK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:UZUcaS_KKPA1b035LbprffKgbCYMwJtTQQLWdb3b8FVXZoqG9PxSOA>
 <xmx:UZUcaS3R6RavSqLxbLPdWd8rxubQpnRQjqPdHcgU2rYr-jRcgxMS-g>
 <xmx:UZUcaf-Hyxw2XJFJRaIKK18T-QcN85nX_BNPZM0v92LKQOrFVG160Q>
 <xmx:UZUcaSvCGgN1RZG73fIJ_9zMCKQloZPKyw3jAW8P3PHfhY3tfqhSDg>
 <xmx:UZUcafHMxX2SJOCCyPLasrJpiDrto_YjpGhDbOI8fbzKHwDVEIootq4G>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:32 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 1b937f50;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 03/11] ati-vga: Implement foreground and background color
 register writes
Date: Tue, 18 Nov 2025 10:48:04 -0500
Message-ID: <20251118154812.57861-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index cb979ae0fa..a2c0302e42 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -945,6 +945,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
2.51.0


