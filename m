Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA0BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEvf-0005os-S0; Fri, 12 Jul 2024 07:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSEve-0005lC-NT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSEvc-0003ZI-HZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720785546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gt/JMCWBo8W3MXuK3jYM/Tk0lLpO5nk8HHi9J1NS6zc=;
 b=AHSeL2ZAEbS0RTmaEDrTxHuEyyYDogQqTYpk8W+u2NyKgMzyORmbAfd1xkPe8XHQlcBF0H
 VSygT7FNQ4iY0xV5AJ0VLYzvQ9Stb/Sw8jQdHetH/VpLq47Co740q4QeUbqrno3x8hzO9t
 Qj6oD1os6fEOYIK7qbhf0RlefTjBurs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FhSbus5CMQSFzfr7Rh4KKg-1; Fri, 12 Jul 2024 07:59:05 -0400
X-MC-Unique: FhSbus5CMQSFzfr7Rh4KKg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77f0eca75bso188501166b.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785544; x=1721390344;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gt/JMCWBo8W3MXuK3jYM/Tk0lLpO5nk8HHi9J1NS6zc=;
 b=NjKKSQbaYtOXBfLgh7zkYIUPIP5ta2YwM2vIJz7IJ9Ke9+PxbL5n1YDE+p1Z1YI0OD
 xu6cvwyzNwmMSAT6TSVz+/LmknH13UmFpqmz3l4D4zlWu01d0p7ZDNB0IJOjNZOrnBzs
 KxXspTJhZ739oB4l3PKwOBokz8t10UtXr4NHBh1E6Q32pcsP8bzFFHO3dIpLb+fPvrbG
 XOVdVW28ZQlTwZ85V9FlaMdOYbLKwizPD1PUuKR1fgVPf0W1i5ki7EvsJFjjuTy7YbxE
 uA/1Hln3N6qYpjv4o18UFanWJxwN/gOevBFSK5veOLHJE2BFiMsG4DF2LVjxyrOJVxWg
 iyNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbnHazkh8ikG4UqTJHlGHsMSsxa0e5mROCeGuPRIMDp61J4vnG4SAmXlgamiGurusxoETbcY+QI4MgD6dS3nKNDD/8ZuY=
X-Gm-Message-State: AOJu0Yw6cGBlfcpb0eVAQdZgs2ne6BfxN0p+AoyIKoQ4YvnKlMEUECjG
 Z7AVOQIxV5lJeZzlQvvLrLi3oH3P1umXHcqJte/PFdKzulBUV112sk5bBvPFwJuse5XQlwIwZFv
 GuDEpCitwkVpWgZIHxrTpOBIluGjXS1q98ed4H3isl7LwJvUNCqI0
X-Received: by 2002:a17:906:f588:b0:a77:c364:c4f3 with SMTP id
 a640c23a62f3a-a780b8855dcmr1008136566b.55.1720785543924; 
 Fri, 12 Jul 2024 04:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCPIG3fqcQFTi42vO8AMGw5iTB6vN9bcDtWyFO0qL7eNSAmkz+F+BJf9sq7VX14Eu8EzkIng==
X-Received: by 2002:a17:906:f588:b0:a77:c364:c4f3 with SMTP id
 a640c23a62f3a-a780b8855dcmr1008134566b.55.1720785543542; 
 Fri, 12 Jul 2024 04:59:03 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8542bdsm334771466b.156.2024.07.12.04.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 04:59:03 -0700 (PDT)
Message-ID: <8e04c36b-62eb-4931-b529-48dc983cc6cf@redhat.com>
Date: Fri, 12 Jul 2024 13:59:01 +0200
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
 <154a3249-b99e-4f93-bc45-0f34d08c1c6a@redhat.com>
 <ZpEX7sMLODBuiMBk@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZpEX7sMLODBuiMBk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

On 12/07/2024 13.47, Daniel P. Berrangé wrote:
> On Fri, Jul 12, 2024 at 12:14:45PM +0200, Thomas Huth wrote:
>> On 12/07/2024 11.01, Daniel P. Berrangé wrote:
>>> On Thu, Jul 11, 2024 at 01:55:42PM +0200, Thomas Huth wrote:
>>>> From: Ani Sinha <ani@anisinha.ca>
>>>>
>>>> Integrate the pytest framework with the meson build system. This
>>>> will make meson run all the pytests under the pytest directory.
>>>
>>> Lets add a note about the compelling benefit of this new approach
>>>
>>>     With this change, each functional test becomes subject
>>>     to an individual execution timeout, defaulting to 60
>>>     seconds, but overridable per-test.
>>
>> The avocado runner uses timeouts, too, so it's not really an additional
>> benefit that we get here.
>>
>>> For CI purposes we'll need to add 'python3-pytest' to
>>> tests/lcitool/projects/qemu.yml, and re-generate the
>>> the dockerfiles. Some of the other non-gitlab CI
>>> integrations probably need manual additions of pytest
>>> packages.
>>
>> I'm currently rather looking into getting rid of pytest and to use pycotap
>> instead: Using the TAP protocol for running the tests, you get a much nicer
>> output from the meson test runner, which can then count the subtests and
>> properly report SKIPs for tests that have not been run.
> 
> I've just looked at pycotap and IIUC, there's no command line
> tool equivalent to '/usr/bin/pytest' at all. Each test case
> is expected to provide a stub for "__main__" to invoke the
> tests.

With pycotap 1.3.0 you could run tests through "python -m pycotap ...", too. 
But for playing nicely with meson, I'd like to set message_log and 
test_output_log to LogMode.LogToError instead of using their default value, 
so I need my own wrapper code anyway.

> As such each individual test is directly executable.
> This meshes nicely with what I'd suggested as changes in
> patch 1, and eliminating the intermediate runner process is
> a nice further simplification. So I'll be interested to see
> your next version using pycotap.

I'll try to post it as soon as I have something at least in a somewhat more 
proper shape than the RFC ;-)

  Thomas


