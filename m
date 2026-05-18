Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D1CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwmq-0003sB-6R; Mon, 18 May 2026 08:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlo-0003I4-6g; Mon, 18 May 2026 08:08:30 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlm-0006xZ-NU; Mon, 18 May 2026 08:08:27 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F0DE97A00A4;
 Mon, 18 May 2026 08:08:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 08:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779106104; x=1779192504; bh=pqMNEYCNy79Tbh4L38XZx7k0q6H5dcq6
 P54JV6pMWIc=; b=hhFuTaySt/Hiv3eZt+hT0cWPJINOUfDLniXkOOLbXWZaQWRM
 FGEPRERHJcnAOp3ByWYfKefQYRcXeiW5w2x94d9wWXdXgz1K97+W4nefciLSOQO/
 m60+lmsKhfKp80UUYxhbuo9ArWnXhaaconJyJYoP0LtREFzJO1YufdeVvs+jbOwN
 8LpFLmc/z+wmTni9fUEX3dnqqBkxvgE4YbN2PcL6xDDS7BtBkiGp4ebWGPkTcQ+i
 jO6NAzBqj5pT04qfhm0hLpGcO2cqA6qPhxbmUMIYfzXknFRls+J67hW5GDJfuxa2
 xHj3CnAAwIp4AiWkJ2TdI/CdqMIHLrkZpT+Gag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779106104; x=
 1779192504; bh=pqMNEYCNy79Tbh4L38XZx7k0q6H5dcq6P54JV6pMWIc=; b=q
 Hk0Tx6z7JG1Wn+K9CpKou/+YGOA2U2JftytA2Oh6MfnZINx6f+tGBOMnlyW1cwPp
 S3AAWq6KCm440oN2gSbleEKfuVW7wuTCKNWyChlbW4Deu7nP8qSyx7FXZZDq7l6p
 zeb8ErUPR7KbK6QiyLWKtn3jnaviPJE0SMUgKaHBrX8rf90I8rxbpzOIxv1FTmjA
 KfM59/XQ0EenPptMiIhBSVolwedV96nQnkn4yMTUG3NZTYfsFhg60JnifXYuQIxF
 PR4dWb+h+ZZPYitwoinO6s849VlUHU039sich1qoQtB3Vbnf3213CHwrYtv1V/3S
 x+IRd5cQDJ7uGuobUOpIA==
X-ME-Sender: <xms:OAELar7G9dX7WmftlsqVEXw8cyXgcT4qNc5IspbQLgeOQb3k0nyW_A>
 <xme:OAELaq-yqTcefHQlDFG4ZFpEU3d28xMRLYBkpj35pSZge96SJhXl7aJ0cXMauQkYh
 Yq3n94l4fV_lo8MOQsErIYVarS4naJFql90YxRKHTd02HDvcFZcZPY>
X-ME-Received: <xmr:OAELaiWq-BjY0qK3d4cF0bU9BfQ1cEt7wCI9aEtkbb1iliFHy-zbhBZW6sR8m1Hldjz72bmifS2g-gmlVy2cvB7e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteejiefh
 vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtph
 htthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdqsghl
 ohgtkhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:OAELatqqQokPBr3yEosdDtOrkZYMUDNigNMRzuMsLy8cK-0Dl79uOw>
 <xmx:OAELaslYZ3e6x2uSo80z0J6AOAP210ZQf7QAbBk80MZbX56tWTEInA>
 <xmx:OAELal2B-kzvvJPDukSKWKxyjnOdEHDBhTsLBbj3-crfuoYE1Bv03g>
 <xmx:OAELahQx3eaVcfUcQp5f8UpZOxc9cw5UDeW80pGAekC6UL4ZwxmM1A>
 <xmx:OAELalGhbLzuAJXa4ltr9HIYNn_b_SsAsUG3XQwuMbZxAo4TRY6pQDIv>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:22 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 2/5] hw/nvme: report error for oversized 'serial' parameter
Date: Mon, 18 May 2026 14:07:45 +0200
Message-ID: <20260518120748.14831-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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

The 'serial' accepted by the NVME device is at most 20 characters
long. An over-sized user supplied value should be reported rather
than silently truncated.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index be6c7028cb58..2556aced2a47 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8602,6 +8602,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         error_setg(errp, "serial property not set");
         return false;
     }
+    if (strlen(params->serial) > NVME_ID_CTRL_SN_MAX_LEN) {
+        error_setg(errp, "'serial' parameter '%s' can be at most '%d' characters",
+                   params->serial, NVME_ID_CTRL_SN_MAX_LEN);
+        return false;
+    }
 
     if (params->mqes < 1) {
         error_setg(errp, "mqes property cannot be less than 1");
-- 
2.53.0


