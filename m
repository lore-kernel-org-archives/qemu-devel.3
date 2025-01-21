Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89062C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taD3H-0000qF-Q4; Tue, 21 Jan 2025 07:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1taD3B-0000p7-5N
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:08:10 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1taD34-00072K-Pa
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:08:08 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 31C752540172;
 Tue, 21 Jan 2025 07:07:57 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 21 Jan 2025 07:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1737461277;
 x=1737547677; bh=VTiYjjfTVoj97+tjEK0XcIKNU8vMMUKnOvYacGdzV/U=; b=
 n+rZJ3Teez8I7LQXBAYAznmnRRb6xdKfVcGBlq2e8bGAH0NYqkCMjAHX4s0EELlf
 jLgh9KR/7oFvzQ2Mf5fSVisxylZFfMBSGNuP/grrTanEEOPb+2BQ8xFn7iGyMf/t
 rq2MgdJ8OMkdrOsRDeJ4U9TLwp+gmsngkfsGbQko49G/bpVcefrubxHglRGZ+LTd
 KfuOGwSHJQeV/zn+OwGWQQlCrirol/7L5i7TbbL3ZCr7/pyui2V1++VXP7ni/WuW
 7CJtaqpfRgCszlvmmFeB+ecORCrCA21mKs1ZX6L0Ye5kKGeeZPfqLk+qEvNzv064
 zSKvNDU2Yxm6x2yOSYGTdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1737461277; x=1737547677; bh=V
 TiYjjfTVoj97+tjEK0XcIKNU8vMMUKnOvYacGdzV/U=; b=CEzpsqDItADdQv2oK
 G5QB4UOXdwRXW93qhRGPYBgcdHaf71yaXuU8CkKnJmKfP3NUgPGVPgj1zDcGPPcW
 zQAp7AnHVirEgJBPaojclu+jb420CNrqLky7tlMpB4rgJ0OeI8CNgsEsnmR6QeIN
 werKG33X3hARzGnFFeXOnCsHwURkect83niv1e3mjj8IA6RSn289Sm7Rf3cVL8Ho
 EnrSC+WHRPTexPwD9Ilp27ngtYd33cHQj41w994RsJljg7p3DB0DNGt04kdW1OhD
 1GU6wob4oBOVxB1L8X+Sos5yIuLkKp4tm/IPe9YeEef46zQnDdTvr/cPZ5iZFKsG
 vgQcw==
X-ME-Sender: <xms:HI6PZxBzWr0Ljn5aRC_xJRWDPDgNXQS4Ih5HPkT-lxWF5kNM05IoLA>
 <xme:HI6PZ_h5mR3ksAPex0yZICjW-QFP7jAgYUFXv8VuFcGgqEKDTkYKA8TxMvrmJh9_o
 _IqxQa2tAMDyAzjwC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
 ucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfgteevhfffhfduffehleei
 ieevledvieelfffggefhfeekuefhudegfeelffenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopegrrhhikhgrlhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhlmhgusehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:HI6PZ8kW7vXUyDDXJQLyWuUBRqmOeXJdUtQckxR4cJRUjObJH3Svjg>
 <xmx:HI6PZ7y1BzOmQQoaF-bGtfWxuMoNKEBAe7cc2PXELDZaobAGUuiX5A>
 <xmx:HI6PZ2QNI3XwWkojclXsFzUuOwkAFIOEkG4HO2vlkM-h392aJj3UWw>
 <xmx:HI6PZ-YnC-8VHf2TzTXb_8n68rOVCpNtQUlyQ7HaBrKg4WnvfXSzqg>
 <xmx:HY6PZ0dkHkInxq1LQ4dxrzSAndXOzwr13rFTY54bPin52JsfcNlQ1iQp>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 82E6F1C20066; Tue, 21 Jan 2025 07:07:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 12:07:36 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Thomas Huth" <thuth@redhat.com>, "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Aleksandar Rikalo" <arikalo@gmail.com>
Message-Id: <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
In-Reply-To: <20250121103655.1285596-1-thuth@redhat.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82025=E5=B9=B41=E6=9C=8821=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:36=EF=BC=8CThomas Huth=E5=86=99=E9=81=93=EF=BC=9A
> We are not aware of anybody still using this machine, support for it
> has been withdrawn from the Linux kernel (i.e. there also won't be
> any future development anymore), and we are not aware of any binaries
> online that could be used for regression testing to avoid that the
> machine bitrots ... thus let's mark it as deprecated now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  If anybody is still using this machine, please speak up now!


FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
time by time to check TCG's compliance.

It is a proprietary software so unfortunately no binary available
to public :-(

AVP has two supported platforms, the first is plain old MIPSSIM
here, the second is OVPSim MIPS, which is compatible with my previous
MIPS virt machine effort.

Maybe I should bring MIPSSIM work back?

Thanks
- Jiaxun

>
>  docs/about/deprecated.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962..133c8bab93 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze=20
> ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
>  Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for littl=
e=20
> endian
>  CPUs. Big endian support is not tested.
>=20
> +Mips ``mipssim`` machine (since 10.0)
> +'''''''''''''''''''''''''''''''''''''
> +
> +Linux dropped support for this virtual machine type in kernel v3.7, a=
nd
> +there does not seem to be anybody around who is still using this board
> +in QEMU: Most former MIPS-related people are working on other archite=
ctures
> +in their everyday job nowadays, and we are also not aware of anybody =
still
> +using old binaries with this board (i.e. there is also no binary avai=
lable
> +online to check that this board did not completely bitrot yet). It is
> +recommended to use another MIPS machine for future MIPS code developm=
ent
> +instead.
> +
> +
>  Backend options
>  ---------------
>=20
> --=20
> 2.48.1

--=20
- Jiaxun

