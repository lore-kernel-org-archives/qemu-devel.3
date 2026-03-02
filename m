Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09968EB362B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7dq-0006Ln-6W; Mon, 02 Mar 2026 13:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7df-0006Cb-IG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:04 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dd-0006Ll-P9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 36BEA1400094;
 Mon,  2 Mar 2026 13:05:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 13:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474701; x=
 1772561101; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=G
 PRkKfAKcwAYCH1zQF0NP9b0dIlW/cJBvRMkpGxn4+YqTtBqe0TajF+obU+/945PL
 MuC0lVm2vD6Ab7maGzYKRZ85baJE2F1UapYfQESYfklRcYkqgMzTRrCRpR1wUvrE
 W+CtLOtfKXZBLVf3GZQgu19t9k9hSzMulpgzFF7RzHRLyinh5nj+4CimjXUmgIl2
 VS6VmTCFl/a1vtUXlBlFR9rnGkJ+dhpCyL8RzuBnZTi028aBh7rRrP8sKOe1g7Hz
 WLhtGVaWtABt32Zr05rpRFGLvlNQ6MdQqbJTSpO2ePKTZzwYrb2iSMfpeLWXFTjr
 GWEeJDDX8N4a6gsDzhRuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474701; x=1772561101; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=ikprcpc68X927VYjw
 dRgFwjLTccwmb50ddtkCFbfWg9Ce04pNNGLXT+KyppZFYX1Yc5nN3tZh6YZb8Nn/
 C1tG3amMnhvbE7PHJsYY0Csk3Eda3dmndzbGV2a2Dn2Hwy2EUIDiz49S/Czh1VvH
 k9V8Auw5tbPpfn4TBBz2l5FUmDnYBAwNp8HXvPam4lj3LBoPQVdormkzbuvFrSMi
 DG2k2GK3IE5SI99tzvNRuEnWZW2IM9E5wMGO+20+k+3pCCGo7LBDu3K50bvCMt5k
 RcjcrkGKFmoE8QwOIublXBGLD4Fknp/knV6cXsisxTe6L76eJm3ENUO/CDpn05XR
 VcZIw==
X-ME-Sender: <xms:TNGlaWYLMPcKRMzu_eVMaEjLXVYfdsMeQAjopjsLh8ZhgWxCwkVXOw>
 <xme:TNGlaQRl53oeirO3C7Q8vioVSYHKBJR607eZTFwzFxOvxi4xEs3FZXWAyuGhka2tX
 h5y-wj1GsWb1_4U_acLNrAssST7NMNhlq1gp6lhRsNNQsk5ecM_ddE>
X-ME-Received: <xmr:TNGlaZQtCnTP2QJ46LLWDS2lW-9eNYcaMy-0P0R3Y2Z1oKARESHFBwC5E1wU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgt
 phhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:TNGlaUSKWW_MQzJWITfaBd8VriBoo3Mz4gqB3kvq1TujMkNqBgGnUQ>
 <xmx:TNGlae6zHn9KZa-9hetVlDPOMr5UM5fTu0oN-nSBCl7ojMTn9z0bYw>
 <xmx:TNGlaQ3KHv0yjsYuqFF_zBoKwZMpWvTfh7v6qMVbJSOrhOknY_1l5A>
 <xmx:TNGlaZD92E8ZwKEbD1rnz_MooOdwjW4BSNi74sYUmsr0h3-74amxSQ>
 <xmx:TdGlaRtjoX0TY52wsGcmapHmiKk32vg1vxZcLmF_6ysC4P2DdCweX4v6>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 6e6c58da;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 05/17] ati-vga: Implement foreground and background color
 register writes
Date: Mon,  2 Mar 2026 13:04:35 -0500
Message-ID: <20260302180447.1078098-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
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


