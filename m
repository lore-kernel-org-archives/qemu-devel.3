Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30EBC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 20:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxBZH-00063a-W3; Wed, 17 Apr 2024 16:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxBZF-000635-J5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 16:07:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxBZD-0000fq-Lj
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 16:07:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so182449b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713384458; x=1713989258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tcTq2KpScTlws07ObRAiC//XPp8pHFLk1BZM5ydL3M=;
 b=h8QzEhvsradVqDq+vVXw7W+nYcnBd73teAsfOqTBiAn0dZd3mlecFwHFUoYXcx6oak
 MevkqV/V2JdTHye9ARyYMIFgbXJp9y31ulj8CvZvUFokpANW3iKvpidOQOEJ2A5ZuZiQ
 3R98p203cB5kiQM9G3Otua7SMXZEpOsVR9t6yVEQyZj0MTNylm0hjdyTdEZ13gdHi22Z
 1xDTn4ezQNJnc0+xvBoRYTqTtu/un7Dbub/nj2fuuzzvOOWZi05D+fciJNbVxkUtHcEO
 oHKnY7mybbp8vfSwMslEDpgrFk+CwGxuaQUNUuTqGGgQwwbWZPKJue/faQ/XaqLT/s0r
 Jn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713384458; x=1713989258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tcTq2KpScTlws07ObRAiC//XPp8pHFLk1BZM5ydL3M=;
 b=ginSWZ8bY+YgrAJrnpZH0V8+qLP8jffUg8rCiNhS7y0IjkvvZDNw7K+01E+zpDvITe
 BWUQWEMXSfgXPlvP/7n3OAglBAK+2elYi3KLdE/rpSxQfypXQ1AJoN4BNkqKe91wUvCM
 GwDPLojkpuxmXIQ5RPuGp994ASbHSmEi52L0xtL8sGXNv6TI9mQwVt4UZrJhcfGLZRiL
 sY90EANfpfp7IG0CHx8oShpMFFVa+USa/6MAFQDXMA9+XdGOdh49juszGMYKNFBQWzCc
 sEc9yzYmp9VO7MKLFB7ug13JhWw4CygKVbldy7uGS+zs2hhR+fX0l6+89AEdna1MoL9M
 cKfQ==
X-Gm-Message-State: AOJu0YxgP/qpl5vIRMcjw2IWmxNuyzuBiwYp3fn15q2/w1tMZUgzMHdc
 JNzuf9sOQO/XBgi4kGglObGteztTf9kBYw95Tj3uVqrXKeipJJMmTHOL3g9j9wk=
X-Google-Smtp-Source: AGHT+IGd/Lf0BXKayVixwkXklJn2/801rj5nxuRCrFw0NLBzqPMVL6xjMgD/T1SdmRW/IUXz0QsWow==
X-Received: by 2002:a05:6a00:198e:b0:6ed:e1c:1035 with SMTP id
 d14-20020a056a00198e00b006ed0e1c1035mr688575pfl.28.1713384458019; 
 Wed, 17 Apr 2024 13:07:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fb33-20020a056a002da100b006ed14fed3a5sm52917pfb.154.2024.04.17.13.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 13:07:37 -0700 (PDT)
Message-ID: <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
Date: Wed, 17 Apr 2024 13:07:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] target/arm: Do memory type alignment check when
 translation disabled
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Idan Horowitz <idan.horowitz@gmail.com>, linuxarm@huawei.com
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416161111.0000607c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/16/24 08:11, Jonathan Cameron wrote:
> On Fri,  1 Mar 2024 10:41:09 -1000
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
>> If translation is disabled, the default memory type is Device, which
>> requires alignment checking.  This is more optimally done early via
>> the MemOp given to the TCG memory operation.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hi Richard.
> 
> I noticed some tests I was running stopped booting with master.
> (it's a fun and complex stack of QEMU + kvm on QEMU for vCPU Hotplug kernel work,
> but this is the host booting)
> 
> EDK2 build from upstream as of somepoint last week.
> 
> Bisects to this patch.
> 
>   qemu-system-aarch64 -M virt,gic-version=3,virtualization=true -m 4g,maxmem=8G,slots=8 -cpu cortex-a76 -smp cpus=4,threads=2,clusters=2,sockets=1 \
>   -kernel Image \
>   -drive if=none,file=full.qcow2,format=qcow2,id=hd \
>   -device ioh3420,id=root_port1 -device virtio-blk-pci,drive=hd \
>   -netdev user,id=mynet,hostfwd=tcp::5555-:22 -device virtio-net-pci,netdev=mynet,id=bob \
>   -nographic -no-reboot -append 'earlycon root=/dev/vda2 fsck.mode=skip tp_printk' \
>   -monitor telnet:127.0.0.1:1235,server,nowait -bios QEMU_EFI.fd \
>   -object memory-backend-ram,size=4G,id=mem0 \
>   -numa node,nodeid=0,cpus=0-3,memdev=mem0
> 
> Symptoms: Nothing on console from edk2 which is built in debug mode so is normally very noisy.
>            No sign of anything much happening at all :(

This isn't a fantastic bug report.

(1) If it doesn't boot efi, then none of the -kernel parameters are necessary.
(2) I'd be surprised if the full.qcow2 drive parameters are necessary either.
     But if they are, what contents?  Is a new empty drive sufficient, just
     enough to send the bios through the correct device initialization?
(3) edk2 build from ...
     Well, this is partly edk2's fault, as the build documentation is awful.
     I spent an entire afternoon trying to figure it out and gave up.

I will say that the edk2 shipped with qemu does work, so... are you absolutely
certain that it isn't a bug in edk2 since then?  Firmware bugs are exactly what
that patch is supposed to expose, as requested by issue #1204.

I'd say you should boot with "-d int" and see what kind of interrupts you're getting very 
early on.  I suspect that you'll see data aborts with ESR xx/yy where the last 6 bits of 
yy are 0x21 (alignment fault).


r~

