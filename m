Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C72EC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBKG-0001c5-Mu; Thu, 19 Feb 2026 16:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBK1-0001Wm-4f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:29 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBJz-0004T3-GT
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:28 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8249cb73792so1252587b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535546; x=1772140346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=notRDoQ/tgEard5Hd6hjgYmzPVcjtuTrYBuLwIskBbk=;
 b=obExlkvvYCRlkNWAIrSmFL3tZyoHiAADtd6+pYJ6voataRy7vwy9Vpmya0PPN/YjcY
 5wNG2zSNJ7S5eZvsv05Q3/oNJ1Zbjh0PMKraKRreruduCYjX/HxXYuiaU7SUIuADQe6B
 Q4Hi/G0tnUQftWuBb4YeFjbHCaO3qNGyeyzmY3t4+An7vdQKgaMUaaO5M3M/STa8GwWP
 CdZNMFf802+9eo0mjKSWk2daED0D/baGsNuoRE3emvqWdJyKfqSs/wrenO8RhKPelcrX
 rqPY15OxlRLIBz394bdMY3y3OAU5xvX22LbCiNEqIaSdHs34tR+ZTYcjr2kuBH+ysZ2w
 qrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535546; x=1772140346;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=notRDoQ/tgEard5Hd6hjgYmzPVcjtuTrYBuLwIskBbk=;
 b=HwM8sJKDR9PhBHwtz+SR1JazbezN9b3smxDKZoK9UMYewQcUhQY27/lTGJuO29fsmb
 Qlu4cC6gpIR84YGhZrpo9gFusypMgnNoeFZNZnUpq/Zm38Kw5EPfSir0vNh35beTtG8f
 P+xm7TgYPaVsAa0YB1u1OkilOFDbOuVW74OqDB3lddNTJldv7e9DP4xaxkL0YitFeGl9
 0iSixgehLbGpXJ2bB3aDfFvbY5OBgRxaTgS1v0WU+H4jzIsv5hqDwY1gWWj8fotxpTya
 4VAGxlfe/1w5iKuaZ5pNmPXA9rBk28GUzRY7H6Z/kYOtXkP62qnAjvH56/q5+jA4R9Li
 4KjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW89DEuiM7RZuBYiRJinFOWsc/6KQEOmIp/APaLsTzl/9fMBdIW9fRXz8pQDboTIxi6N1Ioctf21UDf@nongnu.org
X-Gm-Message-State: AOJu0Yz6hoGSu5ugmOb4/45xlcIuSI8o9zetillb+ClupdkUsRjWlb9U
 tg5MdymyRBNKz4FOCNFJ2/NwG4UplS5MpwtZq82UZAI+E+xJ10dj+FOufi+ig/dyjOA=
X-Gm-Gg: AZuq6aKTgVS0sKwfE/qAx8//MT1nLyznB6Iw+GcRTIrJTVjRbUhqM4ybhYlperKQ+fG
 8qIkgw1D1/xc+ZCTRVCWaXhk6k9dERwolsV71Oc2FXgtqh6FPJY24vZ9mkPGx2/DxKPtOpPpCto
 0BPrkemkeUgzkrpobnWXlT5AgHc9E/Xafgj3HGxAxvJw2FAjQpGi588j2dQ7WLK51YNuTOJmRpk
 uK7eHxLobkXys5RC1Q+MRIsqnosD8cnhtjU1sUXRGY3gABXJoMEzkSpxFXbDQ1wGAYFKT4GZ++N
 4VhuXlFcw9v7fES0BGINnwY/TwlfLbE+NzP3B+9fEFQhmKse37xckmuoc2kg54emw3hBsknjHyb
 JTZMy2d3nREmaA4pxmQxMiwTSKNf1rYR8iK3OGHmgRhqwaG7lI8TV3AKUX6Rnegq8tZkKsbBXVV
 vjwPb57WhNQ8bEKuF5E6dszPrqk6L7LUS5D84ATY4JEOzju+SVoKowGBLNeEAQthATQRWd
X-Received: by 2002:a05:6a00:2307:b0:7ef:3f4e:9176 with SMTP id
 d2e1a72fcca58-824d9612684mr16931379b3a.49.1771535546198; 
 Thu, 19 Feb 2026 13:12:26 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2c4e5sm20591934b3a.4.2026.02.19.13.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:12:25 -0800 (PST)
Message-ID: <65775ecc-912e-46bb-97a9-92dcdb413d8f@linaro.org>
Date: Thu, 19 Feb 2026 13:12:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/50] target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x442.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Restore gdb-xml/sparc64-fpu.xml from mainstream binutils, tag
> 'binutils-2_46', found in the gdb/features/sparc/folder [*].
> 
> Extract sparc_fpu_gdb_write_register() out of
> sparc_cpu_gdb_read_register() and sparc_fpu_gdb_write_register()
> out of sparc_cpu_gdb_write_register(), taking care to update the
> register indexes in the switch cases.
> 
> Register these helpers with a call to gdb_register_coprocessor()
> in sparc_cpu_register_gdb_regs().
> 
> [*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/sparc64-linux-user.mak |  2 +-
>   configs/targets/sparc64-softmmu.mak    |  2 +-
>   target/sparc/gdbstub.c                 | 88 +++++++++++++++++---------
>   gdb-xml/sparc64-core.xml               | 50 ---------------
>   gdb-xml/sparc64-fpu.xml                | 59 +++++++++++++++++
>   5 files changed, 119 insertions(+), 82 deletions(-)
>   create mode 100644 gdb-xml/sparc64-fpu.xml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

