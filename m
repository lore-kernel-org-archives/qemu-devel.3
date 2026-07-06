Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02C2C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglLO-0007VN-HF; Mon, 06 Jul 2026 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wglLH-0007Ut-SO; Mon, 06 Jul 2026 11:34:44 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wglLF-0001R3-P3; Mon, 06 Jul 2026 11:34:43 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id A8DA9EC00C0;
 Mon,  6 Jul 2026 11:34:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 11:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783352080;
 x=1783438480; bh=eg2L72sAYQFyQ/5fUltSJJCd7RU9lNyZO0unZiBzKF0=; b=
 HHUyvDIl3ZefqH+rrxTT4EYpt7rDSxQFlF3vTuh9vszPgHEHjwyQivEXezv+WLbm
 kISG6U3mKDeGQI5taCdXSsgfYUtonkWRH+Cmup/bkn2sUt3pvb5hX2+iqtVeyE7V
 8qQO/LV1tV47wEmI1dSZRldJSm140waeLO+f9Ud29l5ocFiJxnvl+MhAcGCMkH78
 olJi5yKyCkWVTWaojqUaY2PioEKHoR7rfD2xvmYeibXsvIpOyhHsgHy3KlkvsSYg
 K+QxsZroFgn/xSyNps2p9Ov8OC/hR4lV8XCe9bWne9LaDo51R+8s9BtVIQY46R/5
 vFL6ka/QJmOBuE3HxDCI0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783352080; x=
 1783438480; bh=eg2L72sAYQFyQ/5fUltSJJCd7RU9lNyZO0unZiBzKF0=; b=L
 Y8kqxLeZhBOIdVkQuANcCqJ3kVcv8/8GwEd0ZrEKQPqkn51+jJEHquw4ziD7m+Fk
 +7BCvBytzZaKEBGjss+dNCEl17RU3Is60f/2ooeOtSLBMa41/0ZCTTzJ1o75olwI
 ZX4ipCss9HhpcM7h6wGezekKUyQRw+8NX4QE+YEzegTSg+yHfGKGp+796gWsaX8g
 dn2xri1Oja6cmEr6vr6W9ep2UTXPJwZevnePT/cCsaYqD3tQyxrhsq7lbrGYGpvp
 qOD69v1VGjwONYIQpOwF7iTu5Ku+hS+IZvF5rT7ip2DFSW8KgzR8KXZzghkZpyP2
 RkuDlNsFZ+n0wB8rx6iEw==
X-ME-Sender: <xms:EMtLasnXtoQwqOss0pDg2xK1BOJMy8QvcVykfKHUmlsW3IV-5CT8lw>
 <xme:EMtLauF60gGPl9GAZhbSSeCuQjRyAuGsTqWVVTK3_FFf94aflTjh6ZIlLrNa84Ybk
 h_zix6N4nae30e5ZU2igSEtJmlM1RlQbr6Mv2YuWvV9ZpuB1XqB6w>
X-ME-Received: <xmr:EMtLas5TtDESYGFJdCvH4pZJoB5ArWzE9fqsVU6ZKXGue1t_-I2zTLtVRUU>
X-ME-Proxy-Cause: dmFkZTGja22+aHzXlelTg6m3POKMiLfvo6ZnEtrd1CSFsHK6jqEPwWfQrMHQaSxy8qM9AP
 DUhzp52W3A+oldvubqj9yiU1fxcnK5iKn+u247qQQZ5rD0Cabb6Be0zq+NoYdItB3mTul6
 hMLgQrzM8EzGhyQGDURwrMzyrE+Qx5rfgl/FMAQLo6CNkUbAq3F8MMdnzI4y/AqIfeIJon
 MsUaUP05LWbTFatVWu3qJvAiTQcFMatyG14z32LDsiYRWJM5R2KIEMS0d9Fe/I6P5csuX0
 0kKIlY8TOMqA8BKel75FEXd4MtwcLks8N4A+9/Mr2zlzlDGOCWaReagbudDX1isWGpKLp6
 dvO2EggDXz8NxzTVWck5pllI4HkmG/TV+pMN/fjIkJsER5mLRC7a/1AiUutNbnA67rIJvO
 KaHIrGNr8rz0PdiaabDydPilqqFnjL6ZFOV7qB5Fb4DzbBdHm5vxYEtKjq7Utt1tfvI2zh
 A0JRyNZkg3NfAko37yVkI6aK2wvcNke6ooNXqw0g8hUpif4SP/5AicS4ep8LkZA5ki2H5b
 +NKM6DJj++fDx6oB+qespYU5WDs0lk0jG1V3lIi93GGfmZ3nhSyq2DZewZ8QMlh8u5D3Nm
 fPUgMutEG10sbH1sD1ba0ToGM0mVjX+IB2QExwfAKlYV1mjAzNfV0EQfTgfg
X-ME-Proxy: <xmx:EMtLaukwqqF_81APiwiB4Xz9lR92Q02787f0xdl9zIVa_Zh_NV8Qgw>
 <xmx:EMtLapr96CnfynJN7mx2uu0Q5g_havC_cXOPF6G05fz3DMWDtFEJPA>
 <xmx:EMtLalu2UdTXWMe8d6z4pQA93uW5yAx47J4BXcdTbgcN-QgdMMZnRw>
 <xmx:EMtLamHCXkqJZRV0SH5_BOpa_BsVqc-c4TnXWcKqzBvuS6CCJz4Uow>
 <xmx:EMtLapKDrw-M6Y9hPVX0ZQuWrI9UxaqtvwdK8YOyEvTJnLzv76dLv5jW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 11:34:39 -0400 (EDT)
Date: Mon, 6 Jul 2026 09:34:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Peter
 Maydell <peter.maydell@linaro.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
Message-ID: <20260706093438.1ea88aef@shazbot.org>
In-Reply-To: <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.146; envelope-from=alex@shazbot.org;
 helo=fout-a3-smtp.messagingengine.com
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

On Mon, 6 Jul 2026 17:12:07 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 7/6/26 16:20, Alex Williamson wrote:
> > On Thu,  2 Jul 2026 18:06:40 +0200
> > C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >  =20
> >> Any device on the board can have non-page-aligned memory regions. The
> >> VFIO listener should not warn about misalignment for regions that are
> >> not VFIO-related.
> >>
> >> Replace the vfio_known_safe_misalignment() whitelist with a
> >> vfio_get_vfio_device() ownership check: only warn when a VFIO device's
> >> own region is misaligned. For all other regions, emit a trace event
> >> and silently skip. Extract the misalignment test into a
> >> vfio_section_misaligned() helper for readability.
> >>
> >> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
> >> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
> >> memory regions through this path so this is sufficient for now. =20
> >=20
> > I thought the whole point was to warn when there are non-vfio devices
> > that we cannot insert into the DMA map.  851d6d1a0ff2 added tpm-crb-cmd
> > to an ignore list because it's not a DMA target.  The intention of that
> > ignore list was to continue to evaluate devices that are misaligned
> > and either add them to the ignore list or determine they could be a
> > valid DMA target and correct the alignment. =20
>=20
> If the goal was to use the VFIO listener to catch all misaligned regions,
> and potentially fix them, we should reconsider that approach :
>  =20
>    https://lore.kernel.org/qemu-devel/20260701080843.2418461-1-clg@redhat=
.com/

Arguably ok, likely no tpm device is a useful DMA target.
=20
> As Peter pointed out, regions that are not page-aligned regions are valid=
 :
>=20
>    https://lore.kernel.org/qemu-devel/CAFEAcA-QHJ=3DHaBc5WSLLap8NdDw+tty4=
EFfGt6cmmNOK6e_m7w@mail.gmail.com/

Yes, they are valid, no argument.  We're trying to DMA map things.  We
can't DMA map things that aren't page-aligned and sized.  If it's not
likely a DMA target, well, that's the purpose of the ignore list.  If
it might be a DMA target, this is intended to log why the VM may not
work correctly vs bare metal.
=20
> and aligning them would require a machine compat for migration.
> Not addressed in :
>=20
>    https://lore.kernel.org/qemu-devel/20260630173245.2070268-1-clg@redhat=
.com/

Which I think highlights why we might rather see warnings than bury the
issue in traces.

> > Can this even legitimately trigger with a vfio-pci device?   =20
>=20
> This would be a real error to report. Right ?

I suspect it's not possible, so as proposed here we're turning a blind
eye to the issue we intended to monitor and validate, and we replace it
with likely dead code.  Thanks,

Alex

