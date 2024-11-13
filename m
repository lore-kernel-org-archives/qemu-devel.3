Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0294D637AE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKBp-0006fW-Ec; Wed, 13 Nov 2024 15:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBKBn-0006fN-TR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:42:11 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBKBm-0000pJ-1W
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:42:11 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so5509568f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731530528; x=1732135328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhZHDOu5aT/J2vqBBrwJp4n3UPW80fjr4yyi6rpTMlQ=;
 b=CUhp+BFrkCIVms2jN6fVFHQXLo8qIbSdJTv7qNelJaxHlX9Z2OP5rRqIH89QicEsNw
 rTKwDC6mLDDXtHe9JRDfPTmYs46ynb63zXzuiOE8BswcFql31jUu26FkF1Q6WLlKPAGJ
 sYzTbioQuZBUMsGJEt4pa9b0Q/XPWOsY9I13w7mOkcMFQpxZMtIYpuobiWc9v2fPDiqn
 o89iNEqo3tZEBiaBvLQFXy7WI50hrtyk1u/d1wVjQA7MF5T5Y6V82g6yaAnnPrgRmb6z
 uQZy1/VDaddKbE0WoNTe+itPFN8KPSGwbi2nzBmb7pKJ4wK+6aDRzHU/mgkL/Wawjpxj
 ukng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731530528; x=1732135328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhZHDOu5aT/J2vqBBrwJp4n3UPW80fjr4yyi6rpTMlQ=;
 b=qPQY0Pu4XxPLdMmLRjnEcbyA6gsxjF+5GG5c9BknLAo3OQMKlKrauPZaKVt6B0xxry
 buxez5tOfAGUScNd2uOWTo2+limeeB0nGp1c6MFSLaj5ToYkGR2HxdWwGwVl1/grYMN4
 jncu54ikETMxbak+T/OwGks1snAQViph+4l6AASpqe8hsz4kiatSnq7T/1AdGF9OfCjy
 O3bOTXg/zFLyUt5ApLqcY8Wt1haSw66+CcXMbvlAIObQ4u0XZ0qZXEA1ZXdD5c5tZnEQ
 7VTows9bTM9WaSnK1juKlGDKpDe0O9vtmGSTWI9bh5evQfMpL4Fe9rmnHP0+y+xmfdjC
 6DHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA+fOjYFsjfaDUl35JDV3GHBY7M6w895UBfQIjNDsIyXM7VMbfWFLU6N9JP2O0Qiu1EkWiv6URNlh+@nongnu.org
X-Gm-Message-State: AOJu0YxvbHM0VLJzrqauKUSmhlUbAMHZ1fSbiHrdBtNAYqzQbyareNQL
 Bx6f4knIx8yvjUX8sCruQuTEJsR/6ZGb/C5I0tp6Xmqj7GV5XGXwf+u1Ixp3py4=
X-Google-Smtp-Source: AGHT+IGx6S/F5axeaAzKdwxFHI/BbhKJ2tHZAD7NNMpC4rP9Wzpe475mYQ66iLNqg+XGtA8MPKl3sA==
X-Received: by 2002:a05:6000:178a:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-3820df71b96mr4180794f8f.16.1731530528483; 
 Wed, 13 Nov 2024 12:42:08 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9f8984sm19616231f8f.71.2024.11.13.12.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 12:42:07 -0800 (PST)
Message-ID: <0f3124e8-1bb3-4359-be80-8fdd34f898ea@linaro.org>
Date: Wed, 13 Nov 2024 21:42:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20241113163800.355547-1-alxndr@bu.edu>
 <0d1f8f1d-2894-4753-aeef-1a229a71a334@linaro.org>
 <glpwzquiqa6vaesu5dg7zc2futxypcycoel7uawlwg6l537oz7@4uzab3435nyf>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <glpwzquiqa6vaesu5dg7zc2futxypcycoel7uawlwg6l537oz7@4uzab3435nyf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 13/11/24 20:02, Alexander Bulekov wrote:
> On 241113 2040, Philippe Mathieu-Daud?? wrote:
>> On 13/11/24 16:37, Alexander Bulekov wrote:
>>> OSS-Fuzz builds have been failing due to some strange issues that seem
>>> to be related to color codes from libffi:
>>> https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af-9656-b4162fa881e1.txt
>>>
>>> Disable tcg to disable libffi.
>>>
>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>> ---
>>>    scripts/oss-fuzz/build.sh | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
>>> index 7398298173..095f7a90e3 100755
>>> --- a/scripts/oss-fuzz/build.sh
>>> +++ b/scripts/oss-fuzz/build.sh
>>> @@ -65,7 +65,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
>>>    # Build once to get the list of dynamic lib paths, and copy them over
>>>    ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
>>>        --prefix="/opt/qemu-oss-fuzz" \
>>> -    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
>>> +    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu" --disable-tcg
>>
>> IIUC we are using the QTest 'software [un]accelerator' to fuzz via I/O,
>> right?
>> Then maybe we can disable all accelerators to speed up build. But please
>> mention it in the commit description.
>>
> 
> That would be nice, but needs some changes to meson.build, which doesn't
> treat qtest as a real accelerator and will complain if building w/o tcg
> and kvm:
> error('No accelerator available for target @0@'.format(target))

We need to start with the binary using '-accel qtest', not "pick any
available accelerator randomly".

