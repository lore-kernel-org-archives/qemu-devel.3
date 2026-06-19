Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF2CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waUr6-0007HH-5J; Fri, 19 Jun 2026 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waUr3-0007H6-4U
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waUr0-0005OT-Vm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781858733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0rCq//8WoD+LWfjg2suJkBTQWOZxIpy5fppYdXbbWEo=;
 b=Mbi7fpT1ttjVCBYpqL1dgcJkLz9hedrGfe2Drt7H3aYG8lx9ern4EFd/OlRbsFdkdxPERC
 S9vRJm30GXERH8TPBPV/J7Z2SZSSjV0lrodLqF1DERhlAZGNNp323AtDf76+vW79vpmRd3
 GqOgtolVjgNtKjscBPObEUhG6IWgyR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SWzIohG9OUu1A-1SqiESow-1; Fri, 19 Jun 2026 04:45:32 -0400
X-MC-Unique: SWzIohG9OUu1A-1SqiESow-1
X-Mimecast-MFC-AGG-ID: SWzIohG9OUu1A-1SqiESow_1781858731
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b5d2e394so11826175e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781858731; x=1782463531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0rCq//8WoD+LWfjg2suJkBTQWOZxIpy5fppYdXbbWEo=;
 b=XwVZEecfzXfw3EqnPbnqTq7l5E8XxgI9WqFsiuNUg55fhLiOmt1v7YhClCxhqbLOtU
 kMpuGpQitvQ2m21qJdoUPZ1nELn6OCy5gBUbAdKAo0QwbPqBHn7k/bNF4IINbrHKZOK2
 yY16CyLeEtctKphT4h7oLnjUwMsCwqwA2hJi9RyGk06+Ee6ilwJLYV2sGhPGCTuKBLEQ
 oK/SZLwSOvs8zFp/yS96Dnhg8SOyNWOYCjpSeP87pKv9PNABo0tr5/o7ArRkzOUD2fVK
 ty+vWcJABMl8vaJahvZiGn19NLcKxv0/PILtE4l4AVyJwzDv94aFQhtrk2EU7G9eYHbP
 Sx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781858731; x=1782463531;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rCq//8WoD+LWfjg2suJkBTQWOZxIpy5fppYdXbbWEo=;
 b=qRGFvlQye+jiTedzWfHlKWRy5KbwSHJHJehSEsdti2ZFyDtW5KVfZwAP0RR5OuOQ2G
 n8OaHLdzwV5scRMOexGN9PNb5hDxXkDwEYu8cvZ09dlFGWUFdIhjRfZ91ZYKueu4K50d
 t/JucAxlDxml6teSkiaqwIGpvO4yKoIEr2YXWa7RVYSy/mIib2VvRrbNj7LcZL3QwT3z
 34NLbUaLz8t/kxGUgBH3U7Zi1DFevFkUEfv88lb2MBYBVKlkNrQKfayT90DYyUDMBtN/
 +JqKh9CeBMqtb1sreukIcRLm67qa5ZqwVkJDNldGkTlEva51cPyuSD4JXqGRi1RnStXV
 Gbsw==
X-Gm-Message-State: AOJu0YzjTosuT1FmfNbs312tfrAMe2fYO68zxNeoJp9Zbmx/hc1Q7pn2
 GfP2vOiT0cZXDxorxxYoUxh1zHppoPpeE5zrq8rJep0IjOg+smusA9Yh8Ur+cHonvOnzmMqQw85
 +apLV0a9O1/5vMYZI77Z4lDztuPfLiC9DycNGEY/cj9WbVjNj/EESpdNF
X-Gm-Gg: AfdE7clVJQYEL61smWuV6t7wNy59L6OoA9wCDQZrtolaQNZIUmyfDTqBsDLIWev8lqU
 XUAxkqLeqQKd2Ww3uKAu2Cm+1wmnSZAnQVFuVtqyLul1H2gI+JWdEnJ9/41+Jh218NsXAOVzFVP
 JZ1Z6Dcn8W1G3187WMP0uqDSpWKmHfpgJpVb9giSlAuD+9rslq3nsC3elo5k51RqZl0TO156hw3
 3FMuG+18l+abRg3mP3xSRQdXhkNVsDZZWaEGmm9OQthgV9SUk8YquM/k3ABv2TCB2u6CaR9dcMY
 mxUsZCTu/3fwjVEdf/FXNReWe7yf+i7TEaQwO45fUrtWSH415leRBm5pXtm96rsf77oDWU8aM64
 RNWMehwk=
X-Received: by 2002:a05:600c:1f92:b0:492:3670:85a7 with SMTP id
 5b1f17b1804b1-49240eb1347mr40233035e9.35.1781858730560; 
 Fri, 19 Jun 2026 01:45:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1f92:b0:492:3670:85a7 with SMTP id
 5b1f17b1804b1-49240eb1347mr40232385e9.35.1781858730071; 
 Fri, 19 Jun 2026 01:45:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fcdd08esm31574015e9.0.2026.06.19.01.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 01:45:29 -0700 (PDT)
Message-ID: <351767e2-2e1b-47fa-bf96-29996e9ccf05@redhat.com>
Date: Fri, 19 Jun 2026 10:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] security: rework guideline about issue URL / CVE
 references
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260619082236.1175764-1-berrange@redhat.com>
 <ff565264-cabf-45d7-81e2-a35a23c79638@redhat.com>
 <ajUAyOd7mYaeiAlD@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ajUAyOd7mYaeiAlD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/06/2026 10.41, Daniel P. Berrangé wrote:
> On Fri, Jun 19, 2026 at 10:27:33AM +0200, Thomas Huth wrote:
>> On 19/06/2026 10.22, Daniel P. Berrangé wrote:
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>
>>> This incorporates the feedback that Michael provided on the
>>> just merged security process changes.
>>>
>>>    contribute/security-process.md | 23 ++++++++++++++++-------
>>>    1 file changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/contribute/security-process.md b/contribute/security-process.md
>>> index c091fa1..146e9cd 100644
>>> --- a/contribute/security-process.md
>>> +++ b/contribute/security-process.md
>>> @@ -92,19 +92,28 @@ be scrubbed before disclosure.
>>>     * The maintainer(s) will develop and/or review patch(es)
>>>       for the issue privately, optionally attaching work in
>>> -   progress fixes to the GitLab issues. All patches must
>>> -   include the issue URL in the commit message(s). The
>>> -   **"Workflow::In Progress"** label should be assigned when
>>> +   progress fixes to the GitLab issues. The
>>> +   **"Workflow::In Progress"** label can be assigned when
>>>       a maintainer starts working on a fix.
>>>     * When a CVE is allocated, it must be recorded as a comment on
>>>       the GitLab issue, and the **"CVE::Required"** label replaced by
>>>       the **"CVE::Assigned"** label.
>>> - * The maintainer(s) will update the commit message(s) to include
>>> -   the assigned CVE and issue URL. If multiple commits are required
>>> -   to fix an issue the CVE must be included in the final commit in
>>> -   the series, and may optionally be included in all prior commits.
>>> + * The maintainer(s) will update the commit message(s) before
>>> +   sending a pull request to include the assigned CVE and issue
>>> +   URL in the following format:
>>> +
>>> +     ```
>>> +     Fixes: CVE-1980-12345
>>
>> So far we used "Fixes:" to indicate the commit ID of the patch that
>> contained the bug. So maybe it's better to use something like "CVE:"
>> instead?
> 
> We've used it alot for CVEs too:
> 
>    $ git log | grep 'Fixes: CVE'  | wc -l
>    116

Ok, then it's fine for me, too.

  Thomas


> 
>>> +     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/75
>>
>> Maybe best to use a number here that does not exist, e.g. "42".
> 
> Oh yes, good idea.
> 
>>
>>   Thomas
>>
>>
>>> +     Reviewed-by: Not Me <notme@elsewhere.com>
>>> +     Signed-off-by: Some One <someone@somewhere.com>
>>> +     ```
>>> +
>>> +   If multiple commits are required to fix an issue the CVE must
>>> +   be included in the final commit in the series, and may optionally
>>> +   be included in all prior commits.
>>>     * When the maintainer(s) are satisfied that the patch(es) are
>>>       suitable to propose for merge, they must be submitted to
>>
> 
> With regards,
> Daniel


