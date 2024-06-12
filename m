Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE400C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMnk-0004nh-5M; Wed, 12 Jun 2024 08:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHMna-0004mq-FB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:09:55 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHMnX-00075s-Kk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:09:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id BE6D61140151;
 Wed, 12 Jun 2024 08:09:45 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 12 Jun 2024 08:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718194185;
 x=1718280585; bh=vyueXoYZ6erq5NL75eAPMO+g4k5eu8DSjMuKvkl0Rkc=; b=
 Mnt4pOe9jFOE5w0JKwdqxwucRGbtuN1QWd7+TEWDe5fh7M+NhxhLxdZdL86HaLrk
 0MIUO/spFs274KXozNX0YqMhfTle4KyYtle+ksL+sYySDKwX3GMPDGLzhlDGIgv6
 mVpmF+W3GgEH76JGeQdxleqHGSU3C9pwfnco7dsK/1W7DpCiX7M+tQKXvn4nkJ7E
 /gpz2Pq7EqRowhXglbz4iwpUDtCHylSNjTmyJNnj0UI0JOP8A8kCG45YuiBwACtu
 LR80stWJ1UTusSrUGpVunNS9lQjIgGC/t7ybRqDfM45cf/rscxpupjMUqyYGP4j3
 O2bjxgKZMF3bkWAnkbUJdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718194185; x=
 1718280585; bh=vyueXoYZ6erq5NL75eAPMO+g4k5eu8DSjMuKvkl0Rkc=; b=J
 rSp0EiU610gcxw1Xtmee8ylvli+UT32pzLzQxQKKnWEVs9o6iPaRrfEIvHjNPpZw
 fOWQr4U6KHTiAAfm9sMcdx5kwhaJL6r/T824PtWI08XdWhtCvThWx0++bWk7eFF8
 gQ3Sjl1EkNvSjgvCZXhLqE4mPENsRgXYUD5laH6DRkof3hwdP0dEkU9dfg6wZb3q
 GSU+T4oEW/fk744LTlESFBR9+2rdFJWdny7WMGPjVTEzz8n6p+4X53jf6sxqcnwI
 Pwrlgfnqs0KyDX+5eOhmV7tYU75fR55C/y3oebTblTlOSfNPdRh3YWaygpVPsx5Y
 UrYHGfZTwauQgGP66f7ag==
X-ME-Sender: <xms:CJBpZgFVgVFIyyBQ1nyLkJVTDTqMOsAORGQEf6MRoB7v9meqyWOfhw>
 <xme:CJBpZpUzUmmWBNRb8LiI-KlQ7qYkEw1yf_urr-GVsQryyOqWK64HdkqA3y6Vn0mHG
 -T3CDrjeL7w1JtwHOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeekleevffehtdeigfekfefhffdtudffvdeuvedtffet
 heeuiefhgfetleekleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:CJBpZqIsFG12JR3RaCO9Il6-pPDKT4V9ZRhk-Ja0eW62tIUezL9DPA>
 <xmx:CJBpZiH563fSRh57tMbkgVdf4t42Envg90XhHMtSuMFTklunLhih-A>
 <xmx:CJBpZmV9_JWau-t-PiUToJQnXM4Qu6Xqb2LsZMtv625A2a4a4PcR5g>
 <xmx:CJBpZlO-LGWNXsS1cOr3iG4oXovu4ez7XooGQEaZarLrZMk58-1a9g>
 <xmx:CZBpZlR7ockemb3dk_k_lgxPFAJUzTWmnDOt911-Q68Iv3N002c7FtnN>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 822FF36A0074; Wed, 12 Jun 2024 08:09:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <cb6f844c-1b63-423a-a821-03d9f0e4b9f5@app.fastmail.com>
In-Reply-To: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
Date: Wed, 12 Jun 2024 13:09:25 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Song Gao" <gaosong@loongson.cn>
Subject: Re: [PATCH v3 0/4] hw/mips/loongson3_virt: Implement IPI support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=E5=9C=A82024=E5=B9=B46=E6=9C=885=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:15=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series enabled IPI support for loongson3 virt board, loosely
> based on my previous work[1].
> It generalized loongarch_ipi device to share among both loongarch
> and MIPS machines.=20
>
> Thanks

A genttle ping :-)

Thanks
- Jiaxun

>
> [1]: https://lore.kernel.org/all/20230521102307.87081-1-jiaxun.yang@fl=
ygoat.com/
>
> To: qemu-devel@nongnu.org
> Cc: Song Gao <gaosong@loongson.cn>
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v3:
> - Fix up sign off lines.
> - Link to v2:=20
> https://lore.kernel.org/r/20240605-loongson3-ipi-v2-0-da26282e03a5@fly=
goat.com
>
> Changes in v2:
> - Add a patch to remove loongarch_ipi.c (Gao)
> - Change iocsr alias owner to CPU (philmd)
> - New patch to remove ipi_getcpu
> - Link to v1:=20
> https://lore.kernel.org/r/20240508-loongson3-ipi-v1-0-1a7b67704664@fly=
goat.com
>
> ---
> Jiaxun Yang (4):
>       hw/intc: Remove loongarch_ipi.c
>       hw/intc/loongson_ipi: Provide per core MMIO address spaces
>       hw/mips/loongson3_virt: Wire up loongson_ipi device
>       hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id
>
>  hw/intc/loongarch_ipi.c        | 347 --------------------------------=
---------
>  hw/intc/loongson_ipi.c         | 120 +++++++-------
>  hw/mips/Kconfig                |   1 +
>  hw/mips/loongson3_bootp.c      |   2 -
>  hw/mips/loongson3_bootp.h      |   3 +
>  hw/mips/loongson3_virt.c       |  39 ++++-
>  include/hw/intc/loongson_ipi.h |   2 +
>  7 files changed, 108 insertions(+), 406 deletions(-)
> ---
> base-commit: d67a6e054b92e5e1cbb7b0bd5782a670cc7f0df7
> change-id: 20240508-loongson3-ipi-65e99b47c400
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun

