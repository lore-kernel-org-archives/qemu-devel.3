Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E418CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPfH-0001mv-CN; Wed, 27 Mar 2024 05:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPfF-0001gy-09
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:33:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPf4-0000OT-0w
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:33:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6f69e850bso5887665b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711532012; x=1712136812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHTl8gYlsmXfu+P4KVuboaLUZSbMsj4ZZeM4VMTTSS0=;
 b=NK9mBEBWY1Hkoy0GXmIp+fAY3UvLvUfirjedPhGVTPrHNl9uV1pOiN162BUCdY1TsG
 ssXu+7WTR1QH86ts3DqIu5JEyJXBtsmito4/YQYOduwsD019tkp/Q0KSatlQ2a8k//s1
 MI7RXAietoPo7SvMDL6s8PPQrT/7R7v/YGlfWcMrgGUvmZ/25E9XMNMkTgRnD6ZpYmpr
 sXmk6qfVcEAKHK7VLWFJrRe2jdEzc/+bQeYeqLI6VQYvbXlVFsvq9kAWevUbc+0fWhHk
 eSrz446FUZop43kvD2M31p8+TVgj7X8dcI/k/fqqQT5e0g9lVEBhlkwL4IFlyRaRPH6o
 GJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711532012; x=1712136812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHTl8gYlsmXfu+P4KVuboaLUZSbMsj4ZZeM4VMTTSS0=;
 b=MN7eg89R6AdcX463mCwvBaA4ks5ZEDUZOCywvd39+llMlpIHxt3waz5b+t8S3NqqTa
 MeI1uKVHKPU4c/34CKplUhLVbQyaqZ1RGfH6hBGwFto62O02megPoHYsCny0sXueViUc
 wWWlCOr1M4Ghej3rSxiAdh95u063ZCr6fE6aj22R+YNjvnZ4JSqRQI4nFemzBmBFYaIa
 NFgb9GwsHvlW36x/Z8ZZBFxqnK5e2ct6osRUB3hCE92DZn9ZeucfKiSfCDKRPBCnGs/Q
 8GsCp5PDMOOqV9nKjtkhP2Ad0AygW3PEJHZZkY0Ae9ikauGeA+paxNLbrlVEDrZzFq88
 sS0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ruWKReluNc+q9jQzm+b7vc8BecgxOdNJT5ipjK6p0iE873ypNWS+FmsOgIwefZ7bECxx7Dra6wQvnH+fSYbHFlYg7jY=
X-Gm-Message-State: AOJu0YwyZ21IL/wte1Pr/fTn+qp2BEs9hP6lmkOY9naaTNwq95FMZEo4
 F67Ivs4Eg+aAA3aZ82LoYyYUCWz954gKSj7F+N5nlilOCdS+YmYUcMM2ZRDkV94=
X-Google-Smtp-Source: AGHT+IFXo6sqV8t49TDIJlir5M6N8ZgariqGKvpHHSc9CMWzOOw2m36pha61HVyGXUAeciTWp93fsA==
X-Received: by 2002:a05:6a20:12c1:b0:1a3:be07:7c00 with SMTP id
 v1-20020a056a2012c100b001a3be077c00mr3986536pzg.3.1711532012645; 
 Wed, 27 Mar 2024 02:33:32 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a170902ce8100b001dd6ebd88b0sm8474240plg.198.2024.03.27.02.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 02:33:32 -0700 (PDT)
Message-ID: <f968c2ac-4056-47bf-af87-70534db82035@ventanamicro.com>
Date: Wed, 27 Mar 2024 06:33:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz
 <groug@kaod.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, peter.maydell@linaro.org
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <20240326180550.3072dd2d@bahia>
 <1f73d065-fcf6-4466-bc86-c8fdbae7bd96@ventanamicro.com>
 <190171404.Ysjo4HZYI3@silver>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <190171404.Ysjo4HZYI3@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 3/27/24 05:47, Christian Schoenebeck wrote:
> On Tuesday, March 26, 2024 6:47:17 PM CET Daniel Henrique Barboza wrote:
>> On 3/26/24 14:05, Greg Kurz wrote:
>>> On Tue, 26 Mar 2024 10:26:04 -0300
>>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
>>>
>>>> The local 9p driver in virtio-9p-test.c its temporary dir right at the
>>>> start of qos-test (via virtio_9p_create_local_test_dir()) and only
>>>> deletes it after qos-test is finished (via
>>>> virtio_9p_remove_local_test_dir()).
>>>>
>>>> This means that any qos-test machine that ends up running virtio-9p-test local
>>>> tests more than once will end up re-using the same temp dir. This is
>>>> what's happening in [1] after we introduced the riscv machine nodes: if
>>>> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
>>>> this is what happens:
>>>>
>>>> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
>>>>
>>>> - virtio-9p-device tests will run virtio-9p-test successfully;
>>>>
>>>> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
>>>>     first slow test at fs_create_dir() because the "01" file was already
>>>>     created by fs_create_dir() test when running with the virtio-9p-device.
>>>>
>>>> We can fix it by making every test clean up their changes in the
>>>> filesystem after they're done. But we don't need every test either:
>>>> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
>>>> i.e. a dir is created, verified to be created, and then removed. Fixing
>>>> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
>>>> both. The same theme follows every test in virtio-9p-test.c, where the
>>>> 'unlikat' variant does the same thing the 'create' does but with some
>>>> cleaning in the end.
>>>>
>>>> Consolide some tests as follows:
>>>>
>>>> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
>>>>     fs_create_unlinkat_dir();
>>>>
>>>> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
>>>>     fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
>>>>
>>>> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
>>>>     fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
>>>>     creates is now being removed.
>>>>
>>>
>>> The  change looks good functionally but it breaks the legitimate assumption
>>> that files "06/*" come from test #6 and so on... I think you should consider
>>> renumbering to avoid confusion when debugging logs.
>>>
>>> Since this will bring more hunks, please split this in enough reviewable
>>> patches.
>>
>> Fair enough. Let me cook a v2. Thanks,
> 
> Wouldn't it be much simpler to just change the name of the temporary
> directory, such that it contains the device name as well? Then these tests
> runs would run on independent directories and won't interfere with each other
> and that wouldn't need much changes I guess.

That's true. If we were just trying to fix the issue then I would go with this
approach since it's simpler. But given that we're also cutting half the tests while
retaining the coverage I think this approach is worth the extra code.


Thanks,


Daniel



> 
> /Christian
> 
> 

