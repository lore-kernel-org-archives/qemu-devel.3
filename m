Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E56D216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0isq-0005bS-B4; Tue, 15 Oct 2024 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0iso-0005a6-L9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:50:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0isk-0007FY-1s
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:50:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e221a7e7baso3642698a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003806; x=1729608606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rk+/FbCiHQ32J4q76H311+hrQgeaQw67dxOv7z9Wcek=;
 b=XzNijK+oOYZFzXRI0QP8/+qBIoPGkIogOcsQz94x9pJls4WhrakmKxQ8DMoBDI9eb4
 utbG8IUm7KZPiDdB5vUPNoDpXa3yVIU6XQIULFI1dRsBJv3/MaRTafT0vTvlMQrvilYg
 vsfRlHZrKNNkQpmLOp+wUnBzr9eQ11hl1dwqHfsLnWlTOjFXGDabAeY1ClNAspCqzWqj
 sCDhDhsQhIEvkHU4FSX0n/ryUuFdTAhlAzrjNqnl7brOhIUYMlmzOIoBGXo4jlA8HM1x
 qSk1aMvsUJQQxPtDRTfJuhxgixw0zWqONPgEYiak2oAKzHQY6AMpLSuiSYumASYoGstj
 5j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003806; x=1729608606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk+/FbCiHQ32J4q76H311+hrQgeaQw67dxOv7z9Wcek=;
 b=Zu/ueM75n9HfzbJKMiOCy+2IpQtKVgJuVyPZmes0BGbxBDlR91WgfuTelZi2bQAzwc
 f/ogwjgsb//NTxTe/2LaQXj7YDanUCVgGtQt0ZIVJv/3+XQNODL4jyjNMR0Jd2auMMuM
 EDYSA35ljCE3+XpMjCFOcD3cJ774zeyaCS7HfT7T9p8+3fLUap/uT9lXZtiHR6vQ5aW0
 mMDCXAXObIiRdn4y0HQDQnw7x0XY0YSl68ynu07s+uJ8OBFLEiKLpeYqUR8AsfTsL9bq
 TfPfnG2FLpwWeq34HH2lNSUPq/APUNqnPUbzvgSgiQJGZ7DtyTsMLS3m9euGLGLxxwhp
 J3Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6e1s0iBAp9mC6J2yacVHRVNa35NdDbtdL4ubrbUa+NxR2/mPgHkprX7iDgvhG6QwUFuEG12zF/SXm@nongnu.org
X-Gm-Message-State: AOJu0YxSomQ7mrNC6+kEMie84BSenLFjZKWtnh/upNZ44A8YrPiJmbXT
 mIb7lEc9fuVUNe8i+aSITUqx+pWHnJjdsH3zPpRtDI2FeKFPYI3O3H5i+WR4RbE=
X-Google-Smtp-Source: AGHT+IE3JOVsYp9RZ51cS+h+UjKMEpSJi9nmKqOedw3tz8PcdpuXaSa6oC4Y9A+CfUl8Lt1UBIcesg==
X-Received: by 2002:a17:90b:8d7:b0:2e2:eba1:a1a1 with SMTP id
 98e67ed59e1d1-2e3ab8e7b72mr510959a91.36.1729003806667; 
 Tue, 15 Oct 2024 07:50:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392ecdd37sm1867836a91.13.2024.10.15.07.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:50:06 -0700 (PDT)
Message-ID: <345e96a9-7111-4727-9510-63c3d6deffbc@linaro.org>
Date: Tue, 15 Oct 2024 07:50:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Clean up unused header
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial <qemu-trivial@nongnu.org>
References: <20241015140922.385470-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241015140922.385470-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 10/15/24 07:09, Gustavo Romero wrote:
> Clean up unused (already commented-out) header from syscall.c.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/syscall.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1354e75694..d1b0f7c5bb 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -54,7 +54,6 @@
>   #include <utime.h>
>   #include <sys/sysinfo.h>
>   #include <sys/signalfd.h>
> -//#include <sys/user.h>
>   #include <netinet/in.h>
>   #include <netinet/ip.h>
>   #include <netinet/tcp.h>


Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

