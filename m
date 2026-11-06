Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753E606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=OcvYHHGM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tFPnt6VR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJu0-0006kv-D7; Fri, 06 Nov 2026 08:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xPJtx-0006kM-PG
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:22:41 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xPJtv-0007eZ-EL
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:22:41 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5D4BC7A00BA
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2026 08:22:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 08:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1793971356; x=
 1794057756; bh=EZMXIiOIhcX9DSEsmXwMLO5Xs9HAhIX6n7Hxvfdmnbw=; b=O
 cvYHHGMVa/FftxrRM2WYhJjlNmSUn+WuW8OztS+Ezht27RXCMXnzWS13+p/KAHeR
 uN9fwFR2QMCO2Oh/L33hUVgn2tTwvsYhF0y/iyAucIgpOSXYzvCC3LCJQtZt3WO5
 ilBYUnM464OGgIQgen5UdngNEIZnS0uvfkfu1362OT3dErcsl9B1S6AXeGjO6kiw
 lK6R3MrXB1xqzFvZEWj6vDnNRB8gKPXF5hSy2bKy0pOHKkpsizWOE6P3BU/bRuEn
 wu4Mghc57EKcI8B32PStAAOHm5WBTmsLf35lA+SEWgddxHSLhE+ei9UvhpeGsbJE
 dbtJDcGQxmDGD6I5Dv2oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1793971356; x=1794057756; bh=EZMXIiOIhcX9DSEsmXwMLO5Xs9HAhIX6n7H
 xvfdmnbw=; b=tFPnt6VRhlyIQqR/dG26Qrtsmiz5JPvkTyzx2XhvNfjdItzHiyN
 92ChiEJXbhu/nFDnlgDluGr2O6LFMIQf6aSzkf2ohCC2ksq4HW9fMYTFkNKJJxbY
 i9Xw2bCqy0UXIzU3IweEKkaa7jnQRgMJoLu56wTVURC8nOK3KuOutX1wTQVTTXwZ
 YoTBr5C2y6cRS1Wtx72uuyP8g6KGaEoPZYgC+8kRbwNx5Z74HJHmAhHkM7y2INaA
 Hp2UhgEGygRZR5af4/vvI9Ok0DS0CNuONImb1X/8aVZEMPDz6liFSpkv9/PuWQJp
 lspPCBWyuT51Eg2vTQ4m0j4nSi1CAlf3qFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793971356; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:gwLvmFxtEEC3ZP5c4Z3pW2Hn1JohqFfzbzW6rOxda/vOaae
 5yQZRPuU5wC4T8OlQtlXoZRiyu5riIN5MRXjTGwx7WDOrfiAOIttY7+AgXlq+shh
 IXzs1dJxaedq+JMVJiMCMFAotmjVPWH45c2MP52qaEC50AJIj4Cz+5lxB/Fwq5dk
 l8OB0ewTWmsEqHAF0WNGEtOHZZhOWpcAuYY0TLQP8Gghmxhm861ikqk/HsrJTkIt
 jaNRoq//qLALhVAPEvjXcpsx446dBgMbo1/pSCkdKi7t65Mx54oCHTs7gIcWN7pC
 Kwbbq7cvIiUal3bi+1CzaOpCTZ2wFj4KA1adPUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Y9bSG4tnnwIoFpBTN8q/yRmHIydDeTyS1MwQaIyNgbs=:yDag5wD5ghLvFOhhY8o48WnsLDWomlxa8Uj80Y7mP80=;
X-ME-Sender: <xms:m9Ttas7IWTbs77n6vx2nF8p5hkZxkAlRNkKpYVxvd3EihO_rogBJHg>
 <xme:m9Ttam3th5RkAMHUUkDyCdR1N4Dk_TADw07-66tXwaBwk1iwAlReFVfxA68-FIkkG
 c-Dxybw6G9FuyjMU-cvXC60mjOA_eNRoPFZCZmENmuZJDWLnrV1dMf_>
X-ME-Received: <xmr:m9TtanBN5Rm0TSfeWZo8RNuNYX-ZTL2wIOb2pdkKh7hFseUPu_lXm-hILAa4zsyg1LqyBmHTQznFdBEgAveDbrVB4NOD5Xk>
X-ME-Proxy-Cause: dmFkZTEiTcK2Ib/nyMUbYLdj1a7n50nvkdHLLrsWMRblt8gicHT8mX8VgsmR3sgSWLoLo+
 rK2kIR1GYCetUWdtE5se1RmAKO1R3RtfwAI9DqetUSi2k42wKk/8sX6wI3WyAUc0s/Oe1e
 7lmlC5/w3uCFNHqHNV1THjnhrkDABMNfLZbRHthbuJ+9pCOf5TviOZCGnmUwyxOO0Yxp2Y
 3TzzJPB6ey1g+ZE7MPsYvDuC/02qdgs/PKREPzjSzCeG13LrAxkzUoCqztGiDI5jI/gGZt
 e5Ng7o4yLSEAvbl+1g+yfmVFH0t7bXgn78LYzYqxsFu6+nsdMAj6+cV60bC6gaVQlhFxjO
 jfSPxlTHqyEqbHSOSr1Vws25yD/n/eqYAbp2PF2A9kbNL7EM80XZNlEyppUTDbmLv2UnOX
 NOieHlDhY84Jpqg5cIDbJOSsQEKVsOnkm/k5cxgMuhciaM76I/d7o2H+e8BI9zyH2vixnb
 MwmnsYw/36bgi/hI5JiX7c3aCMU5yM744+TF2Nej3g5X+dzun4xEoSZy0VTrIh6gAvIxMD
 QVUAuR8oHdl/SdJRVS7GBlWJbP63ymAAa1vla3knUikRlXUyAaLpNI2pd2+8iW39utrTkO
 serDLMqhT7QixdrwHl6YJ83Ca0FKRftg+mU0mCj1GMAI7ejNXlwTzffqao/A
X-ME-Proxy: <xmx:m9TtahPa5YQBsNwdw5lHvhffwuy6A-1b-F482BjopXx3JMEHnNqLog>
 <xmx:m9TtasZGEuR4x6Vdxx8C5JZLk12im4yhVuOM6grtWB_pNAgHh8T9ZQ>
 <xmx:m9Ttagt2011UyDiRKHctmue8pqRvdQ1BjWEux_Q86I1piO1AqgY9oA>
 <xmx:m9TtauPzsLG4vN7BS--xUgUSwssxeR9ebr-tUK6GA4kbmyXhDUfKwA>
 <xmx:nNTtarSUOqG7moN2ARhwbjfjyACjsQ7DmWjQ12CkqartiiFZ2AIeyFXn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 08:22:34 -0500 (EST)
Date: Fri, 6 Nov 2026 14:22:33 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Markku =?utf-8?Q?Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 0/3] hw/nvme: fix legacy INTx handling
Message-ID: <au3UltfFbwnhVmJZ@AALNPWKJENSEN.aal.scsc.local>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hMtmdCsygABTTgyd"
Content-Disposition: inline
In-Reply-To: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--hMtmdCsygABTTgyd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 23 15:20, Markku Ahvenj=C3=A4rvi wrote:
> This series fixes three cases where an NVMe legacy INTx interrupt may
> remain asserted, causing an interrupt storm in the guest:
>=20
> * cq_pending can underflow when a doorbell notification is processed for
>   a completion queue that is already empty.
>=20
> * A stale CQ event index can cause the guest to suppress a subsequent
>   MMIO CQ doorbell write, preventing QEMU from observing the updated CQ
>   head.
>=20
> * Controller reset does not clear pending CQ interrupt state.
>=20
> Without these fixes, a Linux guest using legacy PCI interrupts may see
> the following:
>=20
> [    2.058360] irq 23: nobody cared (try booting with the "irqpoll" optio=
n)
> [    2.058724] handlers:
> [    2.058820] [<000000006a09281a>] nvme_irq
> [    2.058966] [<000000006a09281a>] nvme_irq
> [    2.059113] Disabling IRQ #23
>=20
> I reproduced the interrupt storm with Linux 6.12, 6.18, and 7.2 by
> booting the guest with pci=3Dnomsi. The cq_pending underflow occurred with
> ioeventfd=3Don, but its fix covers both ioeventfd=3Don and ioeventfd=3Doff
> configurations. The stale event-index issue occurred with both
> ioeventfd=3Don and ioeventfd=3Doff.
>=20
> The following command was used to reproduce the interrupt storm with
> ioeventfd=3Don:
>=20
> qemu-system-x86_64 \
>       -machine q35,accel=3Dkvm \
>       -m 2G -smp 2 \
>       -kernel ./linux-7.2/arch/x86/boot/bzImage \
>       -append 'console=3DttyS0 root=3D/dev/nvme0n1p1 rw pci=3Dnomsi' \
>       -drive if=3Dnone,file=3D./guest-image.qcow2,id=3Ddisk0,format=3Dqco=
w2 \
>       -device nvme,drive=3Ddisk0,serial=3Dtestserial0,ioeventfd=3Don \
>       -nographic
>=20
> The controller-reset fix addresses QEMU issue 4142:
> https://gitlab.com/qemu-project/qemu/-/work_items/4142
>=20
> I was unable to reproduce this issue with a Linux guest, but a
> controller reset must clear the CQ interrupt state and deassert the
> interrupt line.
>=20
> Kind regards,
> Markku Ahvenj=C3=A4rvi
>=20
> ---
> Markku Ahvenj=C3=A4rvi (3):
>       hw/nvme: prevent cq_pending underflow
>       hw/nvme: fix missed CQ updates
>       hw/nvme: clear interrupts on controller reset
>=20
>  hw/nvme/ctrl.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> ---
> base-commit: 7074591d7954876951f84c15b994a43251d5a3c1
> change-id: 20260922-nvme-intx-fixes-10b70b6520ba
>=20
> Best regards,
> -- =20
> Markku Ahvenj=C3=A4rvi <mankku@gmail.com>
>=20
>=20

Looks good!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--hMtmdCsygABTTgyd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmrt1JYACgkQTeGvMW1P
DekrCgf/XnxVOL+v19Zt1u1gGV4ThQAP4a9X28Mh8Uqw1eGy8d7dDcfLXHem2Xex
ZOfuAvRRWUACYtLYP7HrqsOTv0fHHgM22YIPIoq+kJS9+VH4AeRgt70ZIAfN3sDZ
1UU34lZzvdA7dk46sNfsthwgO7X5hiwA2XLMkoTiZcBdbn5LTdlhkj+o6ngwlEod
kvDZYd/oTObbS9he+G/nJn64aQRpUXtoR5cfYSeIm/OF80z76WLXkMXszkKzpdSF
Xydq+wsG2kDzVircR341gHur3Lg/O5i4CpmDIiTt6u7I7I9qDrOxYZhTmap6orq0
FlQAOdRk+wOCcCMm3RkP89Eo3Qdm2A==
=NYwz
-----END PGP SIGNATURE-----

--hMtmdCsygABTTgyd--

