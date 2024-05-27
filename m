Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DDFC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdwO-0002yX-2b; Mon, 27 May 2024 13:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwI-0002x9-6u
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:16 -0400
Received: from wfout8-smtp.messagingengine.com ([64.147.123.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwE-0004Zm-Q4
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id D970E1C000FE;
 Mon, 27 May 2024 13:15:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 27 May 2024 13:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716830106; x=1716916506; bh=K1
 Ockac4cEdD9IESqhUKnFAX63FcNT7CBeiGq+n/22w=; b=oY8r7w6gIpt0u03PQ3
 nxrs2JZZo7+BSw9rsHx0wYYi4u+CUBs6Fmipwp9TRrv8xPo2XTj6iXr1+tFM6yLR
 H6PgXRX2eC/D8VDsDU5Zlp5drTK247MuG7HbV66b7OFPVeV557Q+XX47Anj8ZlQb
 FbquuHoXpNKhguFy1SyQBNbKUYNQucjdqUjvpvJAt7qN75XRMPG7avwS8CspAaKG
 lqlkDAhSAngXtz+/Y94QjzCLsZpJNg/dn9QVtYQZ7cTgQ74bbOffRrDgTU5aN38I
 Pr7HQp1/m4nXw3EvMjxoJcMLe/UU6hNsWEUJY/I9ZKr/4Zc5NNyotjbiHg7zoyBT
 eGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716830106; x=1716916506; bh=K1Ockac4cEdD9
 IESqhUKnFAX63FcNT7CBeiGq+n/22w=; b=MQNt0y1SCcm82hFv/kNkwZSoGAkBO
 sBWnmSkBlBbyoNiWF0QCtB8Pi2edsKOXTGEISKDmGaB5t02E0c/vNtKB7CrVf4qb
 K008Cr9OKoqzi5WV7BmrLeKa214tIJdNmnaINvm28RcbJ3QlbrPKCeVQP/c/eM9H
 rmXF6MgilyEuemh7C+gXdl4cOB06ks7RUvsVcBTDKD+zRz2Ywn0eQAlnrnI1Ichc
 dRIRcI2Bvwlsy8eR8O4Li+v/lCI8mI6RxFr7e7rlv0uI/lWpUoWYi64g0tu+Rkwo
 0bpnRjk7VzkODxMbJPautdrOVLPv6y8N56ghLcSa9+l9Ta1Bz6Q0va/gA==
X-ME-Sender: <xms:mb9UZpEADTLtMREGuF-j3kIPDddNdWG42AmsEBN76_6m-z-NQ0ZE9g>
 <xme:mb9UZuWfrYlyiZGIYTuId3BWWF_SB05Z-cmDYHy_M6Bm9tZd7jGuNCQyisiHtCDiK
 YXdWTipIuIF6k6g9gM>
X-ME-Received: <xmr:mb9UZrIqEZHw4gxFsrRqxV1MVfkWTExx1iVQSiNbJWseOl3LPGYxtBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
 keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mb9UZvGFpi2WIH_AOxls1oCPWQBfi4tIB5hH4A7zewX1qit8PdPzoQ>
 <xmx:mb9UZvVRrcAJnV_H6utdjJ_Ns7xe18Qasl-0kuibDWsh91W3PUu-xw>
 <xmx:mb9UZqOfMEbJMJVapWSr2Zh1Mc2U4mSDPJzyGXlcLla0UvjE5etXLw>
 <xmx:mb9UZu37AYlcnbwbwapt-2laT6kl2P4dM8ytlwJzbivSCpYBSEtE7A>
 <xmx:mr9UZhKsbxwhh-QE3iU_yKnaNfm_Dc-dbAZGy7aC2aNJDWv3kwDaOWGy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 13:15:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/4] hw/m68k/virt: Add some devices
Date: Mon, 27 May 2024 18:15:03 +0100
Message-Id: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJe/VGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3Vwzi2zdpMz8Yt1Eg0QjY3MDQwvDNFMloPqCotS0zAqwWdGxtbU
 ApFVwoFsAAAA=
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=4/BRFvKYfsG/Y7LlJQQcWYbEOhcoiFzMBMsTf6Mq7M8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSQ/TN116/vOph06Q1vUlaR6sFX9nN5Qv8VeBzgW388O
 meJbsjVjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIuwkjw1RVQ0W7Hh3fd+zb
 mSy2xjOwazKoR56wZfE4dH6h2MaNIQz/szdnOW6882Fu6UKnb6WKluaPMpgXPUz59vD/S+/Lhlf
 WcgMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi all,

This series added some devices that I found lacking when
I was trying to port U-Boot to m68k virt machine.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (4):
      hw/m68k/virt: Add a XHCI controller
      hw/m68k/virt: Add fw_cfg controller
      hw/m68k/virt: Add a pflash controller for BIOS firmware
      hw/m68k/virt: Supply bootinfo for BIOS

 hw/m68k/Kconfig                                   |   3 +
 hw/m68k/virt.c                                    | 231 ++++++++++++++++------
 include/standard-headers/asm-m68k/bootinfo-virt.h |   4 +
 3 files changed, 176 insertions(+), 62 deletions(-)
---
base-commit: 60b54b67c63d8f076152e0f7dccf39854dfc6a77
change-id: 20240527-m68k-bios-a0a2370181f5

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


