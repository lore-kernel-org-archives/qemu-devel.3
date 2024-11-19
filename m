Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69729D6207C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDS1a-00028U-6g; Tue, 19 Nov 2024 12:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDS1T-000215-J4
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDS1Q-0004Xi-JC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732037291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kCtysJtT2M4yzCzEmpjHBPRZknsQkpVQaIt43FewD2I=;
 b=hvoTwKj+PcCS4LaKVvZzZVA1wUvYQJPlWuZg9rs/aamEfdXOVqO41wWpk7qD5jqhvfNMdS
 qHZniVeBBvyVv2PG+4hde342c56wKu64VjluqdeL2rJSBi0pNYuP9d5XZrb9zqKnaKsFq0
 eJiUHhrv0UAiZ/cXP+EWMqfnyM/JaxU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-MezHR1UBMhq1HceKFPvstQ-1; Tue, 19 Nov 2024 12:28:07 -0500
X-MC-Unique: MezHR1UBMhq1HceKFPvstQ-1
X-Mimecast-MFC-AGG-ID: MezHR1UBMhq1HceKFPvstQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38243a4ba5fso2273668f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732037286; x=1732642086;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCtysJtT2M4yzCzEmpjHBPRZknsQkpVQaIt43FewD2I=;
 b=CHyyvWuVyZ2L0glkMrZBBuHlIMb5VYjEJGhbT98vioeO/WKUIrqFN+BLjJxRpb2ltT
 EvpeGP4Y9wgq0dGKH4jXC5hhDhtkGw8WMIKnfqppfF//cXc/HBpXuny8U8N6bh9Stp6s
 phGdrR+meWZqvp26rmvNbpGuedQXUOPdllsVQwn6cKufGeNKoacsS8imLNIosA5LflJu
 VuUGT25zlLzFxgyy++Z7AR4ACAqOlmkk/i/D5+OBjpJ69K5fRjPPKAwkY83Y/o07M8nS
 JefcIHTRjX2RiIOnIuXJzoEDY6wdKomQ7pqOxW/LAI2tWIZfXD1yu+EnTKF5Vsjvsbqv
 jhsQ==
X-Gm-Message-State: AOJu0YzL0uP/auCoq51KQsvxkdKfABg3VwO8BqjKi9N84YeNTONFXqC/
 rOYVsVnys00L7pd/XircK7FgNfpNvBFuj9Lcq+UarMK0/wm2esb9Hn8zF3zMx+tPr0VBoMbbY0g
 kzHTkgwTtREflMfCDa10FO8l0duaYw7px2PUHdCCGjCn3cYyt7LvG
X-Received: by 2002:adf:e186:0:b0:382:4ab4:b3e5 with SMTP id
 ffacd0b85a97d-3824ab4b609mr8931406f8f.0.1732037285927; 
 Tue, 19 Nov 2024 09:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdPpaERyjKSxqle4Cfi/mBiBFerxPRgrmLIcXklE/zOz7XtkoGM4AO4C9xldBhEC+yAn8fJg==
X-Received: by 2002:adf:e186:0:b0:382:4ab4:b3e5 with SMTP id
 ffacd0b85a97d-3824ab4b609mr8931376f8f.0.1732037285624; 
 Tue, 19 Nov 2024 09:28:05 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-244.web.vodafone.de.
 [109.42.49.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38249ed88d8sm5534745f8f.48.2024.11.19.09.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 09:28:05 -0800 (PST)
Message-ID: <fb3e6a04-acf3-45b2-954c-bad769a81c3f@redhat.com>
Date: Tue, 19 Nov 2024 18:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] tests/functional: automatically clean up scratch
 files after tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-3-berrange@redhat.com>
 <87frnnp53d.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87frnnp53d.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19/11/2024 17.21, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> The build/tests/functional subdirectories are consuming huge amounts
>> of disk space.
>>
>> Split the location for scratch files into a 'scratch' sub-directory,
>> separate from log files, and delete it upon completion of each test.
>> The new env variable QEMU_TEST_KEEP_SCRATCH can be set to preserve
>> this scratch dir for debugging access if required.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   docs/devel/testing/functional.rst      |  6 ++++++
>>   tests/functional/qemu_test/testcase.py | 14 +++++++++-----
>>   2 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
>> index bf6f1bb81e..6b5d0c5b98 100644
>> --- a/docs/devel/testing/functional.rst
>> +++ b/docs/devel/testing/functional.rst
>> @@ -65,6 +65,12 @@ to the QEMU binary that should be used for the test, for example::
>>     $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
>>     $ python3 ../tests/functional/test_file.py
>>   
>> +The test framework will automatically purge any scratch files created during
>> +the tests. If needing to debug a failed test, it is possible to keep these
>> +files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
>> +variable.  Any preserved files will be deleted the next time the test is run
>> +without this variable set.
>> +
>>   Overview
>>   --------
>>   
>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
>> index 411978b5ef..b9418e2ac0 100644
>> --- a/tests/functional/qemu_test/testcase.py
>> +++ b/tests/functional/qemu_test/testcase.py
>> @@ -13,8 +13,9 @@
>>   
>>   import logging
>>   import os
>> -import subprocess
>>   import pycotap
>> +import shutil
>> +import subprocess
>>   import sys
>>   import unittest
>>   import uuid
>> @@ -40,11 +41,12 @@ def setUp(self, bin_prefix):
>>           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>>           self.arch = self.qemu_bin.split('-')[-1]
>>   
>> -        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
>> -                                    self.id())
>> +        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
>> +                                      self.arch, self.id())
> 
> I don't think you need save self.outputdir as only self.logdir is used
> by the other functions.

I guess it might be useful to have this variable as a reference point in 
future patches, so I'm in favor of keeping it.

Reviewed-by: Thomas Huth <thuth@redhat.com>


