Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C8DC25B5C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwYf-0000EV-Rf; Thu, 25 Apr 2024 06:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwYd-0008NV-Nc
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:42:27 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwYb-0007dp-OE
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:42:27 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so9305731fa.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041744; x=1714646544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQvojeQR8GDvv5LfZTwKARJFKYCu6zUt5V+bZDXmKU4=;
 b=Q1TWWoWHsErHi8P/SoSP8OFuSdEgNsDaNrKYBpb70UFMQLEXbuh3QSS2LaIamG0BVe
 HI4RS7k+bjkytqnolvwt3PD4cynj3X2bm2wHc6szNqD4PD8zJB4mMlw2nZz0fuXzgz9J
 yz7LS/hyNqydt+CKtAxURyLwNdZRJLWXq9ON9FzoajGS5+an4q5eW5S2z687KFZb0zZw
 J02xPz9R0NdZjpR70Jt+3Od3Fbvf9OBGUZGmuBoqazqeVoldKkmf0CMbqJ2LsgkZhuoA
 kQ8t0eNy/AkBiRO/yXUtmNmRorfhtLkWrZDeuDMhApkUTGnY/4BUFVdkWR8rrPE0EEw7
 jqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041744; x=1714646544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQvojeQR8GDvv5LfZTwKARJFKYCu6zUt5V+bZDXmKU4=;
 b=HYCbG0uD1NzyYPNUqyNzsFtc26trByY+NrbWsK3tQw07m5J2cGtD+3CiQ46OTOIpKl
 0BXah1O7VpJqNbBgx4UoRb3b+5xE3PsVOHxBdOOxAS4XnPEPxec3/9rt46U8Y2kmjaWK
 nydszKV/Dsv2yfGFSZPsGCxybwOiPzo8PWR2dbvJfBLEEJs+KZKqcxBA+1mSS8zWAGML
 wxPlsTNeiiEnHoX0FvEf11W9zaIbdocw/C1WKd97OqW4csg1X2G9SZsTm3I52UvKSEjG
 RB1Pf4MwGLv2+6fK5Ym8pAk9maRnQHiENfAS0t7k6rjUZTLsjK46rPj9r2+N9RbzUtog
 7G6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEcQ0Td9RuB8EMTaZ4AQ13/tSu/m9473nwNDMqSLvJ3U2HZzZFF/fr3OsRsCsWn0xP/xQaTLjbr9N0SxkJQzCANBW7+6A=
X-Gm-Message-State: AOJu0YxXv1b8l27m0qA4BfqA9Jr+wQoyx3vhLmIlq05RzW44kkhD8bZr
 pXSxHocmedU0P34a2KUU3v4bbDVkWX1qeLnL6OdDEW5d4C/9Sj6QBnnxLPHUFGM=
X-Google-Smtp-Source: AGHT+IHg+0nolmJVtXIQ6DK2rCLAwom/FvVLjVZEs5kX9XxZN1YEWFYvdqsr0FJj17kun4v8CoT7GA==
X-Received: by 2002:a2e:9f42:0:b0:2d4:5321:9daf with SMTP id
 v2-20020a2e9f42000000b002d453219dafmr3420580ljk.44.1714041743833; 
 Thu, 25 Apr 2024 03:42:23 -0700 (PDT)
Received: from [192.168.113.175] ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b00417f700eaeasm27263118wmo.22.2024.04.25.03.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 03:42:23 -0700 (PDT)
Message-ID: <074c9cbb-939e-4fb1-87a9-235626bf3a94@linaro.org>
Date: Thu, 25 Apr 2024 12:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fix host-endianness bug
To: Alexandra Diupina <adiupina@astralinux.ru>,
 Alistair Francis <alistair@alistair23.me>
Cc: "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20240425100718.20184-1-adiupina@astralinux.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425100718.20184-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Alexandra,

On 25/4/24 12:07, Alexandra Diupina wrote:
> Add a function xlnx_dpdma_read_descriptor() that
> combines reading the descriptor from desc_addr
> by calling dma_memory_read() and swapping desc
> fields from guest memory order to host memory order.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2:minor changes in xlnx_dpdma_read_descriptor()
>   hw/dma/xlnx_dpdma.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index dd66be5265..62a0952377 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -614,6 +614,34 @@ static void xlnx_dpdma_register_types(void)
>       type_register_static(&xlnx_dpdma_info);
>   }
>   
> +static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
> +                                    uint64_t desc_addr, DPDMADescriptor *desc)
> +{
> +    if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> +                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED))
> +        return MEMTX_ERROR;
> +
> +    /* Convert from LE into host endianness.  */
> +    desc->control = le32_to_cpu(desc->control);
> +    desc->descriptor_id = le32_to_cpu(desc->descriptor_id);
> +    desc->xfer_size = le32_to_cpu(desc->xfer_size);
> +    desc->line_size_stride = le32_to_cpu(desc->line_size_stride);
> +    desc->timestamp_lsb = le32_to_cpu(desc->timestamp_lsb);
> +    desc->timestamp_msb = le32_to_cpu(desc->timestamp_msb);
> +    desc->address_extension = le32_to_cpu(desc->address_extension);
> +    desc->next_descriptor = le32_to_cpu(desc->next_descriptor);
> +    desc->source_address = le32_to_cpu(desc->source_address);
> +    desc->address_extension_23 = le32_to_cpu(desc->address_extension_23);
> +    desc->address_extension_45 = le32_to_cpu(desc->address_extension_45);
> +    desc->source_address2 = le32_to_cpu(desc->source_address2);
> +    desc->source_address3 = le32_to_cpu(desc->source_address3);
> +    desc->source_address4 = le32_to_cpu(desc->source_address4);
> +    desc->source_address5 = le32_to_cpu(desc->source_address5);
> +    desc->crc = le32_to_cpu(desc->crc);
> +
> +    return MEMTX_OK;
> +}
> +
>   size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>                                       bool one_desc)
>   {
> @@ -651,8 +679,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>               desc_addr = xlnx_dpdma_descriptor_next_address(s, channel);
>           }
>   
> -        if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> -                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
> +        if (xlnx_dpdma_read_descriptor(s, desc_addr, &desc)) {

Correct, but this is incomplete, because we have the same problem
on the write descriptor back path, few lines later in the
xlnx_dpdma_desc_update_enabled() block.

>               s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
>               xlnx_dpdma_update_irq(s);
>               s->operation_finished[channel] = true;


