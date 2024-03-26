Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E40C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3a0-00035X-2z; Tue, 26 Mar 2024 05:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3Zi-0002tT-AK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:58:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3Zg-0007Qw-Ot
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:58:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41490cc034aso113395e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711447111; x=1712051911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TObrvq0LWaiGaNz+1mx0BPv+uL9zRekplec+sU6N03I=;
 b=d+vqBpdsUqG2DBgQ8/8VsmsYYrtbd5fddlnAoWSngnbaq3FQRLNa8O+m0JuzEM9lqd
 YCgStqNXg9rLZAANCq29nQlDdMUcuxrKu50MIhhbTcSgHxGsk85A8DaA4Cyt1I3yaOC0
 HBCnw30+8djcuALgoPohH0X4N3NEq4Efzouy+1p3chg3sMaD9IT5YN14gDMMoXJXNNZP
 aGeW+YJfT77ULQal0UlhzfR6c3H5d6+gMG5RiLlGpbC8k/510VkuBGXQiF62EKRTT7Z7
 14M7pWPJOMRtckg80kBofgRrX4bSsi98i8Qc5h9gb/+JCtO9Dl5viAksuuChKuTJP0/V
 LNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447111; x=1712051911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TObrvq0LWaiGaNz+1mx0BPv+uL9zRekplec+sU6N03I=;
 b=XiYqL7z69sw8mVllEk8aVqvAIHwtjHvAk+RAUgu/kLWgiFFr0YGX3hbX3FPhhLpPMK
 X3w5prF9yp3OCH4r2i9acPyNFpRmOd7OFk2o+jiyH/V6bK33snsxEuitpE/KsVr4Xcow
 PmjXBICZwjYoYeO1BM959jWRPCpkni7JGjEJraYJTzV2C0Ax7NPuNcVFnigDfz81P3Df
 AtnzCrmX4hgCEv2r8fwG1Gux620yDIGorDUsMhmTVGE3apQQoyr+hg59B03gTBYqH5pg
 u8j+SkyTXUfwfsrz8cW2pT0iUc8SQe1II95+Fk0NoilbnI+eR+BPtIR4ibNSXUJOqu0l
 Qh3w==
X-Gm-Message-State: AOJu0YwRnBZAaI4Yxu/vRYlgTtQMT/MturW6fpg8Pa9QZDuailJjYh73
 MkepXPgz1JveraoT63zftujkKXaHXtJCY9xLovPOl88y+q7BSTWagEXU43ML/NaHyaepPuRAQ12
 J
X-Google-Smtp-Source: AGHT+IEIx/8bxfpgT6/TQf+zBfPRGPTuIY5TzSU4aBMESnwIuj1I03Oz/+nqaQiZ6wCR22CRNVxBow==
X-Received: by 2002:a05:600c:45c9:b0:414:669b:aa9 with SMTP id
 s9-20020a05600c45c900b00414669b0aa9mr484149wmo.28.1711447111130; 
 Tue, 26 Mar 2024 02:58:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.02.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 02:58:30 -0700 (PDT)
Message-ID: <df95144b-3873-4e13-a8b3-7134e0bc2170@linaro.org>
Date: Tue, 26 Mar 2024 10:58:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor/hmp-cmds-target.c: append a space in error
 message in gpa2hva()
Content-Language: en-US
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, dave@treblig.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
References: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319021610.2423844-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/3/24 03:16, Shiyang Ruan via wrote:
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> In qemu monitor mode, when we use gpa2hva command to print the host
> virtual address corresponding to a guest physical address, if the gpa is
> not in RAM, the error message is below:
> 
> (qemu) gpa2hva 0x750000000
> Memory at address 0x750000000is not RAM
> 
> a space is missed between '0x750000000' and 'is'.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   monitor/hmp-cmds-target.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.

