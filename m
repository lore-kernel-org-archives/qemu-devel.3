Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4011C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS7c-0005cy-LC; Thu, 04 Jul 2024 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS7C-0005NB-Rv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sPS79-0005xc-5a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720121250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SeyxytBLmu2d3M5IKTijzEn//zN6lTfl9SzcALViPYc=;
 b=S0f0wxLWZlOlcvDjsycWFD5Pin7SIkHLz0PARcJ99Pw5g4if18ve1qBnL5NmAxlQGN/ZND
 jtQAVoEn19NNtXARgfKPoUh7dYzXOxIVzBmM87STkBdb8mUJk+R/H8pZjsb5/cwUJSjOSo
 g7M7i1PmKxEJDTuLTstJiRop0Px5z6Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-ciOlBxVoPHin-dwrhtWVuQ-1; Thu,
 04 Jul 2024 15:27:26 -0400
X-MC-Unique: ciOlBxVoPHin-dwrhtWVuQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A1B1956080; Thu,  4 Jul 2024 19:27:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B1DE195605A; Thu,  4 Jul 2024 19:27:20 +0000 (UTC)
Date: Thu, 4 Jul 2024 19:51:01 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v6 06/10] block/nvme: add reservation command protocol
 constants
Message-ID: <20240704175101.GF2529519@fedora.redhat.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <20240613071327.2498953-7-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oiXEhoq2RiasPgT9"
Content-Disposition: inline
In-Reply-To: <20240613071327.2498953-7-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--oiXEhoq2RiasPgT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:13:23PM +0800, Changqi Lu wrote:
> Add constants for the NVMe persistent command protocol.
> The constants include the reservation command opcode and
> reservation type values defined in section 7 of the NVMe
> 2.0 specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index bb231d0b9a..da6ccb0f3b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -633,6 +633,10 @@ enum NvmeIoCommands {
>      NVME_CMD_WRITE_ZEROES       =3D 0x08,
>      NVME_CMD_DSM                =3D 0x09,
>      NVME_CMD_VERIFY             =3D 0x0c,
> +    NVME_CMD_RESV_REGISTER      =3D 0x0d,
> +    NVME_CMD_RESV_REPORT        =3D 0x0e,
> +    NVME_CMD_RESV_ACQUIRE       =3D 0x11,
> +    NVME_CMD_RESV_RELEASE       =3D 0x15,
>      NVME_CMD_IO_MGMT_RECV       =3D 0x12,

Keep NVME_CMD_IO_MGMT_RECV (0x12) before NVME_CMD_RESV_RELEASE (0x15) in
sorted order?

>      NVME_CMD_COPY               =3D 0x19,
>      NVME_CMD_IO_MGMT_SEND       =3D 0x1d,
> @@ -641,6 +645,63 @@ enum NvmeIoCommands {
>      NVME_CMD_ZONE_APPEND        =3D 0x7d,
>  };
> =20
> +typedef enum {
> +    NVME_RESV_REGISTER_ACTION_REGISTER      =3D 0x00,
> +    NVME_RESV_REGISTER_ACTION_UNREGISTER    =3D 0x01,
> +    NVME_RESV_REGISTER_ACTION_REPLACE       =3D 0x02,
> +} NvmeReservationRegisterAction;
> +
> +typedef enum {
> +    NVME_RESV_RELEASE_ACTION_RELEASE        =3D 0x00,
> +    NVME_RESV_RELEASE_ACTION_CLEAR          =3D 0x01,
> +} NvmeReservationReleaseAction;
> +
> +typedef enum {
> +    NVME_RESV_ACQUIRE_ACTION_ACQUIRE            =3D 0x00,
> +    NVME_RESV_ACQUIRE_ACTION_PREEMPT            =3D 0x01,
> +    NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT  =3D 0x02,
> +} NvmeReservationAcquireAction;
> +
> +typedef enum {
> +    NVME_RESV_WRITE_EXCLUSIVE               =3D 0x01,
> +    NVME_RESV_EXCLUSIVE_ACCESS              =3D 0x02,
> +    NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY     =3D 0x03,
> +    NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY    =3D 0x04,
> +    NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS      =3D 0x05,
> +    NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS     =3D 0x06,
> +} NvmeResvType;
> +
> +typedef enum {
> +    NVME_RESV_PTPL_NO_CHANGE =3D 0x00,
> +    NVME_RESV_PTPL_DISABLE   =3D 0x02,
> +    NVME_RESV_PTPL_ENABLE    =3D 0x03,
> +} NvmeResvPTPL;
> +
> +typedef enum NVMEPrCap {
> +    /* Persist Through Power Loss */
> +    NVME_PR_CAP_PTPL =3D 1 << 0,
> +    /* Write Exclusive reservation type */
> +    NVME_PR_CAP_WR_EX =3D 1 << 1,
> +    /* Exclusive Access reservation type */
> +    NVME_PR_CAP_EX_AC =3D 1 << 2,
> +    /* Write Exclusive Registrants Only reservation type */
> +    NVME_PR_CAP_WR_EX_RO =3D 1 << 3,
> +    /* Exclusive Access Registrants Only reservation type */
> +    NVME_PR_CAP_EX_AC_RO =3D 1 << 4,
> +    /* Write Exclusive All Registrants reservation type */
> +    NVME_PR_CAP_WR_EX_AR =3D 1 << 5,
> +    /* Exclusive Access All Registrants reservation type */
> +    NVME_PR_CAP_EX_AC_AR =3D 1 << 6,
> +
> +    NVME_PR_CAP_ALL =3D (NVME_PR_CAP_PTPL |
> +                      NVME_PR_CAP_WR_EX |
> +                      NVME_PR_CAP_EX_AC |
> +                      NVME_PR_CAP_WR_EX_RO |
> +                      NVME_PR_CAP_EX_AC_RO |
> +                      NVME_PR_CAP_WR_EX_AR |
> +                      NVME_PR_CAP_EX_AC_AR),
> +} NvmePrCap;
> +
>  typedef struct QEMU_PACKED NvmeDeleteQ {
>      uint8_t     opcode;
>      uint8_t     flags;
> --=20
> 2.20.1
>=20

--oiXEhoq2RiasPgT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaG4QUACgkQnKSrs4Gr
c8hcBAgApkgponX3YAtMJ5XAZJTfepWj/oMM7yh/SA1SsXk0S+qQ0qt5RJ4/rsLe
La9fJhxQh0muAZqXUf3XL1j4hq8NYhzm9d7yK9YFmjKQ3wsW2HYy8vZbp9AjiNfT
JJGpzph6oGrkP67l2lyaAJHkUHKDC5xm2ZR7lKzrtUkBY9dPNduHMmCGjnhdLuJA
F08Xi5E9iQPOP8JidRwF0lSTZA/MNAAfVAITTJqN3La6TxjfaJbhDcUVKa4BgGrq
SOk0aOJLhTero9at5TKrI45dQTJoQmLESe5hUl3a3lciDGZDp9MPII4Az+pI5vnX
yvcUOiawJ2cuoG5n/7AWo7Cxymx2TA==
=jCga
-----END PGP SIGNATURE-----

--oiXEhoq2RiasPgT9--


