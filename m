Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E5CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 05:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryPWJ-0001wK-SF; Sun, 21 Apr 2024 01:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPW4-0001ux-KU
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:13:30 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPW1-0006jV-LO
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:13:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e5b6e8f662so26052555ad.0
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 22:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713676401; x=1714281201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mTpLBWm76JRiGgj3TbPJnQwmXPjnbwHIYW3eF9O7+Kc=;
 b=nyP3EU74bUtrzFdODdFxCeo0zLuc5CgvEUrtfTAuEpAxG4HKbVYb4FPK/IEhfFS75y
 i9ew9+0suOvlPqNC4AsIHq0N/mbDjLqKZcKMiufD8jIXBuLzD+5GFZgHoNVBvfdaYd8S
 fmPn2tWNUmtni2Tk5TYPwaYudwhO/WMQ84g6YYo7uUPCSEw90BZk03GOrBbBzshinKS1
 SEb1AfnHXVcfzMkqgxN0dEe5WLX8bWs9RcPN44Jp8qhNRwC/1iI2Ypb3OVReBguX843V
 q1Jx0Rh2A5kfhjxnf2umiMRX0bTJjFaY6vDdgxfMRrxV8oK6JPjSeHIX8dKNqYMaMOiv
 NGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713676401; x=1714281201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mTpLBWm76JRiGgj3TbPJnQwmXPjnbwHIYW3eF9O7+Kc=;
 b=ANE+rfjIszxyuVotBlFB0niAt6ZXSwu+4Kb+NNRiFnd/TEZFdfc1FYdaWxb5W7qWKE
 q+HUvI2GRNEcc6qcnBOaA69f94bo4nB4LmPmp6PBUKtyVBVMrU7X5UTHy3XNI+IipgD4
 kMRhcq9KuX738R5aF5D9eoTod6SwH/TYkarn03djnJXZy65SYz7UrLk1s72I0xyxptHq
 5MzFX7M9ijFuRfHoLzrNlbR+5AWtiXnbgqnnn1/BHE7EMrMLjq7rvobAMwoW8T1OOKc+
 0YnqNT9qlyWFbiKOPx8L2qxewncbdlCumX6QtTymFNYjg3pg8LVmqVQtgjGeczVWf2fg
 xwqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyf6OteO+D4d3202QxkD2c+RJgv5dKT2g5/HuoqsKe/vRZVnfeoN3kptxRL8ZMSvk8QUtf8wxx0hY6wS6p/4sWlMV4+1k=
X-Gm-Message-State: AOJu0YzGwyOkvIf3G74uie1Q3Pnqnwoc2tJTX1CQxP235V5ClUDOn8ry
 cvM2dy3eBG6QRwkimvCjZARpEz0d9R8Ecn3TmjBVfeSVrmQq4PrDIKewG3QJyh8=
X-Google-Smtp-Source: AGHT+IEKhd29z0jAr2WpSvCxM+T6WFxH3wSzT0tYdwB+VmSVAxXcIpTxCn68pslB5olCBknBuFqJpA==
X-Received: by 2002:a17:902:f605:b0:1dd:dde1:31dc with SMTP id
 n5-20020a170902f60500b001dddde131dcmr8676252plg.26.1713676401466; 
 Sat, 20 Apr 2024 22:13:21 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170902a50a00b001e0da190a07sm5802110plq.167.2024.04.20.22.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 22:13:20 -0700 (PDT)
Message-ID: <292e6672-445e-405e-8eb0-effe712d0fe1@linaro.org>
Date: Sat, 20 Apr 2024 22:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] exec: Declare MMUAccessType type in
 'mmu-access-type.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> The MMUAccessType enum is declared in "hw/core/cpu.h".
> "hw/core/cpu.h" contains declarations related to CPUState
> and CPUClass. Some source files only require MMUAccessType
> and don't need to pull in all CPU* declarations. In order
> to simplify, create a new "exec/mmu-access-type.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h        |  1 +
>   include/exec/exec-all.h        |  1 +
>   include/exec/mmu-access-type.h | 18 ++++++++++++++++++
>   include/hw/core/cpu.h          |  8 +-------
>   4 files changed, 21 insertions(+), 7 deletions(-)
>   create mode 100644 include/exec/mmu-access-type.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

