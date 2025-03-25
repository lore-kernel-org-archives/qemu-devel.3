Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A60FC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx9Fj-0001sy-SY; Tue, 25 Mar 2025 14:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx9Ff-0001se-MR
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:43:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx9FV-0001nX-MY
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:43:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224191d92e4so118421045ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742928219; x=1743533019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1KMccnWLayveHVykdq72S7A5HryrNJBOb0wjvi72hss=;
 b=ZkFSzZTDea21MwaMjZNqjc46Q3AtX3vRDn7uXFQ7Kkt4oZ3L7RRARdBdgOvW3Y4c/K
 nMvqDkAyP/av6X32G25SRXQN1u7tJfLd6iKZQBA5IAUFk9a6h1laqDn+HZDUjl1Z2Nzr
 GK2pLqghg3zKW9dISTI10maWceK2qdHfRNGugbJ2ewXwF+NeLCmY9cheFmz+9a8aMFHR
 tlayLXKes2FKQlZNuBeAG4tjrWepQXAccFGbh8pFwNq4L3yzEvxfLq9TxMxYzg8Ph63N
 B81ZKy/HE8ZErSBhoEDvt99oQwyXjH38andF5jJINjtyL15h9gdJ/XQ0c/3dI4gwCmFy
 vUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742928219; x=1743533019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KMccnWLayveHVykdq72S7A5HryrNJBOb0wjvi72hss=;
 b=t9U/3m6Ojn5NYVAjJz6yU8ikp/K7hA4l+TAxzHXQbqDXv+VRBiXC3XHFtdP9WeyQ3E
 1T7kLazzEBOsw+BBIss5kmvb5ga5xROEzk6cWu1dj0bNweeqZZ4tMYH1Ft2in2Bh1yNn
 PxuBwHPHwUC9y8xCniHCuZSMSmb1+3mxgaRYeiOJEolFmdWAtNCdADSJhNtivKlT5gnm
 Acdk9uJkxrYwZy6ksr2W6fl45ocBOElEWU1xYbNOMELVRsktXwNaje/XkUoMaZnLzhxD
 4GthojOJ4Mm3UWI324unI465K5XUkT5fYImbrcCBtOvPdKfNnEeYaIuaJzosy1ApA8Ry
 ZbHg==
X-Gm-Message-State: AOJu0YzyqvIoM96AsXWTmK9F6AXATTTbVg7r4W/n2phwyihvA/x2QbwG
 skJzMMXGHYq24iz9f294vYHYBBIvq3Xt7ZmrR9LrdziboHSrn4BLu6ft5IOw5E7W+Lk81XmCwgh
 w
X-Gm-Gg: ASbGnct2NXXDItwBUZ30jNNlHT/lxTJ5eNrezfcp+2pRO2bqELT52OU7e/x5if25wWM
 L8FhLAZgXpG+ke4adnLWZYy3cVu9C/RK13vec/ixnoiPVBzVfDShjL4G3cE5xd9M4zTSQY8woQ0
 iexu5Ek8pGbSjADoErcN6gO/6vmyHAbM389ua31bSaIHCE1L+uvSZu2xa9WG9mDfqCytPlnvClx
 guA2hvQ5hRA6ZhwsK6UsFxDNDrMrL43m2jK693qgUOrcGNJSRfZcoctQRoHs3sjsnTGwLNEhD9T
 miK7ITDcS/UL73DZOJFMSeA/TzyjlCONYwN/X+97Lygq3CatAUGlu/bI3GjQemcPT6EEveF0slj
 qFY0yHCEf
X-Google-Smtp-Source: AGHT+IFKkm4+UDVIuJMfm+4HsTyCBR/9S8tPOrakrsiQ+/0WlNsoVCpSQwiem1WGlhpwKVG31P/GYA==
X-Received: by 2002:a17:902:d541:b0:224:2657:2c04 with SMTP id
 d9443c01a7336-22780c7e049mr313827795ad.4.1742928218682; 
 Tue, 25 Mar 2025 11:43:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906159fa1sm10514225b3a.151.2025.03.25.11.43.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:43:38 -0700 (PDT)
Message-ID: <f811c78d-e055-43f0-bd74-a09d2edee766@linaro.org>
Date: Tue, 25 Mar 2025 11:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2] target/riscv/gdbstub: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
To: qemu-devel@nongnu.org
References: <20250325154913.95283-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325154913.95283-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/25/25 08:49, Philippe Mathieu-Daudé wrote:
> Replace the few ldtul_p() calls by a generic ldn_p() ones.
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/gdbstub.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

