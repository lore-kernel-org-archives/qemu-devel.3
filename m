Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3D0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbdFf-0005Uk-7g; Wed, 07 Aug 2024 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sbdFd-0005MH-3D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:46:37 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sbdFa-0002uG-NE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:46:36 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb7cd6f5f2so1219315a91.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723023993; x=1723628793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1AVB994S6wq7qsb2iXuG97I7XsPOLeMXxwdjd2d7eWU=;
 b=McPPNAAhXWSekoiyG6oK2qNvrOes749AxacwLTzd+mf452/blQPzE5RtrPMLi9bjrF
 kPAotP/1YlwtxZT5XMBrYyekN1WyOfWMdL5nKC5zcl6c/+GhGCYJYiRmDfwrZa2Mysf8
 cBQUfItO1kq8BhPqLVTyP/vWbbfXK1zZWA+z0x7NtDb0EecK/5CZSBR9NkKd8ZJ2DCZl
 NuzSllcOaRiHsXlscoU0QL3GCwfnCBvcsSlM5Z7DvniTBkUcZ+qnWO+twKFfEPaCH6t5
 N1WxZKPzYn9t+xxEnFKbAGS7tjQcglGLlLt4vgpZFcpvfihogLc1p8jvux/t0rwfihCQ
 lT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723023993; x=1723628793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1AVB994S6wq7qsb2iXuG97I7XsPOLeMXxwdjd2d7eWU=;
 b=qh4DRNcGAazfQetWEZpRCODrL6jwpJa3VaOMKOPodHyuiJ2sDDLj7eX62yp74855tb
 MpKJ45BgS9njyTRp4XUAxO68zDjthj3h2MjYK+cyVeF1IqLFmglD+f98EArNWrOqUp6g
 JQt9sIc96xvIPNjSJJ1NQMXqD0A2iGyWRJFyy32hBrSiOzBy09g+HcM4mbCGtzfflyIu
 7si48Enrn7Sx7MmTQmOS/wZWecbYJv5y+3IVAOWnJoWdKiixDqdBqsScIIlQtNfFh3xO
 RzQR6TpjVFtjPeCrtUZ0ZSzXVopJWdDEmGMX4Ar6klpe1qf0ah3HrCjHJZ5tyAyPajYn
 A2lw==
X-Gm-Message-State: AOJu0Yw3bgtEZWIZXUKRe01qU/Rl9sdv2tFhNSNgyKvPnlbxpZNofRBO
 VAMrNdoKj7IpxSHsQq1BZKgk9/6xw5bWbXxoNjeVJZQa4luBRz4EE7mcncD/q3U=
X-Google-Smtp-Source: AGHT+IFReYia2C0UIlPYrdAu/GwI7f9q0xzsCe8JYhSz2Uc3T+R7yonGEAAnV+xlwAH3YjKaMOs4fg==
X-Received: by 2002:a17:90a:c70f:b0:2c8:bf72:5389 with SMTP id
 98e67ed59e1d1-2cff93c61a1mr20625700a91.9.1723023993329; 
 Wed, 07 Aug 2024 02:46:33 -0700 (PDT)
Received: from [192.168.68.110] ([177.18.66.246])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b5d75668sm878552a91.11.2024.08.07.02.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 02:46:32 -0700 (PDT)
Message-ID: <82bfdc2e-317b-4379-b16b-c3abd0a6fdbf@ventanamicro.com>
Date: Wed, 7 Aug 2024 06:46:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qom/object, accel-system: add support to Accel
 globals
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 berrange@redhat.com, eduardo@habkost.net,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-3-dbarboza@ventanamicro.com>
 <87bk2ekr8p.fsf@pond.sub.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87bk2ekr8p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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



On 7/31/24 3:30 AM, Markus Armbruster wrote:
> I apologize for the delay.
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
> 
>> We're not honouring KVM options that are provided by any -accel option
>> aside from the first. In this example:
>>
>> qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>>      -accel kvm,riscv-aia=hwaccel
>>
>> 'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
>> option that set 'riscv-aia' to 'hwaccel'.
> 
> The way you phrase this, it sounds like a bug.  But as far as I know,
> -accel is meant to have fallback semantics: we use the first one that
> works.
> 
> Perhaps:
> 
>    -accel has fallback semantics, i.e. we try accelerators in order until
>    we find one that works.  Any remainder is ignored.
> 
>    Because of that, you can't override properties like this:
> 
>        qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>            -accel kvm,riscv-aia=hwaccel
> 
>    When KVM is available, 'riscv-aia' will be set to 'emul', and the
>    second -accel is ignored.  When KVM is not available, neither option
>    works, and the command fails.
> 
> Why would you want to override accelerator properties?
> 
> Aside: not diagnosing obvious errors in fallback options we don't use is
> not nice.  Not this patch's problem.
> 
>> A failed attempt to solve this issue by setting 'merge_lists' can be
>> found in [1].
> 
> I guess this failed because it destroyed the fallback semantics.
> Correct?

If by 'fallback' you mean the idea where we would use -accel kvm -accel tcg, where
we try to use KVM and then, if not available or failed, we use TCG, yes. That was
the reason.

To make that work I needed to homogenize all -accel options, i.e. it wouldn't be
able to have both TCG and KVM as -accel options in the command line, otherwise
something setting 'merge_lists' in a command line like this:

-accel tcg -accel kvm,propA=true -accel kvm,propB=false

would yield

-accel tcg,propA=true,propB=false



> 
>>                A different approach was suggested in [2]: enable global
>> properties for accelerators. This allows an user to override any accel
>> setting by using '-global' and we won't need to change how '-accel' opts
>> are handled.
>>
>> This is done by calling object_prop_set_globals() in
>> accel_init_machine(). As done in device_post_init(), user's global
>> props take precedence over compat props so object_prop_set_globals() is
>> called after object_set_accelerator_compat_props().
>>
>> object_prop_check_globals() is then changed to recognize TYPE_ACCEL
>> globals as valid.
> 
> Would it make sense to enable -global for user-creatable objects
> (-object), too?


To be honest, I'm not sure. I can't talk on the motivations to have -globals
for devices, but if the same reasoning applies to all other objects, I think
it's ok.

As far as -accel goes I really thing that the elephant in the room is that
-accel is an oddball. "-accel kvm -accel tcg" being a thing is weird. Why not
-accel kvm,fallback=true if we want a fallback mechanic for KVM? Do we have
a strong use case (i.e. libvirt) to keep this mixed accel options around?

Note that this patch doesn't make things particularly better: I'm using globals
to emulate what should be regular command line behavior for -accel. It's kind
of a cope out for a more complex issue.

> 
>> Re-using the fore-mentioned example we'll be able to set
>> riscv-aia=hwaccel by doing the following:
>>
>> qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>>      -global kvm-accel.riscv-aia=hwaccel
> 
> I'm confused.
> 
> -accel kvm,riscv-aia=emul creates accelerator kvm (which is an instance
> of class "kvm-accel") and sets its property "riscv-aia" to "emul".
> 
> -global kvm-accel,riscv-aia=hwaccel changes the (global) default value
> of class "kvm-accel" property "riscv-aia".
> 
> Are you *sure* your example sets "riscv-aia" to "hwaccel"?

It does. Verified with printfs and debugs. I copied what's done for -devices and
applied to -accel, which means that the global value is applied after the command
line options, doing an overwrite on whatever was set before. You can see that
happening in accel_init_machine() in this patch.


Thanks,

Daniel

> 
>> [1] https://lore.kernel.org/qemu-devel/20240701133038.1489043-1-dbarboza@ventanamicro.com/
>> [2] https://lore.kernel.org/qemu-devel/CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com/
>>
>> Reported-by: Andrew Jones <ajones@ventanamicro.com>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 

