Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84622CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu76o-0008BD-DN; Thu, 04 Sep 2025 06:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu76m-0008A7-5w; Thu, 04 Sep 2025 06:22:24 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu76g-00059y-Ra; Thu, 04 Sep 2025 06:22:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHb611NkNz6J6yc;
 Thu,  4 Sep 2025 18:18:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id DF8AB1402F5;
 Thu,  4 Sep 2025 18:22:07 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 12:22:07 +0200
Date: Thu, 4 Sep 2025 11:22:05 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, <dlemoal@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <20250904112205.00007e47@huawei.com>
In-Reply-To: <20250904031058.367667-5-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-5-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  4 Sep 2025 13:10:57 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Hi Wilfred, 

I haven't even opened the nvme spec on basis others are covering that
part well. So this is just a review based on the code in this patch
so mostly style stuff.

Jonathan

> ---
>  hw/nvme/ctrl.c       | 213 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   5 +
>  include/block/nvme.h |  15 +++
>  3 files changed, 232 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f5ee6bf260..df72599bcc 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] = {
>      [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]   = NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]   = NVME_CMD_EFF_CSUPP,

Maybe it's an email thing but that alignment of = looks off by one space.

>  };
>  
>  static const uint32_t nvme_cse_iocs_nvm_default[256] = {
> @@ -7282,6 +7284,210 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr = {0};
> +    g_autofree uint8_t *sec_buf = NULL;
> +    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len = transfer_len;
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp = extract32(dw10, 24, 8);
> +    uint8_t spsp1 = extract32(dw10, 16, 8);
> +    uint8_t spsp0 = extract32(dw10, 8, 8);

See below. 16 bit field seems more logical to me.

> +    bool spdm_res;
> +
> +    if (transport_transfer_len > UINT32_MAX - sizeof(hdr)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    transport_transfer_len += sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    ret = nvme_check_mdts(n, transport_transfer_len);
> +    if (ret != NVME_SUCCESS) {
> +        return ret;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol = secp;
> +    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
> +    hdr.length = cpu_to_le32(transfer_len);
> +
> +    sec_buf = g_try_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_INTERNAL_DEV_ERROR;
> +    }
> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
> +                                transport_transfer_len);
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,

As in earlier patch, spdm_socket_receive() seems to take a void * so no cast
should be needed and definitely not to a uint8_t *!

> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status = be16_to_cpu(nvme_cmd_status);
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
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp = (dw10 >> 24) & 0xff;

Used extract32() below. Why not for this one?

> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        if (n->spdm_socket <= 0) {
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
> +    g_autofree uint8_t *rsp_spdm_buf = NULL;
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
> +    uint32_t recvd, spdm_res;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp = extract32(dw10, 24, 8);
> +    uint8_t spsp1 = extract32(dw10, 16, 8);
> +    uint8_t spsp0 = extract32(dw10, 8, 8);

This is a little odd. You break out two 8 bit fields here just
to combine them again below.  Why not a 16bit field?
If its about spec alignment maybe call that field spsp0_1


> +
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr = (StorageSpdmTransportHeader) {
> +        .security_protocol = secp,
> +        .security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0),
> +        .length = cpu_to_le32(alloc_len),
> +    };
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&hdr, sizeof(hdr));

As above.

> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                (uint8_t *)&nvme_cmd_status,

As above - seems to be a spurious cast.

> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);



