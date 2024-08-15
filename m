Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F06C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 22:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seisQ-0005Fo-Vq; Thu, 15 Aug 2024 18:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seisP-0005FD-6Z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:23:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seisN-0001XL-DG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:23:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso1155730b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723760600; x=1724365400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q627ROlZ45W4pAd8YAjz7di6hooqCDnTFiUtcvaeoMI=;
 b=cxMeh+0eKP1oFRtFg/iJmffy1DRhFWfDWq61nNE3SsD66Tr/Zwo5H4AgSA6RS2O76U
 iDJvey6lkHQfjF3WdnZBGjHHYJgrm0OwNE9z0wcEd5Yv1ur0elVW32ReGV7ycIFeAy2H
 y7f8IMbudyAgj0ENxCQ+CIbxE03/P5/FP7zl2OBVKmx0wqfqcXdu/O4xg413o7qZ9gxr
 e2Wv+7jzQhpl5mvIyYXoCE3kiiTZyohHPQWyIk/wkQjOrGV4K/Nh6nmstquclCPLzKTv
 50mHa7YpwS2Rs1KdPwZYCSd4c8TnTKrwOXKI0aNMCryBERpxwnuE/GiGc6Vo/05BlyXf
 HqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723760600; x=1724365400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q627ROlZ45W4pAd8YAjz7di6hooqCDnTFiUtcvaeoMI=;
 b=DWayXjPZL42JjOq6ahEi39OxxPGn+iSK4Qzlhroa5ShLpLEH7nfmL3fMfwG6Lapw5d
 p3r3UHMrtrbnxN8vxVa2E9gDHN7SPBM1pcbO67Lb2Mdj7ls+lIN4H3KNgJ1iKMpeyzoN
 eLpAXVRDw7wEKvBbjUgGLZw1SUwMM9YyLY8WVryIjou0EdNl3eK8OGJc2UzUZQHJiZVO
 DHnRbbQcvbbVFYUL5O5l/WBesV28eSs3Am3IIL3Q3m4c3DHfKI1eeHU/yg0ogFnCa5Vg
 jwy4hewxpKnnrK5lYI8SzvAC3Qy5EQCVENc4YE/AHHdEm/ymBhbyRK6gu5RRYY+JPfo7
 8LRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSDFdaqY7iddbEevE3NXsrleqjXoGtfrj13EVmiX6U0koP0sd2AdrK0/5PcdGHEZZ8uUb1guLZLaENP6Wr59zgd51pEOQ=
X-Gm-Message-State: AOJu0Yz1ePVMCbZHlLwTPfV+AY8fAITQV+zQhk0E8SMY4LczWo/zzIsK
 NJg1EbdQiGD0gTjVqB5p1BZAjq6GskA3GkxLLCC1o5idmCWlBQiRyJDYFfnKmUQ=
X-Google-Smtp-Source: AGHT+IE+rmrBwOojKa+irZmp9u+LfXsBCfyHUP2VuvnaeXwWNi95oc2FBo599d7Ni//+7DB0s4kUzg==
X-Received: by 2002:a05:6a00:148b:b0:70d:278e:4e94 with SMTP id
 d2e1a72fcca58-713c5285995mr1214636b3a.30.1723760599758; 
 Thu, 15 Aug 2024 15:23:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61a6cffsm1657980a12.2.2024.08.15.15.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 15:23:18 -0700 (PDT)
Message-ID: <557ad237-9a46-4dff-9177-bd4b2108d26c@linaro.org>
Date: Fri, 16 Aug 2024 08:23:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ttfm2em2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/15/24 21:46, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 15/08/2024 01.36, Pierrick Bouvier wrote:
>>> Found on debian stable (i386).
>>> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
>>> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>>     477 |             effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
>>>         |
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/cache.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>>> index 512ef6776b7..82ed734d6d4 100644
>>> --- a/contrib/plugins/cache.c
>>> +++ b/contrib/plugins/cache.c
>>> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>>        n_insns = qemu_plugin_tb_n_insns(tb);
>>>        for (i = 0; i < n_insns; i++) {
>>>            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>>> -        uint64_t effective_addr;
>>> +        uintptr_t effective_addr;
>>>              if (sys) {
>>> -            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
>>> +            effective_addr = (uintptr_t) qemu_plugin_insn_haddr(insn);
>>>            } else {
>>> -            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
>>> +            effective_addr = (uintptr_t)
>>> qemu_plugin_insn_vaddr(insn);
>>>            }
>>
>> Is this the right fix? I assume effective_addr stores an address of
>> the guest, so if the guest is 64-bit and the host is 32-bit, you now
>> lose the upper bits of the address...?
> 
> I think the problem is higher up, it was a mistake to have:
> 
>    void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
> 
> return *void.

No, not a bug.  This is a host addr, right there in the name.
Returning uint64_t would be a bug.


r~

