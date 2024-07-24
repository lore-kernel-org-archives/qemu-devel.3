Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D3CC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWb8f-0003Uh-GS; Wed, 24 Jul 2024 08:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@kernel.org>) id 1sWb8R-0003Sh-De
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:30:25 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit@kernel.org>) id 1sWb8M-0002He-Mj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:30:22 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BBA95611F9;
 Wed, 24 Jul 2024 12:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E92C4AF0C;
 Wed, 24 Jul 2024 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721824213;
 bh=8rnFNsxiLWTT9EPF+PXhrYGlg0XeCtYXN1A8hMdrNQI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=B4WMZvgqaOEAUDlnlQoFeGDicDOYO9ZwVUxJzE3fmafvRh0wzNJqr7U0PDX7QenJ2
 dEOr2rS/eSqSPlpLzTELNWfNMnEz4wK/NU4C/+T2zctXAXJdc96RgcSJxkCRBGJzez
 whdtKWDEepCvY2AQBPAiCzyoBuY1mYQ/PGxFYdQDjDTXRQjRhceN9eO3ESeA5dS84W
 y6nt9sBTaiavPbqUS7ymRlbibJXrlxKoBHiHBizxiJpeAQOiJdyufuM5hTzzLSFXPc
 odavnpi7kujuqy6g43pHKx3f8D7HY1yx+2BeFxShlStXgIL2M9oDSdDZyXjgRMMyJY
 lGcSkzi1oZPfg==
Message-ID: <295721d53b2da8b7c67d89e1d6a6fa8fa636d057.camel@kernel.org>
Subject: Re: [PATCH] virtio-rng: block max-bytes=0
From: Amit Shah <amit@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 24 Jul 2024 14:30:09 +0200
In-Reply-To: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
References: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=amit@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, 2024-07-24 at 06:51 -0400, Michael S. Tsirkin wrote:
> with max-bytes set to 0, quota is 0 and so device does not work.
> block this to avoid user confusion
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> =C2=A0hw/virtio/virtio-rng.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index f74efffef7..7cf31da071 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -184,8 +184,9 @@ static void virtio_rng_device_realize(DeviceState
> *dev, Error **errp)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Workaround: Property parsing does not enforce=
 unsigned
> integers,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So this is a hack to reject such numbers=
. */
> -=C2=A0=C2=A0=C2=A0 if (vrng->conf.max_bytes > INT64_MAX) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'max-bytes'=
 parameter must be non-
> negative, "
> +=C2=A0=C2=A0=C2=A0 if (vrng->conf.max_bytes =3D=3D 0 ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vrng->conf.max_bytes > INT64_=
MAX) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'max-bytes'=
 parameter must be positive, "
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "and less than 2^63");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }

Reviewed-by: Amit Shah <amit@kernel.org>

