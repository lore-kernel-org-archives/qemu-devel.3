Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EBCC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2Vz-0005la-3Z; Thu, 08 May 2025 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vv-0005hx-VH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:20 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vr-0005Q8-Dn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:19 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E205725401E2;
 Thu,  8 May 2025 10:46:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 08 May 2025 10:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1746715569; x=1746801969; bh=0b
 3lK/0Fpj2azO7tV8t+D2bik5lireq1rygEf2Ugdfw=; b=X3gQxMobwDiZf+dODL
 67wjirB+Eyjdxb2r7gMxCXc1ipf3PolUFXMRvcGFWmnKzI6M3vuNrMwHx7riQgRu
 3otC4v5++bFJlpp8EfvpKh8YLl8Kn27Af64W7jPRR5aNZ9Bdqi0JchcEoMjjWZRl
 pe6073pdGvYgblplfKRwEP1qt61XoDLaJqtJZ0+Gawdd//mR7dJFHWxDOBvSXJYl
 FwH/Qq3n0lhkfXrsPKOM86RFmOKmSrTZd6U9SzP8yXWuXro/JfMKqraMB9SdxvxF
 35RhkMhr+b19RGG1YNlCgsF8x0G6HD9BYSU2Jz/VdeKsCAbYFaybgnj8h8aTqLy0
 r6GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1746715569; x=1746801969; bh=0b3lK/0Fpj2azO7tV8t+D2bik5li
 req1rygEf2Ugdfw=; b=vfGaQfTqWQpWH7rhnnCDgyNgP6Uz6pizidFbtZ78UAYO
 0o6zTICLp8Jm4R8ULQyWY04DZPpIrobbp3c36ibrwZz4AKPEmZNbMgGAtOxhAeWM
 lqgbJZPaOiId28ulNuEhE4SALgsAx3XBqaRPfGEbflxfGAv+Di+qWimNWE75nn8J
 0fv0N+cWeQx6e+xd6rOB5JzutW5zGw4KW4fP+/OlPJHHLptOi2lqgTuQ+XMqTyBY
 dcdSsW6/PMnq70D7ZETnofQBESqZoJErjCHdIhheQ2Omxnq9Kq3QGNbNcL0n15yX
 +piZyyHLyRiPPCcP7bs5LHA3Ta/8GGf/KLzksC9dWg==
X-ME-Sender: <xms:scMcaLHVGm3sG1v2EnMBQLoliJiU-tgIkpxZcwxKsmn0uD8CMNyucg>
 <xme:scMcaIUejFV6tvw7jAaqrZLNzDp1Whj9tJB__oAQL5v52bLoyCEWKjvAFHO1PvQPX
 ov0s1MFb2JsVxzw9S8>
X-ME-Received: <xmr:scMcaNLUEMCtAOo6YdjKkZf0dsDfC_XvptjmnSE9NP47p3E_f9_PTrFk5ebgqXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeu
 geetfeegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopegthhgvnhhhuhgrtggr
 iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdho
 rhhg
X-ME-Proxy: <xmx:scMcaJG12niLKQQ5xiOfGIVIJNfBoW8x3gdihTc9xGwoNePeiyV4mg>
 <xmx:scMcaBVZL1CxkZOPsuuXz3Y4csLOtg8ILxgmRlOyFoFMfmJ6Q4vGSg>
 <xmx:scMcaENodIRC7jVBPLbkSZLpe6Ba4M1R0cs2s9waoacnTRU8aLcGNw>
 <xmx:scMcaA0onqVXrF7nXnkuujiKFNbS_VuFZoTpRO2bZewUtpvsOfQ2RA>
 <xmx:scMcaArrTzNX-Dsse6MNKd8brncTWkCs0SOGUkQxaW54itRe1WcHalOe>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:08 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] hw/pci-host/bonito: Improve various emulation
 functions
Date: Thu, 08 May 2025 15:46:05 +0100
Message-Id: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3DHGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwNz3aT8vMySfF0TCyNzU8skoyRTozQloOKCotS0zAqwQdGxtbUAjRW
 uKFgAAAA=
X-Change-ID: 20250507-bonito-482759b2b52f
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Z4jSD3Hn1W1y+kyu9le5QRQKK7Xt9VdntPDvHNKY6+8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxsO/OI2yYwJ8jsU9FVTNcDo4ndPcfZbXpc2P7Lcr
 SEWuV+lo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbygoGR4fvxzyJX74eu3tOW
 fs+9+tqWw+vDtsXprKg8xTt/0evi6XYM/z3LRC3X7DY9vs1nwyJXPZG/2a+O10Tmz430FnustMR
 BjRUA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
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

Hi all,

This series addressed a couple of missing Bonito functionalities
I found when I was trying to test NetBSD against QEMU.

Please review.

Thanks
Jiaxun

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (5):
      hw/pci-host/bonito: Implement ICU
      hw/pci-host/bonito: Implement PCIMAP register
      hw/pci-host/bonito: Implement DMA address translation
      hw/pci-host/bonito: Rework PCI config space accessor
      hw/pci-host/bonito: Add comments about documentation

 hw/pci-host/bonito.c     | 453 +++++++++++++++++++++++++++++------------------
 hw/pci-host/trace-events |   3 -
 2 files changed, 284 insertions(+), 172 deletions(-)
---
base-commit: c5e2c4042e3c50b96cc5eaa9683325c5a96913b0
change-id: 20250507-bonito-482759b2b52f

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


