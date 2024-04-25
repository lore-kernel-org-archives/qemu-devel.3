Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D460C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00nu-0006Vj-7y; Thu, 25 Apr 2024 11:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00nq-0006VG-GS
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00no-00026V-M1
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714058063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tsPYWKCxgj/T5fDF1SDgtECccyci+CGueWDj8ewZvys=;
 b=F1foZAbgsNsGjmGZEe02AR1NPQ8QDruFZYLuLABxIgT+iHOUt6F2FnpVmcRME75GBCFBDW
 dRH44pD3uRrtYd67god3aj3/40w7Cf3+R7n7OQW1xFw230qQlhQ/L8fS0AsrXMYEycnf/2
 7QPJV/aTEzDhS15pV6QERsOhwwtQtZM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-LPzX9hScPEOy9_yXjYUjUQ-1; Thu, 25 Apr 2024 11:14:21 -0400
X-MC-Unique: LPzX9hScPEOy9_yXjYUjUQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6efef492e79so1475332b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714058059; x=1714662859;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsPYWKCxgj/T5fDF1SDgtECccyci+CGueWDj8ewZvys=;
 b=LFtQcXJ9ir0wmLvds4S69OxUNu2Lhzr9QHhD4VOkaV5p861KQ/OpnfWvOHQn/Vcmuw
 G0h7uQMlorj95IRzPoBKpsvVeBV1PkOw6ORJWv8Tuz9FyZxZbF8xzmgTu1BlqUVuWi71
 HHvJqo0KZRYAALpK5+h9bmlsz0+Rtu4qrwpYqxmYZjaP+apARS3PPTjSQonydnJXIKoe
 2LblqfidCA7R8Rdqg8kf8cAa+imgx/DrrXoV8juZXb79F8aoAYeXZdJ0KPXAvS8HAwyx
 Rz821jjQV/sUJaXcimodgEEFC7HVeHJ4IJYA18judOaaEer0BITOiL4S0Y+UNyh3Ffxk
 nRpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Z8q0qM2oO+mNmmhQ26DuKIfQa3af4epUxVTwIKWl53iL0WtUwlM9e5IEXgMX9tu2QtxVXXTNI9fboBOBUWHcRdw6pfg=
X-Gm-Message-State: AOJu0Yx3ne1fe9lYJ3qKm9MdDHLO1edJHKeJqDxWrXDUfT4AH6bPo0mx
 OG3c6kEgfL7sSZKhqjcT71ZcKk/wh7ACkRkJBXlkOvLXmurzrWPdIR1y4k52XRbsFsZ29sOSvWP
 KmCcteS7AAk4z2cScK6ttqGFNsSKjOccyuw5RmIIxmyMgGnvZ+eXv
X-Received: by 2002:a05:6a00:399d:b0:6ec:db05:36cd with SMTP id
 fi29-20020a056a00399d00b006ecdb0536cdmr55431pfb.9.1714058059595; 
 Thu, 25 Apr 2024 08:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzNmTJMw0nj1TmMutuII4mD6sEYQm3V19ZBr5l76aA9ql3V5IfL81DF3rS1wF/lKPjKfYhGg==
X-Received: by 2002:a05:6a00:399d:b0:6ec:db05:36cd with SMTP id
 fi29-20020a056a00399d00b006ecdb0536cdmr55402pfb.9.1714058059214; 
 Thu, 25 Apr 2024 08:14:19 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-130.web.vodafone.de.
 [109.43.177.130]) by smtp.gmail.com with ESMTPSA id
 fb22-20020a056a002d9600b006eceaccaec9sm13208873pfb.131.2024.04.25.08.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:14:18 -0700 (PDT)
Message-ID: <aff6768f-a659-4c25-8417-2f24007c5fc3@redhat.com>
Date: Thu, 25 Apr 2024 17:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
 <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
 <f8aee65f-7cda-46a7-8c13-3d3645f130bf@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f8aee65f-7cda-46a7-8c13-3d3645f130bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/04/2024 17.04, Richard Henderson wrote:
> On 4/24/24 22:11, Thomas Huth wrote:
>> On 24/04/2024 18.21, Richard Henderson wrote:
>>> On 4/24/24 00:57, Thomas Huth wrote:
>>>> The following changes since commit 
>>>> 13b1e9667737132440f4d500c31cb69320c6b15a:
>>>>
>>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into 
>>>> staging (2024-04-23 17:35:57 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24
>>>>
>>>> for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:
>>>>
>>>>    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 
>>>> +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> * Update OpenBSD CI image to 7.5
>>>> * Update/remove Ubuntu 20.04 CI jobs
>>>> * Update CentOS 8 CI jobs to CentOS 9
>>>> * Some clean-ups and improvements to travis.yml
>>>> * Minor test fixes
>>>> * s390x header clean-ups
>>>> * Doc updates
>>>
>>> This introduces a failure in the migration-compat-x86_64 job:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/6707154868
>>
>> It wasn't failing for me:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/6702058896
>>
>> And according to the diffstat of my pull request, it's only touching test 
>> files, docs, and s390x stuff, so I somehow fail to see how it could 
>> influence x86 migration at a first glance. It also looks like the job is 
>> running on opensuse, and not on CentOS or Ubuntu, so it should likely not 
>> be influenced by the changes in this PR.
>>
>> Could you please hit the re-run button of that job? If it then passes, 
>> we're likely rather facing an intermitted failure that might have been 
>> introduced earlier already...
> 
> It did pass when re-run.

Ok, thanks! So it's likely and intermitted problem indeed...

I've now submitted a v2 of the pull request where I just dropped the other 
problematic patch that tried to update the custom CentOS runner ... I hope 
that PR should be fine now.

  Thomas


