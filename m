Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA15C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 09:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjFp9-0001ei-HG; Sun, 10 Mar 2024 05:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjFp5-0001eH-Un
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 05:50:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjFp3-0002pH-JO
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 05:50:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dd5df90170so22797195ad.0
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 01:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710064223; x=1710669023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwzpLY81HI4d1/yIIF7dQdqkkcfAtKxiOLFJ5W/E8fw=;
 b=iRUDabig0BrEGLaxjanQ0UKSBJrJ2U3wFQx7Eno8MdB3/wQNhCCr3B7CxMGi6SfLKB
 LkiHW4V4VZpBDfMjx6+3DShsOjKXuTSNtaTrY/pL+azs8fs5PdvUrZGnsCnVI2M6kiYH
 mk+Ph9+RKBiS2tHQ7fKNeen3280zHZKVOpwkGW7ALq/Be0Al54jS92xFHjjsVJxbioAf
 ijgsoTHrODh9G297wXMoJgFc63yAjfCYle4rn5Uw5mdmMP07uzJprXoWkya0Ml/mk/Kt
 ehBdQtKOpYfKpK8+AZ4OE4ZL5K7j0O8smLa1fdmMEm5Fe5TVL64HoK81u7HyknWfzTGw
 rkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710064223; x=1710669023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwzpLY81HI4d1/yIIF7dQdqkkcfAtKxiOLFJ5W/E8fw=;
 b=uV/y34PGJqAE3kYYaAszqChH15zKmWkPpfY/awJSvKUMqBhi5U6niEmFjEPncRbTo9
 PpQQOnxamx4e0VIe9q6Y9fBM8FujChFMC3o9G5r/YeOesjO8zqukvtBhrC1UEWI2YeXU
 kK0JzpXGwwrm0iyQWdDPTRxk/vxzlKeGnxh5OSbJzTfIGE+4KY/fvR7NWcRTEkRoJYTa
 ec/DNTSIQeD7xPDROTVkwhe2oM4UB9rI1op/VoDjUAT85GcjqgriW4FgvPnKMCqT5g6o
 HZLV3XJeym7KrcWq1FBgti8TKf/QkjXykwmYkWY1wliaSaAVAcG/eijJZ5KXzV0lnc8z
 mp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzLnbcjzb22rkF2mAjh3V6/A7HWvTGQ03ZMDtFdIvCKubg233WesCkNbThz/50MVIaDQN8tCjLgXa3gp0cJ3iLF/wj0K4=
X-Gm-Message-State: AOJu0YxvRM4drttcWUwDUhCUo6gge59Cs38LFJd6jW/vYB/q7by7mQgu
 lwvIp3OicMGo1yXK2ov57K7Pe0YsU+4u78w/gNDbzZfWLIgJqL6KONFyU1hGpOI=
X-Google-Smtp-Source: AGHT+IG4rzBicypNT9mCq5uZGIEz0Ja9E2MAdkHOrZuTjHtEt5FOZGs9g1IjFtQ5SaA25mb7+OCqhQ==
X-Received: by 2002:a17:903:585:b0:1dd:54a6:6401 with SMTP id
 jv5-20020a170903058500b001dd54a66401mr3756069plb.17.1710064223370; 
 Sun, 10 Mar 2024 01:50:23 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170903024800b001dcc2847655sm2436042plh.176.2024.03.10.01.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 01:50:22 -0800 (PST)
Message-ID: <fe4a7631-699c-41c2-96d4-dcc3133437e2@ventanamicro.com>
Date: Sun, 10 Mar 2024 06:50:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] target/riscv/vector_helper.c: update tail with
 vext_set_tail_elems_1s()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-5-dbarboza@ventanamicro.com>
 <888ec29d-4c93-4a3a-8882-3db690ae0f40@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <888ec29d-4c93-4a3a-8882-3db690ae0f40@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/10/24 04:41, Richard Henderson wrote:
> On 3/9/24 10:43, Daniel Henrique Barboza wrote:
>> Change all code that updates tail elems to use vext_set_tail_elems_1s()
>> instead of vext_set_elems_1s().
>>
>> Setting 'env->vstart=0' needs to be the very last thing a helper does
>> because env->vstart is being checked by vext_set_tail_elems_1s().
> 
> I did wonder if it would be worth doing the vstart = 0 in vext_set_tail_elems_1s, allowing that to be the very last thing in each helper, and could be tail called.


Some insns don't update tail, e.g. vext_ldst_whole(), and we would need to
clear vstart explicitly in them regardless. Might as well deal with clearing
vstart in every helper to make them consistent.


Thanks,

Daniel

> 
>>
>> A side effect of this change is that a lot of 'vta' local variables got
>> unused. The reason is that 'vta' was being fetched to be used with
>> vext_set_elems_1s() but vext_set_tail_elems_1s() doesn't use it - 'vta' is
>> retrieve inside the helper using 'desc'.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

