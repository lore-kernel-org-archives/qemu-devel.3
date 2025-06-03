Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE560C5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRFd-0000YG-Uz; Tue, 03 Jun 2025 09:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREq-0008Fg-L6; Tue, 03 Jun 2025 08:59:32 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREg-0003TQ-B5; Tue, 03 Jun 2025 08:59:31 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BA8542540189;
 Tue,  3 Jun 2025 08:59:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 08:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1748955554; x=
 1749041954; bh=RSnqs8+Hy59VJK3U59KrNiPrQ/2DAGZFiJgNNJBvDM4=; b=N
 Dj82JZcUTr+/EyoopVzL0A4iXQhl0TvmjFMPRrxnbRbxXbfl8IYSiWfC1NkwJMee
 UXvLi9AUZ7/BJaj47Io6R9qo7klO77UAGtUkkkpsgukDf3WPh6MRNLQS5x5H0Mys
 Wm/OjZ/ZlOrFS0ZhvxAM9lueUWhbOMUpW/Shb5GYUMP5z1kOQU8I/Ubsd8bj/s8r
 ANvKKEpeyK37m6In05iNxYrlo7G7iw1Znvhddep4Pr5M2CogzdLjcgCTKlrYkX7p
 Timoq4k8rDRYHFeBz7hI2TAOmN6qfzc+83hUd95e/wiGt+cT+OngEhZNgiX4YxTm
 bGfzvK+dNrKVa04+YpI9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1748955554; x=1749041954; bh=RSnqs8+Hy59VJK3U59KrNiPrQ/2D
 AGZFiJgNNJBvDM4=; b=g+m+R36hmtkoQTEiEwNX9SPF7gZhekouJ9lo9lV4w3hs
 mowNZUtk9HTwCJwMsmbEy25NeGLqgda+spY5VygS6LChLKWYbq7dqixQLX0VSfdO
 0aSR1KQw1l1OMDBU1XV4vSKGgbBpfuXDW5qftrZiVtty1O19yjkv+CPHcDgND3zJ
 CmJSZTJYaIsswYgFN5fRst77MEYpAOxUxDOxF1LKnLpR3trC0fpBO8JzOFjJ+YpJ
 b4ZtTeSwvfprhh3oMsi94C34pUvBjwmPIvVbgTp+QoeJkbR2cxJd1zz8azULTWp2
 8PMQ+RWk2+vr9fK7DuLDw34jm4fPah2/0ULNGUl78w==
X-ME-Sender: <xms:ofE-aBFUuyjz1k6x5OknOeVP-I6A5E3ziFBcZglfgiv9NyriGlTfJg>
 <xme:ofE-aGUt7Cqxi4068zwMT5BlN72eHCCsP6SjRH3cGjbmKuejXGqNKx-6qnSBQWV7U
 5bOIQXqIqFYFgm7E-k>
X-ME-Received: <xmr:ofE-aDJq1N0WQUiClvnyoR7vUysdYFzYgbkOv2TUS09V7aJ1IyAZVzc23BR2ZneQu43cPNyB038nxr_zZqvyvQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeftdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfh
 rhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
 eqnecuggftrfgrthhtvghrnhepvdffhfehfeefuefgheehudelleeijeeuudfftdduvedt
 gfehhfdtfffgveekueefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohep
 jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnoh
 hnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhope
 grlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepkhdrjhgv
 nhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ofE-aHGP1dHtHmpkb88V9B5U5EfgzDRZFtF-2Uq9G_J1wG4tuSrWAg>
 <xmx:ofE-aHVdPa2FMT7OCjSinCVOR1eWjmJiv5gfh93xdNqnmHbitH6YkQ>
 <xmx:ofE-aCOF2gPyUgTVg81kQbvCMYliaUAoFlFzESiWCDZTpMVBxfezjA>
 <xmx:ofE-aG2ziYAiJX2XTYEZZZwp25kBCzQDTRRklj4NUgO-bZr5AVlAfQ>
 <xmx:ovE-aPW0nnCs7IfRBFRzWPUtHbEkPFijAcSNrmKasc_SGDk7wWGu-Z-_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 08:59:12 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/2] hw/nvme: stable fixes
Date: Tue, 03 Jun 2025 14:59:04 +0200
Message-Id: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjxPmgC/x2LywqAIBAAf0X2nOADA/uV6CC51h6yUJBA/PeWj
 sPMdKhYCCssokPBRpXuzKAnAfsZ8oGSIjMYZZyalZW5XSgTvVhltMnb5ILX1gMPT8FfcL9uY3z
 R4fknXAAAAA==
X-Change-ID: 20250603-nvme-fixes-d3f93f5a9139
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, 
 Alan Adamson <alan.adamson@oracle.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=471; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=adMpWzrTatdKUSK3XipNCtS9G9X+tg8PHS0JvpdTdJ4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2crOFo5K2FDWEplM1B0akVLcVI0dzZ5aFg0CkVKcHkrWHZqeXpYUDRwM2xz
 VzlaRElrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKb1B2R2Z
 BQW9KRUUzaHJ6RnRUdzNwbkFvSUFMeTVGNTZ1bUIwNi9ITkowWTA3Y0VoUVM2a1g3K0E1UC9IYQ
 pRNldyK0Q3YURUWk1qaU9XY0dBdWR4d1JQalJLSlVzdFQvdGtqRHQrTjlCNERTeiswaSs2WW5ZV
 GNmMXMvLzJDCkg0VGtOektuTzlEd0UvWHFoZHhhaDJhcjRyWlA3R3RqVWJHWUw4KzdhSzRuQ01s
 OG04R2JqUXcvc2RBQXV2UUMKbW0vcGNaR3hmWWVtcGFYUGlrbjRZdnhmenk4dE15dk5hb2tRTHc
 vdjJOM0hwM01VcEdidmp6NUc4NldwcFI3Sgp5RklMNlVreXh4bE9ldS9rSU4yN0pZaGFrdXYrQ3
 NCRVlrMUx1dXlEalQ0Y0Z0bUpZcUFZZ08vQ1laTUthZ2dqClRycjFzWlRwdW15bW9EL3BsU1p3U
 WwzWVcvSmE3a0ZQc3NNbDdDcW5wZ3licUlOc1VLS2lRNnhpCj1NNW1hCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-b1-smtp.messagingengine.com
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

Two fixes for stable. See commits.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (2):
      hw/nvme: fix namespace attachment
      hw/nvme: revert CMIC behavior

 hw/nvme/ctrl.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)
---
base-commit: 6322b753f798337835e205b6d805356bea582c86
change-id: 20250603-nvme-fixes-d3f93f5a9139

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


