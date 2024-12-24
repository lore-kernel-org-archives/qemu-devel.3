Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B107DE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtdi-0002OD-O4; Mon, 23 Dec 2024 20:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtdf-0002Ny-Gp
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:23:11 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtdd-0001HF-Qd
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:23:11 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id B08EC13801DD;
 Mon, 23 Dec 2024 20:23:08 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 20:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735003388;
 x=1735089788; bh=Tp/TbYK93/7pA/Oa2ra0BmabbGHJ1d3Txj1F3oQQIDA=; b=
 cSz+CqUmLG6ry/QkotbhVIGb/yvkFg+7vCsXZ+vLXxn/v4LfzXDDJSjbLMNYe0YM
 VafSRFQoCUPs00SMroFYA9hbPZ2aTl8OiqThuIrjUvUcqrQLBRFMyOpQzcr4pBsl
 YDkLY6I7kfxYHBJ1Z4Dqbj6ScGsCYbXU0om0KTer6DlM1UjwU3HmSCeb25eviPn0
 dkiPUAgaVkQTeE7DbHXsKdSLXeJT+CvYemgaPSURh9iW5+GH4gFiN4kcwu57BtVI
 oFMsOUjNDKFQIxKbA+d0+SqsOwiqJf0qnb69EsJNXj3hidt+teJMgVrp5eqDIIqw
 xCPeV03MbwkGDx9NdWy/hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735003388; x=
 1735089788; bh=Tp/TbYK93/7pA/Oa2ra0BmabbGHJ1d3Txj1F3oQQIDA=; b=N
 kMED1udyEQgupJkV6zBZX19tUkYduSCY9U+ERQYHrqBG8/lhMI/MbhF2QLgQkUp1
 FnCNPwP+vErQR9HTfKJu/bDqsBxV8ky8L1BJI6ctZHcjMv4KnPeHpJfAXph95EYs
 txFHIBpg4mA8VaR3skxOrjEtFhqmHtylGsCw7dI21BLzkSOZGkYQIArM0tVvUx7H
 eaOS1kfu8PpnZOUO85nav8PEiE+12+SKNahCA1cqs9Fkzm2ghD0XDw7ebweucB6n
 529IfPeNoDv6QtHbcgv02jceW02n4spGx5VEqHTdgPBCpl6WwimAWllKsZyepMMl
 t5IEBOPqPLyJPkwV3D65g==
X-ME-Sender: <xms:_AxqZxQhvvMB2LncsMiT6D7uXKYvDPQBxAJQNbYFVfEUsuIpLDRmPw>
 <xme:_AxqZ6wpErjQ59Fid0pHjOgIdiAGoCGAx5hn6p2nj55_cJLI7PIrjwCoBCpcEPWN5
 XTSKl3Rx4aj8Y7QtbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddufedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgepud
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehgrghoshhonhhg
 sehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrgh
X-ME-Proxy: <xmx:_AxqZ22eHDsMPiIqQ43HgrvRhwJb-dsciTXH-DPECU0kFn4Cj0yFVA>
 <xmx:_AxqZ5DO5LhIfg27FNQ_aanZZ6ZPH7-cObMep2fsMNCZgTT8kz7vTA>
 <xmx:_AxqZ6gXBdScSsHvk6QcBF04ITWx8xGUC0ulz-makv2QGjz9-gEabQ>
 <xmx:_AxqZ9qeMtkKwJztg-p8LvYJEhpBm1tElp4Iq7CWMltcWiQU9B8d7A>
 <xmx:_AxqZ9txbP5FUXmG8YnkaJyOktM1sQ5ZbSXr8roCbNpZTQ0DPiaRQwrG>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 6A9111C20068; Mon, 23 Dec 2024 20:23:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 01:22:48 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>
Message-Id: <860f3202-c6e6-4080-9f8c-eeee5dfe6b29@app.fastmail.com>
In-Reply-To: <e0ade58a-51b8-43c5-88f1-0dd8b3c9611e@linaro.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-1-8c62b7e594db@flygoat.com>
 <e0ade58a-51b8-43c5-88f1-0dd8b3c9611e@linaro.org>
Subject: Re: [PATCH 1/3] target/loongarch: Enable rotr.w/rotri.w for
 LoongArch32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
=E4=B8=8B=E5=8D=8812:46=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 23/12/24 00:40, Jiaxun Yang wrote:
>> As per "LoongArch Reference Manual Volume 1: Basic Architecture" v1.1=
.0,
>> "2.2 Table 2. Application-level basic integer instructions in LA32",
>> rotr.w and rotri.w is a part of LA32 basic integer instructions.
>>=20
>> Make it available to ALL.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/targ=
et/loongarch/tcg/insn_trans/trans_shift.c.inc
>> index 377307785aab4837bc181f1691632e7970a9889d..136c4c845527f0e63902a=
8306dcaf136dd4dd3fc 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
>> @@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_=
SIGN, gen_sra_w)
>>   TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
>>   TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
>>   TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
>> -TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
>> +TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
>
> Using 'ALL' disables the availability check, is that what we want here?
> (I don't know, maybe it is, I couldn't see any LA32R/LA32 instructions
> checked).

I think it=E2=80=99s indeed not checked presently.

I discovered that when I was getting LA32 kernel to run on QEMU.

Those two instructions exist on LA32 but not LA32R.

For LA32R, I=E2=80=99ll take care of it later.

Thanks
>
>>   TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
>>   TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
>>   TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
>> @@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, t=
cg_gen_shri_tl)
>>   TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
>>   TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
>>   TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
>> -TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>> +TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>>   TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
>>

--=20
- Jiaxun

