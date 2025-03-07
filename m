Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15445C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdTX-000751-6l; Fri, 07 Mar 2025 14:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdTU-0006tO-Me
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:35:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdTS-0007Md-Rz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:35:12 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224171d6826so17149095ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376109; x=1741980909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tZuYtoRXFWyQyTHKWqYeJurYWPpe4EhPI7MSG6xLHJc=;
 b=Pc5YjLhUTuf8HLypJoT4yfRyIxgS54B38ZtR0HYckPRuHVU27ZiOwcQSpWH6gBXCOn
 +FJqOn2S/Sephnna3Ou6fsHU/x53IFnJHB4M+IrgYjFKc/jlaj4mcXGX8tk6c9eS2wpU
 VNLhaB+2YbLtrGM/7p39ieXzh3VzchYrfD9GmAH0Myb/RtELsSVqZVtQOresOreWX9sH
 yn1JH2QEFmo5kZzml5VU6VNhVeVlYSvVo/A9FpIGwlwdAs6iZNbuf306WHs3vznG2H96
 WlScXuRtGdU+8qCg064zxSRvYWuQE3fQMJyFJ3p4arQ9kfOO2p1/SpgyQKcXZBTLMpqz
 4kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376109; x=1741980909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZuYtoRXFWyQyTHKWqYeJurYWPpe4EhPI7MSG6xLHJc=;
 b=LJRzjt5I3jLk0BUoF6c6h8ziX/ol6JCtMNDyUpoI7dHgP/1NEKA/cmivKX+hXR/c2e
 IgulgFWSlZE9kRvaUp71uhXyNIpuJ459qMHKDOkCwPd8qlO3ndiwqSoVCqabD9wJ3iVr
 j+X1d2B3x2g4Fu4MquE3gCYAFLK9aDgAbVgq7YQ4OuRgwTmT16fiNtPiTe6DJmv2Uz1g
 39crdO9P7+psREhrDWWqUZmPGs6DEGRPar2kHblnIXsVHxc2TeYWAZ2uCb+1fCE0Tt99
 s0P3sA4jX1aiOUI6itRA2RmRBKOhm+hZBgRvb6nNcHLuiYx55snjNZZCjb5NRUovhwvg
 Ck0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoXRaEZ+8BzlxoLybtuDAz7d7IjwaPfqmKpZVOnK4ZEoAJunYLIO28guccb6oXNezeB9ylf1Hy+NQ/@nongnu.org
X-Gm-Message-State: AOJu0YxvxGOQl0G6dE77qTpSjEHHUQBhpAHX1YMHzEjMTPiR5o05MMXz
 TcQ6qEoWK9JLwiFtjTg60M19Dw/m4lDch0CJHomkLSBI+BAmNb9f1zY147m5syI=
X-Gm-Gg: ASbGncs+ch64J/9C0sRD9skiuM99UxBogG2TSegHIWQ20OdBrP6IF+Uqm6eslzhsFdA
 LAO2etn2/avyLU1TDk8KM6eMVlTtG8ba2buiAbuonY1UiBNzakxY5BGmy1yYOlm8IkK5m+aG37g
 9xu3axqFji4ttNnXPqEpkpXVEN+9cR6HfV8EBbrsgZ2jbYLL+eIssi1VMs11oxf5U5QsTEoeHYW
 3BO9Yr0Q0KI1K4l7Q69YAaVKS3Fr50CybpGvvcAq2+gFWmUMLLljFle+olE5kRxBH5dpsiPFeAS
 LZnAXA7DqDLfWEl6h5awWILIvE1TDFjHPbiqakazIEUfWSRzDHLenaXUzaFF1Tu5GIhU1q/D0LW
 9yIAc+hpE
X-Google-Smtp-Source: AGHT+IExjWEgbnZRrv9nOq1kaTGVOEEvlZ2m0c+3JvzcesHA3PFhUNy4hzEMGib4npQVGcxdA8GmHw==
X-Received: by 2002:a17:903:2448:b0:224:191d:8a79 with SMTP id
 d9443c01a7336-22428993894mr57044765ad.27.1741376109236; 
 Fri, 07 Mar 2025 11:35:09 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91b8asm33913175ad.171.2025.03.07.11.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:35:08 -0800 (PST)
Message-ID: <49c97be1-4784-4b81-b5aa-d899ad8f3525@linaro.org>
Date: Fri, 7 Mar 2025 11:35:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/vfio/common: Include missing 'system/tcg.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-2-philmd@linaro.org>
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Always include necessary headers explicitly, to avoid
> when refactoring unrelated ones:
> 
>    hw/vfio/common.c:1176:45: error: implicit declaration of function ‘tcg_enabled’;
>     1176 |                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
>          |                                             ^~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/common.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

