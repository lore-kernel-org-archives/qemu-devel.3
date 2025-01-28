Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C37C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnS7-00011b-7w; Tue, 28 Jan 2025 10:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnS5-00011M-AZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnS2-0003gf-SK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738077869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b6n5/SAwwbMo0qGUDrwmNq+7d3xhjtl2Yu+Q/irBC+8=;
 b=KWcjIaF18dI6Z2pg1E5ZT8MkK+RM/QaY7QhXM8autSGPGSIslAmOFg91KK0hbGsyIMB4Pg
 b0ge3qGYlHNCXZJX943OTp7RweF0XE5bYXdMbPBjreBKuKTruPHYWONfCb3S5VfVDtPv7K
 RWMRJpZc28tJqE8t+Bvq8R5g9I+dRpQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-mxkf84svNPu5MR7kDHLJKA-1; Tue, 28 Jan 2025 10:23:18 -0500
X-MC-Unique: mxkf84svNPu5MR7kDHLJKA-1
X-Mimecast-MFC-AGG-ID: mxkf84svNPu5MR7kDHLJKA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so618323466b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 07:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738077797; x=1738682597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6n5/SAwwbMo0qGUDrwmNq+7d3xhjtl2Yu+Q/irBC+8=;
 b=SznhxPYpQ6H1UZi0fU2Z5/+z3uuS/Vs4ka8weNPhsABuZvYxl03MQe04uJe9YBgplO
 HkqJkKKRe/XcuCe36txY1mzSQk9j8ZEnypCh0J5iGHIWs0B220HnEyc6cqfB+Tlm6U09
 YNFFAbrgyhhipXaNjOBVfTgDcqvjCGu2w6PXExpzAN2TrPLxPlDgZic1AbpHlmItVvIm
 KuWINpKscdVOmcNX3sQWtr8FVSM34XjP9J5Ckz+Nuu7z94ErYNB2G4JB7FG7sZN6E7yL
 ImSo9TKB8M8sQi9q8vB62K1LLgUdUgQcwmXRbiY5tPz7PUHWUTLts5uh8XNI9wjzuBOe
 Spqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVg3RujvINtT9K8dGMZndi5gr9TCeALnGthQLz+d3uI6A6m2f7NmZu+F4GGNgTudNVMq8yDvXEtGUF@nongnu.org
X-Gm-Message-State: AOJu0YxkzO03DKFgjEc2l3idi9HfdMM5qrzYS4NoDerrIx+YALSfGB7K
 Wo/2aP/PPF7CKKTksb9QyDFQmMZF9vG31FQtpLvS1AlseUJUf/jPuioTkkSHVktx+E316+NmCZ+
 KBegj6AI7r0uoV5hmuVZVV+NKVE3FrZGbjuoMNYDLxTXFfJ9LooWm
X-Gm-Gg: ASbGnctQM1KUBPMB4KA38EFR73THqzixFsL18GmcvhnW0ajE0H3xv39Ryk6SAlPDEF9
 DUEYoTQXmhmjLMpOqaZ+M6Jllzl6pAeH6AwL3nYt3TrxEmJUh9TR3PkbPqd81LuyfBaKSyvcO9s
 X8eplNjb8oKG0k5SiqwrHAjgArjjTwOU73jjxKITz0S8+yifAKyksSsi1K8J64SsytS9xc2X/dP
 tjTLCXVAQ9Y1cEJRNbn5O1T/hF5DfFEYSlBiUrPm6F+g0sPJHhe4Zr3w1mhpLxsUrFO74meeJVE
 CqWjEXSnFUbUiJ4ziw8QoTL6LPdycdIiXcTu
X-Received: by 2002:a17:907:3f23:b0:ab6:4fa2:80c1 with SMTP id
 a640c23a62f3a-ab64fa2839bmr2357949566b.52.1738077797578; 
 Tue, 28 Jan 2025 07:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy8i68Vm71yM5d7MponycqK337dGSQxIa/uj+af5tY86AbfKX4oX7VUUqt6r+SCdGxNRE3RQ==
X-Received: by 2002:a17:907:3f23:b0:ab6:4fa2:80c1 with SMTP id
 a640c23a62f3a-ab64fa2839bmr2357945866b.52.1738077797168; 
 Tue, 28 Jan 2025 07:23:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e64da5sm806113466b.60.2025.01.28.07.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 07:23:16 -0800 (PST)
Message-ID: <0306de55-06f4-4d61-bc98-34971b83e62f@redhat.com>
Date: Tue, 28 Jan 2025 16:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/functional: Add a decorator for skipping long
 running tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250124141529.1626877-1-thuth@redhat.com>
 <20250124141529.1626877-2-thuth@redhat.com> <Z5OxsmoiSSCh485I@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z5OxsmoiSSCh485I@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/01/2025 16.28, Daniel P. Berrangé wrote:
> On Fri, Jan 24, 2025 at 03:15:25PM +0100, Thomas Huth wrote:
>> Some tests have a very long runtime and might run into timeout
>> issues e.g. when QEMU has been compiled with --enable-debug.
>> Add a decorator for marking them more easily and document the
>> corresponding environment variable that is used to enable the
>> tests.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/devel/testing/functional.rst        |  8 ++++++++
>>   tests/functional/qemu_test/__init__.py   |  2 +-
>>   tests/functional/qemu_test/decorators.py | 14 ++++++++++++++
>>   tests/functional/test_arm_quanta_gsj.py  |  5 +++--
>>   4 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
>> index ae238ed3fc..7d9396b696 100644
>> --- a/docs/devel/testing/functional.rst
>> +++ b/docs/devel/testing/functional.rst
>> @@ -351,5 +351,13 @@ the code snippet below:
>>   Tests should not live in this state forever and should either be fixed
>>   or eventually removed.
>>   
>> +QEMU_TEST_TIMEOUT_EXPECTED
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +Tests that have a very long runtime and might run into timeout issues
>> +e.g. if the QEMU binary has been compiled with debugging options enabled.
>> +To avoid these timeout issues by default and to save some precious CPU
>> +cycles during normal testing, such tests are disabled by default unless
>> +the QEMU_TEST_TIMEOUT_EXPECTED environment variable has been set.
>> +
>>   
>>   .. _unittest: https://docs.python.org/3/library/unittest.html
>> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
>> index da1830286d..b1a19d2a4b 100644
>> --- a/tests/functional/qemu_test/__init__.py
>> +++ b/tests/functional/qemu_test/__init__.py
>> @@ -14,7 +14,7 @@
>>   from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>   from .linuxkernel import LinuxKernelTest
>>   from .decorators import skipIfMissingCommands, skipIfNotMachine, \
>> -    skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
>> +    skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipLongRuntime, \
> 
> s/Runtime/RunningTime/, but actually in terms of naming
> convention, 'skipSlowTest' would fit better.

Ack, that sounds better, indeed.

> 
>> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
>> index df088bc090..8f311e5309 100644
>> --- a/tests/functional/qemu_test/decorators.py
>> +++ b/tests/functional/qemu_test/decorators.py
>> @@ -86,6 +86,20 @@ def skipBigDataTest():
>>       return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
>>                         'Test requires large host storage space')
>>   
>> +'''
>> +Decorator to skip execution of tests which have a really long
>> +runtime (and might e.g. time out if QEMU has been compiled with
>> +debugging enabled) unless the $QEMU_TEST_TIMEOUT_EXPECTED
>> +environment variable is set
>> +
>> +Example:
>> +
>> +  @skipLongRuntime()
>> +'''
>> +def skipLongRuntime():
>> +    return skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
>> +                      'Test has a very long runtime and might time out')
>> +
> 
> You're preserving the existnig env var which is good,
> but I have a little niggling desire to unify the
> naming conventions:
> 
>    skipFlakyTest     -> $QEMU_TEST_ALLOW_FLAKY
>    skipUntrustedTest -> $QEMU_TEST_ALLOW_UNTRUSTED
>    skipBigDataTest   -> $QEMU_TEST_ALLOW_BIG_DATA
>    skipSlowTest      -> $QEMU_TEST_ALLOW_SLOW
> 
> Could be a separate patch though if you like the idea.

I like the idea, some of the others are already starting with 
QEMU_TEST_ALLOW_, so the renaming makes sense to me, too. I'll change this 
patch in v2, but I'll leave the others for now - feel free to send a patch 
for them, if not I'll tackle them sometime later.

  Thomas


