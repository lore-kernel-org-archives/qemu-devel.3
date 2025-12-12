Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65265D4415B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 10:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTzxj-00077o-I2; Fri, 12 Dec 2025 05:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vTzxX-00074O-Kx; Fri, 12 Dec 2025 05:01:11 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vTzxT-0006DG-Qt; Fri, 12 Dec 2025 05:01:11 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 9E8461D00172;
 Fri, 12 Dec 2025 05:01:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 12 Dec 2025 05:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1765533663;
 x=1765620063; bh=RXMmxixVyhe9Cev6yBZjdPNU8Dgyw9KiIPIl6L93egk=; b=
 gA+/1tEbsek9SKHNVETGeccgTP7iTeChopaO7MNtfwpAqbV9bgU1r72N3Xjd+Wdo
 HFuxT6xSirbNs9GeM4duchUMPfLea888CO6CFIC+A6/7YqcNdrfrZM22lHYf6V8d
 hvNauuLcOUhfaVmrOUhp9oQDRBY0a2cctcFtLUOOrfOaqFnu0x0NnNto07xDoC/o
 xkhj+IFpVLR3sF/SRmM69rQW080xMjWgpiu6K+jcYv4iE9jC1Gw/NSHPi5u/Hf1W
 zup4TN6VTjTkWPKckmMqaI7OMhoxITLRInFR2N6ISI9mdF6uVDsReGXhYjv4p8N0
 fHVS5NZLoqtMpaIdwIt2ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765533663; x=
 1765620063; bh=RXMmxixVyhe9Cev6yBZjdPNU8Dgyw9KiIPIl6L93egk=; b=d
 i5PCRPELcpxPq+TJGw04G9EYCiKIvtVoJcBio351qTx0pLeZV7R8GleIkIYjfjDs
 Dgon3RENugkrRLJoC2QvuUXbG1i8GeC0ld791lctvp0h4jwWd6Ckue3P//1fqkPI
 wucIekVXKQZu2aIJwDxmYUYwD99a1r3fhT/mxjGB9rliKFMjTxXqZJOaGxx/6Pzy
 3CnexRwhI8n0wG65Jj9ByDF17Dx1jw0rujt1GNt8/VAlmwH/1+Bgn3lGnTacVKII
 eXGElHavq1OYPg+s7HW5G7OpVnJaUDp9mrO2cgYhSBVDaDLBXwxaKPaN4ZOYhrPa
 B63WVxc41WgYt9m10iw9A==
X-ME-Sender: <xms:3uc7aX5a223sZDf1zJj-1buv8888u9pR3IYuQ5KhLVy6kdzjUTQpfQ>
 <xme:3uc7aYyOv4Ch8m1KGouuokDEYIgxqVPYn6rzSwuEWqpBNytM0rarfgs4tO_rrED9N
 _RNEvD-PzpWg_tPeedN1z-sQNJM6UvoA5T8IovGGW8liCh1gn4fdFO3>
X-ME-Received: <xmr:3uc7abeUfIy2EC_CajSGzLWAGd1AmshKTp7pYpAITEwbMSVg3OGsAb4GzX46jsV2-2OAifGjFMGytnaW44NEGDjylA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpegggfgtfffkvefuhffvfhgjsehtqhertddttdejnecuhfhrohhmpedflfgvshhpvghr
 ucffvghvrghnthhivghrfdcuoehfohhsshesuggvfhhmrggtrhhordhitheqnecuggftrf
 grthhtvghrnhepveeitdfhgfdtteektdfgueeuheffveegieekfefgudfgueeiffdvkeei
 gfeiueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epfhhoshhsseguvghfmhgrtghrohdrihhtpdhnsggprhgtphhtthhopeduuddpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepshgrihhfrdgrsghrrghrsehlihhnuhigrdhvnh
 gvthdrihgsmhdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhg
 pdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehqvg
 hmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghv
 vghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrd
 gtohhmpdhrtghpthhtohepnhhikhhhihhlkhhssehlihhnuhigrdhisghmrdgtohhmpdhr
 tghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrg
 hmsegvuhhphhhonhdrnhgvth
X-ME-Proxy: <xmx:3uc7adAmjUaYzhxknKXyzUkaw9WtpoN4Js_TIXzAgoUMe42qa00-hw>
 <xmx:3uc7af6fCcvTGXb9uaEMGeEFqDQ4TqMbQZb0-tnznD9N5a32Yg3ksw>
 <xmx:3uc7aWeQrQ3ukEJ-TuuwEcXkMl5I8SCo22VtkuK8Woa-IKSNPLo2Rg>
 <xmx:3uc7aVucIXokzIwiP26y-maTCmXmenvOtHxbNj8ApyWvVdB49ZBJbA>
 <xmx:3-c7aYF6izpE2a9Q9MtsvNdpfTkSam3trdSEPl7sBzaPtMHGL9I60V3a>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 05:01:00 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 11:00:58 +0100
Message-Id: <DEW5G5O4E3RG.1PVHB79KYDWO4@defmacro.it>
Cc: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <npiggin@gmail.com>,
 <nikhilks@linux.ibm.com>, <stefanha@redhat.com>, <fam@euphon.net>,
 <philmd@linaro.org>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v4 0/2] hw/nvme: Properties for PCI vendor/dev IDs and
 IEEE-OUI
From: "Jesper Devantier" <foss@defmacro.it>
To: "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>, <kbusch@kernel.org>,
 <its@irrelevant.dk>
References: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=202.12.124.151; envelope-from=foss@defmacro.it;
 helo=fout-b8-smtp.messagingengine.com
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

On 2025-11-27 06:02:49 -0600 -0600, Saif Abrar wrote:
> Add properties for user-specified PCI vendor/device IDs and IEEE-OUI.
> PCI properties are now set independently of each other and
> used only when use_intel_id is not set.
>
> Saif Abrar (2):
> hw/nvme: Add properties for PCI vendor/device IDs
> hw/nvme: Add property for user-specified IEEE-OUI ID
>
> hw/nvme/ctrl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
> hw/nvme/nvme.h | 7 +++++++
> 2 files changed, 56 insertions(+), 3 deletions(-)
>
> --
> v3 -> v4: Resolve merge commits when moving to the latest repo.
>
> 2.47.3


Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>

