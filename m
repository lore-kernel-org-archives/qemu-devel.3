Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5BAC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 00:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mIy-0003sK-T0; Sun, 05 May 2024 20:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIx-0003s3-1e
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:07 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIo-0000Ps-Fq
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 79D151C0007D;
 Sun,  5 May 2024 20:33:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 05 May 2024 20:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1714955635; x=1715042035; bh=i03vkEx8AYFKeFdY3aCajZlHxdEjUWgd
 7pSbYvUhUMI=; b=m7OOj3qkJAcd8sWz/ciwSVM64jsddv4KOdvTa6/xvLwPhS1q
 DUQv4iViW050nJcbinQdFd/PAn6zM9d6TrilGWoWUQ1Vh9e68goT62g88iXhB7zF
 xmS6yV/K6GXXpcJuim5tnTvAuKfyW3k0d6ozWC3aenVrnkRBKVcWfCKsW9c/36XA
 XDQ4U1j3f7xdiEdh+bRpxToVlUT4rcSxHa4IZK597tzf/uVLF0xzRswmSz0+QFy+
 UM9etrk3MXRpGtf0emlfGwcw0bYJakRy+2LsmqbHfy+zWnL6Yi6KVcWkTHJl7idu
 13Mxbj5bo9PXsEHhbJ1Boh41u0VWfQ23D6/m9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1714955635; x=1715042035; bh=i03vkEx8AYFKe
 FdY3aCajZlHxdEjUWgd7pSbYvUhUMI=; b=KQgH+QqUBu+NwuwCDIi4+WJenHdYS
 TXc/jr8VnGQ12hFyTeOgeLnhAyVNmWKB/V7uvKt+oMCtDEiBQWe9DFm+WegIrufv
 rTOufbCMjvGA3EeRqBuuSZNUr0ImZ6yNlQrdFJ7TcACeX3GyJCqiqB5SEXOp7DPK
 aZBxhuszr2MutCliW2UqlNNjuQ8nAemxfpo5Y9uyPL+F9QCrf3vfFf+NnPcdTFdf
 wgbQF0t6u+nngOHUG7gPgOf/hxroUfqjyTSAi6GU1Yo36ehieIwa4N4HoqWkOTh0
 KQgZ8bQ6JbLjSRRbqsImESqWw4lcIP4M2llCjYmhmBHjH/7AKJ2zIdl/Q==
X-ME-Sender: <xms:ciU4Zh__Z05Jt1PwuKKcoxtD896AhgbX1S0wdj2o3idADuDqOKw9Zg>
 <xme:ciU4ZluWByxLp-C9UESZXVbiokNYh7A8PWhNSdcdSHVSFePIIdE8mUA5t9hkmak52
 Cuu0lKm0x4SlQ>
X-ME-Received: <xmr:ciU4ZvAelQ0FQiyH6eftil7QUdJMH3efvlaasb0eOWywvZIxrz5ZgwIWiVdO9VlnMTuj9_q2HcIvA3FCnf_aUHq_QB4683ZvCc0xRyOXZxhPpAGeVN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
 dtredtjeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggt
 khhiuceomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
 eqnecuggftrfgrthhtvghrnhepleekhfduleetleelleetteevfeefteffkeetteejheel
 gfegkeelgeehhfdthedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdr
 tghomh
X-ME-Proxy: <xmx:ciU4Zlc4bawoZgMPu8b_dZWAtRH86aUHsZ7-abH2pYPNwGH1gllpeQ>
 <xmx:ciU4ZmPrlildqysrsb4nPmMRcSGTzZFmoFG3WDJwPSeJyd65OZAhXQ>
 <xmx:ciU4ZnnH56bCWE6wLi-xjPzH9SXo0FlqRMMqjWXWv-64tI2IrnngRQ>
 <xmx:ciU4Zgs2EJJ7gyCxP8mOZjdfHK29dJcx4fKYEaCF2gr9sP6_K1sKKA>
 <xmx:cyU4Zo1X_FhpJtv5ridJ7PYFZlmNQ7GDkDZH58rX6nx2Xlyav2rttHz->
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 20:33:54 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PATCH v3 0/3] Fix MSI-X handling for Xen HVM
Date: Mon,  6 May 2024 02:33:19 +0200
Message-ID: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.148;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series fixes handling MSI-X when device model is running in a stubdomain.
The main part is to avoid accessing /dev/mem, which also fixes running dom0
with lockdown enabled.

It depends on a behavior change of Xen that was just comitted, and signaled
with a feature flag. If Xen is too old (and XENFEAT_dm_msix_all_writes flag is
not set), fallback to the old behavior.

The other part is a fix to enforce read-only registers in the config space.
This fixes MSI-X setup for iwlwifi Linux driver, as it happen to write to MSI-X
capability id reg (as a workaround for some older device which has another
register there). It should be no-op, but due to a bug in xen_pt code,
it broke MSI-X detection.

All those patches have been shipped in Qubes OS 4.2 already, and prove to fix
the issue.

See individual commit messages for details.

Marek Marczykowski-Górecki (3):
  hw/xen/xen_pt: Save back data only for declared registers
  Update Xen's features.h header
  Do not access /dev/mem in MSI-X PCI passthrough on Xen

 hw/xen/xen_pt.c                     |  7 +-
 hw/xen/xen_pt_msi.c                 | 94 ++++++++++++++++++------------
 include/hw/xen/interface/features.h | 17 +++++-
 3 files changed, 82 insertions(+), 36 deletions(-)

base-commit: 2358f1b60f73287fe606c7ff48043b4f9e1c2d0f
-- 
git-series 0.9.1

