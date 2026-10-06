Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A3CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENh7-0002XI-Tx; Wed, 07 Oct 2026 05:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xELYi-0004nb-Eh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:55:37 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xELYf-0005la-Nt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:55:23 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a20f06cce6so22538641fa.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 23:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791356119; cv=none;
 d=google.com; s=arc-20260327;
 b=kSq+Y1+H4tGXaUIT8vmSsL0Cid6T4M9S5EyByCw6IsUIXk6vGuCTI67MFvJYQzFJFO
 ZFzAL+3ywZnowzBimPIGGPXo0hW075LpCtyKbOgZhgf2uq0ux22KoMviVWTCxOSK85k6
 KayPCC3u+bwfYDfbfZO13n97sGkN254aSrvh09vLyey/CH1EomNA1SrhYnDsmMubpM6L
 ZSwCwMmV6UugKpzu5FrqtXOwIjcF9S5uXoGmVF8Jq+3riaQXAnnB/UFjytTIuogAKIB+
 mBZubZ7WmyrfSd0qrgWiQ4CrqxMyhwFBxLnyd8QgvHxxuisb1q4Em17co8ejqRewXYM+
 DkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=iGsASOwIYqiLJkkmyP7K6YhiPreGgg+P7pTHUbHCpE8=;
 fh=R2xEx6XpG+kpApXxvEuRg5Ckm1YNdL1jrK7GHpZcH0I=;
 b=OTYBPF2t2ZrUY8s4yNwLmw+1p8wu3LQfZRyGzeGFM5+mLa/h9iKFGHyNiU/We2jfb+
 amy6ZnjzRaxZzE7iB72rRUohlv2fxd/lJp8y3NtMSAQFF+U1dY0yJKazzToCDvrbyH0G
 /8rwN/mDo5ukXM/o6pHyJTlKJVyefu7ei2JZ+TNi2+S+zpRB/WSuTamOJ+AqpXAYjTWt
 qO+t8Bt5OQp4vRksyd0ylHfaP8OK6h+ALX8JdIPP1+RJrWFIUzMfZdAOC9gtWSzTNnLz
 zrKzvNcfwyycz5UOvwDvvlmL5THvP+ASyjeTtARPOoKVdsPabmqHeiKNBYiuML/qn+Ye
 fVjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791356119; x=1791960919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iGsASOwIYqiLJkkmyP7K6YhiPreGgg+P7pTHUbHCpE8=;
 b=CxeNHub9/ID3M9NSEx0ZTC8Hn1QAbM3MnznQrEq877iMDbfnWKhDpqBPQ7hpxCQlq7
 icU950mXGZmEE2kkBFF/YyVvB6G7jrpWi39EfuQbKg7Z3Hak1juutM+lpmFE36I1tChX
 Ghb6wnM3Ju0+dmuRZIRXI2X95aFTIArBh6TkjKERpdPWBKzEQ0cV2yUkSxmd8hzS5uLH
 XQ6JzSUYLK7DA2QIE3B+if5cKoRz4F8WS7E0bPVOZ7k5CDdnoMR7iBCXZRgbDJor34ch
 PVfHL7mi+llz5QrPDcVfr1LHnc9tRQklYxSI54HUzGHLo6Df0mWo2rZVUzGbj0ddWuNO
 hS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791356119; x=1791960919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iGsASOwIYqiLJkkmyP7K6YhiPreGgg+P7pTHUbHCpE8=;
 b=NXdapreg5A5Qf6qgIAkBsa6Lhqot8JUs5L5UAENjF1VKD0CB3v+HK4tG9m7Uts40+X
 NUlSsbe8HBhA+7LEiaU77WS26r+ZDqqYBnHylffAezWKYmqzGtOWhPeT6p4kuJd1B6XG
 trgoWJEmenPf3z2TOpZoTCiato1YdAWDZjp/OhZvufTUCRhRSxli+en4/Pir5gYZdKml
 V8veaxf2h73DqFa/MrHChm9vhYp0zIYU+i913RkYqUWq94VgU/hdQ3JBvYjp8iDC54bC
 VpE++fUWtsYMgRCJcRsTLCA+jrCRqqtNKqdX8qqiMrniG2SlLn8bXnENniXtdmmdn/eU
 byEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/QpaXsQ43QKAOOIUAWn7EnYbaVNIwVBpVr7FA22/E5NxTEc9XTwtEyhRIWDXEzu4daGxXEGEl8MaU@nongnu.org
X-Gm-Message-State: AFq9FYJDuBOLCSWB5Hu3AWWCiei1hGcf8Ktg3hresHFPQLh0lPfseLQJ
 5SfBYyi59hux/JXnMnXx1uLv+xODP32J4+4M7uaH9/NGg4vDVbhwAqpoPucvHRLJ75hBVO0HA7M
 FDBAR9PhPTLRXvAuuUwFQx1nsIpSuAjgPqNHhx5k=
X-Gm-Gg: AYBFou1kNXB8+HTTjqql59nEs141whVNEVT+quwBHP+8vGJYGiWnKcMPowinDB3/Wv0
 2ZOZLLe0OIe8pRz9M668e/L8sqCvbGvQZPWl0RQHVkTqv6pfmus/OV53Kwbc3Ts7u41vvqIRaJr
 KSqGlypyNGXSED0e/+CKo8xgtFychN1bK32m6qWxZaMT8uwAKTf+dJ5ecGl/Sb74DfLalcAKHyO
 f/9YluLWiwSGvu1yAJT45zozF8HCBfGjm/ixFOHSxELlMUdhC0IVkXz/nbRFvx9gIWOMJCk8ego
 dr7sM0auc8W1LgWxvoAGyk4ijec24cqbZfHUTSGrhLhi1XMgBbYAsR0=
X-Received: by 2002:a05:6402:4259:10b0:6aa:e44a:ae9e with SMTP id
 4fb4d7f45d1cf-6afd8350d5fmr976367a12.1.1791255540639; Mon, 05 Oct 2026
 19:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
 <c71b5f00-3808-9037-cee3-2c5df5007550@eik.bme.hu>
In-Reply-To: <c71b5f00-3808-9037-cee3-2c5df5007550@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 10:58:47 +0800
X-Gm-Features: AclHuK9XgpAqzmUFDtvXIqszXkwqGaJfpXXZUkzUk9z8wMnTZ8-vhlFiKbNOazo
Message-ID: <CAE2XoE-2JzUuq-6mtMu3PS8boAn7KCD1ZpWaM5TwYc4F57Mwdg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 4:53=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Tue, 6 Oct 2026, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 2:52=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> >>> On Tue, Oct 6, 2026 at 2:06=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> >>>>> On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
> >>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>>
> >>>>>>>> Ok, but I'm not sure it answers the why.
> >>>>>>>> Could you explain the benefits?
> >>>>>>>
> >>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-b=
inary because
> >>>>>>> The following original code would return -1 for some user-binary
> >>>>>>> +    SysEmuTarget arch =3D target_info()->target_arch;
> >>>>>>> +
> >>>>>>> +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> >>>>>>> +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_na=
me(), -1,
> >>>>>>> +                               &error_abort);
> >>>>>>> +    }
> >>>>>>> +    return arch;
> >>>>>>> So basically assigning any value for the user binary is valid.
> >>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysE=
muTarget.
> >>>>>>> -1 is another option but easy to confuse.
> >>>>>>>
> >>>>>>>
> >>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> >>>>>>> "target-info: Statically initialize target_arch"
> >>>>>>> doing that, I am not sure.
> >>>>>>>
> >>>>>>
> >>>>>> I guess there is a (good or bad) reason for which sub variants of
> >>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double=
 check
> >>>>>> that before doing any change, as it might have other consequences.
> >>>>>
> >>>>>
> >>>>> You=E2=80=99re right to ask, and I need to correct my earlier sugge=
stion:
> >>>>> leaving user-mode target_arch
> >>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by AR=
M
> >>>>> code shared with user-mode builds,
> >>>>> including cpu-max-v8.c, where its result indexes a two-entry array.
> >>>>> For aarch64-linux-user, the sentinel could therefore cause an
> >>>>> out-of-bounds access during type registration.
> >>>>>
> >>>>> I checked the distinction: softmmu needs the full system-target
> >>>>> identity, including variants such as mipsel;
> >>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
> >>>>> (aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
> >>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> >>>>> than leave the field at SYS_EMU_TARGET__MAX.
> >>>>>
> >>>>
> >>>> That's technical details, but not an answer to the initial question =
of
> >>>> why we need to change anything for user binaries, compared to what e=
xists.
> >>>
> >>> The first two patches revert the current static initialization so the
> >>> token can be replaced. They are not a user-mode behavior change.
> >>>
> >>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
> >>> qemu-mipsel already reports mips, and it still will. Names such as
> >>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> >>> full target name for this field; keeping TARGET_ARCH preserves today'=
s
> >>> value and avoids the runtime parse.
> >>>
> >>
> >> Why should we need to expose this precise information?
> >> So far, if those targets were not exposed (and aliased to 32/64 bit
> >> variant), it's probably we didn't need it.
> >
> > because for different SysEmuTarget, the machine list is different.
> > return a wrong SysEmuTarget would cause a mismatch between SysEmuTarget
> > and the machine list. for example:
> >
> > static const char * const mips_machines[] =3D {
> >    "malta",
> >    "none",
> > };
> >
> > static const char * const mips64_machines[] =3D {
> >    "magnum",
> >    "malta",
> >    "none",
> >    "pica61",
> > };
> >
> > static const char * const mips64el_machines[] =3D {
> >    "boston",
> >    "fuloong2e",
> >    "loongson3-virt",
> >    "magnum",
> >    "malta",
> >    "none",
> >    "pica61",
> > };
> >
> > static const char * const mipsel_machines[] =3D {
> >    "malta",
> >    "none",
> > };
>
> I don't know anything about this but for bi-endian architectures the CPU
> still has a default endianness it starts in, or a way to strap it to some
> endianness by a CPU pin or similar, or the board firmware sets the
> endianness (which in QEMU may be implemented in board code where we
> emulate the firmware instead of running a real firmware image, so while o=
n
> real hardware the machine starts in BE then firmware sets LE we only star=
t
> emulating from that point and the board code sets up the CPU to LE in
> QEMU).
>
> In any case, this means that endianness should be a machine property and
> the list for an arch could contain all boards, then if the target arch
> defines an endianness, you compare that to the machine endianness and
> filter out those that don't match.
>
> But from the above list BE machines also seem to appear in LE the list an=
d
> malta appears everywhere so first we should understand how these lists ar=
e
> defined. It's not filtering out non-matching machines but maybe "el" just
> adds default LE machines in addition to the mips64 list and magnum and
> pica61 are added due to having 64 bit CPU which is another property to
> watch. So the lists seem to depend on CPU and board properties, in
> particular 64bit and LE.
>
> I don't know if this can be implemented easily or at all with how these
> are currently, but I think going that way could arrive to a cleaner
> implementation. I'm sharing the above in case it helps this topic, I don'=
t
> mind how this is implemented so you can also disregard this, just thinkin=
g
> aloud.

SysEmuTarget is the API
##
# @QemuTargetInfo:
#     Information on the target configuration built into the QEMU
#     binary.
#
# @arch: the target architecture
#
# Since: 1.2
##
{ 'struct': 'QemuTargetInfo',
  'data': { 'arch': 'SysEmuTarget' } }

start from qemu 1.2, so keeping its behavior not changed is the most
straightforward way, I don't know why break it
in the first place. If we need narrow to `TARGET_ARCH`, we can always
introduce a new member into
TargetInfo such as config_arch for it. Because the main usage for
`TARGET_ARCH` is reading the Kconfig.
The runtime usage should also reflect that.
here is how its used:
  # Add default keys
  config_target +=3D { 'TARGET_' + config_target['TARGET_ARCH'].to_upper():=
 'y' }
  if 'TARGET_BASE_ARCH' not in config_target
    config_target +=3D {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
  endif
  if 'TARGET_ABI_DIR' not in config_target
    config_target +=3D {'TARGET_ABI_DIR': config_target['TARGET_ARCH']}
  endif

>
> Regards,
> BALATON Zoltan



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

