Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A639CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg1p-0003jO-EA; Mon, 23 Sep 2024 06:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssg1n-0003dW-UW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 06:10:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssg1m-00037z-7s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 06:10:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so7854159a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727086244; x=1727691044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnTcfZSv7rxHl+uhvrkeXweo3EVHht0UkrNeAaionF8=;
 b=PKC003ntn/FqBbu5IRFrYph/r8q1pah0mpaeHPQgaVjW5wa2B+4Ud35a7jlmmtyw0T
 J3ldzo6j170/4GxZNnvN0Xgh9tAHggxcQmST/yFqvAVpQDt6qxLvwnhmDxuikshCRy6y
 OkD+eVYRmKP66J1TlAUFwqr7Kz0zlmHtXc3VYlv6SQdV67+MnijV1DQ6t49Dz0pHfbDR
 hT36n1M9Bv8DwE/63syx25bw8Rba2v0JSClOiGG3OAPxkDV6KgYeW2QVd9tRLD0t4KXj
 apIqsvrpiuGBE/OYAiZhDHOH/nZGvi5kdaUnW4g5+12qQUMesWvk2AbBs8e7EoisuSW7
 /xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727086244; x=1727691044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnTcfZSv7rxHl+uhvrkeXweo3EVHht0UkrNeAaionF8=;
 b=VSWhpVybpEekqyqrHeQEEijTmXSTZ+y+XHWGXHrYB3mnVvkyB1qcBN2kMNz4VJZrjf
 DKSiPOxz4rOGKGbM6kM9kdnFsdjpgkgkWeppyMh8sBDDH/8I5K1e6tpInO6noeErR2PY
 XYXHOZJ+Nnws+X/0nr/ITY74sYk/koAJ8unh5+hpgFm6gHHkIFcCnIskmvPb+PthkYFi
 oMkSl7OdzsxVWmEczK5IkoqyHnEjGlVRmJ9ZjwRT3yQ90qbXEBFgtnPHgyPKWadSxhqr
 iOYdlGgg96awxO3CCfpGU/WoVaxz+jiNJqClavBe4BSeUPKjvhUns9wPV7PU8nhw4ehT
 6VzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/zxGOAVzBeNsf/h1rbFsE+TIWIOZw0NIv0/SfD6T0LyLUvCpwlXsyWSMwuMvdmO/PjXhnfUnm//Ic@nongnu.org
X-Gm-Message-State: AOJu0Yz5ReFKBhnjRwFGGPFGrjec0DB4SXPtIvKq7tuqKTpTIyFzbkBQ
 /GbGBil69C29KXHkjlWy1pzorp+XoKvLxAAoum+xHcT/Jf2VvY2bOtTUDn2p7N4=
X-Google-Smtp-Source: AGHT+IGWBA5/MJpXxITY6Sm5TNK3ODD4c3blhxTlfLY4n9J7VjI6+waWOgfj8mLC+3u1iUaH9guxBA==
X-Received: by 2002:a17:907:9482:b0:a8a:85c7:8755 with SMTP id
 a640c23a62f3a-a90c1c747a4mr1683792166b.11.1727086244444; 
 Mon, 23 Sep 2024 03:10:44 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1195425666b.107.2024.09.23.03.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 03:10:44 -0700 (PDT)
Message-ID: <aec8f70f-9a9c-4ce9-9d49-d3e895497f90@linaro.org>
Date: Mon, 23 Sep 2024 12:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
 <0dba42ab-83fb-44f8-9802-1f2e53bb89ba@linaro.org>
 <8f4fb8f4-508b-40f0-ac9e-f3f591b5aae5@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8f4fb8f4-508b-40f0-ac9e-f3f591b5aae5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 9/23/24 06:46, LIU Zhiwei wrote:
> 
> On 2024/9/22 12:46, Richard Henderson wrote:
>> On 9/11/24 15:26, LIU Zhiwei wrote:
>>> @@ -2129,6 +2389,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>>>     static void tcg_out_tb_start(TCGContext *s)
>>>   {
>>> +    s->riscv_cur_type = TCG_TYPE_COUNT;
>>>       /* nothing to do */
>>>   }
>>
>> I recently realized that the vector config is call-clobbered.
>> We need this reset as well in tcg_out_call_int(), 
> OK.
>> and prepare_host_addr().
>>
>> In prepare_host_addr, place the reset just after the two calls to new_ldst_label().
> 
> As slow path will also cal tcg_out_call_init, can we only reset after tcg_out_call_init?

No, because all slow path code is emitted out-of-line at the end of the TB.  When we begin 
generating code for he next TCGOp, we will not yet have called tcg_out_call_init. 
Therefore we must recognize this possibility when generating the branch to the slow path.


r~

