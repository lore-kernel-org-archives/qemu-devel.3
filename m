Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0789FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ5nf-0005gH-R5; Tue, 24 Dec 2024 09:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5ne-0005c3-DT
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:22:18 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5nc-0005Gr-Ks
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:22:18 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id CFE9D114011B;
 Tue, 24 Dec 2024 09:22:14 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 24 Dec 2024 09:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735050134;
 x=1735136534; bh=RwK+1woltfiko4f96JXysKHTlGZXex0v+DFHMZzh2Tk=; b=
 RJk7C+NwzUe1en3zVEvELjm2eJLZc4eMPnW7YS0SG8p+g26eJHx+k7xv6XOV0cD5
 aL+n+OvTjuMC5gCCZzHKOwtF8vkncuEVz+dvNAA76BV+wlvaSphjFfW8D1Ma9fqP
 sxPsyB4MvR7Hdo2C8OduHcYPNnfRkzW0Ds33aUM2b+GcxvhHteal03XabThMIsTs
 MhbgSdz9G7TkNNwlstNt5z7c1NzE8yAfUU7BlROYyzrdBo8eZYZemsi2Lnowhg1q
 pXICSujsHLEVbaMa/QFQZztS3e4K7rXJzyoZe/BcQGcPEsaDYIxfrzm1PhHOkZAv
 TjkXvQEfh8/NlemNv2YOaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1735050134; x=1735136534; bh=R
 wK+1woltfiko4f96JXysKHTlGZXex0v+DFHMZzh2Tk=; b=QmeaGt37jSwCspYij
 x92TLkcp38NRdrNVfU5+5Yg233imSlrf87ywHP3IHvBmGaQMDhxsP19TBnP3pkq5
 W6riAD6vwohd8kzpl6GUWzAV4CuDhNcKaw24mwCFDq/E9hLzYeMQmstgg6w3PWmb
 F0iR+o7b+UcuxTqsuJq3oeNdTk01fcroDo+CFVdTE2x7NqrlIVghTeSEOlaUEXMX
 hHVD2a+nsCcat/iq1cPtdYvUQ9tqZXKlUvB87icT7ue5CxxvVHpxCpGXcoU1zN1q
 bSRZxribUrG91nFtEChEFc6Qhkp/gJzyglNQRNomnT39JGkXPDz1gh0ghbW5QYZr
 zg++A==
X-ME-Sender: <xms:lsNqZ_TRk-CLMrUa3rs6jB76dRzZoz76u46a9otneuL3fsEMiZs3Lg>
 <xme:lsNqZwy5d9q3WgDKjNK6J4Kf2pgoSZg4wX4r5jnvMEKElucHfr2_HQkjOnU-VwFFY
 kETdsRxAI7ruWxMUmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
 ucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedujeevvdfhfeffvdegveetffef
 tdfgtdeivdfgveeufffhleduueehheffffevgfenucffohhmrghinhepkhgvrhhnvghlrd
 horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepvd
 dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdr
 ohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:lsNqZ03qqovX4niy2AUL4UpBDUmUTa0JCGZEecnFUGeJ83KxUV5e7A>
 <xmx:lsNqZ_BcJhCjjJ20W2ogv3r06xEI-ggiu3ldcA9iM-bGZC4J_m5DSg>
 <xmx:lsNqZ4j2WGGsQ_qOve7c_dQEQc71bfFuhK_O1q60z79RrGJjgbIINQ>
 <xmx:lsNqZzrEpRatHWqM-DR3rNdM7zxAWZFaopeMBaKD6Jbl1ncm15WBgg>
 <xmx:lsNqZ0YWsoITFj8v8DfmuqTNsH-vhvw5RMgMt1Fqkng-9hvs_8f8g8Hj>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4EDCC1C20066; Tue, 24 Dec 2024 09:22:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 14:21:52 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Message-Id: <84d52594-c9d8-4f8a-80cd-5440a9d9c4bf@app.fastmail.com>
In-Reply-To: <20241224135054.10243-1-philmd@linaro.org>
References: <20241224135054.10243-1-philmd@linaro.org>
Subject: Re: [PATCH v2] b4-config: Configure Lore masks
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b3-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8824=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=881:50=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!

> Based-on: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
> ---
>  .b4-config | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> index 5feac156429..af9cfdcd3ed 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -8,3 +8,6 @@
>      send-auto-to-cmd =3D echo
>      send-auto-cc-cmd =3D scripts/get_maintainer.pl --noroles=20
> --norolestats --nogit --nogit-fallback
>      prep-perpatch-check-cmd =3D scripts/checkpatch.pl -q --terse=20
> --no-summary --mailback -
> +    searchmask =3D https://lore.kernel.org/qemu-devel/?x=3Dm&t=3D1&q=3D=
%s
> +    linkmask =3D https://lore.kernel.org/qemu-devel/%s
> +    linktrailermask =3D Message-ID: <%s>
> --=20
> 2.47.1

--=20
- Jiaxun

