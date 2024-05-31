Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A1C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1lC-0002d2-VW; Fri, 31 May 2024 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD1lC-0002ch-7E
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:53:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD1lA-00047c-M3
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:53:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4210aa0154eso13797225e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717160007; x=1717764807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slyQoeeu/NcOcLaDoNWXMh1mRNOsbepgAIyvLPD6q8k=;
 b=iflpj/Ksjt81iy7x5KsRYrRfqstQu9kRiS/emdo6Teazmtl5CQLZ2aMved6qVPAb/O
 Gx8yy5Ng5nVjPP98VzcWrxBI+IagT+3yDjrAtmq0J17FdpdFfphWs7BjvWPIWGZXKB+T
 JY322GLxHNUuJT+Izt7W4Ybxhk6IPRxjKMFGbEkfyiR9WqMHvzvgEOyc+0+jFPxZgLvy
 VIqS39T6GLFa38awJ/x+Xi5TH0xuFX5sb0nFNexaVQjp/gVfa8dMq0lwWArJOxG8defR
 kwM5N/oz2GFw0lkWd63Y454i0e1pnMxTmCuz44aJ3DLLeVE6Re6BA9xM0ha6fcits9Jg
 PVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717160007; x=1717764807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slyQoeeu/NcOcLaDoNWXMh1mRNOsbepgAIyvLPD6q8k=;
 b=YqM9xk4fcEY7ayo7CkfZW3PKmP7JzlZYxZj7HtB3gxEn2PmJ27YIPUSeJGkLe7bD8t
 /pL+MrffG3nq3Sou8P2D4nrNdCZPXdSTYpnxazAjiAwvfMfVpyiOx0w3I9kbG3mYNwJm
 Tog8CzmGDRplbTDAlo6CKH805sbigYAPLh3sG80swj5FvDkA53Zt+O2joWqh+OQyze05
 74vcBgZ9WKi0QS2tXVZPHDZkHoNxoW9MKe3NnmvnxsMIcWtdIowf4wZ2lnBHVMSiNw3+
 Dn/qK4ZET2SYhnvSa96frEuW39YmhsH9tehlYaLyIyNB0nRVLHRGceTwTGPPiaV1oMpC
 gviQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpdSULwGLW04JM4JO5suLQUFlrQ5k67RGtdXDIKSLcbMRQUmb+v5MJNlOZN2tcEF/IBWSF42xW++hYWlc8davH6TgV6mI=
X-Gm-Message-State: AOJu0Yy4Y+zjpyoRr5dpBIvHwtn+iQyb0FuGooGIiiYd7bQM6nh2quQd
 myTwsevEGm49RfAupM8C49mNKTMhq5EhtKMq1Bcc5YALSdHQSh0NkxGel7GopD0Twn1JSR/CRm1
 Xe9M=
X-Google-Smtp-Source: AGHT+IEepnj7s5GJNeuV7yk/aJQBy8eDZ/TS0xwtRdcx9beNeZCmnF0SaZnGIT/LXOkuy0ew6EyzBA==
X-Received: by 2002:a05:600c:4f82:b0:41a:908c:b841 with SMTP id
 5b1f17b1804b1-4212e0adcddmr14662375e9.32.1717160006899; 
 Fri, 31 May 2024 05:53:26 -0700 (PDT)
Received: from [192.168.183.175] (11.red-95-127-95.dynamicip.rima-tde.net.
 [95.127.95.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062edcdsm1822603f8f.70.2024.05.31.05.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 05:53:26 -0700 (PDT)
Message-ID: <307d9877-048d-4552-b85b-973b7d46e0de@linaro.org>
Date: Fri, 31 May 2024 14:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/xlnx_dpdma: Read descriptor into buffer, not into
 pointer-to-buffer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alexandra Diupina <adiupina@astralinux.ru>
References: <20240531124628.476938-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531124628.476938-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 14:46, Peter Maydell wrote:
> In fdf029762f501 we factored out the handling of reading and writing
> DMA descriptors from guest memory.  Unfortunately we accidentally
> made the descriptor-read read the descriptor into the address of the
> buffer rather than into the buffer, because we didn't notice we
> needed to update the arguments to the dma_memory_read() call. Before
> the refactoring, "&desc" is the address of a local struct DPDMADescriptor
> variable in xlnx_dpdma_start_operation(), which is the correct target
> for the guest-memory-read. But after the refactoring 'desc' is the
> "DPDMADescriptor *desc" argument to the new function, and so it is
> already an address.
> 
> This bug is an overrun of a stack variable, since a pointer is at
> most 8 bytes long and we try to read 64 bytes, as well as being
> incorrect behaviour.
> 
> Pass 'desc' rather than '&desc' as the dma_memory_read() argument
> to fix this.
> 
> (The same bug is not present in xlnx_dpdma_write_descriptor(),
> because there we are writing the descriptor from a local struct
> variable "DPDMADescriptor tmp_desc" and so passing &tmp_desc to
> dma_memory_write() is correct.)
> 
> Spotted by Coverity: CID 1546649
> 
> Fixes: fdf029762f50101 ("xlnx_dpdma: fix descriptor endianness bug")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/xlnx_dpdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


