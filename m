Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94053C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAkP-00027K-9c; Thu, 07 Mar 2024 05:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAkN-00026y-Nl
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:13:07 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAk9-0004uu-Em
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:13:07 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a4429c556efso100155466b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709806371; x=1710411171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ninZKFCz4+ELRJna5U19ZymEEI8bWBRiNtIINR38Bvo=;
 b=ZEyuUVNnFhsW5qSH/ryraAq5P3GxZ3HC1kY6QgSBTf5aHQY8AmMu7Q68l8XRxjn3zK
 J8cvEwQdBacfyXi1B4/TK+9hS5n4SsGwbVgLjcwuaIYeqq7fDCEjUk+0E+9DNSXi/s/j
 FN/foKww3QGIy0J+ZJ1KfYe5XXoLZsPuuiLMTBzkAYU8CRHlCPp32wfI1EA5qDDsIh96
 NgsF3IM3MKfydM3sly6wM3WJCTL5YlOviqcYX+35H01CHWRdVY//JSZ3hViU45Y/FZRW
 HkF44zVp42MEg+ILCBeI16g7j5zR1Zk2kdm+QKVYXbPdLPmmldiRIX6ILWxjAxkEVgGK
 ATJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806371; x=1710411171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ninZKFCz4+ELRJna5U19ZymEEI8bWBRiNtIINR38Bvo=;
 b=qOajOYoLL7cQKc+GzqsdubtoOXoyV6bG+JFw6xYQ2cE6hUiEqA2/xG/mahl9jy1ob6
 B87CvqxPsvr3xtIZtvol5436uqKGKx4gQvNrXxgQ4jO7OEIFlmeLLjkqvtsy7W2DFoCa
 A+vTj+C+TZaJdENHSR3sqL72JPhKdBPm5OET2n5Sk/vLUbmRMqV+OoHtXJt5Xx9ehfkz
 tGqzL2A3VQw5JWgdeZi6teINRPAuk3K1vTlP728mzSQu45k2F18C4Y87As9Dz+2m1sjp
 ou21FRfC5IvjvWJvbnO+9IwJg0Aakp45WpFuXsGoF2hLpitFlsweZvvc2DU6P/FJ/ZiH
 Ofhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS3JISaS3Joyx+hYs+N90VSLfvyKsOjxquuDYNCFj9ydjP7ggeRaabF2+9AiBwYi19cCIcHQ9HudCdwMOG2TopCzRS04A=
X-Gm-Message-State: AOJu0Yzo9jXQzL6GWHdGUradPQgGph7qLmBcio4cfk02COwrcXtAFcAT
 3UmC4m3qvQwn8HsJFWqg2zNq7U06ja5On3SGxb7cCjBDJUIDfgt0+ZxT9MKIVds=
X-Google-Smtp-Source: AGHT+IHZPnllXHV/qsUX16zuQl06eZealK3p5XPTCbouqDa6vX/A2TXcGTI4HEaIE0ZNoPg4VtE7ig==
X-Received: by 2002:a17:906:410:b0:a45:c997:2267 with SMTP id
 d16-20020a170906041000b00a45c9972267mr1335149eja.65.1709806370795; 
 Thu, 07 Mar 2024 02:12:50 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 sa20-20020a1709076d1400b00a4432543b21sm8020137ejc.198.2024.03.07.02.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:12:50 -0800 (PST)
Message-ID: <1f3fe77f-7139-4e40-a279-0f59771b96b4@linaro.org>
Date: Thu, 7 Mar 2024 11:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] backends: Initial support for SPDM socket support
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, marcel.apfelbaum@gmail.com,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, mst@redhat.com,
 hchkuo@avery-design.com.tw, wilfred.mallawa@wdc.com,
 cbrowy@avery-design.com, kbusch@kernel.org, lukas@wunner.de,
 jiewen.yao@intel.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307005859.356555-1-alistair.francis@wdc.com>
 <20240307005859.356555-3-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307005859.356555-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/3/24 01:58, Alistair Francis wrote:
> From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> 
> SPDM enables authentication, attestation and key exchange to assist in
> providing infrastructure security enablement. It's a standard published
> by the DMTF [1].
> 
> SPDM supports multiple transports, including PCIe DOE and MCTP.
> This patch adds support to QEMU to connect to an external SPDM
> instance.
> 
> SPDM support can be added to any QEMU device by exposing a
> TCP socket to a SPDM server. The server can then implement the SPDM
> decoding/encoding support, generally using libspdm [2].
> 
> This is similar to how the current TPM implementation works and means
> that the heavy lifting of setting up certificate chains, capabilities,
> measurements and complex crypto can be done outside QEMU by a well
> supported and tested library.
> 
> 1: https://www.dmtf.org/standards/SPDM
> 2: https://github.com/DMTF/libspdm
> 
> Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> [ Changes by WM
>   - Bug fixes from testing
> ]
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> [ Changes by AF:
>   - Convert to be more QEMU-ified
>   - Move to backends as it isn't PCIe specific
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS                  |   6 +
>   include/sysemu/spdm-socket.h |  44 +++++++
>   backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
>   backends/Kconfig             |   4 +
>   backends/meson.build         |   2 +
>   5 files changed, 272 insertions(+)
>   create mode 100644 include/sysemu/spdm-socket.h
>   create mode 100644 backends/spdm-socket.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4183f2f3ab..a07706c225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3395,6 +3395,12 @@ F: tests/qtest/*tpm*
>   F: docs/specs/tpm.rst
>   T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>   
> +SPDM
> +M: Alistair Francis <alistair.francis@wdc.com>
> +S: Maintained
> +F: backends/spdm-socket.c
> +F: include/sysemu/spdm-socket.h
> +
>   Checkpatch
>   S: Odd Fixes
>   F: scripts/checkpatch.pl
> diff --git a/include/sysemu/spdm-socket.h b/include/sysemu/spdm-socket.h
> new file mode 100644
> index 0000000000..24e6fccb83
> --- /dev/null
> +++ b/include/sysemu/spdm-socket.h
> @@ -0,0 +1,44 @@
> +/*
> + * QEMU SPDM socket support
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef SPDM_REQUESTER_H
> +#define SPDM_REQUESTER_H
> +
> +int spdm_socket_connect(uint16_t port, Error **errp);

Could we have a short description on what this function returns
and its arguments?

> +uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
> +                         void *req, uint32_t req_len,
> +                         void *rsp, uint32_t rsp_len);

Ditto.

> +void spdm_socket_close(const int socket, uint32_t transport_type);
> +
> +#define SPDM_SOCKET_COMMAND_NORMAL                0x0001
> +#define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
> +#define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
> +#define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
> +#define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
> +#define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
> +
> +#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
> +#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +
> +#define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +
> +#endif


