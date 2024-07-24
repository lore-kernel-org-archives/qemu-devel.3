Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F22C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWaGn-0001L8-Ky; Wed, 24 Jul 2024 07:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWaGh-0001Jw-N8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:34:51 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWaGb-00016R-54
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:34:49 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso1356373a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721820881; x=1722425681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73xhR2zmyFywSe4zYyzIJqoQc1mHipQJjOmOtzW8Mjs=;
 b=Qek7PN/ReI+dC1ZlFLYSNyGZb0LrUES05aBYvATX+WAj4DbPLpd6gHwJm1QtHddnQg
 P/xQG/iuTuiBwIZYrVfz2Cxq+qjjuqrGkCb45h7sP/LQbnlumrwIJmSIfRtUFcfsCWPT
 hSByExCYm04d+FMnmjYg1msoeNb4W4EpEMLjjP4krppXTEo+HPSYW06fGzXnEvelPvjh
 VkmQlBuhFirqnLE2+Vfeh3gq/ESCvEVEUPp9mpjBpe4XSuKo80Sdyc5mOoP/+xXQHaB8
 FZQouXrQUY/S3Bg7W7rkzZClEhI0DEwVB2tpk51wTHSf/8lDhIHIgxoGHQiXDyH3orhn
 yvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721820881; x=1722425681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73xhR2zmyFywSe4zYyzIJqoQc1mHipQJjOmOtzW8Mjs=;
 b=tWDwgu/jQlLTrG1X/3+q02jLIt7sbtkLN1prL8MR81VzMMGTy2DRRv1SoV+PrHyVFV
 9Ar/ZExpPL3SXN8Cxh0yNOFV332lPEsiG44WppILBGI9BL1f/ed5IN7t0tm1c98PVvuq
 SlkTn9jq7HM/YLSz4hBjqr8txq93FArBUY5Lm3JSKMoLRwV1JjbySXVa4ndS06I/dZIO
 m6wrC7uN7PFnhxEYGAD9z3cl/njq2jpTpLd7jVc4MBxWSVhfoe0fi+pH/O3O0gsg/tmE
 li7SHPSZw91XtQ1wltX26f5GwS44cZlLoAC2kQ/ctm22s/5ZygeINjhWzICacdJHfwtZ
 2b3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvn6GFWtWrRxXdR85/6TshhoXcsIa6SkB8CwsLc+KWC8dULPadOSX4YBPI4yoM2y41oqBY/SR9cfLW65rSpDVaKKGK4Do=
X-Gm-Message-State: AOJu0Yypk/RGkkV0O7C/e3+BsA6D6RFEkL5cYUtfJxdmON43GZ84YQIv
 URFYWch14DYa+g+SsdcnNH+AreXTV7m8fkDxES0u4RT/cqC0F9H5T9Tab0U7dsKDEtuSCvUR4l3
 KsFSPYw==
X-Google-Smtp-Source: AGHT+IEY/GxZOK/8kxDMllycaJ10aIaGqEgCuunNALAq3Eog4F689x2uWRN/Bg44h+l4KnT5969bIw==
X-Received: by 2002:a17:90a:be17:b0:2c9:7cf3:4aea with SMTP id
 98e67ed59e1d1-2cdb514397emr2156810a91.17.1721820881219; 
 Wed, 24 Jul 2024 04:34:41 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb738fd65sm1413158a91.7.2024.07.24.04.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 04:34:40 -0700 (PDT)
Message-ID: <f72e40c0-9217-47d2-8404-81eb1051bd8c@linaro.org>
Date: Wed, 24 Jul 2024 21:34:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] LoongArch fix for 9.1
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240724083956.1519277-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240724083956.1519277-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 7/24/24 18:39, Song Gao wrote:
> The following changes since commit 6410f877f5ed535acd01bbfaa4baec379e44d0ef:
> 
>    Merge tag 'hw-misc-20240723' ofhttps://github.com/philmd/qemu into staging (2024-07-24 15:39:43 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240724
> 
> for you to fetch changes up to a18ffbcf8b9fabfc6c850ebb1d3e40a21b885c67:
> 
>    target/loongarch: Fix helper_lddir() a CID INTEGER_OVERFLOW issue (2024-07-24 16:52:18 +0800)
> 
> ----------------------------------------------------------------
> Fix for 9.1

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

