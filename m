Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37830C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 23:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPVYs-0000K9-RY; Sun, 22 Dec 2024 18:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYo-0000Ji-Ef
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:34 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYl-0006BC-83
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:34 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 359B31140173;
 Sun, 22 Dec 2024 18:40:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 22 Dec 2024 18:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1734910828; x=1734997228; bh=+n
 XAambZ6G4b+cJSsflmB6/KA6vrreVRf6yzSNaRtaE=; b=ekBbmMr0X+bOeKrP8p
 7HF5iHNahG4Aq6gTfUOKrMBQOQwmi1wP9KHtZVEv8Z2bADL9+/ldHOjzgCMCUNDb
 VRWcYM7ynahgDlyQuaDBIc6WlBBgCk+hDS+we3Y0GXwU0rM86eeSu392EKpCrOGv
 Lkum6yOhHDm3nu+o4dLQreBd9GGp0nloDs7X0ja6hH5+FXMbQhioVjT/zKxcLwo1
 94TtGApfwCTNNCFArRV3I+c3YQC0nwk8UNa8hSCDexrA6tQfcoLbbk31+aSWHQ6Z
 6uU/yeftOey+jvzXKolnaZBorCro8h4DosjydEOk4Fxoob9RjUpGqc1TgMPE0IYn
 8kyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1734910828; x=1734997228; bh=+nXAambZ6G4b+cJSsflmB6/KA6vr
 reVRf6yzSNaRtaE=; b=lzL8Rob3rak4D1NrFMWUE4VKZ/b4Ff66mBhAuw5/9VAT
 vWn6PNVHeD8xNLmfxIXXogtyg3jy1ub/QPHR2+HXlNOgFRTd942Gulm9EpRdwXB/
 mUtJsv6Nfn+xLgcl5ToOHvCUcx5eg9h4JKeDvdOCReg0JTRos8FBAkSCeSYgVQUf
 Hoc0CLFKbvyANK1a/eEznAxD8oyVXKecinJeaU+/23897sSTQXSpflwdw7M3Y/KG
 5K01nrNEGUA2Gro+bvxoQHqdSA/rCNIBkkMXNCvH7AxVDW9QSoavK/yJuu2A7i51
 5o1boKuehxcJxoHgAYEWXWTycv/3gBMo/ZZdHVCGmQ==
X-ME-Sender: <xms:a6NoZ8kjF17RaIMTQKy0Zv8C362_GPNhoJWrIsr3HkpsUYcqvIs0zQ>
 <xme:a6NoZ73uQm2icZwa5pEK3jAuvJc0bZzIpZmVKKaVeJSYPoDc_YEZCPp8uv64UScHk
 Jzk9EwnvqF27VtlFzk>
X-ME-Received: <xmr:a6NoZ6rMmZvumIjHtkE5gT4VbyvzeDyUY0vwIw_-gnesu-GAw20YeMfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledguddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeet
 feegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
 mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihunhdr
 higrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhooh
 hnghhsohhnrdgtnh
X-ME-Proxy: <xmx:a6NoZ4lM-Ms5lnxEWqIL_JGKtRY7w8ry169vZTTnFBeGEU9Oi-_iSQ>
 <xmx:a6NoZ61wC4Z1cwt9I7ZMJiUqU0KkApyLVVQKmiYoCVz8h6jodBC0uA>
 <xmx:a6NoZ_sDfcBvpswuSjoYFWpqTM7xVhihmp9zgufcMsadY4vGmNF6cw>
 <xmx:a6NoZ2XFzw7sDAk6IFQLx3vwt5CLd7JWMjqixWtiRUQ1Fpr-qnKkVA>
 <xmx:bKNoZ_zNhdMwzTDrWVvhd_g9pKRAuQMyrKvBBEog_6hsce0hlEa60YeU>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 18:40:26 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] target/loongarch: LoongArch32 fixes 1
Date: Sun, 22 Dec 2024 23:40:24 +0000
Message-Id: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGijaGcC/x3LQQqAIBBA0avIrBN0FLGuEi1EpxoIC4UIwrsnL
 R+f/0KlwlRhEi8UurnymTv0ICDuIW8kOXUDKrQaEeURDMqVH6paGudj1Dap0Tvox1XoL32Yl9Y
 +di7BO10AAAA=
X-Change-ID: 20241222-la32-fixes1-368cc14d0986
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=rr1hfoP6T1ZoSmz/CxpVZ9awOs0XjW99FAlT8YsehU0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSMxVmukx83Om/nOiEUyuClppe08NWC7QuU3jNEfuLMW
 l93u7O5o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACaSG8rwv4LvcEjWhI/7ty+Q
 WOBh9faC0tZKjgmHFj+3DhbwE9eSr2FkaMhkYYxTefJfKEiRscEipStigs3Jp31F+3ZdXGh/a/V
 +XgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi all,

This series is a collection of small fixes I made to TCG for
LoongArch32.

There are still many thing broken, especially on CSRs. More
series following.

Thanks for revivewing, merry christmas!

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      target/loongarch: Enable rotr.w/rotri.w for LoongArch32
      target/loongarch: Fix LLSC for LoongArch32
      target/loongarch: Fix PGD CSR for LoongArch32

 target/loongarch/tcg/csr_helper.c                  | 2 +-
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 5 +++--
 target/loongarch/tcg/insn_trans/trans_shift.c.inc  | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
change-id: 20241222-la32-fixes1-368cc14d0986

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


