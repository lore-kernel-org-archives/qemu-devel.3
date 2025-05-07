Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C15BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZFW-0002T5-OU; Wed, 07 May 2025 03:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uCZFO-0002ES-5z; Wed, 07 May 2025 03:31:18 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uCZFL-0007PG-Kf; Wed, 07 May 2025 03:31:17 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 2A42413800E9;
 Wed,  7 May 2025 03:31:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1746603071; x=
 1746689471; bh=pD8j52EvOhwtpXpiBU4PvI6djNSqJ08++4z0SAYwOL0=; b=B
 oRoFJXNiZPe+2VcEZaNSTx9FQxYxTkg/dK+unfl4Dw/SpwEAWdd8GGnGqZZM7ccR
 zihHZUGrZKuassJdg/Rq/UcyvAi9uI/B4MeyGDs2X0n3mAojNzp7CbnQYwbnG3kG
 mNquu2mMWuCJmyioBLWaF48Ai1lSN3Oa3Kbedc1tqQgzC5geeQyqlAcsZ/N+Zrk1
 e7UxFXmx9giIeCA5CCWqdzSmXkiY3XZsN79RlW1dKGWf1UoMB51Bun16uwhj82lU
 BRjnGxqzCL2T75UUC6jZ6NNtOZeL6KLmIyQbQKeNY7lqbZTByCgsgj5W0HNNU0cY
 9ul7NJkqXx2WBSbthPp2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1746603071; x=1746689471; bh=pD8j52EvOhwtpXpiBU4PvI6djNSq
 J08++4z0SAYwOL0=; b=Ip5Jj+Au8R4hwdet3RPtwz4zGXx0b0vPRcK46hUIiYvP
 xfpPrzcpgWO3rGu/pUbAQmNlcRnULHzEW63NkcX1zUraF4HIEQIECtLhDFzEi6t7
 xP4atoc24USQWzJbN7gjVmbjhTO+LkkaNLIyd1jNx2qb/RfN2+LpYoF1nae5BMSl
 JVmcSA+V+kxYnW9LtrNdXWG+CKj5xiOoLY9lROmod2bjegJfK4gyVvB50zwP6T8x
 /3KSn2LyKjiBGu5Gn9gQ7rwlzIkw02ZFoOL3eouvEu0v1opVxP6zObXYpFNr0uLj
 qwzpDNL3YuJMFGGgxUpbnggc1EEsngs5OJPzIR/jew==
X-ME-Sender: <xms:PQwbaGcv7uKXHcsQtomUh6Gz5m5Wm2iqylAShbu67JWuQRqGl54UoQ>
 <xme:PQwbaAPV6upbdmjThN0hj5-n88dOgm3ZRxpobbl8JZ0CYCBGf5hoS8kAzt2-Rbm0R
 MQvPkbbOusghHrenWs>
X-ME-Received: <xmr:PQwbaHi8gfGHzgkWlsdeehff1zrtvQ4N1BvEu515shUzc9s8ctymYBk4zKmtfF1PYbt8yac5STk58ggywMOv4RU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeevfeeltdekleevledugeejveehffejteeftdel
 keekiedtuedtudefhfffgeehhfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhr
 rhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
 htpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthht
 ohepshhtghhrrggsvghrsehsthhgrhgrsggvrhdrohhrghdprhgtphhtthhopehqvghmuh
 dquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghl
 vgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukhdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhse
 hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PQwbaD97FHcrS5_E68J-yzfE7GKQTuJbpSivwoJLxakq7UaHyhoZ2w>
 <xmx:PQwbaCvYypYhBeC4fiV8-ToPx7mjWP3KAw5K6tK3DJ3mmXxoxisiqg>
 <xmx:PQwbaKFIH4VceC5AStMeK3sKsa4Qno3rQuTBGrP1ww4o81QEHjJOCQ>
 <xmx:PQwbaBMknM6Ml42e_aVEixCE1PUE_7gVZkpUESKW2RzkyEoAT9ggzQ>
 <xmx:PwwbaONhZhYXZsWjUsN52473N-RTKHykqI8kpPJkLIj_429Fwdof2pq7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:31:08 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 07 May 2025 09:30:55 +0200
Subject: [PATCH] hw/nvme: fix nvme hotplugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-fix-non-hotpluggable-subsys-v1-1-667f224ebc0f@samsung.com>
X-B4-Tracking: v=1; b=H4sIAC4MG2gC/x3MSwqAMAwA0atI1gbaivi5irioGmtAWmlUFPHuF
 pcPhnlAKDIJtNkDkU4WDj5B5xmMi/WOkKdkMMqUqlQVznyhDx6XsG/r4ZwdVkI5BrkFlSlsMdW
 6GhsN6bBFSvl/7/r3/QABKWFibQAAAA==
X-Change-ID: 20250507-fix-non-hotpluggable-subsys-023a3d817c91
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=q5QHh4i9WZialT5kLw8YDaneF/BMYXKkocT82fG5r8E=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2diRER0ZCtWTGI3eVV2dTF0aUkzYzdLajR1CnUxMmRCQzVjOEZuSUN3UGNZ
 MWNReUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKb0d3dzd
 BQW9KRUUzaHJ6RnRUdzNweFZjSC8yYXUxRnMvQzhjVTFxNUtoWlEvRW1aclRBSytEQnhSYWxoSw
 pRUnNPZGtJTm1CcWJWMlczamdHUDdkVzQzc3o1RDd3TlVPL0xaYTVKY2hCY2xrNWxFSEgrRUdxR
 1R5UWtyandiCjBOc21saWphcTd5WXFwczBETzhXTnhzVWo1NXgxR3V5UHEzWG83aHZpNFcyanZ3
 dWQrYWFmZndreTNramdQYnoKZHVDaWkyL0FyWXBMZjhqdlZuMW1iNFNxRVV1VGFlcUFRbFVNYVY
 vUkFaWkMxTWJnZmkrZU93SDkzamdIOGNqZApZYzlyL2hWSnZBZlR0T1Bkb3B3VnR1UmdPSC8xQT
 NkWmZ6QlkyRXhtVTA1Z25jWCtQeFEzMVpZeENTOHQ4MmpFCklkUEpiOTVlTE9xNm5xS3hXcGZFd
 Go0S1hUdms4Vm8xREpFZDJoRWN4UzV1aFljcFdmZkpYYUh0Cj1pT0puCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit cd59f50ab017 caused a regression on nvme hotplugging for devices
with an implicit nvm subsystem.

The nvme-subsys device was incorrectly left with being marked as
non-hotpluggable. Fix this.

Cc: qemu-stable@nongnu.org
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2950
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/subsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 38271d78c8bdc6dfa07cbea6b41b6a6083d62203..777e1c620fd0372ea1d9e193a5cd0903b9ffb019 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -226,7 +226,6 @@ static void nvme_subsys_class_init(ObjectClass *oc, const void *data)
 
     dc->realize = nvme_subsys_realize;
     dc->desc = "Virtual NVMe subsystem";
-    dc->hotpluggable = false;
 
     device_class_set_props(dc, nvme_subsystem_props);
 }

---
base-commit: a9e0c9c0f14e19d23443ac24c8080b4708d2eab8
change-id: 20250507-fix-non-hotpluggable-subsys-023a3d817c91

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


