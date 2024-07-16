Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B82C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiGE-00052b-H1; Tue, 16 Jul 2024 09:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTiGB-0004pO-U6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:30:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTiG9-0004BA-Q8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:30:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so38420765e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721136624; x=1721741424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fqYXuI8dFITP7ECgsEI6Gm6t3TwXwSXdH4+K1VfcJ58=;
 b=v+F+EIM2Q285VXDsAfnK+SpTRPjQlCuA403rtm1Q72YevwP1OIoz1MOzioHiuiDsVy
 wOfKvJP+bTIw9VuZK8/6S2huNxeTyLrP8eWluu343irhG2RUuQR0Hl5lf8+sUNbLV5+/
 4PGxAMJuGuYSWdOHqWKpaJ6ZLVKDgnT7IVdXyHRDBY74KUMKLnZ6m+vWVcsMkhtXfQFg
 0d1IkxyYwn8/Ck29wKtkEzfYQKrkbM7oj3VuCb/NvXs1ZrZN3EQNAuQvHUO3D9XhHsKz
 vWY1NQF7ggjMpoSAzpU146VkTz8Lhm8sPsqeRFAC5w2x9xnw48K3brjR2Jeq0QcYcokV
 FiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136624; x=1721741424;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqYXuI8dFITP7ECgsEI6Gm6t3TwXwSXdH4+K1VfcJ58=;
 b=sZVHD8OHmiog2A03jBB9Yl/cJuz1yaGvXjZr5M3574UPq1cTM9ZNOu+3TW9AgGY8Mr
 SPA/F8HNtqfhYgSwRLeel98CXkiqzJdUSB96UFAe9LYeRtZm6RLXGff6vW5v28IRMcdj
 Uosk4M3tgaLgc3Nrn+ETPtQzAPqOcov5d3gsjjzWu51tCFyPnovYP6RHxAG1+aJuiL1E
 c0t4gCV6lvA4bX9zMFTYwhE3wC+feEgTNmPfZLtsoD2kXvjZhjPiCcqNeACni24PLqFJ
 ulmPypfNWwPfRqETT77gjr3KaSqjUAE+SiJvuSZKfn2w6NE20czY/+xQcfCkGO22tPvU
 ht7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOZOHyPunDA2gRqAbmCz6ZtDMwTnfvPaC0DGOjtiIoMIfmkPOzpWDcIpjBxRWYEzpVHmfpVL6p0I5yprTpiqUd0FFSkBs=
X-Gm-Message-State: AOJu0YwSvCd2vZoAiU8f8U5TmNoJBSTGgW35M2i1hebNEWDZyk6/WxaK
 IQsEzgF6rj/nw3whE0woB1HiYhRUvXiS1OdAy4kWw5LTaTtRsQD0QFtO/WSe75Q=
X-Google-Smtp-Source: AGHT+IEovbz1ZRXArko3wKnQ3TE42VUM+o/S/VvsIH/eusW/xkkqVMLHXLQnulnJ1EvtQac3GyUz0g==
X-Received: by 2002:adf:f548:0:b0:367:97bf:f65c with SMTP id
 ffacd0b85a97d-3682610e9cdmr1392840f8f.22.1721136624051; 
 Tue, 16 Jul 2024 06:30:24 -0700 (PDT)
Received: from [192.168.1.172] ([185.87.38.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e27sm9104176f8f.15.2024.07.16.06.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:30:23 -0700 (PDT)
Message-ID: <a47858bf-fa2e-4316-b48e-3927d6c14698@linaro.org>
Date: Tue, 16 Jul 2024 15:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] esp.c: remove transfer size check from DMA DATA IN and
 DATA OUT transfers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, fam@euphon.net
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
 <1408e396-b597-4481-b537-e7b53976d5d1@linaro.org>
 <de7fe2e4-a590-4fe0-801c-b7998927c570@ilande.co.uk>
 <bcbd4622-ba30-4210-91c0-321406bd1f1a@linaro.org>
 <fbf76f1f-6efa-401f-a45d-ba4be739e51d@linaro.org>
Content-Language: en-US
In-Reply-To: <fbf76f1f-6efa-401f-a45d-ba4be739e51d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 16/7/24 10:56, Philippe Mathieu-Daudé wrote:
> On 16/7/24 08:46, Philippe Mathieu-Daudé wrote:
>> On 16/7/24 00:01, Mark Cave-Ayland wrote:
>>> On 15/07/2024 07:48, Philippe Mathieu-Daudé wrote:
>>>
>>>> On 14/7/24 00:42, Mark Cave-Ayland wrote:
>>>>> The transfer size check was originally added to prevent consecutive 
>>>>> DMA TI
>>>>> commands from causing an assert() due to an existing SCSI request 
>>>>> being in
>>>>> progress, but since the last set of updates
>>>>
>>>> [*]
>>>>
>>>>> this is no longer required.
>>>>>
>>>>> Remove the transfer size check from DMA DATA IN and DATA OUT 
>>>>> transfers so
>>>>> that issuing a DMA TI command when there is no data left to 
>>>>> transfer does
>>>>> not cause an assert() due to an existing SCSI request being in 
>>>>> progress.
>>>>>
>>>>
>>>> [*] See commits f3ace75be8..78d68f312a
>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
>>>>> ---
>>>>>   hw/scsi/esp.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> Queued adding [*], thanks.
>>>
>>> Awesome, thanks Phil!
>>
>> I'm getting dubious timeout on the msys2 build on the SPARC target:
>> https://gitlab.com/philmd/qemu/-/jobs/7347774958
>>
>> qemu:qtest+qtest-sparc / qtest-sparc/qom-test time out (After 900.0 
>> seconds)
>>    1/151 qemu:qtest+qtest-sparc / qtest-sparc/qom-test TIMEOUT 
>> 900.38s   exit status 1
>> qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test time out 
>> (After 720.0 seconds)
>>    2/151 qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test 
>> TIMEOUT        720.23s   exit status 1
>> qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test time out (After 
>> 360.0 seconds)
>>    4/151 qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test 
>> TIMEOUT        360.17s   exit status 1
>>
>> Not sure this patch is the culprit, but since only SPARC is affected,
>> likely. I'll retest without this patch.
> 
> Same failure without this patch, so not this patch fault ;)

Actually I couldn't find any patch in my PR triggering this,
then noticed it is also happening on the main branch:
https://gitlab.com/qemu-project/qemu/-/jobs/7347517442
:/


