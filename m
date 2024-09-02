Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACD2CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4GB-00038n-1A; Mon, 02 Sep 2024 06:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl4G8-00035s-Jh
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:26:09 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sl4G2-00085s-3N
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:26:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b6so3927912a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725272748; x=1725877548; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQvFp2rYegFxVLMETW0mIch92xTcCNBK+983G9O/Zt4=;
 b=Y3ceEEH+u9sxCT/SvN03yc75vgugFNUbOXvRIDIJHsDK72FxpsaYTbI3QrZTuJE6DV
 bGklWW4vXoYWYn+M8fcJzWidxsD1+ZdvY9wSY7oPNVPRaiKkLzsuNYm3bq/yFlnzWiJM
 GJC0j3CCwkO3J9Ij1FueCP1hfCk/ckmXjQAu49u+IKYBTHPev1TSL0jejL/E7WQ9KwC9
 B+iC6H/BRr3ODrgUaI//6jNHOC/BGbUm6aJagCmkO11QsYMO0i690OORLS7xbs/dvmXx
 K7YMeSd7zyf1OYiUqNwjuEqU3ip8tIKqh1E2+Md5aDQ5Ik39lqKUPuZInAlnTV9L6z8k
 W7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725272748; x=1725877548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQvFp2rYegFxVLMETW0mIch92xTcCNBK+983G9O/Zt4=;
 b=f6QrVD8zS3JyYRL39b8kqvkrAhS+p/rtLddBzmT1PN4ebqT5HWeMxzgd0dTL8dYkcC
 v59UIg3uAnhysfKZoSb76vegrmzp3MeG2EnEKlZe79PFLZSezzhUnAxEq+shHoDe7/Gx
 4CXF0cY0y4cx/CVDwSlyHfbLugVNISMCNkurYJd9vVH9TXiIFzWamj8H2w4R808/JBIG
 /t/PsKjIhBLjx2KIwVhn5r90seqkFT1P73KIis7A+aaoks859qCnvXY4I5PsO9HjuRyZ
 6gJyeQBAe21R621rqFiLo3gspf6Zs8r22dEkBfccTG2jda3bSP7O724mbwqy79yRknb4
 WmHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmlZAK39VeiATmv+wN52aXIE4yOt+GTZ4lGCM/H9PRtPBUSF8Xey6JH6GOsEC3L0UF6WD6ZJkiTXmB@nongnu.org
X-Gm-Message-State: AOJu0YyreF4fUrApBu4TA+Whypms2opMDJ0taPpCmvVV1wiu9b7F2u9S
 cWeQ1znZy/HhkOoBZKmdW6fz8iw0nJVH08wZcOw9z4RgTk2s4qkbqkiQChG0athmC5HbZnRka86
 r4Y4uJmt05dgbaeGzOH+5ak+lQDWEn1yrVMuzZLaC/mmK5BGq
X-Google-Smtp-Source: AGHT+IFJJlWHkIK3T2Iwz2tPBUenxXdK0u/FfkQO88Bn3FAkDlpe917rsfcPM17Qmkb31Rp5me2UpMOpxXW/snL559w=
X-Received: by 2002:a05:6402:510a:b0:5c2:467a:183e with SMTP id
 4fb4d7f45d1cf-5c2467a1c24mr3356115a12.3.1725272747803; Mon, 02 Sep 2024
 03:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240830184713.224-1-alireza.sanaee@huawei.com>
 <6bed13cc-fe6e-40ec-93af-1723bf46a6c3@linaro.org>
In-Reply-To: <6bed13cc-fe6e-40ec-93af-1723bf46a6c3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Sep 2024 11:25:36 +0100
Message-ID: <CAFEAcA90iqLv0OYs5U0L474C1vP0qvh57i8XWe+=WVfOGshQbQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm/tcg: refine cache descriptions with a
 wrapper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, linuxarm@huawei.com, richard.henderson@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com, 
 jiangkunkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Sept 2024 at 11:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Alireza,
>
> On 30/8/24 20:47, Alireza Sanaee via wrote:
> > This patch allows for easier manipulation of the cache description
> > register, CCSIDR. Which is helpful for testing as well. Currently
> > numbers get hard-coded and might be prone to errors.
> >
> > Therefore, this patch adds wrappers for different types of CPUs
> > available in tcg to decribe caches. Two functions `make_ccsidr32` and
> > `make_ccsidr64` describing descriptions. The 32 bit version receives
> > extra parameters that became unknown later in 64 bit.
> >
> > For CCSIDR register, 32 bit version follows specification [1].
> > Conversely, 64 bit version follows specification [2].
> >
> > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > edition, https://developer.arm.com/documentation/ddi0406
> > [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architect=
ure,
> > https://developer.arm.com/documentation/ddi0487/latest/
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >   target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
> >   target/arm/cpu64.c        | 19 ++++++---
> >   target/arm/tcg/cpu64.c    | 86 ++++++++++++++++++--------------------=
-
> >   3 files changed, 105 insertions(+), 53 deletions(-)
> >
> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> > index c59ca104fe..00a0f0d963 100644
> > --- a/target/arm/cpu-features.h
> > +++ b/target/arm/cpu-features.h
> > @@ -1022,6 +1022,59 @@ static inline bool isar_feature_any_evt(const AR=
MISARegisters *id)
> >       return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
> >   }
> >
> > +static inline uint64_t make_ccsidr32(unsigned assoc, unsigned linesize=
,
> > +                                     unsigned cachesize, uint8_t flags=
)
> > +{
> > +    unsigned lg_linesize =3D ctz32(linesize);
> > +    unsigned sets;
> > +
> > +    /*
> > +     * The 32-bit CCSIDR_EL1 format is:
> > +     *   [27:13] number of sets - 1
> > +     *   [12:3]  associativity - 1
> > +     *   [2:0]   log2(linesize) - 4
> > +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 64 =
bytes, etc
> > +     */
> > +    assert(assoc !=3D 0);
> > +    assert(is_power_of_2(linesize));
> > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > +
> > +    /* sets * associativity * linesize =3D=3D cachesize. */
> > +    sets =3D cachesize / (assoc * linesize);
> > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > +
> > +    return ((uint64_t)(flags) << 28)
> > +        | ((sets - 1) << 13)
> > +        | ((assoc - 1) << 3)
> > +        | (lg_linesize - 4);
> > +}
> > +
> > +static inline uint64_t make_ccsidr64(unsigned assoc, unsigned linesize=
,
> > +                              unsigned cachesize)
> > +{
> > +    unsigned lg_linesize =3D ctz32(linesize);
> > +    unsigned sets;
> > +
> > +    /*
> > +     * The 64-bit CCSIDR_EL1 format is:
> > +     *   [55:32] number of sets - 1
> > +     *   [23:3]  associativity - 1
> > +     *   [2:0]   log2(linesize) - 4
> > +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 64 =
bytes, etc
> > +     */
> > +    assert(assoc !=3D 0);
> > +    assert(is_power_of_2(linesize));
> > +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> > +
> > +    /* sets * associativity * linesize =3D=3D cachesize. */
> > +    sets =3D cachesize / (assoc * linesize);
> > +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> > +
> > +    return ((uint64_t)(sets - 1) << 32)
> > +         | ((assoc - 1) << 3)
> > +         | (lg_linesize - 4);
> > +}
> > +
> >   /*
> >    * Forward to the above feature tests given an ARMCPU pointer.
> >    */
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 262a1d6c0b..57ebc1b979 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -23,6 +23,7 @@
> >   #include "cpu.h"
> >   #include "cpregs.h"
> >   #include "qemu/module.h"
> > +#include "qemu/units.h"
> >   #include "sysemu/kvm.h"
> >   #include "sysemu/hvf.h"
> >   #include "sysemu/qtest.h"
> > @@ -642,9 +643,12 @@ static void aarch64_a57_initfn(Object *obj)
> >       cpu->isar.dbgdevid1 =3D 0x2;
> >       cpu->isar.reset_pmcr_el0 =3D 0x41013000;
> >       cpu->clidr =3D 0x0a200023;
> > -    cpu->ccsidr[0] =3D 0x701fe00a; /* 32KB L1 dcache */
> > -    cpu->ccsidr[1] =3D 0x201fe012; /* 48KB L1 icache */
> > -    cpu->ccsidr[2] =3D 0x70ffe07a; /* 2048KB L2 cache */
> > +    /* 32KB L1 dcache */
> > +    cpu->ccsidr[0] =3D make_ccsidr32(4, 64, 32 * KiB, 7);
> > +    /* 48KB L1 icache */
> > +    cpu->ccsidr[1] =3D make_ccsidr32(3, 64, 48 * KiB, 2);
> > +    /* 2048KB L2 cache */
> > +    cpu->ccsidr[2] =3D make_ccsidr32(16, 64, 2 * MiB, 7);
>
> I like the uses of make_ccsidrXX() instead of the magic values.
>
> I don't like much the code duplication between make_ccsidrXX()
> definitions, I'd prefer both call a common (static?) one.

How about we have
typedef enum {
    CCSIDR_FORMAT_LEGACY,
    CCSIDR_FORMAT_CCIDX,
} CCSIDRFormat;

and a single
uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc, unsigned
                     linesize, unsigned cachesize, unsigned flags);

? Since the only difference between the two functions is the final
line that assembles the return value, that seems like maybe
a better way to avoid the code duplication than a common
sub-function.

-- PMM

