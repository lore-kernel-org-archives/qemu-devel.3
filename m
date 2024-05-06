Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FFEC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tvk-0000eg-7C; Mon, 06 May 2024 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3tvV-0000bL-Q9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:42:25 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3tvU-0001OW-3U
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:42:25 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52006fbae67so2167148e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714984941; x=1715589741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/y3A+Whe4/vlM9oBR9QL5Dz3x3dqJLja5EldNh1/co=;
 b=OF5y6Pr710kk7V8U1o1W2fPoQeYlwbSOJdBfYykCA+qtts0fhmXW7qnVV9pABNLhjW
 gnUrELtvGxM6jUpBxitoacTeeKsQEkqKVmfnyUq4eBf7jasSWiUGLJorr8Meak3tS1rK
 2sAImsYbqomWmvX6bnSSzHL30wuVW/i54E50VGYRfW7tfU6Bw67H+o9KYuCP/PY5br0u
 9gcyIQbu+zXofy8lD8xzbcj+47N+aIKZZ4kC8z3BrZpEmvdrGKJQbIlIAfS57HqGxHyK
 kuCVAjkSeRLI2O+yrM4ZdTmjBfewVLFpDFiBWOpVEgtlEa/Ugvai61WQ642Ews+lgI2G
 Ow2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714984941; x=1715589741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/y3A+Whe4/vlM9oBR9QL5Dz3x3dqJLja5EldNh1/co=;
 b=k4fMWLgMdl1ZGr9cESwhKNWYUuaFkOaSI4yvEli16dgHdmZYFHvh0WhgSuYO3L0Yul
 parb53xzJ3xCbcOlC31tEq83TckfbS9pjsPtuYjvw0FRlH6CJ4vqQzC+x95vtI2Lenl1
 qzUoEmpY9RbMGjkLOEWFnvbNXviuXepUAXDabBMS25FQUjt54fypLQ02+Nwll2X12cWR
 xtlGVvDtJ72ONGU+Eyq1RG8z5QMSh7XlBwfNRZuYQoDfIEBL+MqRFHp1FtjAZxqcxzVv
 Yap5HBHPtjkjI/KiEdPEomcA+HsbYzioAxf0wWE7GCcdpy6YyKsaAR71/PMAJKCWASPf
 l4uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU8oP9QfnO2ghQQ0zpD+Lpc2e/65C1TXE6YY1HX9DwS4vHz11ITDcQT6c+XYg88AuK2Qwk8GtvVjAR4FWaCD6gRdhfi1o=
X-Gm-Message-State: AOJu0YxKEtTizuuHrHj3YGIWL6vKgyL+Ol9DRjaWyr+EsC6mg+VhEXwT
 2llOhBxImWoYA3lEVGoh3P58RLjwBEZkvRMZdTzVYFhdJ5P3O/RxAg0nUQYLraPb6hw7ak5UhlZ
 9
X-Google-Smtp-Source: AGHT+IFUhzBtoH9DUKIVz0WPt12kHeFCcCeyIg7mVxPGq1OpGcnMuVt5NqYLgHV69PNO0717Or456g==
X-Received: by 2002:ac2:43bc:0:b0:51b:e46c:19fd with SMTP id
 t28-20020ac243bc000000b0051be46c19fdmr5644963lfl.18.1714984941498; 
 Mon, 06 May 2024 01:42:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 c16-20020adffb10000000b0034f0633e322sm3037266wrr.38.2024.05.06.01.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 01:42:20 -0700 (PDT)
Message-ID: <9ddae62b-68e4-47dd-8fec-a5ec6a01c6f3@linaro.org>
Date: Mon, 6 May 2024 10:42:19 +0200
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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
> 
>   MAINTAINERS | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


