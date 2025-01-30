Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E80C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 11:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdT2N-0001DT-49; Thu, 30 Jan 2025 06:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tdT2I-00017t-4v; Thu, 30 Jan 2025 06:48:42 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tdT2D-0004by-7u; Thu, 30 Jan 2025 06:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738237695; bh=gACRncbKAVwvBMKYhSpdoULuuPQ7X4R326vt280uarI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=YOVfNKv6E3UskBk8b7L1KTDVTUAUHKsj2JOG50Iyj/JuRioF6h3LC0LHjSKswiPqZ
 wee1DqZBFr26jPikpryWTlImG88tepjLWZKQKfsk9BUzf9l/PlK0xf2b0QNGiXSn2H
 1l91NjRZ+JRvmDhsJrdKX6tSRnd44uArbcIpzDtI=
Received: from [192.168.78.120] ([117.172.226.81])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id C0D8CEC9; Thu, 30 Jan 2025 19:48:13 +0800
X-QQ-mid: xmsmtpt1738237693tix3f0e17
Message-ID: <tencent_6A70CD1509675ED7CF926CD93DEDC152CA05@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOKCB/VySmeFbzIBOrxZ6i1BIVm8/oHUpkLIojAe+e0kxcTMxSvx
 JB3WvPLk98O0A3G+sv9CEZ8yzqc/NA3LTjtWIRzWw+a1W91bHpFZXYmAvxz0husa/HpssB/8+bvn
 cdF6n4ao1WIkLBSdNCZn9I+HFo3YijqwKOFOzQ7taMVQfnvDjrAC1KPP1pXvUZg67jUDQ0ck7qxE
 DegOCW2HXRgvD+y0oJIyblL5cR4OuE78SiUhOozw0dYICWwvCXt62qny7Ix/iF2AreiB0M+M8TAb
 JBUtJKouvCbTe7ZsUAYF/asJhgrlg8QblbzQnYPYsYP6W10ybj9Sk5mFHPlbL2GNNPPUV3SjR64B
 bO6tF0bdR+d5kNVg7jxtoTtAmLZTFTtxHnxGASxrJocM4utlqtO9lwm4Tn3WqPPzIib21EYrSeb9
 ysllyYK3RvQUv6pN4mL2+jqfUEJwgaEcuZ5pY+4rqlPcDfzudlYW5uyGGvADxEPUs8reRsSQ6gFN
 SUFWF5nPBPH11aHIiOOZLdelPgOTDaBX2Q7KKw9ikcTGhpt3w9Eh/ZvuOuRp3ZmLsZ4OvjzqWsGj
 mvXDUu9CCTrNaHnIsj+SE6Q/m61o6VIN3V2nBAvabmWcmnES9oL2v4I2lVTJONVPo1RdYuL9rfn9
 3o4GFd0dh25gEwIH4ni/k7Fgb0VyDmrO3N67orFZU+ZRre8OmZh6c703LAEQuudYw2fNs4OTG01Z
 1cB5A4LrW/MXq6UXeIIFz3N2sJpltKcLr0KXHzmaKVXLgPz3BofifD4AIJ2KvI62xkYq3g4u2O0P
 9fJd8tbCKQvXn5dMIVRFCYRMg6iqXIoPv36ppuKACUb9odONdrXQYXLXnMA3m+olRmhh+BFF+q2n
 IJj36mMyeyLo3lbigjOBAMGS9aErJbFXHa9ztJX7ypWr3DKKsof3HrIcLNzlJtLphLycaD1muTbv
 whxNNvYHg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <612801ab4d81b2767cfc30024163c6e5b062cf4f.camel@qq.com>
Subject: Re: [PATCH] arm/cpu: revises cortex-r5
From: Yanfeng Liu <yfliu2008@qq.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@wdc.com
Date: Thu, 30 Jan 2025 19:48:13 +0800
In-Reply-To: <67dbc202-7b6d-4bf4-8d18-2ba78f39a287@linaro.org>
References: <tencent_033217F7900714A999352724A7790C3F0007@qq.com>
 <67dbc202-7b6d-4bf4-8d18-2ba78f39a287@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.44; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_PBL=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 2025-01-27 at 09:03 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> On 26/1/25 12:43, Yanfeng Liu wrote:
> > From: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
> >=20
> > This enables generic timer feature for Cortex-R5 so that to support gue=
sts
> > like NuttX RTOS.
>=20
> QEMU aims to model CPU faithful to hardware, than the R5
> doesn't has generic timer.
>=20
Okay, I see.

>=20
> Maybe you want to use the Cortex-R52 instead? I see NuttX supports it:
> https://nuttx.apache.org/docs/latest/platforms/arm/fvp-v8r-aarch32/boards=
/fvp-armv8r-aarch32/index.html
>=20

Thanks for mentioning this, both commit logs and docs say the r52 support i=
s for
FVP simulator, not for QEMU. Also the MPU memory model support is still mis=
sing.

Is it proper to use Cortex-R52 on `virt` board? I am currently using CR5 on
`virt` board to share some code base of armv7-a support.

> If it works for you, could you add a test for NuttX on Cortex-R52?
> See for example tests/functional/test_avr_mega2560.py
>=20
>=20

I don't know how a FVP guest can help on QEMU testing. But from the sample =
test
you shared, it seems that a NuttX image URL is needed to create a test case=
.
That won't be an issue as NuttX images are small and we can have different
images for plain flat memory model, MPU isolated memory model and MMU mappe=
d
memory model if needed.=20

If using cortex-r52 on `virt` board is allowed, I may add a NuttX port and =
share
a binary image URL for a QEMU test case later.

> Thanks!
>=20
> Regards,
>=20
> Phil.
>=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
> > =C2=A0 target/arm/tcg/cpu32.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> > index 2ad2182525..5d68d515b4 100644
> > --- a/target/arm/tcg/cpu32.c
> > +++ b/target/arm/tcg/cpu32.c
> > @@ -590,9 +590,10 @@ static void cortex_r5_initfn(Object *obj)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_feature(&cpu->env, ARM_FEATURE_V7MP)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_feature(&cpu->env, ARM_FEATURE_PMSA)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_feature(&cpu->env, ARM_FEATURE_PMU);
> > +=C2=A0=C2=A0=C2=A0 set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->midr =3D 0x411fc153; /* r1p3 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->isar.id_pfr0 =3D 0x0131;
> > -=C2=A0=C2=A0=C2=A0 cpu->isar.id_pfr1 =3D 0x001;
> > +=C2=A0=C2=A0=C2=A0 cpu->isar.id_pfr1 =3D 0x10001;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->isar.id_dfr0 =3D 0x010400;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->id_afr0 =3D 0x0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->isar.id_mmfr0 =3D 0x0210030;


