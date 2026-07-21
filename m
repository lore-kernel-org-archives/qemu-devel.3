Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3806C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7m8-0003R4-Mk; Tue, 21 Jul 2026 06:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wm7m6-0003QB-Cc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:32:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wm7m4-0001iS-Jy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:32:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47640541585so5708503f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784629950; x=1785234750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EDrSaLftjUF53HXxUXoW3+xDvpx4XYBMvXLXpW72g2s=;
 b=IacdHSZXKM7FxR1wnStgS7elW4KjrtJV59XDpgcYl0k4D5EWlkZ+7pHYWP4vTiwaBA
 JbxSHC2yQlTKUtnWnyPlYspEuPeNsrCfRwdwn7FlkEExhRcjv7pVEHxDHc930HY93Z7d
 4N6kXrgVbKoOgd8WubpVeyZIKmMjCbmEIsFhBhwBXJwp/S5wPLxB+8nImwBiEMrBivG8
 +zQIIcPk2P5oOMs5jG8DEP4cCbbFCTAgygqEVMq+Gk37sREz0p2pw9QWw7VhrWkRfJOb
 R055QIlGpfwYtC/9Viyt3tbhy/QuguhcHJhOX0K7qMVjvNME3f72Q0KRMUPUB1skGhL8
 PKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629950; x=1785234750;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EDrSaLftjUF53HXxUXoW3+xDvpx4XYBMvXLXpW72g2s=;
 b=Q3HvCbwmLpL/GhjsJmpMWPH+PiFax9TObrFmFTFVwbqnCj1Y3zJN4gnZ8xiftDLgWS
 K/GBYHaXkMGE7+217Rgt0RduVFegzUOS+AQQFvx6/KIBPfN8lU+Ws/hJfnN61Qsm4wWm
 KLgRmxuhMwx2u2+Z/zy0vX78wQkJwjF8cguRDUTGty+r2LvEi7aVr8Bw8zvCUON0P8ok
 7Wy2tbjZqOJqIgG9JQ0r9lHwKwg0+ALbs9d85UNdnGhsgexPN+16d3F0fdkHYqlcmrrq
 OPvfIduAU5B3kabHhpbcXZDY0RFbB6KFDYhJAsskb4zJpqe0oGyW7yMiYh1kXBMYkHfh
 +Dmw==
X-Gm-Message-State: AOJu0YzTTTdmP6xOiFx4stteUnWuxErSwnhKrvJ4mGJwjuKGS1WQGiM1
 Kb4cEP+JczrxlWntc/3ACSY40bzgA0hK1dPr5+jmVf2u6UJMqcC8MjML/wuD7g==
X-Gm-Gg: AR+sD13iEwe29ldxEANwLJLy4LjMiACXVLGeObvvPdbW7g2uHUTYvyKNcSwhs4vHxbK
 5lVkzxaS/gbh7uwl+CHJbmAoW/KXDTbZXgofwTvKMANC8M586FpE3T0p0jLgZf11iqUZd44FHwr
 v3Vng4tvE8quUlKiEVies6l626XCjmYxnTGGANb+1asHm6liiQb6cQQ5WkwvttAOp1lXpbXdv88
 2VFjRFLALhkdrqM/mPbDHwpiAy7dyJ8mevQ3p8NX1Xc1KcfA2P9xuuJQgUNAUUx/FfYC0E8Httg
 Rph+Tz65QCusZjQi29EcFaD68jEVHqYjhMJkZOQ9kSzq1c3FQwtjBk8HWanGpigixNloLrhG/tL
 8b2ON6vmyoy2Wy9baTziJ060dtYwhcbgCkC7zqmRR/pu7CKsWyyGaoD265/IAQQyORjOKFAWcmw
 Fle1hqumCq1eb6eX6pkA==
X-Received: by 2002:a5d:5f94:0:b0:47f:5289:d5e1 with SMTP id
 ffacd0b85a97d-47f62337871mr20178992f8f.37.1784629950030; 
 Tue, 21 Jul 2026 03:32:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6b85970esm31381317f8f.15.2026.07.21.03.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:32:29 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:29:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
In-Reply-To: <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
 <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
 <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
Message-ID: <D1B4AD96-B24C-4448-9B83-8D319997E768@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 21=2E Juli 2026 08:38:19 UTC schrieb Bin Meng <bmeng=2Ecn@gmail=2Ecom>:
>Hi Bernhard,
>
>On Tue, Jul 21, 2026 at 5:11=E2=80=AFAM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>
>>
>>
>> Am 20=2E Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng=2Ecn@gmail=2Eco=
m>:
>>
>> Hi Bin,
>>
>> Thanks for yor reviews and R-b tags!
>>
>> >On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmai=
l=2Ecom> wrote:
>> >>
>> >> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() whi=
le
>> >> the eSDHC code path uses the standard SDHC interface=2E Extract the =
quirk
>> >> into a new `usdhc_write()` function=2E
>> >>
>> >> Fixes file system corruption on emulated i=2EMX53 where Linux'
>> >> esdhc_is_usdhc() returns false=2E The same likely happens on e500 an=
d
>> >> imx25-pdk machines=2E
>> >>
>> >> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
>> >> cc: qemu-stable
>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> ---
>> >>  hw/sd/sdhci=2Ec | 73 +++++++++++++++++++++++++++++++---------------=
-----
>> >>  1 file changed, 44 insertions(+), 29 deletions(-)
>> >>
>> >> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>> >> index c86dfa281f=2E=2Ee58a610397 100644
>> >> --- a/hw/sd/sdhci=2Ec
>> >> +++ b/hw/sd/sdhci=2Ec
>> >> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint=
64_t val, unsigned size)
>> >>          sdhci_write(opaque, offset, value, size);
>> >>          break;
>> >>
>> >> -    case ESDHC_MIX_CTRL:
>> >> -        /*
>> >> -         * So, when SD/MMC stack in Linux tries to write to "Transf=
er
>> >> -         * Mode Register", ESDHC i=2EMX quirk code will translate i=
t
>> >> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>> >> -         * order to get where we started
>> >> -         *
>> >> -         * Note that Auto CMD23 Enable bit is located in a wrong pl=
ace
>> >> -         * on i=2EMX, but since it is not used by QEMU we do not ca=
re=2E
>> >> -         *
>> >> -         * We don't want to call sdhci_write(=2E=2E, SDHC_TRNMOD, =
=2E=2E=2E)
>> >> -         * here because it will result in a call to
>> >> -         * sdhci_send_command(s) which we don't want=2E
>> >> -         *
>> >> -         */
>> >> -        s->trnmod =3D value & UINT16_MAX;
>> >> -        break;
>> >> -    case SDHC_TRNMOD:
>> >
>> >Looks like this register is not eSDHC specific?
>>
>> Not quite sure what you mean exactly=2E The SDHC_TRNMOD isn't eSDHC spe=
cific but as per the comment above trnmod partial handling is deferred here=
, i=2Ee=2E needs to be intercepted=2E
>
>If I read the Linux driver correctly, I think we should do something
>like below when writing to SDHC_TRNMOD:
>
>  case SDHC_TRNMOD:
>      if (is_usdhc) {
>          val |=3D s->trnmod;
>      }
>      sdhci_write(opaque, offset, val, size);
>      break;
>
>Because for eSDHC, the transfer mode is already passed in the value,
>and oring previous s->trnmod may cause some bits being set to old
>previous value unexpectedly=2E Please double check=2E

By moving out of esdhc_write() into a dedicated usdhc_write() method we ac=
hieve exactly that, no?

Best regards,
Bernhard

>
>>
>> >I looked at linux
>> >driver source codes and suspect we may need some more turning here
>> >other than uSDHC only=2E
>>
>> Yeah, there is certainly a lot of room for improvement=2E I have some c=
lock-related and SDMA buffer boundary patches in the pipeline which are nec=
essary for satisfying U-Boot=2E But that's a story for another day=2E
>>
>> Best regards,
>> Bernhard
>>
>> >
>> >
>> >> -        /*
>> >> -         * Similar to above, but this time a write to "Command
>> >> -         * Register" will be translated into a 4-byte write to
>> >> -         * "Transfer Mode register" where lower 16-bit of value wou=
ld
>> >> -         * be set to zero=2E So what we do is fill those bits with
>> >> -         * cached value from s->trnmod and let the SDHCI
>> >> -         * infrastructure handle the rest
>> >> -         */
>> >> -        sdhci_write(opaque, offset, val | s->trnmod, size);
>> >> -        break;
>> >>      case SDHC_BLKSIZE:
>> >>          /*
>> >>           * ESDHCI does not implement "Host SDMA Buffer Boundary", a=
nd
>> >> @@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
>> >>      qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>> >>  }
>> >>
>> >> +static void
>> >> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned siz=
e)
>> >> +{
>> >> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>> >> +    uint32_t value =3D (uint32_t)val;
>> >> +
>> >> +    switch (offset) {
>> >> +    case ESDHC_MIX_CTRL:
>> >> +        /*
>> >> +         * So, when SD/MMC stack in Linux tries to write to "Transf=
er
>> >> +         * Mode Register", uSDHC i=2EMX quirk code will translate i=
t
>> >> +         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>> >> +         * order to get where we started=2E
>> >> +         *
>> >> +         * Note that Auto CMD23 Enable bit is located in a wrong pl=
ace
>> >> +         * on i=2EMX, but since it is not used by QEMU we do not ca=
re=2E
>> >> +         *
>> >> +         * We don't want to call sdhci_write(=2E=2E, SDHC_TRNMOD, =
=2E=2E=2E)
>> >> +         * here because it will result in a call to
>> >> +         * sdhci_send_command(s) which we don't want=2E
>> >> +         *
>> >> +         */
>> >> +        s->trnmod =3D value & UINT16_MAX;
>> >> +        break;
>> >> +
>> >> +    case SDHC_TRNMOD:
>> >> +        /*
>> >> +         * Similar to above, but this time a write to "Command
>> >> +         * Register" will be translated into a 4-byte write to
>> >> +         * "Transfer Mode register" where lower 16-bit of value wou=
ld
>> >> +         * be set to zero=2E So what we do is fill those bits with
>> >> +         * cached value from s->trnmod and let the SDHCI
>> >> +         * infrastructure handle the rest
>> >> +         */
>> >> +        sdhci_write(opaque, offset, val | s->trnmod, size);
>> >> +        break;
>> >> +
>> >> +    default:
>> >> +        esdhc_write(opaque, offset, val, size);
>> >> +        break;
>> >> +    }
>> >> +}
>> >> +
>> >>  static const MemoryRegionOps usdhc_mmio_ops =3D {
>> >>      =2Eread =3D esdhc_read,
>> >> -    =2Ewrite =3D esdhc_write,
>> >> +    =2Ewrite =3D usdhc_write,
>> >>      =2Evalid =3D {
>> >>          =2Emin_access_size =3D 1,
>> >>          =2Emax_access_size =3D 4,
>> >> --
>
>Regards,
>Bin

