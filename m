Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39A7C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 11:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkiDh-0006Fg-T7; Wed, 19 Feb 2025 06:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tkiDg-0006Cr-DQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:26:24 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tkiDe-0000sM-GD
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:26:24 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dd01781b56so79926336d6.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739964381; x=1740569181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywdqwoI8kebjHm9wTy/sLLATh4m1ZbIxq3wEwOVvUfo=;
 b=VzvHXPSU6fTZl+OqX7LCwwl69cF9k1PUy8Xf7y5jpUZcuFU6r++0+xBRrv50Dm20Id
 U7KtHdWti9JIWuvuE5O8aljx/o00eWWB4ZZTFI+3ZTddjeG5sEDABkrQztzdcJtr5Rz3
 VP05hB7S7BhSzF7/3kvN8tKQV4x0FXm15EUoEmFFtSaQGk9DOBeXFHY+U8f9LJRWh1/B
 jc0T+tZM/W8RX8h49VrbegjKe2K7/aFyru1xCJSrjslJsptM/+LLso66jOj3r9uKoPax
 wtB7gVZvY62eOGhw8Y/uSoJG6qN5FIJPfSgAAQpoZJXLiN0l7STi0f9F0L0XrWWV/iBB
 kSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739964381; x=1740569181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywdqwoI8kebjHm9wTy/sLLATh4m1ZbIxq3wEwOVvUfo=;
 b=R6Dw6qrSn5YARjSUmzkx24zjKPXXxv2uXz6I61DOaXdiCux5bFy+xnTdPfFPQlg9F9
 gyaY+Bhdh9Fs3MIkcM5M+cr/eLul9xcAxFibob5/Z2BWYQyVUUp/xHY7493+PZAG4TUp
 fbcGALakBgC9Fl9DgLvRudnXq0LZxpg9ywbEPgxQ3bfqA146E3vVpdIqo82L0ylwHLRY
 GUNaYQDt0Ph6uU88HNNm0vVa7EG9rHXpsM0+2OXwlwb6SaVOOh1RhPAoabfhlQznMIbF
 cn+Rm4f0J3U4U643nifBekk/aVWuYqycbzIqT391WyJ0tPYget9ags3H/tj8pa9TZcTQ
 PHoA==
X-Gm-Message-State: AOJu0YxeqNtNIpXzc0bDossvpK5aVamWqJtwYEHdjxtyEMwDN8CCRAxD
 JZku9oWlgaNMXSkFNGqCYgScfOSDYRYcD4jON5wVFTU1n60Xjn3s9d1CVrG7nYBOxxH0m0qMay/
 edmpIakNraRrZ+/ZfYoPkk8xwjNCBcLiv20Xesw==
X-Gm-Gg: ASbGncu43CjRq8GyFq3l4Z/TjEGbQNB9MEe29gUv6aOP6rPBgKJMYmEW4gh4urQm7iT
 EX1ZZQU0OwW3SZAmQpbyvYn5askygCD8yWG54FzdvbNQDrQCrCLHV5ocYT32CFS96mHAfKIBOIF
 Y=
X-Google-Smtp-Source: AGHT+IFLxBwS0ublwzb927FVVbZn+kmdrfWLMly1/7v0QsFJ5uHDiV8ZjVf/jn8SZtFA6xYgKDH5eiqniTucXOaho4w=
X-Received: by 2002:a05:6214:300e:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6e66cd06482mr219321266d6.30.1739964381146; Wed, 19 Feb 2025
 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
 <20250217081730.9000-8-yongxuan.wang@sifive.com>
 <20250217-9d3c0d38ed66b1a8257b4515@orel>
In-Reply-To: <20250217-9d3c0d38ed66b1a8257b4515@orel>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Wed, 19 Feb 2025 19:26:10 +0800
X-Gm-Features: AWEUYZlDUQ_2CB8hECe2FSB2Hb7IqOnFPkicTXQWmUVnxZSjyq7BN-hFAwa6CoM
Message-ID: <CAMWQL2j38794BJUY4BwBOCV6JTdrsLUVnTpY=-Lvi4guymwDdA@mail.gmail.com>
Subject: Re: [PATCH 7/8] target/riscv/kvm: rename riscv-aia to riscv-imsic
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Andrew,

On Mon, Feb 17, 2025 at 10:07=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Mon, Feb 17, 2025 at 04:17:27PM +0800, Yong-Xuan Wang wrote:
> > The riscv-aia property only controls the in-kernel IMSIC mode, the
> > emulation of AIA MSI mode is controlled by the kernel-irqchip property.
> > Rename the riscv-aia property to riscv-imsic to prevent the confusion.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  target/riscv/kvm/kvm-cpu.c | 52 ++++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 25 deletions(-)
> >
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index c047d5f36951..ab53b76ab81f 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1798,9 +1798,9 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, in=
t level)
> >      }
> >  }
> >
> > -static int aia_mode;
> > +static int imsic_mode;
> >
> > -static const char *kvm_aia_mode_str(uint64_t mode)
> > +static const char *kvm_imsic_mode_str(uint64_t mode)
> >  {
> >      switch (mode) {
> >      case KVM_DEV_RISCV_AIA_MODE_EMUL:
> > @@ -1813,19 +1813,19 @@ static const char *kvm_aia_mode_str(uint64_t mo=
de)
> >      };
> >  }
> >
> > -static char *riscv_get_kvm_aia(Object *obj, Error **errp)
> > +static char *riscv_get_kvm_imsic(Object *obj, Error **errp)
> >  {
> > -    return g_strdup(kvm_aia_mode_str(aia_mode));
> > +    return g_strdup(kvm_imsic_mode_str(imsic_mode));
> >  }
> >
> > -static void riscv_set_kvm_aia(Object *obj, const char *val, Error **er=
rp)
> > +static void riscv_set_kvm_imsic(Object *obj, const char *val, Error **=
errp)
> >  {
> >      if (!strcmp(val, "emul")) {
> > -        aia_mode =3D KVM_DEV_RISCV_AIA_MODE_EMUL;
> > +        imsic_mode =3D KVM_DEV_RISCV_AIA_MODE_EMUL;
> >      } else if (!strcmp(val, "hwaccel")) {
> > -        aia_mode =3D KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> > +        imsic_mode =3D KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> >      } else if (!strcmp(val, "auto")) {
> > -        aia_mode =3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> > +        imsic_mode =3D KVM_DEV_RISCV_AIA_MODE_AUTO;
> >      } else {
> >          error_setg(errp, "Invalid KVM AIA mode");
> >          error_append_hint(errp, "Valid values are emul, hwaccel, and a=
uto.\n");
> > @@ -1834,13 +1834,15 @@ static void riscv_set_kvm_aia(Object *obj, cons=
t char *val, Error **errp)
> >
> >  void kvm_arch_accel_class_init(ObjectClass *oc)
> >  {
> > -    object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
> > -                                  riscv_set_kvm_aia);
> > -    object_class_property_set_description(oc, "riscv-aia",
> > -        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'aut=
o'. "
> > -        "Changing KVM AIA modes relies on host support. Defaults to 'a=
uto' "
> > -        "if the host supports it");
> > -    object_property_set_default_str(object_class_property_find(oc, "ri=
scv-aia"),
> > +    object_class_property_add_str(oc, "riscv-imsic", riscv_get_kvm_ims=
ic,
> > +                                  riscv_set_kvm_imsic);
> > +    object_class_property_set_description(oc, "riscv-imsic",
> > +        "Set KVM IMSIC mode. Valid values are 'emul', 'hwaccel' and 'a=
uto'. "
> > +        "Changing KVM IMSIC modes relies on host support. Defaults to =
'auto' "
> > +        "if the host supports it. This property only takes effect when=
 the "
> > +        "kernel-irqchip=3Don|split when using AIA MSI.");
> > +    object_property_set_default_str(object_class_property_find(oc,
> > +                                                               "riscv-=
imsic"),
> >                                      "auto");
>
> We can't change property names without deprecating the old name (which
> isn't likely worth it).
>

ok. I will remove this patch in the next version. Thank you!

Regards,
Yong-Xuan

> Thanks,
> drew
>
>
> >  }
> >
> > @@ -1851,7 +1853,7 @@ void kvm_riscv_aia_create(MachineState *machine, =
uint64_t group_shift,
> >  {
> >      int ret, i;
> >      int aia_fd =3D -1;
> > -    uint64_t default_aia_mode;
> > +    uint64_t default_imsic_mode;
> >      uint64_t socket_count =3D riscv_socket_count(machine);
> >      uint64_t max_hart_per_socket =3D 0;
> >      uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_a=
ddr;
> > @@ -1867,24 +1869,24 @@ void kvm_riscv_aia_create(MachineState *machine=
, uint64_t group_shift,
> >
> >      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> >                              KVM_DEV_RISCV_AIA_CONFIG_MODE,
> > -                            &default_aia_mode, false, NULL);
> > +                            &default_imsic_mode, false, NULL);
> >      if (ret < 0) {
> > -        error_report("KVM AIA: failed to get current KVM AIA mode");
> > +        error_report("KVM AIA: failed to get current KVM IMSIC mode");
> >          exit(1);
> >      }
> >
> > -    if (default_aia_mode !=3D aia_mode) {
> > +    if (default_imsic_mode !=3D imsic_mode) {
> >          ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG=
,
> >                                  KVM_DEV_RISCV_AIA_CONFIG_MODE,
> > -                                &aia_mode, true, NULL);
> > +                                &imsic_mode, true, NULL);
> >          if (ret < 0) {
> > -            warn_report("KVM AIA: failed to set KVM AIA mode '%s', usi=
ng "
> > +            warn_report("KVM AIA: failed to set KVM IMSIC mode '%s', u=
sing "
> >                          "default host mode '%s'",
> > -                        kvm_aia_mode_str(aia_mode),
> > -                        kvm_aia_mode_str(default_aia_mode));
> > +                        kvm_imsic_mode_str(imsic_mode),
> > +                        kvm_imsic_mode_str(default_imsic_mode));
> >
> > -            /* failed to change AIA mode, use default */
> > -            aia_mode =3D default_aia_mode;
> > +            /* failed to change IMSIC mode, use default */
> > +            imsic_mode =3D default_imsic_mode;
> >          }
> >      }
> >
> > --
> > 2.17.1
> >

