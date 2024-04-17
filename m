Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66089C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvDn-0007nV-Sk; Tue, 16 Apr 2024 22:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwvDf-0007jm-5X
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:40:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwvDb-0008Mf-Q8
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:40:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so2890834b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713321613; x=1713926413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5fYP9arSrEpl1/pH5zfPyK6DgIzF3ocBunn/1aci+BQ=;
 b=fEXYhTEzogb/5p8ZUuvZPyGanv8emo/tp5EgGCVmnhqInusz032zrMuBfO9kyN05/x
 xLleTewyL3ByUsPIvq9abwlZTze5NsGlr+1oHgntrpT6K8Fbedf39hRR+UkGsbpN4UMa
 DzgmERUgzdu6i0usyxw5bQLfw1PVC8/Z/GYz9RkW+zUjDLm2WEekgAuRmD9EiN6HCJ/W
 Yc0yBmjbQdiQk7TdFQbB9n0WdEzdae1oc610/dmiYSA4inidCQIQih469/HGcCWkpgaO
 s7fGVc4vG5Y51G/HmiyBsZiTtGj1Ia1IG37sx6PWU9IJs/C0WNStt1SwXfh5GjWcGBzo
 2YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713321613; x=1713926413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5fYP9arSrEpl1/pH5zfPyK6DgIzF3ocBunn/1aci+BQ=;
 b=Dc2DRUMZTRXfVcuIJtMlAKivNjAfqll6G1P7PUVjFnm8FbyJmljjW0XmHZA4nyt0kH
 Cq3u617ZZVs9jX5vWfXmsCSRRgTrUWpFUlV6fTk6ybZS2du1G5WME/v9Gjljr4HJcuqW
 jz7+zHPa2swkOnBzQ4PTbFmIp3OxwjQMuNZjEmnNKzBupHbnSxfMnvw0VGrh8ZXi0jq1
 NACXgeCS11z10hIgPnblB8HPjijZX+OEA/z/pFxpbkAIpMwo3ety3xgKDOuu1i+kHqBv
 SvpU31qGbvGphI+wjOqgnLsgBjTn1Ho0HotwkevmkBYUNhp9TV2TZ5vgv2/PP4/URipo
 NxEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDAcOv8nz+omQPjajNYE7ZXYHwnlZ0z1nhvwP/hzeNDIE8P1Sf+/a9ilpBcscdTxEMGftscIyFkNUw5HV3qxieYyCTiJ8=
X-Gm-Message-State: AOJu0YwO+VQl+78JX626GZfY7phLNX7VqffixJurWfVeIueAov+/M32T
 zlm9b9tRVAAeupxns6z7zMgS7Jb876Fb0umCEiLN4IgJswxXDynDFDBpjo2SiYm1akWk8SyA1Ji
 9
X-Google-Smtp-Source: AGHT+IFr3p6jfHuti5jbfx8S20oZ8/YbAtXRPb60SmT/+pbxB0FH0lp3M2YR56a4CUF7d3tsVealjA==
X-Received: by 2002:a05:6a20:3953:b0:1a7:9886:4bad with SMTP id
 r19-20020a056a20395300b001a798864badmr16393612pzg.2.1713321613171; 
 Tue, 16 Apr 2024 19:40:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902c24400b001dd578121d4sm10479365plg.204.2024.04.16.19.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 19:40:12 -0700 (PDT)
Message-ID: <91735cdb-0620-4fc6-a19d-08ca29acd9ff@linaro.org>
Date: Tue, 16 Apr 2024 19:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] plugins: Use unwind info for special gdb registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <c55a1d2c-bae0-44b5-9cd8-3df1b33c31ad@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c55a1d2c-bae0-44b5-9cd8-3df1b33c31ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/16/24 17:35, Pierrick Bouvier wrote:
> On 4/15/24 21:06, Richard Henderson wrote:
>> Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
>> ("[PATCH v2 00/21] Rewrite plugin code generation")
>>
>> This is an attempt to fix
>> https://gitlab.com/qemu-project/qemu/-/issues/2208
>> ("PC is not updated for each instruction in TCG plugins")
>>
>> I have only updated target/i386 so far, but basically all targets
>> need updating for the new callbacks.  Extra points to anyone who
>> sees how to avoid the extra code duplication.  :-)
>>
> 
> Thanks for the series Richard. It looks good to me.
> 
> Besides reviewing individual commits, I have a more general question.
>  From some discussions we had, it seems like that previously gdb stub was correctly 
> updating all register values, and that it has been dropped at some point.

Normally gdbstub does not run in the middle of a TB -- we end normally (single-step, 
breakpoint) or raise an exception (watchpoint).  Only then, after TCG state has been made 
consistent, does gdbstub have access to the CPUState.


> Was it for performance reasons, or an architectural change in QEMU?
> Is gdb stub the right way to poke register values for plugins?
> 
> I don't know exactly why some registers are not updated correctly in this context, but it 
> seems like we are trying to fix this afterward, instead of identifying root cause.

The one or two registers are not updated continuously for performance reasons.  And 
because they are not updated during initial code generation, it's not easy to do so later 
with plugin injection.  But recovering that data is what the unwind info is for -- a bit 
expensive to access that way, but overall less, with the expectation that it is rare.


r~

