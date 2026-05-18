Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E659DCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwmh-0003bX-8M; Mon, 18 May 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwll-0003Hs-KP; Mon, 18 May 2026 08:08:30 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlj-0006wV-T5; Mon, 18 May 2026 08:08:25 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 2060A1D00139;
 Mon, 18 May 2026 08:08:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 08:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779106101; x=1779192501; bh=XUOS6O5xtnbkldc7d05Clng93PdHkPfB
 5ConI4/RV5I=; b=1vRX/ANn9IctbyKE4Vociatl1bzOAxNuHVfJvHV2lp4hsoP7
 FjTPpAjJ8EE1boYdfl0vZtQLHtjks/5R/syiurPG93DOj/Qi0cOC3n9aagE9Wfm1
 92RnenPnJSf/YebytwW1aVK8kd8U4c3KtTonzfpYipA09spSnGG7tjS0ohKyKzQQ
 ZCps0VB+PopfSOg6R6Ir1fbRzKSNZ+hdPK5a8nNfEuMNFLazdOvUPsKQuWIZBEjC
 K0NNzPV+964S7rZJ/p53cotx7kbAkiCfnb9xLbJK3G41iMCmDZT0jJqkPf/O56f0
 xd30da2qq4fJUEgAAjRh1N61NEjYOjuLANrGpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779106101; x=
 1779192501; bh=XUOS6O5xtnbkldc7d05Clng93PdHkPfB5ConI4/RV5I=; b=m
 Vm1BPoDywxskT2eZOglCcimOYl2raNSVSJTfHeDIbRKY6cVHYBo+W6ey7J3AUKvu
 ALmUQf4b2Wg46quMRJoIF3zEDF1hTLVfdbiR0oFpcSVNZSZzyU4pMqhZzV4pqS3i
 qVORg/1VSeTIJi/INGVtAk77L09cwNU1VeuF1ZM1EGkDbRa6kEDguNfZAsWGAvGm
 Yo3x4m6ntSkM17BXs0nFtWts6T95qWLrodhCU26gc4zv4qSEXT2wM4VQ9X73ZOCV
 qzAzfXvn1c42ZAjsw8hudTBPQpx3XYKpO6Pk8Mo0ermGTLvrKzVscjM83Zkh8h8S
 C/YD6/n1QaYV4xaIHPWbw==
X-ME-Sender: <xms:NAELatHxfd_yZJgqfSZZbwOhUySBsA8sttjy4febqJRoxqhcI8lFyA>
 <xme:NAELauOOcnG3cKRj2hXPdOqExZUo1FxnwLQLkraUxTSrKWUOjOQUw1XlOzIfYHAzD
 1UpbJQbbES1HX4ZoW0GOnnLMkmUlWr4NU9OACeG2qhIZRWLCAWmbf8>
X-ME-Received: <xmr:NAELasLjNZ1PtDVvYqNeyBCwrIpawLSn1AYe4a1-L_itlGnBBEu1dDjQtX72BSjKdkgvMgLDXrdDeWCvbE5QPBAG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteejiefh
 vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgt
 phhtthhopegsvghrrhgrnhhgvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhdrjh
 gvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghr
 nhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtg
 hpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepshhtvghfrghn
 hhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvth
X-ME-Proxy: <xmx:NAELan-wm0rmfCrLuMHTJfyihfe6QXy_utQjnV-WNcZLO36RxHywgg>
 <xmx:NAELaoF5QUTlSbn3jkSSMLBQ4OwHzSsmL55c2o-0mX7tc51hVsIrfw>
 <xmx:NAELai7fpPYErpoO3ER9Tc_XFm6730CXfKmCBfLKeHIH397n2ryMfg>
 <xmx:NAELahbxqA0amhqZGZ0SXfig4fvbqIIVSB0SC3OOVSkDi8HPCVmFXQ>
 <xmx:NQELahP7VjayXm3H69bxZwku5ryFmd3MFVZhYiAXEdnG_pNYR_4x0G0v>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:18 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 1/5] include/block: define constants for NVME string fields
Date: Mon, 18 May 2026 14:07:44 +0200
Message-ID: <20260518120748.14831-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The version, model and serial fields accept fixed length strings.
Add constants to enable user supplied strings to be validated.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9d7159ed7a7a..e4e7be51205e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1134,12 +1134,16 @@ enum NvmeIdCns {
     NVME_ID_CNS_CS_IND_NS_ALLOCATED   = 0x1f,
 };
 
+#define NVME_ID_CTRL_SN_MAX_LEN 20
+#define NVME_ID_CTRL_MN_MAX_LEN 40
+#define NVME_ID_CTRL_FR_MAX_LEN 8
+
 typedef struct QEMU_PACKED NvmeIdCtrl {
     uint16_t    vid;
     uint16_t    ssvid;
-    uint8_t     sn[20];
-    uint8_t     mn[40];
-    uint8_t     fr[8];
+    uint8_t     sn[NVME_ID_CTRL_SN_MAX_LEN];
+    uint8_t     mn[NVME_ID_CTRL_MN_MAX_LEN];
+    uint8_t     fr[NVME_ID_CTRL_FR_MAX_LEN];
     uint8_t     rab;
     uint8_t     ieee[3];
     uint8_t     cmic;
-- 
2.53.0


