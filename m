Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B3AC0219B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 00:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti0pE-0005P3-SP; Tue, 11 Feb 2025 19:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti0pD-0005Oo-1r
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti0pA-0006Dx-CE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739320914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tTanG0H0tjUgSeoSDLraFmzuRe/xbf3fsUPlbi+mOBI=;
 b=Q97F8/rw0p8mq5L4QmwVety5taP53RlFAUL7lA2DrqH8c7571Q9oUpaoEBk/2GPCqgai6j
 5G1tMJoBNQ0hzPBG7m06INI0Kbi6fxBMmxHeXc5nLjZdhrfRIAyEG8HiCwd7Iitlkct6VZ
 OPDhVS4nv5T/fK2nNaRST3G8pD99fqI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-0kSc6WcJPqefUL-CsMtsHA-1; Tue, 11 Feb 2025 19:41:52 -0500
X-MC-Unique: 0kSc6WcJPqefUL-CsMtsHA-1
X-Mimecast-MFC-AGG-ID: 0kSc6WcJPqefUL-CsMtsHA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so45188045e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 16:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739320911; x=1739925711;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tTanG0H0tjUgSeoSDLraFmzuRe/xbf3fsUPlbi+mOBI=;
 b=nTnTGXi4JdQ2FD/qky/Y0h02OvxREtPZuC5bpNz7cd76dQuyZaG7BuU1HyUqzJMtcv
 Aukjt8+k+5K9i4RV4wB0PA7uoect33s6rczjwr3LmITbJidM3nYXghLqQSERfGRS1lhn
 hDUWre3DqYTXWu0/pcKj4NQ4GvAJtQaP7uwyx44GW4JYxYEs9Ykc3FxL61AJrUnIl9m7
 CWsEPy9ERQaKAOJ8PkjYB/Eu2Rn/UyZj4lufh0OliY8YlcRMBQsqvzNZndmoqxjQvTvJ
 /YAoMSmjzxRl8Tk8bReSVcSwLbYusx6lYv5zRHWryHke+1Gxvd5kZ5BWuACNOJ/JKSk3
 PZmg==
X-Gm-Message-State: AOJu0YzNxq2VugeoAGIPiOQkaoaj1pSSrzm2EIZdBfwsHk6aZZS+SaNM
 Ekp8EK+WsqY1Lb7+0tcLQTf58vNdlvQlEaJwjJtvuJj1GTok9uLYKwmn3PWbXlEr5o3fXHupjpQ
 rABjC0bIr/jjGLi9hbA+bh5DhLkY1rrMp/2QVCTj006vdSJRQ6BMN
X-Gm-Gg: ASbGncuZ3dgWVTtpaRpeboFWMS4/weSM9MAXRqUs3/kulbfZ2rBlR5RKo8ADx/zYcI8
 ScpDGvE4RTjB2PIo0NiDlXTiI7lUHs/qWVaD5O4wEu/gl5xKzDSAV5cFGLX5uGXxXhAmfQcuaw9
 U1rfHJbuni+js9NZzplwhFe5idUdjgIGQj9OEU+MTHEckBKKzuUvkTkHwOPvdQ2uNUYrUtKZqWY
 mShbUcWV4QQk5AMLk3NITZbUpB+nY9LZerjvS/ypqC0d2IXK5Ui97TX2kb1Syy9q7xb4wfICHTK
 BbQnbwhbCKNuuzTVP4k8LXme1WH/NH1GCQ==
X-Received: by 2002:a5d:6c61:0:b0:38d:dbbc:3b04 with SMTP id
 ffacd0b85a97d-38dea259195mr669004f8f.5.1739320911284; 
 Tue, 11 Feb 2025 16:41:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM+DyCR0dtkHpM1YL+P9QMgdzUSBaSMOVQT5K/QEXQh9eRvarT9N4R3g1+mrgG+ig1h4VT8Q==
X-Received: by 2002:a5d:6c61:0:b0:38d:dbbc:3b04 with SMTP id
 ffacd0b85a97d-38dea259195mr668992f8f.5.1739320910876; 
 Tue, 11 Feb 2025 16:41:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd093e1ffsm11545481f8f.100.2025.02.11.16.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 16:41:50 -0800 (PST)
Message-ID: <6e62808e-0fc2-4de0-a732-621e81f1937e@redhat.com>
Date: Wed, 12 Feb 2025 01:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eldon Stegall <egqac@eldondev.com>
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
 <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/02/2025 20.03, Philippe Mathieu-Daudé wrote:
> On 11/2/25 19:53, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
>>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> The following changes since commit 
>>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>>>
>>>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
>>>>> armbru into staging (2025-02-10 10:47:31 -0500)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>>>
>>>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>>>
>>>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
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
>>>    Exception: Asset cache is invalid and downloads disabled
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
> Well, apparently related to network failure:
> 
> INFO:qemu-test:Downloading http://www.qemu-advent-calendar.org/2023/ 
> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
> ERROR:qemu-test:Unable to download http://www.qemu-advent-calendar.org/2023/ 
> download/day13.tar.gz: HTTP Error 403: Forbidden
> 
> $ curl -v http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
>  > GET /2023/download/day13.tar.gz HTTP/1.1
> < HTTP/1.1 301 Moved Permanently
> < Location: https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
> 
> Using:
> 
> -- >8 --
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/ 
> functional/test_microblaze_s3adsp1800.py
> index 177c8a685bc..949e627c84a 100755
> --- a/tests/functional/test_microblaze_s3adsp1800.py
> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> @@ -24,3 +24,3 @@ class MicroblazeMachine(QemuSystemTest):
>       ASSET_IMAGE_LE = Asset(
> -        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> + ('https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> 
> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> ---
> 
> I still get:
> 
> INFO:qemu-test:Downloading https://www.qemu-advent-calendar.org/2023/ 
> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
> 
> However:
> 
> $ curl --http1.0 -v https://www.qemu-advent-calendar.org/2023/download/ 
> day13.tar.gz
>  > GET /2023/download/day13.tar.gz HTTP/1.0
> < HTTP/1.0 200 OK
> < Content-Length: 4752277
> < Content-Type: application/gzip
> 
> So I'm confused...

Looks like this also happens in test runs without your patches:

  https://gitlab.com/qemu-project/qemu/-/jobs/9108828196#L844

The test then silently gets skipped there (since we only fail hard for a 404 
error now).

Maybe Eldon could comment why the downloads are blocked for python scripts 
but not for curl downloads?

I the worst case, we have to mirror the asset to another place, I guess...

  Thomas


