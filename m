Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB6C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhTH-0005Lv-KU; Fri, 21 Jun 2024 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhTF-0005Lc-Lv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:50:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhTE-00012k-5M
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:50:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70599522368so1728825b3a.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718988638; x=1719593438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DSRTH1bYQawr4QumifZ+B9apLsEEgQPG8h0hDbsXYmc=;
 b=TchMzZmBCv6C8dha96DGva0F9WPnErZhWkbdv+4eL4cuWPeZ2sycoy5jk8Kv2vhBVj
 GxINSpSx0sF/XjGiHqLF6cZnPjiWWHVAJx+rROqxfMyDk8Oao47f3UCqKEsI2GIXImYZ
 XSfItf5hJSPf53qIKMNhUSIhoqVJkIuRMs2gVDUOgtL83CVgRm+Pfhe3tVEriUUbp86Q
 ZWj8kM0NieUryINUS/mycFl/MgWOx8Vj+m3G8b0nNvDtTKG+bNJoJ5u++O44zEXzMxC/
 qR8boUuwmkp0wkl0sLH8EcI0z/L57GZcbMrZaY6JscBWWji5Vh6SriiSeD2rQm1HMWhy
 EYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718988638; x=1719593438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSRTH1bYQawr4QumifZ+B9apLsEEgQPG8h0hDbsXYmc=;
 b=gMPs0zPiYk9f3diUJlY9r/Hh74nFvgPjGMFsS3mMocrfaBINHQKTh1N8ZDqGsVG8xs
 ZuGIya294kQeMy+vAPCOXiqWB/OvllRfU51nahqwj9xpLfRYRuClzrxWd1jboMV7emV3
 n6bBItdJSqf1mWRVo4k51No5pZ25xDSd8Fhgvjd5Ied3qh3io1eju7SJBTNqCj5FetYJ
 AeC49hr8195JHkFu0lJdTi+Cdsra5PT5vDJusFmExZckbyIMX+5eFsXyHEXdZG3FBDrz
 4EahM8ZjwJIcTEm7fvYgvzJy0zzxuHQln/9/FBDfRb8U3nDsTc+GwtAvSme1q4b8q4Hk
 S1Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXvzrCfz5eUY2TUVwsZjjyl90jri+tVVm87fVP1uqyAxrH3TGgzexZ94xiztIMhxEfCKhvBontllQmReodgG+uXHVClN0=
X-Gm-Message-State: AOJu0YyxFUO3x6IKp59Qzd6CvfIUejp+NXA00J+1HrNEjPuq6V3+T3zc
 rnlRaduDFbdcD7Jdyl2A78MYe9y8CXqozuLk19/AjertRunvhj21+xedC7Lcr3B7xCbRsn1u/4M
 h
X-Google-Smtp-Source: AGHT+IE3xlOrXo8w/1EHp1gvPNvWNQUQ8rPU/iEwtEqCNZR0U9XZ23u8rrh12XMaDbtTtB5oDKDqYw==
X-Received: by 2002:a62:aa15:0:b0:705:9d7b:2b3f with SMTP id
 d2e1a72fcca58-70629ccff30mr7882434b3a.21.1718988638510; 
 Fri, 21 Jun 2024 09:50:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706512fed18sm1611862b3a.181.2024.06.21.09.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 09:50:38 -0700 (PDT)
Message-ID: <c070f2e0-cd36-485e-aeea-9133018cba77@linaro.org>
Date: Fri, 21 Jun 2024 09:50:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240621143903.3598230-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/21/24 07:39, Gustavo Romero wrote:
> Gustavo Romero (2):
>    target/arm: Move initialization of debug ID registers
>    target/arm: Enable FEAT_Debugv8p8 for -cpu max

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

