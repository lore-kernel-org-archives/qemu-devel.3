Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2729606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F7WJICUM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qw7tsLyg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLc0J-0007ie-7H; Tue, 27 Oct 2026 03:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLc0H-0007iB-DX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLc0F-0007Wg-EL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793087629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UCjZRKr3gfpIiQxN6QbyCktMK+woOeLs4ynbca8NZzs=;
 b=F7WJICUMZOOpsZnKKPjtfyQ12hoe4XkaoghUqnzg0RNhEeQnQY8w51elT7sQHC7z2dGcbv
 lyxjUEZCAclaY5b8rNg+e1952sFKkWJ57nPoAdoAuALV7ALRhGYAywQrasXwP6H507pYAS
 ncIP+QPsQBGh2zpo8kHzpMXQ1dFzKn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Lud-5sZtNQetUgK8TECM4Q-1; Tue, 27 Oct 2026 03:53:47 -0400
X-MC-Unique: Lud-5sZtNQetUgK8TECM4Q-1
X-Mimecast-MFC-AGG-ID: Lud-5sZtNQetUgK8TECM4Q_1793087626
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso22746935e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793087626; x=1793692426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UCjZRKr3gfpIiQxN6QbyCktMK+woOeLs4ynbca8NZzs=;
 b=qw7tsLygQ4zCvUUXsJggP1zn3F8ofzRuIS4gY6qBMdCMzh0xfQjtgj3zxo9/PryOLr
 /M+eFMQXxqjyu0X60QqUlAgmyDjJs3wMCjzZK71Xhwu71wVJ/w0Qx6PPvzapsCvD4QO5
 fG9S7TwrC73TqNWmGkeE95KPvmoKdlllAh3/39Z/+HZS4Bab+CZ9UIgzEvPXjtBQqzCT
 ZCRXLj2X5DkpmC38oK9l+HrwZo3lQZJjIo1/DoohzXvh4pscQngwsMMj9HsK4WqTB3/g
 JRr82b/Uf/EjYf+fRZjbkomMMiVO8YPhi5eBL0HvAYn26lyA8eAZCnE+vLsPYjethzdr
 CC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793087626; x=1793692426;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UCjZRKr3gfpIiQxN6QbyCktMK+woOeLs4ynbca8NZzs=;
 b=H6mOB4L/U1+eLgGiG0wmsF3NvIWF0sFQTel0HCSQW40L0gzj5YJUN5ouqP3qVRQ6Kn
 1MDhJLg4mjJfNj3nluj4Z8B5lFETykM+8RexuzLM+470yAQ+24zrzP7UdAmgSH1PGWxG
 8Tn71WlJaadk8VV8fPUS6I1UgTTNHOHS6hZI9wLVuVTDtmERViejO8Q4JUcAk+IcKyVj
 Gm+jMyL7yN8RofbMFogUT8qpkAxxlk6tNkFGOWFYA27MdqbkSrB5LuwVYYGd2JZ5YRpM
 /EdPJICwTrCoz+2whWN93Y/UsfDhHLy28BZ27+efs6lqIQKvGEeV2Js0E6KHJxUgCVVz
 Sy5Q==
X-Gm-Message-State: AFq9FYKCw8KDNabqlPdlBYkKnNmByvFK0QS65h1a/plPgmLHf9bcUjhf
 uDOi7FjbHCEy+jKKEF1MEiE2HXga7t0vP1Fm3XT88zn7jdFbyT3W9mHg/BfS3FDnaJK3o7v6sGe
 /PN/W3SGzvScsU8TQJKjjw6a8iDGSzfn0PpZNxcQZun6vHJexwLzpBC+H
X-Gm-Gg: AYBFou21hMzm+mbLMuhdDeKR8f8WvQ4Trre/b6fGXwZRf0qHXlW+znRjbBHG24QD+6s
 fN90IkWdpnHbdEUkxZToqASEqwQEMpQJwzWr0GkE2JRydBt6ROJ4LzWClgrDxDpCYYPWJAr6oJU
 PW6fruZ4qzOGNxMzDOhetURH4cU/OOCTiasgeKpgeQhKJei93ygPiiSAWFEwCIsS557xOdG6oos
 MQdUQv5Q3Y3x3+t0hPdu7cY4idhOWjbta0aFnspe5phucigQyNkeIT9lA3xroQpWGVLPnx/428P
 6RPc35vgTQDep1qLHtxWxaGi2P0LrDSgkn7jifrbRQqmzYdW/VEI3We5cwiugBKA341/kW67
X-Received: by 2002:a05:600c:198c:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4a35acc0b00mr169619445e9.29.1793087626117; 
 Tue, 27 Oct 2026 00:53:46 -0700 (PDT)
X-Received: by 2002:a05:600c:198c:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4a35acc0b00mr169619225e9.29.1793087625786; 
 Tue, 27 Oct 2026 00:53:45 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2d9280sm245182145e9.13.2026.10.27.00.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 00:53:45 -0700 (PDT)
Message-ID: <d16ec2e0-4db6-486d-82f5-663fc5b53071@redhat.com>
Date: Tue, 27 Oct 2026 08:53:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Add a target to run all tests in thorough mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261026093034.516604-1-thuth@redhat.com>
 <at8pj6S3tBVoRdkf@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <at8pj6S3tBVoRdkf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/2026 11.21, Daniel P. Berrangé wrote:
> On Mon, Oct 26, 2026 at 10:30:34AM +0100, Thomas Huth wrote:
>> "make check SPEED=thorough" is a little bit clunky to type and many
>> people are not aware of this nice possibility to run almost all test
>> in parallel this way. So add a "check-thorough" target that makes this
>> way of running the tests a little bit more accessible.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/Makefile.include | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 9f82552ab54..d9d2b7ef13b 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -4,6 +4,7 @@
>>   check-help:
>>   	@echo "Regression testing targets:"
>>   	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
>> +	@echo " $(MAKE) check-thorough                Download assets and run almost all non-flaky tests"
>>   	@echo " $(MAKE) bench                         Run speed tests"
>>   	@echo
>>   	@echo "Individual test suites:"
>> @@ -46,10 +47,13 @@ FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$
>>   $(FUNCTIONAL_TARGETS):
>>   	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>>   
>> -.PHONY: check-functional
>> -check-functional:
>> +.PHONY: check-functional-precache
>> +check-functional-precache:
>>   	@$(NINJA) precache-functional
>>   	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
>> +
>> +.PHONY: check-functional
>> +check-functional: check-functional-precache
>>   	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
>>   
>>   .PHONY: check-func check-func-quick
>> @@ -57,9 +61,12 @@ check-func check-func-quick:
>>   
>>   # Consolidated targets
>>   
>> -.PHONY: check check-clean
>> +.PHONY: check check-thorough check-clean
>>   check:
>>   
>> +check-thorough: check-functional-precache
>> +	$(MAKE) check SPEED=thorough QEMU_TEST_NO_DOWNLOAD=1
> 
> I'm not understanding why this commit has the refactoring present
> too ? Wasn't it enough to do
> 
>   +check-thorough:
>   +	$(MAKE) check SPEED=thorough
> 
> the precaching download would just do the right thing already
No, that way, the precaching (i.e. the downloads before the tests start) are 
not triggered at all, and assets will be downloaded while the tests run 
instead. That means you'd easily run into timeout problems when the download 
takes too long. We need the check-functional-precache target for 
check-through to make sure that the assets are downloaded before the tests 
start.

  Thomas


