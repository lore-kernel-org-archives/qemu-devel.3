Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94E2C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4l5g-00047b-0q; Wed, 08 May 2024 13:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4l5c-000479-OI
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:28:24 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4l5Z-00024M-77
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:28:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id BCBA9138015A;
 Wed,  8 May 2024 13:28:18 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 08 May 2024 13:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715189298;
 x=1715275698; bh=4Biwh1tTEiVwIje2qrK+MNsT4dr1r6puto9Yh+sLmzA=; b=
 WQHSRAElEtKBe1b6nTuC1F6isywafP9P8ATCmGV9J/4hh7nRgvv9/ZLcF1WaNnmr
 8J3E0VeWLvYA7vqe/zgHTruV5otY7LsKmPmsatGnK5D7VS1BD5LVviU95MGFktcS
 SncWRer1PiVjzFkPPgo2JrlO8fqKE1gztowqEwba5vUplojeyHNQgScQAsulpk0R
 exWBrAk2ZkuQQLqIHX6TXDYF2i5hAMjEqmkujW2NSRWsR9qFXMDXXbahgf9iOJQH
 gyqlFz74dVLGvMw1tXS4mUMCC/5ZvWGX0v0CU2pausfjkjeEAmsfwnY79QNe/UdH
 TfDD5ROceln89MSbfqwrfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715189298; x=
 1715275698; bh=4Biwh1tTEiVwIje2qrK+MNsT4dr1r6puto9Yh+sLmzA=; b=L
 At5+NR2sZKXpYrvG/t1C1NiaIplNlLNuwLnRR61WecVl7IH0yu2f9tGBfPPN76BS
 WajDKByYL4J+JFdjiFbPVugyLCtk0+6+iJp7id9StyuFoHP2m5ek1wj6xJGsZFAq
 Q6WMjCJUAxq1tByrey/buVWeKBwHGQLKJU3ve4kGy3xxFlERddpU07kF+1EsaAJp
 fftGjNRIO3N8borKVrtb5buPqdjCM9KFTMPoCHUlLSM4HrPVmUt3ChXFCSjUxF5E
 cfxzbqBiixZZA2hUmJbs+ewfPzK8G8dDqkCgPuKJW6iWfzZCURtGQiSsmd852ZDl
 sohRPYfNsyONA2drwl/+A==
X-ME-Sender: <xms:MrY7ZvrsfE5_OWBlOgk_NLwgv-vCEpa6XBoaSXHz2ybOWjyaIWfAEw>
 <xme:MrY7ZpqehzIh-dpZlSe_5fuMenaDalhDbpQgQ6HC91ZQwN9Ja84POyW1Trgrua03c
 HkIyP542xwal4fRvII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
 jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:MrY7ZsM7lRUzysZUVtS_k8Unw_Jq0jPEHYApqy9QlRpHqyJ-WnrT6w>
 <xmx:MrY7Zi4Q47poV1we8NvvoOjxBif_agBMP-63YWfgXwexuxpEICfsTg>
 <xmx:MrY7Zu774p01-HpkHicqHYDi_ZIK1UGjV1Ts_jOjXN1MVoqd2T50bg>
 <xmx:MrY7Zqi0S0z-2hiEo_rmxYozQ_D3sxqTSMZV8_uDrlv9g0hRelHA_g>
 <xmx:MrY7ZuFY7EwX_nvFc8yGHVFT6Pa3ARXKpcYZvbt2l7jWNF8pnfgVJu5P>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6E31536A0075; Wed,  8 May 2024 13:28:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
MIME-Version: 1.0
Message-Id: <145ab58d-eb3b-4671-afc6-b0b556dba936@app.fastmail.com>
In-Reply-To: <37a227ca-af03-4f03-b135-b12ea2ef521a@linaro.org>
References: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
 <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
 <37a227ca-af03-4f03-b135-b12ea2ef521a@linaro.org>
Date: Wed, 08 May 2024 18:28:00 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>
Subject: Re: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout4-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B45=E6=9C=888=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=885:48=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> On 8/5/24 17:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/5/24 11:31, Jiaxun Yang wrote:
>>> Suspend function is emulated as what hardware actually do.
>>> Doorbell register fields are updates to include suspend value,
>>> suspend vector is encoded in firmware blob and fw_cfg is updated
>>> to include S3 bits as what x86 did.
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> =C2=A0 hw/mips/loongson3_bootp.c |=C2=A0 1 +
>>> =C2=A0 hw/mips/loongson3_virt.c=C2=A0 | 19 +++++++++++++++++++
>>> =C2=A0 2 files changed, 20 insertions(+)
>>=20
>> Thanks, patch queued.
>
> Fixed:
>
> ERROR: use g_memdup2() instead of unsafe g_memdup()
> #76: FILE: hw/mips/loongson3_virt.c:293:
> +    fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 6)=
, 6);

Thanks, I omitted this one as it is copied from hw/acpi/core.c

Should we fix that one as well?

--=20
- Jiaxun

