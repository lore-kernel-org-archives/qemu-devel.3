Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFBCC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 07:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4T3-0001Gi-83; Mon, 17 Mar 2025 03:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4Sr-0001FW-Uc
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4Sq-0001t6-4W
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742194842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8puAN4A8grtk+65o5yszw0CbuvEKhKrxXKukvXlbK70=;
 b=bjlhMwEi/UAGn1E84VLncU8ZwwvcP1zh+RrfEqcBafZjVCGcTGZFlY5M/wzV5QBHgkSLIk
 kdseWGvBJHYwIq+tWPdE5H4bt1Y6l9Gpmiu/cMdevK5uUwhVSDdjJKfVyXp8V9ZQiNgAz7
 BnD0yctTjoyWOeb6qUnv4cVjkAzMiDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Ui023kbcM5WrejYdbCL9Hg-1; Mon, 17 Mar 2025 03:00:39 -0400
X-MC-Unique: Ui023kbcM5WrejYdbCL9Hg-1
X-Mimecast-MFC-AGG-ID: Ui023kbcM5WrejYdbCL9Hg_1742194839
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so14841605e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 00:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742194838; x=1742799638;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8puAN4A8grtk+65o5yszw0CbuvEKhKrxXKukvXlbK70=;
 b=U0IUtJXKVU6OFnAt3gX/WWfcERTVsMM2QPtUkOnl7tQw6BVVJV49TRNHEO+GLA45Tq
 1hhz+lP0wueCERjpa2mDI3VdKqFpnXpWB+/TOhHBTuWdJEWcaRyfW5eoiqMAKPR6xMbU
 9eZ5erwbrWvKANip7C8AFEjrsTXYxreIM9rUyV35kdJbEq+iKCqz3cA5Ly0J89sXxUq/
 SoF8qgbkB2Y+jXw9PSm3T8zeYz0fURlnwnUEuE0zi1+q22jhSoPJXSC87/2gmbQ5Sa9i
 GIWgFvEI+O+tNLNSrR8gK4t4HoO8au4K85nnLiwTbbZ4ddS0f6NDNV3Z+H0VAc8sFbbB
 HCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXgD3Uhb4a7FDjZ1IRCkS0yRJCKVBkjgOWsAEwNpoUQdn+JpEUmPcJ6LyiPYRngkZhe88R6FGrVBY@nongnu.org
X-Gm-Message-State: AOJu0Yxj4dN4PDd5pgNf7yWaalTu19DCe3UXQsU/weNRaMZCwshQqZ80
 5lf8ThwJUsyBbg6nWankHJ+G/8EXf52OxxpNyTeftGJioFTKJ65Ki/q3i0+dMf2n7osJf6+HXnM
 6OxSWDWEW1KwoyvOunqj0W4TmCb1b4AhKz73MSR+xiLH2wb45wNbq
X-Gm-Gg: ASbGncviYprmdhEzRNfX8ltrCkVaREHv43v1mIluTuOoiQq4c8ZmVPN/PnXMOrpLO+E
 khkWn8jtrH7+dBXsniCkCnokDFl9AFaXMunDQrakR1spJ1vbWBc6+jTtfKp/sSN9hltIuguKJvg
 UZgoRUQ5jB2UiUNIw1XfLBdLYZiNYeOXpdUiFKmliWxXyWsFA19X2BSQmBXMjzH3aptDAaf2QnU
 F3dzOnCfoVeeq4Nq6BvUd9Wf4GhBJyPX2B0IaRHuok6lsoV70XarhAq5xfiSMeIA+kap9p4xVXA
 rLxCQwunC8gI2UTZWvKMeOASkHPz6pa+YHskH2TxyT3RU+M=
X-Received: by 2002:a05:600c:5112:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43d1ec73438mr113943095e9.4.1742194838530; 
 Mon, 17 Mar 2025 00:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV6OgtGUjINt2rzuVP2PkXZW+MsAc6SK2of/HeN/vtQFfWeiHRxqi2qRGrARCFsfpyct+CFg==
X-Received: by 2002:a05:600c:5112:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43d1ec73438mr113942865e9.4.1742194838143; 
 Mon, 17 Mar 2025 00:00:38 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm95899505e9.27.2025.03.17.00.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 00:00:37 -0700 (PDT)
Message-ID: <8c5b08fb-de96-410d-9490-3e971f914c43@redhat.com>
Date: Mon, 17 Mar 2025 08:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/functional: Add test for fadump in PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
 <20250315064636.611714-9-adityag@linux.ibm.com>
 <8dad5654-6d0a-4045-abb1-2dee489f3102@redhat.com>
 <9eaf6719-ce8f-4d38-8ae3-b23506d69fe2@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9eaf6719-ce8f-4d38-8ae3-b23506d69fe2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 17/03/2025 07.51, Aditya Gupta wrote:
> Hi Thomas,
> 
> On 17/03/25 11:55, Thomas Huth wrote:
>>  Hi!
>>
>> On 15/03/2025 07.46, Aditya Gupta wrote:
>>> Add testcases for testing fadump with PSeries and PSeries+KVM
>>> combinations
>> ...
>>> diff --git a/tests/functional/test_ppc64_fadump.py b/tests/functional/ 
>>> test_ppc64_fadump.py
>>> new file mode 100755
>>> index 000000000000..3d6d3734e243
>>> --- /dev/null
>>> +++ b/tests/functional/test_ppc64_fadump.py
>>> @@ -0,0 +1,185 @@
>>> +#!/usr/bin/env python3
>>
>> scripts/checkpatch.pl recently got a check for SPDX license tags, so 
>> please add a SPDX-License-Identifier here now to avoid a warning when the 
>> script is run with your patch.
>>
> Sure, don't know how I missed it. Will fix it.
> 
> 
>>> <...snip...>
>>>
>>> +    @skipUnless(platform.machine().startswith("ppc64"),
>>> +                "KVM tests require the same host and guest architecture")
>>
>> I think this is likely unreliable: The test could run on a ppc64 host, but 
>> KVM could still be unavailable, e.g. if it has been disabled in the 
>> kernel. It's better to use self.require_accelerator("kvm") instead (which 
>> will also skip the test if it is not available).
>>
> Thanks, agreed, will remove it, and add self.require_accelerator("kvm").
>>
>> Also, shouldn't there be a "-accel kvm" somewhere if you really want to be 
>> sure to enable KVM ?
>>
> Will add it, this whole time I thought it's using kvm, guess the tests were 
> running in tcg mode only.
>>> +    def test_fadump_pseries_kvm(self):
>>> +        """
>>> +        Test Fadump in PSeries with KVM accel
>>> +        """
>>> +        self.do_test_fadump(is_kvm=True, is_powernv=False)
>>> +
>>> +if __name__ == '__main__':
>>> +    if os.getenv("DEBUG"):
>>> +        logging.basicConfig(level=logging.DEBUG)
>>
>> The setUp function in QemuSystemTest already sets the log level to DEBUG, 
>> so this should not be necessary?
>>
> I did that to see the QEMU VM booting logs. I see in QemuSystemTest, it sets 
> the log level of some loggers to DEBUG, don't know if it's the same, as I 
> didn't see the boot logs during testing (also, in QemuSystemTest, we are 
> setting specific loggers to DEBUG, while I did .basicConfig to DEBUG which I 
> think is like a global debug level setting)
> 
> How do I get the system booting logs in `make check` ? I didn't find it in 
> the docs.

The log files should get written to 
tests/functional/ppc64/test_ppc64_fadump.* - main log file is base.log, and 
the console output should go into console.log. Can you spot there the 
information you were looking for?

Anyway, that information is missing in the docs indeed ... I'll try to come 
up with a patch when I got some spare time for it.

  Thomas


