Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D7C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1n8-0004Hm-IG; Fri, 31 May 2024 08:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD1n5-0004Gp-NY
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:55:27 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sD1mx-0004cc-6o
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:55:26 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso25867651fa.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717160117; x=1717764917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1cpFa6FVKwSFA+VRpsxUQlT8OEi2ogEdoXtWwLeulhQ=;
 b=y903D/JI02lv//kBi/NNqONN6E4+l4CXJPXWbqwOmudiSaKMBfsyQT8uDHnOl0qFkn
 ix8H3KckgJG5kLdzZQ1IM4GrYkYIUqXihlC/idA3V+A4pvQpV8jfsjUReW7bysoTqAvm
 R8W6RXvzahVOtCb/THtrA0H8XJ5S1rrPo+vRtTtDuUcK9lamHs/4qx2vxtqu9nuKdkMy
 VNY9COntGAeCn9ulObNYrG9W1hJ1ck+DSUgrRm6+MR0f4suUrBAWuMlXRqBkp8uSvmzz
 Abx0PfnV9sJkxM9quYEaTN1TiCMGDJmG6BjxDERu/ARDdSadmAlXalV0ilGsDy3EOOMT
 UUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717160117; x=1717764917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cpFa6FVKwSFA+VRpsxUQlT8OEi2ogEdoXtWwLeulhQ=;
 b=K739ch3KRZxcYsteG3BrF7botiffuPa8btpbnWeSJuo0qcdl0IxsKiqGc6eCSEmufH
 jqfM6ynzDSB6yafRLAuSzYt3LSbqxhSE5yM4zTGz1ZBW8jyPFMtwpCaTIJVJUh/KW/pm
 2eOD91INqfqZWJUCgKUoUYysRgUP3zcP+kqIbgUJpRN89l0sT7FmbFQAMW4XZQ0NP/uW
 MKOgDtg9Y4Qn4Vo2KqySQXDZSsMERXOqhPNv1dI0qoNdeX3bz6IYpL8LPsfQpw0i8gtX
 L+zKZ+GJsA74T+/B4kSDCUS+VvUhIGCXGocZe1eQV/zpMwcO8aKMR5AmDZ6RSLk76xZ8
 sNMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW83083RFxeJEamlXSxoI1jVwDfIQhXf0OibDTuWAHuVAZqcYtvMZdeo4VaGfoW/CmdfCfJv5kcanEHzKJtVpFE9sR9nQI=
X-Gm-Message-State: AOJu0Yxt1NL9lk+abHDzqZwJTkn8Dvv11b7cloN5RSKQ7JZNslFVYxaH
 JHW4pOWWg9b1xDcfWcFw52m1AHFOrOg4sNG0FN3QvyEjFbJDJJdhRJ30lAi86ItQKNCQs4lBxo6
 1TFA=
X-Google-Smtp-Source: AGHT+IGOjvew9dyTHM535YbCv+Wk/f3AfYrgQi+sC3rQFagvuN7j2o1xIe2No9VCarxVqGVEv98PrA==
X-Received: by 2002:a05:651c:2112:b0:2e9:8374:3820 with SMTP id
 38308e7fff4ca-2ea951dfc12mr15841811fa.40.1717160116781; 
 Fri, 31 May 2024 05:55:16 -0700 (PDT)
Received: from [192.168.183.175] (11.red-95-127-95.dynamicip.rima-tde.net.
 [95.127.95.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b2bc975sm26527815e9.29.2024.05.31.05.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 05:55:16 -0700 (PDT)
Message-ID: <aa9e9b63-a8cd-49b6-9b83-a193456aa925@linaro.org>
Date: Fri, 31 May 2024 14:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] host/i386: nothing looks at CPUINFO_SSE4
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531091457.42200-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 11:14, Paolo Bonzini wrote:
> The only user was the SSE4.1 variant of buffer_is_zero, which has
> been removed; code to compute CPUINFO_SSE4 is dead.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   host/include/i386/host/cpuinfo.h | 1 -
>   util/cpuinfo-i386.c              | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


