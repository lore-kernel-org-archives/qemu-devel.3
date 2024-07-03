Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D85AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOx68-0007DG-Ef; Wed, 03 Jul 2024 06:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOx66-00079F-N6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:20:22 -0400
Received: from flow7-smtp.messagingengine.com ([103.168.172.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOx5t-0008ND-Ns
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:20:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailflow.nyi.internal (Postfix) with ESMTP id 74C9320046D;
 Wed,  3 Jul 2024 06:20:08 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 03 Jul 2024 06:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1720002008;
 x=1720009208; bh=yM2EdPI9XusHAZG4ZlPVShG8MDlT1v5rFbqttzLVTfk=; b=
 Ksfj05snDz2cN2Iw0plLEtSx6fHF4b74fCJfcl4LlLs/bHuEmJy/txhPRCyynl0B
 EBpKf1TqVgzaQzNErR1nXghM/UnFpNhrHXPOTrx80FM5sVPyf5iTuGr9rBWyiyY0
 KL7OK6mxYwRrzKBoDddijUSd68s0NRnTn7G06ksffmT59utUMB+3SK07FlDXXt10
 uTSxXXBwJKpkEweR1/7xvifSsKdQE5MCXzF40dW5ET5HLCpejv5orIu4ZIex6JFx
 jH+2IwGp0VM7mKZ5/21+vIlJWKA21EkmKJ4PgaxcVwvUo9tjk8F80RV43Ad5MlyS
 OnOpKNRS7lTPescsUPGLrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=ifd894703.fm2; t=
 1720002008; x=1720009208; bh=yM2EdPI9XusHAZG4ZlPVShG8MDlT1v5rFbq
 ttzLVTfk=; b=VaK6AoLrZRhwaybRGv++cRDcjMQNttCHYbGlYL6WmETj4kcVi9R
 Yr3UdkIsTu9yR1mWIC2KuNwgKbtfDQObSyrP6T1gh1bGE7h+DN2UxuEelDSZpP9J
 eft+8OSJ76Y7HTA8p1b5S1J0ycq9gpa0w7+1ZNhT50w7uMxXozpRQnz4vee6BAcL
 9kvXcWW3334SzEf8OPTE+Iri8uY5vGOYmbFsdaaYPYSHW2h2xQBrzJs/joObOSKA
 m94NYumwt24tKGwvEFkt9USmLWVxRxKgXpoXCkH8J6ys6I62D+lkYn7AGlU2D+bO
 iHElGtNhlDjiJHd6fD/6sbigrj/gXEYxjnw==
X-ME-Sender: <xms:2CWFZnmD77noIRXpa8FLfzt4LCUJpOW6xa1JERdv_uJeKdzhuwWdDw>
 <xme:2CWFZq3Mm8QBeDTdHpturBmMT4CCVJ1EimDULUuqZ448FiuZmqThQyYS2j58AJE7O
 2IgKdUt0MWuDgFeBGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgddvjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:2CWFZtrrFV3lPVq8j4gVP8PpOVx2ltdu9tzGzB9bNKXv_ouy5fRdmw>
 <xmx:2CWFZvmzFhKcqsT9xUhiOFSHDEfIlW8u8r_0u7FaJq1EK0Y6j9Nj1A>
 <xmx:2CWFZl0bLC2kuLB4xkr26OOHgQhRqWWBmtskkgbbGjwcWBMj-Cy2Sg>
 <xmx:2CWFZuvQ_zxwc4PO9_dEzvXl38R98eBAiFP8lrApGVDvdf5_QYw2lQ>
 <xmx:2CWFZpWn4KPuLneTQBQqvBiQAuyBdDfh_XhSMymlt4F5ZHEA7vAaPyBe>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4C94436A0074; Wed,  3 Jul 2024 06:20:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <c0d18ff3-3c58-4794-bc31-db6787e4becd@app.fastmail.com>
In-Reply-To: <5224f884-6327-f181-5bbf-f1d1f9f3b894@loongson.cn>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
 <60da2f5e-009d-4362-bf62-32a088b2848c@app.fastmail.com>
 <CAAhV-H4YqauX+dDFGK1oHrRjROSykkp-j0AfRD4a43Yea4qMxQ@mail.gmail.com>
 <5224f884-6327-f181-5bbf-f1d1f9f3b894@loongson.cn>
Date: Wed, 03 Jul 2024 18:19:46 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.142;
 envelope-from=jiaxun.yang@flygoat.com; helo=flow7-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B47=E6=9C=883=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=886:10=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>>
>>> Huacai, would you agree with me?
>> For me the important thing is consistency, all vm-features or all
>> vcpu-features are both accepted.
> To understand features immediately is difficult job for me. There is=20
> supported features/used features usages etc, overall feature detection=20
> should be VM relative by my knowledge.
>
> Maybe after host machine type and migration feature detection and=20
> checking is finished, there will be further upstanding -:(

Do you agree with the scratch_vcpu approach? This seems to be the only
straight forward way to make some progress here.

Thanks
--=20
- Jiaxun

