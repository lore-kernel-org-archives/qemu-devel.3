Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254CBC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWTb-0000Jz-OE; Wed, 22 Jul 2026 08:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRu-0003VV-TK; Wed, 22 Jul 2026 08:53:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRt-0002dl-4n; Wed, 22 Jul 2026 08:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=MgM47pT4tVSiS5jidfjSc8kwj5mUmkV3qUXI8y8mt5E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qqMhcpKRF9a2rPS/tUjZhRSw5cPSahbQgr87hVMM93gwODG6fwqR5BnFvTUV1mz5V
 PZm2KiQy7GDGyQNiMJ5cNzzF9itxAjRvcpsv3zqgdRbnfenUEgD+xmZSXjvhEE1GoE
 oLu3Ojlf2BzmnFgPxFntzWbFonb5SxxtVp5OLz20pVZyOFDWqbfcOKz1qjJ8oVWls0
 TLiRDl8so87y+7ODA/OTwjWYJLX9ri31laquA/oe7wKyb8enWRK+XRpaZPJskK4ta5
 3//G+mKymtLoBZeigdVsJmX2aW1v/U96L0Q0gFQx6FfK3VqmQteryXa8ob+l5gLCYU
 5oacZhWjJe5gA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EEA811C3B44;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 43BDD3F3794;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C617A17F5D; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Rohitashv Kumar <roohiit@amazon.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Puranjay Mohan <puranjay@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 103/127] net: only advertise passt in netdev help
 when CONFIG_PASST
Date: Wed, 22 Jul 2026 15:48:28 +0300
Message-ID: <20260722124859.32371-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

show_netdevs() lists each conditionally-compiled netdev backend behind
its CONFIG_* guard (CONFIG_SLIRP for "user", CONFIG_L2TPV3 for
"l2tpv3", CONFIG_NET_BRIDGE for "bridge", ...). The "passt" entry was
added unconditionally, so "-netdev help" advertises passt even in
builds configured with --disable-passt. Trying to use it then fails
with "Parameter 'type' does not accept value 'passt'", since the QAPI
NetClientDriver enum member "passt" is gated by 'if': 'CONFIG_PASST'.

Guard the help entry with CONFIG_PASST so the advertised backends match
those actually compiled into the binary.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Message-ID: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 504f2bad932c4f1b067d3b759597ed38e57576a1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index a176936f9bc..4ccc8763465 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1385,7 +1385,9 @@ void show_netdevs(void)
         "dgram",
         "hubport",
         "tap",
+#ifdef CONFIG_PASST
         "passt",
+#endif
 #ifdef CONFIG_SLIRP
         "user",
 #endif
-- 
2.47.3


