Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7556EE645A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dR-0000rK-IH; Wed, 31 Dec 2025 16:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dL-0000pc-6g
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:32 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dI-0003hh-18
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:30 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 41B78EC010E;
 Wed, 31 Dec 2025 16:21:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 31 Dec 2025 16:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1767216085; x=1767302485; bh=hmf0GIjV07
 vVEQuWaf63aEVRMxa7L2GGaBElg5r6J30=; b=ac/riQL6L/+7SrTU+ytXxQLswJ
 Z/g9dgAzprpwaoUhoVkO9nqksNzUx7Cjt0spKYVXyX1pe330BwlHX5vSPCjpprIZ
 1t/VAQ3mn1tsQVELtbl2OGPTusLi6YewbObB3H8mgUntkUr1urB2+flo7RPOJs7+
 CaVuRA/OLvqPJKOJkR2DK3mGevJywlLKppVhE4gR1DQdiTiL6KUMuD5JLJdekxvR
 8AcSe2J+AwvFbXh7yrpRa7sETKnr73cIKFmXJ8CfAIulypKiE2WvgGLmlIYYvJ+g
 o4ad1Ig5fDRByNv8n3EftFDvJp04woELonWW9OyMJobOgT2GNJybGfnUOlZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1767216085; x=1767302485; bh=hmf0GIjV07vVEQuWaf63aEVRMxa7L2GGaBE
 lg5r6J30=; b=rJe1nHAT5wSbcahJFvRxmtb2MMwHxx7K5sI3sWrBr74AEETMdLr
 XgNAWkwQbO23A+RA6kFKpm5imkVoc+5YmyLvcTt8wzz8l20Fe+hZYB72doQMa4J1
 T1FVAjqd32m9XvgDRvcMZs5nA31U4rpVUXFwvyOsrAZGIcRs7vxAiWQSP0cUvXR0
 r0cLwxMGlREp7d3+ik2SkbUBIzQFVeiU6NDniOv8RBHD1YYMSxQhL4j5Qcc0cNob
 h1431syJduIhIay/ASVPGkgLuGiJAixRSjyUsNZ+61a2kVniBG/WMyR4biR9LeCW
 WJck75YUJSrYrNQW/0Xm1ZejJMa2o5msdFQ==
X-ME-Sender: <xms:1JNVaZ2miYqu7SNx1QF3RkG4TnjMw-S4hVMiE466cQn_jJkzLMRdgA>
 <xme:1JNVaXj22hjgrdDqphE0o-6t-f-AdwgegRVLbCJik2IJYLreILayF6vgzESTgiOXK
 6mLjCBcSNCTiQ8C8qjtjcQisyYC8bpIVOVqL7ICZV3faz_e_OQp6A>
X-ME-Received: <xmr:1JNVaXTJyMloRzvs3h_6FuNvf4lNGh-ilCN-SZQ19DXp8vFrudD-Hlgu4NKD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeliecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
 fkofgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhiuceo
 tghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhtddvhe
 eiveeggfetffehieeghedtledvvdeuieejjedvleeiffetvdffjedtueenucffohhmrghi
 nheptghouggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggprhgt
 phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtohhnse
 gvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:1JNVaQiCNocPBPFG2rxR1fvO0ZrDQrj8ThPK3vy6kvEjtT_lnb0svA>
 <xmx:1JNVaf4IysTdhtyGVrTXlnIudSshJ6lJFN2VgCoGlW383HLZjuk6kQ>
 <xmx:1JNVaVCJ0-bVHcD-mEzQDSbc2ncwBDqmrr2qfCkf7iU8pExd-Eqy6g>
 <xmx:1JNVaeZgArncA8VeKqbGXMVnlAeBXX6_ZOea1VOgvcKoxUJde-hBzQ>
 <xmx:1ZNVaXMOPs30738Lr64McUn0SQNWOXuMzqXNqIf1I1cVobsY_BCOLdqS>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c24d4e81;
 Wed, 31 Dec 2025 21:21:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 0/7] ati-vga: CCE engine setup and PIO packet processing
Date: Wed, 31 Dec 2025 16:21:00 -0500
Message-ID: <20251231212107.1020964-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, FROM_SUSPICIOUS_NTLD_FP=0.058,
 PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
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

This series implements CCE engine setup and PIO packet submission/processing.
This forms the foundation for full CCE support in the future.

CCE engine microcode is stored but not executed in this series. Reverse
engineering doesn't look impossible but it will definitely be a journey
and I think an initial implementation of at least some of the CCE
packets in C will make it much easier.

Ring buffer (BM modes) and Type-3 packet processing will follow in
future series.

Hardware tests available at:
https://codeberg.org/cjab/ati-tests/src/branch/main/tests/cce.c

Tested on real hardware (Rage 128 Pro Ultra, PCI 1002:5446) and QEMU.

Chad Jablonski (7):
  ati-vga: Extract ati_reg_write() from ati_mm_write()
  ati-vga: Implement CCE/PM4 microcode register handling
  ati-vga: Implement PM4_BUFFER_CNTL register
  ati-vga: Implement PM4_MICRO_CNTL register
  ati-vga: Disable GUI engine MMIO writes when CCE enabled
  ati-vga: Process Type-0/1/2 CCE packets via PIO
  ati-vga: Implement PM4_STAT register and common flags

 hw/display/ati.c        | 123 ++++++++++++++++++++++---
 hw/display/ati_cce.c    | 194 ++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_cce.h    |  91 +++++++++++++++++++
 hw/display/ati_int.h    |   4 +
 hw/display/ati_regs.h   |  16 ++++
 hw/display/meson.build  |   2 +-
 hw/display/trace-events |   9 ++
 7 files changed, 428 insertions(+), 11 deletions(-)
 create mode 100644 hw/display/ati_cce.c
 create mode 100644 hw/display/ati_cce.h

-- 
2.51.2


