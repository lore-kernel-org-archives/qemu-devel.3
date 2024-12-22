Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDD8E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPP3p-0000IJ-0p; Sun, 22 Dec 2024 11:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPP3n-0000Hs-HR
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:44:07 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPP3l-0005Ak-L9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:44:07 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A440625400C4;
 Sun, 22 Dec 2024 11:44:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1734885842; x=1734972242; bh=EY
 v3NM6J9V+TRoNHxO+wmEqvvVzFfR/+nzW4zgPsRic=; b=hLUU8It9E2TVrf0waF
 DqqsntvoVW2EN3YA8v7PbS3Y0gfEjd9EXrEd9yjFUO1J/o6X0CUbA25YWQj6Oruv
 JdKCDyXhjeG0WxPs+88lrD7bYQ5wg9l5pg9KGsvazU2zoDnXmH9YLxWzdcbCFMra
 UOGjir/Vn/3vuP/NqqZn9w4SfbaK3DKEmzr/8koMBkM2c1F+T1Sy7hLVglTH8Etq
 nvucWyaX/Bn2nmBAq6B5+tvXYxrbgS3EC2DP9ie53gXnFJNhZR4XPtmTjKpc7Drb
 fNLz9CLzxAXfdK8gRkYNkh77pr2ivVp6IJ8iqfGmP9zZl+IdYijjzj99ixE8Dmb6
 euHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1734885842; x=1734972242; bh=EYv3NM6J9V+TRoNHxO+wmEqvvVzF
 fR/+nzW4zgPsRic=; b=pZYTxdM2rKtWPrH+G80OPxZUxsbOfqViz5jhVu0KKT3D
 cyyCrFDPlzJxbc5tAMDVpvrVieX3QC3os9pbkcDBCH9fG/2Mc9sTJQlItPffQYKE
 e6PqbmvVEYghIgmzjUwkW034MzVKwtQ7YuJwWBpBHLwtVy4Jg74ZACenK5JSmvxv
 6eRJSQ6bVRIOUCmBx+V9K5kZjV8huS5D39ca21tAy/Scqcx9aS1+6SbHmYQga6X+
 YqX56gako9+fdm7erIbGHp0rraIwjSJxL+qUPsCiKUDgIANPo4bJ+56FfggUUoYV
 v6/4XywuZcvLwVmqEu+pfSlV7nHOup+Q+DqUmaa1TA==
X-ME-Sender: <xms:0UFoZxdEJXivqvLp2qxOAAmCrDF3tv9ZPPIEEElyacSYxGXTsRQmiw>
 <xme:0UFoZ_PDNKJTHtqm-N1hNEapYxPHXt-Bp2A0zMvNjm3rkX7PqPaKIa_3jLddvengd
 gQ42dvcBcZ0E4xrumc>
X-ME-Received: <xmr:0UFoZ6gY6M1zV4JZGrLRumXIBY9gi-piIxqmRh5FYJ86zKj9g-Co_Kc7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeet
 feegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
 mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
 grohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomhdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdrtghn
X-ME-Proxy: <xmx:0UFoZ6_bvOHkuHsWY5lyiEASXv8nqz60FJyy8xwHcFeNBhJmw3Q-BQ>
 <xmx:0UFoZ9uHYE7Ko9xNRWbOnefD_hTFzcVkbwVBen-lrQOExcVNRGHZRQ>
 <xmx:0UFoZ5E288G9dWCStRkBJOYc6UVK2epsOsQ2aQXJI72Tk_VyjmNKIQ>
 <xmx:0UFoZ0MT3pWviW1VxO4QeYM6-N5YNnxZvw8M2hmILGBTjkh5yHeXuw>
 <xmx:0kFoZ3KnN_rzcHTtoN-G51ZrrazgTi1faEozzl5okVSey4MJ0cGGPYMt>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 11:44:00 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/2] hw/loongarch/booting: Booting protocol refactoring
Date: Sun, 22 Dec 2024 16:43:58 +0000
Message-Id: <20241222-la-booting-v2-0-bef2ea7d3b32@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5BaGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NL3ZxE3aT8/JLMvHTdFLMUCxMj80Rzc0sDJaCGgqLUtMwKsGHRsbW
 1ACp2sUVcAAAA
X-Change-ID: 20241219-la-booting-d6d8427a7790
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uRmR2uGTHaChwBhju7xxKfpl1OFHUbqS9HyNA7mFYcQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvQMx4vpX9wfC3joPNnac+X7BQOJKy8lW3tFp5QdCE8/z
 7kznfN4RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExENZ/hn8JS991sNaYT7to4
 /ntZePRzDddJAc+Me2vk6k01yidu82X4XyO5P+ubr3ZdpkddmPryylsNWx4ZsojNy10nXqn61ew
 LGwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.158;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b7-smtp.messagingengine.com
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

This series refactored booting protocol generation code
to better accommodate different host ABI / Alignment and
endianess.

It also enhanced LoongArch32 support.

Thanks

---
v2: Fix building on 32 bit host

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

---
Jiaxun Yang (2):
      hw/loongarch/boot: Refactor EFI booting protocol generation
      hw/loongarch/boot: Rework boot code generation

 hw/loongarch/boot.c         | 323 ++++++++++++++++++++++++++++----------------
 include/hw/loongarch/boot.h | 106 ++++++++++++---
 2 files changed, 295 insertions(+), 134 deletions(-)
---
base-commit: 3e9793ab01904144c204589811e0e879109a9713
change-id: 20241219-la-booting-d6d8427a7790

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


