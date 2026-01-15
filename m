Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9417D46627
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVrz-0002Va-69; Thu, 15 Jan 2026 17:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgVrw-0002Lt-Ou
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:31:08 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgVru-0004W4-Gg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:31:08 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c1e4a9033abso785668a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768516264; x=1769121064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfvfwry9tZugcQPuyphcnZ3K55lLPW9RawgBzHIR90M=;
 b=ChcwoOUXAPLMknnNviRdkjm8p2XZ+oH4ETC+/JC5knsOBNG1jX6ntfOVT7XYVdLScb
 Ns3vFI9XqokuC8UYHcBkDcM5NieepV3Ogl10/EZdgT96LZO4FLxBAWgKD8/Qp5zJ11ps
 GDyN8YS7PS5pIXfVxLiiGQfTs1MSdukbRjrZ8Inm9O2FTCbafL+Si3BXAU5LZDmXgrIX
 kATLMKTF1G8uP409zImLSgKx79ctWH6ccKxCtfr4FC9OyPUsqTCI4RIu/oF5L6OjtYsK
 LVWJmlMmad5PyVDbADHvVc/5xIAT/F0l3+RcPvsOsABZgITOlkA4sTN0ukkQtFzJ9djc
 eFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516264; x=1769121064;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfvfwry9tZugcQPuyphcnZ3K55lLPW9RawgBzHIR90M=;
 b=X2bztnCt5pwXJX4lQ/Nws7l0yzC7q8Jm51whKaNehVDCTsamCSkh6KF5rltLzyzLPC
 12vXpDTHVhWYicu3iBKtCmJrDOD72bnjHPCSt/q6qPo5lMUabVonerGf4/o1zM7dP202
 SlJt21QaMfzwx892y4ykWqfiq+uYfSEhGk2hP2O/4PiU6WfFhwodNSu4UvYZYysBn4Wb
 9HPu17RZxBoQsGpmafbqcQPWvbd4zswyha0HHvnqeM6qIplRGFZu8YPYEtltUfzro9lN
 if3p+P9j1htSWckCrgtJoUDZn/mGVIskEFP8WnCdymC+SctLsMkvoc0vFGMVOqDSQB7L
 /v4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU+wrbCvOUJ/MIAwmAYKVnZ1XgomibvOmpqKW2a6WbqAfzR+XrXSMDrMNr4Z23DDNirpL+RStsPTx4@nongnu.org
X-Gm-Message-State: AOJu0YwgQ1iik68A5Daad0xXVOCwvMRbEx18ZwPzqir8opotiKLDumPr
 LIzxvJO1NRBmhB7ZctunIL9LHVPlN1qUc7pQ4JHfSoKZUT+kFYt7vntJNjUrWZE1MJo=
X-Gm-Gg: AY/fxX5dQNraSOPHKubLA/00c4F3Jjh2/CJLUtzpvLA1gnriJGdgWvHHGBwwFZoXoxw
 iLwvJyeyI1faAqhsZg3usu4ZqA+DVofbxe3h5Wwh9h76CYxH/XQ7qUutRCSm2Vv+fm+loXuEWvC
 6iwyUPJNEq48i1Rp+C6Ae0AnFsO1vQ7TSS33bEnf8X8D6XZB5EgiU9w5MSvkyB6F0LyVDud0HZL
 v0x0ZmpiKD5HKts7vFgP55S8oeFO+rOld3ryOLmJf+cw1tOHCiVoiPL9uVhMF9tWFvHdcauWOQU
 L2IK4TVuBFrZpRm09GRG/HiXAi3V5EZhobpTUAdQh3I0jOv0Qm5PeYUCtMLVTQx5oRsgxS5NH9d
 4XIiyQcO4Kdsz1gxzgq3NHTNcBq2DoVKZKqAIk01e0Una5qDpOSp8Ux4ld86yZ5FnrtFQ/TWFi9
 fjgwQCN7Crm1kOyV3+21V/vtMHS0egyQ==
X-Received: by 2002:a05:6a20:748f:b0:366:14b0:1a42 with SMTP id
 adf61e73a8af0-38dfe9011b0mr1051044637.80.1768516263491; 
 Thu, 15 Jan 2026 14:31:03 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190c9f0dsm2773225ad.31.2026.01.15.14.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 14:31:03 -0800 (PST)
Message-ID: <be82b155-a61e-43f9-ba16-ae2c6d227087@linaro.org>
Date: Fri, 16 Jan 2026 09:30:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/3] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
References: <cover.1768452598.git.jeuk20.kim@samsung.com>
 <a508208eda9711c8779ce4fbab28c98999e628d6.1768452598.git.jeuk20.kim@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <a508208eda9711c8779ce4fbab28c98999e628d6.1768452598.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/15/26 15:53, Jeuk Kim wrote:
> The UFS spec defines the PRDT data byte count as an 18-bit field. This
> commit masks the value to the lower 18 bits to prevent incorrect
> transfer lengths and ensure compliance.
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   hw/ufs/ufs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index cab42ae7b6..4ee6755d82 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -224,7 +224,8 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
>   
>       for (uint16_t i = 0; i < prdt_len; ++i) {
>           hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
> -        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
> +        uint32_t data_byte_count =
> +            le32_to_cpu(prd_entries[i].size & 0x3ffff) + 1;
>           qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
>           req->data_len += data_byte_count;
>       }

This fails on a big-endian host:

https://gitlab.com/qemu-project/qemu/-/jobs/12725280508

You need to move the mask outside of the le32_to_cpu.


r~

