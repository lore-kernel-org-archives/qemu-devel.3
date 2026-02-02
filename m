Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C60E7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmw0V-0001e2-IK; Mon, 02 Feb 2026 10:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmw0T-0001ct-A6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:38:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmw0R-0005Mq-U8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:38:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso2834376f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770046706; x=1770651506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xtzc+zDHIihJICfdhzNz9OraYCFUdbVvRCSSebBmE8k=;
 b=rq0uwiNgkkpmihIv7KLPrftUtLDEvvLa6jegcXQkeGr+iHRuNmfIot/UkuxsVW+tj+
 a3RTbxO/B7XJEd2BH9tLAlckxpstUYzYJ2wpHDow6rcx5PlYolqTuitoGW4RPU73fe5S
 AhMaJ3JfpYqxzWCkKhf11QiV/1eluLrehzzO4n/eXjb5Nnzh/TKT3ehL8F+uTzv/K4MK
 1ggfIx0COV+xY/PjHKcafeJuz5NNTLXwOmTRmEQyz5xO7uEAarqQUPteSmPcP87CutM0
 qHq2G6JBVCyxOaEMQsfi9cSdfvvsznnBNN6So/YcRP3YsiQ/e0CqQZe1oOHeEapRpKkp
 S2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770046706; x=1770651506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtzc+zDHIihJICfdhzNz9OraYCFUdbVvRCSSebBmE8k=;
 b=HA06l6LWNMvQqCLltAlSeKEvEW1/iy+yymMqRtXCMRs4uCeG3os69Egp4N8WUbSVgX
 mheVir3pJfc7qGXb200AuRkgtuUVK86zQY5dpu5MiOY+TfNzwpo0T+K2Ik1gtBCvBYQm
 I1MQIABTZRGGi2ea74qmUQwibr268EbQ4XYO2GweU4oA+f3J05DrV3qw+amb6utAo/Kq
 oZsJQGeVl+mjY61JjKkoLhFiB+MPKeSFo7KFurmp4cYbNq9tzTgOaJkHIF6V2qkk0daR
 DGj7JMs3HvHtxDiR6demI/0CwtwKx1zwp0MY+pT71X7uAS10P72uIfbSHEQ/x2/erkQt
 oyMg==
X-Gm-Message-State: AOJu0YzetmjNZekvVT6wMzdGiK55b8/HFH0Q4LNY2/O2wHp7N9AcKdSB
 B7LyyvCBsjq2/MCMN6jkSLXybd/9wusu5DGS4jxql5c2qtpcIN+r9nxZLkXkjnbgJDWwL+SGJ4j
 lowip89c=
X-Gm-Gg: AZuq6aKfWWahoGVqdCBra+14lEvPXVPmiwhsMvFBRnLD4v+D2pjzazMXJCgKCsqjgNn
 3zLeBTU7X/hsJpKwrNpOepfM2oK7yPuLjWLY9hCmR5gF9/qVQvQffL2bCS0HtfVvIXXb2ssv/V6
 cYwooQw3XLKCBVtH0i+aBqBJ4L7vfyD7NNRV0tAPffa8JS/Nt33eYSxS5Xo7AahPCtiagVQ4sKq
 RB64YCgGUldeYgj/KTXR+gtoolFeYClIAnsnsBONJtvZIKSAxiehmsFA/D1G4gTJsFsBl/lhvP/
 GycZmHSFyX+K5HyasIG1fiZWy59Oq7LK6SSGJGD/xxPyGOWjhMyzig5Bek7dRr9sSKqwpG0D2hr
 cOFrwbsRKWC9yqLtEMYc95H57EGcNVL35XfTmzSWL1IXlXOPrp0HNyLW6d0r3ArIDkNObXU/kpx
 h5lfD7H42C1QO51yLUM8fEXSrtBDEpxxe6kyeCGiKf/EThqhYCEqRaSw==
X-Received: by 2002:a05:6000:40df:b0:435:aecf:9674 with SMTP id
 ffacd0b85a97d-435f3ad5ce2mr15506234f8f.55.1770046706260; 
 Mon, 02 Feb 2026 07:38:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm46742514f8f.40.2026.02.02.07.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 07:38:25 -0800 (PST)
Message-ID: <f8662a99-86c8-4747-9015-b1a82b50df13@linaro.org>
Date: Mon, 2 Feb 2026 16:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] target/ppc: Introduce the mo_endian_env() helper
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260122221106.57184-1-philmd@linaro.org>
 <20260122221106.57184-6-philmd@linaro.org>
 <aYDBNF0z2pe-8Cjt@hive.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aYDBNF0z2pe-8Cjt@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 2/2/26 16:36, Anton Johansson wrote:
> On 22/01/26, Philippe Mathieu-Daudé wrote:
>> Introduce mo_endian_env() which returns the endian MemOp
>> from the vCPU env pointer. Keep it hardcoded as MO_TE.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/internal.h        |  6 ++++++
>>   target/ppc/mem_helper.c      | 18 +++++++++---------
>>   target/ppc/tcg-excp_helper.c |  2 +-
>>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
> Minor comment but the difference between mo_endian_env() and ppc_code_endian()
> is a bit unclear from the names.  I think especially since
> mo_endian_env() is used in ppc_ld_code() later on. Maybe
> ppc_code_endian() -> ppc_disas_endian() || ppc_tb_endian()?

Or mo_endian_env() -> ppc_data_endian()?

> 
> Regardless of namechange, just throwing out my 2c
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

