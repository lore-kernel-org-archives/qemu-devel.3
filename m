Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22795E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 02:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXt9f-0001eU-LG; Tue, 14 Jan 2025 21:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXt9W-0001e5-Gg; Tue, 14 Jan 2025 21:29:08 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXt9R-0006FA-Uv; Tue, 14 Jan 2025 21:29:03 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-8622c3be2f4so1577180241.1; 
 Tue, 14 Jan 2025 18:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736908139; x=1737512939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6MnQJ5SdoE3cwJjeXqbRM1iQhuqD/4XI8s5u7XsUnI=;
 b=Gnu//PBRQNzvZLnrB9Ck2Ttm2EdoOehiPvUZb6gVusC9q/ytPhdjyKutETojxr9SJn
 aRnbjB07mrgJfKRAwoCvihAE0FFyAWKGkzNU15moyQA236eihoopaeKBdX6zd/cAYScs
 VCQRrjAxTVB9Nh1ec6NW6fDSWOZRXPYKAtDH9Ey6s0PU0OONM+IilnStHP/nroUmTo/k
 Gppk4LMVdjmEhGvAew04ciHYM3KDNb007lRbJhuEokUYPom/RqOwKvNXcy7N16vG4tdQ
 11olayQa9FmYzhm2ZeR0I2xMhD9VZy8eBL7QKGVgp83cI3Ba5E607oTEoRnIXMXkI2Jw
 ejpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736908139; x=1737512939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6MnQJ5SdoE3cwJjeXqbRM1iQhuqD/4XI8s5u7XsUnI=;
 b=HANEUfmwlelO3V7ALMxieRP5ATjNhrzO+Hz3SjQkkeVVnXjBPRBemza/DTJZn4L5gY
 Zs3NDCMStwS5/SzseIAXgeW+LcCMjvaWKwnvqFEfSmSD7zL8jwkN/McYTZdmBJ2ib74E
 70sbD9w+gAHeve+XVoOIWXERIP9MgHPdfdfG79txniRy9fmvXGIcrMl/2mlApUjtqOLE
 4PDEQYu3uICieCMK95VqyTrUu/o9Uf94/TDxqzR6v0knz8iDiANUNmeWO3kFJxtUi+RF
 lP6fWHM+Q3p09CUCshZr44cEax9GA84nHwmxaTt+YE4Ei8p5158yygiYqv83KZ+In7hI
 BG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBtZNyQvF8bsjDaKYuXLqJFWzokJujwNNdXsidnBKjdi8YDzvSOQllA94s4d3z2zQrVnCM9aCGTLjK@nongnu.org
X-Gm-Message-State: AOJu0YwLqLGAIdvxHDfFal+p41ryFA0RnFMIbajZ2LK82OOt5/5pwM8o
 wRwzUdsGcFKydhOkfidC2UyTwp4haWUf/ln2Qcr87R3vOlPbPJ30Mc4fQjU43QoWO8ixyr540Uz
 nTYMZ87wLs739maEK2e8Z71mUZ+k=
X-Gm-Gg: ASbGnct/hsi+fow7X3PYaSSXl3T8LplXyuaIHruoVBpN4TKSmLV2CESxx1LB0NVV9eI
 PQ3QllPyWtwTQUjC3X/CF+eiSaNisDmGLKmbpnXmMo3LMfe8j7MUuev36byFB0uuAnqcB
X-Google-Smtp-Source: AGHT+IGc5AQnEVbYhehiY43rc8DOSOG/HM7Bu0BTakCu+Qut4XZOQDCgFlJ+rPFz+2wkMfz7Xx7eHI9rPlx+W76wRAU=
X-Received: by 2002:a05:6102:50a3:b0:4b2:9e8b:54c with SMTP id
 ada2fe7eead31-4b3d106e36emr24839820137.24.1736908138832; Tue, 14 Jan 2025
 18:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-4-wilfred.mallawa@wdc.com>
In-Reply-To: <20250107052906.249973-4-wilfred.mallawa@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Jan 2025 12:28:32 +1000
X-Gm-Features: AbW1kvbfNGjhMNtFH0DSFWT21Xv-t6T9AqTr3PuQ0RbUJ6lr-1lqM9ynM2B6-P0
Message-ID: <CAKmqyKOE+_7sq4zpCPjymaQZ9TV=+8owVKOyPO3wPeGovY9TUQ@mail.gmail.com>
Subject: Re: [RFC 1/4] spdm-socket: add seperate send/recv functions
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, alistair.francis@wdc.com, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, stefanha@redhat.com, 
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, 
 mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 8, 2025 at 12:04=E2=80=AFAM Wilfred Mallawa via
<qemu-devel@nongnu.org> wrote:
>
> This is to support uni-directional transports such as SPDM
> over Storage. As specified by the DMTF DSP0286.
>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  backends/spdm-socket.c       | 25 +++++++++++++++++++++++++
>  include/system/spdm-socket.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index 2c709c68c8..4421b5c532 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -184,6 +184,31 @@ int spdm_socket_connect(uint16_t port, Error **errp)
>      return client_socket;
>  }
>
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len)
> +{
> +    uint32_t command;
> +    bool result;
> +
> +    result =3D receive_platform_data(socket, transport_type, &command,
> +                                   (uint8_t *)rsp, &rsp_len);
> +
> +    if (!result) {
> +        return 0;
> +    }
> +
> +    assert(command !=3D 0);

This should return an error instead of assert

> +
> +    return rsp_len;
> +}
> +
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_l=
en)
> +{
> +    return send_platform_data(socket, transport_type,
> +                              socket_cmd, req, req_len);
> +}
> +
>  uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>                           void *req, uint32_t req_len,
>                           void *rsp, uint32_t rsp_len)
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 5d8bd9aa4e..2b7d03f82d 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -50,6 +50,35 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t tr=
ansport_type,
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
> + * Receives a message from the SPDM server and returns the number of byt=
es
> + * received or 0 on failure. This can be used to receive a message from =
the SPDM
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
> + * Sends platform data to a SPDM server on socket, returns true on succe=
ss.
> + * The response from the server must then be fetched by using
> + * spdm_socket_receive().
> + */
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_l=
en);
> +
>  /**
>   * spdm_socket_close: send a shutdown command to the server
>   * @socket: socket returned from spdm_socket_connect()
> @@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t tra=
nsport_type,
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
> +#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
> +#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> +#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
>  #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
>  #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
>  #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
> @@ -68,7 +100,10 @@ void spdm_socket_close(const int socket, uint32_t tra=
nsport_type);
>
>  #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
>  #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
> +#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04

This should be in a different patch

Alistair

>
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
>
>  #endif
> --
> 2.47.1
>
>

