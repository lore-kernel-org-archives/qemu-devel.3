Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9Ql-0005Rs-UR; Wed, 12 Aug 2026 09:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9Qh-0005PR-Ke; Wed, 12 Aug 2026 09:55:39 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9Qf-0000mR-EB; Wed, 12 Aug 2026 09:55:39 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2EE171400023;
 Wed, 12 Aug 2026 09:55:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 09:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786542936; x=1786629336; bh=oZ4GmeYLOWk+0gmP6jzAgTfoqWqnwl8s
 RrLY7xMA8Nk=; b=iRwUpZO1iewpCsuhD10vNCZh5xVYAEDVMUxD16HNXVqrshvA
 k+tpk67VJLP3QvLsyV6jtMvHpA/jfzwc8BiYhmK0aCKC452BjrM6enmPFdOsPtfx
 2QWneuE7GQfV8uFYVQr2oxKE0nM4WphAav/jz8AsZqPbSrU4Q+G+ASwrnn/kLb6c
 PLj1UOSjeHSZA5QLm6w5ABVL8ZeX7ZkmnHAQqtkqTHUhs7oWug8j8RXibhtREvi7
 oPl23I3iK8BCp3ryi3V5knDzH2mzec2v72INpwpZanYoo62aAsNyeTmegP0QYlxF
 edhN5Y937C6BtSMihmLKPMtyZuKULmvps7dRhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786542936; x=
 1786629336; bh=oZ4GmeYLOWk+0gmP6jzAgTfoqWqnwl8sRrLY7xMA8Nk=; b=V
 ZlhnCz1SaHfnNQ9F04NukEeuwS9wvaDDNQ0S10e8rGTmKgXwyty4MC8Tgxxx/cMV
 S3oExrLMzlyKS4irpEY57XEaMHF7WXbu3WnA6f3paZs5nVWd5oPVyQzPRd7uM2YB
 /HntbHhvgt4FE9V0Q/gme0GhgJusk5U+/jsIoStQAn4/cJ+yPdUNjAAz1wUyKCGy
 /I5woC27MCbYEmOfye9CgDISf1dnBLugeycF7G3Ji+NBv8YmAhmD37+5MHTAWV0n
 j6iTmD8ZvUQAl9Gp5lMQo0eFbQ5ZjmXF4ifsLsxo0xYbNoNQkGiD7AEPrYztALGM
 b7PGRo1vIB4+R3+p5VWRw==
X-ME-Sender: <xms:Vnt8al2ONDQUROWw49KOvulH3bg_kit7T2bRHJP066Jf02c2M_OT_A>
 <xme:Vnt8asieromKiFk8IoBEtus_8RzVH4uLn7L8IoQQP6P99sI_WAolOyXCGL-VPzBxr
 cjpa2zqDaNtM2ETWmGGtvTl8easCsDyKOgEYuz8UgwYuobZkq0P9JmQ>
X-ME-Received: <xmr:Vnt8alq7RLP_t11BZu-hEce89X6QKCsjstNU0wrpn3O4G0uFB3tIq6PwWf7j19MRg3plPg>
X-ME-Proxy-Cause: dmFkZTGpny9W1s0p3xNlSlxCKU6BUw0/nkW0lH5LI01PqfNp6jwHd7zE8zv4zBu7aOaXZe
 dxBW2lue3EeYgZ1yemV+Px5tWXmT7Y1AUFuIE5TeS/VoN2dp2tKKTlZLQjF1DV1fw4g/gh
 +7uYWneW7c0G6Q7YMzQzU+eVtUMF0rAfx7P8e3f9voLcmyuIAQTOqo8y12s7khR5gRq7B/
 9xbmicUpEebrt3cbmugBU5MpxSbNsa33UM83LBKgAWKrRjnan+ZqqP1h/E1rT6uD11O9Kw
 +m63xOdIEES1VfCtUALhvYvj1RWoZAUbSJfcDit4tINbcZpPbNH4hQd7dxdv7HTOfdY+lA
 EP7rlJy1+/HkOk1pIzXE6fuQ7UaJ/2b/gzXLhbQnp2hfgd7h4m7Yw9WP8L+i/QHGwh4heN
 abpVNhGGS4UNm383f2fld5wE8cNtSjSXq1e5ZJaqgV14yt665XqmIwLtylj5zsFfKKy7jL
 A4uNfue97PXlMDfliOVhW13hYa3MCXHV4kxb4sPlt0fZCNka4SCSU7NBVjR3TUviAPg5BK
 bgSxLrvg8Pb4i/udActzxZ7UqYKTupQYDDuMNazeQicUH39M8Hget/af6Dt5+LdGPBTBd2
 0pKs2J32DQfKAO/wDLaHnMir4f+rDyojhEUg16wLC5QqIxzzgcim/uLF3y1w
X-ME-Proxy: <xmx:Vnt8avNwIC7DXHSrcNRpUPylRpVx11P04yrOt4CgNbc-FBiumkPGMw>
 <xmx:Vnt8ah10-b2fVMpSnJ4Y7_6eyz9-CihGUHAAf05-1Z_2Cb00jhymtA>
 <xmx:Vnt8atrd9-WrLxPX1DyqyRBH_Tt9izL5PymZL5miYxS3Hf26VyOriw>
 <xmx:Vnt8arfZJEEXjfqWnvRjGWn0XEkROxQMQrjnond2Zg18HBrc-a5XCw>
 <xmx:WHt8anzEn7z7NEvgn6EHrWmrIkslIOyis6v34LNptVCZpVeJgvyPKFWm>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 09:55:34 -0400 (EDT)
Message-ID: <18a946ef5252d04cf2cfdea71464df7dba8ebfd4.camel@alistair23.me>
Subject: Re: [PATCH v4 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
From: Alistair <alistair@alistair23.me>
To: Flavien Solt <flavien.solt97@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, Tao
 Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis	 <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu	 <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier	 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nutty Liu	 <nutty.liu@hotmail.com>
Date: Wed, 12 Aug 2026 23:55:33 +1000
In-Reply-To: <20260727-qemu-mrif-v4-v4-1-73e0890ad395@gmail.com>
References: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
 <20260727-qemu-mrif-v4-v4-1-73e0890ad395@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=alistair@alistair23.me; helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-07-27 at 15:22 +0800, Flavien Solt wrote:
> iommu-testdev writes ITD_DMA_WRITE_VAL with unspecified requester
> attributes. RISC-V MSI remapping tests need to select an interrupt
> identity in the payload. The MSI trap also identifies the device
> through
> MemTxAttrs.requester_id.
>=20
> Add a write-value register with the existing constant as its reset
> default. Populate the requester ID from the PCI function. Existing
> translation tests retain their payload while interrupt-remapping
> tests
> can issue a valid MSI for the test device.
>=20
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
> Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/misc/iommu-testdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 ++++++++++++--
> =C2=A0include/hw/misc/iommu-testdev.h |=C2=A0 1 +
> =C2=A02 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
> index 15eb6de..6428a57 100644
> --- a/hw/misc/iommu-testdev.c
> +++ b/hw/misc/iommu-testdev.c
> @@ -28,6 +28,7 @@ struct IOMMUTestDevState {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t dma_paddr;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t dma_len;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t dma_result;
> +=C2=A0=C2=A0=C2=A0 uint32_t dma_write_val;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool dma_armed; /* armed until a trigger consume=
s the request */
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 AddressSpace *dma_as;=C2=A0=C2=A0 /* IOMMU-media=
ted DMA AS for this device
> */
> @@ -80,6 +81,7 @@ static void
> iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Initialize MemTxAttrs from generic register. =
*/
> =C2=A0=C2=A0=C2=A0=C2=A0 attrs.secure =3D ITD_ATTRS_GET_SECURE(s->dma_att=
rs_cfg);
> +=C2=A0=C2=A0=C2=A0 attrs.requester_id =3D pci_requester_id(&s->parent_ob=
j);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 space_valid =3D ITD_ATTRS_GET_SPACE_VALID(s->dma=
_attrs_cfg);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (space_valid) {
> @@ -97,12 +99,12 @@ static void
> iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 as =3D s->dma_as;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
> +=C2=A0=C2=A0=C2=A0 /* Step 1: Write the configured test value to DMA add=
ress */
> =C2=A0=C2=A0=C2=A0=C2=A0 trace_iommu_testdev_dma_write(s->dma_vaddr, s->d=
ma_len);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < s->dma_len; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Data is written in li=
ttle-endian order */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_buf[i] =3D (ITD_DMA_WRI=
TE_VAL >> ((i % 4) * 8)) & 0xff;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_buf[i] =3D (s->dma_writ=
e_val >> ((i % 4) * 8)) & 0xff;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 write_res =3D dma_memory_write(as, s->dma_vaddr,=
 write_buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dma_len, attrs);
> @@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void
> *opaque, hwaddr addr,
> =C2=A0=C2=A0=C2=A0=C2=A0 case ITD_REG_DMA_ATTRS:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D s->dma_attrs_c=
fg;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case ITD_REG_DMA_WRITE_VAL:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D s->dma_write_val;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> @@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void
> *opaque, hwaddr addr, uint64_t val,
> =C2=A0=C2=A0=C2=A0=C2=A0 case ITD_REG_DMA_ATTRS:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dma_attrs_cfg =3D dat=
a;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case ITD_REG_DMA_WRITE_VAL:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dma_write_val =3D data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice
> *pdev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_paddr =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_len =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_result =3D ITD_DMA_RESULT_IDLE;
> +=C2=A0=C2=A0=C2=A0 s->dma_write_val =3D ITD_DMA_WRITE_VAL;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_armed =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_attrs_cfg =3D ITD_ATTRS_SET_SPACE(0,
> ITD_ATTRS_SPACE_NONSECURE);
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_as =3D pci_device_iommu_address_space(pde=
v);
> @@ -280,6 +289,7 @@ static void iommu_testdev_reset(DeviceState *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_paddr =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_len =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_result =3D ITD_DMA_RESULT_IDLE;
> +=C2=A0=C2=A0=C2=A0 s->dma_write_val =3D ITD_DMA_WRITE_VAL;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_armed =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->dma_attrs_cfg =3D ITD_ATTRS_SET_SPACE(0,
> ITD_ATTRS_SPACE_NONSECURE);
> =C2=A0}
> diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-
> testdev.h
> index 3383659..2f4e931 100644
> --- a/include/hw/misc/iommu-testdev.h
> +++ b/include/hw/misc/iommu-testdev.h
> @@ -81,6 +81,7 @@ enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 ITD_REG_DMA_ATTRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0x18,
> =C2=A0=C2=A0=C2=A0=C2=A0 ITD_REG_DMA_GPA_LO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D 0x1c,
> =C2=A0=C2=A0=C2=A0=C2=A0 ITD_REG_DMA_GPA_HI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D 0x20,
> +=C2=A0=C2=A0=C2=A0 ITD_REG_DMA_WRITE_VAL=C2=A0=C2=A0 =3D 0x24,
> =C2=A0=C2=A0=C2=A0=C2=A0 BAR0_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x1000,
> =C2=A0};
> =C2=A0

