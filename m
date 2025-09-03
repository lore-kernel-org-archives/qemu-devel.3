Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA68CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjlW-0006vB-Fd; Wed, 03 Sep 2025 05:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utjlU-0006uC-A4
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utjlR-0005JQ-LA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756891607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI8IhE5j0oxCvgXPoRZLfmHlfRULbbN0EcU/0WzB3eY=;
 b=JghKv9XS+GF72ZKf1Qh1j8OCRbZSIQaFHvXudrB6VKqi3u5u7WDWxDUZ20Ud6/gzbHypgy
 d2sZ83saJ4Sbl8lFl3xhn+coLjuOz6FiONYJDKBTDkEEDj1O99g7fEBQyL/u6i8O/mWMce
 o32yYSMyEQnN8nWcKtOg0X7OOrJ58r8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-uWjinsm4Nr6b_wuPRWszFw-1; Wed,
 03 Sep 2025 05:26:43 -0400
X-MC-Unique: uWjinsm4Nr6b_wuPRWszFw-1
X-Mimecast-MFC-AGG-ID: uWjinsm4Nr6b_wuPRWszFw_1756891601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCBA919560B2; Wed,  3 Sep 2025 09:26:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9B5430001A4; Wed,  3 Sep 2025 09:26:38 +0000 (UTC)
Date: Tue, 2 Sep 2025 22:47:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <20250903024705.GA103624@fedora>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+WZD+vi3cRKPozWg"
Content-Disposition: inline
In-Reply-To: <20250901034759.85042-5-wilfred.opensource@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--+WZD+vi3cRKPozWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 01:47:58PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  hw/nvme/ctrl.c       | 188 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   5 ++
>  include/block/nvme.h |  15 ++++
>  3 files changed, 207 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f5ee6bf260..557f634016 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] =3D {
>      [NVME_ADM_CMD_FORMAT_NVM]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   =3D NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]   =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static const uint32_t nvme_cse_iocs_nvm_default[256] =3D {
> @@ -7282,6 +7284,185 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr =3D {0};
> +    g_autofree uint8_t *sec_buf =3D NULL;
> +    uint32_t transfer_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len =3D transfer_len;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +    uint8_t spsp1 =3D extract32(dw10, 16, 8);
> +    uint8_t spsp0 =3D extract32(dw10, 8, 8);
> +    bool spdm_res;
> +
> +    transport_transfer_len +=3D sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {

An integer overflow check is needed since transfer_len comes from the
untrusted guest. This will prevent the sec_buf buffer overflow below
when nvme_h2c() is called.

> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol =3D secp;
> +    hdr.security_protocol_specific =3D cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.length =3D cpu_to_le32(transfer_len);
> +
> +    sec_buf =3D g_malloc0(transport_transfer_len);

g_try_malloc0() is safer when using untrusted input from the guest.
g_malloc0() aborts the process on failure, so it's disruptive.
g_try_malloc0() allows you to handle allocation failures.

> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret =3D nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_SEND,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
> +                                transport_transfer_len);
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);

be16_to_cpu()?

> +
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    return nvme_cmd_status;
> +}
> +
> +/* From host to controller */
> +static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp =3D (dw10 >> 24) & 0xff;
> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        return nvme_sec_prot_spdm_send(n, req);
> +    default:
> +        /* Unsupported Security Protocol Type */
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
> +static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr;
> +    g_autofree uint8_t *rsp_spdm_buf =3D NULL;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t recvd, spdm_res;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +    uint8_t spsp1 =3D extract32(dw10, 16, 8);
> +    uint8_t spsp0 =3D extract32(dw10, 8, 8);
> +
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr =3D (StorageSpdmTransportHeader) {
> +        .security_protocol =3D secp,
> +        .security_protocol_specific =3D cpu_to_le16((spsp1 << 8) | spsp0=
),
> +        .length =3D cpu_to_le32(alloc_len),
> +    };
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&hdr, sizeof(hdr));
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);

Should this be be16_to_cpu()?

> +    /* An error here implies the prior if_recv from requester was spurio=
us */
> +    if (nvme_cmd_status !=3D NVME_SUCCESS) {
> +        return nvme_cmd_status;
> +    }
> +
> +    /* Clear to start receiving data from the server */
> +    rsp_spdm_buf =3D g_malloc0(alloc_len);

g_try_malloc0().

> +
> +    recvd =3D spdm_socket_receive(n->spdm_socket,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                rsp_spdm_buf, alloc_len);
> +    if (!recvd) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint8_t resp[10] =3D {
> +        /* Support Security Protol List Length */
> +        [6] =3D 0, /* MSB */
> +        [7] =3D 2, /* LSB */
> +        /* Support Security Protocol List */
> +        [8] =3D SFSC_SECURITY_PROT_INFO,
> +        [9] =3D NVME_SEC_PROT_DMTF_SPDM,
> +    };
> +
> +    if (alloc_len < 10) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return nvme_c2h(n, resp, sizeof(resp), req);
> +}
> +
> +/* From controller to host */
> +static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint16_t spsp =3D extract32(dw10, 8, 16);
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +
> +    switch (secp) {
> +    case SFSC_SECURITY_PROT_INFO:
> +        switch (spsp) {
> +        case 0:
> +            /* Supported security protocol list */
> +            return nvme_get_sec_prot_info(n, req);
> +        case 1:
> +            /* Certificate data */
> +            /* fallthrough */
> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        return nvme_sec_prot_spdm_receive(n, req);
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
>  {
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -7389,6 +7570,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRe=
quest *req)
>          return nvme_directive_send(n, req);
>      case NVME_ADM_CMD_DIRECTIVE_RECV:
>          return nvme_directive_receive(n, req);
> +    case NVME_ADM_CMD_SECURITY_SEND:
> +        return nvme_security_send(n, req);
> +    case NVME_ADM_CMD_SECURITY_RECV:
> +        return nvme_security_receive(n, req);
>      default:
>          g_assert_not_reached();
>      }
> @@ -8824,7 +9009,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->mdts =3D n->params.mdts;
>      id->ver =3D cpu_to_le32(NVME_SPEC_VER);
> =20
> -    oacs =3D NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
> +    oacs =3D NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES |
> +           NVME_OACS_SECURITY;
> =20
>      if (n->params.dbcs) {
>          oacs |=3D NVME_OACS_DBCS;
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index b5c9378ea4..67ed562e00 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -461,6 +461,8 @@ static inline const char *nvme_adm_opc_str(uint8_t op=
c)
>      case NVME_ADM_CMD_DIRECTIVE_RECV:   return "NVME_ADM_CMD_DIRECTIVE_R=
ECV";
>      case NVME_ADM_CMD_DBBUF_CONFIG:     return "NVME_ADM_CMD_DBBUF_CONFI=
G";
>      case NVME_ADM_CMD_FORMAT_NVM:       return "NVME_ADM_CMD_FORMAT_NVM";
> +    case NVME_ADM_CMD_SECURITY_SEND:    return "NVME_ADM_CMD_SECURITY_SE=
ND";
> +    case NVME_ADM_CMD_SECURITY_RECV:    return "NVME_ADM_CMD_SECURITY_RE=
CV";
>      default:                            return "NVME_ADM_CMD_UNKNOWN";
>      }
>  }
> @@ -648,6 +650,9 @@ typedef struct NvmeCtrl {
>      } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
>      uint32_t    dn; /* Disable Normal */
>      NvmeAtomic  atomic;
> +
> +    /* Socket mapping to SPDM over NVMe Security In/Out commands */
> +    int spdm_socket;
>  } NvmeCtrl;
> =20
>  typedef enum NvmeResetType {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 358e516e38..9fa2ecaf28 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1779,6 +1779,21 @@ enum NvmeDirectiveOperations {
>      NVME_DIRECTIVE_RETURN_PARAMS =3D 0x1,
>  };
> =20
> +typedef enum SfscSecurityProtocol {
> +    SFSC_SECURITY_PROT_INFO =3D 0x00,
> +} SfscSecurityProtocol;
> +
> +typedef enum NvmeSecurityProtocols {
> +    NVME_SEC_PROT_DMTF_SPDM    =3D 0xE8,
> +} NvmeSecurityProtocols;
> +
> +typedef enum SpdmOperationCodes {
> +    SPDM_STORAGE_DISCOVERY      =3D 0x1, /* Mandatory */
> +    SPDM_STORAGE_PENDING_INFO   =3D 0x2, /* Optional */
> +    SPDM_STORAGE_MSG            =3D 0x5, /* Mandatory */
> +    SPDM_STORAGE_SEC_MSG        =3D 0x6, /* Optional */
> +} SpdmOperationCodes;
> +
>  typedef struct QEMU_PACKED NvmeFdpConfsHdr {
>      uint16_t num_confs;
>      uint8_t  version;
> --=20
> 2.51.0
>=20

--+WZD+vi3cRKPozWg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi3rCkACgkQnKSrs4Gr
c8hl7wgAyNe8IHlZqXCr2kIMak3WXD3OWhbFp02G3lwJ3wKVWLrZGEpSA1wk+2M8
Qt5X1D6tHLPeKwknL+WtSppJzk79o19wqPwPbQqR6hwWt6b/eqByyA6H3bxN2hHh
E+KZL4jQR1zoYlWlxf+wrxRjc5CtkeH4mnbnsJH78ySugpquP9GcPg579LdHTwSZ
jL07Gq89EJaqA+M4MOtaRjxwqQIw2zpvK2YhFoOIPVy3zdpw42JSNA7H6MKsouoz
Yi2a04dsyeH0jxjZofxEb9UMqsnT7LPeQkdG3kmr7MZK4wRdlvCVGrKB20a+I9Ug
TqNmNkq9gZGGqroBZQdcnoZOjQ/AOQ==
=Yc1Z
-----END PGP SIGNATURE-----

--+WZD+vi3cRKPozWg--


