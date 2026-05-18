Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFBDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOxSB-0001Ww-Qf; Mon, 18 May 2026 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOxSA-0001Wa-7M; Mon, 18 May 2026 08:52:14 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOxS7-0005kV-Vv; Mon, 18 May 2026 08:52:13 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6BCCB7A0116;
 Mon, 18 May 2026 08:52:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 08:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1779108729; x=
 1779195129; bh=C7fSbjVCPZoTltSL4hbNmrMfviqycUus3l6tTM277v8=; b=V
 O3jqMuFWOX6R+/J++mV+XNhnnIBp5wCGEbqtaq9mMwVfGayptnZVXpujXDTq4TSo
 vdZhho0zpIBROwdP+4ZCTNTLC6YkDa6Z7d5FceFqe3br7TdxyaNFCM/bQ55+8/cL
 v6tHc9GYX7c8X6/ubFoDCvIsGm2VOgJUfPMdNHCVbhBfzAxASyYm3q9Dz7umGDQx
 re8/4jeawr+PO3Ujq5ezpbTymwjPwDU6Mcj+23etaoj8OTEg1mJvLVgosgz2/5bu
 5AiqZu6H094OenK1vN+nZThLupCesSKMJc6necy4svue+ze9xV5m2lwY7wr5HDhm
 sj+4ZiclwQr0vIo3DyGPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779108729; x=1779195129; bh=C7fSbjVCPZoTltSL4hbNmrMfviqycUus3l6
 tTM277v8=; b=V5H2PqC1O7QdD11nFlDBoIj+rQ8c8Yrhmfg1JXk6BPqtib4hmXB
 XDn3H/fhfmEIUTNQGiBcPc+fOURF35v4ck8QIIqOYoPgZGLO1fGDo5RQpi69EiJd
 fWV1wiEdZ+cCPF8Ul42lYlZTnHj4wlxwvBsfLq3lewO7W/jswJJNVtVeym0kzcx4
 gigCWZ1fZL1NKmdxHbZhYBXtOF0zM29LH1tSRHLOcvTBreKpRoEWfdg+w6wNw/kr
 6ZwuEoMHHvBuo94pOTefZsu6/ySZhfE2CM+5MgBjQpjCtIT4MGrbUVKD3aj0xAos
 Vnn7wBpiBmo0d6CCMJRZmedP92Cx556GtJA==
X-ME-Sender: <xms:eAsLar6XlbOBAJ_U-1O_0zpfl5ji2E_5WpHbGhaZASWiDM2Oi5XzDA>
 <xme:eAsLam7HMF2DJisXOloD8ALCItbFHlSBrrYiP-MXsNEp-Lx-CyP9T6JzZIPP0Mv-L
 MBjyOL5NtdprnhsRtnGfihUrRqxcxr1xEi6hUoVJ10F_aWMYMgdEA8>
X-ME-Received: <xmr:eAsLatQmGlJvid7ylWijsYo8atjTUGq57UbI-E-YScqCTNSFF_xj6xW5rFPMw7X3Kci-D-Ha4oY-3nBSgrahmhvt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehmrghtvghushiirdhnohifihgtkhhisehpohhsthgvoh
 drnhgvthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhope
 gurghvvgesthhrvggslhhighdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpth
 htohepvggslhgrkhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrrhhmsghruhes
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:eAsLau8Q59mrVnJ_PcwsRiowtf2jKVRXbNcXgAjt0aEnaerw8P6EeQ>
 <xmx:eAsLauaxZ8gVpqJiMjz5ou3S35fExLnTcV1vF05X9ieGpzZMUV2zLA>
 <xmx:eAsLavroe1QJjalIh-zfACVSV04kydf1IAmtn1I8ZuELoDR5FA97hw>
 <xmx:eAsLaiQS2dUkx26Esa7LpWJeu4iSF92xKeBG5TWvlqFK6iOYslxiHw>
 <xmx:eQsLarGTsVlmOvv5tgN6xZDtvoC0yjnLErkFFftemWIv1VijIpYcXC4H>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:52:07 -0400 (EDT)
Date: Mon, 18 May 2026 14:52:05 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/nvme: add 'info nvme' HMP command
Message-ID: <agsLdWIugBvTxz8W@AALNPWKJENSEN.aal.scsc.local>
References: <cover.1778409416.git.mateusz.nowicki@posteo.net>
 <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hjHZqU+6Yz/HSXJp"
Content-Disposition: inline
In-Reply-To: <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


--hjHZqU+6Yz/HSXJp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10 10:57, Mateusz Nowicki wrote:
> Add an 'info nvme' HMP command for inspecting emulated NVMe
> controllers from the QEMU monitor.
>=20
> For each NVMe controller in the QOM tree the command prints:
>=20
>   - PCI BDF, vendor/device ID and BAR0 base address;
>   - Identify Controller fields visible to the host driver: SN, MN, FR
>     and CNTLID;
>   - the CC, CSTS and AQA registers (raw 32-bit values);
>   - the number of admin and active I/O submission/completion queues.
>=20
> Useful when debugging the Linux NVMe driver against the QEMU emulation
> without attaching gdb to the QEMU process.
>=20
> Example:
>=20
>   (qemu) info nvme
>   /machine/peripheral-anon/device[0]
>     PCI:    BDF 00:04.0  VID=3D8086 DID=3D5845  BAR0=3D0x00000000feb50000
>     ID:     SN=3DNVME0001  MN=3DQEMU NVMe Ctrl  FR=3D...  CNTLID=3D0x0000
>     CC:     0x00460001
>     CSTS:   0x00000001
>     AQA:    0x001f001f
>     Queues: 1 admin + 4 IO SQ / 4 IO CQ
>=20
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> ---
>  hmp-commands-info.hx | 13 ++++++++
>  hw/nvme/meson.build  |  2 +-
>  hw/nvme/monitor.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json    | 17 ++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor.c
>=20
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..b984691c3c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -340,6 +340,19 @@ SRST
>      Show guest USB devices.
>  ERST
> =20
> +    {
> +        .name       =3D "nvme",
> +        .args_type  =3D "",
> +        .params     =3D "",
> +        .help       =3D "show emulated NVMe controllers",
> +        .cmd_info_hrt =3D qmp_x_query_nvme,
> +    },
> +
> +SRST
> +  ``info nvme``
> +    Show emulated NVMe controllers.
> +ERST
> +
>      {
>          .name       =3D "usbhost",
>          .args_type  =3D "",
> diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
> index 7d5caa53c2..3017f058f9 100644
> --- a/hw/nvme/meson.build
> +++ b/hw/nvme/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c',=
 'ns.c', 'subsys.c', 'nguid.c'))
> \ No newline at end of file
> +system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c',=
 'ns.c', 'subsys.c', 'nguid.c', 'monitor.c'))
> \ No newline at end of file
> diff --git a/hw/nvme/monitor.c b/hw/nvme/monitor.c
> new file mode 100644
> index 0000000000..95a6754437
> --- /dev/null
> +++ b/hw/nvme/monitor.c
> @@ -0,0 +1,76 @@
> +/*
> + * QEMU NVMe Controller monitor commands
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "qapi/type-helpers.h"
> +#include "hw/pci/pci.h"
> +
> +#include "nvme.h"
> +
> +static int collect_one(Object *obj, void *opaque)
> +{
> +    GString *buf =3D opaque;
> +    NvmeCtrl *n;
> +    PCIDevice *pci;
> +    pcibus_t bar0;
> +    unsigned io_sq =3D 0, io_cq =3D 0;
> +
> +    if (!object_dynamic_cast(obj, TYPE_NVME)) {
> +        return 0;
> +    }
> +    n =3D NVME(obj);
> +    pci =3D PCI_DEVICE(n);
> +    bar0 =3D pci_get_bar_addr(pci, 0);
> +
> +    for (unsigned i =3D 1; i <=3D n->params.max_ioqpairs; i++) {

I think this needs to run over n->conf_ioqpairs to also work for SR-IOV
VFs? Same goes for patch 2 I think.

> +        if (n->sq && n->sq[i]) {
> +            io_sq++;
> +        }
> +        if (n->cq && n->cq[i]) {
> +            io_cq++;
> +        }
> +    }
> +
> +    g_string_append_printf(buf, "%s\n", object_get_canonical_path(obj));
> +    g_string_append_printf(buf,
> +        "  PCI:    BDF %02x:%02x.%x  VID=3D%04x DID=3D%04x  ",
> +        pci_dev_bus_num(pci), PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn),
> +        pci_get_word(pci->config + PCI_VENDOR_ID),
> +        pci_get_word(pci->config + PCI_DEVICE_ID));
> +    if (bar0 =3D=3D PCI_BAR_UNMAPPED) {
> +        g_string_append(buf, "BAR0=3Dunmapped\n");
> +    } else {
> +        g_string_append_printf(buf, "BAR0=3D0x%016" PRIx64 "\n",
> +                               (uint64_t)bar0);
> +    }
> +    g_string_append_printf(buf,
> +        "  ID:     SN=3D%.20s  MN=3D%.40s  FR=3D%.8s  CNTLID=3D0x%04x\n",
> +        n->id_ctrl.sn, n->id_ctrl.mn, n->id_ctrl.fr, n->cntlid);
> +    g_string_append_printf(buf, "  CC:     0x%08x\n",
> +                           ldl_le_p(&n->bar.cc));
> +    g_string_append_printf(buf, "  CSTS:   0x%08x\n",
> +                           ldl_le_p(&n->bar.csts));
> +    g_string_append_printf(buf, "  AQA:    0x%08x\n",
> +                           ldl_le_p(&n->bar.aqa));
> +    g_string_append_printf(buf,
> +        "  Queues: 1 admin + %u IO SQ / %u IO CQ\n", io_sq, io_cq);
> +    return 0;
> +}
> +
> +HumanReadableText *qmp_x_query_nvme(Error **errp)
> +{
> +    g_autoptr(GString) buf =3D g_string_new("");
> +
> +    object_child_foreach_recursive(object_get_root(), collect_one, buf);
> +
> +    if (buf->len =3D=3D 0) {
> +        g_string_append(buf, "no NVMe controllers\n");
> +    }
> +
> +    return human_readable_text_from_str(buf);
> +}
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..d4a589e768 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1772,6 +1772,23 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
> =20
> +##
> +# @x-query-nvme:
> +#
> +# Query state of emulated NVMe controllers.
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: NVMe controller state as human-readable text
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'x-query-nvme',
> +  'returns': 'HumanReadableText',
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @SmbiosEntryPointType:
>  #
> --=20
> 2.53.0
>=20
>=20

--hjHZqU+6Yz/HSXJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmoLC3IACgkQTeGvMW1P
DelKNgf5AZlQXRAZTo+a63NY7WTLif7NpjsUp//7zm5ZMEmu2wiRi0TidnOhI/jp
4xx4f+X5xpOootAZcWrOMM0TfKVU6GSAIjfQOZwVQ1XfoZ+xAMpf/E8hGmdtQVUd
OpX7nDjyMymBcqHxqQNeHaSg00wIpGTmaY739/L99qMX6f8aYLViXv/A9MU4wrlX
YCJk2XyLqsuPvjDc0jN/gd45ZJwc++ISMkaQAB8kDUN6utEWyIHscr/fuCUqA/7d
GqoDDJxO7sov7DPb6ABXFtyDc/zthkmCQ7JYtsfDw9HHM6X//6Pj/ThcDuIdN1jJ
B7gEh3+G5uUA2Ki9fQAKN1z+Dav01w==
=AkEr
-----END PGP SIGNATURE-----

--hjHZqU+6Yz/HSXJp--

