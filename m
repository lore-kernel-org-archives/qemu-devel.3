Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3122BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUJD-0004Mn-C7; Fri, 21 Feb 2025 09:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUJA-0004L6-4h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:47:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUJ8-0007kG-F7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:47:15 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f26a82d1dso1204610f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740149231; x=1740754031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTIQziLHxEI31pRspCNaCVe2UyXrqLEJeUhe/QY8wA4=;
 b=AlEAIuWwzL5+Oe+pH82SZsneBphQFPSNL/AO802A63kOmRWyHI0EY9FWSV70o3FnqJ
 PfguS0G7Tyl1sS7tF7pGyyHD8edAIxg/q22Ao+DaXeKB4C/vgwm5TpU+7BAWHLybJgig
 1wE3AThtymMQm4b31QNv0l9z0Dr0X14CnLGxrgwLwfdQMX1AnecoW+pgRk29AxfdVULI
 PuW7eLnTO7wFa2zcwjNzU1VHMjLBuU5u1+QdqR3ntS5p1XyyKaKM4DPHx4B9AThnwu8M
 FnOtvle70S46ak42s1UYwB8Rbvg3Zkg/13Bq8hS45SETxLR4u4CxMorTKc/a3yOJzgSY
 +4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740149231; x=1740754031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTIQziLHxEI31pRspCNaCVe2UyXrqLEJeUhe/QY8wA4=;
 b=NulLhcvisCl41DmkaHdAjgWnwaah80qkcJ7f3UWp6XdiAR0OTr1vXtleRl0KsnhNff
 uxXL+D60vXh2F1F9fgwIzEF7v0B9iHUZJtpn4T+MbjRjPnQRUu11cb3OtyCeg13zkBC1
 likH2FQ2bN54T3PYJiBepbrt2BKC7HBcaGsBiIIn6MTa9IEmKy3/lWtuTKVpK9zxl4AS
 cjql/8z48NvK5e0588JJC0NJrNaWOd0q1k2LQHw642Vn4T6DZH5T9gDUzAs8vYWjGGTm
 JOYQB76kTKr95nA07szaR2macyojvL8tO1vex7XuevVS2sBTDGfbPDJREes6pUWfu10L
 tvZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq4E5+onrTBByVUnNBSMDoE1qN3LCXDY7LNkGaTOTn4vQRUl/KflbWZh91fGgvyhs0eCgqnkttKS+B@nongnu.org
X-Gm-Message-State: AOJu0Yy/6fhyYUwLJ/3DJj2wt+jbMNmtwqRfOsi+Be7Q2bftjdmtQHeU
 ljwm76Zkws9s5f7nbid0opN7I/I+TeFdtnFJDFiPt8kk9C9MWEYE8jeDVd20kds=
X-Gm-Gg: ASbGncuNcVUVCQubHRkzzGwNF5+6nyG9qLj92jpFj+ypkVdew7bcSz6f4OqOyrPM5OY
 3WOitfnrNPF5MSbsdsRPKGPQ1YdV50aqrZsqMc/yn807bvNZ9Fuxt8wdPP/SuclKHIzmMdMMsQJ
 mpm8I4eNmGnZKyjJZmlLXiK9oTPbLmhfUdCPR1krtcE56Pn+ZT7tiAqsk9wfiPMfNH3L+8rgH6k
 4J8v4Gn+I5LH623H5X6uhp6CyKna8b6+LxDCSkOhYeUvN6nfAqMhvJ4DBlhomhNFYKl+T7OZSr3
 3jO24wrr+9Inz01G8GoIpmiEtEOlaV/19SD9ZBnUr5K0XiR/j84/KESpVUS2lESVan9PTQ==
X-Google-Smtp-Source: AGHT+IHpWWE8cnr4GI6oW02q/VrJn0zZRJ72Vf+TYf9YD7NY8v9cNalL3PT93WYDGsTpn7vTW/YBmg==
X-Received: by 2002:a5d:6dac:0:b0:38f:4e30:6bba with SMTP id
 ffacd0b85a97d-38f6e979fb9mr3257919f8f.23.1740149230841; 
 Fri, 21 Feb 2025 06:47:10 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f64b0f565sm4820236f8f.51.2025.02.21.06.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:47:10 -0800 (PST)
Message-ID: <4effd75a-d0a8-4cc9-9c43-ec569a15a157@linaro.org>
Date: Fri, 21 Feb 2025 15:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/19] target/i386/hvf: fix a typo in a type name
To: Wei Liu <liuwe@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com, mukeshrathor@microsoft.com,
 magnuskulke@microsoft.com, prapal@microsoft.com, jpiotrowski@microsoft.com,
 deviv@microsoft.com
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
 <1740126987-8483-2-git-send-email-liuwe@linux.microsoft.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1740126987-8483-2-git-send-email-liuwe@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 21/2/25 09:36, Wei Liu wrote:
> The prefix x68 is wrong. Change it to x86.
> 
> Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
> ---
>   target/i386/hvf/hvf.c       |  2 +-
>   target/i386/hvf/x86.c       |  4 ++--
>   target/i386/hvf/x86.h       |  8 ++++----
>   target/i386/hvf/x86_descr.c |  8 ++++----
>   target/i386/hvf/x86_descr.h |  6 +++---
>   target/i386/hvf/x86_task.c  | 22 +++++++++++-----------
>   target/i386/hvf/x86_task.h  |  2 +-
>   7 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


