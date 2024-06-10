Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C84C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 11:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGdWN-0002Xy-M3; Mon, 10 Jun 2024 07:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGdWM-0002Xh-68
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:49:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGdWK-0006m3-Ho
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:49:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so5091955e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718020142; x=1718624942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pa9ymKnAR4hIiL0jEThC5anaSYKiL9fDSMa9S/KtC2Y=;
 b=FuWQhkaR4a0pl4luTnjtorADOEOZ9rc0eI2Qa/2BLyxfmkgHna5wdRqjtN9QIeaby0
 +fciIKEFEztgQ7QdNZW3FL36i66ZWv5DiyV78C2vxwL+v+B8xiNLjYvo4t1Q2NA7ZjTw
 aV0QjcQjN3u8xHWRupl+NInsvjRdlnE9Ywm4RN67whPReuqyZ2sav7zxwsb/83IlmzjM
 9wegkMFqeZ2loRN5focPMj48HtcOYS8/PLVcVZkP5eyGygaqi9Nef14t/FnUwursndjK
 6amhxYyxmcAZPEwKUbo1L1ZsErqFXysNYyMIHOd0ZJmeHSKd+YlhoBmcSXdJBmz1mIl+
 kzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718020142; x=1718624942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pa9ymKnAR4hIiL0jEThC5anaSYKiL9fDSMa9S/KtC2Y=;
 b=iOsURZOMybhBzzCXz0o98XcoifgL8GnbRWtFN5PtAmC/mIshI0xm1aE+kol2RihfSD
 uZQBZibpQ/l9c8O5xOs47RVjZMm1ln5RJidBpsMbOkYJ+/VM2sxb6MdpJL/M/+ca8w3c
 eFUdz9SU2FKkxBmpKXTmLlCizctoJQGSaB60AVeXHIMgVKcPDTHuQ4M0yK7S7VYixWu2
 v7a7gO/xUcswvlLlOK8Mt3a29Lnd10U1yo0fsXmHy7GSfU29mq7Id1OJwW5JIrtK8P7c
 aiWSWO9usLGEbWC8kTB3TYp3php7Rldnluler+3Lir6qm2EoHKXjeLGuVv/7UQpfvJXG
 00rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcPlCV1e6eXs+VBYlH7Zi12tmoHNLEP/jOERgeNAHIYtXr1+NABa9+wUQvzGzNLal52Bw7ok4AzWXKZJpHjh/kysisYEE=
X-Gm-Message-State: AOJu0YySmBtjLFz9wMTGcl1VAvLPlOG7bvoDrRu77/dEvRlGS/XZMGxy
 9Fge+RHQtdXtJLL+aCYPgOOSFqgi9j+B6ADzHnjVYJZ0fKeBaGmYn4IRvyiH5NU=
X-Google-Smtp-Source: AGHT+IFQNlPMrHdhbygP1NVRwAdtzAhj+xjVeVkCNIWpaJlVr/iRFrhDA8U8+C6og2DHKNlQtFy33A==
X-Received: by 2002:a05:600c:154a:b0:421:7e88:821 with SMTP id
 5b1f17b1804b1-4217e883770mr36064695e9.32.1718020141756; 
 Mon, 10 Jun 2024 04:49:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4216412972fsm120793155e9.47.2024.06.10.04.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 04:49:01 -0700 (PDT)
Message-ID: <3a919e08-fcce-48d5-b609-cc97cd3ff22b@linaro.org>
Date: Mon, 10 Jun 2024 13:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/dma: Add a trace log for a description loading
 failure
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20240604071540.18138-1-fea.wang@sifive.com>
 <20240604071540.18138-3-fea.wang@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604071540.18138-3-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Fea,

On 4/6/24 09:15, Fea.Wang wrote:
> Due to a description loading failure, adding a trace log makes observing
> the DMA behavior easy.
> 
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/dma/trace-events    | 3 +++
>   hw/dma/xilinx_axidma.c | 3 +++
>   2 files changed, 6 insertions(+)


> +# xilinx_axidma.c
> +xilinx_axidma_loading_desc_fail(uint32_t res) "error:%d"

Unsigned format is "%u".

Regards,

Phil.

