Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95D7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 19:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfPcm-0001Z5-Bl; Wed, 28 Feb 2024 14:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfPcd-0001YO-FM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:29:44 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfPcP-0003kw-3A
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:29:43 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e581ba25e1so80897b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709148566; x=1709753366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8ZiWsC8PINTqPkkUEiU/R/W7k1D0patBmwZVGT9M38=;
 b=R0nVsVYzL574nn1BeyUxNwVs1RmED3irB/FtAWHXqnuLcAfPrYFES8lKnI4YTwL+BX
 aHOwUHYL8069a87aiQh1qmpx7SsLtLVtrGdTxDzzm69gAZLITm4SasV+ik+T2KpTC43w
 62M1oxelP1VSm4NbeJggBM67aWM0+Caz1sqRMDmRv0sfzbo15ImhaCfvzs+en+Zg8IQS
 6nhq5ZXsIW0psjYxF1fy/8xUwUjfwUefiC2Jq6NGVtmlDoJHiwj8S6aoZq71nwF5GEd+
 4CnUC7Op7IOaFvyJWIGodjF9MO/sPS9lOJRD6X6LvNPFsMRibJ1+yxHCPbOjo1lMRG85
 H62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709148566; x=1709753366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8ZiWsC8PINTqPkkUEiU/R/W7k1D0patBmwZVGT9M38=;
 b=Abb77yTpkdV/GYrBUGsKkvvMleFUt420dn+HedCkyw2ldwk7anYo4TCIXhYISeu1z+
 MQcFkqSnvdl+Mca3uvklsxqAdASDP6gfOyF0z67KWbxqZriPEqIFp5pTHU+bGl3ejUyz
 YS6Ry4oKRSBX/ZMxvDr8FSaXCYjo+Tyg7qYBXGDpVGYr2EFoUFrNxuX5BY+dasZUDJ/t
 yvmX8ae4/eOhEA9Kd2H6ZQHC4kHLEfYFKL1jZHBwCRbqCoz8s0hXO6ywF7qlgqTar/Rn
 egtxEfadZPH0iz4Xd0Q5PBQmTA+N8YiQ8tl7VP05X/FCVUdpY892WupDg0EnAYRzffFa
 UuKA==
X-Gm-Message-State: AOJu0Yz+3FsQiU+JMDBEsfUDP+xUrd+pDLceRcU0f2GZOzYeEfhu2wmp
 UnDaiDiYhCCxmpQXFiMMhr7MvxSAyYw2GeXidA/se+jfRs6twOG1JqtQ+h1Kw70=
X-Google-Smtp-Source: AGHT+IF3RHvMYadZCOyEL0xFkZZTQb6nQLWLwC8JKdZ4O/pWnFIWD5eEiuOx2gGCFjAU/0IPv3opQQ==
X-Received: by 2002:a05:6a00:2da0:b0:6e0:df2d:e7fe with SMTP id
 fb32-20020a056a002da000b006e0df2de7femr159083pfb.11.1709148565721; 
 Wed, 28 Feb 2024 11:29:25 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 e24-20020aa78c58000000b006e50cedb59bsm64918pfd.16.2024.02.28.11.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 11:29:25 -0800 (PST)
Message-ID: <86e5043a-ec20-4e8c-84bc-e63ecb982bff@linaro.org>
Date: Wed, 28 Feb 2024 09:29:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: fix uninitialized variable
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240228110641.287205-1-pbonzini@redhat.com>
 <1f179ee4-cab6-49c8-a625-2ac9dbe4e3d2@linaro.org>
 <CABgObfaZPp_wAE4u70+_ShmtFpEf69RjyRyqZEQ8TjDkue_Q-g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfaZPp_wAE4u70+_ShmtFpEf69RjyRyqZEQ8TjDkue_Q-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/28/24 02:20, Paolo Bonzini wrote:
> On Wed, Feb 28, 2024 at 12:19 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 28/2/24 12:06, Paolo Bonzini wrote:
>>> The variables uext_opc and sext_opc are used without initialization if
>>> TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
>>> on the compiler, might be the generation of extract and sextract opcodes
>>
>> Shouldn't compilers bark?
> 
> I expected that too...

Weird.  Anyhoo,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

