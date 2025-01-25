Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F065C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbk5K-0008HY-7w; Sat, 25 Jan 2025 12:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbk5I-0008H9-Sm
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:36:40 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbk5H-0006u5-82
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:36:40 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so74481315ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826597; x=1738431397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H+agyMelGB2jCNI0Fwtb4C++uTYNHQmyhKqcGXVAMVs=;
 b=BSuYjW77tn6IYD9z0xTDhgbxVzN0eIKuKtvpk/nanvuheVo3puHmygiXAuhvgUC5I7
 EFafZMYvgh2ldMD5kQ6vaenBW0FikltTBYYSRfE0nh9nWJkvq2T1DwTC6hQWWIT/JAS0
 6b9tR4Mdkr781yUtktPPFTdokoPq8Alf2jZkIbusEJ047dXX7qBpt2PqNNW5XZa/JRc1
 srHofrtj9z5NL3eBNdkJHH/mtY93/hFA5lWYSbxkvWjrZQVU/6Ihsyig4bHBhGEXs5Nm
 AnfAKp9jG8R9ibLdzh9/+5IAyzLryV48ikCWnDbh50lkwytEKqNzHDR13plSUeySLZ+o
 Gtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826597; x=1738431397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+agyMelGB2jCNI0Fwtb4C++uTYNHQmyhKqcGXVAMVs=;
 b=llfxHowsrVJlUrDA3ugHF3Kk93KUnadSys2i56deOhEvLLeGsPsQFpV0n6YV5FX0Ue
 R3E0OOT2L73azMwoaJC8n7bCnygLT8n3aVn1cNl/+pbWP3pb86dXL538//rCc9LDCWeW
 9+sC11pKzyl+If/y4lLPWnBDyTZ+yFnJzgz3WuV66D8S36buXilTBi9DW/+ZhgBMzgLB
 ZlHtL3uMzKnsD8Ykk4KUKdFIo6IJGDgSjUAC4VgK2q7tb6tOcPylUjfwgAP6HeP70L9l
 F5L8MIhs/9oHolBj3NVOO7znl9mi1ccyKRtwRCVM7MKnEGRdOELB3phNE05mKq8UCVjo
 h0vQ==
X-Gm-Message-State: AOJu0YyDJl/0X82UBTk7q+8BDVsX68H66B+CMqOaQ1pAfbmPkCpREzJH
 Fupd+dULMCNw8OPyPSJ7oG+MOHf1L9HMb+8UCHZcInA8wDlv9GW78JudX+LinZpH/hsAK2kZKxE
 +
X-Gm-Gg: ASbGnctxAm9MZwXUC3RkvJfg3QutAo5Rhz0EEAeE94viKwla+Os/h0UWXHMBJohUf5R
 366WLVgCRZTMeLb4gXisSN2BY6tvhl4pu2jiAXhLgw1yas527S65G8402vjCTQJdIEpmcryalXf
 qLzyuIez25/0PEi3lpcErX/KT9r7H2gpEWDhaLwSA9js3CR5RhCFm9kBXOb44OJNzxRHT2zv9Ge
 X1sxuC9BgnUBDerkpYeQ3mG0Yl+G8kpek97QgJayeMSIEyKIRIQ9o3saOqKY4pg02MhGdc13UNo
 dWIAHTQcs8KRT3CpwnrFjQ==
X-Google-Smtp-Source: AGHT+IFmkOoK9Iq58yX8PMc7ZNTrJ/p101FWFL+WVtLYdiGJ2fXarWs8JW9SLJFNSmGGH3N/2MDU3w==
X-Received: by 2002:a17:902:d4c9:b0:216:31aa:12fc with SMTP id
 d9443c01a7336-21c35563f15mr587066035ad.24.1737826597313; 
 Sat, 25 Jan 2025 09:36:37 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414ed53sm34540875ad.203.2025.01.25.09.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:36:36 -0800 (PST)
Message-ID: <16467dca-39be-4a15-af00-a1729a76cdb5@linaro.org>
Date: Sat, 25 Jan 2025 09:36:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/76] target/arm: Set up float_status to use for
 FPCR.AH=1 behaviour
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-33-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> When FPCR.AH is 1, the behaviour of some instructions changes:
>   * AdvSIMD BFCVT, BFCVTN, BFCVTN2, BFMLALB, BFMLALT
>   * SVE BFCVT, BFCVTNT, BFMLALB, BFMLALT, BFMLSLB, BFMLSLT
>   * SME BFCVT, BFCVTN, BFMLAL, BFMLSL (these are all in SME2 which
>     QEMU does not yet implement)
>   * FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS
> 
> The behaviour change is:
>   * the instructions do not update the FPSR cumulative exception flags
>   * trapped floating point exceptions are disabled (a no-op for QEMU,
>     which doesn't implement FPCR.{IDE,IXE,UFE,OFE,DZE,IOE})
>   * rounding is always round-to-nearest-even regardless of FPCR.RMode
>   * denormalized inputs and outputs are always flushed to zero, as if
>     FPCR.{FZ,FIZ} is {1,1}
>   * FPCR.FZ16 is still honoured for half-precision inputs
> 
> (See the Arm ARM DDI0487L.a section A1.5.9.)
> 
> We can provide all these behaviours with another pair of float_status fields
> which we use only for these insns, when FPCR.AH is 1. These float_status
> fields will always have:
>   * flush_to_zero and flush_inputs_to_zero set for the non-F16 field
>   * rounding mode set to round-to-nearest-even
> and so the only FPCR fields they need to honour are DN and FZ16.
> 
> In this commit we only define the new fp_status fields and give them
> the required behaviour when FPSR is updated.  In subsequent commits
> we will arrange to use this new fp_status field for the instructions
> that should be affected by FPCR.AH in this way.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm not super enthusiastic about the ah_fp_status naming, which sort
> of suggests it's always to be used when AH=1, rather than "for this
> specific group of insns when AH=1". But I couldn't think of a better
> name that was still reasonably short...
> ---

Hmm.  I should really compare this vs the new pair of fp_status that I add for SME2, which 
also do not write back exception flags.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

