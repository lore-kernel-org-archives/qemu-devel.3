Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DABC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBND-00061T-Le; Wed, 12 Feb 2025 06:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBNB-0005y3-5k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:57:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBN8-0004Bj-IE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:57:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4395578be70so16149915e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739361460; x=1739966260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54ARi22mlK1/plYqd476Cq1udVV29MrdJACpBAux9n0=;
 b=kwiBKDe8qEd05jHZ5KdSTeZht4T2AJCPr/zaiNQFlQ0NCMhK3v3c1/SPCXK3DUShPS
 oiRqFu9IiwdMSMF3yY5Y63txgSCTQVb8D0p2LeXRJW040oTroRVP8G8ePjEkvA8Oxkmd
 MnqaEgWsfMci9doDterYTGRMUjHPfOEk4yZ1vagJ8/T/xJfXQBoXPLAoongtuUhxsBmB
 Dt9wOLo+bld8gemWgwZNbShbg3YKEhiXejOv/EmjZmO3ergUt5R5LsF11ZTPf6g8A7xq
 j5zVXZDZT12k6ponOKcdVnauSVSSgGbpl/0OTUC7RMhe25i3pYFJgoS1Qpajg/du8beL
 icTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739361460; x=1739966260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54ARi22mlK1/plYqd476Cq1udVV29MrdJACpBAux9n0=;
 b=m/8NJqouplXtBdba0ipMrCfOX2LnwXUQCIUhXUaG1Qilt9Db4BSlDxpeP9BsKToQBW
 ZoxH6Veij7zRb+SkaoxO2RdEBgh/0UVPOGQxj3EDKD0GwKcNnU/DIu91sAqD0Y+BCxgC
 MkbQpiVVqcNGAV2UD1sSJ3y+2PZfeOjOwl1+ol2KZYZ9SZQcQY4Tuc8m5xulK1O4EUwY
 U5QGjQz4R59H/D/Xty8ldh3bNeur+pj4W6vhzu/Bc0mjhzz8ONjp8LPmGUjrDJv9mGkg
 ONdkfCip5wBp7d+WqFL1KFVYUYte5FyGhvxWKwq3Uoyti0i5Dj8Ouavknk2G9KF9ScEr
 9Gdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvulfTZ7hhZyusuUJegxLksdeqitW7OMNUf2oRDCbpsZji6DrORotO1ho0DP6oiCug9ojt75FYq4PV@nongnu.org
X-Gm-Message-State: AOJu0YwwkQ9l2IeEEbLoaVcU6KH+Tebcx+7ja6x+Mq+RMzccrzCBWi49
 vut5GyzsPvAGUkcylpve6XPzcqNZS0jUt2tsEd6NwT4xLtG4ZL8MZi55gUyjaiM=
X-Gm-Gg: ASbGncsbneyb7+obDLavbtUCyqmH1PAqF8h6Q7WwbtMEl7eKL19hCQOoMAiAATpHyNy
 /LPRW4ExtSMNn3JviVW1oTjCC6Pa1kG7TAtsyh4Hs8gOc8cQNHlr1Tp/tSbNY+MhgwLSVXQ41jt
 ix8XnoNPR3ZgMyvEri4q2N6oVHubEcqOAFCc0zrZEXXaKG++xw9wloHEAdR2dgOwveq/o9Ob3rn
 324dHy7blWhxf8P2PLlYdarAim4JDTlMp0LKvtDoHI9wTm/8cHzpUSCjusw2BpCAZT/CceVhesN
 V3LDKlVlFR6XuYtVo9CNP34c+qah8+axQGVgAesG7RWuzAxr5sXq0f7ctuU=
X-Google-Smtp-Source: AGHT+IFRz70Em5aPzY59cmcTYBYsVxsVMnhSYFHRlsb4qa9VhOeJMi9d06nPQuIncWkwNYGZFTac6g==
X-Received: by 2002:a05:600c:1c91:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439581cab45mr29799995e9.31.1739361460348; 
 Wed, 12 Feb 2025 03:57:40 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a053e42sm17672615e9.15.2025.02.12.03.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:57:39 -0800 (PST)
Message-ID: <682f2585-ec38-4a36-9749-457e22a46415@linaro.org>
Date: Wed, 12 Feb 2025 12:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
 <Z6xlUMopyRVfYjAh@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6xlUMopyRVfYjAh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/2/25 10:10, Daniel P. Berrangé wrote:
> On Tue, Feb 11, 2025 at 07:53:32PM +0100, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
>>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> The following changes since commit
>>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>>>
>>>>>     Merge tag 'pull-qapi-2025-02-10-v2' of
>>>>> https://repo.or.cz/qemu/ armbru into staging (2025-02-10
>>>>> 10:47:31 -0500)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>>>
>>>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>>>
>>>>>     hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
>>>>> (2025-02-10 21:30:44 +0100)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Misc HW patches
>>>>>
>>>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>>>>> - Make various Xilinx devices endianness configurable (Philippe)
>>>>> - Remove magic number in APIC (Phil)
>>>>> - Disable thread-level cache topology (Zhao)
>>>>> - Xen QOM style cleanups (Bernhard)
>>>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>>>>> - Invert logic of machine no_sdcard flag (Philippe)
>>>>> - Housekeeping in MicroBlaze functional tests (Philippe)
>>>>
>>>> Please take a look at this CI failure:
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
>>>
>>> Hmm I can not reproduce locally this error:
>>>
>>>     Exception: Asset cache is invalid and downloads disabled
>>
>> OK, I could reproduce by blowing my cache away.
>>
>> The problem seems in the "tests/functional: Have microblaze tests
>> inherit common parent class" patch, which does:
>>
>> -class MicroblazeelMachine(QemuSystemTest):
>> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
>>
>> I presume, since MicroblazeLittleEndianMachine is no more a direct
>> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
>> downloaded.
> 
> Yes, my code assumes all assets are on the leaf test classes. I'll
> look at a fix since it is easy enough to check parent classes too.

Actually your code works fine :) I mis-interpreted the network issue:

DEBUG:qemu-test:Extract 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
format=Nonesub_dir=None member=None
INFO:qemu-test:Downloading 
http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz to 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
DEBUG:qemu-test:Unable to set xattr on 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22.download: 
module 'os' has no attribute 'setxattr'
INFO:qemu-test:Cached 
http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz at 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22


