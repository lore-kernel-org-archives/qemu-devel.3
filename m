Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC99ACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxil-0006Kw-KX; Tue, 26 May 2026 15:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRxij-0006KD-M3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:45:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRxih-0005JO-VX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:45:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso94658915e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779824742; x=1780429542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNw2TkQSlosjWcleasdMm3OQDRl86TSud92Cbt1NUaw=;
 b=WWNAZlfgXaJgJhI5u2izR+y/QJA56u6oMY4U4C3FB/VBYwc6kDTYXqixNQQwDIHYxX
 vqbbzXi9hUs+ctGgdov6j8FbpTskP1WMVxIyVsv1j2OM/qSPTfHie7JAOSLHuxT4tnUU
 F421TTB4oSLj2RRCMLH83qyjctakPYn5wyNbjfO3j2pr1u4x5aBXJsbhl/U6xP1ZTonu
 yxamxgWomTE1t3OwCnKbj9eNrOTQVVH0Lg5dpyAlPMhXq1TAeYfsCnzUN26yvbcsi1Eu
 VFMcjFvXuTJ4cdpE8/MBYmzufBi9SrE5Bhtsqx+VmE99hxCapcq76lWBOiCnBGLQqJ6e
 gBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779824742; x=1780429542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNw2TkQSlosjWcleasdMm3OQDRl86TSud92Cbt1NUaw=;
 b=pzvqXLBIFLsNzvzXG9hN22ScGn9qaXrvGPr2M6wj5p5caHimXezH5FDxqmiiPo+0LF
 bAdPCq2tUyV9Qw2Dofhh1nMvoj/rgrdIV0J0VjsPZlubkb1sS+HghrrkxIQvbIsPxVQ/
 EaNWKM5JdGi865mfH2wT0nU0RMy0yRmv5C+k+E6XVmx/ZAX4qMyRJC9c8nyO8KuGzDyp
 Kk7s3H0o3h3+k3GVK1LZexVQM1i91y+SMlu40prBwDbz5cAgnEnYgoqv3a3OifT7GSg0
 qVTPjbEyJIon/1/tirwfNRb228Xx5CYaFCI5v0h4x7h8FXdV/3pnw0f/hUN9Ql4U4V39
 1MhQ==
X-Gm-Message-State: AOJu0YwIcBiuXydrSjz9lMLj+erkrvAaTc/t2gbh2qyzUSWmsO3fAkfa
 3IfOAHWQKxowMbmwVhvojzQIReeOcyj6TqcbT1CgC/oC37sVBl4LMhFLP3vwag3L5D0=
X-Gm-Gg: Acq92OGP3Gjfdpoqz9zL9Cv32kq714B80P50Jg+OTYvR9GT/9AB0B+pGEUFKdJBPoya
 F/EKUwZvSjs9adRfOrpd9c7tUYWdZMYk9WnTrXqtPuXxXYZTdHam/bJQoq/Ima0I7kg/hTzkwnu
 rdyhxs0L89J6HiNTMyS549BMZ+uYDoC9mMhPJ74IimXJLcqLfCJCCvFsvNE5ZviSVP9Sbf5sSnf
 0i8TqCcN0Wn9/NEicKNDRY0OK2RxkMMR8xpwcn1EsENmaE+pCrRVrczF/gLb3PaSR+UuswFK4OQ
 LNygm1PzMz5QHg8xhBKSc1gAu5GoSh/lQjBj2LKTEWUURpBAvkA1ZxF2ezIfiKu6+vujAEXZZtP
 sfXK8M+sCNGAa7Ql0xZ5Kkfjoe0dr52GvRuSwTzYbKPy7OprAknVI2EiUxJz0pSVpxhTQptp+OR
 MRfZPNng1biqIuZfzT1j41vNGanpU9tE/OtAMR3sJ3ebAB8D+tCLM14o9xMw7WN/uLVA==
X-Received: by 2002:a05:600c:4f88:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-49050ebb9e0mr295651755e9.5.1779824742201; 
 Tue, 26 May 2026 12:45:42 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm353132855e9.0.2026.05.26.12.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 12:45:41 -0700 (PDT)
Message-ID: <aa810589-f2ab-43ac-a3a9-7717d06df92d@linaro.org>
Date: Tue, 26 May 2026 21:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
Content-Language: en-US
To: Mohammadfaiz Bawa <mbawa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260526164716.689664-1-mbawa@redhat.com>
 <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
 <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
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

+Richard/Pierrick

On 26/5/26 20:07, Mohammadfaiz Bawa wrote:
> On Tue, May 26, 2026 at 11:13 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>>>
>>> memory_region_init_ram_device_ptr() requires the target page
>>> size to be finalized, which has not happened during
>>> instance_init. Calling it from tpm_tis_sysbus_initfn() causes
>>> an assertion failure when the device is introspected without
>>> being realized, for example:
>>>
>>>    $ qemu-system-aarch64 -device tpm-tis-device,help
>>>    qemu-system-aarch64: ../system/physmem.c:2524:
>>>    qemu_ram_alloc_internal:
>>>    Assertion 'target_page.decided' failed.
>>>    Aborted (core dumped)
>>>
>>> Property introspection only calls instance_init, never
>>> realizefn, so moving the memory region setup to realizefn
>>> avoids the crash while keeping the device fully functional
>>> when actually used in a VM.
>>>
>>> Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
>>> and the corresponding sysbus_init_mmio() from
>>> tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
>>> them just before the existing vmstate_register_ram() call.
>>>
>>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>>> ---
>>>   hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
>>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>>> index 6bec30c36f..33fe9e332c 100644
>>> --- a/hw/tpm/tpm_tis_sysbus.c
>>> +++ b/hw/tpm/tpm_tis_sysbus.c
>>> @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>>>   {
>>>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>>>       TPMState *s = &sbdev->state;
>>> -    size_t host_page_size = qemu_real_host_page_size();
>>
>> This is asking about the host page size, so why does it wind up
>> asserting about the target page size not being fixed ?
>>
>> thanks
>> -- PMM
> 
> The host_page_size line itself doesn't cause the crash -
> qemu_real_host_page_size() is safe to call anywhere. It was
> moved simply because it has no other consumers in initfn.
> 
> The actual crash comes from memory_region_init_ram_device_ptr()
> - which calls qemu_ram_alloc_internal(). In there, line 2522
> evaluates TARGET_PAGE_SIZE: align = MAX(align, TARGET_PAGE_SIZE);
> 
> With CONFIG_DEBUG_TCG, TARGET_PAGE_SIZE expands through
> TARGET_PAGE_MASK which contains: assert(target_page.decided)
> 
> That's where it blows up: the target page size hasn't been
> finalized yet during instance_init.
> 
> Thanks
> -- Faiz
> 
> 


