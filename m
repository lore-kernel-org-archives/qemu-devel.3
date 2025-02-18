Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B116EC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkNVn-00079I-Dy; Tue, 18 Feb 2025 08:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkNVl-000791-Dr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:19:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkNVj-0005pI-AR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:19:41 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso17845605e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 05:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739884776; x=1740489576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9jOWDgWdgm3WlBmHZkzJFmY7KFSm2K7SI7318/JBa0I=;
 b=cmQerR0F/sSgGfjz7hGooucPCuT7VBuj24QnBnidXhXWvK25NKifmS2DCHnqsastH+
 j6B1qwXzQPeTl2mvdsARdH/6xXWrWxYs5GBVd1PrTTNeir8VwteoXK+T6U5P/p/24J5Z
 Rwxcw+/ZTvrt4omsH0aDqzikrtf08N4E/NqlaVoBRwKcl3CzSU/UEAsxALj0SND/7oYX
 4Wp+a0hjfGQQxvENjSxFgYpUEiVI82zGwnNx/bkOzL5OAKDrdSx+DmZUdjzM6/YBCexe
 77R865fiCBeOR0Vs/Ur2NY3+aT5NR0wEcVdMNyhsNk4mmfsYEwLAscpFvkP7//fNg6HR
 vDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739884776; x=1740489576;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9jOWDgWdgm3WlBmHZkzJFmY7KFSm2K7SI7318/JBa0I=;
 b=CPdY/5dN3fJifvRIzGUQHr6iVgpEGMYoYdgKxN3MXEccJCNpACEuMYMVTD0Q9BAfGZ
 v9su1ldW9jAH6l/giHKVTmeYXxJBz2P9SiAl8D1acvMU4PxtsMZDk+C8tDBwkblR7Gio
 0aQB7fiFfqJMUUXs4kLZR2C3Ahl+HNf6zSHHR0ZJAWGV9kHH8N2f7g90SY4zoIT+KGn0
 zxXeJZmfOORGtIpmBsT2/2x8RbsukGwpCevq1pJGcEp47/IDrRmNiCLozCc/3xnX9MTH
 DhYGPFJRWj9KbIybsLUGOUefnZZS7hMbf3Vk08XWlNMgJR68K7cPuqvtq+gcqXcp0D62
 C8aQ==
X-Gm-Message-State: AOJu0Yyx4Mzg5WTZoOav/SU6/2IgtmD6debs+xgaz2CUphjFNouw/3h2
 Ur6EnPV9Y8WOMPSWtEzAePel8G3xKtnChyZGWx301UoeYm/KpsHWLrxZ7jYR7tBVI0K/NS6SxBr
 HTu4=
X-Gm-Gg: ASbGnct8QzwzyesgSGa/eK5gWm08qoLP4Vj1371JtBfD9Gjt0t+zK6OIVODQFtc1FLg
 JFnCleYAHrtbYSMdMKXIs90xH1pjn0hkzXJAyPLwX1n2zjDX2A4rvtNlkV4ttFR1zaTKPI8jULb
 XUtzgUTceDm23ajo+Lin6idJyzYPBhdESe7+n+dLWdsCQ3++Ac+tgsxzKGRrFZRUCDzgHrxdane
 ksz7lXozAIMo6Yz3F5h5VnWAqXopme+KFGcMv5dbdMzSx0Ygda2GWTQw5bi40AABp/z+qfQcrCj
 k316/Pc328EGcQ7dbhszHrooKB0AeVLStmriGChN89fhTTLDu2AlUIepkBI=
X-Google-Smtp-Source: AGHT+IFqA+wta4oXzvphBFhAl3JSyZyc9j8Lmp26VteGErYposT+mqTp+MOGtS8nT9S2EAYzkKJk9A==
X-Received: by 2002:a05:600c:3b22:b0:439:8bc3:a6a3 with SMTP id
 5b1f17b1804b1-4398bc3ad73mr64046275e9.3.1739884775677; 
 Tue, 18 Feb 2025 05:19:35 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7e8sm183896475e9.26.2025.02.18.05.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 05:19:35 -0800 (PST)
Message-ID: <dc24cf43-b6a1-42b6-ac93-4128f2c03684@linaro.org>
Date: Tue, 18 Feb 2025 14:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
Content-Language: en-US
In-Reply-To: <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
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

On 18/2/25 12:20, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Adding Xen community.
> 
> On 8/2/25 21:57, Richard Henderson wrote:
>> Require a 64-bit host binary to spawn a 64-bit guest.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   meson.build | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 1af8aeb194..911955cfa8 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -304,9 +304,14 @@ else
>>   endif
>>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>> -if cpu in ['x86', 'x86_64']
>> +if cpu == 'x86'
>> +  xen_targets = ['i386-softmmu']
>> +elif cpu == 'x86_64'
>>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
>> -elif cpu in ['arm', 'aarch64']
>> +elif cpu == 'arm'
>> +  # i386 emulator provides xenpv machine type for multiple architectures
>> +  xen_targets = ['i386-softmmu']
> 
> Is actually someone *testing* this config? I'm having hard time building
> it, so am very suspicious about how it runs, and start to wonder if I'm
> not just wasting my time (as could be our CI).

This config is not tested and not functional. I'll post a patch
removing it.

> 
>> +elif cpu == 'aarch64'
>>     # i386 emulator provides xenpv machine type for multiple 
>> architectures
>>     xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
>>   else
> 
> Regards,
> 
> Phil.
> 


