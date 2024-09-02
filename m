Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD828CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 11:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4xQ-0004xK-17; Mon, 02 Sep 2024 07:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sl4x7-0004f8-EO; Mon, 02 Sep 2024 07:10:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sl4x2-0005E2-R7; Mon, 02 Sep 2024 07:10:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wy5Yc3LFTz6LDBK;
 Mon,  2 Sep 2024 19:07:00 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FF2E140A35;
 Mon,  2 Sep 2024 19:10:24 +0800 (CST)
Received: from localhost (10.47.78.245) by lhrpeml500006.china.huawei.com
 (7.191.161.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 12:10:23 +0100
Date: Mon, 2 Sep 2024 12:10:18 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@huawei.com>, <jiangkunkun@huawei.com>
Subject: Re: [PATCH v2] target/arm/tcg: refine cache descriptions with a
 wrapper
Message-ID: <20240902121018.00006eb6@huawei.com>
In-Reply-To: <CAFEAcA90iqLv0OYs5U0L474C1vP0qvh57i8XWe+=WVfOGshQbQ@mail.gmail.com>
References: <20240830184713.224-1-alireza.sanaee@huawei.com>
 <6bed13cc-fe6e-40ec-93af-1723bf46a6c3@linaro.org>
 <CAFEAcA90iqLv0OYs5U0L474C1vP0qvh57i8XWe+=WVfOGshQbQ@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.47.78.245]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Sep 2024 11:25:36 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 2 Sept 2024 at 11:07, Philippe Mathieu-Daud=E9
> <philmd@linaro.org> wrote:
> >
> > Hi Alireza,
> >
> > On 30/8/24 20:47, Alireza Sanaee via wrote: =20
> > > This patch allows for easier manipulation of the cache description
> > > register, CCSIDR. Which is helpful for testing as well. Currently
> > > numbers get hard-coded and might be prone to errors.
> > >
> > > Therefore, this patch adds wrappers for different types of CPUs
> > > available in tcg to decribe caches. Two functions `make_ccsidr32`
> > > and `make_ccsidr64` describing descriptions. The 32 bit version
> > > receives extra parameters that became unknown later in 64 bit.
> > >
> > > For CCSIDR register, 32 bit version follows specification [1].
> > > Conversely, 64 bit version follows specification [2].
> > >
> > > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > > edition, https://developer.arm.com/documentation/ddi0406
> > > [2] D23.2.29, ARM Architecture Reference Manual for A-profile
> > > Architecture, https://developer.arm.com/documentation/ddi0487/latest/
> > >
> > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > ---
> > >   target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
> > >   target/arm/cpu64.c        | 19 ++++++---
> > >   target/arm/tcg/cpu64.c    | 86
> > > ++++++++++++++++++--------------------- 3 files changed, 105
> > > insertions(+), 53 deletions(-)
> > >
> > > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > > index c59ca104fe..00a0f0d963 100644
> > > --- a/target/arm/cpu-features.h
> > > +++ b/target/arm/cpu-features.h
> > > @@ -1022,6 +1022,59 @@ static inline bool
> > > isar_feature_any_evt(const ARMISARegisters *id) return
> > > isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id); }
> > >
> > > +static inline uint64_t make_ccsidr32(unsigned assoc, unsigned
> > > linesize,
> > > +                                     unsigned cachesize, uint8_t
> > > flags) +{
> > > +    unsigned lg_linesize =3D ctz32(linesize);
> > > +    unsigned sets;
> > > +
> > > +    /*
> > > +     * The 32-bit CCSIDR_EL1 format is:
> > > +     *   [27:13] number of sets - 1
> > > +     *   [12:3]  associativity - 1
> > > +     *   [2:0]   log2(linesize) - 4
> > > +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 6=
4 bytes,
> > > etc
> > > +     */
> > > +    assert(assoc !=3D 0);
> > > +    assert(is_power_of_2(linesize));
> > > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > > +
> > > +    /* sets * associativity * linesize =3D=3D cachesize. */
> > > +    sets =3D cachesize / (assoc * linesize);
> > > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > > +
> > > +    return ((uint64_t)(flags) << 28)
> > > +        | ((sets - 1) << 13)
> > > +        | ((assoc - 1) << 3)
> > > +        | (lg_linesize - 4);
> > > +}
> > > +
> > > +static inline uint64_t make_ccsidr64(unsigned assoc, unsigned
> > > linesize,
> > > +                              unsigned cachesize)
> > > +{
> > > +    unsigned lg_linesize =3D ctz32(linesize);
> > > +    unsigned sets;
> > > +
> > > +    /*
> > > +     * The 64-bit CCSIDR_EL1 format is:
> > > +     *   [55:32] number of sets - 1
> > > +     *   [23:3]  associativity - 1
> > > +     *   [2:0]   log2(linesize) - 4
> > > +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 6=
4 bytes,
> > > etc
> > > +     */
> > > +    assert(assoc !=3D 0);
> > > +    assert(is_power_of_2(linesize));
> > > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > > +
> > > +    /* sets * associativity * linesize =3D=3D cachesize. */
> > > +    sets =3D cachesize / (assoc * linesize);
> > > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > > +
> > > +    return ((uint64_t)(sets - 1) << 32)
> > > +         | ((assoc - 1) << 3)
> > > +         | (lg_linesize - 4);
> > > +}
> > > +
> > >   /*
> > >    * Forward to the above feature tests given an ARMCPU pointer.
> > >    */
> > > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > > index 262a1d6c0b..57ebc1b979 100644
> > > --- a/target/arm/cpu64.c
> > > +++ b/target/arm/cpu64.c
> > > @@ -23,6 +23,7 @@
> > >   #include "cpu.h"
> > >   #include "cpregs.h"
> > >   #include "qemu/module.h"
> > > +#include "qemu/units.h"
> > >   #include "sysemu/kvm.h"
> > >   #include "sysemu/hvf.h"
> > >   #include "sysemu/qtest.h"
> > > @@ -642,9 +643,12 @@ static void aarch64_a57_initfn(Object *obj)
> > >       cpu->isar.dbgdevid1 =3D 0x2;
> > >       cpu->isar.reset_pmcr_el0 =3D 0x41013000;
> > >       cpu->clidr =3D 0x0a200023;
> > > -    cpu->ccsidr[0] =3D 0x701fe00a; /* 32KB L1 dcache */
> > > -    cpu->ccsidr[1] =3D 0x201fe012; /* 48KB L1 icache */
> > > -    cpu->ccsidr[2] =3D 0x70ffe07a; /* 2048KB L2 cache */
> > > +    /* 32KB L1 dcache */
> > > +    cpu->ccsidr[0] =3D make_ccsidr32(4, 64, 32 * KiB, 7);
> > > +    /* 48KB L1 icache */
> > > +    cpu->ccsidr[1] =3D make_ccsidr32(3, 64, 48 * KiB, 2);
> > > +    /* 2048KB L2 cache */
> > > +    cpu->ccsidr[2] =3D make_ccsidr32(16, 64, 2 * MiB, 7); =20
> >
> > I like the uses of make_ccsidrXX() instead of the magic values.
> >
> > I don't like much the code duplication between make_ccsidrXX()
> > definitions, I'd prefer both call a common (static?) one. =20
>=20
> How about we have
> typedef enum {
>     CCSIDR_FORMAT_LEGACY,
>     CCSIDR_FORMAT_CCIDX,
> } CCSIDRFormat;
>=20
> and a single
> uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc, unsigned
>                      linesize, unsigned cachesize, unsigned flags);
>=20
> ? Since the only difference between the two functions is the final
> line that assembles the return value, that seems like maybe
> a better way to avoid the code duplication than a common
> sub-function.
>=20
> -- PMM

I like this suggestion. I can address Philippe's concern too if I move
functions around. I thought a bit how to avoid duplication then I ended
up saying let's see what others might say.

Alireza

