Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A8DE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBrF-0008ED-8k; Fri, 10 Jan 2025 05:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWBrC-0008Df-8k; Fri, 10 Jan 2025 05:03:11 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWBr9-0003pZ-NU; Fri, 10 Jan 2025 05:03:10 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A0EB1254018D;
 Fri, 10 Jan 2025 05:03:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 10 Jan 2025 05:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1736503385; x=
 1736589785; bh=XtQFI40uxltcMx7ny6W7q5+Rbdjzf7wd2afFfsiWnxo=; b=R
 kqA4whIdN1LJhK5gNvN6FSy8Rs2dC4Nj8xz0aIF1cO9kJe3uONAwjLMe64D91KoV
 cFuGJHdQa6ip1HOcSqwLWH0R01gEexjv8cnTN+YwCxrT3chMpU1dYRoRAPl/a/eg
 uNSv7IwygPwIBXUE/4emy5LRk/bHiOuPV4ORThDiCRjir0LXDpTLE7cmgFRuinY+
 IFJ4ius0E5Qs/xeyBkjZ4EqCkp29kIaYpofznKq3YTDMpsi27mBYugTJ+b7KBgdz
 fG2yOZnV+iQn1scAaXjMlzCaP5ArTY7MMpnTO8U/vACl1yQAB/36AMAvNuCEOOsX
 cHsUwth3bhT6cQCfQtUqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1736503385; x=1736589785; bh=XtQFI40uxltcMx7ny6W7q5+Rbdjzf7wd2af
 FfsiWnxo=; b=DoAU1tCH9z9tUoQHNaDwvqBmMXMoPUb88u3OYEO6xfi87Y9yggf
 brcGJlKj1wckIHs7Z+u4cICCNeRKR+tM+fYKGW+gBfmv1ulKN/RM3+on3K6tKdZ7
 RP27bQPllCbS4cjCIfL4uXkwAKQ3VSygmCsIJU3ZZjJXHabkKzGVd3WC3/ovRmS+
 G3ZsVostmbSp9fuXwkpZThi0Tfuaj0V7q7ecre5hPIBD2RUTBnpzLf1kfkKNbYby
 ud2hw2tTVieSJsDFwOzim9XpyqrqVGzlXk3Tnmo8lM0W0TVcd6sR5ECFdjZ2DcMk
 5EhFK1qzWDliEvHKHoMpmbqldewYeLqoAsA==
X-ME-Sender: <xms:WfCAZ0xU_Nkv2QSKV_TL4bjGVaE84ImwZVSYX3bcvyc1og40WMEo-w>
 <xme:WfCAZ4RIMmr9-y9UUpcEvhsuvYMCWaC8hbDNZ5kDQV5eAUB1ZwZ7DLPlHKNPYQk6p
 NPBLEBSPBk9oMmfF40>
X-ME-Received: <xmr:WfCAZ2XQn62HlwDjRJFxkI-NJ5bwL2NmR5oLhqJL_u9d6uNtkcu_M1pRpVYytw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhlfhhrvggurdhmrg
 hllhgrfigrseifuggtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhr
 tghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfohhssh
 esuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepph
 hhihhlmhgusehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:WfCAZyjlRXqgqxDOyNmNihQm6ARhvACSjpotBYuiM4a8xjSq0tTNXw>
 <xmx:WfCAZ2BGyAjrCKV2mw46fQZ0mbFV5fgypq50iucpNRHSISmYQPCw9A>
 <xmx:WfCAZzLT5k18wyKxvkNWkVZKELsA8PGdl416F_BMWlwaeV3hPUarlQ>
 <xmx:WfCAZ9BpvA0A1jQTlCebMQWlYr1T8lX26D7Z7Z0EOLIUizQnc1HPWg>
 <xmx:WfCAZ-ZwS_Pq1ctajLiBRelqbvgM1CHQJWhoevCGI4pvf7dqXAOVJyYa>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 05:03:04 -0500 (EST)
Date: Fri, 10 Jan 2025 11:03:03 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, alistair.francis@wdc.com,
 kbusch@kernel.org, foss@defmacro.it, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [RFC 3/4] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <Z4DwV7A1rUU7CWob@AALNPWKJENSEN.aal.scsc.local>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-6-wilfred.mallawa@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ew5XDBNOiboGIrIw"
Content-Disposition: inline
In-Reply-To: <20250107052906.249973-6-wilfred.mallawa@wdc.com>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--ew5XDBNOiboGIrIw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan  7 15:29, Wilfred Mallawa via wrote:
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  hw/nvme/ctrl.c       | 207 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   5 ++
>  include/block/nvme.h |  15 ++++
>  3 files changed, 226 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 68903d1d70..68341e735f 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -283,6 +283,8 @@ static const uint32_t nvme_cse_acs[256] =3D {
>      [NVME_ADM_CMD_FORMAT_NVM]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   =3D NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]   =3D NVME_CMD_EFF_CSUPP,
>  };
> =20
>  static const uint32_t nvme_cse_iocs_none[256];
> @@ -7182,6 +7184,205 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr =3D {0};
> +    uint8_t *sec_buf;
> +    uint32_t transfer_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len =3D transfer_len;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status;
> +    uint16_t ret;
> +    uint8_t secp =3D (dw10 >> 24) & 0xFF;
> +    uint8_t spsp1 =3D (dw10 >> 16) & 0xFF;
> +    uint8_t spsp0 =3D (dw10 >> 8) & 0xFF;
> +    bool spdm_res;
> +
> +    transport_transfer_len +=3D sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol =3D secp;
> +    hdr.security_protocol_specific =3D cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.inc_512 =3D false;
> +    hdr.length =3D cpu_to_le32(transport_transfer_len);
> +
> +    sec_buf =3D g_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret =3D nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_SEND,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
> +                                transport_transfer_len);
> +    if (!spdm_res) {
> +        g_free(sec_buf);
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);
> +
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        g_free(sec_buf);
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    g_free(sec_buf);
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
> +    StorageSpdmTransportHeader hdr =3D {0};
> +    uint8_t *rsp_spdm_buf;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t recvd, spdm_res;
> +    uint16_t nvme_cmd_status;
> +    uint16_t ret;
> +    uint8_t secp =3D (dw10 >> 24) & 0xFF;
> +    uint8_t spsp1 =3D (dw10 >> 16) & 0xFF;
> +    uint8_t spsp0 =3D (dw10 >> 8) & 0xFF;
> +
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol =3D secp;
> +    hdr.security_protocol_specific =3D cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.inc_512 =3D false;
> +    hdr.length =3D cpu_to_le32(alloc_len);
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&hdr, sizeof(hdr));
> +    if (!spdm_res) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);
> +
> +
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* An error here implies the prior if_recv from requester was spurio=
us */
> +    if (nvme_cmd_status !=3D NVME_SUCCESS) {
> +        return nvme_cmd_status;
> +    }
> +
> +    /* Clear to start receiving data from the server */
> +    rsp_spdm_buf =3D g_malloc0(alloc_len);

You might allocate quite a bit of memory here. Is that necessary? Would
be better to received chunked? Is that even possible with the socket
receive api?

> +    if (!rsp_spdm_buf) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    recvd =3D spdm_socket_receive(n->spdm_socket,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                rsp_spdm_buf, alloc_len);
> +    if (!recvd) {
> +        g_free(rsp_spdm_buf);
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
> +    g_free(rsp_spdm_buf);
> +
> +    if (alloc_len < recvd)  {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }

If this condition was true, wouldn't that mean you had more bytes
written into rsp_spdm_buf than you requested? And you would have written
out of bounds?

> +
> +    if (ret) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint8_t resp[12] =3D {0};
> +
> +    if (alloc_len < 12) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

NVMe specifies that "Allocation Length (AL): The value of this field is
specific to the Security Protocol In command with the INC_512 field
cleared to 0h as defined in SPC-5.". I cant seem to find the dword
alignment requirement anywhere in the referenced specifications.

> +
> +    /* Support Security Protol List Length */
> +    resp[6] =3D 0; /* MSB */
> +    resp[7] =3D 2; /* LSB */
> +    /* Support Security Protocol List */
> +    resp[8] =3D SFSC_SECURITY_PROT_INFO;
> +    resp[9] =3D NVME_SEC_PROT_DMTF_SPDM;
> +
> +    return nvme_c2h(n, resp, sizeof(resp), req);
> +}
> +
> +/* From controller to host */
> +static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint16_t spsp =3D dw10 & 0xFFFF;

Should this be (dw10 >> 8) & 0xffff ? Lower 8 bits are the NVMe Security
Specific Field (NSSF).

> +    uint8_t secp =3D (dw10 >> 24) & 0xff;
> +
> +    switch (secp) {
> +    case SFSC_SECURITY_PROT_INFO:
> +        switch (spsp) {
> +        case 0:
> +            /* Supported security protocol list */
> +            return nvme_get_sec_prot_info(n, req);
> +        case 1:
> +            /* Certificate data */
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
> @@ -7289,6 +7490,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRe=
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
> @@ -8708,7 +8913,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->ver =3D cpu_to_le32(NVME_SPEC_VER);
>      id->oacs =3D
>          cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT | NVME_OACS_DBB=
UF |
> -                    NVME_OACS_DIRECTIVES);
> +                    NVME_OACS_DIRECTIVES | NVME_OACS_SECURITY);
>      id->cntrltype =3D 0x1;
> =20
>      /*
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 7242206910..c8ad20ee34 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -459,6 +459,8 @@ static inline const char *nvme_adm_opc_str(uint8_t op=
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
> @@ -636,6 +638,9 @@ typedef struct NvmeCtrl {
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
> index f4d108841b..e2352cfb1e 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1733,6 +1733,21 @@ enum NvmeDirectiveOperations {
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
> 2.47.1
>=20
>=20

--ew5XDBNOiboGIrIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmeA8FQACgkQTeGvMW1P
DemP7wf/Rlbr9+7PEFk1hMEvui0uDGsFxqazilp03Km6RabZxsCijaEffFrCr2l4
wwKu/EZHQofSenRqJbV2GR4bS5Om8fNU8qVqOxduP2NIuILnLGblMAjcmIa/HBiV
u6oPsyT5bv1lnh0hkyPpTu6SwuYSipElTS+gGO+t5u5Bc59OenLKgK+Wk6Wt2qB0
U5t6Fqoedk/VxDo8ot77ULpvLEnfVWAxPRSt3FVfFXp5wuvhs9Bz2FUKU61OGLNo
ZAe3j+UT1q7LPvA28MqoK0OqmMroGq6lkFdslfs3Yib3YPU8hK+mLTTuxhyE3BGx
GhMM6hFVU1yfCnfN7lMjIX/z8TsmSg==
=QTFc
-----END PGP SIGNATURE-----

--ew5XDBNOiboGIrIw--

