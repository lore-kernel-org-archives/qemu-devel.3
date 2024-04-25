Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB76C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00yI-0004Xq-Us; Thu, 25 Apr 2024 11:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s00y7-0004TE-7N
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:25:03 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s00y5-0006hb-9v
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:25:02 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6eb797e10ceso681591a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714058699; x=1714663499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=je4x5jiGT0B0ywcNHuMNctXjgVyiZbeVwC2Wv/LhaKE=;
 b=GhXRnwtc/2yb54cJVtMX0dgebWpeadMlO2l+SbgTTuEgAvs8Ue1mbSUANk/f6h5DrD
 lbsy0ZdIbO+gBYLyhv7V5ch4CnfkjvP6UZ+LSkjVZsvBgu2XLrlm2QkbpOhS0gPSZyP7
 LdFOU9+l8VNMf3PqtcoyAouuQ3PGJ7jIgpuh72jKetXSxYaKXu1Hfu6TstxwATHysfQo
 1WKMS7BPEy0p+1/l9w81d+UE9iMEme6Q16eKnG+mdSLrKDZeJuBwHdl07SA732WvNJxS
 nz7vLZfJosF3XxjFmfr+USy27HNJpicXWEUyd/gH3deKTJrERAoQ1jtAH4GLOeS7t2yf
 fIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714058699; x=1714663499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=je4x5jiGT0B0ywcNHuMNctXjgVyiZbeVwC2Wv/LhaKE=;
 b=IDynBU5N8X93pS5JEQiFouN/QbI+WTim3Xuh7Zc4DJaJigwZ3q7v9su30gI6iBupnq
 LNvH1p4/Oz+7MxieMcgHmj99TuTboCPMScDbanj2ig304VffgwPnfeDOXlOBC0IqzKAW
 TpGV1FiFmPpCRZYKBWC+y55bjkd7EOy4yylwxWAHg0wuJUvLu/mpXDRYTNRo/IqG+XGC
 FXcUancO8zyhqgI75YTztjwPUAcdQln9zmvNqefQfW0uBnOLZ6NoDFq/cJSzW1pPmUIn
 oBuTPKvimmQoNZoYmk2YeZPwAnNbXg7f5QFSDMg+TTJN+mEFkeisxpmqb5Z9NHC0j8iL
 UzFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAqsPagmjl6Gomwj/FBWBt9+TB2+A/WyUz3EqWJr3/2uiHVWPqhBxtKoZxGPEGMVdPYEf9r+JX8kEToeXo9PUEnFkr2ZQ=
X-Gm-Message-State: AOJu0YxJYm1x5dlgqtm124p5bQwEKyFalbY0wQHD58kXMkdR5El9Wvda
 jMrsEQI1srbega6Rat1XFdfpdiahTtHCMYTpj0AtechNtjrn6DW9LrMcfWPiKDs=
X-Google-Smtp-Source: AGHT+IH8N86xEqaBXHH8XQpf7+5QxUfSSio/86orhmNo4957RZHoopjswxORMvWT+ydV6UzywyeN4g==
X-Received: by 2002:a9d:4f06:0:b0:6ea:9ba:7fce with SMTP id
 d6-20020a9d4f06000000b006ea09ba7fcemr6796669otl.38.1714058699706; 
 Thu, 25 Apr 2024 08:24:59 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d?
 ([2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a056830114900b006eb94216797sm2694229otq.58.2024.04.25.08.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:24:59 -0700 (PDT)
Message-ID: <56479506-9e30-4003-9153-db6ef19ecea0@linaro.org>
Date: Thu, 25 Apr 2024 08:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fix endianness bug
To: Alexandra Diupina <adiupina@astralinux.ru>,
 Alistair Francis <alistair@alistair23.me>
Cc: "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20240425134115.32057-1-adiupina@astralinux.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240425134115.32057-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 4/25/24 06:41, Alexandra Diupina wrote:
> +static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
> +                                    uint64_t desc_addr, DPDMADescriptor *desc)
> +{
> +    if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> +                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED))
> +        return MEMTX_ERROR;
> +

Missing { } for docs/devel/style.rst.

> +static void xlnx_dpdma_write_descriptor(uint64_t desc_addr,
> +                                                DPDMADescriptor *desc)
> +{
> +    /* Convert from host endianness into LE.  */
> +    desc->control = cpu_to_le32(desc->control);
> +    desc->descriptor_id = cpu_to_le32(desc->descriptor_id);
> +    desc->xfer_size = cpu_to_le32(desc->xfer_size);
> +    desc->line_size_stride = cpu_to_le32(desc->line_size_stride);
> +    desc->timestamp_lsb = cpu_to_le32(desc->timestamp_lsb);
> +    desc->timestamp_msb = cpu_to_le32(desc->timestamp_msb);
> +    desc->address_extension = cpu_to_le32(desc->address_extension);
> +    desc->next_descriptor = cpu_to_le32(desc->next_descriptor);
> +    desc->source_address = cpu_to_le32(desc->source_address);
> +    desc->address_extension_23 = cpu_to_le32(desc->address_extension_23);
> +    desc->address_extension_45 = cpu_to_le32(desc->address_extension_45);
> +    desc->source_address2 = cpu_to_le32(desc->source_address2);
> +    desc->source_address3 = cpu_to_le32(desc->source_address3);
> +    desc->source_address4 = cpu_to_le32(desc->source_address4);
> +    desc->source_address5 = cpu_to_le32(desc->source_address5);
> +    desc->crc = cpu_to_le32(desc->crc);

This is incorrect, rewriting in place, because after the call,

>          if (xlnx_dpdma_desc_completion_interrupt(&desc)) {

the memory block is still live, and the swap here has corrupted it.

> +
> +    dma_memory_write(&address_space_memory, desc_addr, &desc,

This is incorrect because desc is now a pointer so &desc is DPDMADescriptor **.

Do not reply to an existing thread to post a new patch.


r~

