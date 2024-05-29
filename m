Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7015C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM1n-0007CE-Gg; Wed, 29 May 2024 12:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCM1m-0007C1-Qj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:19:50 -0400
Received: from wfout6-smtp.messagingengine.com ([64.147.123.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCM1W-0005EF-Pd
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:19:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 3C2211C0012B;
 Wed, 29 May 2024 12:19:28 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 29 May 2024 12:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716999567;
 x=1717085967; bh=KkM33jHfzKesOcTu8BJUyBoVikj1zMh49WvGhby1YwQ=; b=
 xInFYeqnG5QUnRPNVuFPziOScQQ7CoGMsA6NxXuU+GcMVvM4pdCV9uMPY+GnMVaH
 ZsgNvtlJE2I7hRCqs4a/MIlLlObjYORicmzM6qmgeTXflyKu0kwUnQmKgLd+x6uO
 7sjfLylQvOr0SGfb03W+YseYO+wS/s0g9vDyeU5azL00rV3oufWGuAgjPB+jsswB
 zuqXVuI7JdwQO9eobk/iUoDx/B3ukz0fZf8MrUfW4HaMxbVKzv/Hl9m/XwUVB8RZ
 xmLFGXlvrN7GHE/Fj1P69uSeWc1cKSC5H6wnwLqiB4oHQmRhbeZRHOZND3NJJa9K
 AjGGLbM5fRLEJ8IH2o2vjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716999567; x=
 1717085967; bh=KkM33jHfzKesOcTu8BJUyBoVikj1zMh49WvGhby1YwQ=; b=k
 nMLXpcKufSr79/D8fvNV6i+UNbG0/mhniblGbEgtaLPDlBAyUcKCaWpJ5E3Gmzb+
 Q7ZX5vz14eu6DMnEPN3q1tiqSFSXP4Ia4pWedM6M3TqCIiqd/t/GENvXeZSQOSpL
 dx+/yiQ8LMVxWUCLTmkHCX5E2p0FPRV5qGAVbIKGmUMsGEYTDWMGoGtoq4VPag0K
 Y4a/K6l/SAzP4Ny4u6/VvzqYo/wCkUVCBMeUle7QFAn3Mq0KWDt63RzINkAvlNhP
 I4EyRHgPKIx+/FwK070l8JJIM7EoXWPjK9h/2MsBFwcT1+k46C+MiX8N8u3Wwtms
 p0k2K9nDCWPRdBFSp/pwg==
X-ME-Sender: <xms:j1VXZoYEmoG5_Z3qc7CzpfC0TAyWjtMLWDHIwhGetANWac-nvZP0MQ>
 <xme:j1VXZjZtIjYC6Rm_269S_b605YUYTiOySeC1tR1caIdil6vqa6PEAFVGHMpgy3jWu
 g6_HiEvFWNe0Q_2Cag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:j1VXZi9c73NHTPuRD-pRT0V4q6olbHbFU-OF9XRzSrhFQV6mxPSdwA>
 <xmx:j1VXZirm82sf1KEDzc5HcX1KDFcrxM83qZsSZRq0OhEJzpRSebGRpA>
 <xmx:j1VXZjqAnu4xBGBd86YKUFZ8H66Z7Y0LH8p5r0qQnqDxB-rPoMkhmw>
 <xmx:j1VXZgRRDwOpUQharfcWHBZFO1ek7VKrwvAcYpTCEY32rQPdiCHq5w>
 <xmx:j1VXZiVTh_-wm5qRz0qUHgVqYZrdocOe5Q1gZkcPNP58k0yTXpgAWwVM>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7072436A0074; Wed, 29 May 2024 12:19:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
MIME-Version: 1.0
Message-Id: <c547af8d-2abd-46bd-9a8d-b36fb0061619@app.fastmail.com>
In-Reply-To: <20240529155216.5574-1-philmd@linaro.org>
References: <20240529155216.5574-1-philmd@linaro.org>
Date: Wed, 29 May 2024 17:19:07 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Aleksandar Rikalo" <arikalo@gmail.com>,
 "Aurelien Jarno" <aurelien@aurel32.net>
Subject: Re: [PATCH] target/mips: Remove unused 'hw/misc/mips_itu.h' header
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout6-smtp.messagingengine.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8829=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=884:52=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> Since commit e1152f8166 ("target/mips: Remove helpers accessing
> SAAR registers") this header is not needed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  target/mips/tcg/sysemu/cp0_helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/mips/tcg/sysemu/cp0_helper.c=20
> b/target/mips/tcg/sysemu/cp0_helper.c
> index ded6c78e9a..79a5c833ce 100644
> --- a/target/mips/tcg/sysemu/cp0_helper.c
> +++ b/target/mips/tcg/sysemu/cp0_helper.c
> @@ -28,7 +28,6 @@
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
> -#include "hw/misc/mips_itu.h"
>=20
>=20
>  /* SMP helpers.  */
> --=20
> 2.41.0

--=20
- Jiaxun

