Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DD2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdyn-0001fc-QZ; Tue, 16 Jul 2024 04:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTdyl-0001V7-DT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:56:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTdyj-0008D4-Di
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:56:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso38441165e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721120166; x=1721724966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fb/K/NaNBBZ/CLSJzjNZbiLTdwQQNrfwjFFFjxg/AI8=;
 b=GyzBjXt08cyOUDJDL/sRQgkoH0Vyrrt5ps7o7fRa7eWUnjFc0Jl58lxCpNq4UK3daG
 h1DVQXHIrd9X7Wjr7+77EkTkmBe5v6Bg6WchEzHgfXKuIYBRHYvEmUY+naabPaca3v6k
 +3lkeoWEO7+C2+6xN229lCm7dNrH69yqW14GyRx2xgkDA5zbt52ySlUaEaBbbp3MRp1Z
 bIWIczWh/POVEEXNnpjP29M7ApbPPrf80b7j3mK/tRTTYE+SCCBaY3jjAD/r2mKKB+rK
 V+2mP5Bjn9DSs0ei1RWbQsvgEwEkb59vW2C+IQsh3V/VqVviNGh0GkMRKboS32PEfm6z
 oUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721120166; x=1721724966;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fb/K/NaNBBZ/CLSJzjNZbiLTdwQQNrfwjFFFjxg/AI8=;
 b=huGbk+cU+Q9wlgiYfcUAwj+7lrwoyyM/AHhRHrv1u5nj3MZp0RV0IY8IKlks4qwrHh
 DE1Bvb5WEYzxkS7+FIjX5Zm/B/d10C/w9yX3BPyxAPdisihDonCOJSwJWbqaqTgJ6OjQ
 0u7uHlz+v21j94dKOVbwGox20p1kT+3ydfUhEceVQt31FxaXwijAwZt3AZw9Ug1FFllS
 MpwNp1BtRgkWvJRjIMg2efllXnq3VdZTfd0L6+lrylk6OOymETshq3UhEHNT+TcdQUtd
 qu50Z+DBhT/TmPLY2bclc8SNmKSzmJ6guVM1u3R1rvazUeF1u3zkrmmB6VIGeWRSnlvY
 v/4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCl4613VtniCjdgik3mozWz76rofx9AOeCxUlk/uEYWXeuJWO2657S1kMe/jiqq7r/8nLPfAcXf3IsXLKf7enLKPQilWE=
X-Gm-Message-State: AOJu0Yz6zTk/2q/3fixQH/nEw0AtBsSDOY8m4JYWa0eei64beMqIWkEN
 ow7LYkSV14xWQOWgqLPnYEq+b5nLdEDGSxQA17PjFiUzkYAIZfng7vfXsnjxvj0=
X-Google-Smtp-Source: AGHT+IFGCA8TRXP/aWjz41xVo0uUy/EhSTE3xouX9oBoQCvMNX6jfF7IR9GViN50MDx91S/jnnBKRA==
X-Received: by 2002:a5d:618b:0:b0:367:88e8:fed1 with SMTP id
 ffacd0b85a97d-36826106642mr939333f8f.25.1721120166582; 
 Tue, 16 Jul 2024 01:56:06 -0700 (PDT)
Received: from [192.168.86.175] (233.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccc55sm8372726f8f.50.2024.07.16.01.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:56:06 -0700 (PDT)
Message-ID: <fbf76f1f-6efa-401f-a45d-ba4be739e51d@linaro.org>
Date: Tue, 16 Jul 2024 10:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] esp.c: remove transfer size check from DMA DATA IN and
 DATA OUT transfers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, fam@euphon.net
Cc: Thomas Huth <thuth@redhat.com>
References: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
 <1408e396-b597-4481-b537-e7b53976d5d1@linaro.org>
 <de7fe2e4-a590-4fe0-801c-b7998927c570@ilande.co.uk>
 <bcbd4622-ba30-4210-91c0-321406bd1f1a@linaro.org>
Content-Language: en-US
In-Reply-To: <bcbd4622-ba30-4210-91c0-321406bd1f1a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/7/24 08:46, Philippe Mathieu-Daudé wrote:
> On 16/7/24 00:01, Mark Cave-Ayland wrote:
>> On 15/07/2024 07:48, Philippe Mathieu-Daudé wrote:
>>
>>> On 14/7/24 00:42, Mark Cave-Ayland wrote:
>>>> The transfer size check was originally added to prevent consecutive 
>>>> DMA TI
>>>> commands from causing an assert() due to an existing SCSI request 
>>>> being in
>>>> progress, but since the last set of updates
>>>
>>> [*]
>>>
>>>> this is no longer required.
>>>>
>>>> Remove the transfer size check from DMA DATA IN and DATA OUT 
>>>> transfers so
>>>> that issuing a DMA TI command when there is no data left to transfer 
>>>> does
>>>> not cause an assert() due to an existing SCSI request being in 
>>>> progress.
>>>>
>>>
>>> [*] See commits f3ace75be8..78d68f312a
>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
>>>> ---
>>>>   hw/scsi/esp.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Queued adding [*], thanks.
>>
>> Awesome, thanks Phil!
> 
> I'm getting dubious timeout on the msys2 build on the SPARC target:
> https://gitlab.com/philmd/qemu/-/jobs/7347774958
> 
> qemu:qtest+qtest-sparc / qtest-sparc/qom-test time out (After 900.0 
> seconds)
>    1/151 qemu:qtest+qtest-sparc / qtest-sparc/qom-test TIMEOUT        
> 900.38s   exit status 1
> qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test time out 
> (After 720.0 seconds)
>    2/151 qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test 
> TIMEOUT        720.23s   exit status 1
> qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test time out (After 360.0 
> seconds)
>    4/151 qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test 
> TIMEOUT        360.17s   exit status 1
> 
> Not sure this patch is the culprit, but since only SPARC is affected,
> likely. I'll retest without this patch.

Same failure without this patch, so not this patch fault ;)


