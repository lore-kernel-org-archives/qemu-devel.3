Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C06C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzq6-0004A1-L4; Tue, 12 Mar 2024 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjzq3-000498-0u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjzq0-0003If-9n
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710241107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t09QWsY94/iQRZOnzLkiHhhxO2pFYnVJQ15R56gTi90=;
 b=BgyxbMxb3jQ35lmwDpAGeB357iXNYCu3OuRnaa+7+DEf/OoG9u9txdp1WDhRVNU7lhENlt
 WkQV++jrUMEf7r1TxavP6wXQdFRqEeJzsSOp8JMOBhDn02A2FhvUMAm0x/A2tdQTMhIjSj
 rF+iIM0qyvjr2QfGxerGm0jdfgs3Ry0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-fp-8qzwYNr-Fp6GCzAbCDQ-1; Tue, 12 Mar 2024 06:58:25 -0400
X-MC-Unique: fp-8qzwYNr-Fp6GCzAbCDQ-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7db1c4c6df6so1851019241.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 03:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241105; x=1710845905;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t09QWsY94/iQRZOnzLkiHhhxO2pFYnVJQ15R56gTi90=;
 b=FlDT7hnCFgxKSq1m835obWvfqGGuhY6FFrmUQ/HWKABBOig9Vfi+pbIeuRVJooxU8S
 uVC2S6/5R+fVgjIDsKm80S9Bmv1kTCvVN66CBOOK7H9hqUHzE79eqXcxwBu1fRUmzPFj
 DTQW9OWWCX7WrrJ15lFnUMs4ITGHU8Aox27E8gbmFVmJvy5lXovfZDh1EeV1qOnIE7SX
 wzopbOkWSgTKJENEJM1x4AW4TR4xoI+lpzBOXsK1GqHbCQYBDdoGuFR6CE7TbMh1llgf
 oVbuOaX49t5gX/4bwdu6hJrVRceHD2VkC75t5VmdocjCMEDoa+0tPzGrmNTeUYlQ0CnY
 jjTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm3cktlRYAeDrdopqz0OHMBZvAX2kj+IypTRnbWDHZYKJhyx6r1RoqOCkxN5OouAL/D0glLgDAmyVUru41rp5PcmthbtU=
X-Gm-Message-State: AOJu0YyikGhwd4AoVR42LzzolurH6Qho718TGCMO2735LzUXSwYCr5QN
 3aWL66VbrSbDuv+L88lsAiNF5VoehqZkSCdr82+eKDAYRpsjZ85Jkb7bLv0TLZtPTYcYQIxsm1G
 7iMX4am85eAmZMSLNtUzL/I4jQ0qiL9+gUG/m0/YzUZ/wWW3tZnDy
X-Received: by 2002:a05:6122:1689:b0:4c8:e834:6cf2 with SMTP id
 9-20020a056122168900b004c8e8346cf2mr5391224vkl.3.1710241105309; 
 Tue, 12 Mar 2024 03:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtCzZ5TA7h9HxcRxlzvWik4+loeycFPPMxtIdVzO3b5gRmM4gqXQbDLa+4sOabcSEDHwf29g==
X-Received: by 2002:a05:6122:1689:b0:4c8:e834:6cf2 with SMTP id
 9-20020a056122168900b004c8e8346cf2mr5391211vkl.3.1710241104988; 
 Tue, 12 Mar 2024 03:58:24 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 m14-20020ad44d4e000000b00690d26a6b20sm1893400qvm.130.2024.03.12.03.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:58:24 -0700 (PDT)
Message-ID: <db5a73f5-bccc-4595-b1e9-4ed5806e3884@redhat.com>
Date: Tue, 12 Mar 2024 11:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] hw, target: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/01/2024 17.44, Philippe Mathieu-Daudé wrote:
> Patches missing review: 1, 2, 5, 6, 8, 11, 14, 15, 29
> 
> It will be simpler if I get the whole series via my hw-cpus
> tree once fully reviewed.
> 
> Since v2:
> - Rebased
> - bsd/linux-user
> - Preliminary clean cpu_reset_hold
> - Add R-b
> 
> Since v1:
> - Avoid CPU() cast (Paolo)
> - Split per targets (Thomas)
> 
> Use cpu_env() -- which is fast path -- when possible.
> Bulk conversion using Coccinelle spatch (script included).
> 
> Philippe Mathieu-Daudé (29):
>    bulk: Access existing variables initialized to &S->F when available
>    hw/core: Declare CPUArchId::cpu as CPUState instead of Object
>    hw/acpi/cpu: Use CPUState typedef
>    bulk: Call in place single use cpu_env()
>    scripts/coccinelle: Add cpu_env.cocci script
>    target: Replace CPU_GET_CLASS(cpu -> obj) in cpu_reset_hold() handler
>    target/alpha: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/arm: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/avr: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/cris: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/hexagon: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/hppa: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/i386/hvf: Use CPUState typedef
>    target/i386: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/loongarch: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/m68k: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/microblaze: Prefer fast cpu_env() over slower CPU QOM cast
>      macro
>    target/mips: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/nios2: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/openrisc: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/ppc: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/riscv: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/rx: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/s390x: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/sh4: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/sparc: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/tricore: Prefer fast cpu_env() over slower CPU QOM cast macro
>    target/xtensa: Prefer fast cpu_env() over slower CPU QOM cast macro
>    user: Prefer fast cpu_env() over slower CPU QOM cast macro

FYI, I'll try to queue those for my PR today except for:

  scripts/coccinelle: Add cpu_env.cocci script
  --> Still needs review and you mentioned a pending change

  target/arm: Prefer fast cpu_env() over slower CPU QOM cast macro
  --> Needs a rebase and review

  target/hppa: Prefer fast cpu_env() over slower CPU QOM cast macro
  --> Needs a rebase

  target/i386: Prefer fast cpu_env() over slower CPU QOM cast macro
  --> There were unaddressed review comments from Igor

  target/riscv: Prefer fast cpu_env() over slower CPU QOM cast macro
  --> Needs a rebase

  Thomas


