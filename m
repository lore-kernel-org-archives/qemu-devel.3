Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488BC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYT1-0001ly-BG; Fri, 08 Mar 2024 06:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riYSz-0001k5-6x
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riYSx-00082i-F5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709897562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G5TwqMr/piQqEVlLmpiNbiRN/c+6k9A5RdoxxvDGtl0=;
 b=doQATUkzKJsS2yZkblURbRU8NG73BZ8SopiztFaEXSnTBj+4gEsJH4c3nqA6nRkzl6k2cL
 jJ7ZbBsTpSF2CSqkXL8f2ziagLDI6BQ5bEifkZLFHQjsKHOisIqraGYsomqDTrruJbP6d4
 mShkLsUhpa+liNxbr/tMnZL+JGU4GtU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-hHna2RE9N1y82tccqZ4_vQ-1; Fri, 08 Mar 2024 06:32:40 -0500
X-MC-Unique: hHna2RE9N1y82tccqZ4_vQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-59907104d88so1992310eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709897560; x=1710502360;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5TwqMr/piQqEVlLmpiNbiRN/c+6k9A5RdoxxvDGtl0=;
 b=LrfUlEi2y1tsjoxDzCyZsZ24J46hcMpR59NO/x52zSxELmwqwiS/+3vYepo7Ao4XPt
 yJ8Bujm/dEMAzeI2XGO5WwUwtSVZImKr/VpNJ0zuX8YfPECbljQVQWfKDcCbeFfF02aT
 8fltqRen4yEJ2+6zGJBXMfnRsqoSW4zKigCph55Asjqr24w294vmAzIR0JWAT2I9uSwZ
 BHojGFmpzqg7LEZN/ZIo2S8bTGdQMkngy+6waj+oMT7Uty75NObtYwB/R+CXtw8oy5BL
 Y/dEm3ZmHf69KEd82w/tfD2a0PDZjZjwoboptDdZ9iZEGCHZR2ab6URo3IMt+V6/6u49
 XigA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6bT+/2zfY4BmhlLwkVnaYnhxwG/Q0M0bAFbMnZ/aNLH34Lk5256OG6IkCv1VaOMzBElw4icDL3V5Kx8hTQG2X/0E3ow=
X-Gm-Message-State: AOJu0YxqE3yy5qEwUxAj2eLUF8ZkWfoISZ4jSE2N5qHJ3OQHx3WkERaE
 F6gDwSf40DSWNEtGc0RsDDhEe8IFHCQ29HCkXLmh3jJMMpuG9lW0mE9sdFSRRBaBrJKnAdEPPNw
 neTdUHGH1kXnSvyNaQeyCZE1d1bu2fYNDmSgmfytDtZ+O0y7pXL3j
X-Received: by 2002:a05:6358:5685:b0:17b:f465:c67a with SMTP id
 o5-20020a056358568500b0017bf465c67amr12580562rwf.29.1709897559817; 
 Fri, 08 Mar 2024 03:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv2qYR26jIaraZhcWQIT/fpffZfW127/qwbY1spN05upaI5eCRjABDM8LAeZ4crmysXnsMyA==
X-Received: by 2002:a05:6358:5685:b0:17b:f465:c67a with SMTP id
 o5-20020a056358568500b0017bf465c67amr12580531rwf.29.1709897559478; 
 Fri, 08 Mar 2024 03:32:39 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 25-20020a05620a04d900b007882528475dsm5556975qks.49.2024.03.08.03.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 03:32:39 -0800 (PST)
Message-ID: <bb66c3f5-73b9-4ee8-b186-8384168c8930@redhat.com>
Date: Fri, 8 Mar 2024 12:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Fix error message when C compiler is not
 working
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240308060034.139670-1-thuth@redhat.com>
 <CAFEAcA-0kNwed8SbceWuR89mFMvfwfPpQaJJfdoRoM3az8vttQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-0kNwed8SbceWuR89mFMvfwfPpQaJJfdoRoM3az8vttQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 08/03/2024 12.26, Peter Maydell wrote:
> On Fri, 8 Mar 2024 at 06:01, Thomas Huth <thuth@redhat.com> wrote:
>>
>> If you try to run the configure script on a system without a working
>> C compiler, you get a very misleading error message:
>>
>>   ERROR: Unrecognized host OS (uname -s reports 'Linux')
>>
>> We should rather tell the user that we were not able to use the C
>> compiler instead, otherwise they will have a hard time to figure
>> out what was going wrong.
>>
>> Fixes: 264b803721 ("configure: remove compiler sanity check")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   configure | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 3cd736b139..a036923dee 100755
>> --- a/configure
>> +++ b/configure
>> @@ -411,7 +411,7 @@ else
>>     # Using uname is really broken, but it is just a fallback for architectures
>>     # that are going to use TCI anyway
>>     cpu=$(uname -m)
>> -  echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
>> +  echo "WARNING: could not determine host CPU, proceeding with 'uname -m' output '$cpu'"
>>   fi
>>
>>   # Normalise host CPU name to the values used by Meson cross files and in source
>> @@ -1000,10 +1000,12 @@ if test -z "$ninja"; then
>>   fi
>>
>>   if test "$host_os" = "bogus"; then
>> -    # Now that we know that we're not printing the help and that
>> -    # the compiler works (so the results of the check_defines we used
>> -    # to identify the OS are reliable), if we didn't recognize the
>> -    # host OS we should stop now.
>> +    # Now that we know that we're not printing the help, we should stop now
>> +    # if we didn't recognize the host OS (or the C compiler is not working).
>> +    write_c_skeleton;
>> +    if ! compile_object ; then
>> +        error_exit "C compiler \"$cc\" is not usable"
>> +    fi
>>       error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
>>   fi
> 
> Why doesn't it work to check the C compiler works before we
> do the "what is the host CPU" test ? Does that make the
> --help output not work when there's no C compiler?

Right, that's the problem: --help would not work when there is no working C 
compiler.

  Thomas



