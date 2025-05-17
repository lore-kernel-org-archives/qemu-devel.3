Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41B5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 05:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGA3M-0006xV-OR; Sat, 17 May 2025 01:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1uGA3J-0006xL-TD
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:25:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1uGA3G-0007R4-CK
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:25:40 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad24b7e0331so422993466b.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747459534; x=1748064334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4uPPSB3wj9sExnl6Hm0LXZzlnNv2D8YvmEHQqG4JORc=;
 b=iCqC/3HJGDjpgYsE3jill/U2YI4unA7KQPlBAblGq+xZiOoGy1NP/WKaKdkwNAcQ5J
 ZQTHsp0HqKlPJZ67czfAUfJwdtJ/XLf2DjjHmIv+lqn+W4hTE5xTii8mPAAdzr/5WbNR
 49a/D9gX5czzvIy/D7Fe+wZiajbYmg1E4MheohY57pgxmgcVZzzgGKoHc5F+v+9jm+R3
 tc+ABfntEz0DJqbLeEX1Nm7PBQISHhAsTBJfuGFXjUejkWLWbYKaAiIMpm8sSoghm4iy
 X6GU63EeYKiH0VgTVwvGLqaVtURxQV1Itc2jyeuK/rpK62RN9Tg8c4MN0AIjs3OFJnEY
 ifDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747459534; x=1748064334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4uPPSB3wj9sExnl6Hm0LXZzlnNv2D8YvmEHQqG4JORc=;
 b=Gv6f5jq2N8cSVevP4X/WJJtps007VkOfmxmH6yKbMzMrF7FVkSHWDS1LKN15GXi4i8
 cjDfUSNU/JzjOqM/iUCt/XUDpfuBqcH079yIzJY30h8Gb7NRazgk1PO6ohy+du1ggsDP
 Ntimp92VJgl3hBXNCHQg8WUxDkkn2VvgDQrWPn39Luf2xP7gtVn8QIXfBvoaQdEp85/c
 unYDm5dpnuxj+tV2qa6FQ2U2DMcxZPCnqOoWReEGkswr+fiCDBMYLXGizRmHWD/wopmu
 3N9tud7z1lhmViFxdk0Wso1mExdG2/C+Mo9vfpijHDB2gl1598a9CMGc83IoK9z6GTzu
 yjLg==
X-Gm-Message-State: AOJu0Yxmdsw3sZfG9sjwE/xhYfXHzE2x2VZ0JwucfpD/BnV3P+hKoWZE
 4vpPbS04zstYCgSa7U/LxtKaDYjGOnVvoCM+WUxcV8yT4wLYHfEQFtj6A0gp6ydGfaoOHdsQ7nP
 qKX5Ah/6Tc/XonW9a2QKbF4Y+UEL7g8PUqFh1
X-Gm-Gg: ASbGncusRezNCiCZA56d6NAGV56NV1M+JUPRycuxqqIZC35Mgs2qf2LHNv8p4QXKxDt
 PaaKb7cVQ9u5Hjy1MLlkWhUBk9bPH37uoLkmsAaAuYU62kPREVbvx1OEBnQZh7bUhbyR7fcBIxD
 5SshD5tzTEfbwlKy1IXoBNrDAE4yMrkiGDZi6jWRGYW7SCx3zQ6y3jLPk+OgkKrgrdYB4=
X-Google-Smtp-Source: AGHT+IHQkxM92yK+y32kqXlmWnyvj8XOrQBDeX+V3TzWbETif9SGqOiMInaPEWa6UrXEl192Ay7MMliR5SKJi3lf96g=
X-Received: by 2002:a17:907:d716:b0:ad4:f5ed:42db with SMTP id
 a640c23a62f3a-ad52d4b3699mr608415866b.17.1747459534229; Fri, 16 May 2025
 22:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250429170354.150581-1-rakeshjb010@gmail.com>
 <20250429170354.150581-2-rakeshjb010@gmail.com>
In-Reply-To: <20250429170354.150581-2-rakeshjb010@gmail.com>
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Date: Sat, 17 May 2025 10:55:22 +0530
X-Gm-Features: AX0GCFvQy7DGVhgl9Okurx9HbHZtrLQGPgl49pjHC5HxAcehoVHHsgkZCdS9XCk
Message-ID: <CAD8nu1jtypmu+EyCY_kCdN3+Vo+Di64t9aBTfKSjArGZ+L3vYw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hw/pci-host/gt64120: Fix endianness handling
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 thuth@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000cc14f906354e20b1"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000cc14f906354e20b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:34=E2=80=AFPM Rakesh Jeyasingh <rakeshjb010@gmai=
l.com>
wrote:

> The GT-64120 PCI controller requires special handling where:
> 1. Host bridge(bus 0 ,device 0) must never be byte-swapped
> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>
> The previous implementation incorrectly  swapped all accesses, breaking
> host bridge detection (lspci -d 11ab:4620).
>
> Changes made:
> 1. Removed gt64120_update_pci_cfgdata_mapping() and moved data_mem
> initialization
>   to gt64120_realize() for cleaner setup
> 2. Implemented custom read/write handlers that:
>    - Preserve host bridge accesses (extract32(config_reg,11,13)=3D=3D0)
>    - apply swapping only for non-bridge devices in big-endian mode
>
> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE
> MemoryRegionOps")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>
> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
> ---
>  hw/pci-host/gt64120.c | 82 +++++++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 34 deletions(-)
>
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index 56a6ef93b7..ecb203a3d0 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
>      memory_region_transaction_commit();
>  }
>
> -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
> -{
> -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset:
> 0xc00 */
> -    static const MemoryRegionOps *pci_host_data_ops[] =3D {
> -        &pci_host_data_be_ops, &pci_host_data_le_ops
> -    };
> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> -
> -    memory_region_transaction_begin();
> -
> -    /*
> -     * The setting of the MByteSwap bit and MWordSwap bit in the PCI
> Internal
> -     * Command Register determines how data transactions from the CPU
> to/from
> -     * PCI are handled along with the setting of the Endianness bit in
> the CPU
> -     * Configuration Register. See:
> -     * - Table 16: 32-bit PCI Transaction Endianness
> -     * - Table 158: PCI_0 Command, Offset: 0xc00
> -     */
> -
> -    if (memory_region_is_mapped(&phb->data_mem)) {
> -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
> -        object_unparent(OBJECT(&phb->data_mem));
> -    }
> -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
> -                          s, "pci-conf-data", 4);
> -    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << =
2,
> -                                        &phb->data_mem, 1);
> -
> -    memory_region_transaction_commit();
> -}
> -
>  static void gt64120_pci_mapping(GT64120State *s)
>  {
>      memory_region_transaction_begin();
> @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
>      case GT_PCI0_CMD:
>      case GT_PCI1_CMD:
>          s->regs[saddr] =3D val & 0x0401fc0f;
> -        gt64120_update_pci_cfgdata_mapping(s);
>          break;
>      case GT_PCI0_TOR:
>      case GT_PCI0_BS_SCS10:
> @@ -1024,6 +991,48 @@ static const MemoryRegionOps isd_mem_ops =3D {
>      },
>  };
>
> +static bool bswap(const GT64120State *s)
> +{
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> +    /*check for bus =3D=3D 0 && device =3D=3D 0, Bits 11:15 =3D Device ,=
 Bits 16:23
> =3D Bus*/
> +    bool is_phb_dev0 =3D extract32(phb->config_reg, 11, 13) =3D=3D 0;
> +    bool le_mode =3D FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD,
> MByteSwap);
> +    /* Only swap for non-bridge devices in big-endian mode */
> +    return !le_mode && !is_phb_dev0;
> +}
> +
> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigne=
d
> size)
> +{
> +    GT64120State *s =3D opaque;
> +    uint64_t val =3D pci_host_data_le_ops.read(opaque, addr, size);
>
Hi , I just noticed that I made a mistake in the declaring data length of
read val. In previous commits declared as uint32_t (as I think the PCI
controller handles 32-bit values, while MemoryRegionOps uses uint64_t
returns)
Should i consider:
1.sending corrected patch(hoping it not yet merged)
2.or any suggestion on fixing it?

> +
> +    if (bswap(s)) {
> +        val =3D bswap32(val);
> +    }
> +    return val;
> +}
> +
> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> +    uint64_t val, unsigned size)
> +{
> +    GT64120State *s =3D opaque;
> +
> +    if (bswap(s)) {
> +        val =3D bswap32(val);
> +    }
> +    pci_host_data_le_ops.write(opaque, addr, val, size);
> +}
> +
> +static const MemoryRegionOps gt64120_pci_data_ops =3D {
> +    .read =3D gt64120_pci_data_read,
> +    .write =3D gt64120_pci_data_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
>  static void gt64120_reset(DeviceState *dev)
>  {
>      GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);
> @@ -1178,7 +1187,6 @@ static void gt64120_reset(DeviceState *dev)
>
>      gt64120_isd_mapping(s);
>      gt64120_pci_mapping(s);
> -    gt64120_update_pci_cfgdata_mapping(s);
>  }
>
>  static void gt64120_realize(DeviceState *dev, Error **errp)
> @@ -1202,6 +1210,12 @@ static void gt64120_realize(DeviceState *dev, Erro=
r
> **errp)
>      memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR << =
2,
>                                          &phb->conf_mem, 1);
>
> +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> +                          &gt64120_pci_data_ops,
> +                          s, "pci-conf-data", 4);
> +    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << =
2,
> +                                        &phb->data_mem, 1);
> +
>
>      /*
>       * The whole address space decoded by the GT-64120A doesn't generate
> --
> 2.43.0
>
>

--000000000000cc14f906354e20b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 29,=
 2025 at 10:34=E2=80=AFPM Rakesh Jeyasingh &lt;<a href=3D"mailto:rakeshjb01=
0@gmail.com">rakeshjb010@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">The GT-64120 PCI controller requires spec=
ial handling where:<br>
1. Host bridge(bus 0 ,device 0) must never be byte-swapped<br>
2. Other devices follow MByteSwap bit in GT_PCI0_CMD<br>
<br>
The previous implementation incorrectly=C2=A0 swapped all accesses, breakin=
g<br>
host bridge detection (lspci -d 11ab:4620).<br>
<br>
Changes made:<br>
1. Removed gt64120_update_pci_cfgdata_mapping() and moved data_mem initiali=
zation<br>
=C2=A0 to gt64120_realize() for cleaner setup<br>
2. Implemented custom read/write handlers that:<br>
=C2=A0 =C2=A0- Preserve host bridge accesses (extract32(config_reg,11,13)=
=3D=3D0)<br>
=C2=A0 =C2=A0- apply swapping only for non-bridge devices in big-endian mod=
e<br>
<br>
Fixes: 145e2198 (&quot;hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRID=
GE MemoryRegionOps&quot;)<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2826" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2826</a><br>
<br>
Signed-off-by: Rakesh Jeyasingh &lt;<a href=3D"mailto:rakeshjb010@gmail.com=
" target=3D"_blank">rakeshjb010@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/pci-host/gt64120.c | 82 +++++++++++++++++++++++++-----------------=
-<br>
=C2=A01 file changed, 48 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c<br>
index 56a6ef93b7..ecb203a3d0 100644<br>
--- a/hw/pci-host/gt64120.c<br>
+++ b/hw/pci-host/gt64120.c<br>
@@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_transaction_commit();<br>
=C2=A0}<br>
<br>
-static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)<br>
-{<br>
-=C2=A0 =C2=A0 /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, O=
ffset: 0xc00 */<br>
-=C2=A0 =C2=A0 static const MemoryRegionOps *pci_host_data_ops[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pci_host_data_be_ops, &amp;pci_host_data_=
le_ops<br>
-=C2=A0 =C2=A0 };<br>
-=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
-<br>
-=C2=A0 =C2=A0 memory_region_transaction_begin();<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* The setting of the MByteSwap bit and MWordSwap bit i=
n the PCI Internal<br>
-=C2=A0 =C2=A0 =C2=A0* Command Register determines how data transactions fr=
om the CPU to/from<br>
-=C2=A0 =C2=A0 =C2=A0* PCI are handled along with the setting of the Endian=
ness bit in the CPU<br>
-=C2=A0 =C2=A0 =C2=A0* Configuration Register. See:<br>
-=C2=A0 =C2=A0 =C2=A0* - Table 16: 32-bit PCI Transaction Endianness<br>
-=C2=A0 =C2=A0 =C2=A0* - Table 158: PCI_0 Command, Offset: 0xc00<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-<br>
-=C2=A0 =C2=A0 if (memory_region_is_mapped(&amp;phb-&gt;data_mem)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;s-&gt;ISD_mem=
, &amp;phb-&gt;data_mem);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(&amp;phb-&gt;data_mem))=
;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, OBJECT(phb),<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pci_host_data_ops[s-&gt;regs[GT_PCI0_CMD] &amp; 1],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_mem, GT_P=
CI0_CFGDATA &lt;&lt; 2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;phb=
-&gt;data_mem, 1);<br>
-<br>
-=C2=A0 =C2=A0 memory_region_transaction_commit();<br>
-}<br>
-<br>
=C2=A0static void gt64120_pci_mapping(GT64120State *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0memory_region_transaction_begin();<br>
@@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,<b=
r>
=C2=A0 =C2=A0 =C2=A0case GT_PCI0_CMD:<br>
=C2=A0 =C2=A0 =C2=A0case GT_PCI1_CMD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[saddr] =3D val &amp; 0x0401fc0=
f;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GT_PCI0_TOR:<br>
=C2=A0 =C2=A0 =C2=A0case GT_PCI0_BS_SCS10:<br>
@@ -1024,6 +991,48 @@ static const MemoryRegionOps isd_mem_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
+static bool bswap(const GT64120State *s) <br>
+{<br>
+=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
+=C2=A0 =C2=A0 /*check for bus =3D=3D 0 &amp;&amp; device =3D=3D 0, Bits 11=
:15 =3D Device , Bits 16:23 =3D Bus*/<br>
+=C2=A0 =C2=A0 bool is_phb_dev0 =3D extract32(phb-&gt;config_reg, 11, 13) =
=3D=3D 0;<br>
+=C2=A0 =C2=A0 bool le_mode =3D FIELD_EX32(s-&gt;regs[GT_PCI0_CMD], GT_PCI0=
_CMD, MByteSwap);<br>
+=C2=A0 =C2=A0 /* Only swap for non-bridge devices in big-endian mode */<br=
>
+=C2=A0 =C2=A0 return !le_mode &amp;&amp; !is_phb_dev0;<br>
+}<br>
+<br>
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned =
size)<br>
+{<br>
+=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
+=C2=A0 =C2=A0 uint64_t val =3D pci_host_data_le_ops.read(opaque, addr, siz=
e);<br></blockquote><div>Hi , I just noticed that I made a mistake in the d=
eclaring data length of read val. In previous commits declared as uint32_t =
(as I think the PCI controller=C2=A0handles 32-bit values, while MemoryRegi=
onOps uses uint64_t returns)<br>Should i consider:</div><div>1.sending corr=
ected patch(hoping it not yet merged)</div><div>2.or any suggestion on fixi=
ng it?</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 if (bswap(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return val;<br>
+}<br>
+<br>
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, <br>
+=C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 if (bswap(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val); <br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 pci_host_data_le_ops.write(opaque, addr, val, size);=C2=A0 <=
br>
+}<br>
+<br>
+static const MemoryRegionOps gt64120_pci_data_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D gt64120_pci_data_read,<br>
+=C2=A0 =C2=A0 .write =3D gt64120_pci_data_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
=C2=A0static void gt64120_reset(DeviceState *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);<br>
@@ -1178,7 +1187,6 @@ static void gt64120_reset(DeviceState *dev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0gt64120_isd_mapping(s);<br>
=C2=A0 =C2=A0 =C2=A0gt64120_pci_mapping(s);<br>
-=C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void gt64120_realize(DeviceState *dev, Error **errp)<br>
@@ -1202,6 +1210,12 @@ static void gt64120_realize(DeviceState *dev, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(&amp;s-&gt;ISD_mem,=
 GT_PCI0_CFGADDR &lt;&lt; 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;phb-&gt;conf_mem, 1);<br>
<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, OBJECT(phb),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;gt64120_pci_data_ops,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s, &quot;pci-conf-data&quot;, 4);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion_overlap(&amp;s-&gt;ISD_mem, GT_P=
CI0_CFGDATA &lt;&lt; 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;phb=
-&gt;data_mem, 1);<br>
+<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * The whole address space decoded by the GT-64120A doe=
sn&#39;t generate<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000cc14f906354e20b1--

