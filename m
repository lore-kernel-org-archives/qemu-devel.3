Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F92DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5OL-0000R0-Hn; Thu, 22 Feb 2024 04:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd5OI-0000Ls-WD; Thu, 22 Feb 2024 04:29:19 -0500
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rd5OG-0002vN-Lm; Thu, 22 Feb 2024 04:29:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 4C28511400D3;
 Thu, 22 Feb 2024 04:29:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 22 Feb 2024 04:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1708594154; x=
 1708680554; bh=unEqUS2ah1tg5MfeHlyQZzvJDUO9xa3f3mPjgTDV990=; b=d
 N0MqbHzXjwwcWazHUtlDNDcCgOw3Vv6k4lQVKO2uw3xR2xYLuh3MipMFV4gtW+d2
 1MqWO4NNOtlCC9fVLz/CF5dYu6woqeYXU1GKgljIou/QEuEK3WXbvpzKqVaKlDXw
 GIkD1czSR7StKCd/lJBrtP0t0R5aQras5ciyK1RYv2hjVzzYgOM/B93qUlfpLQJC
 idi71uGtTfY6P4fFkjULj01DgLC24ctiLwEsqh+msVbTRhwjdWdEVV8UbOXhKwdy
 yJAfCf0Fp5UAhcYPonwPrlvv/UiXRxLFBJBabYAR8GRLHCS7c0C2TJrFrEmqQWqC
 2s/0Dl26AtxH9q/WAqKoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1708594154; x=1708680554; bh=unEqUS2ah1tg5
 MfeHlyQZzvJDUO9xa3f3mPjgTDV990=; b=XyG9AKCbWJqh38ynmFCZKGc8AWfUQ
 BkeSg/Ijm9ZrmIMzm2/ZduYpR+zvGvTLBwAthqkL1MlLz9R7U9f5JHWrKYJ/IlPH
 OgdcEfrBDrIveT971Z73qVnqcimMYHffZhrPj2OqQRqrtOOPSg39IqwvTlePs1r4
 pdRSHsJxuHabDSJNU9BOw8ko6+dQZx3wczNPWFLssaT0Bw70/GcBUp+o8O3sq+Cv
 MAEfo1x9pQgZviqYZqDPXChRkFWvlxvkuTUqeIg9SFbOCw7LEi7RpH93+FYXZMol
 jgDRyJ2gOp88kGJ+u13Q3AYTEOC3mJyaEZjzC0Cmg78F9j7zeCYvLorqg==
X-ME-Sender: <xms:6hPXZUeDrgT36q4Td0at_8vTjoExPjFhKHH2PhN7eHKiXup1GqZy5Q>
 <xme:6hPXZWPLqadM8QHuMj6uyMhJ8ESYN9R19DhrRiQ6d5Pq9q35PTPryKkd8YbkHMHKK
 OBws5xk5M7h5GRoreA>
X-ME-Received: <xmr:6hPXZVjjqkDFnDcZD9-HfOxAhpYdPizxAzsDOc-5FpkmcgG-0gv9p0fbghHMepuz8mmK1qFhvnd3wBSP0Ag7rll0q5UAQ8hRcVGKLz0YtoRknoknjCh4z2q6NqVRedf6b8p1FCQJSI_-V5u4bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdehveejiefhgfegiefhfeehueeigfeugfelhfdtffevheffkefhkeegteetffet
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:6hPXZZ9IBzuekc7EhxkYGaVbOJdUPQz3ppasq5xmYvOLUO5hmsxX9A>
 <xmx:6hPXZQuKML6cMfYxUAkRJT2xHYmDQaqeEbRN5W0f9OJv5pE3TdqloA>
 <xmx:6hPXZQFFu-N5tHjdDHHTqufBCumgZUOUN_gM4JUMk7dPV3uagrNJNg>
 <xmx:6hPXZUhI71Tl-N1ciaO3P-sR4Im6njVhJG_uJbZBnGfvlpl369q22w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 04:29:13 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 22 Feb 2024 10:29:06 +0100
Subject: [PATCH] hw/nvme: fix invalid endian conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
X-B4-Tracking: v=1; b=H4sIAOET12UC/x2MWwqAIBAAryL73UIuVtBVoo8eWy2UhlYE4t2TP
 gdmJkJgLxygVRE8PxLE2Qy6UDBtg10ZZc4MVJIpiQgXeTF4cQ/a+5jstWPFI5t6MKSbGnJ3es7
 S/+z6lD5IOIi7YwAAAA==
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>, Kevin Wolf <kwolf@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=PKexRZKVAtWrh0NHmG0QcIlyS8OHM26yr8H24FSQGLs=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXXE+j+gubLVuf1ZigEypdh7Huj+/bNpFwPK
 Qlt34E/7RnIcokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl1xPoAAoJEE3hrzFt
 Tw3pywIH/RsdlecmYxovU3zNM5/VTmMQ//Ijlu8Wgkk6X+MKEGRJi0RxhGSGkZSZW3I2CRRXibS
 QaGjKsLkGAW2D/uFB4lSEgYDr8U87MZChf8t5g6UzOkuhBu68XAk4gD97EiRjkt2tzxiir663ye
 0l7YOrAwKz2NY1zPfKdZZkXAHWt9ymK6ACEI60wTlKm20azVouZ1TaDDV6Bpcm0nzfCzlZDuadD
 4kPrilZc18FlvnnPTgkUwbXDEGi0DVIp+l5WSJsQ8adt1vXYRohQx7k+939FJWcsnwCjPRjstXA
 3tbsxcrXX83OBLYiqmLBEzZH8naTpcl5K9VfQn6D4IlLiZTnlljkhqiq
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
hosts results in numcntl being set to 0.

Fix by dropping the endian conversion.

Fixes: 746d42b13368 ("hw/nvme: Initialize capability structures for primary/secondary controllers")
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..76fe0397045b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7924,7 +7924,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
     QTAILQ_INIT(&n->aer_queue);
 
-    list->numcntl = cpu_to_le16(max_vfs);
+    list->numcntl = max_vfs;
     for (i = 0; i < max_vfs; i++) {
         sctrl = &list->sec[i];
         sctrl->pcid = cpu_to_le16(n->cntlid);

---
base-commit: 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
change-id: 20240222-fix-sriov-numcntl-5ebe46a42176

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


