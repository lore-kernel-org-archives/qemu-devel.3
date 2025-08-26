Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B06CCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrcM-0002ua-7M; Tue, 26 Aug 2025 07:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqrcJ-0002tp-OS; Tue, 26 Aug 2025 07:13:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqrcD-0005zA-NZ; Tue, 26 Aug 2025 07:13:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB4gb35MJz6L5Pc;
 Tue, 26 Aug 2025 19:09:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3542A1402ED;
 Tue, 26 Aug 2025 19:13:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 13:13:08 +0200
Date: Tue, 26 Aug 2025 12:13:06 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 3/4] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <20250826121306.000071df@huawei.com>
In-Reply-To: <20250826054630.222052-4-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
 <20250826054630.222052-4-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 26 Aug 2025 15:46:29 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
A few suggestions inline that might slightly improve this.
Looks to be in a good state to me.

Jonathan
  
> ---
>  hw/nvme/ctrl.c       | 202 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   5 ++
>  include/block/nvme.h |  15 ++++
>  3 files changed, 221 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f5ee6bf260..442144642d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] = {
>      [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]   = NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]   = NVME_CMD_EFF_CSUPP,
>  };
>  
>  static const uint32_t nvme_cse_iocs_nvm_default[256] = {
> @@ -7282,6 +7284,199 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr = {0};
> +    uint8_t *sec_buf;
> +    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len = transfer_len;
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status;
> +    uint16_t ret;
> +    uint8_t secp = (dw10 >> 24) & 0xFF;
> +    uint8_t spsp1 = (dw10 >> 16) & 0xFF;
> +    uint8_t spsp0 = (dw10 >> 8) & 0xFF;
> +    bool spdm_res;
> +
> +    transport_transfer_len += sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol = secp;
> +    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.length = cpu_to_le32(transfer_len);

Similar comments to below apply to this function.

> +
> +    sec_buf = g_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
> +                                transport_transfer_len);
> +    if (!spdm_res) {
> +        g_free(sec_buf);
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
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
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp = (dw10 >> 24) & 0xff;
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
> +    StorageSpdmTransportHeader hdr = {0};
> +    uint8_t *rsp_spdm_buf;
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t recvd, spdm_res;
> +    uint16_t nvme_cmd_status;
> +    uint16_t ret;

Maybe combine with previous line.

> +    uint8_t secp = (dw10 >> 24) & 0xFF;
> +    uint8_t spsp1 = (dw10 >> 16) & 0xFF;
> +    uint8_t spsp0 = (dw10 >> 8) & 0xFF;

Perhaps extract32()

> +
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */

Could do
    hdr = (StorageSpdmTransportHeader) {
        .security_protocol = secp,
	.security_protocol_specific = cpu_to_le...
	.length = cpu_to_le32(alloc_len),
    };
and skip the {0} above. Up to you but I find this style a little more readable
as can see here that other fields are all zero'd rather than having to look
above.

> +    hdr.security_protocol = secp;
> +    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.length = cpu_to_le32(alloc_len);
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&hdr, sizeof(hdr));
> +    if (!spdm_res) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
> +

Single blank line enough.

> +
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    /* An error here implies the prior if_recv from requester was spurious */
> +    if (nvme_cmd_status != NVME_SUCCESS) {
> +        return nvme_cmd_status;
> +    }
> +
> +    /* Clear to start receiving data from the server */
> +    rsp_spdm_buf = g_malloc0(alloc_len);

maybe
    g_autofree uint8_t *rsp_spdm_buf = g_malloc0(alloc_len);
and drop explicit frees later.

> +    if (!rsp_spdm_buf) {
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    recvd = spdm_socket_receive(n->spdm_socket,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                rsp_spdm_buf, alloc_len);
> +    if (!recvd) {
> +        g_free(rsp_spdm_buf);
> +        return NVME_NO_COMPLETE | NVME_DNR;
> +    }
> +
> +    ret = nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
> +    g_free(rsp_spdm_buf);
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
> +    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
> +    uint8_t resp[10] = {0};

Could do
    uint8_t resp[10] = {
        /* Support Security Protol List Length */
	[6] = 0,
	[7] = 2,
etc but not particularly important.

> +
> +    if (alloc_len < 10) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Support Security Protol List Length */
> +    resp[6] = 0; /* MSB */
> +    resp[7] = 2; /* LSB */
> +    /* Support Security Protocol List */
> +    resp[8] = SFSC_SECURITY_PROT_INFO;
> +    resp[9] = NVME_SEC_PROT_DMTF_SPDM;
> +
> +    return nvme_c2h(n, resp, sizeof(resp), req);
> +}
> +
> +/* From controller to host */
> +static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint16_t spsp = (dw10 >> 8) & 0xFFFF;
> +    uint8_t secp = (dw10 >> 24) & 0xFF;

Perhaps use extract32().

> +
> +    switch (secp) {
> +    case SFSC_SECURITY_PROT_INFO:
> +        switch (spsp) {
> +        case 0:
> +            /* Supported security protocol list */
> +            return nvme_get_sec_prot_info(n, req);
> +        case 1:
> +            /* Certificate data */

Even though I guess this is temporary this probably should have
an explicit fall through marking.

> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        return nvme_sec_prot_spdm_receive(n, req);
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}



