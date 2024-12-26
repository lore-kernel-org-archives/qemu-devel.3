Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED909E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHW-0003wo-Rk; Thu, 26 Dec 2024 16:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHR-0003vQ-Mj
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:30 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHQ-0003Ei-CP
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:29 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id E133513801F7;
 Thu, 26 Dec 2024 16:20:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248027;
 x=1735334427; bh=s3b9pBtSYtBY8Oe04lWhPftHKL0MaU+BrXXUcQGyXVI=; b=
 XXbXHMgGkZhAw/VcqmJKHwBVmXc6q3CY5KTuEp0ahlhyQpxrtc7UmR3pxhPCeCwX
 PwYA6afBQZKjAUQCPwHmaBN8M7iAxcNfTR2af78wZHWFnIYIZWjfEYc9/nIPLY7T
 s7SleKscYw7O3+yB6SIVqe5/y5CAsuumhlLZTK/EhJnLRoGrQGBh7GW/Hp+IGidC
 aXtxzMPh4O4fFS0PJCS8hZApfTOGckmdMr4L50SwXriq550hW6EzA8xuYTImOIlR
 aD7wzTbDL8akByq2K7Jfq+BjEN/LZJJ9k4+agJEYhDG5w89pg0kecCKyI53Fh3ow
 FU4SLF/gMNIdP/yL2GN5uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248027; x=
 1735334427; bh=s3b9pBtSYtBY8Oe04lWhPftHKL0MaU+BrXXUcQGyXVI=; b=U
 LOPwKNg/06b5eHLKLD0FWZXtlss2faCtZoAGtauHyEuX62YFrvr9r8UuC7tvO6No
 b7gx3FdlRgjAIK6DqPTIEMc13FuA5NCU+4aStzHQASOK8dShWMg1X9XdTousJah5
 +MTVTd3BNl17sRF95KKh6iGQUwJXrgWa7wXPVYtxheAunFMPDizEv6o0i1bH91O3
 ztDflo3a+00Zi2K6RTUSpxFIoyGhd4OxvOzBwv/sKfEEEpuCoGtp4oL1DXsgfWfc
 e73eo0g8aclOgwyEjXLwkLLxlYLR2faCkLB1FFG/+R5WRKjFwD2NgcXjVrVsVjKJ
 3mRh2G8Or2tjOyGi5E9nw==
X-ME-Sender: <xms:m8htZwHtwoeRGqMWaM-a54Q-q4muO6S09jIbAiGwrWpu5mvPNBM0_A>
 <xme:m8htZ5Xrz5GCT9-HAmQcN5REskwf94wsVr04lRjqEanwyPY1OdUuJSQQfifOJ7Hpl
 7A7MzZ2R1qgrTpmkdY>
X-ME-Received: <xmr:m8htZ6KE6z3I4OyL3FiksMoXje2wwtXGTI09DSWTomnXZ5hE4ETsR4fd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghrtggv
 lhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopegvsghlrghkvgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigrnhhghigrnh
 grnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:m8htZyFxrPyhReW5LxP8nK6HGaEn9RvTU2xPXusIgnR6smT8iWN4KQ>
 <xmx:m8htZ2WVv6dRyOcXmj7m746QFI8kQiZYLJWHuG6-4XvJOU65cifgsw>
 <xmx:m8htZ1P2zVwk-viEaIuN6UfPFd01A8NM7r2b-mXKSyxlCxEz_pPlpQ>
 <xmx:m8htZ90EIhAGi6TzznciHlJVwAPpNcZ5Ea8w1KhYDNsfnkzn4DOwvg>
 <xmx:m8htZ3v2fBc3WhXkOeXetcLtGJd8gwbWdXxNE_q52TjRbfKt_5LvWeW_>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:26 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:53 +0000
Subject: [PATCH v2 22/23] target/loongarch: Wire up LoongArch32 Kconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-22-0414594f8cb5@flygoat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
In-Reply-To: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7RmQ2Oh/9jjCmpkY2P4iyt9t8EL0uY8W03Wqd+oJIk4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9l3pG5z2N7v+clpauYd9f6DV2RsWf6C76oeN+7+q
 9B5Zbu3o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZSoc/IcPnxxMRzd7apnNC1
 fjHp1TI3vVMaq5xXmovUfDnncah0ESfDX4GLr8TfnuJ5x71O3OLX7ichl2VfMhr8fpz4PXabSgN
 TPTsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
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

Add LoongArch32 Kconfig entry and enable the virt machine for
LoongArch32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/Kconfig     | 2 +-
 target/loongarch/Kconfig | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index fe1c6feac13874424c110637067e5add26978833..fae467e3af1b7c7c6637f7ff04314bc09687c5dd 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -1,7 +1,7 @@
 config LOONGARCH_VIRT
     bool
     default y
-    depends on LOONGARCH64 && FDT
+    depends on (LOONGARCH32 || LOONGARCH64) && FDT
     select DEVICE_TREE
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
diff --git a/target/loongarch/Kconfig b/target/loongarch/Kconfig
index 46b26b1a85715e779672bea93152a3c62c170fe2..e428b066c6d09048d9a34803982e8f344237055d 100644
--- a/target/loongarch/Kconfig
+++ b/target/loongarch/Kconfig
@@ -1,2 +1,5 @@
+config LOONGARCH32
+    bool
+
 config LOONGARCH64
     bool

-- 
2.43.0


