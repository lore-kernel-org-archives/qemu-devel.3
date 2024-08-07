Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D7DC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXdK-0006hm-I3; Tue, 06 Aug 2024 23:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXdJ-0006fj-3x
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:46:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXdH-0003N3-Kn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:46:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7106e2d0ec1so1080484b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723002397; x=1723607197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DU9Z0oz7hUaX+wBucwe27ucxf+vT1gzmbJasnsJcjc=;
 b=A4XqNtRdsO8EimokQgssS1P3cdRLOCjzOO1WB17xtiwvPUuRhnIEMx5cbDXqymZZuz
 k9Feqi58PrP6Tqk88b5BcAqzCybzGKqo6s/xrI88D3kB1Pt81G0NAWgQxnDF7AdMs/o4
 BzR5JRl4VxQExEDv4Vp80Y7F6/Wi0+N7hL6EaxOSXu3kL+CT+2lSInLDdTxDN0VMTtWe
 Am9yO1avw4/Nto/Qdmk84CmFHS+a8hhEo5LcV7XruyHp7UdLYrRICJJkQWZDyi7pO+/Y
 lWNYwcZm8js+CT3ltzPCCNAOHb+B6UtIbMTbO7t1p69RLaiOxJ5HAN9QkhoujIFwmhPE
 gb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723002397; x=1723607197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DU9Z0oz7hUaX+wBucwe27ucxf+vT1gzmbJasnsJcjc=;
 b=Yo+yU+jIKlJO3M+EitRG8vZ929OatYFowisY7dALIaxU3MmfpfEgYNZ0MNxaGSyoDH
 b/uMEUTvu6kMSD8uliuP/oRPoYhyLISw27ho0dSQAk4Zh+KBJf3usr54PDlJpwj42h5C
 8LvaUEWw3D1eUBlvqu3kxQ3kkL+ie9mDcA6eGkHq5OuMwH3/02cZ8LgrdxY9lFVrlC5m
 fcTN0YJvswTa1ti4lyplwGh/1Te8/kVcgRtzWAoKqeE3Lu2f7F3gkLBSwaMrY58mqa17
 L0pWV35GaXNBiwGBLcLz5g5RpDbfp9q7cG2GiX6ENtA/iNTc6upwUTxrXDHngkZYJnQs
 ZH2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpW8gVOw8QytPGIN+FC2eb1bcxeeLxqsXtJc9pEKVgY3I6G0m/uwQkU0Njl0NyFpgyEl7gVBe3gSmYM2eyTI2pkRHZHcU=
X-Gm-Message-State: AOJu0Yy++As3+UsseGqKpi70IlJ4OUj6Fjj1P5S/ouGJVWUj8YYLsn7k
 ajlrAyQg6d9vj8mmJJU171UbM0hPx+St4K+ZJ3bwVIRvsWVlYtzRBPVNvAHII6M=
X-Google-Smtp-Source: AGHT+IHld8l/1nod9XedHnjsXQfeXPj+wBf1Qvmgp7FsXm6yk2DLhWywyUeXA7ngBPWog1DGXOEN9w==
X-Received: by 2002:a05:6a20:12d2:b0:1c0:e1a5:9583 with SMTP id
 adf61e73a8af0-1c69955f54emr17210544637.17.1723002397013; 
 Tue, 06 Aug 2024 20:46:37 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3a9cc47sm298202a91.11.2024.08.06.20.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:46:36 -0700 (PDT)
Message-ID: <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
Date: Wed, 7 Aug 2024 13:46:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806141940.22095-2-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 00:19, Philippe Mathieu-Daudé wrote:
> qmp_query_gic_capabilities() is not specific to the ARM
> architecture but to the GIC device which is modelled in
> hw/intc/, so move the code there for clarity.

But the GIC is certainly arm architecture specific.
It's built into the CPU, and shares state.

The fact that it's modeled in hw/intc/ and not in target/arm/ has always been a needle in 
the side, though it seems there are no good options.

> @@ -39,6 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
>   endif
>   
>   specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
> +specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
>   specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))

Is it more or less confusing that you're not using CONFIG_ARM_GIC, for something that is 
GIC related?


r~

