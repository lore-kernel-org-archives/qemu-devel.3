Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0DEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb2EE-0001RV-Oi; Mon, 05 Aug 2024 14:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2EB-0001Gl-Aq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:14:40 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2E9-0007ij-Bs
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:14:38 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so165791051fa.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881674; x=1723486474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Php6NprLek7+CEHWlqv0zmkXISJU/sqd0GtCwEvo8qY=;
 b=zgeCLXROxfNxfpn73QEqhgvvog4cWDZMou2mGRoqCMF4RHgdYCeu+60OJX3+uyY08e
 x9wJmlSWnhYLmYhRCvr859xIVdfolclMvDIDHS/MT+6zSpAuUWZ+3kEaGyqUYtujgASF
 3c0jQStQNDBSGtp4Pm8owTLQg62uLeivVOQd9qYlEmd/+z4Uh7FAnQiTlVTv4AtXbNmZ
 fG375j5QRC422dRjDETD1T2o7czZu3FjvLCq4fg280OjHwGCciJ08ehftbBqy0gfXiMi
 z3E2I4TWZF7XIp/LEBvdE+MoMNCl1AMQdqPz3VLieh5WJN7zw24GBpN6TA9gRxeM4Y9U
 p7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881674; x=1723486474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Php6NprLek7+CEHWlqv0zmkXISJU/sqd0GtCwEvo8qY=;
 b=D4j7GIPhLY4bv2htu3SPgSpGJSMuMi/EDvIlhvhEOsEkghZmC795BA5yE7HaZ56WjO
 EUKesF1eDBCfG2vdlHMqsnK9uOkWrs03WRJ5Lv8RorBdAHNVCFlOCl5ofa4Bzi4gh0d8
 GA5gMXAbCnB0edQ6x459I4F5Mjvyoq5zKLZdzpEoFCah0gjh41M/IuUOhviqiu/5TIN/
 5KTx7ZBIKihKbgGQ0Iui196Z3J8aIHXZg31gAdPYq4kX+YaLiqqDbfoFfKIAw3QbHdZe
 mcmhPW6SDSEYBwCvXjgO5MnKy6LAq5PspxuF4rdtmwjw7g8TmO6yHocxk7wBai6/NwZ4
 HYIA==
X-Gm-Message-State: AOJu0YzP3vBbQOPe6SfF+0LNYJOdfABS+ICeohJw5xAG8X30vRbuKVxR
 UiCUbqzGB1SXDlN8j9NX0eIFAqBWZ1iTAhzw/98W++WApu87mME38kzXOKKA6pgpUhJQpNNEPQK
 G
X-Google-Smtp-Source: AGHT+IGF9DtokLOOoeK0slicqkMGLHwU3g09TiD3ZmoVtjWu70FyjI+2Is4jcMhfFOoAhDaiTyYScA==
X-Received: by 2002:a2e:9101:0:b0:2ee:7a71:6e3b with SMTP id
 38308e7fff4ca-2f15aac0bdamr80316741fa.27.1722881674132; 
 Mon, 05 Aug 2024 11:14:34 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ad475sm211390085e9.13.2024.08.05.11.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 11:14:33 -0700 (PDT)
Message-ID: <00b977df-88e8-44c9-9d52-1034d87fb5e9@linaro.org>
Date: Mon, 5 Aug 2024 20:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1? v2 0/4] hw/sd/sdhci: Check ADMA descriptors can
 be accessed
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>
References: <20240731212501.44385-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 31/7/24 23:24, Philippe Mathieu-Daudé wrote:
> Since v1:
> - split patch
> - do not return MemTxResult from get_adma_description()
> - single DMA read in SDHC_CTRL_ADMA2_64 case
> 
> Based-on: <20240730092138.32443-5-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (4):
>    hw/sd/sdhci: Reduce variables scope in sdhci_do_adma()
>    hw/sd/sdhci: Reduce variables scope in get_adma_description()
>    hw/sd/sdhci: Read ADMA2_64 descriptor with a single dma_memory_read()
>    hw/sd/sdhci: Check ADMA descriptors can be accessed
> 
>   hw/sd/sdhci.c | 117 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 70 insertions(+), 47 deletions(-)
> 

Ping?

