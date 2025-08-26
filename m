Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C310BCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqq5c-00076E-K3; Tue, 26 Aug 2025 05:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqq5Z-000761-K1
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:35:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqq5S-00008C-Vb
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:35:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB2Yf0JNyz6GDX8;
 Tue, 26 Aug 2025 17:34:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 97A191402F5;
 Tue, 26 Aug 2025 17:34:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 11:34:58 +0200
Date: Tue, 26 Aug 2025 10:34:57 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 1/4] spdm-socket: add seperate send/recv functions
Message-ID: <20250826103457.0000698e@huawei.com>
In-Reply-To: <20250826054630.222052-2-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
 <20250826054630.222052-2-wilfred.opensource@gmail.com>
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

On Tue, 26 Aug 2025 15:46:27 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
Hi Wilfred,

Great to see this support.

> This is to support uni-directional transports such as SPDM
> over Storage. As specified by the DMTF DSP0286.

Trivial, wrap commit closer to 75 chars.

> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  backends/spdm-socket.c       | 27 ++++++++++++++++++++++++---
>  include/system/spdm-socket.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index 2c709c68c8..bab1b512c8 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -184,6 +184,29 @@ int spdm_socket_connect(uint16_t port, Error **errp)
>      return client_socket;
>  }
>  
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len)
> +{
> +    uint32_t command;
> +    bool result;
> +
> +    result = receive_platform_data(socket, transport_type, &command,
> +                                   (uint8_t *)rsp, &rsp_len);
> +
> +    if (!result || command == 0) {

Comment on why command == 0 is good even if result is a fail.
In the existing code, there is an assert if result is true and command != 0,
why don't we need similar here?  Might be worth adding a comment on that
special case to the existing code as I for one can't remember what it is for :(
Ah I see you modify it below. 


> +        return 0;
> +    }
> +
> +    return rsp_len;
> +}
> +
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_len)
> +{
> +    return send_platform_data(socket, transport_type,
> +                              socket_cmd, req, req_len);
> +}
> +
>  uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>                           void *req, uint32_t req_len,
>                           void *rsp, uint32_t rsp_len)
> @@ -200,12 +223,10 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>  
>      result = receive_platform_data(socket, transport_type, &command,
>                                     (uint8_t *)rsp, &rsp_len);
> -    if (!result) {
> +    if (!result || command == 0) {

Add a comment here as well on 'why'.  Or can we have socket_rsp just call spdm_socket_send
+ spdm_socket_receive?  That would at least put the comment in just one place.

>          return 0;
>      }
>  
> -    assert(command != 0);
> -
>      return rsp_len;
>  }
>  
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 5d8bd9aa4e..2b7d03f82d 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -50,6 +50,35 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>                           void *req, uint32_t req_len,
>                           void *rsp, uint32_t rsp_len);
>  
> +/**
> + * spdm_socket_rsp: Receive a message from an SPDM server
> + * @socket: socket returned from spdm_socket_connect()
> + * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
> + * @rsp: response buffer
> + * @rsp_len: response buffer length
> + *
> + * Receives a message from the SPDM server and returns the number of bytes
> + * received or 0 on failure. This can be used to receive a message from the SPDM
> + * server without sending anything first.
> + */
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len);
> +
> +/**
> + * spdm_socket_rsp: Sends a message to an SPDM server
> + * @socket: socket returned from spdm_socket_connect()
> + * @socket_cmd: socket command type (normal/if_recv/if_send etc...)
> + * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
> + * @req: request buffer
> + * @req_len: request buffer length
> + *
> + * Sends platform data to a SPDM server on socket, returns true on success.
> + * The response from the server must then be fetched by using
> + * spdm_socket_receive().
> + */
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_len);
> +
>  /**
>   * spdm_socket_close: send a shutdown command to the server
>   * @socket: socket returned from spdm_socket_connect()
> @@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>  
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
> +#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
> +#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> +#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
>  #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
>  #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
>  #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
> @@ -68,7 +100,10 @@ void spdm_socket_close(const int socket, uint32_t transport_type);
>  
>  #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
>  #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
> +#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
>  
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
>  
>  #endif


