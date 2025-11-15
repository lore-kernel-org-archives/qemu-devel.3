Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C4CEB2CB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 10:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKDzT-00057i-Pz; Sat, 15 Nov 2025 05:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vKDzP-00057G-9I
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 05:58:44 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vKDzN-0001ci-No
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 05:58:43 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso1389117b3a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763204320; x=1763809120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWzZAEqKEpQ5g4Raim42KUlzsjVTdvUfZluGpPw+PIw=;
 b=DfVlX8+bVeC78FjOlMOY60K56dyLX/lLZ05MdN0Fox3UcBr8of+hIVPMVLJJqvFa9h
 sKOomDRdPN95Np5BB+v2f2dIrdAIVCk+G9U5PFFCjOPLE6zPWjbLaxU+NBzgHTxYWqOl
 lwVPz1oy4k0KxAsAfPTQ4cE5pKvj3XXywpwJ0PjfHShD0b0s3O9JX5z9gR3SSfTKDkDF
 Q1gg2Jwgkw39iLzfzm+XjhQkrT8wvEcNo99O3LPbXVCQ7177qR8jOPGTrvCPw5fSw1lj
 fcw5pc2TY0MO1uGYD+9lPE9FQ5xKZLdvB4TDIPJIOM91/0tzbjZ8krw8skF7regg1GkS
 y6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763204320; x=1763809120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWzZAEqKEpQ5g4Raim42KUlzsjVTdvUfZluGpPw+PIw=;
 b=auU8IChj9VbORH90ZnypKTaCd2LqqZcY/jqMo5zrOC8mWz6Zvb7TXoUoX5itxf4k3z
 DOuRl7lcNLMopqgPlWNaAfF8ocLSo30A+z3OJbXinQqmMNyYyvOl5P1cLyVtGf8d3tYK
 HiW4USs7PzcvlrQu602wIlWaErObRPuw2YrZjSEyvV7hI6tTRZMT/wu0efV49COBB2KF
 A1tBvFNBgZ9JtM453FuPpqO2DYiatG5gqBPmZe1xZOGEfypzmm9NaIjRO1jCcUdg3T6E
 X5W7JwVXpDEaOwST2RPQ5GlnWqIMxP/RJsc6k234xt6ujx6gPTlfNVUjFJFWWG6TLZIU
 qHPw==
X-Gm-Message-State: AOJu0Yy3XjGGepSbsIu8Kt95mt8Yad2SiKIF50E5a6bYVldBtHChpyAW
 yW2ukB1eLmjjjxTxkW8esPc+EQl/H5sKiHUbqTQZd6H4Z7GlRwFCfawi
X-Gm-Gg: ASbGncvWsbYf8ivK0Vcfp4bxR+0GDv97GYaoBdzJAiGcljeSnCoTbA3f1QS0HRPSFra
 SaJARGX66dKVDu7pg/Btw6uIPVOKB/NT5u+c52f3spYe3KxXYo2zdR+bhUEtzRhMFozk0OzH4wA
 9oidSaiIMM24o0HivFUKJRC8gj7X8AWRBOFQ8KwNDVuNqdOYpY/AWQN0pWSMU/ZudOn90Gu5HT6
 c8/Nhz2zCsU/wHqBjt/hDJBO+K7WQzDwsq0JXhUrkJpfS7zEKNxGHRn3xXr03tird8Ig9JOSRJ3
 QfyOEhnqHdYWIMe/8Q5tXV2EvG3gzY+BVLttYWTqR8sEdBnteOisrT2uZ4W2IADD4pjxy1FyIQJ
 fQ2oyqmtxWmHTgBRMk4IkVr72bHnksDCx1KFw/LWQpk/55ktqXFn3zR17z4QDykIF/fsC3k5C+F
 dYWv2Xcw1wjQrnCnr0wP+N2Wq5P91eB4Qi8UVpzbKqHN6P3PmwzUalE0qJ0ZGh6R/aalIRbSjtZ
 eFfUQWn8q6N6b3DEGq6bJWgr1+5tVovlr+I5Q==
X-Google-Smtp-Source: AGHT+IHqQHUfS9WBcYdybcoPf9PrURkdJ/Uv+ZWBrRIDoWsaoakfS+H3qN78bgSzEDbWomNrGmisXg==
X-Received: by 2002:a05:6a21:33a1:b0:344:8ef7:7a03 with SMTP id
 adf61e73a8af0-35ba2992e6dmr9219916637.56.1763204319790; 
 Sat, 15 Nov 2025 02:58:39 -0800 (PST)
Received: from [172.27.236.38]
 (ec2-13-250-3-147.ap-southeast-1.compute.amazonaws.com. [13.250.3.147])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc375fe47a0sm7037483a12.29.2025.11.15.02.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 02:58:39 -0800 (PST)
Message-ID: <d1782dd6-285e-454d-bd81-25896eb21bd3@gmail.com>
Date: Sat, 15 Nov 2025 18:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vsock support for communication between guests
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
 <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
 <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
 <CAGxU2F5ag+gfhpCOpT_AQ_41GYhxs7U-tHMadUEN_gTUoeDqRA@mail.gmail.com>
Content-Language: en-US
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <CAGxU2F5ag+gfhpCOpT_AQ_41GYhxs7U-tHMadUEN_gTUoeDqRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 11/10/2025 7:10 PM, Stefano Garzarella wrote:
> On Sun, 9 Nov 2025 at 14:13, Robert Hoo <robert.hoo.linux@gmail.com> wrote:
>>
>> On 11/6/2025 10:32 PM, Stefano Garzarella wrote:
>>> On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
>>>> Hi,
>>>>
>>>> Does vsock support communication between guests?
>>>>  From man page, and my experiment, seems it doesn't.
>>>> But why not?
>>>>
>>>
>>> It depends, vhost-user vsock device, supports it.
>>> See
>>> https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
>>>
>>> The vhost-vsock in-kernel device doesn't support it.
>>>
>>> The main problem is that vsock is designed for host<->guest communication, so
>>> implementing a guest<->guest communication is possible, but requires more
>>> configuration (e.g. some kind of firewall, etc.) and also an extension to the
>>> address (see the required
>>> `.svm_flags = VMADDR_FLAG_TO_HOST` in the link).
>>>
>>> The easy way to do that with vhost-vsock, is to use socat in the host to
>>> concatenate 2 VMs (some examples here:
>>> https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)
>>>
>>> Cheers,
>>> Stefano
>>>
>> Nice, thanks Stefano. It sounds ideal for my VM <--> VM communication
>> requirement. I'll read the doc carefully later.
>>
>> BTW, I also found your vsock-bridge
>> (https://github.com/stefano-garzarella/vsock-bridge); but seems its last commit
>> was 5 yrs ago. It's not recommended, is it?
>>
> 
> Oh, that was just a little exercise I did to learn Rust at the time,
> so I'd say no, it's not recommended.
> BTW `socat` supports a similar use case, so related to the example in
> the vsock-bridge's README, you can do the following:
> 
> host$ socat VSOCK-LISTEN:5201 VSOCK-CONNECT:4:5201
> vm_cid3$ iperf --vsock -s
> vm_cid4$ iperf --vsock -c 2
> 
> But yeah, it's not 2 ways like vsock-bridge (i.e. `vm_cid3` can't
> connect to `vm_cid4`).
> 
> Cheers,
> Stefano
> 
Thanks Stefano.

