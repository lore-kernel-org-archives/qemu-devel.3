Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E95CC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEoF-0000iN-K7; Thu, 20 Jun 2024 06:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEoC-0000hw-E9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:14:24 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEoA-0000WT-KR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:14:24 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52bc335e49aso732208e87.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718878461; x=1719483261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3VlJWFkTFjdwflfWRkDRmIabG4LZ+0ZRQKIWtzhXrs=;
 b=UYy0satvdz/B8hbowO0/JtIoxNj/wDjszYLISyyVcEzuiNC38AwnmYPbICXYXMaLd5
 HYP6MYhPi4z2mqs4/nGu7NgKilDMidx52HCIqQ1Ra+FLS7WHisZ1BJwmNX74sMrU2GB0
 Q47vlLXqhtlHQ8CLUrQn8Xf876rfYQ3GxlkelkG8sasr6JvLuI+29suoCd9jW9gyU01H
 fiUw3J08R813ia6Nxgf3TdrxzgTud2Pv57gi8axWlGUZTToeFX3wdZykB+xKK5APQujE
 D9oSSoyzjRLT+PIRoFFNR3xKFEsC9XeGlEa8PGuyLPij8F5LknyDQOIZMfShKuyFmphU
 ksgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718878461; x=1719483261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3VlJWFkTFjdwflfWRkDRmIabG4LZ+0ZRQKIWtzhXrs=;
 b=Jzul8NV0hE/XNp8Li2Zn3Y7UIZIEwBRWfTmjJYlJCMleuuEeJrKaPGa+Pn+8WE47n8
 9WuxA08v9xtWPi4knukv7lR8uJpvaBEvV2wgBafR/7JBtcD1gXOXoHyInny67ikdLldc
 SV20S+ymortP8sLfh4WZ9tz1Evt4/EupybAC28teTfXhZ+GkmQu27tKJVYnJVYbEagyH
 UduJKh7QK6r/qmBlVxZWW0yTOwDcRx9IRoL3S3F3jHu7KierwF7M2hTygoxxByHboR/X
 +31l1LvLrqbijSAsyVMlfcMEHkmHaN/4pmg/GpgBhkdhfBgbYdPUTFZUw+PJFbSKNzmp
 kuNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8dm4xw82ccRmt+JoekOpWs/XqqliKiqF5grI7GvSfo/ZeKJbL055iU7qoilV6D9Ws6YZbK75cdFYAp9cCl7EwQHe+Hu0=
X-Gm-Message-State: AOJu0Yx/gIO8tgKm+6IfrB4RGAQgC4yOVccfH6E91H9BQRDWGM6tiPmA
 gYfLkfRB+qPlJ446j8WMO4tcwFbpYcydmbrthjeVz4i2yY0s76GSv5DfuOz4ZrwJCrS7HMrpYjs
 xisVP0M70hwIXGPPsez9abiTJo5Hoy+d3mP+19w==
X-Google-Smtp-Source: AGHT+IHNlJW6nuWNkY80Jv6/L+Parf5GcoDLoVjj2ffG5wgghcx4lrrJM1r3rw3y1mv9HRIMV/3ramq36zgsXjKiw1M=
X-Received: by 2002:a05:651c:1038:b0:2ea:ea40:5d4c with SMTP id
 38308e7fff4ca-2ec3cffe85emr34371021fa.48.1718878460588; Thu, 20 Jun 2024
 03:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135610.3109175-1-zheyuma97@gmail.com>
 <CADBGO7_XF5REzENPGupwMB-EOHXS78SG5v=yZ6TRZ_7yVgWUtg@mail.gmail.com>
 <c60ac5cc-c592-46bc-b09a-b918253cb6cd@linaro.org>
 <CADBGO7_=_1SNB2EN9Up7QB4TGOFqWQekBTTvLAJvMtpb73nRug@mail.gmail.com>
In-Reply-To: <CADBGO7_=_1SNB2EN9Up7QB4TGOFqWQekBTTvLAJvMtpb73nRug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 11:14:08 +0100
Message-ID: <CAFEAcA8vei_9jpOjemQeFh89qegdP9r+ANXB1dQRrz1+C1hu1w@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
To: Paul Zimmerman <pauldzim@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zheyu Ma <zheyuma97@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Tue, 18 Jun 2024 at 22:33, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> On Tue, Jun 18, 2024 at 1:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote:
>>
>> Hi Paul,
>>
>> On 18/6/24 20:58, Paul Zimmerman wrote:
>> > On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Zheyu Ma <zheyuma97@gmail.com
>> > <mailto:zheyuma97@gmail.com>> wrote:
>> >  >
>> >  > This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write()
>> > functions
>> >  > to handle invalid address access gracefully. Instead of using
>> >  > g_assert_not_reached(), which causes the program to abort, the func=
tions
>> >  > now log an error message and return a default value for reads or do
>> >  > nothing for writes.
>> >  >
>> >  > This change prevents the program from aborting and provides clear l=
og
>> >  > messages indicating when an invalid memory address is accessed.
>> >  >
>> >  > Reproducer:
>> >  > cat << EOF | qemu-system-aarch64 -display none \
>> >  > -machine accel=3Dqtest, -m 512M -machine raspi2b -m 1G -nodefaults =
\
>> >  > -usb -drive file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Ddisk0 -de=
vice \
>> >  > usb-storage,port=3D1,drive=3Ddisk0 -qtest stdio
>> >  > readl 0x3f980dfb
>> >  > EOF
>> >  >
>> >  > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
>> > <mailto:zheyuma97@gmail.com>>
>> >  > ---
>> >  >  hw/usb/hcd-dwc2.c | 9 +++++++--
>> >  >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >  >
>> >  > diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
>> >  > index 8cac9c0a06..b4f0652c7d 100644
>> >  > --- a/hw/usb/hcd-dwc2.c
>> >  > +++ b/hw/usb/hcd-dwc2.c
>> >  > @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, h=
waddr addr, unsigned size)
>> >  >          val =3D dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe0=
0)) >> 2, size);
>> >  >          break;
>> >  >      default:
>> >  > -        g_assert_not_reached();
>> >  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_=
PRIx"\n",
>> >  > +                      __func__, addr);
>> >  > +        val =3D 0;
>> >  > +        break;
>> >  >      }
>> >  >
>> >  >      return val;
>> >  > @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwadd=
r addr, uint64_t val,
>> >  >          dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> =
2, val, size);
>> >  >          break;
>> >  >      default:
>> >  > -        g_assert_not_reached();
>> >  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_=
PRIx"\n",
>> >  > +                      __func__, addr);
>> >  > +        break;
>> >  >      }
>> >  >  }
>> >  >
>> >  > --
>> >  > 2.34.1
>> >
>> > Looks good to me.
>> >
>> > Reviewed-by: Paul Zimmerman <pauldzim@gmail.com <mailto:pauldzim@gmail=
.com>>
>> >
>>
>> Does that mean on real HW the access to unassigned registers are
>> silently ignored as RAZ/WI like this patch? (I don't have access
>> to the specs -- IIRC you don't neither, but you might have real
>> HW to test).

> I have an old raspi around somewhere I could probably dig up and
> test with, but I'm not familiar with qtest, so I don't know how I
> would reproduce the failure on real hw.
>
> Besides, isn't it always better to fail and log an error than just crash?

Yes, assert is definitely the wrong thing here. RAZ/WI and log a
guest-error is what we typically do for devices where the spec doesn't
give a behaviour for accesses to register offsets that aren't documented
as having registers.

I've applied this to target-arm.next; thanks.

-- PMM

