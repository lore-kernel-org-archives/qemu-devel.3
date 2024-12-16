Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AE9E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAbt-0006Zt-Ov; Mon, 16 Dec 2024 07:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbl-0006SJ-6T; Mon, 16 Dec 2024 07:53:58 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbi-0004pK-Tw; Mon, 16 Dec 2024 07:53:56 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4AECE2540168;
 Mon, 16 Dec 2024 07:53:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 16 Dec 2024 07:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1734353630; x=
 1734440030; bh=XCbI3Q02UV1EDEMW4Vhhd5lKrqBh4/q9LBSnw1+nCJA=; b=m
 q5BxHrRasrW8FjZl8ENHHui+26g6hn71YdGsiFEuRJqvxK2a9wL0kAkhoJmRxICn
 HLSgUOw2a32PFXXikTzO9KLxvHUXBO2H9WkmsAj4I1dbg/FcEJIjZK9NijBn61xu
 /xuhJUl8X8CydmZs8GuXJqRvwIEgia5pnxrHBxTgmgFvsACR1OFrtN6ZUV9mjMwt
 V74OW57lvogeWodC2uIAEQxwxY6xK9ZQNv1KmaddaUBExw0fCyVlPWK8cXGuY0q8
 iGXjlnd4Vq1kLcj68I2uEXnmvSXv1WRw2YdJ7BrG4BzVC1+rHW6WiXip6Z2zM/++
 g7xRzjjeXJnsFPkqOVfJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1734353630; x=1734440030; bh=XCbI3Q02UV1EDEMW4Vhhd5lKrqBh
 4/q9LBSnw1+nCJA=; b=TJFc6CUE8qhZdTnhmmlgqKDWjkYiIFTfrYclaVn2lWH0
 f75U/zshSsnsdSBH9T92ZRaTmaZWOwMpAjKjN7GM+O0OeaFgmfDVUxrXVSXOpOnO
 o8onEYX8XnR86Ti7bLlt41D4MTNQmOYDvzjU0dAIdnM9UeOWhtn4Wt7m+4QZv/1w
 t5iZFAuO3GTlroAMhd9TtcLYvs+1aRhGhK+t9qHZ6DPckDxHaZgBR76Zo0MsoT+B
 /risagRulBx7SNGnFMlgXKIyNDW3Rq2+5JT3qqIJMvQ9HVkU4RDv+wwzikKThprs
 O1o2oDoBNLgwCjJS9sXMR8sTaPOVEuwseNU9QGfNCA==
X-ME-Sender: <xms:3CJgZ4s12ebz6GS0DHBy-q6Ji-ZTf7bPm_rkBhvwY87Png1ZopM9GA>
 <xme:3CJgZ1fKsJ4PWvsjEw4NcIiFsp0NJiGJXJRqE_CCjrPIecMRZyCCH8ur-R9X-2mIV
 VJpFy0MBqxqbjrN3Gw>
X-ME-Received: <xmr:3CJgZzyppFjTKhoFwWPWEp6LBdJsG14BrbVAjyQNAWkrhCCx5SlwxGKR3EKV6rDRUUEES1cTDxANm7sl9FAM4vs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdegiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfh
 rhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
 eqnecuggftrfgrthhtvghrnhepvdffhfehfeefuefgheehudelleeijeeuudfftdduvedt
 gfehhfdtfffgveekueefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohep
 iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqd
 guvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:3CJgZ7NiW_4LSP-q5Xj9Z82-49vMxyZwAhAiX2j9chVAsjuCvsoRhw>
 <xmx:3SJgZ4-c3do6MZfcOv93FzFTXSqj3UqPYr6bN8WNic7AzdzYtxyDYg>
 <xmx:3SJgZzW_viHV167mqhjGbxLgAVX72RsBaXSxIY-WCPRuwDRIiCwPcw>
 <xmx:3SJgZxeZemunGXrrOZ6q0oXg8CEUQ1I3l8uQ2TVHexP8uXetxJbAXg>
 <xmx:3iJgZ4wT-10e3BgEod6kfVrBV_qr7n91ULRNGreJYmprUTTbTJ_T_351>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:47 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/9] hw/nvme: refactor/cleanup
Date: Mon, 16 Dec 2024 13:53:01 +0100
Message-Id: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0iYGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mz3byy3FTdwtLU0lTdNBNDU8Nk0xRzUwNzJaCGgqLUtMwKsGHRsbW
 1AFmwIotcAAAA
X-Change-ID: 20241216-nvme-queue-f4151c5d7507
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=OkhZPsr4fnb0nzaLem/nwKOpSgfQRngHMAgYNtS5KeE=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRjajU1dDlHNmYxSXZOZTBJSlRNZndKCnVRVTRWc3NwSXAxa2ZkSWdk
 MXo4UG9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFh
 BQW9KRUUzaHJ6RnRUdzNwekUwSC8xMmJtNy8yZDhaMEptMmtHWTBxQnRMSmZTSWYyalNKcWtFeA
 owTHJqRHJGZFNucXVySXV3ZzhvTVR3Q1h4OWJCN2I5OE5Eczk5TzJiTEZKQTZyaWhDdmV2T3RwZ
 nFZdVNGb25xCnNxNUtycEhPcHJ0UWlROVFDT1dVNWduclRLSHM3TUZOUm1KRy9aTzRxaTdneVRO
 cVNpeXBtQUhqOUJSc0I1N2QKTEJrMHROY3ZQSytpaEQwdHM4T1pod1ZPNTNEcEhDRHU3bE5lNzN
 aZFN3Z0xla3dSZ2hwcFAvTGJ6T2x3TGkwUApKeWNoWDdKb1lhNk0vdVgxb29OZmU1YnF1S2d0cm
 RyS1RrOFBwL3QyR3crNW1TT2VsaTNCcDhIVkFXQlZoa29qCkRhV2NJb3ZYZXJSQ0tJRDk0cWZNS
 HplTUpVK2tYWVdibTFVSy8zZG1qTXdGNFZuQjJYS1lvNm52Cj1oT3F3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

Apart from some random small fixes here and there, the major thing here
is cleaning up how we handle command sets. Prior to this series, the
controller would not correctly validate namespace command sets against
CC.CSS. This is fixed here.

The most clean way of doing this (as far as I could tell) was to make
sure an nvme-subsys device exists (creating it if necessary). This
allows us to "store" the namespaces in the subsystem, using existing
functionality, and attach supported namespaces when the device is
started (instead of when the device is created/realized).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (9):
      hw/nvme: always initialize a subsystem
      hw/nvme: make oacs dynamic
      hw/nvme: add knob for doorbell buffer config support
      nvme: fix iocs status code values
      hw/nvme: be compliant wrt. dsm processing limits
      hw/nvme: rework csi handling
      hw/nvme: only set command abort requested when cancelled due to Abort
      hw/nvme: set error status code explicitly for misc commands
      hw/nvme: remove nvme_aio_err()

 hw/nvme/ctrl.c       | 430 ++++++++++++++++++++++++++++-----------------------
 hw/nvme/ns.c         |  62 ++------
 hw/nvme/nvme.h       |  10 +-
 include/block/nvme.h |  22 ++-
 4 files changed, 276 insertions(+), 248 deletions(-)
---
base-commit: ca80a5d026a280762e0772615f1988db542b3ade
change-id: 20241216-nvme-queue-f4151c5d7507

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


