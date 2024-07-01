Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCeQ-0001ds-PD; Mon, 01 Jul 2024 04:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOCd5-0001QL-3j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:43:19 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOCcz-0007mg-Fl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:43:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id A1812138016A;
 Mon,  1 Jul 2024 04:43:12 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 01 Jul 2024 04:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719823392;
 x=1719909792; bh=SBuncp6t1oMXbh1a8cQAXO+N/Yf4y6oazG/4surUgQU=; b=
 mFzbaqjyWENcrdI7Hmsjqnx+hXzkTFJvWbLBadbZCk0P85f6K+x2vSZonTdX4s8E
 u2/UIuTi5/y4kEYQ7lRDAigufsE72yLLcY6eJh3wwNqnRhYLfISOqcOsN7jnuIug
 ZUu4JTL8PAp269k8QYfdjqRMYgtVDBBSxIpnPjyS2zf3I6ua70Esf4HbDgclxKlN
 GeKuPorTDa62OK0i1ooZgkMEcg5DLeeX4vEoOYECP9TvkN1PCoIgYO1Fy8BykEFh
 wmeL1UCLCWCWbFQhOLQeexmWhtKNLEYS4BoNp8RGIgMuJX5h+cz/pfBqTibRBG4G
 xVNKw+WqkVPf3qeHDW4wwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719823392; x=
 1719909792; bh=SBuncp6t1oMXbh1a8cQAXO+N/Yf4y6oazG/4surUgQU=; b=S
 fkXpibYTdEC/+GjvIGIzqgtFjj5wbPUi5A9S/B81jsO8AD+veiu9Tngme5XdxuVr
 3uqORhbWeCa5BrLd84FOVYPQVU/yIeC0CZn8Py42coOyI6y0wmXXFTfmahEsdoSZ
 97AODHJxx+i1fZV1JuLyWvhf61/SdF2QWfPzR07hhnh9dobb7QeAwzA+1QXpW126
 m0pZFl0wyG9hl79kYzZRgglw9iugfyg+KZtRxMznsFNYunt+QvlSeISO5loxf1Vd
 3OT3pJBPkDiOm2m93jz7lZ6uw4qcmH8YgGmzVTU3tvA8B3cjvKVfF/T8x6KdumcM
 GCC7nFHgzY38dpDptxbyg==
X-ME-Sender: <xms:IGyCZuJIH3_L95jyQzDGCfuF6fUO3Tzmxpdto4U4EnWfWKVlucOAaA>
 <xme:IGyCZmIwG7CxhoH4z_kin6fNQCFvzo1ekuk4_Em6TLPBrrPpxHu4JK8p-9dxl-7yF
 A6miNVv43A0rr6gv1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgddtiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:IGyCZuv9w_YEKsfM2avObi9_doNHfMlEziprPPlsVDO682CcYDKYBw>
 <xmx:IGyCZjarG0vvOIRcvcjKp4WSWJjUQycpuHdWFDY3Eq9g7CRNE_3kuQ>
 <xmx:IGyCZlYuprwwoIJflTbpnaSB_Wvdvcbur9yYn8XPB59Ti3Z_jV9MSw>
 <xmx:IGyCZvCakWw-ivKsJ9Dmxkky9ik8LXFNhE4MTFcm3bvGsBeLowh-Nw>
 <xmx:IGyCZpFuWMiXGnH_FBfUVx5pMedcJYynwfLNnI9t8W2VF27telLQ3Opz>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3037536A0074; Mon,  1 Jul 2024 04:43:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <cdc0d448-8e3b-44f7-89ca-a15ea48acd2b@app.fastmail.com>
In-Reply-To: <bba3338b-4c28-fc38-fc5e-f4691bfa28b1@loongson.cn>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
 <bba3338b-4c28-fc38-fc5e-f4691bfa28b1@loongson.cn>
Date: Mon, 01 Jul 2024 09:42:57 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout7-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8A=E5=
=8D=888:32=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>>
>>> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
>>> +{
>>> +    CPULoongArchState *env =3D cpu_env(cs);
>>> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
>>> +    bool kvm_supported;
>>> +
>>> +    kvm_supported =3D kvm_feature_supported(cs, LOONGARCH_FEATURE_L=
BT);
>>=20
>> IMHO if there is no global states that should be saved/restored VM wi=
se,
>> this should be handled at per CPU level, preferably with CPUCFG flags=
 hint.
>>=20
>> We should minimize non-privilege KVM feature bits to prevent hindering
>> asymmetry ISA system.
> For "asymmetry ISA system", do you meaning some vcpus have LBT feature=
,=20
> however some vcpus does have LBT features? That does not exists at all.

Yes, we should always prepare for the future :-)

From Weiwu's presentations, I believe LASX asymmetry product is already =
on the
roadmap. So for LBT it's also a possibility.

Even if such product won't land in near future, we should still try our =
best
to bound to vCPU creation, not to the system.

>
> It will be big disaster for such products, how does application use th=
is?

Affinity placement etc, there are many possibilities.

On Arm side, there are already systems with Big.Little asymmetry CPU that
some of the processor equipped 32 bit EL0 mode while others doesn't. They
managed that well with affinity.

See: arm64: Allow mismatched 32-bit EL0 support

Thanks
>
> Regards
> Bibo
>>=20
>> Thanks
>> - Jiaxun
>>

--=20
- Jiaxun

