Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EA7C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfeH-0007Qk-6R; Thu, 30 May 2024 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCfeD-0007QK-Mn
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:16:49 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sCfeB-0007aj-Qd
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:16:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D4E6D1140132;
 Thu, 30 May 2024 09:16:46 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 30 May 2024 09:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717075006;
 x=1717161406; bh=egN0GwrZT3rc76ckawv60CC4W9ynKqMOE8g8Dg8wMGI=; b=
 gDFmk/naMwCmNY1KA7clAXJ6OyaV/QblLa7G8BwbIt2H7BlKCeXUyAscfSYDIXlD
 N8XKA3NCz0zv6lpFiZpx5dV9ai3fwrpvqy6oK2YEfyBpz/yDtXmyWBff/da+BaUn
 JUzltS5IzEyuTDnhZSoATHkGIfDWyJ11FvCmY8bf6D7xtlj3McgBQi/CA6onK97a
 gRzyuHCQB+Gj9PY1KoOtuiwSdbYDKehrHI8rA6tOFdO0e5tsuoPjRw6HdHzSvG95
 z3UvbSDJi3grRKS83PWSs+KRJqFoA2E8MlzxZHAu/xGG67jjKx8+yi6vp9N6EWgE
 3SOFLO+sSH5A50f28/5UVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717075006; x=
 1717161406; bh=egN0GwrZT3rc76ckawv60CC4W9ynKqMOE8g8Dg8wMGI=; b=A
 jq6NaPWVVY3+tkxVfd5olhXGtlVvWDVBQovCPM1O7xaVhtRxMtcnIt5qc03eSHSR
 zJhNdpllCkweNp+uFzaqtljdEz586tDr7KYkkV2SFyirGXjMW8hoDBMJIfG30LvD
 MNXRmIcHhrGxDxwQsK8k8aqBN/j3QJ2JSMTkQG+oyVM2wZvqVZVc7kb9TIYSYVCn
 udcXR7MC95uGNdiztCSjNIonbqVBNhpwqDo8cIifZfPNXEHoqRC8jOpVssrpgI8y
 jhl1dOgOZFseAX935zzUDMQ/bKI/4b+NcLfEQ6JgnwfdecTDe3lnhSISrHnKzBrl
 Ov+XJgrNzhKwqtafosT8A==
X-ME-Sender: <xms:PnxYZkUJq7iklNzwn0ZJ_z1Uhqe6sozkX7hvwbu5YCW0SPnNdhI-pg>
 <xme:PnxYZokMufTy55dYG0WZxYDLFbdtQEEbn25DudiKZIHYCbuokgAnSrx4vz2ho5fAP
 1cXl8pOb6Cw0yW8EvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:PnxYZobEucd5ZxnBLAY6FKYbsNJKSkaOnOlcj47NKW0hp10ydEXo4A>
 <xmx:PnxYZjV9FJXlhYCRiQbC5TuYzvIXD2P_J8dr9j3fOpqalwAX4BQ3Nw>
 <xmx:PnxYZumxVoECJtkKMsv1bO5IqWqD7leBc-I0O-3NyKEqIlQM-3Es6A>
 <xmx:PnxYZoeyc4d2AVulskqnhzi_A924jwLOA7pgpXRb-XMYlkeP-NoeZg>
 <xmx:PnxYZghC993_YNihyn0WLO83tKdZKZKHScedd7DMFRYZAf2DtNMjcJE1>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2605736A006A; Thu, 30 May 2024 09:16:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
MIME-Version: 1.0
Message-Id: <bd599efc-1b5a-47a1-b0e9-15c59907a256@app.fastmail.com>
In-Reply-To: <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
 <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
 <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
Date: Thu, 30 May 2024 14:16:18 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: gaosong <gaosong@loongson.cn>, "Thomas Huth" <thuth@redhat.com>,
 "Xiaojuan Yang" <yangxiaojuan@loongson.cn>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: tests/avocado: Add LoongArch machine start test
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh5-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=882:00=EF=BC=8Cgaosong=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> FYI, the test does not seem to work anymore - apparently the binaries=20
>> have changed and now the hashes do not match anymore. Could you pleas=
e=20
>> update it? (preferably with some versioned binaries that do not chang=
e=20
>> in the course of time?)
>>
> Thank you,=C2=A0 I had send a patch to fix it.

Hi Song,

As LoongArch EDK2 support has been merged long ago, do you to make a cle=
an
build and add it to pc-bios directory?

Thanks
- Jiaxun

>
> Thanks.
> Song Gao

--=20
- Jiaxun

