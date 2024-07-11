Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D391C3DA4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtme-0003hv-CH; Thu, 11 Jul 2024 09:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtmV-0003Dv-6r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtmS-0007N2-Fq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720704255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2M9c+YDMpl6BEAu2i1ABrLGK+RlKlENaMPbz3jUOSM=;
 b=djTBELTICWUOotWz4dCTkHgfZA8rIuAPDRL29ytSGH6qykOXIeXsmM9JTE8EJdfvrjNTDf
 XkL6eP4scv9/xxlqq5kJl+wB9NQbd69Q4/GZZiEaU2R/dShlMyk0mSOoq58rgC1ag37eFq
 GONSm02lbhVvOskr97YnBeyBn+Qi/qI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-qCBERzx2OO63WSQUDqpQ4A-1; Thu,
 11 Jul 2024 09:24:11 -0400
X-MC-Unique: qCBERzx2OO63WSQUDqpQ4A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B2619560BA; Thu, 11 Jul 2024 13:24:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECBA019560AE; Thu, 11 Jul 2024 13:24:07 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:24:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v8 09/10] hw/nvme: add reservation protocal command
Message-ID: <20240711132406.GF16124@fedora.home>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
 <20240709024706.4108-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lgV6K525OmEKyXka"
Content-Disposition: inline
In-Reply-To: <20240709024706.4108-10-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--lgV6K525OmEKyXka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 10:47:05AM +0800, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
>=20
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
>=20
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 323 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 +++++
>  3 files changed, 363 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad212de723..a69a499078 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] =3D {
>      [NVME_CMD_COMPARE]              =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_RECV]         =3D NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_SEND]         =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
> +    [NVME_CMD_RESV_REGISTER]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static const uint32_t nvme_cse_iocs_zoned[256] =3D {
> @@ -308,6 +312,10 @@ static const uint32_t nvme_cse_iocs_zoned[256] =3D {
>      [NVME_CMD_ZONE_APPEND]          =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_CMD_ZONE_MGMT_SEND]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_CMD_ZONE_MGMT_RECV]       =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REGISTER]        =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static void nvme_process_sq(void *opaque);
> @@ -1745,6 +1753,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
> =20
>      switch (req->cmd.opcode) {
>      case NVME_CMD_READ:
> +    case NVME_CMD_RESV_REPORT:
>          status =3D NVME_UNRECOVERED_READ;
>          break;
>      case NVME_CMD_FLUSH:
> @@ -1752,6 +1761,9 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_WRITE_ZEROES:
>      case NVME_CMD_ZONE_APPEND:
>      case NVME_CMD_COPY:
> +    case NVME_CMD_RESV_REGISTER:
> +    case NVME_CMD_RESV_ACQUIRE:
> +    case NVME_CMD_RESV_RELEASE:
>          status =3D NVME_WRITE_FAULT;
>          break;
>      default:
> @@ -2127,7 +2139,10 @@ static inline bool nvme_is_write(NvmeRequest *req)
> =20
>      return rw->opcode =3D=3D NVME_CMD_WRITE ||
>             rw->opcode =3D=3D NVME_CMD_ZONE_APPEND ||
> -           rw->opcode =3D=3D NVME_CMD_WRITE_ZEROES;
> +           rw->opcode =3D=3D NVME_CMD_WRITE_ZEROES ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_REGISTER ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_ACQUIRE ||
> +           rw->opcode =3D=3D NVME_CMD_RESV_RELEASE;
>  }

Why is this change necessary? The only nvme_is_write() caller I see is:

  void nvme_rw_complete_cb(void *opaque, int ret)
  {
      ...
      if (ns->params.zoned && nvme_is_write(req)) {
          nvme_finalize_zoned_write(ns, req);
      }

nvme_finalize_zoned_write() must not be called on reservation requests
because they don't use NvmeRwCmd:

  static void nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req)
  {
      NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;

--lgV6K525OmEKyXka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaP3PYACgkQnKSrs4Gr
c8hSPAf+PYs5fcegbrYHg3197Ve/oX1cufRW2haS6vPhvS1hWlOuT9io3/yot2lO
2dnXmeoVzDxRTb5Y12fhpuvWYVtvJg6GvztnlvaRbHzJuIdHX71r/w+ywTGaI0oO
r5JRm2pEGLm/Pfwc8vQyCE1TNttJ0dRgsCKDM+XFLlXTRdLMTU9XEY8B6SjC8VpL
R8ve1Ujk75qifSuscPNz3ElvA8W1BaYQVyhZoD0TZW/mytP7aD8KBuR4CmPS6VTF
XjVd0nzAbcc8oQM1dypo0QfG0d5DUeKeyej1lcxUVuwTpqE+PDVvpLJN6m6IQ9if
854peJBfsLYcPVh6atwhdFJpHAcW4g==
=Tccb
-----END PGP SIGNATURE-----

--lgV6K525OmEKyXka--


