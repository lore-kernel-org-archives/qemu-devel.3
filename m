Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB73C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29G-0006jO-4q; Tue, 10 Jun 2025 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP20y-0000kM-VX
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:39:59 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP20X-0005rM-Ao
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:39:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGvXG4n38z6L5FT;
 Wed, 11 Jun 2025 00:34:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 556DF140427;
 Wed, 11 Jun 2025 00:39:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 18:39:09 +0200
Date: Tue, 10 Jun 2025 17:39:05 +0100
To: Jonathan Cameron via <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Klaus Jensen
 <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni <fan.ni@samsung.com>,
 Anisa Su <anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>,
 <mst@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH qemu 3/5] hw/cxl/i2c_mctp_cxl: Initial device emulation
Message-ID: <20250610170104.00001392@huawei.com>
In-Reply-To: <20250609163334.922346-4-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
 <20250609163334.922346-4-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 9 Jun 2025 17:33:31 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> The CCI and Fabric Manager APIs are used to configure CXL switches and
> devices. DMTF has defined an MCTP binding specification to carry these
> messages. The end goal of this work is to hook this up to emulated CXL
> switches and devices to  allow control of the configuration.
> 
> Since this relies on i2c target mode, this can currently only be used with
> an SoC that includes the Aspeed I2C controller.
> 
> Note, only get timestamp added for now.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not very important given this is an RFC, but a chunk of code in here isn't
used so I'll drop it from future version...
(I noticed whilst wondering why Anisa didn't update it in they
 FMAPI DCD series).

> ---
>  include/hw/cxl/cxl_device.h               |   8 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  hw/cxl/cxl-mailbox-utils.c                |  49 ++++
>  hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++++++++++++++
>  hw/cxl/Kconfig                            |   4 +
>  hw/cxl/meson.build                        |   4 +
>  6 files changed, 355 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 6086d4c85b..8d87c7151e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -360,6 +360,10 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                              size_t len_in, uint8_t *pl_in,
>                              size_t *len_out, uint8_t *pl_out,
>                              bool *bg_started);
> +
> +void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
> +                               size_t payload_max);
> +

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 475547f212..4c9852642e 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3690,6 +3690,29 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>      cxl_init_cci(cci, payload_max);
>  }
>  
> +static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
> +    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
> +    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> +    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
> +                              0 },
> +    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
> +                                     cmd_tunnel_management_cmd, ~0, 0 },
> +};
> +
> +void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
> +                               size_t payload_max)
> +{
> +    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
> +    cci->d = d;
> +    cci->intf = intf;
> +    cxl_init_cci(cci, payload_max);
> +}
> +
At some point a while back, when adding tunneling we decided to pretend
we have an MLD (because it's more general) and as such introduced the fm owned
mctpcci.  That's the one one that is used for the landing point of mctp
links to a type 3 device.  So this code is unused.



