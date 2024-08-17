Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BBFC52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 11:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfI1C-0006m5-Di; Sat, 17 Aug 2024 07:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfI1B-0006l6-2T; Sat, 17 Aug 2024 07:54:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sfI19-0007Kr-32; Sat, 17 Aug 2024 07:54:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so3734705a12.0; 
 Sat, 17 Aug 2024 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723895684; x=1724500484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdlbEm/UZz+nb/ch8JHD5w8DvoZyACwWe8Yyeu9nEng=;
 b=OGasCzMDYfbLFXhUMUxaKBNvt57CEShV684TXfrj2Wg0Gxbt0hYKMt+/+0SsZmFDcK
 U1ufzE2nlY94xoaNCTqw6/t6j8qiv1WM7xM1dfBMPe4zQW4PC+vTOWTVtZrtB6NXp9mR
 oFiTVNp/bAt1RtPPfVr+CYqHyaojzJp26MPwvatx1rsMJz/9RDTmgq/mJucAbyN3gSPV
 vWpEOZbxfTPFMVrhglN1ewg/8xRvWmUSUnlPYQ3T0r5YceiKErvgiWzGpThc/2JsNVBw
 Hw2xmRAn4RfE4qOAsogZuFRyM/ALHAs1Wn9U6MCdvisV1c4++KaIU+6oxAZWPq62PzSp
 tANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723895684; x=1724500484;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdlbEm/UZz+nb/ch8JHD5w8DvoZyACwWe8Yyeu9nEng=;
 b=NjZKfoy0HlUnfXVgmQN0BTCeoOGVjiiwtC+cyHMzO7aZep99e2LkjfAAhwzdthikQB
 G3j3Hzh5+cdeb6WxH/ePSFVDwInDsST0UeE1AEgI3EK8y4DVpawHNsyk+wh4XKMFGsaj
 GI0gXI7Uv7U5filyRNvXMM9kCMR2QPADkPIEcRD40mRKH06TeK8xneTVZXTHESUS0jB/
 AYzQyBBNxJNGW08avizbLPRdzkrqu6PuPPKMRoaz90WreZfQaTUMAw/+PeT28IQhukkE
 kM1KUFkfXfL3Yw9ANgy7Jsoiwp4CEm7IqHka/v+kigAmcKATjx9NHwU8INljfTTfQpZI
 RyTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqnUiSXw7znclumocDwlCS80OzETsWrKvFITEMb7vZg2/dTj5wAe1OY+BrZUp/TqbGHPU0LIfKcgtnei1OSgHwqA+uvtU=
X-Gm-Message-State: AOJu0Yx4sO5gqrp4Ux8o9J3jlq8wWwDGsU+9AAspVkkZ+Xlvdn0NSYu5
 ZbXtPP4r4xABYQ4MDluheDO+6wxCix9rbAQDXOwnMBm0qfzzKKQjtWoWLw==
X-Google-Smtp-Source: AGHT+IG8K6uvGHUXMQqgekaYhGdAinuY8V2/iXk6tBslS9XjnJiB88tDfUZukqqtvP5xqHRL1tF7Bw==
X-Received: by 2002:a05:6402:2707:b0:5a4:2c8:abda with SMTP id
 4fb4d7f45d1cf-5beca4e23c6mr3720551a12.3.1723895684251; 
 Sat, 17 Aug 2024 04:54:44 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-173-151.89.12.pool.telefonica.de.
 [89.12.173.151]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbe7f05dsm3369927a12.78.2024.08.17.04.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 04:54:43 -0700 (PDT)
Date: Sat, 17 Aug 2024 11:54:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
In-Reply-To: <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
 <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
Message-ID: <30A32FEE-B310-49E7-8D79-746C786C3CE3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 17=2E August 2024 08:49:05 UTC schrieb "Kamil Szcz=C4=99k" <kamil@szcze=
k=2Edev>:
>On Friday, August 16th, 2024 at 15:14, Bernhard Beschow <shentey@gmail=2E=
com> wrote:
>
>>
>> Am 14=2E August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" kamil@szc=
zek=2Edev:
>>
>> > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add optio=
n
>> > to disable PS/2 mouse/keyboard'), the vmport will not be created unle=
ss
>> > the i8042 PS/2 controller is enabled=2E To not confuse users, let's a=
dd a
>> > warning if vmport was explicitly requested, but the i8042 controller =
is
>> > disabled=2E This also changes the behavior of vmport=3Dauto to take i=
8042
>> > controller availability into account=2E
>> >
>> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek=2Edev
>> > ---
>> > hw/i386/pc=2Ec | 4 ++++
>> > hw/i386/pc_piix=2Ec | 3 ++-
>> > hw/i386/pc_q35=2Ec | 2 +-
>> > qemu-options=2Ehx | 4 ++--
>> > 4 files changed, 9 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>> > index c74931d577=2E=2E5bd8dd0350 100644
>> > --- a/hw/i386/pc=2Ec
>> > +++ b/hw/i386/pc=2Ec
>> > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, b=
ool create_fdctrl,
>> > }
>> >
>> > if (!create_i8042) {
>> > + if (!no_vmport) {
>> > + warn_report("vmport requires the i8042 controller to be enabled");
>> > + }
>> > +
>> > return;
>> > }
>> >
>> > diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> > index d9e69243b4=2E=2Ecf2e2e3e30 100644
>> > --- a/hw/i386/pc_piix=2Ec
>> > +++ b/hw/i386/pc_piix=2Ec
>> > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const=
 char *pci_type)
>> >
>> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>> > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>> > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
>> > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
>> > }
>>
>>
>> I think it makes sense to consolidate this handling into pc_basic_devic=
es_init() before doing this change=2E Maybe just in front of the call to pc=
_superio_init()? The additional handling of xen_enabled() shouldn't hurt th=
ere for q35: Even though q35 doesn't (yet) support Xen there are already co=
de paths where this check is done=2E
>
>Makes sense technically, but since I'm new to the mailing list workflow I=
 could use some help with logistics=2E I've already posted a v2 of this pat=
ch which was reviewed and accepted,

Ouch, I've missed that=2E

> should I wait for it to be pulled in and post a follow-up patch or post =
another revision of this patch?

Since Michael already tagged it, it seems safer to follow up with a new se=
ries or patch=2E You can use the `Based-on:` tag there to make the dependen=
cy of the new series explicit=2E See [1] for inspiration=2E To determine th=
e mail ID look up this series on lore=2Ekernel=2Eorg/qemu-devel =2E

Best regards,
Bernhard

[1] https://patchew=2Eorg/QEMU/20230105143228=2E244965-1-shentey@gmail=2Ec=
om/

>
>>
>> > /* init basic PC hardware */
>> > diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>> > index 9d108b194e=2E=2E6c112d804d 100644
>> > --- a/hw/i386/pc_q35=2Ec
>> > +++ b/hw/i386/pc_q35=2Ec
>> > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
>> >
>> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>> > - pcms->vmport =3D ON_OFF_AUTO_ON;
>> > + pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUTO=
_OFF;
>> > }
>> >
>> > /* init basic PC hardware */
>> > diff --git a/qemu-options=2Ehx b/qemu-options=2Ehx
>> > index cee0da2014=2E=2E0bc780a669 100644
>> > --- a/qemu-options=2Ehx
>> > +++ b/qemu-options=2Ehx
>> > @@ -68,8 +68,8 @@ SRST
>> >
>> > `vmport=3Don|off|auto`
>> > Enables emulation of VMWare IO port, for vmmouse etc=2E auto says
>> > - to select the value based on accel=2E For accel=3Dxen the default i=
s
>> > - off otherwise the default is on=2E
>> > + to select the value based on accel and i8042=2E For accel=3Dxen
>> > + and/or i8042=3Doff the default is off otherwise the default is on=
=2E
>>
>>
>> I'd do s#and/or#or# for readability=2E
>>
>> Best regards,
>> Bernhard
>>
>> > `dump-guest-core=3Don|off`
>> > Include guest memory in a core dump=2E The default is on=2E

