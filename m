Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECA4C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXGx9-0000JS-Vy; Fri, 26 Jul 2024 05:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXGws-0000I7-U0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXGwp-0008AU-DJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721984948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EqEJZMXThtbbfYabBCzeDMXz6trq1o20U4ZUzCVT7xE=;
 b=Lp9mfWIP9D9ndqTspaub4CABQUe2VGnuXHFuwPHErsOr/ThHVhQ5xPxWGYTQ+0w75ds7Wf
 aO2Oin8xRXAK8SJ5El2lk2Jak0EeIe8jBICfm812UoNZU4jrF3nIOAFide21JmjhS7a74v
 MWjH9vIW5pdrTVnXEDJ5eD5yQ04EVJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ReAeFQVMOgO9nXaXPe-O6g-1; Fri, 26 Jul 2024 05:09:07 -0400
X-MC-Unique: ReAeFQVMOgO9nXaXPe-O6g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-428077f91a9so7673825e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721984946; x=1722589746;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqEJZMXThtbbfYabBCzeDMXz6trq1o20U4ZUzCVT7xE=;
 b=C2oy3kme7MP5oXkzpk4NsfnsOkw700JmnaRkZqjzsuZaSGrx0FnoSjFc/esEJP+WOS
 6vJ2DghyqzLn8rZ+QZFuu+fV0+dvmggIEJSude+uvA1NF5MT6XBxJtbOHDv94aIKqeHe
 DauoFUYboAlO7tqa9edXKeBQLZaft1I3yDCXRU5786E8Wr8LEp0F19UEXzWnWyudtP5m
 arSR+CJc2dC+OhsyYd3Ksl+tS8pgc1ZH++Ucii7alu484TIJD4TWs6a31OAUc2Z4pn/Z
 u8BaXPR4sE7C22hqVzPg5vHadcQFsm+34OVHbOVpwrxkSJ7G5OquL1SWr8wlabeJJw0D
 UnGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc77a8RRaisCCFrTNM2a+EorJbFq5wMcAhPwJBQ3xKgIpYPEEBa0gfRLQxIYANjivtilxsXjIb/lr8JZfRv2B5zwBemco=
X-Gm-Message-State: AOJu0YxbiYeu3ANbX/2fKMKsgo7h56ps7caLcP7HGBhDHjriDPIrOP2L
 l0nTPqo34ogGD6hWSAazY8HpnaCVAJRwLN/H1WNUR8dbfPcTZSQUOSDyR0iK5eR3oX1cukBRYah
 aAQgJS/fE7zLzLBoyZ/h/YocrFDQH4QM5UiTQZIWAUt7Cgf637mCM
X-Received: by 2002:a05:600c:1c83:b0:428:837:7015 with SMTP id
 5b1f17b1804b1-42808377505mr28437295e9.13.1721984946128; 
 Fri, 26 Jul 2024 02:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF8neW/NjExv5oI1QUcJNr2gUanqvtijhf2Z+ZVPAkKYM1Z8QuJXiHeExRrrd5ePisClfsmw==
X-Received: by 2002:a05:600c:1c83:b0:428:837:7015 with SMTP id
 5b1f17b1804b1-42808377505mr28437015e9.13.1721984945711; 
 Fri, 26 Jul 2024 02:09:05 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fce64sm4460742f8f.61.2024.07.26.02.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 02:09:05 -0700 (PDT)
Message-ID: <c6548713-6c80-4c56-925f-de88fd18d34d@redhat.com>
Date: Fri, 26 Jul 2024 11:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user
 job
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, alex.bennee@linaro.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240723232543.18093-1-richard.henderson@linaro.org>
 <76357626-9714-49f7-9ca5-d2a42cd56ab6@redhat.com>
 <bd367b1e-1858-4344-97d9-d0ed0d1890f6@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bd367b1e-1858-4344-97d9-d0ed0d1890f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 26/07/2024 01.33, Richard Henderson wrote:
> On 7/24/24 16:08, Thomas Huth wrote:
>> On 24/07/2024 01.25, Richard Henderson wrote:
>>> With -fsanitize=undefined, which implies -fsanitize=function,
>>> clang will add a "type signature" before functions.
>>> It accesses funcptr-8 and funcptr-4 to do so.
>>>
>>> The generated TCG prologue is directly on a page boundary,
>>> so these accesses segfault.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> What happend to Akihiko Odaki's more generic patch:
>>
>>
>> https://lore.kernel.org/qemu-devel/20240714-function-v1-1-cc2acb4171ba@daynix.com/
>>
>> ?
> 
> This patch does not work:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7432239478/viewer#L4956
> 
> I presume this is an argument ordering issue vs --extra-cflags.

Ok, then we should definitely go with your patch to fix the job now. ... and 
I just saw that you already applied it 👍

  Thomas


