Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FC3C27C79
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 13:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI7PY-0004MV-O8; Fri, 14 Jun 2024 09:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sI7PX-0004MK-Nw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:56:11 -0400
Received: from wfout3-smtp.messagingengine.com ([64.147.123.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sI7PU-00072q-99
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:56:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 26ED71C00096;
 Fri, 14 Jun 2024 09:56:04 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Fri, 14 Jun 2024 09:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718373363;
 x=1718459763; bh=yMnfbIsl8/gHTnO2Y1sw+WeNV9gRlJToMrluvAX2j3w=; b=
 PnW6L0M86+ufvR7CrlIl6X7acNiNH+KAWNx2SUTKvAVXSdQkdsgYh7vLLLiQ/sXJ
 bBLuKVVZm22MsVW0nqwCul3uvBrYPWy7MvxeEwhl1mN+lq0yDDNsKMa/VVl3nXDw
 BPB2QAjTl6wHv88ab5AH1QXjkL1CbyyZEtrYFZD6HiHnOrNaTcLKQnTO0iBcqHer
 l7RwFc4CBzwM7oWTXidxcquO8hiYdquu3qiDoZ6rtOoDT8waVWoW1tncdBOXWw3K
 JuNTqhIvfSQv5oW9yYrnofwmm+Jko6i0sBcjcTIT+4VyN+iz2KhRK+peHzyaAZvi
 /s969ovX4YvQIrRPF063dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718373363; x=
 1718459763; bh=yMnfbIsl8/gHTnO2Y1sw+WeNV9gRlJToMrluvAX2j3w=; b=g
 IETwY+HhCez9StuNNitH/DfQO5SVEy9h38u9HyPVqHrrROJ8FUz+zOg71viipeEK
 sZ05BucMV+sNqK4b8xJ/AMK3T6NCNh9Czc+D22tPUi+8u64gkFrK+P7WSGOzBZ18
 4OdSEzUUfMxR/0QFz5cscpjo6yqErO5gryF4cTWycu6EK4sExLaEvwh+KPhgQAs2
 a9aW5Y6AB6QhjCjLsWIpbxWKJCQn+9HQUbwrNHF9y54lVJq1ozOmt4HZlp4QGkA5
 CeLLFkbOA4+cGoOnprAazC0ukUSn4oHKrmomSGeqorNsH6+HPCuXbQekNVCxVrlN
 /4rU/Ok6hx998zR68+Eeg==
X-ME-Sender: <xms:8ktsZhHeJT97NBY1B6iPDfylV0HeY-5QsmP__XV8RCND2dHtGNhWBg>
 <xme:8ktsZmXvRKZJb1Vb0AGEfauv_WLMd3rGbhqluixh0h3d84VGeAcY3ngD34vn5JPhg
 0RnZXhi1-5a6Mn2F2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:8ktsZjIE6_gEkope0ReaIUO1qYZ3yR_WwfFfxFZl1pgxlCr3bBH2AQ>
 <xmx:8ktsZnEh0aBCSumOx25M7En7jXQYd1OAQTfLA6ucon2gHNTAPez03w>
 <xmx:8ktsZnWHhmvTBJWMECWnHKlIxT6twVeleiAoeE0_EPU8R0PQL54Lhg>
 <xmx:8ktsZiNnvXxPJHcKFkOp0hDvLuVhkjdz7Rit4LuGXVbooD7HyF_b1Q>
 <xmx:80tsZgPhoSt0kMiEFaohThqpXVrpmbcVc5qHBi5_0Y7hFfp-Jg5KTWPT>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D5CC736A0074; Fri, 14 Jun 2024 09:56:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <94fa26e2-1ae1-4477-ab6b-40888863002b@app.fastmail.com>
In-Reply-To: <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
 <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
 <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
Date: Fri, 14 Jun 2024 14:55:44 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>,
 "Ani Sinha" <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Song Gao" <gaosong@loongson.cn>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Sergio Lopez" <slp@redhat.com>
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.146;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout3-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=886:17=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
> On 2024/6/14 =E4=B8=8B=E5=8D=8812:27, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=884:32=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
>>> It is interesting.
>>>
>>> How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or
>>> ethernet magic packet or qemu monitor command in background?
>>=20
>> Hi Bibo,
>>=20
>> The best way to wake the guest is system_wakeup command in monitor.
> Ok, I see.
>
> It is useful and it can be used to test S3/S4 in TCG mode at least.
>
> Can we add feature capability, enabled in TCG mode, disabled in KVM mo=
de=20
> by default? If vm deploys in cloud, users in general help it is power-=
on=20
> always.

Well, I think we should align both machines as much as possible.

It's also enabled for KVM on x86 piix4 and q35 machines.

Thanks
>
> Regards
> Bibo Mao
--=20
- Jiaxun

