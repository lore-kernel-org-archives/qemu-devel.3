Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075ADCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3seh-0001uQ-Sw; Wed, 01 Oct 2025 04:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3seS-0001rK-Jy; Wed, 01 Oct 2025 04:57:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3seB-0006YM-Pr; Wed, 01 Oct 2025 04:57:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cc7z51Tn2z6L4wX;
 Wed,  1 Oct 2025 16:54:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id D6E8A140114;
 Wed,  1 Oct 2025 16:56:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 09:56:53 +0100
Date: Wed, 1 Oct 2025 09:56:51 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Message-ID: <20251001095651.0000576a@huawei.com>
In-Reply-To: <20250912021152.46556-3-wilfred.opensource@gmail.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-3-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 12 Sep 2025 12:11:49 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This header contains the transport encoding for an SPDM message that
> uses the SPDM over Storage transport as defined by the DMTF DSP0286.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

FWIW I checked the field definitions that I could find, and this looks fine.
If it's possible to give more focused reference (section etc) that might
be worth doing. For example I wasn't entirely sure where the size of
the security_protocol field is defined.  This matches with what libspdm has
though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  include/system/spdm-socket.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 29aa04fd52..80cd7021c1 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
>   */
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>  
> +/*
> + * Defines the transport encoding for SPDM, this information shall be passed
> + * down to the SPDM server, when conforming to the SPDM over Storage standard
> + * as defined by DSP0286.
> + */
> +typedef struct {
> +    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Commands */
> +    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
> +                                               Bit[0:1] Connection ID */
> +    uint32_t length;                        /* Length of the SPDM Message*/
> +} QEMU_PACKED StorageSpdmTransportHeader;
> +
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
>  #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
>  #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003


