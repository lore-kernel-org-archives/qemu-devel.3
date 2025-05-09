Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D44BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 04:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDExP-0007kO-Ur; Fri, 09 May 2025 00:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uDExI-0007Ug-Ln; Fri, 09 May 2025 00:03:27 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uDExG-0006L8-Rm; Fri, 09 May 2025 00:03:24 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2da73155e91so821365fac.0; 
 Thu, 08 May 2025 21:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746763400; x=1747368200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsjDG0nHSiq/M+CBSiIQRA7HVERH5CerMo4pHsZ55vE=;
 b=Pgf0ce5KAyJryCE+W1w7X0sD1Sn0wY9n9bXFTqARAlgG8YTvQ35vCwDP7c7eM+dZRE
 P4Ft8g5kPsPlSFZA45AYb6AGbuMQfxX1skU62V7gpCNWpRNhHAR7Q0/PAlSIAvf2VN0x
 Nd5BwDj8VdTuXQcoM0+bdIFLzbgrc7DRWJq6HP2W8FKeefH1ha+J6HvGzHr3UyC7yA5E
 RVb88OREO12A6BhKFESux0q/eF5hT/K7E63xOiZfgTVXzAXFyKPT4XvDzvtA9ke0sqr4
 eux+wq4SGUXE1wgmldQxrqax/0WGhi6VJrqmz0C2N2hIwof2P3Wq9WEM7aKzNB1iEHpF
 pvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746763400; x=1747368200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsjDG0nHSiq/M+CBSiIQRA7HVERH5CerMo4pHsZ55vE=;
 b=K5o+UFQe9nbwBzbw+Rh9zXmfKaXZK9zLAFHW+O4DPaTEwx8tOhF/sERMfCvppfYsA5
 8ws3tWzclsdnHrtP828iqAD5VO3695k5j1CR0BAoi5rvnmscPAej0m1KBaaP8BKifHyN
 FEyIHFQg3TVpXNbHAbH08WtE18e6JNXcW+AgxMb28fV5BciHVtq3pcBvrFHuiswCWhRb
 dYINKLNesir5i4HFOJ9RoaIKZVWIPf5RvFO352xOw2/JN5PkVDvr4TMpozGg5sSDFJKN
 zbjnk34pMC2RCMDT7w+2xYi2BEOQISXIaClqxHsQg52E7/sEJsbXsIcXG8ewbiT8vFxu
 d9SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77JkT03HEyoGQg7kNP36t73Ye8I0ZXFt/AhH5dVyYEqYo4THnzJyRQZgxRah+RSYWB29pwjSBbQ==@nongnu.org,
 AJvYcCXI+EeJOZFdJ++hIL1NysmMXU2vxw+25RTaEWwQMuR0hY/Kyp9MyyKcaZLAul64pQvWlM1xcLA49tsM/A==@nongnu.org
X-Gm-Message-State: AOJu0YyoK+YwBZG2ti3B1Xxem7QRqkAVjVdGe4mUBjYZJWXN0FXl9MeA
 aVTNjWWuTOZweSBFtlverU4/dcxu9tJZ6gheoNQaUoeREWb6poLnj9dH9wO+84IOyKFVF0O2rnN
 IkB2q13P1HRmSXxGT3kLQOpn6Dek=
X-Gm-Gg: ASbGnct2FN3BrXIBKv3lzeQiTKusFCKRihsxbsVWY11axvjzyVubUSqNL8ZW0bYAVW5
 cbxUzIOlud7veFB5znMVU8c5grozWplIuRCwNrKu31cOSXO4FSPIDoemhMvkRg7hrgrzKQlkeA9
 HLiGU39qpfRpuquSbtbzYDQAc=
X-Google-Smtp-Source: AGHT+IGpnrYNBkLwu7YnQ4iL77seTMNr9hhwvnrhJRCqa3ave3/XSjeKfgiIt5bDmmyRzaOPdqshhZU0/RJeNkjn+Nw=
X-Received: by 2002:a05:6871:5827:b0:2d9:45b7:8ff4 with SMTP id
 586e51a60fabf-2dba44dc797mr1200738fac.26.1746763399726; Thu, 08 May 2025
 21:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250508021510.2959328-1-timlee660101@gmail.com>
 <e6b06003-7145-46d5-b19d-b9e134084fc7@linaro.org>
In-Reply-To: <e6b06003-7145-46d5-b19d-b9e134084fc7@linaro.org>
From: Tim Lee <timlee660101@gmail.com>
Date: Fri, 9 May 2025 12:03:07 +0800
X-Gm-Features: ATxdqUE9vMpx3OnCHRklfHrshdoHSn1a980W5s1w7h5pYkL3POl_iTNfJOTH3-E
Message-ID: <CAJG6D+g8dy5pgkf=V=T=7DKMOb4gEe2WHJPGYWqXMzH962aJGw@mail.gmail.com>
Subject: Re: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device
 part number
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, wuhaotsh@google.com, kfting@nuvoton.com, 
 chli30@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=timlee660101@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> =E6=96=BC 2025=E5=B9=B45=E6=
=9C=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:19=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Hi Tim,
>
> On 8/5/25 04:15, Tim Lee wrote:
> > Fix flash device part number to `mx66l1g45g` according image-bmc run on=
 npcm8xx
> > evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)
> >
> > And add auto zero flash image size to resolve error below after executi=
ng
> > `./qemu-system-aarch64 -machine npcm845-evb -drive file=3Dimage-bmc`
> >
> > Error message:
> > qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
> > requires 134217728 bytes, mtd0 block backend provides 67108864 bytes
> >
> > Tested:
> > Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normal=
ly
> >
> > Signed-off-by: Tim Lee <timlee660101@gmail.com>
> > ---
> > Changes since v1:
> > - Add a statement that checks whether the storage is writable
> >
> >   hw/arm/npcm8xx_boards.c | 20 +++++++++++++++++++-
> >   1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
> > index 3fb8478e72..79295a586c 100644
> > --- a/hw/arm/npcm8xx_boards.c
> > +++ b/hw/arm/npcm8xx_boards.c
> > @@ -27,6 +27,7 @@
> >   #include "qemu/error-report.h"
> >   #include "qemu/datadir.h"
> >   #include "qemu/units.h"
> > +#include "system/block-backend.h"
> >
> >   #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
> >
> > @@ -59,10 +60,26 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *=
fiu, int cs_no,
> >   {
> >       DeviceState *flash;
> >       qemu_irq flash_cs;
> > +    BlockBackend *blk;
> > +    BlockDriverState *bs;
> > +    uint64_t blk_size, perm, shared_perm;
> >
> >       flash =3D qdev_new(flash_type);
> >       if (dinfo) {
> >           qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo=
));
> > +        blk =3D blk_by_legacy_dinfo(dinfo);
> > +        bs =3D blk_bs(blk);
> > +        blk_size =3D blk_getlength(blk);
> > +
> > +        if (!bdrv_is_read_only(bs)) {
>
> This isn't what I meant, we'll get the same issue with read-only storage.
>
> See:
> https://lore.kernel.org/qemu-devel/CAFEAcA9itEDTrznX1KRVEza__Dch95aBpPzbd=
TJ0-tuxwiHtoQ@mail.gmail.com/
>
> > +            if (blk_size < fiu->flash_size) {
> > +                blk_get_perm(blk, &perm, &shared_perm);
> > +                blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_a=
bort);
> > +                blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE=
_OFF,
> > +                             BDRV_REQ_ZERO_WRITE, &error_abort);
> > +                blk_set_perm(blk, perm, shared_perm, &error_abort);
> > +            }
> > +        }
> >       }
> >       qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
> >
> > @@ -194,7 +211,8 @@ static void npcm845_evb_init(MachineState *machine)
> >       qdev_realize(DEVICE(soc), NULL, &error_fatal);
> >
> >       npcm8xx_load_bootrom(machine, soc);
> > -    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD=
, 0, 0));
> > +    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
> > +                          drive_get(IF_MTD, 0, 0));
> >       npcm845_evb_i2c_init(soc);
> >       npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
> >       npcm8xx_load_kernel(machine, soc);
>

Hi Philippe,
Thanks for your sharing. Now I understand why you say it won't work on
read-only storage.
Currently, without this change we cannot run the npcm845-evb of QEMU
with a large flash size (128 MB), including the latest OpenBMC build
image.
That's why we sync the method into npcm8xx_board for our npcm845 evb
board. It's seems not suitable for upstream, right? Thanks.

--=20
Best regards,
Tim Lee

