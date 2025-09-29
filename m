Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC8DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 06:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v37So-0001mr-5s; Mon, 29 Sep 2025 02:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37Sn-0001mj-3u
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37Sg-000694-74
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759127648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mEj197Bbo5bAwyD22bJIxeo5gcg1p0+GmpRDS+3QxAA=;
 b=cW8NO05A62yGOrgAsAjr65V1pK22lkX0PLpIHfNXY15XTHZgdRKzP3pcVLNcb6aQOvn6d9
 udCgrlDtY5x+hGTXmDyGnQzl7GEttQnUU/myRs8BKSNSVL4QbZmts0DsWnSCDq6awd3Won
 ojcw3Nlw4zpjLf4K3561jlqnLImvL9U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XYf9cuyZMBOVLrJtBItUnw-1; Mon, 29 Sep 2025 02:34:06 -0400
X-MC-Unique: XYf9cuyZMBOVLrJtBItUnw-1
X-Mimecast-MFC-AGG-ID: XYf9cuyZMBOVLrJtBItUnw_1759127645
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b07cc3f115aso311265466b.3
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 23:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759127645; x=1759732445;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEj197Bbo5bAwyD22bJIxeo5gcg1p0+GmpRDS+3QxAA=;
 b=haGtORZdo2JhNOBx+0r/WYHjBfnnGZ61eN8X/1/ddKI6PFsn+eR0TufI1LIkXnpXZ4
 oEshLIijZ0+UGHl/OotQC/nRNoRC50EDhpE5SLkdtPAiEk7J7x18wi9k37m0MZAXy4b1
 3GQzLEn1MRv1phi7+g31MiwVmrM1q1qOxcoU2f+MVSaCjIczse8tw2r9LDrzgeqYJ3wn
 IDbrxn4ON7Xltlvk2gwRA+g4LDwbHkrGhUmX6DJkdJygikbn3mu463eMycaaAKEkfGwg
 h3Z4BIOYdmq5f4ijYBiP6+T8ABxUc0e+22MYv/z5JNvz2zZOYB+9Sd8C1QvERV2MQWld
 +lKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUan3GZ6j3g+TwqHLdE27aJXhCEuAGnYyDOfQoMCkgImBY2RJNmE4r5NN/v8i3sddXn6NC+Ard3jQc2@nongnu.org
X-Gm-Message-State: AOJu0YyPMChGRt/mh6ZYgS243TZC55BoxtKt29nhJ65skhxLDEXFGIOW
 186t+gxiawxeWIRHAMdPU17YAy4hNJPG8JWYLckaVZ85oEZG48DvzlQxkNyr8oMI2kFAe4YBSvc
 rsQkjAMOlCPXFtb3RWAGpkmpGptAI1BOYM4jC7oIXU01f8Bf1006pg500aArjPeH0
X-Gm-Gg: ASbGnctDFPtk6MpO0zuWG2xgPqHiEH6Dly5gHM16ARhDAiT9TuhkfcZjcQKbvQnpRhT
 TdT7bSeC6ItEoovVSQtWoITkGfUTizvWCisRpCVqbqAbx7iX7ZAtW+Sj5Avi2OpRmjCpazEZXWb
 ZBCkgt/vMFnrKopgGeoKJW+bbpizpT0+1glA8Z1oxtwcjd+3GLreQx3Hg0ohWpTx47ZwZ8XXFJd
 RB5zxgyE9Oa4eHRK0w0GMM3eBLxHmsusPllVbCy/Gs9CQPqzJpegmO54KyQ04H/03e6dXpJyMxe
 Yl5PjnagTB6upE4DLOsCGTk7H2/q1krRcxLcyF1kJOJ5xdEsoD0MUpLoEYNn54nZF8v2eexR5Xx
 hPzg8Ew==
X-Received: by 2002:a17:907:9803:b0:b32:2b60:ee8 with SMTP id
 a640c23a62f3a-b34b7dc84dbmr1513952766b.15.1759127645228; 
 Sun, 28 Sep 2025 23:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDyPQouKYIF3sGE5XFhBn5UN5G80MiPPs1Sqc4fczjM6Od0Ay6CjH3lY57l9rwNDQPCGt4tQ==
X-Received: by 2002:a17:907:9803:b0:b32:2b60:ee8 with SMTP id
 a640c23a62f3a-b34b7dc84dbmr1513950166b.15.1759127644778; 
 Sun, 28 Sep 2025 23:34:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d0d74888asm244218966b.109.2025.09.28.23.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 23:34:04 -0700 (PDT)
Message-ID: <acad2462-9c7a-43e9-a40c-6c3d625684c8@redhat.com>
Date: Mon, 29 Sep 2025 08:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] tests/functional: Provide GDB to the functional
 tests
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-4-gustavo.romero@linaro.org>
 <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
 <bd906237-c0fb-4921-a017-a591bc95f31f@linaro.org>
 <599cd42e-0619-4556-ae70-b2d360e6405a@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <599cd42e-0619-4556-ae70-b2d360e6405a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/09/2025 20.15, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 9/26/25 15:08, Gustavo Romero wrote:
>> Hi Thomas,
>>
>> On 9/26/25 07:03, Thomas Huth wrote:
>>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>>> The probe of GDB is done in 'configure' and the full path is passed to
>>>> meson.build via the -Dgdb=option.
>>>>
>>>> Because a single functional test can cover different arches, such as
>>>> aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
>>>> the target list is passed to Meson for use in the functional tests. To
>>>> handle this check, a new shell function, is_target_arch_in_arch_list, is
>>>> introduced in 'configure'.
>>>>
>>>> Meson then can pass the location of GDB to the test via an environment
>>>> variable: QEMU_TEST_GDB.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   configure                     | 21 +++++++++++++++++++++
>>>>   meson_options.txt             |  2 ++
>>>>   scripts/meson-buildoptions.sh |  2 ++
>>>>   tests/functional/meson.build  |  6 ++++++
>>>>   4 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/configure b/configure
>>>> index 0f7eb95586..20e05d233f 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -1142,12 +1142,31 @@ fi
>>>>   #########################################
>>>>   # gdb test
>>>> +# Check if all target arches are in a provided list of arches.
>>>> +is_target_arch_in_arch_list() {
>>>> +    arch_list=$1
>>>> +    for target in $target_list; do
>>>> +        arch=${target%%-*}
>>>> +        if test "${arch_list#*$arch}" = "$arch_list"; then
>>>> +            # Target arch not in arch list
>>>> +            return 1
>>>> +        fi
>>>> +    done
>>>> +    return 0
>>>> +}
>>>> +
>>>>   if test -n "$gdb_bin"; then
>>>>       gdb_version_string=$($gdb_bin --version | head -n 1)
>>>>       # Extract last field in the version string
>>>>       gdb_version=${gdb_version_string##* }
>>>>       if version_ge $gdb_version 9.1; then
>>>>           gdb_arches=$($python "$source_path/scripts/probe-gdb- 
>>>> support.py" $gdb_bin)
>>>> +
>>>> +    if is_target_arch_in_arch_list "$gdb_arches"; then
>>>
>>> No TABs, please!
>>>
>>>> +            gdb_multiarch="yes"
>>>> +        else
>>>> +            gdb_multiarch=""
>>>> +    fi
>>>
>>> This unfortunately does not work with the GDB from Fedora - it only 
>>> supports "arch64_be arm riscv64 riscv32 ppc i386 s390x ppc64 aarch64 
>>> ppc64le x86_64", but if you configured a target like "alpha-softmmu", 
>>> this breaks.
>>
>> argh! ok
>>
>>
>>> (BTW, does the gdb-multiarch from Debian/Ubuntu really also support 
>>> exotic QEMU targets like tricore?)
>>
>> No, I've checked GDB upstream and I can't see any trace of tricore.
>> And I just saw that Alex left a comment in scripts/probe-gdb-support.py
>> saying "# no tricore in upstream gdb", so nope, it seems that it still holds.
>>
>>
>>> I think it would be better to drop this hunk, and rather check in the 
>>> spot where we use GDB if the required target is really there (i.e. in the 
>>> functional test that uses it).
>>
>> OK. I'm also not a big fan of doing it in bash. How do you suggest
>> to do it? Directly in the code, via a skipIf decorator, or something else?
> 
> $gdb_arches, obtained using scripts/probe-gdb-support.py in configure,
> could be passed to meson and meson sets it in the test env, as we're
> doing for $gdb_bin and QEMU_TEST_GDB env var. wdyt?

That might be a possibility, though it's getting a little bit clunky if you 
want to run the test manually, without the meson test runner.

Maybe it would be nicer to just start gdb in the test and catch the error 
(and skip the test in that case) in the python test code if it fails to set 
the target architecture there?

  Thomas


