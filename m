Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D292C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3bI-0004jU-LI; Tue, 26 Mar 2024 06:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3bG-0004j6-SP
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:00:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3bF-0007cl-9X
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:00:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41490105322so1454815e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711447208; x=1712052008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jy2xsc/KnnaWbnF4Twr3JERI4F8wZYZxbLbl32VIv+k=;
 b=q4sDJMmAxbD+2Emjgu7ihWV6Xrx6JNpk995DpIwZhFYQ8G9xt7cd5GCqq5veMYF03K
 K7gTiabmzMSzVwdEReYgY0jsZCOUo8Ro5USTo+SpRwPMl8juJkdn/ku77mMXgjWX8D9i
 M7kE7uCfNAfk6eCztI13b7CmVyUXTAERtRzV59trAq6LDygTmP/H01vkHqMzi3rl3XC+
 7gBgFFa4qevq2Zjp07Fh+sz4rz2DDFDK4Gb2luXx70QG3PH8Jk1lo4cHdM3qFbX6eBAA
 VXj2RusnaJYMCdrkr9z8IGZrK3WKR0Or0EYpWaSGvAfcLOi7QoCRfmGCRO0naHVAjira
 6ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447208; x=1712052008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy2xsc/KnnaWbnF4Twr3JERI4F8wZYZxbLbl32VIv+k=;
 b=gR3endkD+afgci+61VI9cgGFTl5n/AR0+00SZ3fV672xEy4bnKwz+OIPek0im5OWiL
 3QtWheEQf60gG5bTZwAjpyaVbCDdLv5DgQnd4hbMuxPRZZU+Qx/3nsAzLJXoZMuFcETM
 3qs5kYe4IRd0dbb7vxcRJanOByQXB7twVIe83zs3x5N3Cag3Y8qK2u0+D/bJPrBMmz76
 meGSXEDzPGjHuYYflY04v1+M+ypH3BlQfhFdyf4fsBuBEslJkZjL55FlG3h9SGHxBhTT
 qkdxINXLNMulL2gnz2TrrxUYHYqCqw5rQbZ5ULlUY1eCalejd8XoUGELp8Iex5mxCZOL
 AQJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWem7IcG073Jmn7l8F8dmywIaPeI7L6EY8dbaknszY8euslZixGyXRdWJm27noaSlIrnxZVGcRU9HMgdW7iIfy1MokXY48=
X-Gm-Message-State: AOJu0YxSWDhhMD6h2pdgfAcsTEqmyc1o5ySOiKR5QTY4vEsabOPqsv9q
 rNuei+IuZAERX0NMlsNrkcepfuBVdxe1Wo0oeSfPgSCJNZ4V6TDDkbrEjf/zyeaXER+4Fk8w0ag
 x
X-Google-Smtp-Source: AGHT+IGKSTQwV1bYsAgHzHYU+j2r6gCOaNVOUDlDuHW8FpE1EzSk7l4ekwaSXsqJE39ddP3B9BfOWw==
X-Received: by 2002:a05:600c:1d08:b0:413:3941:d9ae with SMTP id
 l8-20020a05600c1d0800b004133941d9aemr6110313wms.31.1711447207812; 
 Tue, 26 Mar 2024 03:00:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.03.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:00:07 -0700 (PDT)
Message-ID: <af80eada-3606-4400-807c-439754df98d1@linaro.org>
Date: Tue, 26 Mar 2024 11:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi-generic: fix io_timeout property not applying
Content-Language: en-US
To: Lorenz Brun <lorenz@brun.one>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240315145831.2531695-1-lorenz@brun.one>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240315145831.2531695-1-lorenz@brun.one>
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

On 15/3/24 15:58, Lorenz Brun wrote:
> The io_timeout property, introduced in c9b6609 (part of 6.0) is
> silently overwritten by the hardcoded default value of 30 seconds
> (DEFAULT_IO_TIMEOUT) in scsi_generic_realize because that function is
> being called after the properties have already been applied.
> 
> The property definition already has a default value which is applied
> correctly when no value is explicitly set, so we can just remove the
> code which overrides the io_timeout completely.
> 
> This has been tested by stracing SG_IO operations with the io_timeout
> property set and unset and now sets the timeout field in the ioctl
> request to the proper value.
> 
> Fixes: c9b6609b69facad ("scsi: make io_timeout configurable")
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>   hw/scsi/scsi-generic.c | 1 -
>   1 file changed, 1 deletion(-)

Thanks, patch queued.


