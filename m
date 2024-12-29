Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1CAE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 15:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRvPI-0006Bk-0d; Sun, 29 Dec 2024 10:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRvPF-0006B0-FQ; Sun, 29 Dec 2024 10:40:41 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRvPD-0003b0-LE; Sun, 29 Dec 2024 10:40:41 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B7A4425400E9;
 Sun, 29 Dec 2024 10:40:37 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Sun, 29 Dec 2024 10:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735486837;
 x=1735573237; bh=yCGTfLw0+h/gUpAefSLfg0+itHdtkQU08+0q7cUgP10=; b=
 bLYbCdx2zuCOufTAgduX6VjqUYCtUQZ8O9OCACVmGcA46/Vahtw9pfETjnOKBUe7
 /SHO8NAIRqnwGfo2TcE3IZNN9H3ruPj15CgYFdMvv1w2M0REQ1/xH6pu/kekKReD
 jnP9iikqY/LHnH+CIuyEoyPSqQGLy4touxUCn6TbVKY9pkzEhS5RCng2gJ451w/4
 LSY6wOJH0B6Hp4o25CZ55BZTbILxD1Ty0xPRB8VTqxtS9smcfclmi76FAKtAj66e
 9VBPcLvYct38Ak545MpGHUGHsMrm40ksdTR7cGcGnYenXlwS4aXSvgAPXM+0zTSg
 8BQ/nWxHh70qKAbTie3kZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735486837; x=
 1735573237; bh=yCGTfLw0+h/gUpAefSLfg0+itHdtkQU08+0q7cUgP10=; b=J
 cTPTPw6AtMvNIzwr/j2Xlnm1ExIADD7kMTZlVnGqzPBR64pN7mjR3rkfYx6giOcS
 +xuuZVzu83Y75eRAzFB+/xyvgW2BhoUdGvMiNhiMcm0llkunba91N0CM6+CIVzZE
 doQQs8g+kKgQyhaI6LfB67yT35o/es3vN2bW/4g2QXwLYlGVvtGHRv4EohnIGvjS
 zUwMQCyls67xLD5swYNX0Ih/DZ0Qv3BP9GXvN+FIv6GH848eUkVDCXgZZm0LYYSW
 atzXzfMpAhybwof9mwcW2tCbxtuXFBG+AqDHH+sH7nedGsgy0C2+UnmgRrice+Zf
 8jLEOV30LwnOK6HyoGC4w==
X-ME-Sender: <xms:dW1xZ5n6M2LqP64QpCSTrqdnapwFS6KUPbT_KLdh_pXc8NkvXJwutg>
 <xme:dW1xZ01FSX47RZdbEzuxn4czzgXnf1KlNWSbCbhIHtRT1TEafWnr3NvVqVZ1jXXNi
 4JXhzLHp9BvArz9B2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgedgkedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheprhhitghhrghr
 ugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqd
 guvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqshhtrggslhgv
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehlrghurhgvnhhtsehvihhvihgvrhdrvg
 hu
X-ME-Proxy: <xmx:dW1xZ_oH0jkNfqiZnS6wku9o-bUWzc20p8Ck2fycwR6LevrI-ymR1w>
 <xmx:dW1xZ5lt87wTM8-ghoUV74V5RWvOpGCcQNGjZEZpl2cZKTzEgmh-Ug>
 <xmx:dW1xZ33kbBu458HawswKeqy9g_kPFWZHYnnYWeMAY7V2QF2UX0KC-g>
 <xmx:dW1xZ4szyAzB0phIvTF5uTXCWkcgVQvx8lt4UUKaPyqSXa74v2vhcw>
 <xmx:dW1xZyQWYf6m6EZjYl-tVJX8FsbQ2FcdZD2MFsluVzUNMkG-R1FuxDhO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 488A51C20066; Sun, 29 Dec 2024 10:40:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 29 Dec 2024 15:40:17 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: "QEMU devel" <qemu-devel@nongnu.org>, "Laurent Vivier" <laurent@vivier.eu>,
 "Richard Henderson" <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Message-Id: <5d0800cf-a8af-4c65-83db-36940b49563a@app.fastmail.com>
In-Reply-To: <4e51180d-9f2a-c778-13b7-5130ad4d660c@eik.bme.hu>
References: <20241229-m68k-semihosting-v2-1-8a08b2d199a5@flygoat.com>
 <4e51180d-9f2a-c778-13b7-5130ad4d660c@eik.bme.hu>
Subject: Re: [PATCH v2] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8829=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=883:15=EF=BC=8CBALATON Zoltan=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> Also why use switch for a single case? Why not write
>
> if (!is_hw && cs->exception_index =3D=3D EXCP_SEMIHOSTING)

Mostly for clarity and matching the style above, see:

    if (!is_hw) {
        switch (cs->exception_index) {
        case EXCP_RTE:
            /* Return from an exception.  */
            m68k_rte(env);
            return;
        }
    }

Thanks

>
> instead?
>
[...]
>>

--=20
- Jiaxun

