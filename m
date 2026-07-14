Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB6EC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeUi-00049x-WE; Tue, 14 Jul 2026 10:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <puranjay@kernel.org>)
 id 1wjdHQ-0007Oc-4K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:34:36 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <puranjay@kernel.org>)
 id 1wjdHO-00032C-Kd
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:34:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCBBB4161B;
 Tue, 14 Jul 2026 13:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0431F000E9;
 Tue, 14 Jul 2026 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784036063;
 bh=MZrLCy5VEKYOsH3L6hXSndmuiucIESqBCwL/DeueimE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N+IUx+QkNNtPog7rOQc3ej14qaiwLB2Cp8uGbzm2tHsA9YxBlbLf/1CMw3KOpHTXD
 wDJ8s16Q4pG+sxLOw5v2zwjBAloVqnfduxweubETZgP9H+lt1KMN4yKfFXgdPscQKj
 JXxB0l0m8FnFyz3Ea6wp3+mGYNp+UP03oA+3Bag0mNS/YwvGlJLIwM9tNYIp08IR7/
 CDR5k3XZxRxSp5ssJIH8/j7O4xs+HXJFrpz/C+aY8P4L5PUcm7530fwdrqCd853yH4
 CdvlQGS0D4DfqYte4jx47npee/0z5mN+36ok1MYrIZD8RmFcWuMFOrTSY7AlacQYDt
 AXwmaoBCYdUKg==
From: Puranjay Mohan <puranjay@kernel.org>
To: rohit.kuma1313@gmail.com
Cc: jasowangio@gmail.com, qemu-devel@nongnu.org, roohiit@amazon.de,
 Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH] net: only advertise passt in netdev help when CONFIG_PASST
Date: Tue, 14 Jul 2026 06:34:03 -0700
Message-ID: <20260714133403.3038095-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
References: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=puranjay@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2026 10:52:20 -0400
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

On Mon, Jul 13, 2026 at 07:45:11PM +0000, Rohitashv Kumar wrote:
> From: Rohitashv Kumar <roohiit@amazon.de>
>
> show_netdevs() lists each conditionally-compiled netdev backend behind
> its CONFIG_* guard (CONFIG_SLIRP for "user", CONFIG_L2TPV3 for
> "l2tpv3", CONFIG_NET_BRIDGE for "bridge", ...). The "passt" entry was
> added unconditionally, so "-netdev help" advertises passt even in
> builds configured with --disable-passt. Trying to use it then fails
> with "Parameter 'type' does not accept value 'passt'", since the QAPI
> NetClientDriver enum member "passt" is gated by 'if': 'CONFIG_PASST'.
>
> Guard the help entry with CONFIG_PASST so the advertised backends match
> those actually compiled into the binary.
>
> Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

