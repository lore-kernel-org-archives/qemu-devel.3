Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10650C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 04:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1fAf-000797-SW; Tue, 30 Apr 2024 00:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1fAc-000777-Rh
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 00:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1fAa-0006xd-QL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 00:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714451563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QssvKmbsr5Qu0Uxt49IX79HwWrGFL4OmzG6gp5FBEro=;
 b=CFTKVSeuMtCgJ0yskwSkQExDdlD7QBFzARVZQRe7velRGNeDgnjao9vq+5NReWE9BiX2Pv
 u4A58IYqw4CF/VizIiK3+GWuWAydTNsFP6iav0QVrSsTeGAGF90lDmeS1TK602uJu1Ft6S
 gyCrfmP3LGMwqdF0Kz6kvzyaJNxZiW4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-kRZpBlX6OtKejNmhLzflow-1; Tue, 30 Apr 2024 00:32:40 -0400
X-MC-Unique: kRZpBlX6OtKejNmhLzflow-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a58b9cf05afso280521966b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 21:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714451560; x=1715056360;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QssvKmbsr5Qu0Uxt49IX79HwWrGFL4OmzG6gp5FBEro=;
 b=HQSJAWj7GYFgsZc04p9Garb0BGsl610Nn5Qavw/GlUHB0hGmGYgGNnN3N1wfovhzkX
 wjtoAT+qwqwlf49A29Fz8mz52NYqB/YmJ59xGArVHxfzKq96WjcjuYCWH2HYuhv+vPxK
 P3ItCu805nK6if5rI9EY47eB9rb4TKO4D8hvKC+LEk+87mJ9aYWD2wHQtRXhVkuiVMH4
 10tRz25m6pdSHwJBwUcOyOEENRsZAmo4OXzH+4Hypl9rrDWBEWsqIFdUFPR/MAahC1Bo
 OmFsr9u3P6kwirZNjL+vi7lz27uSA2HNF0LNOYvM/AzTLehV0JFhC+IPPohWL6dLXhUk
 wmuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY8AWO/WvNS6JxEKUQtEFV8ir0LHRGq51qEp1DGboXq+pYW4ow0itkbGHCSeND9X4b2oAT8OMNaw0aFOf2mBaYUuvkPQk=
X-Gm-Message-State: AOJu0YxjBwMVk2exkVX7Mhs7RFYFOLxJyUdZ+xXs40aeZ/fI+IeItlAC
 XurAXqA/HmgZVF2BPEXFmtfgS4pVqAZe3mYHAPe+VMkSisL8pcPhBpWmO2SckEnVIC5lysIUZay
 FnfYcycXEC6U7Lx+Crnrzk8BS1ySeNOatuu30bQMr7JmP6I8uFMgh
X-Received: by 2002:a17:906:5389:b0:a52:8062:a8d0 with SMTP id
 g9-20020a170906538900b00a528062a8d0mr11138377ejo.58.1714451559805; 
 Mon, 29 Apr 2024 21:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDTLwMzZxFE72y37kJY/v850H2gP4Z0nX090TAU9m8D0JdXGXk6Giam2MKgORTQzrV7MCPMw==
X-Received: by 2002:a17:906:5389:b0:a52:8062:a8d0 with SMTP id
 g9-20020a170906538900b00a528062a8d0mr11138362ejo.58.1714451559469; 
 Mon, 29 Apr 2024 21:32:39 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 dq16-20020a170907735000b00a524318c380sm14596968ejc.80.2024.04.29.21.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 21:32:39 -0700 (PDT)
Message-ID: <5f2036ba-8fa6-4c75-9ac1-b782638027f5@redhat.com>
Date: Tue, 30 Apr 2024 06:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] hw/ufs: Fix buffer overflow bug
To: Richard Henderson <richard.henderson@linaro.org>,
 Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, zheyuma97@gmail.com
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
 <f2c8aeb1afefcda92054c448b21fc59cdd99db30.1714360640.git.jeuk20.kim@samsung.com>
 <46836849-4a23-4b7d-9940-5d3ce1f63a12@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <46836849-4a23-4b7d-9940-5d3ce1f63a12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 30/04/2024 02.17, Richard Henderson wrote:
> On 4/28/24 20:25, Jeuk Kim wrote:
>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>
>> It fixes the buffer overflow vulnerability in the ufs device.
>> The bug was detected by sanitizers.
>>
>> You can reproduce it by:
>>
>> cat << EOF |\
>> qemu-system-x86_64 \
>> -display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
>> file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
>> ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
>> outl 0xcf8 0x80000810
>> outl 0xcfc 0xe0000000
>> outl 0xcf8 0x80000804
>> outw 0xcfc 0x06
>> write 0xe0000058 0x1 0xa7
>> write 0xa 0x1 0x50
>> EOF
>>
>> Resolves: #2299
>> Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   hw/ufs/ufs.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> For some reason this appears to cause failures on s390x:
> 
>    https://gitlab.com/qemu-project/qemu/-/jobs/6740883283
> 
> All of the timeouts are new with this patch alone applied,
> and go away when reverted.
> 
> I wasn't aware that these tests used ufs, but I have no
> other explanation...

I don't know for sure, but the test failure might instead be related to the 
problem that gets fixed by 
https://lore.kernel.org/qemu-devel/20240429075908.36302-1-thuth@redhat.com/ 
... I'm preparing a pull request for that fix right now, so maybe you could 
try this ufs pull request afterwards again to see whether the problem is fixed?

  Thomas



