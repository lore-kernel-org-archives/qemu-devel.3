Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D13FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublb1-0002Bs-SN; Tue, 15 Jul 2025 15:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubkzC-00052o-Qh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:06:44 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubkz6-0001r8-EO
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:06:41 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0AF26140025D;
 Tue, 15 Jul 2025 15:06:34 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 15:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1752606394;
 x=1752692794; bh=Ld270ARNXKviUbockHvo9cpRjE6+Uk4j3ncQcA5itck=; b=
 2SLuZKWsGk+mXk70nrFt4nA2i+GcePOeHwME9sIFTgz3rEItV7LJSlmGej50JOr+
 xbIqcNTIj4B5DUiZBuogXDBpBr33m8Wxmz2OxD/wcnnRa6Rljaz4PNvDpnbrnm+i
 mt6LejcvgoSXOjNaVlXy/SogCn8eqNMdPAsTdVUcEevHbOBS2NTcy5zljPnK5DNv
 Oe8kZTJXzcQAn2jvqP65d1G9Ngu2UII3D6IHOYxtI8Dw0i5+VkpcvTFUh21dlrd9
 LjVgHRDTFsXheZJm9XvqHta/WbUPxPJKgI/8Ky6UMMgZgDf6d0+yEnoGprNEyuVy
 n7B0bm6/ZdpTpRurlA9S0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752606394; x=
 1752692794; bh=Ld270ARNXKviUbockHvo9cpRjE6+Uk4j3ncQcA5itck=; b=c
 R5r7VgHVNmllDLgLq75rs1lksYEtxh8n1CcuZnphSHFuAPVLHPJsn5Kc9UYR1K0/
 Cwmgaerl6tUjUy+4TwVEe9TdQMiagcuPYg1OyY2553BHxdiVdTmhwVc/amp5zKHA
 nJjgto2R5bTAasygn5ZHs1HddgZj9851PH5sI0cm77hl1Bpntn4OFwYK9hXGbmtQ
 scNwTU7AvMibi+HP5lbqRihtQDjUGi8ZV/dMx8nM1fD+d/5d6rOlwjUuLwr3bwrK
 vDCrlalARMqRsQW/E8Nj1M0DuZPWHFge8xRedIqYSGwCXIZso5umA3BkDqTCA5yv
 omauyZDrhY/YQKvUml4HQ==
X-ME-Sender: <xms:uaZ2aAt7WNjBswmWsssI-6gqFFbr3cG2zgZf2X0-Z5NLgTwNBf1dGA>
 <xme:uaZ2aNdhUtyHUAxryAMZANZmcwRIfzR3432-0XHP1IYjOVGxvD_QiRiW1s6GMKDlI
 ClJ90vyyQTgNO9eRqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflihgrgihu
 nhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeehfeehkeekhfffueeifeevieejgfekkefffefggefhgefgleeu
 ffdvheefvedvgfenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
 hpohhuthdprhgtphhtthhopehfgegsuhhgsegrmhhsrghtrdhorhhgpdhrtghpthhtohep
 rghurhgvlhhivghnsegruhhrvghlfedvrdhnvghtpdhrtghpthhtohepudelvdeivdejje
 essghughhsrdhlrghunhgthhhprggurdhnvghtpdhrtghpthhtohepvggughgrrhdrihhg
 lhgvshhirghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlse
 hnohhnghhnuhdrohhrghdprhgtphhtthhopegrlhgvkhhsrghnuggrrhdrrhhikhgrlhho
 sehshihrmhhirgdrtghomh
X-ME-Proxy: <xmx:uaZ2aFLg5vFsjcLLpZTb4oTOCCFuGp4MUo9FQBGtDKsxt_H2z4nehA>
 <xmx:uaZ2aB7-5Lo6KJyNuT3tgSDftmdrx5G5hzYhCtUOatZHRR5LQjvPXQ>
 <xmx:uaZ2aJ1FpyaQ-OZEA_TmZ7LtnxgKRm_uwF-q5sRI67CH-mWl4l_4Zg>
 <xmx:uaZ2aHcoiB4WVsJ2ZzyvPaoafiYuLs4GKdrwnbRSNK--tG8eFxRPWA>
 <xmx:uqZ2aD2NzKDNWe2XKZ8BCuPMG6vpdHRw_34ibpuSw_FU9Wg86b3SdQTY>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 310F92CE0071; Tue, 15 Jul 2025 15:06:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T13493bb08d7ad028
Date: Tue, 15 Jul 2025 20:06:10 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Aurelien Jarno" <aurelien@aurel32.net>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Aleksandar Rikalo" <aleksandar.rikalo@syrmia.com>,
 1926277@bugs.launchpad.net
Message-ID: <970fe4bd-e0a0-4488-8db2-a581568bf090@app.fastmail.com>
In-Reply-To: <20210427133343.159718-1-f4bug@amsat.org>
References: <20210427133343.159718-1-f4bug@amsat.org>
Subject: Re: [PATCH v2] target/mips: Only update MVPControl.EVP bit if
 executed by master VPE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a6-smtp.messagingengine.com
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
Message-ID: <20250715190610.TilYlKTnGL6xaSb-FIixqlTTTA59y8LNMp-GsSAK7YI@z>



=E5=9C=A82021=E5=B9=B44=E6=9C=8827=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=
=8D=882:33=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> According to the 'MIPS MT Application-Speci=EF=AC=81c Extension' manua=
l:
>
>   If the VPE executing the instruction is not a Master VPE,
>   with the MVP bit of the VPEConf0 register set, the EVP bit
>   is unchanged by the instruction.
>
> Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
> if executed on a master VPE.
>
> Reported-by: Hansni Bu <https://launchpad.net/%7Ehansni/+contactuser>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
> Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Confirmed with uarch behaviour.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks
Jiaxun


> ---
> Supersedes: <20210427103555.112652-1-f4bug@amsat.org>
> v2: Check VPEConf0.MVP bit (hansni)
> ---
>  target/mips/cp0_helper.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index aae2af6eccc..d5f274f5cdf 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -1635,12 +1635,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
>      CPUState *other_cs =3D first_cpu;
>      target_ulong prev =3D env->mvp->CP0_MVPControl;
>=20
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> -        /* Turn off all VPEs except the one executing the dvpe.  */
> -        if (&other_cpu->env !=3D env) {
> -            other_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_E=
VP);
> -            mips_vpe_sleep(other_cpu);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> +            /* Turn off all VPEs except the one executing the dvpe.  =
*/
> +            if (&other_cpu->env !=3D env) {
> +                other_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVP=
Co_EVP);
> +                mips_vpe_sleep(other_cpu);
> +            }
>          }
>      }
>      return prev;
> @@ -1651,15 +1653,17 @@ target_ulong helper_evpe(CPUMIPSState *env)
>      CPUState *other_cs =3D first_cpu;
>      target_ulong prev =3D env->mvp->CP0_MVPControl;
>=20
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
>=20
> -        if (&other_cpu->env !=3D env
> -            /* If the VPE is WFI, don't disturb its sleep.  */
> -            && !mips_vpe_is_wfi(other_cpu)) {
> -            /* Enable the VPE.  */
> -            other_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPCo_EV=
P);
> -            mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            if (&other_cpu->env !=3D env
> +                /* If the VPE is WFI, don't disturb its sleep.  */
> +                && !mips_vpe_is_wfi(other_cpu)) {
> +                /* Enable the VPE.  */
> +                other_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPC=
o_EVP);
> +                mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            }
>          }
>      }
>      return prev;
> --=20
> 2.26.3

--=20
- Jiaxun

