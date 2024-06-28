Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F4BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNG0j-0000Jp-Bl; Fri, 28 Jun 2024 14:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNG0f-0000J6-Gu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:07:45 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNG0e-0004Xx-1B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:07:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-725a7b0fc55so647105a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719598062; x=1720202862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Nk10LBvRwVzClQUrIggh8lHC5OD3VbB1upClmsGveU=;
 b=b2E+hVLPl+hYJb7p90qcE+J8MQAmk1nZTHjx0Y313T7bJu7i3Cm9otn5bGRAuSB+xP
 0h63cPvIL6aHor/sxwUqM5i5JTPyPgrlir+V93alguKydZ1mhMCQHh+Zh6HNVbFbaYYd
 fYFWnbuY1p9iWJdD465XcByHz1ly9cuqiwrMAb0ZmF87OKKyN9dWkOtYLrRZxyHwyAop
 oc1XijPg2mEIhlZgA2nSOMXcX6KVO84+90pVf0yCbPwxx1SwEzlzvqt8LkgQuj1zQBCF
 R/bbOxaG75NlI8fXDqZU+IJPc/yeb2KEp+xMHgR+m87bZYfwezRNKvuTwH+StW+U4Khx
 7QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719598062; x=1720202862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Nk10LBvRwVzClQUrIggh8lHC5OD3VbB1upClmsGveU=;
 b=d1TbTibZO7KkZQoJM4KskFScZCcqiiI+UGJq+45gOORVGBvo3/gUuW175zbKyJ7SdF
 ArJbFnqu5GAySgEEuCqc6IcD1T2qDiJkqfESBCASJiXMHQMaodsJY0xFskhGZb5VTbC5
 puHvZfQlugatssMzHkBcheYgfHtlGbYjqYUMWnpKG/L3/iM4I9t9/5dDbexq2OvUCyws
 pSttuCm72kkV3l0VUSUSF1Ba7g45w3+gQvywzFaqZ6uvu+JHtDd+MIMwViWtZarbgWbn
 Chpeo/spe0KTipkrbhZQt0Wm+IzO7UXRNlRxvCqianUhHZDxRI+fQkcwNs7VimKDQm5d
 YpPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxB794TS3ctGW1N4rTNrS7WnUTeJFDu0pV5Yc9OEoySK+0nQAeXa74UliB56iqG8RJ78jUezuN72Gzxes3O6Of1Q11u5U=
X-Gm-Message-State: AOJu0Yy0dyAN1jdaI8Z8GawYiY2jxMvjOHxRyZvCUb+HtH5QRjY6Qke7
 cXIjDVOx5i5WwDDuiJPuZiWCKvZLQASWeukclSnTLev4HAPvtppLVcyeX1KJVIOckixWVIjxKjg
 r
X-Google-Smtp-Source: AGHT+IFUIJQAlc0v25gWdaNOYyWUQ95hrb23HLgqwXMWpFL90pDELSo00ccC8RncRUvUqnDIov/jbw==
X-Received: by 2002:a05:6a20:728c:b0:1be:cdce:9fb7 with SMTP id
 adf61e73a8af0-1becdcea170mr8206893637.19.1719598062314; 
 Fri, 28 Jun 2024 11:07:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce7414esm1941950a91.34.2024.06.28.11.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 11:07:41 -0700 (PDT)
Message-ID: <3e93d04f-74af-46ea-a05f-7841f0b4a3b6@linaro.org>
Date: Fri, 28 Jun 2024 11:07:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] tracepoints: move physmem trace points
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628124258.832466-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/28/24 05:42, Alex Bennée wrote:
> @@ -1885,7 +1885,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       } else { /* list is empty */
>           QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
>       }
> -    ram_list.mru_block = NULL;
> +    qatomic_rcu_set(&ram_list.mru_block, NULL);
>   
>       /* Write list before version */
>       smp_wmb();

This is unrelated to tracepoints.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

