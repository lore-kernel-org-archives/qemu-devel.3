Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0p4-00012z-CW; Tue, 28 May 2024 13:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0p3-00012W-31
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:41:17 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0p0-000589-MP
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:41:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f44b4404dfso9860285ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716918073; x=1717522873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b8regoAjpO+UU6Vl5OocXpkP0xE6mgOtLUjS45BneZQ=;
 b=ysoSJD9qlUNkUp7Pbbll1WvDaOUMz7p5FYlEbNkbdXK4mO9QkZgewkPEBluhuhxlRl
 SX8DS7/I7JdUlfNf00OX6MsbPqbgF1MK5lmUBjxA33Utts/5KYgc1Pw344ufPQs/Mb17
 eqi4OyywFCbYcsrc7fpnwf5Nfb0I6KhMfHzBZ/kIr/8g5oDNjKXd1vZ+Ux/tMKG4WfpV
 kDWjPvmxfShgA1UIaanbJKPVGajX//iOHuYiZEdrWsBzEBA1Sz2/DK7+ldfAht+jDwx0
 6Jy/VDaMKPyKrrZYAD8ixUBo1A1yBKc3I89lca6eT+aLw1Be5xRf7wlcF1hRV9uvBWcK
 0sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716918073; x=1717522873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8regoAjpO+UU6Vl5OocXpkP0xE6mgOtLUjS45BneZQ=;
 b=sMhxVb/TRvlT0ZZKQbB/rCOLI7igIkAPANtVP2zhrJG0xF3CAAllzrM/Y0NnCGjnUn
 0WGgwoLP9QDlHMiqrsKOWyugdRW0XnCV+8YSrc1LuybFV3Ip0WJQxwD8PrA1Lkqf5JCo
 2ucjo33fzD7coFcIKSkvsyGFzPKH68ttIzR2+Lwj0UcJcIDFsqN78W1dYYqt28LRDddl
 hb0K/Y/TclFim66bfwkirrrYLxL1/HYLxKwRktJqje8Awc3ZMkz9u9WggJ5gbPz0HXzp
 9g674NTGfntkmEE+Yy/hGR0dVmhEUJFVckQX72gb08pu8XBNHUQ+BMLkagtQM1I836iV
 6OSA==
X-Gm-Message-State: AOJu0YypmgUBc4I1RZZfnI6cXsRfa/mKo5GlpwlttqTroV8flvBDoBO4
 vyqM6ndeGjpeDSj+fU+9NbpmjfH2VSLPJGDLbPbyrbsFusgUxnXQC/ZI0Df7+TI=
X-Google-Smtp-Source: AGHT+IGP4ZVnfDSSEBjXj7nDbJPFoO6MptU9j0nGAo1JkL4AmzwXHScBC2iHf26Zq7t4GJdWNwY0yw==
X-Received: by 2002:a17:903:1107:b0:1eb:d7bd:c0d0 with SMTP id
 d9443c01a7336-1f4498f2a5dmr143226965ad.60.1716918073124; 
 Tue, 28 May 2024 10:41:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c968516sm82990535ad.179.2024.05.28.10.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:41:12 -0700 (PDT)
Message-ID: <6db11e9a-34c4-481f-938d-df8e3c2decb9@linaro.org>
Date: Tue, 28 May 2024 10:41:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/67] target/arm: Convert SUQADD and USQADD to gvec
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-39-richard.henderson@linaro.org>
 <CAFEAcA9oBzyrjBKcX6NdkDGde5YJzfHUYpPKfx4w20KaqhpS_Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9oBzyrjBKcX6NdkDGde5YJzfHUYpPKfx4w20KaqhpS_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/28/24 08:37, Peter Maydell wrote:
> On Sat, 25 May 2024 at 00:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/helper.h            |  16 +++++
>>   target/arm/tcg/translate-a64.h |   6 ++
>>   target/arm/tcg/gengvec64.c     | 106 +++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-a64.c | 113 ++++++++++++++-------------------
>>   target/arm/tcg/vec_helper.c    |  64 +++++++++++++++++++
>>   5 files changed, 241 insertions(+), 64 deletions(-)
> 
>> diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
>> index 093b498b13..4b76e476a0 100644
>> --- a/target/arm/tcg/gengvec64.c
>> +++ b/target/arm/tcg/gengvec64.c
>> @@ -188,3 +188,109 @@ void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
>>       tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
>>   }
>>
>> +static void gen_suqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
>> +                           TCGv_vec a, TCGv_vec b)
>> +{
>> +    TCGv_vec max =
>> +        tcg_constant_vec_matching(t, vece, (1ull << ((8 << vece) - 1)) - 1);
>> +    TCGv_vec u = tcg_temp_new_vec_matching(t);
>> +
>> +    /* Maximum value that can be added to @a without overflow. */
>> +    tcg_gen_sub_vec(vece, u, max, a);
>> +
>> +    /* Constrain addend so that the next addition never overflows. */
>> +    tcg_gen_umin_vec(vece, u, u, b);
>> +    tcg_gen_add_vec(vece, t, u, a);
>> +
>> +    /* Compute QC by comparing the adjusted @b. */
>> +    tcg_gen_xor_vec(vece, u, u, b);
>> +    tcg_gen_or_vec(vece, qc, qc, u);
> 
> With this kind of code where we wind up doing a vector op
> into vfp.qc, is there anything somewhere that asserts that
> we don't try to do it with a vector length bigger than
> sizeof(vfp.qc) (i.e. 128) ?

No, but I could add an assert to the top-level expander below.
(In this case gen_gvec_usqadd_qc.)


r~

