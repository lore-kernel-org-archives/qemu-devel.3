Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C63C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 20:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXRDc-0005ck-ED; Fri, 26 Jul 2024 16:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sXRDb-0005c6-0A
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:07:11 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sXRDY-0007LT-9f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:07:10 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7a36f26f3so8832236d6.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1722024426; x=1722629226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8AuOzx/9Y1jYZv2yiLo/KkLdwmdsh+pVv3XmCSdHBx0=;
 b=g2Ou1jFZ5U60qOFkYU79znxV8x5Xq/LcRYdxoilhp2h8E+De3nvynv3KEyi/O0FAPO
 XSG/tfxY+1jJG3FCfAPt3hlHHfQfHh5AdjgPmWjRfVYwd0IH2cxQk8L9JBYrE2k0v2oL
 obWZP0+/Pecxp+m74s06puNu7tK0AsiSUAaKkXUYvA3Nv8w0wRpCRbn4m2zf+t7ji9pJ
 V/yYr9TD8Iv/r0pMgA5XHiuyQP+stOYEUn64Z9s1DZ8A4OOGXimC3ZKLxOfaZEDH6NhG
 bAZpBcBFg84m8bpG34aG0BD40Ftug7/T+5HOfikAZPf8RLq9u/valSuby1XHebjyree+
 ORrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722024426; x=1722629226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8AuOzx/9Y1jYZv2yiLo/KkLdwmdsh+pVv3XmCSdHBx0=;
 b=QFpzsSBefer1krAEfXcTSNEv9z/9iwjd8KecAt6hYXLEm42vTRrCTj/MdDmUF1o/nA
 Ww2LWRF6JUDtNiNx+4l1baKyPshwGPaoAwuiaGtFQJxzmm1UZJl+ByH5i5gtgghQRlSI
 ct3rdWTa5JGq4fquqUErsZdDxR1Sb4BN0CKM2EpZ7C56wjoIx6JY/1LhjK5XIzUy/xqe
 AZq2yc1bwcqewq6dB+ImLri0T6GJwcUl1ipoW1PoU8PtMgoHadkMvuKPJNZJye3r5Xta
 zjSYZ9MLgTJWBOFKNdvw0pMPE1GGXfLM3YwrRWjYFZ/9z5fplpXTVGlk7e/P5sdB+HBu
 NWqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYYOCzomu0bgjz80kImmrAyD59BGXH+aZ7S1t8k+IskSq1pqSpeCuy1mJM+owk762+zf1g+op6K29AU9NYywCXUJDF1tc=
X-Gm-Message-State: AOJu0YwoNIqkQ6KzQy775NWdHunjxlglluLXozxY3JMzKVAHcFeJEIE1
 eaAaXC7rEyy7z/DAvzg3tlGAOziVz4v/jebnqQyC4HtOY1Cm0Z4NtBBorWhqWQ==
X-Google-Smtp-Source: AGHT+IG3aJB+5BJo18nTT9fK2s1DfrSsqbPmpIabC0qvauSn6HeRol2VmvsPya3RQvUgmMqb1TnsZg==
X-Received: by 2002:a05:6214:514e:b0:6ad:84aa:2956 with SMTP id
 6a1803df08f44-6bb563091b2mr11186376d6.13.1722024426496; 
 Fri, 26 Jul 2024 13:07:06 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3fa94e57sm19556456d6.85.2024.07.26.13.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 13:07:05 -0700 (PDT)
Message-ID: <27646d48-3565-4b72-8d23-f825edcacbf1@cs.unc.edu>
Date: Fri, 26 Jul 2024 16:07:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] Add an "info pg" command that prints the current
 page tables
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <20240723010545.3648706-4-porter@cs.unc.edu>
 <d3316e48-e601-4a43-b77e-2bf127d91a7a@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <d3316e48-e601-4a43-b77e-2bf127d91a7a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Richard,

Thank you for the feedback.

On 7/23/24 11:33 PM, Richard Henderson wrote:
> On 7/23/24 11:05, Don Porter wrote:
>
>
>> +    if (env->hflags & HF_GUEST_MASK) {
>> +
>> +        /* Extract the EPTP value from vmcs12 structure, store in 
>> arch state */
>> +        if (env->nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) {
>> +            struct vmcs12 *vmcs =
>> +                (struct vmcs12 *) env->nested_state->data.vmx->vmcs12;
>
> This is not required.  You appear to be confused by nested paging.
>
> First: nested paging is how hardware virtualization works.  When we 
> are *using* hardware virtualization, all of that is the kernel's job.  
> Our job as hypervisor is to give a bag of pages to the kernel and have 
> it map them into the guest intermediate address space.
>
> When we are *using* hardware virtualization, we are only ever 
> concerned with one level of paging: from the guest to the intermediate 
> address space.  From there we use QEMU data structures to map to QEMU 
> virtual address space (address_space_ld/st, etc).
>
> This is all we will ever see from KVM, HVF etc.
>
> With TCG, we can *emulate* hardware virtualization.  It is at this 
> point where we are concerned about two levels of paging, because QEMU 
> is handling both.

I actually think we are close to the same understanding, except that one 
can use KVM to emulate (well, pass through to) Intel's virtualization 
hardware for a guest (TCG does only appears to support AMD's hardware 
virtualization interfaces), which is a use case I care about for my course.

One of my test cases for these debugging features was to have a simple 
guest/nested hypervisor running on emulated VT-x hardware. As in, the 
"guest" code enters VT root mode and sets up a VMCS and EPT, and 
launches a guest, etc.

My understanding is that when one uses kvm in this way, in the kernel 
kvm creates shadow page tables to merge the guest hypervisor and host 
hypervisor's tables transparently to the guest.

My reading of the KVM code is that this ioctl is the way that emulated 
architectural state (like the vmcs) is synced from the kernel back to 
qemu.  I don't see another KVM API for getting things like the extended 
page table root and certain VMCS configuration flags that one needs to 
walk the page tables.  Most of this state is not currently exposed to 
debugging features in qemu, which is why this definition was not needed.

I am open to other suggestions how to get that state, like the EPT root 
pointer, from KVM.  Perhaps I am missing something.

----

I will admit the intermediate address space is a lot to get one's head 
around.  I believe I have consistently used appropriate 
address_space_ld/st and friends at this point.

Thanks again,

Don


