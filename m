Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE49E7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 10:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR7tM-0008Em-4b; Fri, 27 Dec 2024 05:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tR7tK-0008Cq-DD
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 05:48:26 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tR7tI-00033b-Er
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 05:48:26 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5AE3C25400F6;
 Fri, 27 Dec 2024 05:48:22 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Fri, 27 Dec 2024 05:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735296502;
 x=1735382902; bh=lU3EuS7EQvfoXrJhhEZNcwiRH0f3kbO5SqoNcTKi+eQ=; b=
 F7GZVgGtiMK2HFrg1VEOdcaCn/dRLHjPY+sr+EZbGhkdSc6+c9ejwM/nCPxP4YqZ
 YInncFptrpFIHEsfPX6ybi5z6JRDoy/dWizmKwyWJ4Kn5+XBYx5hkFSYHejst6Cn
 qC3tNlbxXqiE5cDyEto/dcSqPEsNvClFy+zm9RJb8SzXkYx1Sw7EJ61NbBTW5Ej/
 N+44xudy3HHDi7sbOe1vmAHerHeE17RCSQuodCVjDWDJMMFuYM1X9CkEqkV69ZTp
 prKZYzRxhZTDCnc0dH6hXA6tLqQ3Ip5v3QpX/nWVYhoo8aY+10csKGSI0K94IbES
 Bju/yGgx/RguTQw5JX3/TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296502; x=
 1735382902; bh=lU3EuS7EQvfoXrJhhEZNcwiRH0f3kbO5SqoNcTKi+eQ=; b=X
 3GP6U+sJ1PRM0pM7j/NHVNEEBtd2Fr4A4O/xSRByZGFKsJOn2k+/hWReiGB0+QyL
 Jkm8hjfKKMZLfDsGjbacaBGK1xV2Kth0qEKhvCdR20RA8omezUp+Al1eU3nigOsd
 z5hsOnxTiR+vReQqEuUDOcMftSgPVEf3OQcvZ9IazGnWnUrtQcxPILCz/cffA0lN
 HQX6MSSvVGi/nnouRhaYsCsqpnjkYD17Fa2uqUGEA5K8erXE+zf7XsnAX3zEdMwu
 XUj4/wU5XqvnMqAKb6jGJEbz6ZPLyt13gWT1sTZlD3ngD3h9g1CZowwJMNwztb7y
 cUrb5CWby+A1wy5MNw8xA==
X-ME-Sender: <xms:9YVuZ8I3rHvFjqTViiDv7DfEh-LdhBxTqSQJl2PIa9NXhQPdvf6_Yw>
 <xme:9YVuZ8IlOk2p73i6vqx0o_8ZkP4UCf8t46gZp81evU4RtFXhYyypkcZ5GdeJxbVL9
 DQ4ID-_3ElI8dBnXrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphht
 thhopegvughurghrughosehhrggskhhoshhtrdhnvghtpdhrtghpthhtohepfigrnhhghi
 grnhgrnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhg
 pdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhope
 hmrghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghv
 vghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:9YVuZ8u35iFDVsDtu0--bvuORLLxysRlKguTvrP8xmwH1MZCGLsQpQ>
 <xmx:9YVuZ5YPZHag0ZmZ5KUtySVcUdWIN9ky2McW8ge2yWXNI3KhhdZGwQ>
 <xmx:9YVuZzYrJ_1vPq-GPKMF7bJXtr-Z3TUfQRXYdFXmblNrS4s9gbRQBQ>
 <xmx:9YVuZ1CGLiXruqvJHdd78yksK6eKn1xw7t5NVa2pyqDyaZySBaCw8Q>
 <xmx:9oVuZxDNsujFtDmXtQ-y7qUCFGXuO7uGvMNvBSvxhzi95p2RK1rBo-DV>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 18D321C20066; Fri, 27 Dec 2024 05:48:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 27 Dec 2024 10:48:01 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Eric Blake" <eblake@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <3014a754-57fb-469c-8242-a6ee1720850f@app.fastmail.com>
In-Reply-To: <0a6b9d18-435e-4d38-b2f5-a561d474fd58@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-23-0414594f8cb5@flygoat.com>
 <f332d6b4-66c0-481c-8936-12892664d24f@linaro.org>
 <0a6b9d18-435e-4d38-b2f5-a561d474fd58@linaro.org>
Subject: Re: [PATCH v2 23/23] config: Add loongarch32-softmmu target
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8827=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8A=E5=8D=885:20=EF=BC=8CRichard Henderson=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>> +++ b/configs/targets/loongarch32-softmmu.mak
>>> @@ -0,0 +1,7 @@
>>> +TARGET_ARCH=3Dloongarch32
>>> +TARGET_BASE_ARCH=3Dloongarch
>>> +TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>>> +TARGET_SUPPORTS_MTTCG=3Dy
>>> +TARGET_XML_FILES=3D gdb-xml/loongarch-base32.xml gdb-xml/loongarch-=
fpu.xml gdb-xml/=20
>>> loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
>>> +# all boards require libfdt
>>> +TARGET_NEED_FDT=3Dy
>>>
>>=20
>> I'd really like, if possible, to not add a new target, but make the
>> current loongarch64-softmmu.mak evolve to support both 32/64 modes.
>
> Yes indeed.  I had assumed the preceding 32-bit target_ulong enablemen=
t=20
> was for linux-user.

Ok, I'll drop loongarch32-softmmu.mak for now.

It's indeed mostly for linux-user. I enabled softmmu just for validating=
 the code.

Thanks
>
>
> r~

--=20
- Jiaxun

