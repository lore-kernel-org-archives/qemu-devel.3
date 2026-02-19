Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9664AC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBCc-0004Op-VN; Thu, 19 Feb 2026 16:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBCQ-0004Jz-HX
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:04:39 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBCP-0002hZ-5E
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:04:38 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82491fbf02cso763358b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535075; x=1772139875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ggc47rHkO0iWbIY/JgsidQYPXEdnnjt/MhbHM0zcaXw=;
 b=UCk9s9IFXM1fbwwKMOhdSf4DgRm0OjoFSEjPeo0jZzK/zi50VzVRTK1WWwpBTwGUYn
 +g5B8+M1s4yNwCA2K5RAvI2lHEvA6NawDwnrkcLYeZx9cYUnaomFee27ZTS/q6+J1E7J
 99OBWzthSHY1bjyhlL7PAf6w15J5/Xtv19obC+ik1wl9MkatUz1DYVYvNSm7/PLcS0XO
 ezOpQ2bBNunnndtDSOEn6BzaKOGjO77K5y+xr64eIxBDXauCuQl93Djq/426SYMTh4fl
 DFQCtV6O4vmCJPUqtXGYP1YY1qhUFrdnJnD6fKPfevCSH2eTScyE7SqWxcpLYWXhEvQE
 P2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535075; x=1772139875;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggc47rHkO0iWbIY/JgsidQYPXEdnnjt/MhbHM0zcaXw=;
 b=dENilYAvHBtMXo7Jebn8qDxhysy837Qw8kGvyu02lGbMyNmY7YPE1E6bsvBUjOwe8r
 s06Rlk/lzQYysnLEZNRQV05JFVnt616JsdLTc5Jkb8l2ym1tFsEIlL0opJi5sQ+A1bsC
 mc83nqWps8mcRNxz33x9WRUig85zHfZWQdEaMdMFivGCkSY0AbYF+go2MKzpGwyoDbbH
 y/uz+hQLBlpd3Q7slIw/olTNuEAt0oxbuIFTN83+RqDsRo9r9zOm8jvCkfGSWJg8I0xF
 0i7lBMM+fl39rGjvbuypU3OBOCR9Nn1N3vdiFu4/i7OvaLBqULamDwtylXt08pBvYHig
 lioA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5TT7YeeIIelSOCm+iVHpRAkHHE7lydN9FznHRiNd+B8T/5pWlRZKMCFISOkLc3Axra+rsQ1tr6xNq@nongnu.org
X-Gm-Message-State: AOJu0YxmPtbmR07Puf6cTwkmmm25On/KwO3O64sTQlDAbglNC07Lkk+Y
 zuqO9KhvGd1JYVEUJIH9AnZNc13wFomOeC6y3nqNFFZX1fpLHCJmyozMCJGJdnQp7SQ=
X-Gm-Gg: AZuq6aIhLTqpzXXy+rNdMRQYU49XN+MOH//REcNrKWwf1f9cSK0qzGWv94X2TookmXb
 jjSnVTCwBA+431jWUNUEXhFmW7mVk00h62XEse+bMzD3K8nowJWX/PkXZX4hTzC3Lx2acDVMIdM
 yaraz5h+3/hBcxJ+DfM3w9t6xXJO42sqREiL2czlMgZFb4rAjfynukLrl18I+HZbM5n48n1MjXa
 Rj3wxr1EFhdOxs3rYI3pfEte2rEK6mU+Gs8nHV+B5Y2gY8+sMSEb5nIQy2SjahySyq2frcnCNov
 phQ5h6L3PakWLX3vLjhxSFRlLNFTqHs3Z+ytOIZJzWJD/RRyHAUvXc6wwHVy2pT4ShhZ5yF+4br
 NbEbTqs2Er2FLk5YKnN+xZM1AZ/N22eibMXbpO3UJRvixq4JVf+xT3wS+hOSQ6/VG+lrRsGQFQx
 cB+uekHAxsqPboAtgU8AFerdbU6LqQ15vi5mK2iVEuRNxFRRK7360RsnpRPcn0qv5Qw8fN
X-Received: by 2002:a05:6a21:339b:b0:394:5463:7330 with SMTP id
 adf61e73a8af0-394839d991cmr16032070637.51.1771535075383; 
 Thu, 19 Feb 2026 13:04:35 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3589d8e4229sm943846a91.16.2026.02.19.13.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:04:35 -0800 (PST)
Message-ID: <26b10ba0-7097-405c-a906-dc32f09ca178@linaro.org>
Date: Thu, 19 Feb 2026 13:04:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/50] target/riscv: Extract monitor-related code to
 monitor.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Keep riscv-qmp-cmds.c for QMP, use monitor.c for HMP.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/monitor.c        | 148 +++++++++++++++++++++++++++++++++
>   target/riscv/riscv-qmp-cmds.c | 150 ----------------------------------
>   2 files changed, 148 insertions(+), 150 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

