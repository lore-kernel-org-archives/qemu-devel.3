Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C617E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPta7-0000NQ-Hh; Mon, 23 Dec 2024 20:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPta5-0000MP-NL
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:19:29 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPta4-0000ud-6B
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:19:29 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6A1E7114012F;
 Mon, 23 Dec 2024 20:19:27 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 20:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735003167;
 x=1735089567; bh=36BZtppifh/4DatAH++jyiOYqaklTlQZ9llcgQSSDEI=; b=
 pSDjcmCfb6q/oBVAlcVu+mLImeeJM/FXG2e3B7PdQ0VCsMxg5QVgnIUXXWLq6J29
 yZJKOeWRPyt1VvrjpWlNk58zokOYznx37UAOA2g3EsXPy+ztAH8KGL2YLqZt804o
 mDe0cu+eWktDMlrOvrVErIt8wxIafJCV2ZuAww/wcSpuEIc2fKRst3ASQ3M1PbiF
 PCB5mZjOs8b94cyQ1FZWbhyjAcm++MlhGpdCo/tM5imDktYui9asJzek8QVPooNK
 YRjZ/FI4c7m5GkJlfjJbx1QI2T8hjYDs6EmlUzI8gNtNqybivhwfzixJGEvNSU+O
 ai+VOjO0UHizyKZLIOVS9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735003167; x=
 1735089567; bh=36BZtppifh/4DatAH++jyiOYqaklTlQZ9llcgQSSDEI=; b=L
 Eyf3HuieZYNW4n/plPlLqvViiD9D8WVkBRfdiEHr2aw559kOiaCOOkMMvTTRIBP5
 xiIzaJK6u/vbKeInP7CdYiTTgFweu6IaHxERAFDiw7t8usgzPraMPXB62TzmPIG9
 GrqxzesJ18uNHlA++/UQKRrepiFZfc3X7x8SwFh6ip2vDQI2Vl4UNvG12ZC9p+Ap
 xObneXy2uYwiH7EseR20/m4z3k3pm8esmZ47cVH+JOmPonEww0RQIE5npilHQviJ
 yeUQRpiPEs1l9xB+eYVOFlvmvYZ+IIVeHb1neZMtYKZnjKXdJuJYbjkHmF38XCNE
 721WcEBSKES8rAahNOUjg==
X-ME-Sender: <xms:HwxqZ8GIkm0u8MCtZ2KNnXuq-8l6Mfer_vwUPhDCiINXwdugujka6Q>
 <xme:HwxqZ1W8IwaBj1Qw2HAnKDQba33kHa2K2WxoPvNNSfw-fuOd9WvuNYgf8SIB07btl
 RroTRe7GZT5G7wRgMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddufedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehgrghoshhonhhg
 sehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrgh
X-ME-Proxy: <xmx:HwxqZ2LmJwRJWBVKYHkJH-kfpMsQEHTNxyvL21xCZAO4OhAxfztVJA>
 <xmx:HwxqZ-GPNEE79M8JfmgKGkZtU29gWz9uWViUDp7YGUooaF10WzaJyA>
 <xmx:HwxqZyUtVfomBuKTrz6ZOxDsJ-zqm47dvrD3qqYiIbyMe783MPwKTA>
 <xmx:HwxqZxMT1lGOjuOfbJYl0j9FZFL5PWe4iGskf7tRAccx2r4eDnksYg>
 <xmx:HwxqZ_jZKGqNs4xE02U5_Nt0GAoao1NEfNXUikbd2sD4wRhnlaq_RIoX>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2148B1C20067; Mon, 23 Dec 2024 20:19:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 01:19:05 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>
Message-Id: <305f66bf-8ac0-4e24-ba52-d2ffefb1b465@app.fastmail.com>
In-Reply-To: <4ae86173-4a45-425a-b8e8-24bce3c8545c@linaro.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-3-8c62b7e594db@flygoat.com>
 <4ae86173-4a45-425a-b8e8-24bce3c8545c@linaro.org>
Subject: Re: [PATCH 3/3] target/loongarch: Fix PGD CSR for LoongArch32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
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
=E4=B8=8B=E5=8D=8812:52=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 23/12/24 00:40, Jiaxun Yang wrote:
>> As per manual, the source of PGD CSR is relevant to highest bit of
>> BADV. In LoongArch32, all CSRs are 32 bits only, thus we should check
>> bit 31 of BADV to determine PGDH/PGDL for LoongArch32.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/loongarch/tcg/csr_helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg=
/csr_helper.c
>> index 15f94caefabc7722263fa46e948e21de37b4203c..ca8100eedfb37fd3b45b3=
de0c0fc0fad599c4685 100644
>> --- a/target/loongarch/tcg/csr_helper.c
>> +++ b/target/loongarch/tcg/csr_helper.c
>> @@ -26,7 +26,7 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *en=
v)
>>           v =3D env->CSR_BADV;
>>       }
>>  =20
>> -    if ((v >> 63) & 0x1) {
>> +    if (v >> (is_la64(env) ? 63 : 31) & 0x1) {
>
> Alternatively:
>
>         if (extract64(v, TARGET_LONG_BITS - 1, 1)) {
>
>>           v =3D env->CSR_PGDH;
>>       } else {
>>           v =3D env->CSR_PGDL;
>>

To support 32bit CPU on 64bit builds we still need to check is_ia64 at r=
untime :-(

Will use extract64 instead.

--=20
- Jiaxun

