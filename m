Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366C2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Tf9-0000Mj-Ik; Wed, 24 Sep 2025 13:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1Tf2-0000EW-Nz
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1Tem-0004Sc-Hf
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758736313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D+E5eW85LYsd97op4pNBgDv+LNXYZwb/qz/5sSXQ/w=;
 b=NAJolO+Xqo5M07KmjHnlZsY/4CroqEtdDdySe3Yrg+emLlwG2mRt3TCyZ/Up+kbhUSpsfr
 hJMqn2aQyUP8EvV6/a9IPo2emtMDok+G0NNn5vf/I6VcCG10PbTZ/Ubr/AUDQ3aue7w5Ef
 3sO4f5IWW4iNmdpc2+pJYW56bhJw0BY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-mnKL-0fPO2CjTTbmdW9sZQ-1; Wed,
 24 Sep 2025 13:51:50 -0400
X-MC-Unique: mnKL-0fPO2CjTTbmdW9sZQ-1
X-Mimecast-MFC-AGG-ID: mnKL-0fPO2CjTTbmdW9sZQ_1758736309
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24A41800447; Wed, 24 Sep 2025 17:51:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.176])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F90C300018D; Wed, 24 Sep 2025 17:51:47 +0000 (UTC)
Date: Wed, 24 Sep 2025 13:51:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Qing Wang <qinwang@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV
 devices
Message-ID: <20250924175146.GA6015@fedora>
References: <20250924155153.579495-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vBcO+r+BvqDvzWJR"
Content-Disposition: inline
In-Reply-To: <20250924155153.579495-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--vBcO+r+BvqDvzWJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:51:53AM -0400, Stefan Hajnoczi wrote:
> Commit 3f9cfaa92c96 ("virtio-pci: Implement SR-IOV PF") added an
> unconditional call from virtio_pci_exit() to pcie_sriov_pf_exit().
>=20
> pcie_sriov_pf_exit() reads from the SR-IOV Capability in Configuration
> Space:
>=20
>   uint8_t *cfg =3D dev->config + dev->exp.sriov_cap;
>   ...
>   unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> This results in undefined behavior when dev->exp.sriov_cap is 0 because
> this is not an SR-IOV device. For example, unparent_vfs() segfaults when
> total_vfs happens to be non-zero.
>=20
> Fix this by returning early from pcie_sriov_pf_exit() when
> dev->exp.sriov_cap is 0 because this is not an SR-IOV device.
>=20
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Qing Wang <qinwang@redhat.com>
> Buglink: https://issues.redhat.com/browse/RHEL-116443
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/pci/pcie_sriov.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

CCing qemu-stable

>=20
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 8a4bf0d6f7..cf1b5b5c05 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -195,7 +195,9 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offs=
et,
> =20
>  void pcie_sriov_pf_exit(PCIDevice *dev)
>  {
> -    uint8_t *cfg =3D dev->config + dev->exp.sriov_cap;
> +    if (dev->exp.sriov_cap =3D=3D 0) {
> +        return;
> +    }
> =20
>      if (dev->exp.sriov_pf.vf_user_created) {
>          uint16_t ven_id =3D pci_get_word(dev->config + PCI_VENDOR_ID);
> @@ -211,6 +213,8 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
>              pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf=
_dev_id);
>          }
>      } else {
> +        uint8_t *cfg =3D dev->config + dev->exp.sriov_cap;
> +
>          unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>      }
>  }
> --=20
> 2.51.0
>=20

--vBcO+r+BvqDvzWJR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjUL7EACgkQnKSrs4Gr
c8inlQf8CQ09TgDo52GpnhDL3VAagmq1aDtFB+RUF/k1unvpv2b95mDvZwxiTxUj
AcdYx+GQ46qwz6BUprgllZNAF4AfDwy2TX5fWYddSUxpAYoF3XYcebuqqP84sprm
89AgYXCwooycoorByBRcuyHTA1EQX5I1hsj+0hGlB7gRi726puyEHPsx8yaUs3Bg
hHbzNj6+if3dCFs/j8QdRCdwKsylW8y7UGGxErL0HqmX3qcnbD5vgpTMkUTdqeWu
sJp0i4j5D4VCte7p5iGqUPQctVvAfVftE8WmRaAl8AaMsu+S5GW4BVp8+3kmCj9M
YeckdG1lbXd+WgR0Cb9Eu2ZfxcNukg==
=UZeH
-----END PGP SIGNATURE-----

--vBcO+r+BvqDvzWJR--


