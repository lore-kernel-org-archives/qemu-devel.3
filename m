Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA91CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBad-0003Na-Eh; Wed, 12 Aug 2026 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBab-0003NN-EI
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:14:01 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBaY-00053a-RD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:14:01 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2E65E140008D;
 Wed, 12 Aug 2026 12:13:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 12:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1786551238;
 x=1786637638; bh=PBFdGDCdT3ibKoSh6aeELnaeqDG556fU39GTemxf/tc=; b=
 f74CAXz1HsvmkuJqVxX4ZqfHC50MSp25I+aubKnFwuuz6I5Qa7RVNtjGSKtU7MMU
 +fQ0Ej4/hqaxwLGLVawti04QQ7TA1aoZp6w+Rmpto08x+2/IscBu6xZaytAXOg85
 Y8Wd/UOUf57uf+3ILFBnLUqu28cOLfCom9sgZ3BJRYjsCOLw4ZpFnmv+h8TvI4jl
 DitYYw0SD4TwGthCc0wRRHyLLpFbEz4490wCAusrlX998+0W6ne1MdqnNtStSNd7
 /7TPgSS1BrL7z3H7ETgvKEAVWRTz0RDrJvGtlyWMuh4UhRlUv+Vf4e6PLgtIDZVB
 YYsVupvgllk6k/NCw0hqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786551238; x=1786637638; bh=P
 BFdGDCdT3ibKoSh6aeELnaeqDG556fU39GTemxf/tc=; b=CCFNGJgNfqOudQAmV
 WZeKYzyLNc7VrCevMF+FP4tk9gxLmFjRIA3lufzb+tcOwZZ7/5ss9hqEcSc80WMY
 OHYpR8O/aVhKPv4rRum+j00GWgtqKoyPeWeVJAUuiCVrkgCXWaFbUktOXFuPM8j2
 rclDZ63vFZ7WSxWcarjbipZfGez8GNlO2iBjc/nJteo0stYKsmAwyOpYpXiNoKkd
 jnnHPkC19RLIRo13rrT4hcFCjjCv4WRAWk/KLPX69jrHaEPVRHzs54jzfqmxcg0P
 gJcNbHaYEp9LmAVdNFbIKlVTxoXJAX2NFg0nGNrV5iN07BqHlvFNcVYOrfUSdb19
 UwJ5g==
X-ME-Sender: <xms:xZt8ahkNM33VNoJANB7fITpgvuvyGouEZZ19HTNrRLT1_RVSEPKH0Q>
 <xme:xZt8apL2N6_VcrYaPjFsZKZtCMsSedq0dObIUe5x795IaFGl27_mBPh6W4KTKlOIJ
 QRWFuggSO6C8_14a8JQSApaeBpy0KWBGPqRVb7BFseKINX1jwz_3uY>
X-ME-Received: <xmr:xZt8aqYx8tshF2GnibOiVr7CIpbeQqMj-qfhiF7hP1aoRNIqKMlLZ-A69r0NvcpcHXMX4A>
X-ME-Proxy-Cause: dmFkZTFxrRjOFtMe8RX8vWtbFQk3KUj4tqhREesQduyAIhwMkvILA9a9umlDItRtIt0TCc
 LLSbF8gHotGdHPQpf7bgFSbxI6HcX5sfyig2+uO2ERjiaAAl7y28r0eYeYY1BXNJ7Vmmav
 I1xZEeCZcPoiFpAHmh8K5Hc7x1fPcA6Cp4XImCw7zrLGoSu/HDV2JC5KMe1lPattbgbJIO
 AVoIb4lASyLVJOtTdr5BN9oD2nMhttw6G9K17A3+bcBrtc5jCkCzXPK6WbYZ5BbBOswOAz
 yuirPbHY6V7D14BJXdOAbMwZQB6pobwILUp93jCn24rtDcEvBB7FhRufLYtv68bfdsIbLd
 Un5zNL7R40kl8MubUvl4b8z3gm9UpEqBc2ZikbIK5KjBWXLfW8i5QJQieY1vKrrCUYLRcA
 g8FetPTXrApjXMc0571skG/VmDZlYHHmVcEaS9EV1UMqanW5fkbBJrE+bx8RLPJMywenXO
 DQw8B/1DYelzGyA1iEumsIRqMG9KMGFImIJ724RxLW+7sljlfGOJFA27+8+/NjMLbQyWJ4
 cgbmVC07abkBCcDUSttvtWYLCHMtEK+LGQUtjLGLQ2bRhS12T7vKqcCoRopWoiIMOSDAmq
 nbiWuTPiATtFfABwFEoD0HiEuKj8bq++LZ3RGDgUCoz/CXLaw4BI/jMP6jAg
X-ME-Proxy: <xmx:xZt8ajbnVdAhz8oBvfIOTmr7TsA6M4wi_2vA2Mgia4VJWAXuR9qfSQ>
 <xmx:xZt8ainsXhBz3G2fk07F3QDB87BmkqBbiRm5-_NPfl6_Oq6TCQcG5w>
 <xmx:xZt8anysPaynBfBaLFjta1ng-yUVAT2csnWTTK7b2UM_NVFltC0S3g>
 <xmx:xZt8aoNWUDPAq81hRkb-qutNqi_ixQOVUdMKpgcCKSKSLudS7czlfQ>
 <xmx:xpt8as72RdXqqQcdxcia6_jxQLvuMhOyad_HswuN3aIYU-rR0Ctq77cS>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:13:57 -0400 (EDT)
Message-ID: <4d56aa849324980065070f85c05aa45f24180ac5.camel@alistair23.me>
Subject: Re: [PATCH] hw/riscv/virt: add dram-base machine property
From: Alistair <alistair@alistair23.me>
To: lists <lists@ecloud.org>, qemu-devel@nongnu.org
Date: Thu, 13 Aug 2026 02:13:56 +1000
In-Reply-To: <EB2AEA1E-D748-4448-8824-722A91099AA5@ecloud.org>
References: <amscWwQvYUftUYW8@zen>
 <EB2AEA1E-D748-4448-8824-722A91099AA5@ecloud.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-a1-smtp.messagingengine.com
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

On Fri, 2026-08-07 at 14:26 +0300, lists wrote:
> Ping.
>=20
> Do you have a different solution to emulate memory layouts of actual
> boards?

The ideal answer is to model the board

>=20
> For me this is necessary for the Plan 9 porting work: a Banana Pi F3
> has a different base address than one of the K3 boards, and both
> different than the QEMU default.

The Banana Pi F3 and the K3 will also have different hardware blocks at
different addresses. The starting address of memory isn't the only or
even the main difference.

I don't see how just changing the memory address fixes an issue for
you.

>=20
> > On Jul 30, 2026, at 12:42, Shawn Rutledge <lists@ecloud.org> wrote:
> >=20
> > =EF=BB=BFThe 'virt' RISC-V machine hardcodes its DRAM base to 0x8000000=
0.
> > Real-world RISC-V SoCs put DRAM elsewhere (SpacemiT K1 at
> > 0x40000000,
> > SpacemiT K3 at 0x100000000, etc.), which forces ports that target
> > those boards to build separate kernels for QEMU testing.

RISC-V SoCs can locate their DRAM at any address, that is true. But I
don't see how just changing the virt machine address allows you to
suddenly test a K3 kernel on the virt board. The rest of the hardware
is still different

> >=20
> > Add a 'dram-base' string property that lets users move VIRT_DRAM up
> > without rebuilding QEMU.=C2=A0 Values must be 2 MiB-aligned and at or
> > above the default 0x80000000 to avoid colliding with statically-
> > placed MMIO regions (PCIE_MMIO ends at 0x80000000).=C2=A0 Lower bases
> > would also require moving PCIE_MMIO/IMSIC/etc. and are rejected
> > with
> > an explicit error pointing at the cause.

Am I miscounting a 0? 0x4000_0000 is less then 0x8000_0000 so this
doesn't help for half of your examples.

Alistair

> >=20
> > Example:
> > =C2=A0qemu-system-riscv64 -machine virt,dram-base=3D0x100000000 -m 6G .=
..
> > runs OpenSBI at firmware base 0x100000000, matching K3 memory
> > layout.
> >=20
> > Signed-off-by: Shawn Rutledge <s@ecloud.org>
> > ---
> > hw/riscv/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 59
> > ++++++++++++++++++++++++++++++++++++++++-
> > include/hw/riscv/virt.h |=C2=A0 2 ++
> > 2 files changed, 60 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 51bac47a91..6ccc98842f 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -20,6 +20,7 @@
> >=20
> > #include "qemu/osdep.h"
> > #include "qemu/units.h"
> > +#include "qemu/cutils.h"
> > #include "qemu/error-report.h"
> > #include "qemu/guest-random.h"
> > #include "qapi/error.h"
> > @@ -1307,7 +1308,13 @@ static void virt_machine_init(MachineState
> > *machine)
> > =C2=A0=C2=A0=C2=A0 int i, base_hartid, hart_count;
> > =C2=A0=C2=A0=C2=A0 int socket_count =3D riscv_socket_count(machine);
> >=20
> > -=C2=A0=C2=A0=C2=A0 s->memmap =3D virt_memmap;
> > +=C2=A0=C2=A0=C2=A0 if (s->dram_base) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->memmap_storage =3D g_mem=
dup2(virt_memmap,
> > sizeof(virt_memmap));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->memmap_storage[VIRT_DRAM=
].base =3D s->dram_base;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->memmap =3D s->memmap_sto=
rage;
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->memmap =3D virt_memmap;
> > +=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0 /* Check socket count limit */
> > =C2=A0=C2=A0=C2=A0 if (VIRT_SOCKETS_MAX < socket_count) {
> > @@ -1545,6 +1552,7 @@ static void
> > virt_machine_instance_finalize(Object *obj)
> > =C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 g_free(s->oem_id);
> > =C2=A0=C2=A0=C2=A0 g_free(s->oem_table_id);
> > +=C2=A0=C2=A0=C2=A0 g_free(s->memmap_storage);
> > }
> >=20
> > static void virt_machine_instance_init(Object *obj)
> > @@ -1616,6 +1624,46 @@ static void virt_set_aia(Object *obj, const
> > char *val, Error **errp)
> > =C2=A0=C2=A0=C2=A0 }
> > }
> >=20
> > +static char *virt_get_dram_base(Object *obj, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0 RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +=C2=A0=C2=A0=C2=A0 uint64_t val =3D s->dram_base ? s->dram_base :
> > virt_memmap[VIRT_DRAM].base;
> > +
> > +=C2=A0=C2=A0=C2=A0 return g_strdup_printf("0x%" PRIx64, val);
> > +}
> > +
> > +static void virt_set_dram_base(Object *obj, const char *val, Error
> > **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0 RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +=C2=A0=C2=A0=C2=A0 const char *endptr;
> > +=C2=A0=C2=A0=C2=A0 uint64_t base;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (qemu_strtou64(val, &endptr, 0, &base) < 0 || *e=
ndptr !=3D
> > '\0') {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Invalid d=
ram-base value '%s'", val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * DRAM must clear all statically-placed MMIO =
regions in
> > virt_memmap[]
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * (PCIE_MMIO ends at 0x80000000) and be 2 MiB=
-aligned so a
> > standard
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * OpenSBI + kernel layout (firmware at base, =
kernel at
> > base+0x200000)
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * fits.=C2=A0 Values below the default base w=
ould collide with on-
> > board
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * MMIO and are rejected.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (base < virt_memmap[VIRT_DRAM].base) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dram-base 0x%" PRIx64 " is below d=
efault 0x%"
> > PRIx64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "; would collide with static MMIO r=
egions",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base, (uint64_t)virt_memmap[VIRT_DR=
AM].base);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 if (base & (2 * MiB - 1)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "dram-base=
 0x%" PRIx64 " must be 2 MiB-
> > aligned",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 s->dram_base =3D base;
> > +}
> > +
> > static bool virt_get_aclint(Object *obj, Error **errp)
> > {
> > =C2=A0=C2=A0=C2=A0 RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > @@ -1744,6 +1792,15 @@ static void
> > virt_machine_class_init(ObjectClass *oc, const void *data)
> > =C2=A0=C2=A0=C2=A0 machine_class_allow_dynamic_sysbus_dev(mc,
> > TYPE_TPM_TIS_SYSBUS);
> > #endif
> >=20
> > +=C2=A0=C2=A0=C2=A0 object_class_property_add_str(oc, "dram-base",
> > virt_get_dram_base,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virt_set_dram_base);
> > +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "dram-bas=
e",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Base physical address
> > of DRAM "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(default 0x80000000).
> > Must be "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "2 MiB-aligned and at or
> > above "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "the default to avoid
> > colliding "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "with statically-placed
> > MMIO.");
> > +
> > =C2=A0=C2=A0=C2=A0 object_class_property_add_bool(oc, "aclint", virt_ge=
t_aclint,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virt_set_aclin=
t);
> > =C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "aclint",
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 36a2def410..be8a4ac049 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -61,6 +61,8 @@ struct RISCVVirtState {
> > =C2=A0=C2=A0=C2=A0 char *oem_table_id;
> > =C2=A0=C2=A0=C2=A0 OnOffAuto acpi;
> > =C2=A0=C2=A0=C2=A0 const MemMapEntry *memmap;
> > +=C2=A0=C2=A0=C2=A0 MemMapEntry *memmap_storage; /* g_malloc'd copy whe=
n dram-base
> > override is set */
> > +=C2=A0=C2=A0=C2=A0 uint64_t dram_base;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* 0 =3D use compiled-in default
> > (0x80000000) */
> > =C2=A0=C2=A0=C2=A0 struct GPEXHost *gpex_host;
> > =C2=A0=C2=A0=C2=A0 OnOffAuto iommu_sys;
> > =C2=A0=C2=A0=C2=A0 uint16_t pci_iommu_bdf;
> > --
> > 2.55.0
> >=20

