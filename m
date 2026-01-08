Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30462CF6A83
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlRJ-0001TY-FS; Thu, 08 Jan 2026 03:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlR9-0001Hx-Uw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:32:11 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlR6-0004uX-7A
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:32:07 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4ee257e56aaso19649541cf.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767861123; x=1768465923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GPLNgm47Xm+JmFQLwzXm2g+/zkJ8FH9Sj4CzeV/bCc=;
 b=HitO/CHNgOJ/4E57+tysdl76tqr9/JO0jhegqeSoA1r3qUI7cZ+h2Mxv4bG9SSn2lm
 PeZuEHY6JDwkT7E9gPcdb9rgj6bImBXdVY3QDXk3RHjsapZ0AOGdOAox2qz3s5pUMFwR
 k/T+x+epITYu2/XPHsmkD38NQnIbNEg5GfL93dt3bsp4OX+tRvIYVD6Q1KGI6CveCK25
 a29llEdTapqet7NFkYiTiRShOCv+jIY3YuL2dShAwEGVcl6G0BOWwwMSY8uDM3H+MH/D
 1lrcAh/UXCVcFs0zzdipJDKg66gKqVI+nNAuWCgWRAJi8B9IEpfZzABP9TOKzuJa9qBK
 RElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767861123; x=1768465923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GPLNgm47Xm+JmFQLwzXm2g+/zkJ8FH9Sj4CzeV/bCc=;
 b=liTfyT6LzpJiXSeOKG3f+utSdGc/BORamhAm+hEg1PW6gOse9nU5dZPBS6AQY35kKw
 lRXTILveIWxDHlcHx1SkLFuK/uir/BdhNfxrj8MUHUFntymFhYAO1h99HyZsEUuO0C8F
 fWiXVjC4wfKl5Brajo6sixCUUOqjYz5UQuBgyK9SEKS++WG+D1WLTgksa8Qu3n27ydmz
 2DiWH84OHIcQucv0iwSHuZ0TD7eELaSM8lm550AtjfqALdeEomYNJxjkM6CCh1a3STuX
 wepZNcgR+OU+M83KuFmfmxi4CWczTPHXcfVQePUvp3Qf0RA4SfDZzYOXR8ZWUM9tYZfb
 jYQg==
X-Gm-Message-State: AOJu0YxjS+TdD6feJwVLOv1Bqav+0DeCQrUzOMFBojYUAoyK5rD6IcNf
 LHWiiEZbku1SMWoPAncmj1amg+5ePzJWWmR2hDLJn6DpKHHu+qWolyBQ2HCG14b+paPBUEhPddw
 PwNM/6l7qgVeikb0FsBXx+0+w2T4ozwA=
X-Gm-Gg: AY/fxX4Zme2g4Gzt7aLYeIkX1yEu2Z1ftVH0r3lZrBJT8BrkDBS5LUuXzFTPBy8oK/Z
 bJq58sNzLieyPPTO1mIh/wprYFbF2RD7q3RhFeH7sr3nYXS43C2C8wJJnHZ9Os/zmF+nLS53jn1
 DhsLue8fnON+/FPYtkXYaP2BWrjp/bBavButteub1Ziq5H7ozcGuU7iewJwOSX67vtsDWKnoseB
 75O0OpyeDWjshfrd3+wx0QgR57ueKZ19UadCdw2JV1jvDiAZjrQPzoKltgFVoye1fGdchuAn0xv
 nwKU3/nePgxrlwbD60KbfEW9PcA=
X-Google-Smtp-Source: AGHT+IEuSRA3h6q6BjUia1cZDo92lgDrVAuwUJCt2KcgICcrc5PeWKTpo/8pvfTQ5J35kxef7QubkiVwOW7stBxIyAo=
X-Received: by 2002:ac8:5fcb:0:b0:4ff:82aa:d845 with SMTP id
 d75a77b69052e-4ffb40324b5mr77611061cf.41.1767861123015; Thu, 08 Jan 2026
 00:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20251222055009.1050567-1-csomani@redhat.com>
In-Reply-To: <20251222055009.1050567-1-csomani@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 12:31:51 +0400
X-Gm-Features: AQt7F2ps4R0tHMDia8Z4jkNwP17vZBrLJyA6lne9IVnU4RSV5rRdnpSJ0Ew9VEc
Message-ID: <CAJ+F1CJOkeNQ+QXLOx2SW582BYDLNMz_ukFkYN5_5urVB28rCQ@mail.gmail.com>
Subject: Re: [PATCH] qdev: Free property array on release
To: Chandan Somani <csomani@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Chandan

On Mon, Dec 22, 2025 at 9:56=E2=80=AFAM Chandan Somani <csomani@redhat.com>=
 wrote:
>
> Before this patch, users of the property array would free the
> array themselves in their cleanup functions. This causes
> inconsistencies where some users leak the array and some free them.
>
> This patch makes it so that the property array's release function
> frees the property array (instead of just its elements). It fixes any
> leaks and requires less code.
>
> Signed-off-by: Chandan Somani <csomani@redhat.com>

I sent a similar series earlier and forgot about it:
https://patchew.org/QEMU/20250429140306.190384-1-marcandre.lureau@redhat.co=
m/

Maybe you could combine the two?

> ---
>  block/accounting.c                |  1 -
>  hw/core/qdev-properties.c         | 20 ++++++++++----------
>  hw/input/stellaris_gamepad.c      |  8 --------
>  hw/intc/arm_gicv3_common.c        |  8 --------
>  hw/intc/rx_icu.c                  |  8 --------
>  hw/misc/arm_sysctl.c              |  2 --
>  hw/misc/mps2-scc.c                |  8 --------
>  hw/net/rocker/rocker.c            |  1 -
>  hw/nvram/xlnx-efuse.c             |  8 --------
>  hw/nvram/xlnx-versal-efuse-ctrl.c |  8 --------
>  10 files changed, 10 insertions(+), 62 deletions(-)
>
> diff --git a/block/accounting.c b/block/accounting.c
> index 0933c61f3a..5cf51f029b 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -73,7 +73,6 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOff=
Auto account_invalid,
>              }
>              block_acct_add_interval(stats, stats_intervals[i]);
>          }
> -        g_free(stats_intervals);
>      }
>      return true;
>  }
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 0930d64252..455c28535a 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -673,10 +673,8 @@ static Property array_elem_prop(Object *obj, const P=
roperty *parent_prop,
>
>  /*
>   * Object property release callback for array properties: We call the
> - * underlying element's property release hook for each element.
> - *
> - * Note that it is the responsibility of the individual device's deinit
> - * to free the array proper.
> + * underlying element's property release hook for each element and free =
the
> + * property array.
>   */
>  static void release_prop_array(Object *obj, const char *name, void *opaq=
ue)
>  {
> @@ -686,14 +684,16 @@ static void release_prop_array(Object *obj, const c=
har *name, void *opaque)
>      char *elem =3D *arrayptr;
>      int i;
>
> -    if (!prop->arrayinfo->release) {
> -        return;
> +    if (prop->arrayinfo->release) {
> +        for (i =3D 0; i < *alenptr; i++) {
> +            Property elem_prop =3D array_elem_prop(obj, prop, name, elem=
);
> +            prop->arrayinfo->release(obj, NULL, &elem_prop);
> +            elem +=3D prop->arrayfieldsize;
> +        }
>      }
>
> -    for (i =3D 0; i < *alenptr; i++) {
> -        Property elem_prop =3D array_elem_prop(obj, prop, name, elem);
> -        prop->arrayinfo->release(obj, NULL, &elem_prop);
> -        elem +=3D prop->arrayfieldsize;
> +    if (*arrayptr) {
> +        g_free(*arrayptr);
>      }
>  }
>
> diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
> index fec1161c9c..207064dacb 100644
> --- a/hw/input/stellaris_gamepad.c
> +++ b/hw/input/stellaris_gamepad.c
> @@ -63,13 +63,6 @@ static void stellaris_gamepad_realize(DeviceState *dev=
, Error **errp)
>      qemu_input_handler_register(dev, &stellaris_gamepad_handler);
>  }
>
> -static void stellaris_gamepad_finalize(Object *obj)
> -{
> -    StellarisGamepad *s =3D STELLARIS_GAMEPAD(obj);
> -
> -    g_free(s->keycodes);
> -}
> -
>  static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
>  {
>      StellarisGamepad *s =3D STELLARIS_GAMEPAD(obj);
> @@ -98,7 +91,6 @@ static const TypeInfo stellaris_gamepad_info[] =3D {
>          .name =3D TYPE_STELLARIS_GAMEPAD,
>          .parent =3D TYPE_SYS_BUS_DEVICE,
>          .instance_size =3D sizeof(StellarisGamepad),
> -        .instance_finalize =3D stellaris_gamepad_finalize,
>          .class_init =3D stellaris_gamepad_class_init,
>      },
>  };
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 2d0df6da86..26d694d2ab 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -488,13 +488,6 @@ static void arm_gicv3_common_realize(DeviceState *de=
v, Error **errp)
>      s->itslist =3D g_ptr_array_new();
>  }
>
> -static void arm_gicv3_finalize(Object *obj)
> -{
> -    GICv3State *s =3D ARM_GICV3_COMMON(obj);
> -
> -    g_free(s->redist_region_count);
> -}
> -
>  static void arm_gicv3_common_reset_hold(Object *obj, ResetType type)
>  {
>      GICv3State *s =3D ARM_GICV3_COMMON(obj);
> @@ -644,7 +637,6 @@ static const TypeInfo arm_gicv3_common_type =3D {
>      .instance_size =3D sizeof(GICv3State),
>      .class_size =3D sizeof(ARMGICv3CommonClass),
>      .class_init =3D arm_gicv3_common_class_init,
> -    .instance_finalize =3D arm_gicv3_finalize,
>      .abstract =3D true,
>      .interfaces =3D (const InterfaceInfo[]) {
>          { TYPE_ARM_LINUX_BOOT_IF },
> diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
> index f8615527b7..85da0624f6 100644
> --- a/hw/intc/rx_icu.c
> +++ b/hw/intc/rx_icu.c
> @@ -334,13 +334,6 @@ static void rxicu_init(Object *obj)
>      sysbus_init_irq(d, &icu->_swi);
>  }
>
> -static void rxicu_fini(Object *obj)
> -{
> -    RXICUState *icu =3D RX_ICU(obj);
> -    g_free(icu->map);
> -    g_free(icu->init_sense);
> -}
> -
>  static const VMStateDescription vmstate_rxicu =3D {
>      .name =3D "rx-icu",
>      .version_id =3D 1,
> @@ -382,7 +375,6 @@ static const TypeInfo rxicu_info =3D {
>      .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(RXICUState),
>      .instance_init =3D rxicu_init,
> -    .instance_finalize =3D rxicu_fini,
>      .class_init =3D rxicu_class_init,
>  };
>
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 0f4e37cd47..e715ff9475 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -618,9 +618,7 @@ static void arm_sysctl_finalize(Object *obj)
>  {
>      arm_sysctl_state *s =3D ARM_SYSCTL(obj);
>
> -    g_free(s->db_voltage);
>      g_free(s->db_clock);
> -    g_free(s->db_clock_reset);
>  }
>
>  static const Property arm_sysctl_properties[] =3D {
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index a9a5d4a535..acb0f5773b 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -405,13 +405,6 @@ static void mps2_scc_realize(DeviceState *dev, Error=
 **errp)
>      s->oscclk =3D g_new0(uint32_t, s->num_oscclk);
>  }
>
> -static void mps2_scc_finalize(Object *obj)
> -{
> -    MPS2SCC *s =3D MPS2_SCC(obj);
> -
> -    g_free(s->oscclk_reset);
> -}
> -
>  static bool cfg7_needed(void *opaque)
>  {
>      MPS2SCC *s =3D opaque;
> @@ -489,7 +482,6 @@ static const TypeInfo mps2_scc_info =3D {
>      .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(MPS2SCC),
>      .instance_init =3D mps2_scc_init,
> -    .instance_finalize =3D mps2_scc_finalize,
>      .class_init =3D mps2_scc_class_init,
>  };
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index cc49701dd3..cbc7bd3ed9 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1429,7 +1429,6 @@ static void pci_rocker_uninit(PCIDevice *dev)
>              world_free(r->worlds[i]);
>          }
>      }
> -    g_free(r->fp_ports_peers);
>  }
>
>  static void rocker_reset(DeviceState *dev)
> diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
> index 4c23f8b931..1875fdb953 100644
> --- a/hw/nvram/xlnx-efuse.c
> +++ b/hw/nvram/xlnx-efuse.c
> @@ -224,13 +224,6 @@ static void efuse_realize(DeviceState *dev, Error **=
errp)
>      }
>  }
>
> -static void efuse_finalize(Object *obj)
> -{
> -    XlnxEFuse *s =3D XLNX_EFUSE(obj);
> -
> -    g_free(s->ro_bits);
> -}
> -
>  static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *na=
me,
>                                   void *opaque, Error **errp)
>  {
> @@ -288,7 +281,6 @@ static const TypeInfo efuse_info =3D {
>      .name          =3D TYPE_XLNX_EFUSE,
>      .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(XlnxEFuse),
> -    .instance_finalize =3D efuse_finalize,
>      .class_init    =3D efuse_class_init,
>  };
>
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efu=
se-ctrl.c
> index 6f17f32a0c..4d0c2c8404 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -724,13 +724,6 @@ static void efuse_ctrl_init(Object *obj)
>      sysbus_init_irq(sbd, &s->irq_efuse_imr);
>  }
>
> -static void efuse_ctrl_finalize(Object *obj)
> -{
> -    XlnxVersalEFuseCtrl *s =3D XLNX_VERSAL_EFUSE_CTRL(obj);
> -
> -    g_free(s->extra_pg0_lock_spec);
> -}
> -
>  static const VMStateDescription vmstate_efuse_ctrl =3D {
>      .name =3D TYPE_XLNX_VERSAL_EFUSE_CTRL,
>      .version_id =3D 1,
> @@ -767,7 +760,6 @@ static const TypeInfo efuse_ctrl_info =3D {
>      .instance_size =3D sizeof(XlnxVersalEFuseCtrl),
>      .class_init    =3D efuse_ctrl_class_init,
>      .instance_init =3D efuse_ctrl_init,
> -    .instance_finalize =3D efuse_ctrl_finalize,
>  };
>
>  static void efuse_ctrl_register_types(void)
> --
> 2.51.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

