Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E17CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu79A-00024R-QZ; Thu, 04 Sep 2025 06:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu794-0001q1-UV; Thu, 04 Sep 2025 06:24:47 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu78x-00062U-3I; Thu, 04 Sep 2025 06:24:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHbD85dtqz6L4sl;
 Thu,  4 Sep 2025 18:23:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6EA021404C4;
 Thu,  4 Sep 2025 18:24:32 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 12:24:31 +0200
Date: Thu, 4 Sep 2025 11:24:30 +0100
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
Subject: Re: [PATCH v4 4/5] spdm: define SPDM transport enum types
Message-ID: <20250904112430.00006b3b@huawei.com>
In-Reply-To: <20250904031058.367667-6-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-6-wilfred.opensource@gmail.com>
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

On Thu,  4 Sep 2025 13:10:58 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> SPDM maybe used over different transports, such as PCIe Data Object
> Exchange (DoE) or Storage amongst others. This patch

Odd line wrap.  I'd also drop the 'amongst others' as 'such as' already
suggests there are others so t those extra words add no meaning.

> specifies such types as an enum with a qdev property definition such that
> a user input transport type (string) can be mapped directly into the
> respective SPDM transport enum for internal use.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Trivial comment below.

> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 6c2cb7b926..8fb5f7cf40 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -110,12 +110,25 @@ typedef struct {
>  #define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
>  #define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
>  
> -#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
> -#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> -#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
> -#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
> -
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
>  #define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
>  
> +typedef enum SpdmTransportType {
> +    SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC = 0,
> +    SPDM_SOCKET_TRANSPORT_TYPE_MCTP,
> +    SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
> +    SPDM_SOCKET_TRANSPORT_TYPE_SCSI,
> +    SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +    SPDM_SOCKET_TRANSPORT_TYPE_MAX,

Given it will always be last element and I assume isn't a spec thing as such,
but just a useful terminating entry, I'd drop that trailing comma.

> +} SpdmTransportType;
> +
> +extern const PropertyInfo qdev_prop_spdm_trans;
> +
> +#define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
> +    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
> +                         qdev_prop_spdm_trans, SpdmTransportType)
> +#define DEFINE_PROP_SPDM_TRANS_NODEFAULT(_name, _state, _field) \
> +    DEFINE_PROP_SPDM_TRANS(_name, _state, _field, \
> +                           SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC)
> +
>  #endif


