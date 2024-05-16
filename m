Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7YkD-00081z-Jn; Thu, 16 May 2024 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s7YkC-00081r-KP
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:53:52 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s7YkB-0005q9-0z
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:53:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id D61BC13814E9;
 Thu, 16 May 2024 06:53:48 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 06:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715856828;
 x=1715943228; bh=tkclbpNTGEyjxaAsATg4659R1/wTXj8I4ISabjsydWw=; b=
 lLUEwGrrzfcb2K86GSmcXnysJUoAUOhvL2tUWM5ppaRZAZwSpmGRhxvXUmGuDKxk
 FgN9C16vTVdgf2SVCGiuL//JeLWJEtSaeuufyK4ygzo73DjqGe0r9nB1bN5+zNaG
 m2kMXnj6yI1beDny6MQYkzkmnZ7+Wf/VzLFWU8i/9Bl6CnkN6tRaThBPGSpRw5tF
 LKC44GE0Fpi5NJEIG9cuwt5ul6kU9Grcb2b24lykvqcaZ0/bM2vJ1sN+mzES2pkK
 N4bQwpmCC9+clBplnrI2fGmR/jGf6FDHCJQJ0oqdOhbCZHSmSjubVmftt8YLzlo9
 vkwMISG1nldsGWXHGYN5aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715856828; x=
 1715943228; bh=tkclbpNTGEyjxaAsATg4659R1/wTXj8I4ISabjsydWw=; b=W
 NhjW8Gp6l2qUqSfNI9Ok6ci6SspcFe2LGrRqyoFFAH5IJd8pg7l537Sp4EKIb8zO
 zIhnnZPtposG6oaTNeNHU1dy2yj5DNzhIVLXU0vHruvLgHTNVlLhG0nfb25pLUjs
 abGCaPKKhiUdlMV9fx1120b32MMdGGGNadaDZZtF5E/QWNeXWkO5H0SnLTqOjjDP
 zn2bVERTEGXzGqTRF1nNtWpdVOCMdMz9/8zVRvF70MSgnANF25slQ6WwFjFt3J38
 BJVLaZEpGEsaDdOzgBxLFrlIYar95fRc4O1xgoVOovexpW55R5xljdmZBy+wuMzz
 BK7iU5chIBTenEU7uQlUQ==
X-ME-Sender: <xms:vOVFZmoupahsXgNGSffE3M9lzvx-_WOByWkRfqBWOMVihghbC4JBKA>
 <xme:vOVFZkobtjN20AQQLgUWt6ffGvu5RMfd-39aBw4XDUGhLdw-LA77VQq9VfsatjknT
 cpRjwVJvsRKoSI43zY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:vOVFZrNypuyt66jWhXH4HRCSny_nJ1gQRYHigELnf5Tw4H2tuTR9ZA>
 <xmx:vOVFZl4U04lD1WFWRArOodRqFp_STWeg_jp6qVmnGqcQ0t9I0vAcwQ>
 <xmx:vOVFZl7kF9qOVxbhgHDQb5-rLThgy_3nLgg538b8HyDiyqdUlMRz3Q>
 <xmx:vOVFZlhM596BIYtMknhvlSzayNPjzczHlByOc_6TdzBz5FDAXPo6hg>
 <xmx:vOVFZvnkm_pQSyQeRAQ6WbYEi9RDtqxr-MW4M1ImF-Vzg24jnbaCWRc5>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4555B36A0074; Thu, 16 May 2024 06:53:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <75c78b9e-4a18-4faf-9b80-a497d3401dba@app.fastmail.com>
In-Reply-To: <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
Date: Thu, 16 May 2024 11:53:30 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>, "Song Gao" <gaosong@loongson.cn>
Subject: Re: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B45=E6=9C=888=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=8810:41=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> On 8/5/24 15:06, Jiaxun Yang wrote:
>> Hi all,
>>=20
>> This series enabled IPI support for loongson3 virt board, loosely
>> based on my previous work[1].
>> It generalized loongarch_ipi device to share among both loongarch
>> and MIPS machines.
>
>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (5):
>>        hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
>>        hw/intc/loongarch_ipi: Rename as loongson_ipi
>>        hw/intc/loongson_ipi: Implement IOCSR address space for MIPS
>
> So far patches 1-3 queued to hw-misc tree, thanks.

Hi Philippe,

Thanks! What's your plan with the rest of the series and earlier MIPS
CPS SMP series?

Let me know if you need help on testing etc.

Thanks
--=20
- Jiaxun

