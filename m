Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35433E9410C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9oc-0002HD-6Q; Wed, 31 Dec 2025 22:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0002Ek-38
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:31 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oX-0003hx-0I
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:30 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 8198E1D00058;
 Wed, 31 Dec 2025 22:57:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 22:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1767239847; x=1767326247; bh=iZsO2ANcj7
 57/EhFpo0VoAnVh3P9dsWdpvnxBoY+X/M=; b=OzKGk8ijCF7eZCT8vy22+qGuIY
 w4Y/F3hMzjYmwRqnp20vY6reGjpZGZtXkrSTpKoNez/YLma1uQeQCdsbiocqq7DK
 YTFuH4qPJlhmKieXRWmBYrI0nwU0GlFj+k8LnkUKm5/HlY+EN4BCpOd2LWatBhcF
 uprHSVL8OvlQPobSNRjuIZXpts3/yt2indonguqmc0SR1i7OzSTftlh6k0mb3UOI
 SaV49aqc/gvuTAEunZewo8RH6l4eMBDFs/mpDwFRf+gXzuBQDt7z2Mk+ZSM7xvsY
 WJHkeBLmCq8QyEbdafWCk/NhQd6mKW8Z6fGqeXCIb//8BdK4T99TvHmm2uUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1767239847; x=1767326247; bh=iZsO2ANcj757/EhFpo0VoAnVh3P9dsWdpvn
 xBoY+X/M=; b=Kv52ujGuwfkmqrbJol6J92xAA0/vASz3axWzMXTc+k6+GO8OhBZ
 H6QwSL56QUoLSkLv8uNpMzLpQPkh1IthgfFlwlC83GRCcblFLxLkHXI3vcQA5wru
 E1V6538t6ePlbtiRq8cy63SD7VWOokcH5D4lE44FUCj1+A+tSx5FmUcPOxjyoj/H
 Q+m9aQyPuVl3PYQfJWaBquBXKwDoKTvkmfaH1opwq64VHJ6W4GZhvB6TDeETSl3z
 m2iFnomKwgOc+VWg62WTe8TlPKkfqfOUGD4bH2H/O3eCypb6gZwe2vsN1Ax7aj5P
 gE3YCTQwkAfG+3oOpDm0zl6JQW6peB/zIyw==
X-ME-Sender: <xms:p_BVaXY-tlEZsl4ntm4CpqZ__YbuB94BtjuZwj2_TDNjndKAiwcRYA>
 <xme:p_BVad2TUCG-vnu3_OiBuop738Z4nicXGgH4vjwMF4qijt3O5iFSr5p95phIp90_G
 FvXIU6yB-VF7FN9niRTdoEBa-pJere_DB89luiZhKU-RPfmT282nRc>
X-ME-Received: <xmr:p_BVaXWLYb7k7LIw5gn8U6ThPNb8-AE0oPD0QbCrEjFZR_sxQjPH9uLHI6FS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:p_BVaXUCeqEQSEl2lnJc3iTck1jyEA3Ft3cKPaTQvMBmHVbZTsYxcA>
 <xmx:p_BVaWelZYOR0aoHvhV28pkjqDVRSAMx_1XiS2mC0Xx9Kin3L9yuDg>
 <xmx:p_BVaQV4Zxwm76QycnmpRWta4iK41SNCxed-Cmzx7zunbhGeLAJeOg>
 <xmx:p_BVafehUXa2LCXDnlDhuSnIx4lLhGy9xlDsTL8evBSRyVrY8mP90A>
 <xmx:p_BVaTDrIBLtCbcPEadGKgCtnwJGkYyjToCGCFgTEdfGCMRFaBYuhztn>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3cff8a48;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 0/7] ati-vga: CCE engine setup and PIO packet processing
Date: Wed, 31 Dec 2025 22:55:48 -0500
Message-ID: <20260101035555.1300511-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
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

Changes from v1:

- Rebased onto master (no longer depends on HOST_DATA series)

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


