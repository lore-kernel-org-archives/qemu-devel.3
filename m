Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B43CCD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRSN-0003Yt-HT; Wed, 27 Mar 2024 07:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpRSD-0003Y0-4F
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:28:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpRSA-000849-Sh
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:28:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29fa10274e5so4398076a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711538901; x=1712143701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WI7D1jP8JCGZdfWAXLpf7TQ8yFh17xzr+m0j4nzM4HI=;
 b=kv28BYBsTMVtDg7xKm0Cc1qT8gvqEnG/Qo3hy/FKDlah8TkgsqGsYrrYDRteF39hvT
 N+6Vg5Y+iBGTt1e6uJ5O4puBlG3w9TA/BnY7w/D15QXLfBHLLsFNQNoTfGazEkztFgrL
 VTW8osE5+bIzIAkqJfuljj1eDGVVUEZPjSqxqOfT7Ylo2JSxhaBfO29AFo80q6TDz584
 ZUjEXQiJFCF6F/mP1AqtxgMoHvAco1Bioly5XvTNqW+y1qdQQNZ8XpQ26I8lxgGKjpr0
 8SwaBCO8bf6b8/cjRWNSPoETMNdaA9QMA31P/phSuse8bFPSA1rxGwSIcqgyjtoByDtU
 8JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711538901; x=1712143701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WI7D1jP8JCGZdfWAXLpf7TQ8yFh17xzr+m0j4nzM4HI=;
 b=uNPGUAgQh+vbt21mT9cPJ0ZpG6xTyp8bP25MuxAQaZCw60fJU/JFFLvnusUz95LhVp
 nTKplHd6ZafjXC5ddnhBhvQiMehQZKZmh7AS/iZCBQHg+gIJmeLFrIzIPNqQ9v9ADziV
 2USwh4QqqIqMbsonH16/kCyy/v0v4elEfvmOPq8vgJDbqn5FHsL0DYHymhsXcBWVKDO2
 nE0bact8EpQYAVb2rqjtt5DjzNkOzsmPoNldYZBY9FFA2mBQq9au7ha4lwj7Scw6nP7q
 1rTj48Spua1ntm032eh47wnyBKRsjXWiKQcP34OjH6JhhX3iql7Pi2NP3T5xGgAAlT3Q
 JORg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuoYxSnwP3IW6O1+Dn3Nn9mtiCRQ614/TerG22Rp038mHTzBtQ2mRIf7moQ0suPM3sJ5+ieJPudcOyZ1MzfLdYksGbcN0=
X-Gm-Message-State: AOJu0Yzx2pl8brcDrHzohyuvmcAWrBAeGhT2yYJB88tzgffHmzzPKzNL
 ux+U8BCdsE+RuEJrqP6Gylg8hMupr46FqTSgINd8hys9AepY/MCqoKjHtUTQQd8=
X-Google-Smtp-Source: AGHT+IHLP5Txjnstgc/G+Ra5esPwe8UjN+6BHIZk1GbE+Y3Zii/pRB8GUI72N/jenkY0yGEYDupXcA==
X-Received: by 2002:a17:90a:3f8b:b0:29c:5c56:ffea with SMTP id
 m11-20020a17090a3f8b00b0029c5c56ffeamr4057937pjc.6.1711538900939; 
 Wed, 27 Mar 2024 04:28:20 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 sn12-20020a17090b2e8c00b002a058159ff8sm1409971pjb.8.2024.03.27.04.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 04:28:20 -0700 (PDT)
Message-ID: <067a79d2-229a-40d8-9a88-28535c2e015d@ventanamicro.com>
Date: Wed, 27 Mar 2024 08:28:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz
 <groug@kaod.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, peter.maydell@linaro.org
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <190171404.Ysjo4HZYI3@silver>
 <f968c2ac-4056-47bf-af87-70534db82035@ventanamicro.com>
 <8350437.9EvD175kdC@silver>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <8350437.9EvD175kdC@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 3/27/24 07:14, Christian Schoenebeck wrote:
> On Wednesday, March 27, 2024 10:33:27 AM CET Daniel Henrique Barboza wrote:
>> On 3/27/24 05:47, Christian Schoenebeck wrote:
>>> On Tuesday, March 26, 2024 6:47:17 PM CET Daniel Henrique Barboza wrote:
>>>> On 3/26/24 14:05, Greg Kurz wrote:
>>>>> On Tue, 26 Mar 2024 10:26:04 -0300
>>>>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
>>>>>
>>>>>> The local 9p driver in virtio-9p-test.c its temporary dir right at the
>>>>>> start of qos-test (via virtio_9p_create_local_test_dir()) and only
>>>>>> deletes it after qos-test is finished (via
>>>>>> virtio_9p_remove_local_test_dir()).
>>>>>>
>>>>>> This means that any qos-test machine that ends up running virtio-9p-test local
>>>>>> tests more than once will end up re-using the same temp dir. This is
>>>>>> what's happening in [1] after we introduced the riscv machine nodes: if
>>>>>> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
>>>>>> this is what happens:
>>>>>>
>>>>>> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
>>>>>>
>>>>>> - virtio-9p-device tests will run virtio-9p-test successfully;
>>>>>>
>>>>>> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
>>>>>>      first slow test at fs_create_dir() because the "01" file was already
>>>>>>      created by fs_create_dir() test when running with the virtio-9p-device.
>>>>>>
>>>>>> We can fix it by making every test clean up their changes in the
>>>>>> filesystem after they're done. But we don't need every test either:
>>>>>> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
>>>>>> i.e. a dir is created, verified to be created, and then removed. Fixing
>>>>>> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
>>>>>> both. The same theme follows every test in virtio-9p-test.c, where the
>>>>>> 'unlikat' variant does the same thing the 'create' does but with some
>>>>>> cleaning in the end.
>>>>>>
>>>>>> Consolide some tests as follows:
>>>>>>
>>>>>> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
>>>>>>      fs_create_unlinkat_dir();
>>>>>>
>>>>>> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
>>>>>>      fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
>>>>>>
>>>>>> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
>>>>>>      fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
>>>>>>      creates is now being removed.
>>>>>>
>>>>>
>>>>> The  change looks good functionally but it breaks the legitimate assumption
>>>>> that files "06/*" come from test #6 and so on... I think you should consider
>>>>> renumbering to avoid confusion when debugging logs.
>>>>>
>>>>> Since this will bring more hunks, please split this in enough reviewable
>>>>> patches.
>>>>
>>>> Fair enough. Let me cook a v2. Thanks,
>>>
>>> Wouldn't it be much simpler to just change the name of the temporary
>>> directory, such that it contains the device name as well? Then these tests
>>> runs would run on independent directories and won't interfere with each other
>>> and that wouldn't need much changes I guess.
>>
>> That's true. If we were just trying to fix the issue then I would go with this
>> approach since it's simpler. But given that we're also cutting half the tests while
>> retaining the coverage I think this approach is worth the extra code.
> 
> Well, I am actually not so keen into all those changes. These tests were
> intentionally split, and yes with costs of a bit redundant (test case) code.
> But they were cleanly build up on each other, from fundamental requirements
> like whether it is possible to create a directory and file ... and then the
> subsequent tests would become more and more demanding.
> 
> That way it was easier to review if somebody reports a test to fail, because
> you could immediately see whether the preceding fundamental tests succeeded.

The current test design is flawed. It's based on a premise that doesn't happen, i.e.
a new temp dir will be created every time the test suit is executed. In reality the
temp dir is created only once in the constructor of the test, at the start of qos-test
(tests/qtest/qos-test.c, run_one_test()) and removed only once at the destructor
at the end of the run.

It's not possible to add a 'device name' in the created temp dir because we're too early
in the process, the tests didn't start at that point. So, with the current temp dir design,
the tests needs to clean themselves up after each run.

Here's the alternatives I'm willing to go for:

- what I just sent in v2;

- add cleanups in all existing tests. We can keep all of them, but the 'create' tests
will be carbon copies of the 'unlinkat' tests but with different names. Can be done;

- if we really want the tests untouched we can rework how the 'temp dir' is created/deleted.
The test dir will be created and removed after each test via the 'before' callback. To be
honest this seems like the best approach we can take, aside from what I did in v2, and
it's on par with how tests like vhost-user-test.c works.


Thanks,


Daniel

> 
> /Christian
> 
> 

