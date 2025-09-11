Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B44ACAC583
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwak7-0001vW-2n; Thu, 11 Sep 2025 02:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uwaju-0001tj-4B; Thu, 11 Sep 2025 02:25:03 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uwajn-0002sy-TH; Thu, 11 Sep 2025 02:25:01 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 152A3EC0242;
 Thu, 11 Sep 2025 02:24:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 11 Sep 2025 02:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1757571891; x=
 1757658291; bh=gEc/0SI9UdNxI5Kusgpz8I+JolIv2Fes7553DQ2xr70=; b=V
 i431iVj6l8KDFEauuPrm3LK9gctVXLGYPzwNeqGKD0UDQ0k5W+6DPl9nOmaeuWWF
 YeN3lPu2zxcgQqDXMiYvSXTg5Cxl+qeVOWlQ5FIDWpIW3ELxZolhMte7QxetYK4B
 j7CdMzxOKn1TVQNMluiPgBiKSE/RqgQ4ILC63M9EuHZQh29Ot4sn5KOX5pg701xv
 q4TrYeFLeaPrHxsXa7SkJKpKYgvbq2AkXYgpP3cRl6+7xgq+gq3sspTwJD4VRuMT
 fVXwtcRcxQuhr5E7+qVV5y1ySzCvSWlHv9HIFVJ73NqWZbZTlP1FGDlLuDdXg5LH
 Ft0+ZMXJ11tcBPxVKfN3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1757571891; x=1757658291; bh=gEc/0SI9UdNxI5Kusgpz8I+JolIv2Fes755
 3DQ2xr70=; b=QgdMmkb6ejWVmqeSGnUWkJUpvsiwChV/exznrYGFqzSbaIEaE4G
 wd/gGH9UwKTdYX7QRSRRgYAigrKE/8ojbrxaaDci6k3hIGxg2O/z8rZi6l2hXSej
 Qji9oefuQmXKIr6oekptjVW9b5A6a8F9uvsUhyVmrkmVh+9DAYezkMFRZ0MDpwq2
 R2h6zNphiED9UCb+Gf3qUHxTz8o2G4JNsa2Ql8d1yUswUaJX4pYVhyIO1Tr+0HVb
 fABQP/ewcVYEdWC8nU/YkAV6Z6TTCKj7BNjCahnlrSkCYDjK1SrYL4hZslL+6TUG
 fqOtoY95Y7a/cPx9T0W7jMkV+I6NS8W9UMA==
X-ME-Sender: <xms:MWvCaBpK0xkLlx3VFNx3ljuRb_nX5wv2TFOOUq13daFYIm5h6BqjWQ>
 <xme:MWvCaCnurENyDedARZ7MsviPaqtyQau-rJaBT51a2v89xbxQMccfemENUIuUOK2C_
 5yzYMuwirVeydKpBPU>
X-ME-Received: <xmr:MWvCaKSwEH58242jSPEm60ClQRAB3hvYuClm-ODt6d3Q3UtgSZHNuk7Jjaw3HysQ2hCUjCgG9F4n085xMbgxmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvsehgmhgrih
 hlrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgt
 ohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 hfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpth
 htohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehkfiholhhfsehr
 vgguhhgrthdrtghomhdprhgtphhtthhopehhrhgvihhtiiesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:MWvCaAb-4RvthRMBWvADhxk_XUkZzv08QU_MSaY8YvEeaOu3O9g9lA>
 <xmx:MWvCaC9cjKHCfly-n-jDLOtJNL3LiBLwy5fybxRuBxhGI7VQPawF-Q>
 <xmx:MWvCaKmElLtjwa5BDJWYHnaj7q8dGKRMMnXt7ruvJD-h7gmbwuVaLw>
 <xmx:MWvCaHax69orhdWAlLJ2HdtBfDXyNNQDusupn2E0o3YOChKSII0Nfw>
 <xmx:M2vCaP9HvEdzd-rfZgfanlRW31Plwv1qb7p7AQgF_Hcqid8Kj9afd_s7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:24:45 -0400 (EDT)
Date: Thu, 11 Sep 2025 08:24:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v6 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <aMJrKjmKWx7OIWuB@AALNPWKJENSEN.aal.scsc.local>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
 <20250911060031.124683-4-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jh/Qqk9/N5Udzb33"
Content-Disposition: inline
In-Reply-To: <20250911060031.124683-4-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--jh/Qqk9/N5Udzb33
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 11 16:00, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Looks good,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c               | 212 ++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h               |   5 +
>  include/block/nvme.h         |  15 +++
>  include/system/spdm-socket.h |   2 +
>  4 files changed, 233 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f5ee6bf260..ad52e8f569 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] =3D {
>      [NVME_ADM_CMD_FORMAT_NVM]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   =3D NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]    =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]    =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static const uint32_t nvme_cse_iocs_nvm_default[256] =3D {
> @@ -7282,6 +7284,207 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
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
> +    uint16_t spsp =3D extract32(dw10, 8, 16);
> +    bool spdm_res;
> +
> +    if (transport_transfer_len > UINT32_MAX - sizeof(hdr)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    transport_transfer_len +=3D sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_check_mdts(n, transport_transfer_len);
> +    if (ret !=3D NVME_SUCCESS) {
> +        return ret;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol =3D secp;
> +    hdr.security_protocol_specific =3D cpu_to_le16(spsp);
> +    hdr.length =3D cpu_to_le32(transfer_len);
> +
> +    sec_buf =3D g_try_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_INTERNAL_DEV_ERROR;
> +    }
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
> +                                &nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status =3D be16_to_cpu(nvme_cmd_status);
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
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        if (n->spdm_socket < 0) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
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
> +    uint8_t spsp =3D extract32(dw10, 8, 16);
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr =3D (StorageSpdmTransportHeader) {
> +        .security_protocol =3D secp,
> +        .security_protocol_specific =3D cpu_to_le16(spsp),
> +        .length =3D cpu_to_le32(alloc_len),
> +    };
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                &hdr, sizeof(hdr));
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                &nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    nvme_cmd_status =3D be16_to_cpu(nvme_cmd_status);
> +    /* An error here implies the prior if_recv from requester was spurio=
us */
> +    if (nvme_cmd_status !=3D NVME_SUCCESS) {
> +        return nvme_cmd_status;
> +    }
> +
> +    /* Clear to start receiving data from the server */
> +    rsp_spdm_buf =3D g_try_malloc0(alloc_len);
> +    if (!rsp_spdm_buf) {
> +        return NVME_INTERNAL_DEV_ERROR;
> +    }
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
> +        [9] =3D 0,
> +    };
> +
> +    if (n->spdm_socket >=3D 0) {
> +        resp[9] =3D NVME_SEC_PROT_DMTF_SPDM;
> +    }
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
> +        if (n->spdm_socket < 0) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        return nvme_sec_prot_spdm_receive(n, req);
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
>  {
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -7389,6 +7592,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRe=
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
> @@ -8459,6 +8666,8 @@ static void nvme_init_state(NvmeCtrl *n)
>          sctrl->vfn =3D cpu_to_le16(i + 1);
>      }
> =20
> +    n->spdm_socket =3D -1;
> +
>      cap->cntlid =3D cpu_to_le16(n->cntlid);
>      cap->crt =3D NVME_CRT_VQ | NVME_CRT_VI;
> =20
> @@ -8824,7 +9033,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
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
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 80cd7021c1..f0c8b64d1b 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -112,7 +112,9 @@ typedef struct {
> =20
>  #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
>  #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
> =20
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
> =20
>  #endif
> --=20
> 2.51.0
>=20
>=20

--jh/Qqk9/N5Udzb33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmjCaycACgkQTeGvMW1P
DekuYQf+PXpkUEMBnnZNpc3EJVuEhk4RuXmBCufxZKjqfHvH4sUIlf+BFnxP4QT/
QPZcB3iqhlmF+/wDTvjsjs+r2kCT887uXurCR4roZfgiiywLyLD8ONI/AFvvCBbe
qHywSvjEvU83YiBpSurR09CBpc1jXa8vVcVXqDSj0MpIZ5zHigQXR0nCdoWRxF9e
Hljp5s8i35j4VmU+HoG3Q0lipuX2ykq0Pp5wBXd2jJpunQ5satZL3Gfp6W/udyfG
EKBY9roEBJfohZ3GCZTWxbhg8YgZODddredJtmyl88hZavQoDjhjQDmuw6v1ZqGV
e+OI76OH7OypdO5cg6ro/EBiSNgEyQ==
=Zhdq
-----END PGP SIGNATURE-----

--jh/Qqk9/N5Udzb33--

