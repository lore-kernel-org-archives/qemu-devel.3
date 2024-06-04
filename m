Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97459C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUQF-0000oC-Dx; Tue, 04 Jun 2024 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUQD-0000nT-SG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:41:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUQB-00017w-Rm
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:41:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42121d28664so49379765e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508510; x=1718113310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7QnDfWW8Z79g36PG9YSWGnOrOylGN9I1qxmyLf2WAg=;
 b=UfpwgwVKb5quPSNent6F1CGO5CrbJf0o0hO1LoXYN655CUs+X3qKcTFK6Ks+mWoZn9
 naObg7UBSjxW8nMPYu/930C2RXtsIj8EcE1ePtvLA2Opvi7VaTkhUGkP8HF23vaW2zfk
 gN/bAe3Jyo112ZYu8DAphyh0Xw8uLM7JPPJNDmVn1wmD1W4bGz2xbKCfXIdILNb1YU8P
 8JRBTduqh25Tr7CuPIbMVOjJ2SP4SwSX6paVjYHnoxoMlguKpA/D9qph1PM8T0g7HLDB
 XJz7eVVkxZqdCgFMA0rBF7I9Vi2yxU0OGSX09FCzYq+nFp400TMLUWi0z5pohn0hFbZ2
 Y5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508510; x=1718113310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7QnDfWW8Z79g36PG9YSWGnOrOylGN9I1qxmyLf2WAg=;
 b=t2URSvP+eaCZlhFxgl0daKqjiJ3kpGi+l/DBpIQR5oYBeGcErjOqBA4qFq12LzGJ/e
 43vx0VNyS3bxbFnrGFZp8GZX4fqUDj5TeatXlEBC13gUSqJ7YqjuoZvu+tYPzO/7XGhn
 rwX2laajRwsL70dtLchiLKtn8fvlR8GMjONmuHp8bK3PNlhMHtzRdRvFGZUQ5pHWbEOi
 mISKdnAIzuV0wzYKwrzaQq+skP9UJBEvWboE2Jfu14/zk2/TvqVNzZv3JoBsx/QYEEHt
 QblP7Lmiztxl1/8BlTDIRQbfYrVxOP5S9YI7YsPdXnp7yrZd2Cw2eFUSss+MKIuEzOqj
 J49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH0YXlis3dS9NQf0Ta6TTfCNx/tPzHkOndLLSyy3dVUNeI56XMJ4SqVjtYnCRZn7hVgBW32DfjIZqX6Olu14BEp2Mb7ms=
X-Gm-Message-State: AOJu0YwUbGxZOP3gc/nc3js4HTk4lm7/5wZV9e77HDlKjTfnoC64uSkE
 YfdMoNeVrUMkAJNrXwLi5bPA++yxoTkQ4L+FDtHDnzBoZSKsnrA+23rDFm19SkQ=
X-Google-Smtp-Source: AGHT+IE3D+Y4JVkCyYQUYz6g2SdesTY9v4dCPDY75nOygtceubUqsbbPB85sN/qqY7h/J0kUpwbUWA==
X-Received: by 2002:a05:600c:1d1e:b0:421:5237:786c with SMTP id
 5b1f17b1804b1-42152377c60mr15001485e9.0.1717508510271; 
 Tue, 04 Jun 2024 06:41:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215310c7easm16898045e9.12.2024.06.04.06.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:41:49 -0700 (PDT)
Message-ID: <58456b02-9690-4744-857c-0089359b2c17@linaro.org>
Date: Tue, 4 Jun 2024 15:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/37] target/sparc: Implement XMULX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 ++
>   target/sparc/insns.decode |  2 ++
>   target/sparc/translate.c  |  4 ++++
>   target/sparc/vis_helper.c | 11 +++++++++++
>   4 files changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


