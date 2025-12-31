Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18FEE644A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dQ-0000qv-9o; Wed, 31 Dec 2025 16:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dL-0000pV-10
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:31 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dJ-0003iM-Bb
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:30 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 834A8140004E;
 Wed, 31 Dec 2025 16:21:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 16:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767216088; x=
 1767302488; bh=cOlZAnkN9sjN1QjjKuf1SyOn+m2Ro1DZ/qaGUkQOMhA=; b=G
 MlGuaa6RkpLWtt3faOl1tSsLsgt15c0RicDoVjOBWBoPn/jT5uPgmtILwojyGkeC
 HINU35PDLwLqdjRhCWVHL1An12vUpcNAPxR0Va4AMYPpl4qhxbcT4bT6RrhzXwMj
 t5u+5em0ZDHISrlJJoUpzy9S4+1/hDLeQAVxhs1y+7mLfGMse/ahvuJxrc5aNBhM
 QqmN5v5I0Lu2pbfAMhYo8asvjp9TekHGzAUNcX8HcVEbmfY1wO8xoBRuJtLOOO+K
 T8U40AalSTdj7ctPkz4WN3xq2iaXlTdixpzswZMxb4BSrHm68f2zxvAavyyudbzL
 lrOI14VULg/vMAFK6uz0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767216088; x=1767302488; bh=c
 OlZAnkN9sjN1QjjKuf1SyOn+m2Ro1DZ/qaGUkQOMhA=; b=KAHtoD4oUPQm/XLZa
 +kMazKdvvtG8iGQ9COt7e8G0vwflzxvEkIKWksvDM3UJGRNix8KMgOqtc9nrPs+c
 DMWHv1w3beE1elq5FyFHMAZVzztO8Lwh128OgYsOaSIK//CLt7ZMRe4GFF87aHJ6
 yQSw8fbMobj9ebQIgPzOWAelutp+lELuDVNTnzS7gANEx8DVvZOdx69DUW3qNJJL
 73V3CQULqQ2xLAypYJijIlZxnGXzD0NtFi//0oUYwTbpVG1MX24jOI5iXuiAfK4q
 tysNVbUwC3i4q0veKEh3i4yyyPidPe+Dz9w2gqky+jOehE0t4qNx3DV0QOPEUbfy
 7U4Qw==
X-ME-Sender: <xms:2JNVaY0eYhXNB3Dtst3sllYzOmNVsQDW3Y8ct8KvYY4JOOXxBQxsHA>
 <xme:2JNVaainB2Si-wUNPzPYrUf748YO-IedHkdbAhh3F7xHdZpfbnBZk3RH59V8RVLbz
 D4ob_OEJghU1Se0UNeF-0IhJGf3W6hk2C5YQwenb0upTf3QKQlOMA>
X-ME-Received: <xmr:2JNVaeRaQev6GqhasJdJT8WpkbKdJNMW1ZTP7tuoRqNXszccGodvm9_ZnlDr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgr
 sghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:2JNVabgOd01ezkfq6ja8vYp2D50rTT7IKh20_a2MlXoTOIMAeg9loA>
 <xmx:2JNVae4P7H5SLSMG2EMoOv_krM_aboIESa4xSybQZHloNO1TH4dCqA>
 <xmx:2JNVaYAdzD46Zgd7oDZXrjlGnc8Rc5O9tCgqZt82HbCG-fVF5Swpig>
 <xmx:2JNVaVaZPL9OwHCWUmmxUHVjnFAZS9xkIosh7m6_3DnVzdidgwdRyg>
 <xmx:2JNVaSNOWkyijSvhLNMzuTLQHT6Pl8NIUM97lnCz1cwzDdFfy4_T7XDT>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:28 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e5a7cc78;
 Wed, 31 Dec 2025 21:21:25 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 5/7] ati-vga: Disable GUI engine MMIO writes when CCE enabled
Date: Wed, 31 Dec 2025 16:21:05 -0500
Message-ID: <20251231212107.1020964-6-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231212107.1020964-1-chad@jablonski.xyz>
References: <20251231212107.1020964-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When the CCE engine is enabled, real hardware ignores any MMIO writes to
GUI registers (0x1400-0x1fff range). Writes made by the CCE engine are
not affected by this.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a9fe0cd0d2..82450c0331 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1131,6 +1131,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
     }
+    if (addr >= 0x1400 && addr <= 0x1fff && s->cce.buffer_mode != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "ati_mm_write: wrote 0x%lx to gui register 0x%lx while cce engine enabled, ignored.\n",
+            data, addr);
+        return;
+    }
+
     ati_reg_write(s, addr, data, size);
 }
 
-- 
2.51.2


