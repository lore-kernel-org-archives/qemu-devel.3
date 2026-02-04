Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CCDE83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhIQ-000651-Qm; Wed, 04 Feb 2026 13:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhIN-00064D-3n
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:08:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhIL-0006C2-IF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:08:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso556225e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770228482; x=1770833282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RCoWjIvRFK1p68aMQjDy1Y8xnKT57Fh0Ugp6ixZcINs=;
 b=bEZPFxDA+mmd+9z+nVn9wRISTVTYjvOT/cSNLA6eTd1C3DamW0PE+8OsOZfy9hBNEx
 RsUPAm6I3PVUBnwYMLCkNFdl5altHw0+L6TfPUz9nMDsC3VQE+WzO798k74xila+ny/5
 48/Mw3j9E4fE/rwUCR+F78ubt4pLQgFpD5xNSH2drRVN4Lz4U+gmtgmlpgGlu4WB1rMK
 HY4l9NQjLtTh553E3DYwjNc0Vx7Lhx98lKMEPEdzZFMOpa0LJf5iSP44mDdJJt82E8h0
 ednII9Sgcb9kou6ieTxHaoyY5GUMX/qNMmG6WYRe+NuhUICtzKqF/vt4xui9BUDugiax
 F9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770228482; x=1770833282;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCoWjIvRFK1p68aMQjDy1Y8xnKT57Fh0Ugp6ixZcINs=;
 b=vmpMTy9BaujKKFuEaYqfrY9wjTVVwLdfRVZkxTnqj7OgCjTprzTaVVSF2E5aB6yjzB
 ms2pJSQTjNL6/Jbxcgm/QW54Ryp7wlFJ0JhobzQT8M9su7aO2oqnb2e9R3rTUsoRQ/qO
 h41mEpQBYfyIn4w6y1WMufAUXwUTF9vsvzKIyW9GF79eS9Xl16QS4WrQ9M4sTYn+8BY+
 BJPMmBeARMFrp8vEKpIYzIBrx1H+LqBRAqxxiGmWjamP/vk6jdA1u5OR469xLFk4hK6l
 3jSzAfoBgOsHhMYp1P5hGv4S721ysLcsDYNaySVFpTXSjTnXwvRUlgfDilotncMOg6D2
 Lb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXrOabb8mZFvYt8DJOPIlsvj8rOhQ4XHelguP9TYtM8V3k3yF1yRVuB1CJgy9KRCp0U0Ov5yrH7VVS@nongnu.org
X-Gm-Message-State: AOJu0YyRwUD+K17So6o8JlpYpqJW+/BHezx6jtPdrLzbu4ZGljhnLbix
 NydIGGu2BDbDT0y4hsBRBe889KDiZtpe7YCfbXU/Zhns5m/Gseoqx1LW4iK7ko/Eo4k=
X-Gm-Gg: AZuq6aIuPbAS3EtG9YtNTk+dMB4hnD8sCd4CikFS9IVONzcPNvWWzvadAnh/1YPzvXB
 6qyv4V2Cmb+aukxm09kWDieung8JN+fEos7ZoMt5r1XuIEQc4d59n4nDUF2kmK1YtQBrrYGsOYD
 j+0FCV51k5vx6A758ADU/F73Ny/9BRXPJKGMrU6JzBupIUFio9b0QkMy+EGGiv8zU0kjiuuSvxa
 l/EdK8Kth/eorm/3oTC60ScEx2PJHAY0iMbGaSTugIwdk6qzGl6YVmnv1w9EnJrfiQ4soPRZKE+
 2JeqmSDhmwT0KQgxjc+pGCDSJiZ3Nv5+dteweXORgLa14SOQOQfrrc5wk5sqgJiy5itQZ1CVDsb
 yr0C1xYXHg/e7TkEdz161CQ7czyXPv7uE42qiJQyfiGFc4t0N1GkFhUYQoTj2KLounFhqdtVyB3
 k+XDfBxnLghQMLwfOlvYyEMemizoLeUktkDDLoLZY1kpdDhAjGyJ9NbQ==
X-Received: by 2002:a05:600c:3145:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-4830e98aa4dmr48614075e9.26.1770228482480; 
 Wed, 04 Feb 2026 10:08:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faf7sm7913091f8f.30.2026.02.04.10.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 10:08:01 -0800 (PST)
Message-ID: <6263230d-f108-4178-b5be-22fc61b81a93@linaro.org>
Date: Wed, 4 Feb 2026 19:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/s390x: Introduce CHSC_MAX_REQ_LEN definition
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-14-philmd@linaro.org>
 <5302604f-0fe5-4dfb-8baa-f072e279504a@redhat.com>
 <0fef147f-8268-47ae-b037-ce7d7063489a@linaro.org>
 <038cc071-1a40-47a8-acf4-55016af8d5b2@linaro.org>
In-Reply-To: <038cc071-1a40-47a8-acf4-55016af8d5b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/2/26 19:04, Philippe Mathieu-Daudé wrote:
> On 8/1/26 12:46, Philippe Mathieu-Daudé wrote:
>> On 8/1/26 08:53, Thomas Huth wrote:
>>> On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
>>>> Since commit 166f1bb7968 ("s390x/ioinst: Rework memory access
>>>> in CHSC instruction") the access is no more tied to the page
>>>> size. Define CHSC_MAX_REQ_LEN to better express the relation
>>>> with the length of the Channel Subsystem Call request.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   target/s390x/ioinst.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>>>> index 2320dd4c122..d07773d14a3 100644
>>>> --- a/target/s390x/ioinst.c
>>>> +++ b/target/s390x/ioinst.c
>>>> @@ -398,6 +398,7 @@ typedef struct ChscResp {
>>>>       char data[];
>>>>   } QEMU_PACKED ChscResp;
>>>> +#define CHSC_MAX_REQ_LEN  0x1000
>>>>   #define CHSC_MIN_RESP_LEN 0x0008
>>>>   #define CHSC_SCPD 0x0002
>>>> @@ -660,7 +661,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>>>> ipb, uintptr_t ra)
>>>>       uint16_t len;
>>>>       uint16_t command;
>>>>       CPUS390XState *env = &cpu->env;
>>>> -    uint8_t buf[TARGET_PAGE_SIZE];
>>>> +    uint8_t buf[CHSC_MAX_REQ_LEN];
>>>>       trace_ioinst("chsc");
>>>>       reg = (ipb >> 20) & 0x00f;
>>>> @@ -690,7 +691,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>>>> ipb, uintptr_t ra)
>>>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>>>           return;
>>>>       }
>>>> -    memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
>>>> +    memset((char *)req + len, 0, CHSC_MAX_REQ_LEN - len);
>>>>       res = (void *)((char *)req + len);
>>>>       command = be16_to_cpu(req->command);
>>>>       trace_ioinst_chsc_cmd(command, len);
>>>
>>> Sorry, I don't quite get it, there are still dozends of others 
>>> TARGET_PAGE_SIZE usages in target/s390x/, what's the advantage of 
>>> removing that one here?
> 
> The other ones are really related to the s390x page size.
> 
> This one seems to use TARGET_PAGE_SIZE as an optimization.

Also, making this file common, we get the page size at runtime,
and that triggers:

../../target/s390x/ioinst.c:663:17: error: variable length array used 
[-Werror,-Wvla]
   663 |     uint8_t buf[TARGET_PAGE_SIZE];
       |                 ^~~~~~~~~~~~~~~~
include/exec/target_page.h:42:30: note: expanded from macro 
'TARGET_PAGE_SIZE'
    42 | # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
       |                              ^~~~~~~~~~~~~~~~~~~~~~~~
include/exec/target_page.h:40:49: note: expanded from macro 
'TARGET_PAGE_MASK'
    40 | #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
       |                                                 ^
include/exec/target_page.h:32:29: note: declared here
    32 | extern const TargetPageBits target_page;
       |                             ^
1 error generated.

I'll drop this patch and let someone with proper s390x knowledge post
a proper fix when this will become a blocking issue, but today it isn't.

> 
>>
>> The other ones are also used by user emulation so need more care. This
>> series addresses all system-only files. I neglected to mention that in
>> the cover :(
>>
>> But if you think this is better to review all target/s390x/ conversion
>> in one go, I can wait until I finish the rest.
> 


