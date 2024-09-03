Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4711BCD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slP3Z-0004GO-QP; Tue, 03 Sep 2024 04:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slP3X-000471-KE; Tue, 03 Sep 2024 04:38:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slP3V-0008KC-MO; Tue, 03 Sep 2024 04:38:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wyf7Z4NT3z6K8WL;
 Tue,  3 Sep 2024 16:34:50 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 36AC1140B63;
 Tue,  3 Sep 2024 16:38:26 +0800 (CST)
Received: from localhost (10.47.30.99) by lhrpeml500006.china.huawei.com
 (7.191.161.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 09:38:25 +0100
Date: Tue, 3 Sep 2024 09:38:20 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <Jonathan.Cameron@Huawei.com>,
 <alex.bennee@linaro.org>, <jiangkunkun@huawei.com>
Subject: Re: [PATCH v3] target/arm/tcg: refine cache descriptions with a
 wrapper
Message-ID: <20240903093820.00004693@huawei.com>
In-Reply-To: <f4cd3718-5775-4d88-92f4-48427895d4f2@linaro.org>
References: <20240902203211.270-1-alireza.sanaee@huawei.com>
 <f4cd3718-5775-4d88-92f4-48427895d4f2@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.47.30.99]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 3 Sep 2024 00:11:04 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> Hi Alireza,
>=20
> On 2/9/24 22:32, Alireza Sanaee wrote:
> > This patch allows for easier manipulation of the cache description
> > register, CCSIDR. Which is helpful for testing as well. Currently,
> > numbers get hard-coded and might be prone to errors.
> >=20
> > Therefore, this patch adds a wrapper for different types of CPUs
> > available in tcg to decribe caches. One function `make_ccsidr`
> > supports two cases by carrying a parameter as FORMAT that can be
> > LEGACY and CCIDX which determines the specification of the register.
> >=20
> > For CCSIDR register, 32 bit version follows specification [1].
> > Conversely, 64 bit version follows specification [2]. =20
>=20
> ---
>=20
> [cut]
>=20
> > Changes from v2 [3] -> v3:
> >=20
> > 1) add only one function instead of ccsidr32 and ccsidr64
> > 2) use deposit32 and deposit64 in ccsidr function
> >  =20
> ---
>=20
> > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > edition, https://developer.arm.com/documentation/ddi0406
> > [2] D23.2.29, ARM Architecture Reference Manual for A-profile
> > Architecture, https://developer.arm.com/documentation/ddi0487/latest/ =
=20
>=20
> ---
>=20
> [cut]
>=20
> > [3] https://lore.kernel.org/qemu-devel/20240830184713.224-1-alireza.san=
aee@huawei.com/
> >  =20
>=20
> ---
>=20
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >   target/arm/cpu-features.h |  50 ++++++++++++++++++
> >   target/arm/cpu64.c        |  19 ++++---
> >   target/arm/tcg/cpu64.c    | 108
> > +++++++++++++++++++------------------- 3 files changed, 117
> > insertions(+), 60 deletions(-)
> >=20
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index c59ca104fe..ef40b0dfdc 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -1022,6 +1022,56 @@ static inline bool
> > isar_feature_any_evt(const ARMISARegisters *id) return
> > isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id); }
> >  =20
> > +typedef enum {
> > +    CCSIDR_FORMAT_LEGACY,
> > +    CCSIDR_FORMAT_CCIDX,
> > +} CCSIDRFormat;
> > +
> > +static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned
> > assoc,
> > +                                   unsigned linesize, unsigned
> > cachesize,
> > +                                   uint8_t flags)
> > +{
> > +    unsigned lg_linesize =3D ctz32(linesize);
> > +    unsigned sets;
> > +    uint32_t ccsidr32 =3D 0;
> > +    uint64_t ccsidr64 =3D 0; =20
>=20
> deposit32() works with unsigned so you can use 'uint64_t ccsidr' for
> both cases and return once.
>=20
> > +
> > +    assert(assoc !=3D 0);
> > +    assert(is_power_of_2(linesize)); =20
>=20
> As mentioned in v2, if you insist in using an inlined method, you have
> to include "qemu/host-utils.h" to get is_power_of_2() declaration.
>=20
> If the inlining is proven problematic later we can still un-inline
> it, so as this is an useful cleanup (preferably with one 'ccsidr'
> variable and the include):
>=20

Hi. sure! that makes sense. applied those two changes in v4. sorry for
missing out the comment on v2.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20
> > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > +
> > +    /* sets * associativity * linesie =3D=3D cachesize. */
> > +    sets =3D cachesize / (assoc * linesize);
> > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > +
> > +    if (format =3D=3D CCSIDR_FORMAT_LEGACY) {
> > +        /*
> > +         * The 32-bit CCSIDR format is:
> > +         *   [27:13] number of sets - 1
> > +         *   [12:3]  associativity - 1
> > +         *   [2:0]   log2(linesize) - 4
> > +         *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D=
 64
> > bytes, etc
> > +         */
> > +        ccsidr32 =3D deposit32(ccsidr32, 28,  4, flags);
> > +        ccsidr32 =3D deposit32(ccsidr32, 13, 15, sets - 1);
> > +        ccsidr32 =3D deposit32(ccsidr32,  3, 10, assoc - 1);
> > +        ccsidr32 =3D deposit32(ccsidr32,  0,  3, lg_linesize - 4);
> > +        return (uint64_t)ccsidr32;
> > +    } else {
> > +        /*
> > +         * The 64-bit CCSIDR_EL1 format is:
> > +         *   [55:32] number of sets - 1
> > +         *   [23:3]  associativity - 1
> > +         *   [2:0]   log2(linesize) - 4
> > +         *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D=
 64
> > bytes, etc
> > +         */
> > +        ccsidr64 =3D deposit64(ccsidr64, 32, 24, sets - 1);
> > +        ccsidr64 =3D deposit64(ccsidr64,  3, 21, assoc - 1);
> > +        ccsidr64 =3D deposit64(ccsidr64,  0,  3, lg_linesize - 4);
> > +        return ccsidr64;
> > +    }
> > +} =20
>=20


