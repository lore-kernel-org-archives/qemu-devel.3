Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33914E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 13:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ4h0-0002tt-Pd; Tue, 24 Dec 2024 08:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ4h0-0002th-2P
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 08:11:22 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ4gy-0004E4-2J
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 08:11:21 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 8615F114011B;
 Tue, 24 Dec 2024 08:11:18 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 24 Dec 2024 08:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735045878;
 x=1735132278; bh=ZStwZ3C3LP2X49MKAI0ckUqXMmoAB+o3N5AJFwMbnfc=; b=
 dgiPpeGNbpZIFaPqfRYx+NZwBR2+40DCoO1SqACOkjVcA108AP2AdaFix/5F/f96
 6rYqWS+1FUK0n0pY4REs9Mx9VfWJAAfb0hDVyaYEuBkmZszhfrumXWibecR89wiA
 qf5juEgqdUFalGOd5MeSzi8Wiwq0jkbCK9CFbo+j6FiV+3kUeVVOl66nAFB531OA
 6GB8RIGlxCbO1RAXjiATjLY0YSH8cWhH2YeNbqOAXUC35okMNi1Yll8orUzykL1b
 qotzNTdts/Jo7MN6BtAJjZfvoLvi3eq7tHdOdF+g5xdsC7e+KoQ6uMQrnW67rUrf
 XcmpFsyFpJqJh9ytOcphSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735045878; x=
 1735132278; bh=ZStwZ3C3LP2X49MKAI0ckUqXMmoAB+o3N5AJFwMbnfc=; b=W
 S5vmdVQ9cPrOgPY9lWzYtwfL4N9SzUOrHYgrFdJSq0fA48PjEzS9CNJwlKJYPrgL
 zCUzaYoiuJFJwcmSV63BR+3jGHoUX+vqvvOaYTSZVxbZ7qWXMzE6tlJYtIq1f9B8
 1obA2l+wME1nCL9kvAOosVwpThMgV1kpKVp0rqC2sbj//HazhbFf1xJhBbKBJ32L
 mvxNbyDG1oqqg8yeKUvDr/6FAZRBDVAAt4V5ZnWQjpK2P71X3j6ecQBH+/1TNaIv
 jQ65SQSlvgHYo6ATiNmMNXBPTY5uROI0Y+tQS3CPsyT7HddusFQzwOXpeGCU6GIR
 I+YmiRSOd0iz5sRaFQkow==
X-ME-Sender: <xms:9rJqZ7mj6R4axeCYZxI3O7pGENtoJaWJFewlSGetYdDHxhSnYZVnGA>
 <xme:9rJqZ-0HFbfK01kQQncsQgj20CtI2RoU8e9q1D6Ny_QF9lBTxUvJWxUwOvET4k-ab
 XW9tU9d7Wsqu3vNp-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedggeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
 gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
 drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
 ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhnrdho
 rhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopegrrhhmsghruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggvrhhrrghn
 ghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtg
 homh
X-ME-Proxy: <xmx:9rJqZxqm76TJO3QhLiueR8McdU2QcftKtTYZG6a78GtDfeB_PFPqSg>
 <xmx:9rJqZzmBIHo97JnYL4LW7j7y6WqtgaQiz1939vhYu8D1K4yjZ-Vhjw>
 <xmx:9rJqZ53_v_7UUsL3Im94PkCFR2sMUMr0xnrMJpmrpLZXsO2WBuPHiw>
 <xmx:9rJqZyuACUNeXSDiFdlUj5_lAaumg-3xcJyktB886r37RwyhiaAX1Q>
 <xmx:9rJqZzpp2-dOvyK80Fjlq_RjKLJXa7Ig0tTGveMYq7ZaaA6vbFXRx-ON>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id EAE5F1C20066; Tue, 24 Dec 2024 08:11:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 13:10:58 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <0c0e7bd2-a62f-4ac1-88c0-7a1b4ac00b6c@app.fastmail.com>
In-Reply-To: <20241223-swift-of-splendid-protection-b5dcac@lemur>
References: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
 <20241223-swift-of-splendid-protection-b5dcac@lemur>
Subject: Re: [PATCH] Add a b4 configuration file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.145;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b2-smtp.messagingengine.com
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
=E4=B8=8A=E5=8D=884:25=EF=BC=8CKonstantin Ryabitsev=E5=86=99=E9=81=93=EF=
=BC=9A
> On Sun, Dec 22, 2024 at 04:53:41PM +0000, Jiaxun Yang wrote:
>> +[b4]
>> +    send-series-to =3D qemu-devel@nongnu.org
>> +    send-auto-to-cmd =3D echo
>
> Hmm... does it not work without the above line? If so, can you please =
send a
> bug report to tools@kernel.org?

Thanks for the comment!

Query send: https://lore.kernel.org/tools/af457861-6d07-451a-a4a3-9f5206=
2f95b4@app.fastmail.com/

>
> Thanks!
> -K

--=20
- Jiaxun

