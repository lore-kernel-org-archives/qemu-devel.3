Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F3AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgl5h-0003QH-DN; Mon, 06 Jul 2026 11:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wgl5f-0003Q1-F6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:18:35 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wgl5c-0005FO-Hz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:18:34 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 634BC14000BB;
 Mon,  6 Jul 2026 11:18:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783351111;
 x=1783437511; bh=rLOKrEN9DM/VA/AYtS+Q/P2nAVttRp6VEHNLnDmGYT8=; b=
 grURJ+tFIMdCG/llwoxrIwsE4w19EM7QBnHJ/RDdexZSBHNgA/AbOTUAlhCE2vx1
 pXhdsiFnEPj4BiuJQbpPl4zpB/tggWPYAkKI+v4X/VQdkoTPgBi3IaQ7XupsZkGC
 fmWsRAVMoUNEEFRVWoG5YlNJ4Ljpr48roGyaZ8a3hKyVKoO6JKSfnNtpF0rxpQAQ
 JwVvh1MpAJiwCZsdTHgKulRbXoDwiMqLpS8mvwCcrPTdx9ZLQ29W8Ylx303hmvXU
 Hntk0ov+3AX+zh9EHy4xFiFpIihYJ5iNMdk4Ah9cDLOqqv8GfiPWnKKfXkVg6Gi9
 B0T4uV7bxBSyin0qdZ9AbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783351111; x=
 1783437511; bh=rLOKrEN9DM/VA/AYtS+Q/P2nAVttRp6VEHNLnDmGYT8=; b=h
 Kk9L9BskJ6V0JNiVycgvAlYi8JyWzi2CT1DNqcZ/keEYJ2CB1PWtLQ/GFhkvhJiD
 bZki943p+QN3xZkduBS6Uv66iHsA+0GYEx7T8xuhBNzsTHDQTvmVaYgZASczsPRB
 uss5HRnXS/sHVNFi9tk4Flh8PpuByCwtx9yOVUmBcoUzqq6GrSAADWtUBfzRmn7N
 ERwR7D5CO6qlhUG6HYPaZwOe0sMX6SUw2GWKfvnWfo2UpCF4g2qZWz7o6xBHuswj
 Rk8aLIOrPzyHlgCwf2g6ByOKQIo+0PX2+OJL5pKiEqMiq26nBzsmKwubl4Y6skJ+
 aCFqIjKnt1f+7UIAl8EAQ==
X-ME-Sender: <xms:R8dLavfcM8_-HrWJXUoph2DXgn6W2Y4DCjDF-4ZbUSDj6JzCYv7iAA>
 <xme:R8dLalWA4MGK8Lxenm2KUIkEOp7r1UmansJu8F1g5Qfpd39NZOh9wdrO60jbKEYRh
 uLTbfBNqybyrxvltDrUf4f_581U0jPHhO8bs3ItxHjPK98P9mt3Ng>
X-ME-Received: <xmr:R8dLagcMErKFgW8C5bxRWjdTXD2YEPHJxg78ZdG0awtDPDjkw_4kE4_GaaM>
X-ME-Proxy-Cause: dmFkZTFYL8xWLzS/tkSMX5qdwerVliB4feuc9/2dV+ueeLijoypuwt9JeyEmzJsUf5LVWn
 vwO7CEYry5RQ8arMYTBxK9vSUiO2uHj20VK6UQg093AMHaWwBYwJ6za09JJu4VOwT2FV1/
 dD4xmLY7YMRhsLUpDqm1RgE/IE840bUEQe0OJCSSWtbu3m7822ysQ6CflUkuHTxr/pBXuH
 HrxBoYpJd1wLTNr7ExffRC1eEDcu7X4j6DnSyBwwJi6m7k2IA4oZkk4WLEigKyUzz+w6CW
 HCZ4aXIlVZ0XfO4ncl6lo/bonvXAk3iT2zOjcSuTt3uBpMoMU049evyq4H4h62ZCrfCapm
 QlmWS7ZwX5s20QKBO85yoI311atkKVlLQIv7g8fAbnXULcJzPKtdMbs2unCCShRrmi5K9c
 VAy9s4qdrpB9+PL7/RF7XxfbOwtuLYClylhq/Xkq/WY8yLN2z55RR20/5hqSZbUUVtcX5w
 QewjTnG3nmhw+blNgmSdHLCVgn286fJvxZc1vrADA7A0pap8S7YYoh8eMrzd+Mb9kPnTK5
 LhBU8DEGiJoXBEx7MZ7ooxvrg1dVLSC3J4Du1YGnvgYok+7gfFyYDIrJaWrCJriaOVX05M
 aDkTy/rITpPjgmZAPO+QkjS0FE6C7xxcpbOrvPqIAhAHCl8A+J/f1KwiL2MA
X-ME-Proxy: <xmx:R8dLapMpIJS8AJIWa0cRBK_Eby7UhGiH3KxqtYBzMU9H87klTumAhg>
 <xmx:R8dLamjTeTLNvfRtzwn2s8m3kmOtTDJ5ra_CR8y89AlEjmvkTsrGpA>
 <xmx:R8dLak2Bzt5z-05EADBuJeg0YaTk3UI05yCx-3r1p5yrJOifzy_QzA>
 <xmx:R8dLaohxVQwkkk5MbOlY8oJdmjFZflAOi9LnirlmLLaMlfi2VydcJw>
 <xmx:R8dLaic_DpzPMzcSZhrnLzuO0Az5wGlTGQqeETwbexEnnps1lTeAxyy5>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 11:18:30 -0400 (EDT)
Date: Mon, 6 Jul 2026 09:18:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Feifan Qian <bea1e@proton.me>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Reject invalid MSI-X Table and PBA BIR values
Message-ID: <20260706091828.76964e59@shazbot.org>
In-Reply-To: <20260706143124.2076256-1-clg@redhat.com>
References: <20260706143124.2076256-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.154; envelope-from=alex@shazbot.org;
 helo=fhigh-a3-smtp.messagingengine.com
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

On Mon,  6 Jul 2026 16:31:24 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> The 3-bit MSI-X BIR fields permit values 0-7, but VFIOPCIDevice::bars[]
> only contains BAR0-BAR5 (6 entries). An invalid BIR value of 6 or 7
> can cause an out-of-bounds array access (CWE-129) in vfio_msix_early_setu=
p().
>=20
> Add range checks immediately after extracting the BIR values.

A compliant PCI device used for traditional device assignment is not
susceptible to this without a malicious intermediary.  The primary
exposure seems to be a vfio-user server, maliciously or inadvertently
exposing bogus BIR values, which appears to introduce a DoS vector
without any reliable further exploit.

> Reported-by: Feifan Qian <bea1e@proton.me>
> Fixes: 65501a745dba ("vfio: vfio-pci device assignment driver")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3878
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 67d9d9e846446577e8de7a8c588165c6f38c3bee..324e3f5d98206ccb64963ee23=
2f69d3ada422ef5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1762,6 +1762,14 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *v=
dev, Error **errp)
>      msix->pba_offset =3D pba & ~PCI_MSIX_FLAGS_BIRMASK;
>      msix->entries =3D (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
> =20
> +    if (msix->table_bar >=3D PCI_NUM_REGIONS - 1 ||
> +        msix->pba_bar >=3D PCI_NUM_REGIONS - 1) {
> +        error_setg(errp, "invalid MSI-X BIR, table_bar=3D%d pba_bar=3D%d=
",
> +                   msix->table_bar, msix->pba_bar);
> +        g_free(msix);
> +        return false;
> +    }
> +
>      ret =3D vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_=
INDEX,
>                                     &irq_info);
>      if (ret < 0) {

Note that the vulnerability is an out-of-bounds index on vdev->bars, so
we could test >=3D ARRAY_SIZE(vdev->bars), which is sized as
(PCI_NUM_REGIONS - 1).  Either way...

Reviewed-by: Alex Williamson <alex@shazbot.org>

