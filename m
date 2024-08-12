Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A670DC531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRXX-000459-VQ; Mon, 12 Aug 2024 05:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sdRXU-0003sn-LZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:40:32 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sdRXS-0004xk-Jf
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:40:32 -0400
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal
 [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id E2A0C138FDD4;
 Mon, 12 Aug 2024 05:40:26 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
 by phl-compute-04.internal (MEProxy); Mon, 12 Aug 2024 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1723455626;
 x=1723542026; bh=sJeydjNcU8vl+opa87K9WeMbOK+ymacO6tLDmScqFHc=; b=
 PsRya9tL8/3913RKPH1LN6jGNMTxqornSR/Td851VdTy23tAbt9pfTantI2PIpgh
 4Rv3OnG+kuP3NuJwjsCROWkQfsEau8BT6jqYSBO/O9TQVNKjuKY8Hoj2hxLX4DYx
 KWjnyMeBzRYTbfskLtfHkXqiT6xo7c0T1rQTUT7z9KayJV98QOdQLTDtH61X0VdF
 F5VwuH5Egu4WYTSlcu6/fFZmW4m1dEGyjnev9mteQsgKU7QDZb5cDiTsCQfDbEdY
 p4oJmkQcvJlJheTXrT4mZZs+ox2wOgYfbc5Iqaw2BpYqr4mALIFrcSFshXc98esN
 yu90RA1z7qkk88TYPRsYXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723455626; x=
 1723542026; bh=sJeydjNcU8vl+opa87K9WeMbOK+ymacO6tLDmScqFHc=; b=U
 y/YuNYmK61xd/rShYnBYOmVvOAIBpQi1FHNBSxdFOwN1uJ06EkS3vYmXVQ0gvnRh
 dEUO3rN+T+BQShm5JpbaRQeOyrxDHn+NhENHN4ay3ORAHw+bpWUWw2SYSIdpI9dl
 wjyRLmtoP30iEqkUM8hbIOgtzLKbu3MggRSC5W9mit/1OlJFRcHWrEWNtxFOXyYj
 Pm5YLe5dMN4yB+TO0xr4R3t6zkbia0UB/DPLPLxEFeG0xuVHD0HaMar0hcyFnyPs
 8si2UEWIlpVPjmPLiEXxwXJsgPSYMKGNuHUyVueajouhu0+XzoTQ5bnVHxwqB8CV
 aHjKGA9l1g9YNt3Izws+Q==
X-ME-Sender: <xms:iti5ZnVh2XCOqxfcjesTpHWs0ljl-BOq1gN8Qq6fF8IHPXn09_Y72A>
 <xme:iti5Zvm47--NFp3nYZ1PanRYVvEkPnVKS_bIIBU6FuqxzgIu9kU_ExOSLzN9xR_ls
 TX3IgpEiZSBETv_Nc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepudffvdelhedvleejtddvveei
 jeeiledujeefudefteetffffleeukefftefhkeejnecuffhomhgrihhnpehgihhtlhgrsg
 drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
 ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegruhhrvghlihgvnhesrghurhgv
 lhefvddrnhgvthdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghooh
 htlhhinhdrtghomhdprhgtphhtthhopegrrhhikhgrlhhosehgmhgrihhlrdgtohhmpdhr
 tghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehrihgthh
 grrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghm
 uhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigsgiesuhgtlhhisg
 gtqdhnghdrohhrgh
X-ME-Proxy: <xmx:iti5ZjbQLfTW2DVAwTcN_3cn5ccOM8oCVIHITbkfmYIYEm5XXp7Mlg>
 <xmx:iti5ZiWXPSuQ4BTjaUq5vvIa302dYZ1q3HnXOS11GFf1a6FVEX6KUg>
 <xmx:iti5ZhldZGfGpxmTA1-uKvLjTwZpvGvDzv1JuUUHaguMHMJRfkr8VQ>
 <xmx:iti5Zve1UjM4MkeVdBVG36_MjXwYmDkpanlTzSfad_Se_4a53nqWoQ>
 <xmx:iti5ZvYNZg6oeETE4rF62Pks59zUs4Z7q_WfTyjjLht2mqMo78v8OQcz>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5006F19C0089; Mon, 12 Aug 2024 05:40:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 10:40:06 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Aurelien Jarno" <aurelien@aurel32.net>,
 "Aleksandar Rikalo" <arikalo@gmail.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Waldemar Brodkorb" <wbx@uclibc-ng.org>
Message-Id: <6ca024d7-27f8-4037-b93f-429fe16da0ca@app.fastmail.com>
In-Reply-To: <20240811165407.26312-1-philmd@linaro.org>
References: <20240811165407.26312-1-philmd@linaro.org>
Subject: Re: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B48=E6=9C=8811=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=885:54=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> When refactoring page_table_walk_refill() in commit 4e999bf419
> we replaced the execution mode and forced it to kernel mode.
> Restore the previous behavior to also get supervisor / user modes.
>
> Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_t=
lb_fill")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!

> ---
>  target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c=20
> b/target/mips/tcg/sysemu/tlb_helper.c
> index 3ba6d369a6..e7ae4f0bef 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address=
,=20
> int size,
>           * Memory reads during hardware page table walking are=20
> performed
>           * as if they were kernel-mode load instructions.
>           */
> -        int ptw_mmu_idx =3D (env->hflags & MIPS_HFLAG_ERL ?
> -                           MMU_ERL_IDX : MMU_KERNEL_IDX);
> +        int ptw_mmu_idx =3D (env->hflags & MIPS_HFLAG_ERL)
> +                          ? MMU_ERL_IDX
> +                          : (env->hflags & MIPS_HFLAG_KSU);
>=20
>          if (page_table_walk_refill(env, address, ptw_mmu_idx)) {
>              ret =3D get_physical_address(env, &physical, &prot, addre=
ss,
> --=20
> 2.45.2

--=20
- Jiaxun

