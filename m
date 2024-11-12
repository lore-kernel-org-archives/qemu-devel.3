Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A20D42BA2
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 15:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAt7Q-0000EO-Q3; Tue, 12 Nov 2024 10:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAt7P-0000EC-SF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:47:51 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAt7O-0000YC-8x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 10:47:51 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so5156479a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731426468; x=1732031268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/gYF32x5WRwFWEll3HIZOKHzFl4vybOn5bDSr4wys0=;
 b=xDOVLXGfobVEv8j7NJEg7ClbxGZIXJm570VL6+iwkus9x94NguSp9ZkOtsYLv9+enT
 s9HQYcPH8eSh0V89QTa1W6fZ26vNUBT8upI475qgzOPPLtbHMv477p646oLCTDjJREJ/
 Pk0aDKKftrssOKv/T8nAcMjrQtvZ2W3VRyxCUHd6VBTWERUuDuzfKuetPUcadI/bKnsA
 +PdJjycdQGx4AIkRhXx1n5sH9O/tOF6mdH3D346qlu49SQ8te4d11FWcy6IQLzbc+9am
 T/0ufb2gG7avTW68GuglCMhhwonoKxrTaexuy9FRmoyBWfLC6NpGtpqQpXIKn+Yrfm6e
 iBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731426468; x=1732031268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/gYF32x5WRwFWEll3HIZOKHzFl4vybOn5bDSr4wys0=;
 b=dzF05nG5zOiAKbg90MCTh0gMn1HIMlzXLSo15k32Z8DXpGN++UmpIevTXLv4ccNskx
 cgIq+JEHPZ+miCoOS+iNAO9zPo3J0mUIj9stlAdXDkhq+ClydAqyz4EnRXPWSaRMkYls
 AgVH5uUTnnlXf6YA4sZX3FzXrbgUGCIi99wWw6TOfpSzYmCXaGWTFO2vB6yFyi7D4ZCc
 83dzn6AnMYkYcwuHJFMgdKhqSw5w0GUYiAidV/J+laY5EbUKxwUMF56/WI9UgKJswda5
 umyk1tDFQP6ORzASuxv7sPxV8kWCUBCj6udp5T/dQznFptehP4tq7Wmivd7ytYxNNM9F
 mv8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6NaliiQkKzDSJkna64nQSu80A+xJST2wyFCNFn5cZ1C7FVq4bJm2RikB6CpNld1UH6Yjs/V/MZGz8@nongnu.org
X-Gm-Message-State: AOJu0Yw63+09qaEJeOby2Iv616qZhY26ZNiN1+EAoB6BCw+4/0Pf5mng
 +KK3rYF1N+wP94quDz6ULu3NOwGE2qAbYUIyyVWLgcY8mX+9StivbcVsmGl6sE3JLo7r2ZhavqK
 6
X-Google-Smtp-Source: AGHT+IHUq0ST6ZPM6hYN4yv2iXdMpzzZHyOku1KGVtUrqOwiYoQYp/0KqmVo2DuAPuX2M/NYDi6Y5Q==
X-Received: by 2002:a05:6a21:3e01:b0:1db:ee97:56f with SMTP id
 adf61e73a8af0-1dc22a3285fmr19375144637.25.1731426468104; 
 Tue, 12 Nov 2024 07:47:48 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078609e8sm11703819b3a.23.2024.11.12.07.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 07:47:47 -0800 (PST)
Message-ID: <8867340c-766a-4141-9805-3b48b7580534@linaro.org>
Date: Tue, 12 Nov 2024 07:47:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 10/25/24 10:58, Pierrick Bouvier wrote:
> Most of the details are available in first patch. Second one is there to ensure
> we'll have a useful error message if start_exclusive is called from cpu_exec
> again.
> 
> I'm a bit puzzled that we never triggered this hang before. Is there something
> wrong with the potential slow path for ptw_setl, or is it simply very uncommon?
> 
> v2:
> - get current cpu from local variable instead of current_cpu global var.
> - change condition to check cpu is running as current_cpu will never be NULL.
> 
> Pierrick Bouvier (2):
>    target/i386: fix hang when using slow path for ptw_setl
>    cpu: ensure we don't call start_exclusive from cpu_exec
> 
>   cpu-common.c                         | 3 +++
>   target/i386/tcg/sysemu/excp_helper.c | 5 +++++
>   2 files changed, 8 insertions(+)
> 

Queued, thanks.


r~

