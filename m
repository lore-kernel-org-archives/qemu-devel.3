Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821A7F33821
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEA-0005mq-76; Tue, 17 Mar 2026 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCE-0001UJ-QA; Tue, 17 Mar 2026 04:54:38 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCB-0006mk-Pc; Tue, 17 Mar 2026 04:54:37 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 6BC29EC0189;
 Tue, 17 Mar 2026 04:54:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 17 Mar 2026 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773737673; x=1773824073; bh=m0nSScOuG6RvhdgSMdI9VFgn7eF8Xqxd
 bu5qlCfdxHQ=; b=R0i714s8p4drJan0ky+Dwy19vmemsv9ng8srIoCvLd9TyEBU
 d/QO1YkSLYwVGcf1ho0zjrO8k1PfoFgBHKVF3FM4M6O9xfvjN0YK92XpNFDXfwfP
 +7Up+hhIRKAJcWsIhtEDbqZ8VByM0Nh0MmJeh/CaFyF1QMqELcTFaIEgi0k8OVo+
 jbGIE25gb97uvZtE+p0XJBh51dWkO6MgEv4wu2dRmI0REqYDWX102niVpSsHeSQV
 679Pe3TwnZHvnIa9wgbIAUUYn6sXxB5FBbs2jx5xBYZHZpC2EGULp+dTzwBEQVRs
 Abi6/2fwGPG+uIOM5GrCSUdZMh+f6Lo9tfuTiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773737673; x=
 1773824073; bh=m0nSScOuG6RvhdgSMdI9VFgn7eF8Xqxdbu5qlCfdxHQ=; b=e
 Zzr//8O/qOweXMCPZ/pvR6CGa3Etr2L3VVV5L1dfhMKT8DkC1R3a+3ldQXpTk0fh
 ZWEfS95fTpKc+joc7A+knbF9Oe1vYEgXOBZda+VS/CHv6A/r81LLN8oSa8pdG/Ih
 n9EnoY2/FS82j528n0oe2YFlQvgLWmj6772+YWfs8MccJ7xtOZ+GIYpRxSEAuleQ
 5E2H2nLbyu0FR87wXX1xZmw73VSof67MbsxvSMI1F8JLoNmRPSRpeNQ3u5Yuw8yb
 vZJVhlspOdm1sdeDKacWcXs59eqiglmtUfg5klvAlmJiLGTaCT0NMelM7T8EXa5Y
 UC0q6DsZelSc0hwTAqEdw==
X-ME-Sender: <xms:yRa5aUCcaLCn8di_2t6ivcmTg_RjOAXWC1iv6-Xu7WcaBdLJmF4euQ>
 <xme:yRa5aSgFpIRj_c1bywYojwIcDSWHRYiDdZFu9yj0aJERPr8iZVJGaKfhkXUjR0-29
 7-lWMa0RZSxNIEmjmPaiOxBPzvz4HNac-JII_4OVUetwHJSXvAHR90>
X-ME-Received: <xmr:yRa5aZxyG8oFK1E_pBNpYksLIkTJOXXUsMBItO7FTUh9SusFM3Dv1CmrXcI5hnMC2VM7Ii9wOqe6JOazPZSD8oZEwxFDimcfEAK1whDlt-dY2gNcMXodnXu_cA8F3wSotEs_pp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefggefh
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpth
 htohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthho
 pehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotg
 hksehnohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhn
 ghdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:yRa5ab3UK9mUipV6qn_GPpDWgA-qh02z7yVM0tjr73j6eZGFBACjYg>
 <xmx:yRa5aW83JWSAIftejum3e1IKaXF1UD_LASm-oOj9wRTXtVIDQhx0uQ>
 <xmx:yRa5aboJh31l-_UxpFNC3JEjYpDn0DeNNK3tZK-KzQPQa0UsMI9-vQ>
 <xmx:yRa5aQRwNIpn8CkHxgBaOkGglVcfZKA6bL7w382Qfnf9RCtVfMX_Ow>
 <xmx:yRa5acbr4M9tznl-RSB1tPgreQ_Uz43l6cOxUPGoWR9TCr5KClKu8bUr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:54:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 17 Mar 2026 09:48:57 +0100
Subject: [PATCH RFC 1/2] dma-helpers: lift IOV_MAX limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-lift-iovmax-dma-limit-v1-1-38729170683f@samsung.com>
References: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
In-Reply-To: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=gtGT/UyTeu5CuZJ1b/uQ6PYgXUw1HvuQ+WDn5dM7M9I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR201RnNRZktaY2ZXMThKMXd5SlZ3VXpPVVMxClZIUHdBZVRSNWtwOXNIbUJi
 TDZkZzRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcHVSYkV
 BQW9KRUUzaHJ6RnRUdzNwb0ZnSC8xQ1lDOGw5YUsva2ZBYU91R1A1ZmF2bmh6ZTRCelNQc1ZSZw
 pneWxweWM3cksvOThyWEo5T2VYMzRabjRKVGdtU3ZTVkxPaFZ4a3YzaGlxQ3V6VzF2WFlod1pPQ
 2VFZ29SVnR5CnI0bU9YcHJCREhueGhERkdVaWhlbTQ1dDdRSnhRUGZUZEtUa2ZpT1Q1bmtTMUdv
 eXI5SklXN3lXa29tMjJ0UzIKbEl2amQvWGhPcGRTSDRWNFhxM3d4T0t5ZVlYaXpXYyt3Wm5LOFZ
 oNGNsRUpFR3dsVC9sSFNMaTB6TkxOdFJWagphZkd5emUxQjdYU0x0QW05NU91MlVhbVN6Qk9SRk
 V1MU0ydy9iNXpkRjh0SmJxVEpZQTNQWEp1Nkk0WkU0MUdWCjh0UUUvYjhpeGpGZFBqbVhQNUMxQ
 y8vaUdWUmVvQmJzVEltTzBqRTE1Rk9jTFowN0huOUdwcTU1Cj1ZYmpBCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Split DMA if the number of vector segments hits IOV_MAX.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 system/dma-helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 0d592f646809..feaa50ff4e1e 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -156,8 +156,11 @@ static void dma_blk_cb(void *opaque, int ret)
                 }
             }
         }
-        if (!mem)
+
+        if (!mem || dbs->iov.niov == IOV_MAX) {
             break;
+        }
+
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte += cur_len;
         if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {

-- 
2.51.0


