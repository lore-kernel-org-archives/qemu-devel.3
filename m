Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EBAC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 04:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzpzP-0003yP-3f; Wed, 02 Apr 2025 00:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzpzM-0003xi-2G
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:46:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzpzJ-0002dw-8z
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:46:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so1101087966b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743569161; x=1744173961; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zp0AC3SotlAgVHebd7puhLhMtsjtdkf2LzSxqrMVdAI=;
 b=ZhddNd5iPxAaA+a/FRKSdXioS79uxowExKz101vDV4jiuzqgfC4x8i1y/eOnQsW4Tb
 XcvUaufBSbMOK0y41Xr5tTtole3nC33l6ClnPT7p8Qxp1L8+dvl+dAXUc4kZ9+TSsdaN
 DSTu/GKMGJcD3zGaG95sxrvjbwm/4JDNLzvzRBfbcCP+8YRbnzCe4EwGOZfKkjMIZM8+
 HrhJeEWfLu6pagng5Kldk1P14SF1TylhE2kSNNONmhLX54CMjuDoCNCytvpRHhGtWFH4
 1Am0bFfOzFu7rn9T3jqwF2+b0GEIx9ZJKC23pETg0OCYBAIag9h+3r04RIwc30v2xsSM
 HMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743569161; x=1744173961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zp0AC3SotlAgVHebd7puhLhMtsjtdkf2LzSxqrMVdAI=;
 b=PCGPFS6UeT8exs9T/LC4+8k7Kkzu1D3OZKqoWfRNxmk8MKL4RzeGyDyBnXwS+EIReo
 LnfwuTGwN3oiUsmV6dCi6zi6jigIaYKRxNgHsh6Xa3aJUVT9aVSRsAwo01mZDQfrvRfQ
 rteRUaEo7Pe8YKJh78h0gFFSvJqRWv3ZDUMI9s85CvQs7hgpuGFfQvxw/stM390qCpP3
 5wSgsgwZqZXgnfmn962EHCLjJ15NQUSDq+yaN3n9DvebyzYL12+upKwkuPkvSDyw+6PL
 2dLQrg3uJIkiB4BUuBgOUzqNnNbtr12nbrsktL7yMSH0SWSq/Bojc9hC86KGIm+KflUw
 nbrQ==
X-Gm-Message-State: AOJu0Yz60mbOF/4RHmosVIa6Lf9Rcd/mXORTYDCxWtERBAQffsqmQ2MY
 fWTQO4tr4DGr09AlHDG4cHxVOwwYMHYLrqeK1pFz+uZ8sGH9CFJ5R3wK0/Xmdv33J7SiWH3wm6Z
 hXq4z0/4NLnQedBHo1fYot1lesc2rhlM8zJw=
X-Gm-Gg: ASbGncuaOtYZt7v+HuBDxia9TLqjI1VYQOdxPUPdimihRIkJGAPpbC1n6fGJK/0DcZN
 ehJ2egScS/eGj8Q/C1q4pOvZkb0ZWLC342YIX7B5En4jKr0IRrHFYE9B/R/Rmsz1Ovppfi+QKyg
 8jL0+vcyfdE2z5IL4bvnRnGqZMzzafY+DTQEMiNpimCNyNZWD/DVvfOuTfZ3E=
X-Google-Smtp-Source: AGHT+IE/PCmFtZKwlnqt3zzNPd0Fs9t6jmhnlWSabFLYE/hkA2lRA7ENCWei4qISxyJAqbGmfvJbTW9CNsEjt+g4GMo=
X-Received: by 2002:a17:907:d14:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac738a8db2bmr1473375866b.33.1743569160911; Tue, 01 Apr 2025
 21:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250331184820.34673-1-rakeshjb010@gmail.com>
 <20250331184820.34673-2-rakeshjb010@gmail.com>
In-Reply-To: <20250331184820.34673-2-rakeshjb010@gmail.com>
From: Rakesh J <rakeshjb010@gmail.com>
Date: Wed, 2 Apr 2025 10:15:49 +0530
X-Gm-Features: AQ5f1Jp05DMUssa0si-qdjaTtdkdCl1RMgJYzdBHIvREHaVVhN8Evw2DOyrBeNg
Message-ID: <CAD8nu1hoY10ux2BQmV2h0i6gLFW8odEU1QaMtrMkdr0wEK6LUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hw/pci-host/gt64120: Fix endianness handling
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@linaro.org, 
 thuth@redhat.com, balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="0000000000007a44440631c454a3"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x629.google.com
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

--0000000000007a44440631c454a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ,

Thank you for reviewing the previous versions of this patch. I've
incorporated all the feedback in v4:
1. set .min_access_size=3D4
2. Simplified swapping to bswap32 only

Note: I realized after sending v4 that the commit message still referenced
the old size-specific swap approach -"Implement size-specific swaps
(bswap16 for 2-byte, bswap32 for 4-byte)
  per MemoryRegionOps requirements". The actual patch content correctly
implements the simplified DWORD-only behavior.

Before this moves forward, could you please confirm:

   1. Are there any remaining corrections needed?
   2. Would you like me to resend with an updated commit message?

Appreciate your guidance, and apologies for the message oversight!

Regards,
Rakesh

On Tue, Apr 1, 2025 at 12:18=E2=80=AFAM Rakesh Jeyasingh <rakeshjb010@gmail=
.com>
wrote:

> The GT-64120 PCI controller requires special handling where:
> 1. Host bridge(bus 0 ,device 0) must use native endianness
> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>
> Previous implementation accidentally swapped all accesses, breaking
> host bridge detection (lspci -d 11ab:4620).
>
> This patch:
> - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem
> initialization
>   to gt64120_realize()
> - Adds custom read/write handlers
> - Replace raw bit check with FIELD_EX32 for MByteSwap .
> - Use extract32 for bus/device check (bus 0, device 0).
> - Implement size-specific swaps (bswap16 for 2-byte, bswap32 for 4-byte)
>   per MemoryRegionOps requirements.
>
> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE
> MemoryRegionOps")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>
> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
> ---
>  hw/pci-host/gt64120.c | 91 +++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 34 deletions(-)
>
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index d5c13a89b6..3595d8127e 100644
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
> @@ -1024,6 +991,57 @@ static const MemoryRegionOps isd_mem_ops =3D {
>      },
>  };
>
> +static bool is_phb_dev0(const PCIHostState *phb)
> +{
> +    /*Checks if the current PCI configuration access targets the host
> bridge(bus 0, device 0)*/
> +    return extract32(phb->config_reg, 11, 5/*dev*/ + 8/*bus*/) =3D=3D 0;
> +}
> +
> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigne=
d
> size)
> +{
> +    GT64120State *s =3D opaque;
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> +    uint32_t val;
> +    bool le_mode =3D FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD,
> MByteSwap);
> +
> +    if (!(phb->config_reg & (1 << 31))) {
> +        val =3D 0xffffffff;
> +    } else {
> +        val =3D pci_data_read(phb->bus, phb->config_reg | (addr & 3), si=
ze);
> +    }
> +
> +    /* Only swap for non-bridge devices in big-endian mode */
> +    if (!le_mode && !is_phb_dev0(phb)) {
> +        val =3D bswap32(val);
> +    }
> +    return val;
> +}
> +
> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> +    uint64_t val, unsigned size)
> +{
> +    GT64120State *s =3D opaque;
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> +    bool le_mode =3D FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD,
> MByteSwap);
> +
> +    if (!le_mode && !is_phb_dev0(phb)) {
> +        val =3D bswap32(val);
> +    }
> +    if (phb->config_reg & (1u << 31)){
> +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size=
);
> +    }
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
> @@ -1178,7 +1196,6 @@ static void gt64120_reset(DeviceState *dev)
>
>      gt64120_isd_mapping(s);
>      gt64120_pci_mapping(s);
> -    gt64120_update_pci_cfgdata_mapping(s);
>  }
>
>  static void gt64120_realize(DeviceState *dev, Error **errp)
> @@ -1202,6 +1219,12 @@ static void gt64120_realize(DeviceState *dev, Erro=
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

--0000000000007a44440631c454a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi ,<br><br>Thank you for reviewing the p=
revious versions of this patch. I&#39;ve incorporated all the feedback in v=
4:<br>1. set .min_access_size=3D4<br>2. Simplified swapping to bswap32 only=
<br><br>Note: I realized after sending v4 that the commit message still ref=
erenced the old size-specific swap approach -&quot;Implement size-specific =
swaps (bswap16 for 2-byte, bswap32 for 4-byte)</div><div dir=3D"ltr">=C2=A0=
 per MemoryRegionOps requirements&quot;. The actual patch content correctly=
 implements the simplified DWORD-only behavior.<br><br>Before this moves fo=
rward, could you please confirm:<br><ol><li>Are there any remaining correct=
ions needed?</li><li>Would you like me to resend with an updated commit mes=
sage?</li></ol>Appreciate your guidance, and apologies for the message over=
sight!</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Regards,<br>Rakesh<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Apr 1, 2025 at 12:18=E2=80=AFAM Rakesh Jeyasin=
gh &lt;<a href=3D"mailto:rakeshjb010@gmail.com">rakeshjb010@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The GT=
-64120 PCI controller requires special handling where:<br>
1. Host bridge(bus 0 ,device 0) must use native endianness<br>
2. Other devices follow MByteSwap bit in GT_PCI0_CMD<br>
<br>
Previous implementation accidentally swapped all accesses, breaking<br>
host bridge detection (lspci -d 11ab:4620).<br>
<br>
This patch:<br>
- Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initializat=
ion<br>
=C2=A0 to gt64120_realize()<br>
- Adds custom read/write handlers<br>
- Replace raw bit check with FIELD_EX32 for MByteSwap .<br>
- Use extract32 for bus/device check (bus 0, device 0).<br>
- Implement size-specific swaps (bswap16 for 2-byte, bswap32 for 4-byte)<br=
>
=C2=A0 per MemoryRegionOps requirements.<br>
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
=C2=A0hw/pci-host/gt64120.c | 91 +++++++++++++++++++++++++++---------------=
-<br>
=C2=A01 file changed, 57 insertions(+), 34 deletions(-)<br>
<br>
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c<br>
index d5c13a89b6..3595d8127e 100644<br>
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
@@ -1024,6 +991,57 @@ static const MemoryRegionOps isd_mem_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
+static bool is_phb_dev0(const PCIHostState *phb)<br>
+{<br>
+=C2=A0 =C2=A0 /*Checks if the current PCI configuration access targets the=
 host bridge(bus 0, device 0)*/<br>
+=C2=A0 =C2=A0 return extract32(phb-&gt;config_reg, 11, 5/*dev*/ + 8/*bus*/=
) =3D=3D 0;<br>
+}<br>
+<br>
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned =
size)<br>
+{<br>
+=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
+=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
+=C2=A0 =C2=A0 uint32_t val;<br>
+=C2=A0 =C2=A0 bool le_mode =3D FIELD_EX32(s-&gt;regs[GT_PCI0_CMD], GT_PCI0=
_CMD, MByteSwap);<br>
+<br>
+=C2=A0 =C2=A0 if (!(phb-&gt;config_reg &amp; (1 &lt;&lt; 31))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D 0xffffffff;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D pci_data_read(phb-&gt;bus, phb-&gt;con=
fig_reg | (addr &amp; 3), size);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Only swap for non-bridge devices in big-endian mode */<br=
>
+=C2=A0 =C2=A0 if (!le_mode &amp;&amp; !is_phb_dev0(phb)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return val;<br>
+}<br>
+<br>
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, <br>
+=C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 GT64120State *s =3D opaque;<br>
+=C2=A0 =C2=A0 PCIHostState *phb =3D PCI_HOST_BRIDGE(s);<br>
+=C2=A0 =C2=A0 bool le_mode =3D FIELD_EX32(s-&gt;regs[GT_PCI0_CMD], GT_PCI0=
_CMD, MByteSwap);<br>
+<br>
+=C2=A0 =C2=A0 if (!le_mode &amp;&amp; !is_phb_dev0(phb)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D bswap32(val); <br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (phb-&gt;config_reg &amp; (1u &lt;&lt; 31)){<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_data_write(phb-&gt;bus, phb-&gt;config_reg=
 | (addr &amp; 3), val, size);<br>
+=C2=A0 =C2=A0 }<br>
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
@@ -1178,7 +1196,6 @@ static void gt64120_reset(DeviceState *dev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0gt64120_isd_mapping(s);<br>
=C2=A0 =C2=A0 =C2=A0gt64120_pci_mapping(s);<br>
-=C2=A0 =C2=A0 gt64120_update_pci_cfgdata_mapping(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void gt64120_realize(DeviceState *dev, Error **errp)<br>
@@ -1202,6 +1219,12 @@ static void gt64120_realize(DeviceState *dev, Error =
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

--0000000000007a44440631c454a3--

