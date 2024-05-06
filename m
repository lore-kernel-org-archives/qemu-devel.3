Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6AC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 14:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3yzs-0000hE-RM; Mon, 06 May 2024 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3yzq-0000fq-KB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:07:14 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3yzj-0003Ne-45
 for qemu-devel@nongnu.org; Mon, 06 May 2024 10:07:14 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso25299291fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715004425; x=1715609225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ys3nXqHYRv3BJVb6DxHAxB8fKiZMOgfbiFOG3Qz/k7M=;
 b=GuJ+hBtc3vzhMGtsaOZoV8tl5wI5srMjCf8EGBPvAlUH/pg1is3B520gav2rm2wmDA
 fxSXU9+Own2DWfIA3Ns8jhOnlWLgJoF/PFadgtZbLlsOiTeoX7PFRTqZsmprPUKYuaK6
 EnSKk6sM9eb5BTt2CcTLnjkMIMcy/a7U94FPsomb5Xrc2Hbba30cNQu4ClmOS3eaRhHf
 hH6lYv5hY3bgn0OR4TQAuPcncjxmkxB7qrnL70rSKe+XAiwNc/Ta1/JIIgtzCn9kSxrX
 jUme3w0Toj5Fmx3NSwgmcPBTZSjL1iW+ayob4xjgY4Mhau+jAQVZ3LG25VCLWrl3csOD
 aYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715004425; x=1715609225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ys3nXqHYRv3BJVb6DxHAxB8fKiZMOgfbiFOG3Qz/k7M=;
 b=FukY5BBTUyFeC4OWLnsXLe8A47IMfhxapdvY31CejwtZK7mDrw6/CqJ5itLGTUjQ5l
 6nDtNP64vb/WqmG75x6J8LyAyTWaTl7BZLVyFQvFYHY+U3GhgqRIn8Ld0H89b6pZa2zk
 Wnjol6399k/kASV8sBgu8aIngPjUr8WfI5HCK1bC2R+ues9oJCPJxM7UfOy7buLwd+tA
 9t5gCu3Odx0Y+cZBrpwtAM94164GuVjGggWly2VWwa6nurV4TSBt5L8C8DTU4YwthA4a
 ozUZxeOBSAjlWlCMJ5YJ7zNC8HBhXi2R0mmNz2+3Zw5LCpiL7pwdih3hZxnORj/I/J9n
 nNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2+IJGLar6miBE6i/92AmkHg9PeCqDxgZvFMm/2OQviU1Cu0xYJyJEIykGPLfYde0bEY/Gi+c2467Jvi6stEBBGgF3Ez0=
X-Gm-Message-State: AOJu0YxF+Ovg70z6dIe/WVhGbvPg7+PVfKBLa75ppYU7VziXpU/LkOqK
 qHSQfnHTLmmhLoKr+fXMGoRBkEfzbiTRNfs7KdsTOw9ciesaCluh9I8/h1ygbC+kfgcwaoI+8M2
 G
X-Google-Smtp-Source: AGHT+IGceLeYci/usnQ0gyQEOeEUqkuVTq8+pUeR85picBG1vRykWUSiAJaw9RdVCXJ407I5lHr+Kg==
X-Received: by 2002:a2e:9a90:0:b0:2de:bae:b306 with SMTP id
 p16-20020a2e9a90000000b002de0baeb306mr7551409lji.8.1715004425291; 
 Mon, 06 May 2024 07:07:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c469400b0041bc41287cesm16252017wmo.16.2024.05.06.07.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 07:07:03 -0700 (PDT)
Message-ID: <0b2b8ac1-475e-4bbb-b4d2-7a65da563ba2@linaro.org>
Date: Mon, 6 May 2024 16:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update my email address
To: Bin Meng <bmeng.cn@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bin.meng.cn@windriver.com>
References: <20240505072312.2776074-1-bmeng.cn@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505072312.2776074-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 5/5/24 09:23, Bin Meng wrote:
> From: Bin Meng <bin.meng.cn@windriver.com>
> 
> The old Wind River email address (bin.meng@windriver.com) is no longer
> available due to an internal infrastructure change within the company.
> While a new email address (bin.meng.cn@windriver.com) has been assigned
> to me, I am unable to find a way to send this patch directly from the
> new address. Presumably, the basic authentication with client submission
> (SMTP AUTH) [1] has been disabled by the company's IT.
> 
> Switch to use my personal email address instead.
> 
> Signed-off-by: Bin Meng <bin.meng.cn@windriver.com>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> [1] https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365
> 
> ---
> 
> Changes in v2:
> - Provide more background info for the email address change

Queued, thanks.


