Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE957CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqoe-0002H8-JS; Mon, 07 Oct 2024 12:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxqoc-0002Ge-Q8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxqoa-0001Ba-Rh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bRaMEuv7WvJ0RilDuD8FgmB9mFJOz6JJGe3cI5SCpLo=;
 b=A5icH8+VZqIl7pnoMnphentnd8XzSx6//dKWX38wrExEE+WeXG2Yf7W0o4eqvgQWdmz8bQ
 dyz+jh7lfoO2FbmyWodxjHyeUgMm6D3ZJs0sCRZJ3eUb508AT9YlE76Uiufgl9bI+Bn71B
 C4+diNChtNvIPmeC+EFI2fDpoKaq6ws=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-1K3NKem6O96Znxqgh38uRQ-1; Mon, 07 Oct 2024 12:41:11 -0400
X-MC-Unique: 1K3NKem6O96Znxqgh38uRQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso42018375e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319270; x=1728924070;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRaMEuv7WvJ0RilDuD8FgmB9mFJOz6JJGe3cI5SCpLo=;
 b=HuNdr3wmGSZaXtbYkuEI7ZLzyrKHvY/ntgO1pJsnDrgyU5aVgCiPKF935kmj3ztDLL
 MVsSQMfGxXHCoNVMVM5LOfc2OZp4jDuMrYGApgYsCmIOBm7/3wG6nlNKWB8uVATAkSVl
 GYHBIBu8/tArTcIDMLriJeDgXrHpzZ8uDkuynqu/b9SaCGKi34JbN3oexUcpHlpkuQnm
 nAdwXlQtMJtVXzRXgEl/RlEGnYhlMolUTMlg1zflpaSYIrEtkuomHSwo0Fzm/06QUNPc
 BvcO0Jc64/wZxptq+wSVBOmsRJOQ76XKPzPuUoabJ4tRlbxX9wPFRS5tkPEyeGsp4EBi
 oFTQ==
X-Gm-Message-State: AOJu0YxhFDdrsUmokHjg1OU7lOZdmM3Zsg9tKZZnifbj2Kj6Mp0QgBjp
 HDFSQmL+ThKS1+PrwfDwU72bfQxZk38aMKjSnCLu1p956pppz8vk0Dxobvt4giTfBmTpSzmeVdD
 3n1Gskg8OLXKn3mrvQoSWwE69elToT9wHaQ1flfegPwjhPtFutyMrSTUdSoY2f4g=
X-Received: by 2002:a05:600c:215:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-42f85b64a17mr82160075e9.32.1728319270617; 
 Mon, 07 Oct 2024 09:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgPkr1K+VaVCtvsRCu+7PXoq3EiuN0HmXlmAf7fbcUJs7OWHE8OAV9TWFe9h0ccYsxYHyDUw==
X-Received: by 2002:a05:600c:215:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-42f85b64a17mr82159855e9.32.1728319270082; 
 Mon, 07 Oct 2024 09:41:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d826sm96893395e9.26.2024.10.07.09.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 09:41:08 -0700 (PDT)
Message-ID: <bfbc94db-f0eb-42dd-b52e-4d1a2a1a9cdc@redhat.com>
Date: Mon, 7 Oct 2024 18:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] CI fixes and various clean-ups
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241007115027.243425-1-thuth@redhat.com>
 <CAFEAcA8C1K5jXvSAf_DpSFDDzj-hDSuduCsuyLa5N2M1Vu0_kQ@mail.gmail.com>
 <CAFEAcA-aCr8FAFQPJN4a96DPCQ5+7jrZZGvsX=EJdeSy3irH1Q@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-aCr8FAFQPJN4a96DPCQ5+7jrZZGvsX=EJdeSy3irH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/10/2024 16.13, Peter Maydell wrote:
> On Mon, 7 Oct 2024 at 14:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 7 Oct 2024 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>>>
>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-07
>>>
>>> for you to fetch changes up to d841f720c98475c0f67695d99f27794bde69ed6e:
>>>
>>>    tests/functional: Bump timeout of some tests (2024-10-07 13:21:41 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * Mark "gluster" support as deprecated
>>> * Update CI to use macOS 14 instead of 13, and add a macOS 15 job
>>> * Use gitlab mirror for advent calendar test images (seems more stable)
>>> * Bump timeouts of some tests
>>> * Remove CRIS disassembler
>>> * Some m68k and s390x cleanups with regards to load and store APIs
>>>
>>> ----------------------------------------------------------------
>>
>> This suggests it's moving back to the gitlab mirror for the
>> advent calendar tests, but one CI test still failed trying
>> to access http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
>> and getting a 503 from it:
>>
>>    https://gitlab.com/qemu-project/qemu/-/jobs/8009902301

Yes, that day13.tar.gz is from 2023 which is not included in the mirror on 
gitlab (yet). If we continue to see failures with the original site, I can 
have a try to put it into the mirror repository, too.

> On the rerun it managed to download:
> https://gitlab.com/qemu-project/qemu/-/jobs/8011303154
> 
>> The clang-system test also hit a couple of timeouts:
>>    https://gitlab.com/qemu-project/qemu/-/jobs/8009902206
>>
>> 61/109 qemu:qtest+qtest-alpha / qtest-alpha/qmp-cmd-test
>>    TIMEOUT 60.10s killed by signal 15 SIGTERM
>> 93/109 qemu:qtest+qtest-arm / qtest-arm/qmp-cmd-test
>>    TIMEOUT 60.04s killed by signal 15 SIGTERM
>>
>> which are presumably pre-existing intermittents, but I
>> mention them here just FYI.

I neither had anything related to arm/alpha nor to qtests in my pull 
request, so yes, it's likely something pre-existing... maybe something from 
the previous pull requests? (or did you see these in the past already?)

>> Some of the other qmp-cmd-test
>> runs in that job also came close to timing out:
>>
>> 102/109 qemu:qtest+qtest-m68k / qtest-m68k/qmp-cmd-test OK 56.56s 65
>> subtests passed
>> 105/109 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-cmd-test OK 53.74s
>> 65 subtests passed
>> 106/109 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test OK 45.48s 65
>> subtests passed
>>
>> so maybe we should add it to slow_tests with a 120s
>> timeout...

Ok, m68k and s390x have been touched by this PR ... but still, it's one 
qtest (qmp-cmd-test) that is failing for multiple targets, so it rather 
sounds like we've got a regression in one of the previous PRs?

> As expected, these are all intermittents; on the passing job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8011303114
> 
> they completed in 19s, 20s, 19s, 19s, 19s. So we're seeing
> factor-of-3 variation in job runtime on this k8s runner :-(
> 
> Anyway, I've pushed this pullreq; we can look at the above
> two things as follow-on fixes.

Thanks!

   Thomas


