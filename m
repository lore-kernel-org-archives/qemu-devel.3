Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27257E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 21:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPpa1-0007f4-Ky; Mon, 23 Dec 2024 16:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPpa0-0007eq-Ay; Mon, 23 Dec 2024 16:03:08 -0500
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPpZy-0006Iu-Bq; Mon, 23 Dec 2024 16:03:08 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 864B5138015F;
 Mon, 23 Dec 2024 16:03:05 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 16:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734987785;
 x=1735074185; bh=ypcMPSjv/uITj3BrmR2Z765Y0a4x2DwJ7cNotejkEO4=; b=
 AO8tVWVr4BAio3lP1MuXig95JB1yiG1LW82Ht4SCyAxgC1wfYEDvSUBFrDanIkrN
 XQCH5zyJsEX6UBqdvCvuD+zWEYQLT8lUbBaQZS0o1YeZIrSSEW8shQYwilAO+Gyu
 R9Kw9CsgbS3b4awsfkF4jfxfLj8PDhgTgxTa5MjlBl778xC3OWgGik9pllS//Eou
 E9PAaUJU8gc0s/I/d7HvNlrx26t/GBsNS9LxNS2KGnbbd/FQ5fn1yg7IiWAdOZBT
 qSAUyyGsJ7YTyhYI4M4TddR18iiRILNmbE7hr4GPXcE/3ftCKRbIBespPoN7BHsq
 FiAFvZIuNt6FJhA1czuRBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734987785; x=
 1735074185; bh=ypcMPSjv/uITj3BrmR2Z765Y0a4x2DwJ7cNotejkEO4=; b=P
 hpOnsxF28aNv+oeODHzo87Zow6jhqmc4ij5BvV8xUWZPB5JGWT8fjydhAhLE6dDZ
 8/q5qc11BPtr2vHknJSbjnP+ILdVCoJRcmOr62puMikF0AMptX3iO0kq51Vg/W/V
 sIkD6E8JTNMgHcX22JmSSws9qHY2csNez3OZ35+QA7E2k/yuLgwB0g5BMhszoZ/j
 YoPbtj+uKVDUH1aPpqrzasL3BXriBhSxBJAciEkYX1F4W/5KYZzqvHg0msjPpfbB
 Zw5s6tCZhffay0ditLui38O+jCiri9Xx4wvZFR+SHsVAk0+ZR058+3Mx6W+F+/yN
 +zUHRdd7kIrrquCuME5mg==
X-ME-Sender: <xms:CdBpZ6G3NilPeu5h8u2sWNM1oJnRKBR7ysyHvQDQ_Q1yeHvpnhOaBg>
 <xme:CdBpZ7XxqONODs8xZxgJSO9Oav6s67-HwWJTLRCiebvFMEL08V-kDqoDDyOyrxjsP
 a71UsuNLx49uvUVGNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddgkedtucetufdoteggodetrfdotf
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
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pehqvghmuhdqthhrihhvihgrlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprghrmh
 gsrhhusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsvghrrhgrnhhgvgesrhgvughh
 rghtrdgtohhmpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:CdBpZ0LgU3heg_k2PhNGXvJJVt5iSjOmAuUG7Sqz-xX0ogior7TCYw>
 <xmx:CdBpZ0E07dRu_dVLTqou7OAPJV-PO8pYsSmxuNJewjOOGSH5VHkX4Q>
 <xmx:CdBpZwVqIYwsNiySIykf_IbZvavj5qDrjHDFuJmF87ugFWw9d5nKJw>
 <xmx:CdBpZ3M-_ULuW6EU1jRchWPkxxig87q6yYG7RWC5O6fBhw2ilEmx7g>
 <xmx:CdBpZyJHtSRtPS_YBH9GMG1JmcNb_cY7NSkf8P9j18wKWJMQdxMly5gQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2E4151C20066; Mon, 23 Dec 2024 16:03:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 23 Dec 2024 21:02:44 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>,
 "QEMU Trivial" <qemu-trivial@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "Markus Armbruster" <armbru@redhat.com>
Message-Id: <b827ff72-27d4-4d1f-9622-8b2a507f4b11@app.fastmail.com>
In-Reply-To: <804d9b8d-5593-4884-b184-ecfe079917ae@linaro.org>
References: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
 <d5c580f6-e871-4670-8d38-05f9205828f5@linaro.org>
 <804d9b8d-5593-4884-b184-ecfe079917ae@linaro.org>
Subject: Re: [PATCH] Add a b4 configuration file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a4-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8823=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=8812:24=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 23/12/24 13:18, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Jiaxun,
>>=20
>> On 22/12/24 17:53, Jiaxun Yang wrote:
>>> b4 [1] is a convenient tool to manage patch series with mailing list
>>> working flow.
>>>
>>> Add a project default config file to match QEMU's mailing list=20
>>> conventions
>>> as well as adopting differences on scripting.
>>>
>>> Examples of b4:
>>>
>>> ```
>>> $ b4 prep --check
>>> Checking patches using:
>>> =C2=A0=C2=A0 scripts/checkpatch.pl -q --terse --no-summary --mailbac=
k -
>>>
>>> ---
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> =E2=97=8F cc5a4c890fed: Add a b4 configuration file
>>> =C2=A0=C2=A0 =E2=97=8F checkpatch.pl: 27: WARNING: added, moved or d=
eleted file(s), does=20
>>> MAINTAINERS need updating?
>>> ---
>>> Success: 0, Warning: 1, Error: 0
>>> ```
>>>
>>> ```
>>> $ b4 prep -c
>>> Will collect To: addresses using echo
>>> Will collect Cc: addresses using get_maintainer.pl
>>> Collecting To/Cc addresses
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + To: qemu-devel@nongnu.org
>>> ---
>>> You can trim/expand this list with: b4 prep --edit-cover
>>> Invoking git-filter-repo to update the cover letter.
>>> New history written in 0.02 seconds...
>>> Completely finished after 0.06 seconds
>>> ```
>>>
>>> [1]: https://b4.docs.kernel.org/
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> =C2=A0 .b4-config | 10 ++++++++++
>>> =C2=A0 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/.b4-config b/.b4-config
>>> new file mode 100644
>>> index=20
>>> 0000000000000000000000000000000000000000..5feac15642958350c457d1769b=
f881184ae1a79f
>>> --- /dev/null
>>> +++ b/.b4-config
>>> @@ -0,0 +1,10 @@
>>> +#
>>> +# Common b4 settings that can be used to send patches to QEMU upstr=
eam.
>>> +# https://b4.docs.kernel.org/
>>> +#
>>> +
>>> +[b4]
>>> +=C2=A0=C2=A0=C2=A0 send-series-to =3D qemu-devel@nongnu.org
>>> +=C2=A0=C2=A0=C2=A0 send-auto-to-cmd =3D echo
>>> +=C2=A0=C2=A0=C2=A0 send-auto-cc-cmd =3D scripts/get_maintainer.pl -=
-noroles --=20
>>> norolestats --nogit --nogit-fallback
>>> +=C2=A0=C2=A0=C2=A0 prep-perpatch-check-cmd =3D scripts/checkpatch.p=
l -q --terse --no-=20
>>> summary --mailback -
>>=20
>> I also have in my config:
>>=20
>>  =C2=A0 searchmask =3D https://lore.kernel.org/qemu-devel/?x=3Dm&t=3D=
1&q=3D%s
>>  =C2=A0 linkmask =3D https://lore.kernel.org/qemu-devel/%s
>>=20
>> Do you mind if I include that in your patch or prefer a different one?

Thanks! I=E2=80=99m happy with your additions.

>
> Posted here:=20
> https://lore.kernel.org/qemu-devel/20241223122347.8438-1-philmd@linaro=
.org/

--=20
- Jiaxun

