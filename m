Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5F6C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXXOY-00026H-1j; Tue, 06 Feb 2024 21:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXXOT-00025Z-K9
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:10:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXXOG-0000BV-3f
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:10:33 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so84710a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707271818; x=1707876618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVQKN/Pi5kHdlmu4AcjjVSVeVN6r0rU/9RwRvbWg3Z0=;
 b=edNGb1audfszmPie/yYSY3G2FTJE+JiWgGu/TPZ0O1sfEv1LfdbvHWvUE5cGkFKf8X
 g6oQTpiB8txZNUXzLTGxwbm2TCKHZYSpSXfOh4rT1xLyZ8KtNaRC/zYOs7CXrdHIpwdV
 9rRNaPleTjiTGgMitVw8MSaxsXHfhoxlULJdFz8Zj6H2g8q5oYx5366SRUArwrCFFPAu
 UfgrEO5fwjKFE4Nb259BL+Vxv+wF1dcvoP79+5Z4S70ZRQdpmf2iao1r1ID5hggrBAtm
 jtXjNwSLtBwvUJrS4AVNHzONSJzatoFvv3PgR1dWF2d5z/RnmcMY6i8ii3QCTVSn1bkI
 gEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707271818; x=1707876618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVQKN/Pi5kHdlmu4AcjjVSVeVN6r0rU/9RwRvbWg3Z0=;
 b=cspoOc8K/OvEB5qJQi/Il6ZsrB8kwR0cExt2CKocjV2EVUcxw/apSlx0j1SPgmmAc5
 IMsHNuMdCh0CHRfEU+/83TQLNKBjdFSlJMOy/LU9r14ZRIVCx8JmRFnjXRWhpWzmCuOp
 V2AMgYqq0rKktpOY00wQ2X8sVrMFN4OS9WtA5NpNRaUOyBhwg1WEjjS7hDesGzI/jpAz
 wtXhKVczmOJfqEIVvxlCU0P2xZYzaSesakNbHca14bwcuOTgJVwMrojpO8wXCKaUcO2b
 prsGH63CyCuNA6PwxUGfEc87RNQk0zgUG3J7EmbJt8S2HRDsqa64PRI+tRibcnrb9MRy
 CWMA==
X-Gm-Message-State: AOJu0Yy+NZF3Zgiy6iLrXzdbkH00iin/g8muMiBZd6+Hkc0E/mUhIYAm
 QiaaQQ5CxTg5EYE6+289U2NgE57/HApRuGPIQGc6tCTy4O498mYu11t55/f+kX0=
X-Google-Smtp-Source: AGHT+IEygj9i+Mow0bgAwAORug8a3JjkCSd976MJ4bJwepFgX6NB3iRkgZtwoDaX3URQQ2jjIkbgyQ==
X-Received: by 2002:a05:6a21:2d86:b0:19e:9f2d:9818 with SMTP id
 ty6-20020a056a212d8600b0019e9f2d9818mr2058491pzb.57.1707271818288; 
 Tue, 06 Feb 2024 18:10:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWd85tV07kuOwngxEoHDV0qR2G6YXMBmCgv63M3LBtxbcU6Tb4QkXxuUglNFeOJy/kh2G3T/zlKp5jz4UQRf9TdpjpFby/LCo7PRRx1KTeOFc5R2wCW/ZKZZVCnBAd2
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 sl12-20020a17090b2e0c00b0029649f4ceb9sm244090pjb.54.2024.02.06.18.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 18:10:17 -0800 (PST)
Message-ID: <4fee3af5-eeab-42b8-b5e0-1f36235ebc3d@linaro.org>
Date: Wed, 7 Feb 2024 12:10:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL
 for FEAT_MTE3
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-2-richard.henderson@linaro.org>
 <CAFEAcA8AuQZNbT=7WFXVPDzDywPPp1YZ=Bkow7Dgq2pC9=9X-g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8AuQZNbT=7WFXVPDzDywPPp1YZ=Bkow7Dgq2pC9=9X-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/7/24 00:23, Peter Maydell wrote:
>> +++ b/linux-user/aarch64/target_prctl.h
>> @@ -173,21 +173,22 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
>>       env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
>>
>>       if (cpu_isar_feature(aa64_mte, cpu)) {
>> -        switch (arg2 & PR_MTE_TCF_MASK) {
>> -        case PR_MTE_TCF_NONE:
>> -        case PR_MTE_TCF_SYNC:
>> -        case PR_MTE_TCF_ASYNC:
>> -            break;
>> -        default:
>> -            return -EINVAL;
>> -        }
> 
> We should probably check here and reject unknown bits being
> set in arg2, as set_tagged_addr_ctrl() does; but the old
> code didn't get that right either.

This is done higher up in this function:

     if (arg2 & ~valid_mask) {
         return -TARGET_EINVAL;
     }

The rejection of ASYNC | SYNC here was either a bug in my original implementation, or the 
kernel API changed since the initial implementation in June 2020 (not worth digging to 
find out).


r~


