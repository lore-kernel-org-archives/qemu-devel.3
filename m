Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9A4C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB9Z-0001yX-3F; Wed, 12 Aug 2026 11:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuB94-0001kQ-K1; Wed, 12 Aug 2026 11:45:36 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuB92-00014M-Es; Wed, 12 Aug 2026 11:45:33 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id D94E9EC0090;
 Wed, 12 Aug 2026 11:45:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786549530; x=1786635930; bh=H2taE+TSF0cxM29f7CIUo9IWotKHp9rx
 j35ZnaCUN/Q=; b=fNMUQTW6lu6RdZxKLjKzMf5J+f/inInkbM86LCgtvLH8wBha
 40h8ilBhTtaJxi6qHpvzxy2e2aWc/abeZrEHMm168LHZQiH7Qmy2DxerpmOOULuy
 d1pIAAQ1prFUxXjHceEhbjrNF97MmhzzzahzHngEPNUHeJk9IQESej7jlgCKuhXt
 cQPgHt1qAW1HSyzAnYMUkGGzA+1RJKPZSAqRaREhkecjlJUxM/OXwkKusm+faiWX
 NVqe8he/bvgpqBs8GWQbKRvdApZDWw62daH8FnQIBUiaxeyj+yctPEbZhl8KitRq
 if/CSh43RTDBMpdrzLUZTLO+gcFdIb37qPxSvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786549530; x=
 1786635930; bh=H2taE+TSF0cxM29f7CIUo9IWotKHp9rxj35ZnaCUN/Q=; b=k
 5AGanN7Sxg5TchD/fHpCKVEtAOXwjq3HW7+vvDtewPUZUuw0P8rgnAxxx4hgJju9
 jBRrwp1zixh6iD9g8gCob3DQvAnPO9nuQi6LrjbO1J3mWjmPcDneOcsF6PczeYJF
 1ElvyOmY0L7JK4FsEERakTIBCsefd160ilai3YBCr0mywbxi5Tna48HpDhn/oqdo
 i3ZAXcBwn0AjBseJjO8MfrRN6j5Za6M9Y4i0lCJDelS/jGsa48SwpE7gYMlDKdBK
 ZViGUK81xA08uBhZDHtisF7HbJX4DPcrAEBKd7LxFM14xi8ys/JpkD6RexrSXYpu
 Ef1Kt25QncyMx2KhYLG2w==
X-ME-Sender: <xms:GpV8atXMqD3UITiOabmILxswmBazH-tU3PXV33bKMozpXjEi6BHInQ>
 <xme:GpV8apDi2MFYWcV3Kui2api-P4zRhgpwXqSCpLQY8IKAIJQrtgxGG8kqIy02j-J5b
 IUENq4co7kDVahWZWpmY9EMm4sqCpze8qG1Z06HGB1e8VOnVu0BmU6t>
X-ME-Received: <xmr:GpV8as7qkKlDQAsmfwqr8BSqL5djXQPC1OjpV2Fao-_jON9FPXlsGu6p_C2DfM5AQxjaGA>
X-ME-Proxy-Cause: dmFkZTEth25Dilrpzz09lG7sN220K9Ycbo5LXY95nJ5vRQLPWFKXzebe0GuuzRLktdF5tB
 YJJtN4h3uZTkrjyFu8W3AAf8EWa/O4U0Ymue33mThn9dUVl69EWWooiqaDPMNKLHGzoI//
 7yivHdq+TVAB7JSUy1ihmeNHM3R+IDaIIx5RpasRODz7Zqs0MpkzRuBdXXf9H5ZtzeyRqa
 oQQiFw92LZ9JUy1t6fs1MD9xZk93FnMgfEtEFn9ytQD0vfzF0peegOUic98hYX+90qJ9aJ
 eT0zpMkrv5Bsn2zT/wUenH6Hu3xX3KgNDL+Rnscw49gj1LrYCL/pvnjWpiI5kMatwZyUTY
 qZYbho50Vqxsi3juz0CVDdqxM2NT7DcfNme22YDvaGzBhDFAz9+dD5iyNJE+9cpiVlUXRe
 jLbuC5umM1C9xOuaevx6aGVFx6DSAA3bVZksaJmIDKNLQljhVaMv4t0bxeF1uY404VQGMR
 qjx3gvyCwEzKfZBl3wHZGGx+7iUEGXOv2ADM897UQLXgghnA4FMLugLhwr36BBTnZU1ujD
 rsDPPhTMGu4nzaKfStgQYT/Qd+k553hCV5FinLH5cu79ZTwOuIe51Xg8dhdllAgjoz5KYM
 X/b6PjTyvHooEaXzTtUeARYPD29wphVcTmgrQMt7aN8TpLbEvv7xWOlWyrqA
X-ME-Proxy: <xmx:GpV8akz0vZrtmKNnqghtlhzoBe6_rQXiLdYG93rGyHYET_pndanxpQ>
 <xmx:GpV8ajzff01_Fn75MPjnX8yJA6iC8YBfq_8IavJXZvYHR00GpXruiA>
 <xmx:GpV8aswe8zqWWiBFMnrLriOph-ncqxuMAAOwbdQsZzDN5gK8wZhZMA>
 <xmx:GpV8atYhVQi0t5lxDGsERKmq5qGxcLCGY58GU79tHQrZA4yChcEXaQ>
 <xmx:GpV8agB4U4OPOtov-kjxGsW9XCPSzdCvGpsYObTb7q9A_F3LCmbHhhlP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:45:29 -0400 (EDT)
Message-ID: <8a94c5464253a495c3bdfc67ee5e31f6014eb025.camel@alistair23.me>
Subject: Re: [PATCH 07/26] hw/sd: sdhci: Migrate the Host Control 2 register
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
Date: Thu, 13 Aug 2026 01:44:53 +1000
In-Reply-To: <20260723151853.2143177-8-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-8-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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

On Thu, 2026-07-23 at 23:18 +0800, Bin Meng wrote:
> The Host Control 2 register has been part of SDHCIState since its
> initial implementation, but it was omitted from sdhci_vmstate.
> Migration therefore resets the register to zero and can change
> tuning,
> voltage, or DMA behavior.
>=20
> Migrate nonzero values in an optional subsection. Clear the register
> before loading so older streams retain the reset default without
> changing the main stream version.
>=20
> Fixes: ea55a221bfc0 ("sdhci: implement the Host Control 2 register
> (tuning sequence)")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>=20
> =C2=A0hw/sd/sdhci.c | 20 ++++++++++++++++++++
> =C2=A01 file changed, 20 insertions(+)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 55a4abdd72..749de85476 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1470,6 +1470,24 @@ void sdhci_common_unrealize(SDHCIState *s)
> =C2=A0=C2=A0=C2=A0=C2=A0 s->fifo_buffer =3D NULL;
> =C2=A0}
> =C2=A0
> +static bool sdhci_hostctl2_vmstate_needed(void *opaque)
> +{
> +=C2=A0=C2=A0=C2=A0 SDHCIState *s =3D opaque;
> +
> +=C2=A0=C2=A0=C2=A0 return s->hostctl2;
> +}
> +
> +static const VMStateDescription sdhci_hostctl2_vmstate =3D {
> +=C2=A0=C2=A0=C2=A0 .name =3D "sdhci/hostctl2",
> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
> +=C2=A0=C2=A0=C2=A0 .needed =3D sdhci_hostctl2_vmstate_needed,
> +=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT16(hostctl2, SDHC=
IState),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
> +=C2=A0=C2=A0=C2=A0 },
> +};
> +
> =C2=A0static bool sdhci_pending_insert_vmstate_needed(void *opaque)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 SDHCIState *s =3D opaque;
> @@ -1488,6 +1506,7 @@ static int sdhci_pre_load(void *opaque)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 SDHCIState *s =3D opaque;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 s->hostctl2 =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 s->sdma_boundary_paused =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}
> @@ -1562,6 +1581,7 @@ const VMStateDescription sdhci_vmstate =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 .subsections =3D (const VMStateDescription * con=
st []) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sdhci_hostctl2_vmstate,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sdhci_pending_insert_vm=
state,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sdhci_sdma_boundary_pau=
sed_vmstate,

I feel like it should be added at the end, but I don't think it
actually matters

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL

