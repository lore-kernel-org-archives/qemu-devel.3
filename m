Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D128D70E0D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 03:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGrlN-0004fT-Q4; Thu, 28 Nov 2024 22:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tGrlM-0004fA-EB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 22:33:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tGrlK-0005O8-4G
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 22:33:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2120f9ec28eso10849455ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 19:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1732851223; x=1733456023;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrvUXtItnywxI9klLAShU7rIn2vCxhI8lFLsH+bdSXk=;
 b=0l+pyyxMl5TnfirWHTlmz/MNvIJKKkiye/c4Y8WzZTAkjH/zLs0ccjz8AU7r3ZYk1O
 yuc0AVJGIUdbufguewQhmEbjcJVssCQZzMYR+zRe9pvtuilsSZ4Q+IBxW1lsyNUSFgpC
 vsk3VUlz1NK7KLh1Z1dSHfxH34Os+8YnLwa19pk0DyjEHSbVQE/Es/g28qwGnCJuQES3
 tTCqYldsUw6j4EUZA+SgRQiAMhDiO9Psf6VBdv/MP9xMJh/uTorIGFKXD6aF6BCEF3rn
 qv6KR89p7qUzbyisyVZzQU5INOSLcLVHOLwVfpdsEdXtdEf5Fyetwv/2T/o4Wud0InCh
 Z5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732851223; x=1733456023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrvUXtItnywxI9klLAShU7rIn2vCxhI8lFLsH+bdSXk=;
 b=REmIiaxSFJj4edlAL94WXZ93ClFExVvAe4xNirteX4Ncsb6TGt9kWzOKRc7rcAQK1K
 GtU0v3MNCPoSr/i9KSBH6HDrz09g1fdMX+eGX9O2KmhB97d62EPwd55BNNbAQLy4wcdF
 7Rw1UAHCtzB49aNss1i1RqoV8xCf8BO6wRHzCED7856bCoWnDLzckzWpNzsdNuZfUDQq
 SXPWVs0iynAkoaYXXzPaUO0Jv9hgQSTdUp/Ct5UEjS1MH1ptHt2EzvoL8D3gMg+j6GhH
 e78m8syjtOK3VdOod2bhjN2wNHlFU5NQZPTzCa8qEmNCInOxY/bJcuzwguChyMF6b5UY
 y4NA==
X-Gm-Message-State: AOJu0YyXNDYSKInUn3jic14VO6TngEY5QUYctSlt1pKTRjOzVAxwdfSZ
 CCo5+02Vn62CRoooThmJVThXg61CnNk3zvVOKzCLJtYWbpCf8vVO/ae78zTiZic=
X-Gm-Gg: ASbGncvbtHW/1LckVJAkhZJn5TAQlWWR6rKEMy7stX/gx4/gguP7NwAFubTjhkrOB7A
 etDwRu+9C4hWiLZ8pJMRwPVh4s01PrBR961WHnyT8Q9L6juGFFv51wu7obb9Y5p58OKiDJ0ui3D
 Fjjrnn4iLV5y5vcM49fGVJ+2LUl97LxO9OCyMucVOhMfMPSiul8xHeE2GtBZr4WYx51fVrwKwxs
 NtfHvCXn8Wlwx1x4kLIknQe18+S4c2XWhVuJfTgIOwLJUt93g6moBS47ZZcR7IMsgWA96HxXyA=
X-Google-Smtp-Source: AGHT+IG5+mNuZ9i/ApakAwtXSlyUNd5W/rNa2cvtIVRVqOma+51rCJ3zvP+lvs4EevHq1pFPWw8CCg==
X-Received: by 2002:a17:902:d2c9:b0:205:8763:6c2d with SMTP id
 d9443c01a7336-2151d2fde80mr93416805ad.9.1732851223174; 
 Thu, 28 Nov 2024 19:33:43 -0800 (PST)
Received: from [10.16.166.2] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219b1403sm21240255ad.242.2024.11.28.19.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 19:33:42 -0800 (PST)
Message-ID: <ce5fc614-a54c-4003-b27f-6f08e56dbf08@igel.co.jp>
Date: Fri, 29 Nov 2024 12:33:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de,
 lvivier@redhat.com
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
 <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
 <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
 <CAFEAcA85NOxbmzpCT-5jv5uvcFH2WU5zm+fRTAK-VVG6LQRLbQ@mail.gmail.com>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <CAFEAcA85NOxbmzpCT-5jv5uvcFH2WU5zm+fRTAK-VVG6LQRLbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/28 20:15, Peter Maydell wrote:

> On Thu, 28 Nov 2024 at 06:19, Tomoyuki HIROSE
> <tomoyuki.hirose@igel.co.jp> wrote:
>> Hi, thank you for your comment.
>>
>> On 2024/11/27 20:23, Peter Maydell wrote:
>>> On Wed, 27 Nov 2024 at 04:34, Tomoyuki HIROSE
>>> <tomoyuki.hirose@igel.co.jp> wrote:
>>>> I would be happy to receive your comments.
>>>> ping.
>>> Hi; this one is on my to-review list (along, sadly, with 23 other
>>> series); I had a quick look a while back and it seemed good
>>> (the testing support you've added looks great), but I need
>>> to sit down and review the implementation more carefully.
>>>
>>> The one concern I did have was the big long list of macro
>>> invocations in the memaccess-testdev device. I wonder if it
>>> would be more readable and more compact to fill in MemoryRegionOps
>>> structs at runtime using loops in C code, rather than trying to do
>>> it all at compile time with macros ?
>> I also want to do as you say. But I don't know how to generate
>> MemoryRegionOps structs at runtime. We need to set read/write function
>> to each structs, but I don't know a simple method how to generate a
>> function at runtime. Sorry for my lack C knowledge. Do you know about
>> any method how to generate a function at runtime in C ?
> Your code doesn't generate any functions in the macros, though --
> the functions are always memaccess_testdev_{read,write}_{big,little},
> which are defined outside any macro.
>
> The macros are only creating structures. Those you can populate
> at runtime using normal assignments:
>
>     for (valid_max = 1; valid_max < 16; valid_max <<= 1) {
>         [other loops on valid_min, impl_max, etc, go here]
>         MemoryRegionOps *memops = whatever;
>         memops->read = memaccess_testdev_read_little;
>         memops->write = memaccess_testdev_write_little;
>         memops->valid.max_access_size = valid_max;
>         etc...
>     }
>
> It just happens that for almost all MemoryRegionOps in
> QEMU the contents are known at compile time and so we
> make them static const at file scope.

OK, thanks! I got understand. I thought MemoryRegionOps had to be
'static const' .
I will try to improve code so that it does not require the use of
memaccess-testdev.h.inc .

thanks,
Tomoyuki HIROSE


