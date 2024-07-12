Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE12C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 10:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSDIl-0005EW-1H; Fri, 12 Jul 2024 06:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSDIj-0005DO-4T
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSDIh-0003zw-Am
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720779290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QaLOP6pxU12ayUOhvRHpQxpTvHQJ/9k5cLHEFXMKthA=;
 b=ifeiMBCR9ynH7g+Zv3nB+Q7ZCl9zuYX2OGDuf/1XNMxHqA/YsuVuqzvbfvVIAGURfJi9Ui
 ssnPUiCdJgSnlRzEyopKt9tCUlQOUbi3BBUS9tOVFY85fvfZeDzQ2tR9su6dzIoQP15jrj
 b+Ch6BSu2bqhFE3WV3n+A14MM4TeGhY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-UurPfjXiMjqEFje_rXTdTQ-1; Fri, 12 Jul 2024 06:14:48 -0400
X-MC-Unique: UurPfjXiMjqEFje_rXTdTQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d3eca4c01so1718831a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 03:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720779287; x=1721384087;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QaLOP6pxU12ayUOhvRHpQxpTvHQJ/9k5cLHEFXMKthA=;
 b=M0uXS6+uE3vW6xgrFoMltPNY5OeYG8PUM57DJO1U3+SQ4PVYk+YQIea5JF6hO0bk8o
 CLOZIq62ysuq/+XNjMWJtxYhfO/OXiN52OksN6+bHUeFp3RluRjJfU7e1uJrNI468XPC
 83xkcs0UipSJfGrV2iNOoafS2agcwtd3dcx5jCQ3QBJBef1DWnGN+8+nLLbsSma+j43c
 CwSlcOr12/Ru1+odsBrJIuTFPsWKAowLXwTzwc3H7BR24+8DanltQmbIFThahd2rOIZI
 zAzbLog0CJRHQeSqGnouEMcV+kQ1MPJQ57caqfN8dgLNDSWbV3uxhqU0zafzNrrJLyCO
 kQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9WvhKmHLG591OTSdjDJMYiJyQLkN56ubwF8qlWp5C5tkHEQVPuY8lBEeeDYMhtm0BUZyaXU0yE9RdZQPAy4IvJnUwpZE=
X-Gm-Message-State: AOJu0YxxCI1Ie8+1cgBggL4fydn5CMFMfiMigC4fa5QJ2uEbOqUyFM62
 R8lW1P+yb2+o9PZcVJS58ELKIEORDb6C3Zji4Io9fNB3TY+SYbEc11tHQ8XjouqyYk90RWGTF8g
 bUG9j0oxXStOehKBfR4SBIFXxRA+RWm7yL1Gl2D+HGWQD+5xUjBPR
X-Received: by 2002:a05:6402:270c:b0:57c:68fd:2bc9 with SMTP id
 4fb4d7f45d1cf-594baa8bd2amr8909179a12.3.1720779287556; 
 Fri, 12 Jul 2024 03:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf6guKjV9G/MefKm4bVygxMdOPiwTcy6JHy5mLAuDBu4bsMMbiqyWCbBVCtTyUimWbYiDJbw==
X-Received: by 2002:a05:6402:270c:b0:57c:68fd:2bc9 with SMTP id
 4fb4d7f45d1cf-594baa8bd2amr8909166a12.3.1720779287148; 
 Fri, 12 Jul 2024 03:14:47 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bbe2cc82sm4391802a12.23.2024.07.12.03.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 03:14:46 -0700 (PDT)
Message-ID: <154a3249-b99e-4f93-bc45-0f34d08c1c6a@redhat.com>
Date: Fri, 12 Jul 2024 12:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/8] tests/pytest: add pytest to the meson build system
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-5-thuth@redhat.com> <ZpDw0CiRvN_DvJqe@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZpDw0CiRvN_DvJqe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/07/2024 11.01, Daniel P. Berrangé wrote:
> On Thu, Jul 11, 2024 at 01:55:42PM +0200, Thomas Huth wrote:
>> From: Ani Sinha <ani@anisinha.ca>
>>
>> Integrate the pytest framework with the meson build system. This
>> will make meson run all the pytests under the pytest directory.
> 
> Lets add a note about the compelling benefit of this new approach
> 
>    With this change, each functional test becomes subject
>    to an individual execution timeout, defaulting to 60
>    seconds, but overridable per-test.

The avocado runner uses timeouts, too, so it's not really an additional 
benefit that we get here.

> For CI purposes we'll need to add 'python3-pytest' to
> tests/lcitool/projects/qemu.yml, and re-generate the
> the dockerfiles. Some of the other non-gitlab CI
> integrations probably need manual additions of pytest
> packages.

I'm currently rather looking into getting rid of pytest and to use pycotap 
instead: Using the TAP protocol for running the tests, you get a much nicer 
output from the meson test runner, which can then count the subtests and 
properly report SKIPs for tests that have not been run.

>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index d39d5dd6a4..68151717d7 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -3,12 +3,14 @@
>>   .PHONY: check-help
>>   check-help:
>>   	@echo "Regression testing targets:"
>> -	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
>> +	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest, pytest and decodetree tests"
>>   	@echo " $(MAKE) bench                  Run speed tests"
>>   	@echo
>>   	@echo "Individual test suites:"
>>   	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
>>   	@echo " $(MAKE) check-qtest            Run qtest tests"
>> +	@echo " $(MAKE) check-pytest           Run pytest tests"
>> +	@echo " $(MAKE) check-pytest-TARGET    Run pytest for a given target"
> 
> Or name it after the type of test rather than harness ?
> 
>   eg  check-functional / check-functional-TARGET
> 
> For that matter perhaps also for the dir name ?
> 
>     tests/functional/*.py

I almost expected that discussion again ... (see 
https://lists.gnu.org/archive/html/qemu-devel/2021-05/msg06553.html ) ... 
last time we couldn't really agree on such a name and decided to go with the 
name of the framework...

I agree that "pytest" is likely not the best name here, especially if 
switching to the pycotap test runner instead of using the "pytest" program, 
but "functional" might trigger the same discussion again as last time ... 
should it rather be "functional" or "validation" or "integration" etc.?

Maybe best if we come up with a new fictional name for the "new" test 
framework... something like "pyqe" - PYthon-based Qemu test Environment"? 
... could be considered as a play on the word "pike", too, i.e. something 
that makes sure that not everything gets in ... ? WDYT?

  Thomas


