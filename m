Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9529CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqq95-0008Cg-S8; Tue, 26 Aug 2025 05:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqq92-0008C2-Au
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:39:13 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqq8u-0000wE-Mm
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:39:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB2Zs1xt9z6L51X;
 Tue, 26 Aug 2025 17:35:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CBBC81402EB;
 Tue, 26 Aug 2025 17:38:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 11:38:54 +0200
Date: Tue, 26 Aug 2025 10:38:52 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 2/4] spdm: add spdm storage transport virtual header
Message-ID: <20250826103852.000042e9@huawei.com>
In-Reply-To: <20250826054630.222052-3-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
 <20250826054630.222052-3-wilfred.opensource@gmail.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 26 Aug 2025 15:46:28 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This header contains the transport encoding for an SPDM message that
> uses the SPDM over Storage transport as defined by the DMTF DSP0286.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  include/system/spdm-socket.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 2b7d03f82d..2469424cce 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -88,6 +88,17 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
>   */
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>  
> +/*
> + * Defines the transport encoding for SPDM, this information shall be passed
> + * down to the SPDM server, when conforming to the SPDM over Storage standard
> + * as defined by DSP0286.

I'd use /** kernel-doc (I guess qemu-doc) style comments and fully document the parameters.

> + */
> +typedef struct QEMU_PACKED {
Hmm. I've always seen the QEMU_PACKED after the struct definition.
Not sure if there are any 'rules' on this as such but it was there
for the first 5 or so random cases I looked at.

> +    uint8_t security_protocol;
> +    uint16_t security_protocol_specific;
> +    uint32_t length;
> +} StorageSpdmTransportHeader;
> +
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
>  #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
>  #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003


