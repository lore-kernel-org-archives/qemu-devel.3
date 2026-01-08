Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3219D14881
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vde1w-0001FX-RR; Wed, 07 Jan 2026 19:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde1v-0001FC-DE
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:37:35 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde1t-0008P6-T6
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:37:35 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34f0bc64a27so1455616a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767832652; x=1768437452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhVuDw7nKxzixGdTqiXT3BElDkHpuG97RagT9ewm93U=;
 b=VxhfOeray4WqCfvR2CzyaCJPuvX0TuQOAIZXC5qJSjpwHkETKGFLKa7ByLRYPKdFSU
 uyCnOvjD43x5aDeeZv6j31YWwKnIP5b8qXxyMbp+/fxKQaKNr8zmTGCxW0+vFW7JphpG
 Bodl4TOCGZUCVBODi09Eb7h5UOc3J5z7U44LxpzHUlAJOfiWkOkJPWgjPYuh+sqrVj3C
 4bjawP5Y8E2EFDMfoV0oPOzKsUEIZPRB/r67Jm2GTPGEPyMgdI8il6PQX6aEpKcUXA3a
 8vBaAojYqPGbETPEge+1BQOtfAVUcIjjuhs3H2OIZkxpJIdi4QMJDclhZrO2pQypupkp
 NDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767832652; x=1768437452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhVuDw7nKxzixGdTqiXT3BElDkHpuG97RagT9ewm93U=;
 b=aKT7+/1/BaOurcpNyePErf82RKUhjA57X0y6aYbG8CM/R7yPsHfJ4pYh5S4qGyhdER
 DwOELQ/o/Xy7dDo7AdHhbVuYl6tq4KJoS+oztHsW5hevcEpeceuc4/ZvpfZisZcp2U1p
 ew2yMMgpEZWrCQj/bIEaHb9oNbDs+hLewmyNuJcj6Wf84FRTehageS7lVyP8bPEjtTtw
 zxY/ruGBo/lTo0ivG8cPhKvlyMjtATSr2UEOeM0Kjn0j+ICcG/e1Q2r2XGiNqJr9NPTn
 +3nAI1oiuKeKbTSbnYkfuE+2G2zB7XsB5e4X+HtZx2mIjBKAF6DCP0URKnapnkVl7DAb
 7IQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh65JJzpO30d3P+msCvOaVesWO9I8IFblNXlUdZWDzSxZdCNUC0iWmw1tiT11WLIlNzOtv6V1QFTrT@nongnu.org
X-Gm-Message-State: AOJu0Yw4SdYh/62stebNZXkIwq/0rFCEK6Wyl5XNdk0KWeZHM9sNemnc
 MNaPpXpJP9/isK/GHKe0koTYlFhpm8x9v3ANfec2x60xJViRsr/MlVOMUKfSkjkQncM=
X-Gm-Gg: AY/fxX6+LB2qismejzumIdZZ/yrmrfFexo4Lq3Hd0PPekSuy6NapQ6+sV9N73BTrOXI
 8MmiUzp7NAaXhImR9OZ4qOvPyNLWo2RRxN0AecRhTQjPXXfHJwWqlA7m9grXM+iZp+XoRsla3qP
 1eplg3wPjfBNJsKCELIulLT156f7yyqFrjlSoWDGJIwqdlCMY6PKIhdFseG5iHpuiG++rZTLvil
 b8v99cNhFKWCn42dmPQvcofdTKYJoAoZG7uxKoTaSirWANIJ281BFyUUOEL8/REl173LMyCUcXk
 psaQQ2Ecb3PshcMRNG6Gl3dvDZJc6FrvX1w/ybVCnMUVEhM/kI02OX/wcxT4H2rjCp2qkSzbxIs
 sw8N8aoj9MQCEaC7c/XtTyq0izA8+sdRgF1uBtQOx/91VAFzyz6i1Vb8OL43QHCxRfGxPeVvFPm
 8/xQop1AWHQwPw4HVY7xYFIu0aI0YVVW/H0XKx1ynf1APdrfKGcgYC3fcAyy6Sj5yUDdk=
X-Google-Smtp-Source: AGHT+IGfHu0a5u7biRGAbDjZgqMj2FcYJ561GO/HG+t0naZwJIyPG2dGNXlMA9IUrC5YBChys9wo1w==
X-Received: by 2002:a17:90b:4c46:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-34f68c27d35mr3899413a91.31.1767832651692; 
 Wed, 07 Jan 2026 16:37:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c50347bc321sm3843932a12.18.2026.01.07.16.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:37:31 -0800 (PST)
Message-ID: <ecdde557-27a5-4def-aaf7-d021c24e921e@linaro.org>
Date: Wed, 7 Jan 2026 16:37:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] monitor/hmp: Reduce target-specific definitions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20260107182019.51769-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260107182019.51769-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/7/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> Move most of target-agnostic definitions from
> "monitor/hmp-target.h" to "monitor/hmp.h" to
> reduce files target-poisoning.
> 
> Philippe Mathieu-Daudé (2):
>    target/i386: Include missing 'svm.h' header in 'sev.h'
>    monitor/hmp: Reduce target-specific definitions
> 
>   include/monitor/hmp-target.h  | 28 +++++-----------------------
>   include/monitor/hmp.h         | 23 +++++++++++++++++++++++
>   target/i386/sev.h             |  2 ++
>   hw/i386/sgx-stub.c            |  2 +-
>   hw/i386/sgx.c                 |  1 -
>   monitor/hmp-cmds.c            |  1 -
>   stubs/target-monitor-defs.c   |  2 +-
>   target/i386/cpu-apic.c        |  2 +-
>   target/i386/sev-system-stub.c |  2 +-
>   target/i386/sev.c             |  1 -
>   target/m68k/monitor.c         |  1 +
>   target/riscv/monitor.c        |  1 +
>   target/sh4/monitor.c          |  1 -
>   target/xtensa/monitor.c       |  1 -
>   14 files changed, 36 insertions(+), 32 deletions(-)
> 

(in private),
build issues:
https://github.com/pbo-linaro/qemu-ci/actions/runs/20792272184/job/59717050408

