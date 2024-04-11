Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81592CD129E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9c-0001DX-DU; Thu, 11 Apr 2024 03:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9V-0001BS-2s
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9T-0000j3-BB
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so416375b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821637; x=1713426437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KADZkS5oopa6NkDnE+sktHUe+tp+ZQOlwRaigMpPErA=;
 b=nFNXn+wJ6XwQ7fT+xebqhtF9xVC9qy+4BWwqFZookAnaGGAeVyM/1FuFBqiJimdYzE
 SaFmFcBCT/bPfEIxkiLh+T4/34iI0oqrCGck1iGtW/FN2J31p6O6pnC6XOc13vLHrT2K
 8KfqKWTJSEp04FW+5rka30EEkAmOGXWT+wtApOECfzwDzfARYL1zsyPYLrUt4/t30bui
 tz3omOHsfXXrPzgsQ1M0gGHtjH9c+tncKKT0VzSUqBr+NSlbFkDxPf0M+vLHRpPUwdTm
 PZmgNnVnxX6fcOOBxme2meYaVK0w6doUOSBNz2P2uQI0jbWorY5XmFijM9TKcAdMHmLG
 6ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821637; x=1713426437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KADZkS5oopa6NkDnE+sktHUe+tp+ZQOlwRaigMpPErA=;
 b=BLPb5Ea0Q2NwdEkxERfg8Fcj0QYQ7fu5X+lunpRHnvrl/+AIFZn3W9OtY8BToacZ82
 7iWZb30olDL83l9mu27FW3pHXZPHLN6iPcKZ43EcIlKNvYStN91S9fBQRdzCqx9L8DTa
 Hwim0qc5whDyZXmCxTFAA6DNBbheES8UPyY9LQHtkRhSDJgqa8fRud5OG0tikkIZ0ZQB
 X1OYmnXzdFGn1ku2D0CxLrs16XllHVJi4Zjk+fcJgXb/GIrS2Ei7m76byXkegnB875iu
 p4N1VJmPLfl9U3ATNPXBu+i4FMZNxpZtsaMeigEchuVTIZGPcax9VnQNB9rr7Fr95Ory
 ZdUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUoeHcIm6XDxqxZyAduFfqmQZSqtxOw7a0781rkm+B/pFoJXlwYwKWi9orMt83rLGg7MgiocGML6omaW3a91sGdXw4O/M=
X-Gm-Message-State: AOJu0YwGXJwVl79JuA9p/xbl2q9UDbrs5GnLU8F22W4xzTwYdjGhnDx+
 APpipjHFAztEwh0TIuTp0e4hSNG9JZ8qkosmQ4nTOtR9L2ZzXNfYlBJ10if/zuZsDLhA2RUpP+9
 G
X-Google-Smtp-Source: AGHT+IGI8Ds5hM0LeMRiDh6pmQTV6tUs/XyliVxoxMotkMYLUJutO86s8wq2ZBn4JTA6ZCqJse11sg==
X-Received: by 2002:a05:6a20:7fa9:b0:1a3:a58a:5f77 with SMTP id
 d41-20020a056a207fa900b001a3a58a5f77mr2732826pzj.22.1712821636883; 
 Thu, 11 Apr 2024 00:47:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:16 -0700 (PDT)
Message-ID: <e67e00fd-8c39-4616-a94f-19ebd480b9aa@linaro.org>
Date: Wed, 10 Apr 2024 16:50:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 06/19] target/i386: move 00-5F opcodes to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |   2 +-
>   target/i386/tcg/decode-new.c.inc | 120 ++++++++++++++++++
>   target/i386/tcg/emit.c.inc       | 202 +++++++++++++++++++++++++++++++
>   3 files changed, 323 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

