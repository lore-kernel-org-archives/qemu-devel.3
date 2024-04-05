Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E2DC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsfAH-0007vX-E6; Fri, 05 Apr 2024 04:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsfAG-0007vA-EC
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:43:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsfAD-0001Zv-Qp
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:43:12 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso257908966b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712306587; x=1712911387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZ/mIGU9FzqXnysqxASs2aJf7KpUaoBTPfVK6gw/Yxo=;
 b=vbU1MJpdqPrOfHFxkFfMbVGw5hqkB8RNb6aNKZ9pD2MqBkdtYj7Hir6qplAa2kD4+r
 0dFobIFpvN9iflWAU3p/oWhdSAb14ThI2JJ5YZXX03JoEW2kXPnVqK2UKN9986YVTQUs
 uXUpRAqadwwctmNbM8x6t9MBFficAz2cLbSCwjdQuC+27wGdl7cCK8dvX/Sz1fBSpiZ9
 YzHWIic3ewOD3SutscC5qQ4cIltQzaOMXo9ELX/VuF2qjeshTs4rY+gb9ahyrECNHAAB
 488vT8ew4eXueLMUYZUs6f+GwOkNQbaNiGH9FvXUkFEmZCHEheGcNiYAO4BW9sY96EFC
 61WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306587; x=1712911387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZ/mIGU9FzqXnysqxASs2aJf7KpUaoBTPfVK6gw/Yxo=;
 b=un0fgqqY4GSuxwP+0/S5kvnj9fgmENRvpjzl/e/c+ULm7op6rjt6B5qK+XeXrVYLCz
 vXOoP18T9znLdEdlDroH1S+0EER8e/fIH3LFkkwzDn+myaAwT6URnbL0mUBmzY793Y8T
 2J+hb/aRhpQuBrxUM9CQ1exn5s7vq5p5bqqENdF1KzQQ8zYAQHo3OKkBu6kQpNMceHRg
 yxZcDf4DwbThywSBTiTLfXeJa6ndsVrqWHZG8JDl30jgJYc1DQZNxqHWMMZsxE+Zxksa
 dw6B3n38uYVmcTpz4p+X/ISsSpUqjSbtSTxuR2Js45kDrFW3IxAC6bbkDa++VrPVS1jO
 X2fg==
X-Gm-Message-State: AOJu0YwFaiDHQmPzy/8m4TVom2gw+0DtDXL0qS1YgJtCgwTfvqDuqDo0
 phm60v0Im2a/8n6GtOi4OWu/rXydsbkqRfHVh3RV9cR3mPoO4/Tq9dbm9AJxHxE=
X-Google-Smtp-Source: AGHT+IFQr5GAzdAQonz9N46Yas4fPnRzOvnntu6OCbYTm8Ew1sv/mJwfrWNxYFahoWlE+4QcFzVu9Q==
X-Received: by 2002:a17:906:4888:b0:a4e:b3f:1dda with SMTP id
 v8-20020a170906488800b00a4e0b3f1ddamr482540ejq.74.1712306587078; 
 Fri, 05 Apr 2024 01:43:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 qb34-20020a1709077ea200b00a4df78425dbsm581104ejc.36.2024.04.05.01.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 01:43:06 -0700 (PDT)
Message-ID: <90c54fc3-29e6-48d8-995b-0fa449498353@linaro.org>
Date: Fri, 5 Apr 2024 10:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1] qapi: Do not generate
 commands/events/introspect code for user emulation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <michael.roth@amd.com>
References: <20240404195543.9804-1-philmd@linaro.org>
 <87il0w74oh.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87il0w74oh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Markus,

On 5/4/24 07:35, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> User emulation requires the QAPI types. Due to the command
>> line processing, some visitor code is also used. The rest
>> is irrelevant (no QMP socket).
>>
>> Add an option to the qapi-gen script to allow generating
>> the minimum when only user emulation is being built.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Quick PoC for Markus. It is useful for user-only builds.
>> ---
>>   qapi/meson.build     |  6 +++++-
>>   scripts/qapi/main.py | 16 +++++++++++-----
>>   2 files changed, 16 insertions(+), 6 deletions(-)


>> @@ -50,9 +51,10 @@ def generate(schema_file: str,
>>       schema = QAPISchema(schema_file)
>>       gen_types(schema, output_dir, prefix, builtins)
>>       gen_visit(schema, output_dir, prefix, builtins)
>> -    gen_commands(schema, output_dir, prefix, gen_tracing)
>> -    gen_events(schema, output_dir, prefix)
>> -    gen_introspect(schema, output_dir, prefix, unmask)
>> +    if not gen_types_only:
>> +        gen_commands(schema, output_dir, prefix, gen_tracing)
>> +        gen_events(schema, output_dir, prefix)
>> +        gen_introspect(schema, output_dir, prefix, unmask)
> 
> This is the behavior change, everything else is plumbing.  You suppress
> generation of source code for commands, events, and introspection, i.e.
> 
>      qapi-commands*.[ch]
>      qapi-init-commands.[ch]
>      qapi-events*[ch]
>      qapi-introspect.[ch]
> 
> and the associated .trace-events.
> 
> But none of these .c get compiled for a user-only build.
> 
> So, all we save is a bit of build time and disk space: less than 0.1s on
> my machine, ~1.6MiB in ~220 files.  My linux-user-only build tree clocks
> in at 317MiB in ~4900 files, a full build takes me around 30s (real
> time, -j 14 with ccache), so we're talking about 0.5% in disk space and
> 0.3% in build time.

What I want to catch is invalid uses of these headers in user-only
units.

See for example:
https://lore.kernel.org/qemu-devel/20240404194757.9343-5-philmd@linaro.org/

(Actually I have this patch based on that series).

> Moreover, the patch needs work:
> 
>      FAILED: tests/unit/test-qobject-input-visitor.p/test-qobject-input-visitor.c.o
>      cc [...] -c ../tests/unit/test-qobject-input-visitor.c
>      ../tests/unit/test-qobject-input-visitor.c:27:10: fatal error: qapi/qapi-introspect.h: No such file or directory
>         27 | #include "qapi/qapi-introspect.h"
>            |          ^~~~~~~~~~~~~~~~~~~~~~~~

I'd simply skip these tests on user-only builds.

>      FAILED: libqemuutil.a.p/stubs_monitor-core.c.o
>      cc [...] -c ../stubs/monitor-core.c
>      ../stubs/monitor-core.c:3:10: fatal error: qapi/qapi-emit-events.h: No such file or directory
>          3 | #include "qapi/qapi-emit-events.h"
>            |          ^~~~~~~~~~~~~~~~~~~~~~~~~

Doh, this is 
https://lore.kernel.org/qemu-devel/20240404194757.9343-4-philmd@linaro.org/, 
again I forgot:

Based-on: <20240404194757.9343-1-philmd@linaro.org>

> 
> I don't think it's worth the bother.

OK, I'll keep it locally until I finish my full exec/ rework then.

Regards,

Phil.

