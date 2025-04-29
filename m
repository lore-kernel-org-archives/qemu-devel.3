Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9q7f-0005VG-0S; Tue, 29 Apr 2025 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9q7b-0005UE-8r
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:55:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9q7Z-00075C-3T
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:55:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so5372124b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745952955; x=1746557755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K3SuFLGTtogyg7vg1eSzZQaVCLT+ooyWhAiOCOi8ghU=;
 b=ljNUBrCfPkkYP8PmV4qjdaQ9h2oWUm6TI1KSi3SHbwfFENeLbdiLxolPtA6BG2f/2L
 0Xn6iXFZYXRv5hmPN2EV7/PsoLQ9uamsXEMIKH7YEKzbZQJ6ohn2xeaNDg6NajkAYlVY
 9/+C1jaIWlkw+fYWH+RvTQC3KvUMelG5naJ9cHqIy8UyovKflkPEt8FuZHMr5uKzF4PM
 OuEYSvwubX5Sr32bNhyPmghTdlKI8BPUyBlIAvxjVqg00zqx+6RE1RQz2ieLk/3W5WBQ
 fkZfRJES9YlU7YSh6f6YCGtkdVUqQiHMrpxJam0+yd3VocKbp4P8n3ZxSk1T1L+HYEmT
 Ne2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745952955; x=1746557755;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3SuFLGTtogyg7vg1eSzZQaVCLT+ooyWhAiOCOi8ghU=;
 b=pON/83Bo+By4TZhdCAk73edE0JGu+iO+e2Tc8XCiGrHaTfbD4d7OntZX4SHEY9krj9
 d608SQg/e/9+flJDBYLN1fD/t6Ik1xIykxGAv2ksr0aJa2aCKS1ySdnuSdWw2NzNF9of
 6G9Mr/JkY07vJjAClQAOjgvFty1WESAvKseWJ6f7jpLFp/M0ZAqrGHkj/DuisuMJ+zCv
 HlUbLU7Zyaz1MNcyeXWFGKEBL6bmt6gjOmdXtto4/Q0TE3dfv6ERbEAxPqLMmfxsc0eU
 vGeuHDBpTUWDRvc7h53Ygqegp1c1L+hWCQ8tzCU0V/UBOZn2kTEWDC1vs/av5NJmbjFH
 UnNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQwWIuVPQhXFDV7D29sxaMgezkXqh9YwPkrlE/XF/IPNCZgWb9VchvqosQWqPtptme8HOhCjMDkRXk@nongnu.org
X-Gm-Message-State: AOJu0YxmAkUDAbAD31EluJXFhXfBzX6ZtcqWgl3xfekS+cAWuJ9qk4vH
 ZKxTyQ9qXcyiC9PzIjxqIrBHx/BjppxJph0lYJOtw5pHFNPnY4MpXdFNBlvo7W5YNuAurUzHHQd
 R
X-Gm-Gg: ASbGncv5UOySKQaT+NZtn/Tq8Cep0XaM7mH65LI7i/yfuaa/Za2nQczLgCGWvQ4Dcbh
 bW+Y8m3Fus15J9wjSk50nf5nrOK3CC12yPd1QMZbcSEu0TjOJXrAFxiZL+XhcGEaCuzU1lXZrTy
 nxM1W9JMxFiCDNiuOxUrp4d8KZUGAHDIEBEZVQc3RLzfsIU5NARrWBGC+Y0sTEEvziIIL2WFbL8
 +8DcUFeX/xBznWetiVdEQ9o7TZLp2bSurSWcE4JPitNhbi3vYBzgWTtrX4In8rkG1PP4uy7xF5a
 NkovhXMqIQt3/dR3rHoXn68tZm++AOMJSlxOdgwp2fPhsSHWchTPTisJg661JZO7JGCQSqen7z3
 hqJWtjLE=
X-Google-Smtp-Source: AGHT+IEiaZ9byIMWIACxnsV/BViRgJMMFcFVr+Vp02SJJMMRE2AWl/e1jXGslXmjJWqicwYq08bHmw==
X-Received: by 2002:a05:6a00:3917:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-7403897788cmr446622b3a.5.1745952955329; 
 Tue, 29 Apr 2025 11:55:55 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7403991f046sm13691b3a.41.2025.04.29.11.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 11:55:54 -0700 (PDT)
Message-ID: <1d3bc5b5-1bd8-4f18-9da4-db82f037e5de@linaro.org>
Date: Tue, 29 Apr 2025 11:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
From: Richard Henderson <richard.henderson@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
 <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
 <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
 <db0b8cff-b79f-4f4f-8322-c9f41462cdd5@linaro.org>
 <ad2a2ba6-04c2-4618-9003-47625d31b365@linaro.org>
Content-Language: en-US
In-Reply-To: <ad2a2ba6-04c2-4618-9003-47625d31b365@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/28/25 15:37, Richard Henderson wrote:
> On 4/28/25 15:26, Pierrick Bouvier wrote:
>> On 4/28/25 3:07 PM, Richard Henderson wrote:
>>> On 4/28/25 15:00, Pierrick Bouvier wrote:
>>>> On 4/28/25 1:10 PM, Richard Henderson wrote:
>>>>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>>>>> index f5e5746976..8dbe79ea7c 100644
>>>>> --- a/include/accel/tcg/cpu-ops.h
>>>>> +++ b/include/accel/tcg/cpu-ops.h
>>>>> @@ -18,8 +18,13 @@
>>>>>    #include "exec/vaddr.h"
>>>>>    #include "tcg/tcg-mo.h"
>>>>> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
>>>>> -                          uint64_t *cs_base, uint32_t *flags);
>>>>> +struct TCGTBCPUState {
>>>>> +    vaddr pc;
>>>>> +    uint32_t flags;
>>>>> +    uint64_t flags2;
>>>>
>>>> Could it be named cs_base instead?
>>>> flags2 is a little bit generic.
>>>
>>> Of course flags2 is generic -- it's only cs_base for x86.
>>>
>>
>> It seems to be named the same for other architectures as well,
>> so it's wrong for all other arch too?
>>
>> My point is that:
>> tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);
>>
>> is error prone, and it's easy to swap flags and flags2 by mistake.
>> I don't mind the name, but something more distinct would help.
> 
> I fully intended to go on and pass in TCGTBCPUState, rather than 3 separate args.  I guess 
> I stopped early with the meson.build change for build twice.

You do have a point that it's still named "cs_base" within TranslationBlock.  I'll keep 
the cs_base name for now and rename it all at once at a later date.


r~

