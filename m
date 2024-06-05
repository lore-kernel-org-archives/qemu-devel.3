Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9303DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEwSt-0001fI-4z; Wed, 05 Jun 2024 15:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEwSs-0001ex-6n
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:38:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEwSq-0005TY-Dm
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:38:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c1b542ae9eso155148a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717616306; x=1718221106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZTfYAXO8zb36EAw+iDM1T59B8i0O2ZP/NqsTkx0Ssk=;
 b=xd5yDLWf6fBy2EIaESVqDDEm4tGruR1ju3ISpfbRsE2f72uSWAAszYxHjpKColNeu2
 bYPp1wFdw4Xp92cCEjmPoL/WNjZ4tWCCnu/6zP1XMxFthKi6Ge4bhstni7t0aghXYGYV
 4xFx5CoUgJXblgrB3fVZ1RftXhLPqiIXb0k93QPh51uY6UrZcpNK4y2Lgj/luZryQJQ0
 mhMzhdmugM6SP/kj+aRPc3BF9cs9BwFOntugFqy2QnbvK+R4bgg7Rdfcx1hIYx6tczJv
 1FqQdFj3oje9QS8nVb1RHEaXtbpqzSRJ1w57Fjxk1DatCe+xBI6vqLZvptkV1VbWsby+
 ZDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717616306; x=1718221106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZTfYAXO8zb36EAw+iDM1T59B8i0O2ZP/NqsTkx0Ssk=;
 b=A4RqlcFjuwZ90RkA51K/k1Qw565XxX+8w9o+s630tr3JaxkSWQX+dPj/N0gHdiClP1
 mzCKAGZGW9cuOpwrDHYCdJo8yIuldW/SEQ5MEJKb4yg1lD3UriIJ5e3XDAKHFxPLvBIz
 fa9dgWSVHKWVdAmOCyT2mOUlPfG8H+y0Ds6GKDLAR6elsUa+B4V+kkyJgceVkvvh2LOS
 NkZ/D/O5yIW4AHEY5+Q9BDvferl3aF67nN7IPiH9xQDmWmdRhnI2l7dNr4uhCAtafMSk
 dhU9fb06Jvd/NHRYbiSMsr6w8XudgELlhjkvDKf4J1zXxaWUKe7cfzpwSJW5FsAVzE4x
 dd+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUweU7A9VxV/gbZbbP1AQzX38AflIQU2ZHwiW42OGVgB9UA1+yUo3P6bbZnV3rmKLBoEXn/yXsZCAg1QDjXpFM4i6HLS5s=
X-Gm-Message-State: AOJu0YyrXOghe/QRo+g+2jpXUNZqX0/+4bVMqn4AtBu0AYds/AWSR1BM
 ndmmOj1M2aXfdAtSQExnE2WPn6ugbmP3jzelIF3DLhuzmmZbm4h8j11/Azdpj18=
X-Google-Smtp-Source: AGHT+IGH+UctxfgrzmMysurssj2VyrpYRxx1cwPk8sEqmAyhqsyB4ZKpaEV755/YSst2ZHgnamgwVw==
X-Received: by 2002:a17:90a:c798:b0:2bf:5730:1f56 with SMTP id
 98e67ed59e1d1-2c27db031e8mr3517392a91.1.1717616306008; 
 Wed, 05 Jun 2024 12:38:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d54fsm1846209a91.8.2024.06.05.12.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 12:38:25 -0700 (PDT)
Message-ID: <100509f3-7d73-44b3-bd31-0e7791897e02@linaro.org>
Date: Wed, 5 Jun 2024 12:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] linux-user/i386: Properly align signal frame
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, laurent@vivier.eu,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
 <d644678a-815e-4c49-bc65-15394bf897e4@linaro.org>
 <626f7346-39de-4895-a92d-b7fd09bc18e7@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <626f7346-39de-4895-a92d-b7fd09bc18e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/5/24 14:16, Pierrick Bouvier wrote:
> I'll take a look, thanks.
> 
> On 6/5/24 12:06, Philippe Mathieu-Daudé wrote:
>> On 15/5/24 17:08, Richard Henderson wrote:
>>> v2: 
>>> https://lore.kernel.org/qemu-devel/20240409050302.1523277-1-richard.henderson@linaro.org/
>>>
>>> Disconnect fpstate from sigframe, just like the kernel does.
>>> Return the separate portions of the frame from get_sigframe.
>>> Alter all of the target fpu routines to access memory that
>>> has already been translated and sized.
>>>
>>> Changes for v3:
>>>     - Address review issues (bonzini).
>>>     - Rebase.
>>>
>>> Patches needing review:
>>>     02-target-i386-Convert-do_fldt-do_fstt-to-X86Access.patch
>>>     19-linux-user-i386-Fix-mregparm-3-for-signal-deliver.patch
>>>     23-target-i386-Honor-xfeatures-in-xrstor_sigcontext.patch
>>
>> Cc'ing Pierrick & Gustavo.

Merged on 26 May.


r~

