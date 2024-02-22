Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82E1C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7Ei-0008S8-2K; Thu, 22 Feb 2024 06:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7ER-0008Mo-DI
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:27:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd7EP-00055K-Lo
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:27:15 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d8739ddd4so749421f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708601232; x=1709206032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ewuz/uX+FAlMODLnCCI2wbCxRcoCSmYQznNuQLSANFg=;
 b=k7Sob5/abgM7c+/CTGg7xfeGOW8yh8Z7lmiylCU4kg2g+PHPTjJzwF2vMD5GqnylPL
 GmJEpPVzohxd4LDnqJt6PQkb17NYkiZYtlCxWlT8mAZ9i8ehYOppsPRL9foqJxK16tSo
 gT2WauR3oYmw3q11Jlxfm2asd/BSmjKVDTwIes0LjLNroUqtSwTswdkFIF4vF8KBa3Yr
 R7AE3OK19+1O63qggc8uLMEMC5Gsl4ijyty677+hofPozLgdxoZYIe/XjH375j5doAHl
 4exbJKOIHhEiIL8XNSDAdjFD3gQS8nUbmJvIY1taneZ1/jUHvrGMlGFqVa9sCEUNDyTK
 w1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708601232; x=1709206032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ewuz/uX+FAlMODLnCCI2wbCxRcoCSmYQznNuQLSANFg=;
 b=pX2P97pipaFiyEb8A2bOQll4KyQULoa4p4i7YqdmEsRtyqhw02+jyYEAFVC8PY8mfd
 EBabltRsjR/2HUQypAFM8jz3sva3osnlG+NJDe1XDfcUvY2z8GolbZu+439IH1J1jnZG
 mGoBv/yvg2v45n86/Lx/KKyx6fX0yIMR2OA5aajAjTgdg/I11hD1x5J9FxKMoHLPglQe
 aN0KlIpXqTEQ47/8jlPuzaQgx0vPWxqADHKvGGEbpSEShe3RE19BF6EeayfJwG4teBSX
 SRtL0UXwnirjz0rXmFiESrGj2zPW5krdQvp7WIV1KvvdFfNFBE/xIR+xnp409q2O2UcH
 Cl+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6mNLd9B53dqcw0ce8zjejIgWQ1pKQoUb5MDJL1FgJPUTyDspwBJGFR6Hk3EJAY6jLCCdxFIL6PdBkw624tI8LE/zz7LY=
X-Gm-Message-State: AOJu0YzUcMtl1TNNwKtlETAcC0Ng1zU3izBs6F6z4BpBUJUJcaN2Myx4
 A58ez4S/mtmmlxKDbgkPzhHxiG+Lso/vtIblEXx9tLhA0nveHcRvoI7utvml5FU=
X-Google-Smtp-Source: AGHT+IHYImjIerhPqKzadJuCMolekvIq2CyPVVAB2um/wkcWkD1FGoRTISs+T8n1b2f/WReLN8ASZw==
X-Received: by 2002:a5d:430d:0:b0:33b:302:c08 with SMTP id
 h13-20020a5d430d000000b0033b03020c08mr15756333wrq.43.1708601231756; 
 Thu, 22 Feb 2024 03:27:11 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a056000118200b0033d8a17a710sm2347370wrx.88.2024.02.22.03.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 03:27:11 -0800 (PST)
Message-ID: <6e6ab585-5479-45c5-9042-b958e0dbdfeb@linaro.org>
Date: Thu, 22 Feb 2024 12:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: Thomas Huth <thuth@redhat.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221180751.190489-1-thuth@redhat.com>
 <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
 <1ed3ee21-20ff-4503-98ea-de00c490b83a@linaro.org>
 <0a37899f-ca73-4749-8f6f-2b61b92cb560@linaro.org>
 <CAJ307Ei8-VE1Jsy_uZzLa_2=t76qB_eykZx-=0hNoaogGsUQaA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ307Ei8-VE1Jsy_uZzLa_2=t76qB_eykZx-=0hNoaogGsUQaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/2/24 09:26, Clément Chigot wrote:
> Hi Philippe, Thomas
> 
> Thanks for handling that !
> And I do confirm that it does not trigger any obvious regression on our side.

Since I screwed my hw-misc pull request, I'll add your Tested-by to the
commit before respin.

> 
> Thanks,
> Clément
> 
> On Thu, Feb 22, 2024 at 8:46 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 21/2/24 19:49, Philippe Mathieu-Daudé wrote:
>>> On 21/2/24 19:47, Philippe Mathieu-Daudé wrote:
>>>> On 21/2/24 19:07, Thomas Huth wrote:
>>>>> leon3.c currently fails to compile with some compilers when the -Wvla
>>>>> option has been enabled:
>>>>>
>>>>>    ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
>>>>>    ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length
>>>>> array
>>>>>     ‘offset_must_be_zero’ [-Werror=vla]
>>>>>      153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData,
>>>>> info[id], info);
>>>>>          |     ^~~~~~~~~
>>>>>    cc1: all warnings being treated as errors
>>>>>
>>>>> Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
>>>>> here: DO_UPCAST is supposed to check that the second parameter is the
>>>>> first entry of the struct that the first parameter indicates, but since
>>>>> we use and index into the info[] array, this of course cannot work.
>>>>>
>>>>> The intention here was likely rather to use the container_of() macro
>>>>> instead, so switch the code accordingly.
>>>
>>> Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")
>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    hw/sparc/leon3.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>
>> Patch queued!
>>


