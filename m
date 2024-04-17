Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC99C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 00:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwtHE-0008CR-7U; Tue, 16 Apr 2024 20:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rwtHA-0008C2-Gs
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 20:35:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rwtH8-0005D3-Gv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 20:35:48 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so3179347a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713314142; x=1713918942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmX4cVH0tVfyV2GWZ5kBMxrZNdNp4L35gzxUJU0zvu8=;
 b=At12zf6zeZfyptc2soingrYIuLckL6qGjy8HplRdCdcgrvf9vhx6+vh6iKWg2TFL7R
 M6Kch9IQzlisC5cvUcSjsetQ253KbPNQreUmMUqm2s7Ka47uvv/hkPcY5N/uXLAPyzs2
 zLNkUv/HcVfTU5KGhwF0y/H2I4AEjWIvC18624H2yGIb7eD03xER36bbbgNu7Ac1odcT
 5kh2MGUnRUnxLniYB8YLd+Yv1EYuAS1fyxtoOM5q6oDIpOk0e5l94pnfqy82B7TKdaxF
 5Fc5qY9bsSb/j743pZKGIjkK+aoT0l9xSdC5Q0TW/zxTN/NBdvVymxXeukHvsyYsYACz
 zfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713314142; x=1713918942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmX4cVH0tVfyV2GWZ5kBMxrZNdNp4L35gzxUJU0zvu8=;
 b=O1MhKJv3UzgXYkhIVPSErapKu0QZ3N2u9JeaIATlk8+kPaPNtOZntkd8K9Ieua8iqA
 2kIHvWmA+c/83bNCIs7qNMJpucQsoyYT8l+SuS6MsC3UlW2RDRCj2fWbbRvpA9YuWAef
 8yaogQl9du9Nk7Hfv1asdgg7cuvpBpYMpuasANYlP8bUZhD7UFEyGy6gf4oBV2hs0DSl
 wu931Ygs0yCiPA7a/I/hL1kD3ZFohW9/D1LDJNKBxH3w1jpt5yxAL03wcTJkj8OffgpI
 fDpLs9rijvKZhidBASGUWRMxYvrnzElNySnOb4cmT1thN0w/sEt/Vp/S4YRIESZtIly8
 QZaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTJGYAuzIrJ7pU1VyjDnmvSm9Rdu97mET56LFbjNwlUvJ/xJnByXvtPu9eexnv+METpaL37AX42kfpTpJEIUkHCfwZJeo=
X-Gm-Message-State: AOJu0YyYocXgrA7JVdtzApeUjmBVUQegVYRX9Q11Vws7KvSAHpZJ5N7W
 slYfitWu2hslcMU2+E1y+QmOnkX3Q1wDh3hhVoTlYRQEQ+A4ub6BuDMKAHqi8fw=
X-Google-Smtp-Source: AGHT+IFFz1g/ejUpqjyXHVroCJGnQjH41zYJO4IHdF4SrIciTkyEYJzhfpyot8fE6mUCPkkKUshfXQ==
X-Received: by 2002:a17:90b:1d07:b0:2a1:f455:c3d7 with SMTP id
 on7-20020a17090b1d0700b002a1f455c3d7mr12558398pjb.16.1713314142279; 
 Tue, 16 Apr 2024 17:35:42 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 jb20-20020a17090b409400b002a22ddac1a1sm205144pjb.24.2024.04.16.17.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 17:35:41 -0700 (PDT)
Message-ID: <c55a1d2c-bae0-44b5-9cd8-3df1b33c31ad@linaro.org>
Date: Tue, 16 Apr 2024 17:35:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] plugins: Use unwind info for special gdb registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
> ("[PATCH v2 00/21] Rewrite plugin code generation")
> 
> This is an attempt to fix
> https://gitlab.com/qemu-project/qemu/-/issues/2208
> ("PC is not updated for each instruction in TCG plugins")
> 
> I have only updated target/i386 so far, but basically all targets
> need updating for the new callbacks.  Extra points to anyone who
> sees how to avoid the extra code duplication.  :-)
>

Thanks for the series Richard. It looks good to me.

Besides reviewing individual commits, I have a more general question.
 From some discussions we had, it seems like that previously gdb stub 
was correctly updating all register values, and that it has been dropped 
at some point.

Was it for performance reasons, or an architectural change in QEMU?
Is gdb stub the right way to poke register values for plugins?

I don't know exactly why some registers are not updated correctly in 
this context, but it seems like we are trying to fix this afterward, 
instead of identifying root cause.

Sorry if my question is irrelevant, I'm trying to understand the full 
context here.

Thanks,
Pierrick

> 
> r~
> 
> 
> Richard Henderson (7):
>    tcg: Introduce INDEX_op_plugin_pc
>    accel/tcg: Set CPUState.plugin_ra before all plugin callbacks
>    accel/tcg: Return the TranslationBlock from cpu_unwind_state_data
>    plugins: Introduce TCGCPUOps callbacks for mid-tb register reads
>    target/i386: Split out gdb-internal.h
>    target/i386: Introduce cpu_compute_eflags_ccop
>    target/i386: Implement TCGCPUOps for plugin register reads
> 
>   include/exec/cpu-common.h     |  9 +++--
>   include/hw/core/cpu.h         |  1 +
>   include/hw/core/tcg-cpu-ops.h | 13 +++++++
>   include/tcg/tcg-op-common.h   |  1 +
>   include/tcg/tcg-opc.h         |  1 +
>   target/i386/cpu.h             |  2 +
>   target/i386/gdb-internal.h    | 65 +++++++++++++++++++++++++++++++
>   accel/tcg/plugin-gen.c        | 50 +++++++++++++++++++++---
>   accel/tcg/translate-all.c     |  9 +++--
>   plugins/api.c                 | 36 +++++++++++++++++-
>   target/i386/gdbstub.c         |  1 +
>   target/i386/helper.c          |  6 ++-
>   target/i386/tcg/cc_helper.c   | 10 +++++
>   target/i386/tcg/tcg-cpu.c     | 72 +++++++++++++++++++++++++++--------
>   tcg/tcg-op.c                  |  5 +++
>   tcg/tcg.c                     | 10 +++++
>   16 files changed, 258 insertions(+), 33 deletions(-)
>   create mode 100644 target/i386/gdb-internal.h
> 

