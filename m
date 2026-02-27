Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF3AFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e2-0001Zg-Na; Fri, 27 Feb 2026 15:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dz-0001Po-P0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:05 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dw-0007PP-Ls
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:02 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 614AE14001ED;
 Fri, 27 Feb 2026 15:40:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 15:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224859; x=
 1772311259; bh=t09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=g
 1NVmxTRbPNKcP4fYMC2oIceBW921zYpqMcbmRI0Dot19PB7B67Zj2U7mNCdDU5OC
 Z9ecCFyRxrI7VyA+8VyWtiak7wRbRgTk3IIt6kEADaWlVTJr24wzgECT2SIl+eI8
 B+XbSTiO6yrQivH/mTTPsl4pqj6tmtIUxsXvmRJGGuiL7lZzu5IjOierCiUuC2sD
 fgV6/H0UlgbzwQwH6KiRe5q0R497/try2vaWt/I0oQBd1LbssnGG6mzVddpfLw/G
 XdzFr0ECP3M5qefx4+fObkQ0/nOcJnX/Rf0jMHafPHoXMNvP4WEB6uF+tHUFSInT
 heNu3wBjSUQbXuwHnMxnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224859; x=1772311259; bh=t
 09fhcpWk+aZIQ1AgyqKwCgGRfq7HEmlcpbHugFS7Os=; b=Ihqn3CvarevGfwiY6
 5yQbxEydXPYCLOT7j9vyuCdao/J8P3g5E1yhP0CXnk3tcyStEAZoDmZy9SqS1+Zm
 bMFYePPWcQTGVLpIEkiwW6xOE/gdRplEecIiqOFdsm9c9DC9w7YnWI5Rp52nZJkE
 TCYNL7nBjIBQL1QiEzs5bfwiPocuwaWDhQfmEeVKH6JzziTY0GXlu/TKwl7KmLRr
 ntlC7MJcmJ8k3ThqQbGlfhEmSjJUzwU3fbuRfOH3fb67Bc3Jh+SdXtlwiCD+gIi5
 N+t+FvDdCo/5WTGB40EnEjmPAVgGv+dOVjponmqbQFvTVhJP4Og6BAjQWUXiQZ5/
 2InIg==
X-ME-Sender: <xms:WwGiaeE8NFcAb-AT9haHERv8BnQ7HaxlQtm5BSZgRgdJDB_9H2mNeg>
 <xme:WwGiaa2kbvAKrZeZ1K4s3wrgm47QaXwO8U-iLuHx9w8c3zE6C7heDTBfEe11vvSSc
 E6zP6V_n3JxzLwQCu8vGnOHxfTmfjuRTfZsZ3anIAoTDMc87rluDD8>
X-ME-Received: <xmr:WwGiaem1LCLY7AMOKXdJ_xtEy9S1kLwugWzprtJNMY1Z45V56Ljl9kv_gnJH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrg
 htrdgtohhmpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:WwGiaS-HWq6AQqKIdgx69ozVHPidoVMGB3Rj-voh0v5Gaab6WmCAVg>
 <xmx:WwGiaboiUPdY3HOoyh8d6vaCBkJhzeC4D2oStBsVnUFDss0HDITLmw>
 <xmx:WwGiaTktA_J6A8yReoBF26iOjWbIZ25P15qx3tfl9BBuW96Xl1AYuA>
 <xmx:WwGiaai4-Pt8Qp1hR_ksvERTYjvqEtPjC1O3tzapDYGKb0rZ6ud44Q>
 <xmx:WwGiaejrFQkYHWaRgblPYJfVmhiyIf7xN2_Qr8AJS2L9_9NDe4f7KRg0>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:40:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8727a4bb;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 05/18] ati-vga: Implement foreground and background color
 register writes
Date: Fri, 27 Feb 2026 15:39:31 -0500
Message-ID: <20260227203944.746471-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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


