Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80315C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FFZ-0005US-Oh; Tue, 07 May 2024 03:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FFY-0005Tp-2V
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:28:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FFW-00012U-Ku
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:28:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34e7a35d5d4so2097685f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715066908; x=1715671708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TGu6Ic5PFGqV8m9E/WjRre3ndb6bZOL2WtYIGzgsws=;
 b=GKHL0x3P9X4S8Y+8W/gcDPrTONeb3NONRduDQTKPcEHJsTeJEwhnc1tCGzH1TfDSg4
 p70Qx3+2X8wGT7L5qmO5Irrd3g2kNMPhUzfhUOi5Bq228ywlEKw2pkL2XdCMfQclMVT9
 m8q2rV1GTL9cBjKB7V1IQs3E83VR+HfZcVtwlSN46YH9RBdDKMcdl4hiL4uUoOLvM7o9
 wgm+M6Kzz9xOLnmc15WI2MOmmUvM2r4IsAxn6OKpQjIbQUR4Dp59mhUfgCKQSswvBYw2
 E0c3LtPSf/mNMh03u20gM8htmG0FDPdiEHy/prkC1RiJZsqfcuCoslorvj2xRDwBsltk
 EPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066908; x=1715671708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TGu6Ic5PFGqV8m9E/WjRre3ndb6bZOL2WtYIGzgsws=;
 b=QV/JydV9l2n1X/GAdnSLxf4itZlQtLk2ATlwR6hS0eNyh/mQwLKZRVT+vmSXefbpAB
 /ndpaEyzkJw9xRAUmZZVOEJIiRrwz1xiUGHtk53IIk2CI6Js/2wavxT52nwUgCWEqN2h
 sKe2BMUAyBfV4o75aChvj/Cy/19Z6KMqB+pKwGtRCt+iF9nrBJcEvgzdH41i7e5H7KsF
 yAdJ/VkCTTWmSbSlW4FO9yef0OOpW6wA5syJAmwrbmsdXqGyNehV90G3EenpQ4SqCmZk
 GTcQ143vZcr7mDozZSzv+5QHAwpoHca2rDoXp17A/dFOXlvzQU1Ax8/qZXRt+pPTUC2R
 EPOg==
X-Gm-Message-State: AOJu0YzB+QOgmDg3gA9d2LWyPb0BhelLk0rwkjutC4+1AzZzgnnLFRQs
 J9fO8wgIjakaFnd/5hCIBQrMwy9Ias0mSAvqLQpfWLj2333QSSgVU3Tw5db1fDdqhvdubxjxWYl
 e
X-Google-Smtp-Source: AGHT+IHwN3bZGBcOn6lt4PnF8vbGexSpGluYWnDybWqnhAV/+Go4lNhg2Zj2wFtMLt8lVpRxrgCUBw==
X-Received: by 2002:adf:e504:0:b0:34c:77bd:2545 with SMTP id
 j4-20020adfe504000000b0034c77bd2545mr9088510wrm.70.1715066908382; 
 Tue, 07 May 2024 00:28:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a5d58e6000000b0034dd063e8dasm12241464wrd.86.2024.05.07.00.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:28:27 -0700 (PDT)
Message-ID: <2c3c2c3e-1b24-4f0d-9621-7687e9a07c07@linaro.org>
Date: Tue, 7 May 2024 09:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Fix memory leak
To: Song Gao <gaosong@loongson.cn>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 richard.henderson@linaro.org, zhaotianrui@loongson.cn
References: <20240507022239.3113987-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507022239.3113987-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 7/5/24 04:22, Song Gao wrote:
> The char pointer 'ramName' point to a block of memory,
> but never free it. Use 'g_autofree' to automatically free it.
> 
> Resolves: Coverity CID 1544773
> 
> Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



