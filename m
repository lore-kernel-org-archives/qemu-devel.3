Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC35C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmsp-0004Ls-Ad; Tue, 13 May 2025 06:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEmsk-0004GA-PZ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEmsi-0001YY-Uz
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747132144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Q9Purpm/K4u0zXRViMrb/8QUlPpX+E7LaiOih2O93w=;
 b=R011LYuoW/LFcJLF+vvXgLVR8LLrY4lk9boS+gPScb5CuJHwDSIa5tbZqBNiFBCKrFuH6+
 3FdRYEZ3SMdoZa7OoLH3ICacBXBX8cbsXAbAEGmAfZp+MDfRq+IpyP9aNvzLCgELxWCSHY
 /wPulp6tLPMRKE9Fde+KUA0WcfHyDK0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-RBipaNbRNTmS61TtlCM-Bw-1; Tue, 13 May 2025 06:29:02 -0400
X-MC-Unique: RBipaNbRNTmS61TtlCM-Bw-1
X-Mimecast-MFC-AGG-ID: RBipaNbRNTmS61TtlCM-Bw_1747132142
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so23976855e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747132141; x=1747736941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Q9Purpm/K4u0zXRViMrb/8QUlPpX+E7LaiOih2O93w=;
 b=uL3fMgemZ8+q0cc2WMk6VV5NGH/m2tG0N4LxX61SIyF7NFegVgwsPiRG7Fb3wdORuW
 yaIbd6m1G/P511BInM3U6d4YBC7+YS8k7oxqpGvzScHqrMaBE/VLbPWZP5ATtTaFDGLe
 XsV2Gew9ebYflxc6zp9vgnzYE6amyfqaXtrapP63y6g4BxBr9IPDoy8LW91Y3moa9fio
 C8MwwD+7zs3WUoaD6/4UOLUaQku6p3T62dedluxyH8rPz+nIcAioZ9jJIms8D3gU612o
 rH3W0gxsON6B0aVkM9aHcipLs7/7NPU/i6Vu25JQyDVwR70NDJ5GuFrl9/bYK7PlxGj0
 mBBA==
X-Gm-Message-State: AOJu0YxgPsFYrwURJ+43LIsNKygHN8tpkeP8pN9zzABvDVhal9PEA9qk
 yXG81L7rG/rRhZipNiyw8zrS2L2eIfnHbRyyBXGUQwEiCzwoG+nbp5SrGBmARDXKBW64GVEngqK
 Pr7APGs9cbMjNJQHmzXptpiEONFhZzFmrjnSuiTU+1iNDzwyPXDmM
X-Gm-Gg: ASbGncvaD3zZG1R+xB7ZVdfQFpqD8SpLQGCkWaTxWhwBLdLP7a1DaFq/g0olfqgJ/3A
 ek+lYWe99e8NocxsAmiaGjBPemlfgDYjjSzOp52VdcY/Ex+TQCFlzneU63C0U1TYCnISii8dFJo
 HTuBok3KeZ+vo4urcapBTpnEQePfakfJtbvqkUOpdW2p/SljOPMcy5GS+ecMyJhRr7gIto2ES93
 N2aV6q8pvqgjfCtkOM4qrhezoMurmjEKDQTdesRSSUl8NZeGEeOZbYg+9ijar8HDsIDMH2SGMa4
 Q0uBOqLxHEXOLH/OYNyEDUC9X27Xjkqw
X-Received: by 2002:a05:600c:a089:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-442d6d6ad82mr144907065e9.18.1747132141545; 
 Tue, 13 May 2025 03:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi10nzAH1EKGO/kzFRGmvYqSgNFAee4ggzvFi1MDmC4i0/84NFAoHOBMIjVrdAh6iczoq/8A==
X-Received: by 2002:a05:600c:a089:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-442d6d6ad82mr144906565e9.18.1747132141134; 
 Tue, 13 May 2025 03:29:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bde2sm201853865e9.19.2025.05.13.03.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 03:29:00 -0700 (PDT)
Date: Tue, 13 May 2025 12:28:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 24/27] hw/intc/ioapic: Remove
 IOAPICCommonState::version field
Message-ID: <20250513122858.2a596bd9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-25-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-25-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:47 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The IOAPICCommonState::version integer was only set
> in the hw_compat_2_7[] array, via the 'version=3D0x11'
> property. We removed all machines using that array,
> lets remove that property, simplify by only using the
> default version (defined as IOAPIC_VER_DEF).
>=20
> For the record, this field was introduced in commit
> 20fd4b7b6d9 ("x86: ioapic: add support for explicit EOI"):
>=20
>  >   Some old Linux kernels (upstream before v4.0), or any released RHEL
>  >   kernels has problem in sending APIC EOI when IR is enabled.
>  >   Meanwhile, many of them only support explicit EOI for IOAPIC, which
>  >   is only introduced in IOAPIC version 0x20. This patch provide a way
>  >   to boost QEMU IOAPIC to version 0x20, in order for QEMU to correctly
>  >   receive EOI messages.
>  >
>  >   Without boosting IOAPIC version to 0x20, kernels before commit
>  >   d32932d ("x86/irq: Convert IOAPIC to use hierarchical irqdomain
>  >   interfaces") will have trouble enabling both IR and level-triggered
>  >   interrupt devices (like e1000).
>  >
>  >   To upgrade IOAPIC to version 0x20, we need to specify:
>  >
>  >     -global ioapic.version=3D0x20
>  >

that crutch might be in-use by external users, and even if they use
0x20, removing property will break CLI.

I'd deprecate it first and then remove.

>  >   To be compatible with old systems, 0x11 will still be the default
>  >   IOAPIC version. Here 0x11 and 0x20 are the only versions to be
>  >   supported.
looking at the code removed, default is 0x20 which doesn't match above
statement. Have something changed between then and now (missing ref to
0x20 becoming default)?

>  >
>  >   One thing to mention: this patch only applies to emulated IOAPIC. It
>  >   does not affect kernel IOAPIC behavior. =20
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/ioapic_internal.h |  3 +--
>  hw/intc/ioapic.c          | 18 ++----------------
>  hw/intc/ioapic_common.c   |  2 +-
>  3 files changed, 4 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
> index 51205767f44..330ce195222 100644
> --- a/hw/intc/ioapic_internal.h
> +++ b/hw/intc/ioapic_internal.h
> @@ -82,7 +82,7 @@
>  #define IOAPIC_ID_MASK                  0xf
> =20
>  #define IOAPIC_VER_ENTRIES_SHIFT        16
> -
> +#define IOAPIC_VER_DEF                  0x20
> =20
>  #define TYPE_IOAPIC_COMMON "ioapic-common"
>  OBJECT_DECLARE_TYPE(IOAPICCommonState, IOAPICCommonClass, IOAPIC_COMMON)
> @@ -104,7 +104,6 @@ struct IOAPICCommonState {
>      uint32_t irr;
>      uint64_t ioredtbl[IOAPIC_NUM_PINS];
>      Notifier machine_done;
> -    uint8_t version;
>      uint64_t irq_count[IOAPIC_NUM_PINS];
>      int irq_level[IOAPIC_NUM_PINS];
>      int irq_eoi[IOAPIC_NUM_PINS];
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 133bef852d1..5cc97767d9d 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -315,7 +315,7 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned i=
nt size)
>              val =3D s->id << IOAPIC_ID_SHIFT;
>              break;
>          case IOAPIC_REG_VER:
> -            val =3D s->version |
> +            val =3D IOAPIC_VER_DEF |
>                  ((IOAPIC_NUM_PINS - 1) << IOAPIC_VER_ENTRIES_SHIFT);
>              break;
>          default:
> @@ -411,8 +411,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t =
val,
>          }
>          break;
>      case IOAPIC_EOI:
> -        /* Explicit EOI is only supported for IOAPIC version 0x20 */
> -        if (size !=3D 4 || s->version !=3D 0x20) {
> +        if (size !=3D 4) {
>              break;
>          }
>          ioapic_eoi_broadcast(val);
> @@ -444,18 +443,10 @@ static void ioapic_machine_done_notify(Notifier *no=
tifier, void *data)
>  #endif
>  }
> =20
> -#define IOAPIC_VER_DEF 0x20
> -
>  static void ioapic_realize(DeviceState *dev, Error **errp)
>  {
>      IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
> =20
> -    if (s->version !=3D 0x11 && s->version !=3D 0x20) {
> -        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
> -                   "(default: 0x%x).", IOAPIC_VER_DEF);
> -        return;
> -    }
> -
>      memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>                            "ioapic", 0x1000);
> =20
> @@ -476,10 +467,6 @@ static void ioapic_unrealize(DeviceState *dev)
>      timer_free(s->delayed_ioapic_service_timer);
>  }
> =20
> -static const Property ioapic_properties[] =3D {
> -    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_=
DEF),
> -};
> -
>  static void ioapic_class_init(ObjectClass *klass, const void *data)
>  {
>      IOAPICCommonClass *k =3D IOAPIC_COMMON_CLASS(klass);
> @@ -493,7 +480,6 @@ static void ioapic_class_init(ObjectClass *klass, con=
st void *data)
>       */
>      k->post_load =3D ioapic_update_kvm_routes;
>      device_class_set_legacy_reset(dc, ioapic_reset_common);
> -    device_class_set_props(dc, ioapic_properties);
>  }
> =20
>  static const TypeInfo ioapic_info =3D {
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index fce3486e519..8b3e2ba9384 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -83,7 +83,7 @@ static void ioapic_print_redtbl(GString *buf, IOAPICCom=
monState *s)
>      int i;
> =20
>      g_string_append_printf(buf, "ioapic0: ver=3D0x%x id=3D0x%02x sel=3D0=
x%02x",
> -                           s->version, s->id, s->ioregsel);
> +                           IOAPIC_VER_DEF, s->id, s->ioregsel);
>      if (s->ioregsel) {
>          g_string_append_printf(buf, " (redir[%u])\n",
>                                 (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >>=
 1);


