Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F96C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNTj-0006Ww-Rs; Wed, 26 Mar 2025 05:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txNTU-0006Co-F8
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txNTR-0005pJ-H2
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7tggq3H2Twx6i0OzFx6BEcfv9tpn/ub9lyap8LepMbY=;
 b=X1McOl5gla0XBE3jU1HZmwK+lpA7v5P1pn9XPG7mIUkrXs1I4pKFn25e6TIz1h3fVIbGZa
 WE5ABlDAoZ/KU0RTPVruGq8NxVTQLMxpOY8WEwRljT8jdMBCPmslNps7jxNBySErGz8v+m
 lzTGaU6RCDmtP6GXL2+x3q/VXWPH2Aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-9yZdbD-ANTeyeE0VIl_B3w-1; Wed, 26 Mar 2025 05:54:56 -0400
X-MC-Unique: 9yZdbD-ANTeyeE0VIl_B3w-1
X-Mimecast-MFC-AGG-ID: 9yZdbD-ANTeyeE0VIl_B3w_1742982896
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so51389785e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742982896; x=1743587696;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tggq3H2Twx6i0OzFx6BEcfv9tpn/ub9lyap8LepMbY=;
 b=VZTuiIN+csPQAjSK2z9GKeqG7XmZxdX33TngQnhttKs/WIq7jrdiMqhU3iC1W3wk4U
 wp07s7IOIhGR6arrjAUIGMzUZ6lSreEi/tyWQTBn1aqtu6ilRT/KmAWxuLthlDDCO5rW
 GIEeOLTS+Dxf5RcQl8GajwSdJLECwSBQqIiVyBNBoBiHipfmQBm7aYCmplullW4km8k5
 p1U8IMse1z5clz6x4uVahbszUFZXMVi71Jpn4Rk44BAB8pUnaIjE+xCWbdsHemZ+vPyN
 EasE1d1VOJteiUfhBciwtiI4SuqRUbhn51m9FbtQyxGJ/SMyrXKDzSSGKX6Omr99UChE
 0rcg==
X-Gm-Message-State: AOJu0YzSwzpeRbYcrca1M/9B1ykSzrVCh8HzTUYYC3J9Ty2cY/NIEJW0
 +i/hEbmiwuab+xU+JJXExNYuFtacX/LbvZtyL7UU+STukdgUYLcK+dbIPdvWtDVuJUI8HDOTJ6a
 0LhZq+bPI1+1CCdRd/G8+T016rbeADlLhHM89pEZk7Fjdx7U47dqA
X-Gm-Gg: ASbGncslXF4vT/qHoejhecRtmtuvZOhZtTDEV8Em1tiQHW7YkDM/6Z/03qs30GAORXQ
 H8DcbQf6MNmBF04HGushnWidlj2M5eCBgNNizMyKuRH48o2KmPdVHNBhlCUEmRtOfuNmW2Rte6d
 nrzop3XVyZa/TnCTUa9aVwpXvzSUPTz5jfA23P6m6+fDOGYzfjR05eX/CdzDKoU1dD1pHJ7F9sv
 HBGs4ACGnXC3z4iGj1MlnQQfUeuDjHthwr/IOIXYX20D9BFK6HxxhOD2dMCyoqdsJTpiUfmMP+F
 jY8Luw2v0tAecYvYAf83QZoZMWsndGYdJZw0hPlIxA2IG3M=
X-Received: by 2002:a05:600c:4f0b:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43d50a1d187mr184580115e9.23.1742982895639; 
 Wed, 26 Mar 2025 02:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt4+ZolClmpUWDOjmLqn0IICu+069vGFURbqFHgm7i+Gbmh+gwcfJD9QURnrb/16u+lOVnsg==
X-Received: by 2002:a05:600c:4f0b:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43d50a1d187mr184579835e9.23.1742982895184; 
 Wed, 26 Mar 2025 02:54:55 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-49-206.web.vodafone.de.
 [109.43.49.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceafb7sm182148655e9.1.2025.03.26.02.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 02:54:54 -0700 (PDT)
Message-ID: <3e312b77-6683-4d4f-a300-831c2f140e9d@redhat.com>
Date: Wed, 26 Mar 2025 10:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tests/functional: Use the tuxrun kernel for the x86
 replay test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-12-thuth@redhat.com> <Z-PMVMTP-Z5A_FMc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z-PMVMTP-Z5A_FMc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26/03/2025 10.43, Daniel P. Berrangé wrote:
> On Tue, Mar 25, 2025 at 09:00:19PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> This way we can do a full boot in record-replay mode and
>> should get a similar test coverage compared to the old
>> replay test from tests/avocado/replay_linux.py. Thus remove
>> the x86 avocado replay_linux test now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/replay_linux.py          | 46 --------------------------
>>   tests/functional/test_x86_64_replay.py | 43 ++++++++++++++++++------
>>   2 files changed, 33 insertions(+), 56 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
>> diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/test_x86_64_replay.py
>> index 180f23a60c5..27287d452dc 100755
>> --- a/tests/functional/test_x86_64_replay.py
>> +++ b/tests/functional/test_x86_64_replay.py
>> @@ -5,30 +5,53 @@
>>   #
>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>   
>> -from qemu_test import Asset, skipFlakyTest
>> +from subprocess import check_call, DEVNULL
>> +
>> +from qemu_test import Asset, skipFlakyTest, get_qemu_img
>>   from replay_kernel import ReplayKernelBase
>>   
>>   
>>   class X86Replay(ReplayKernelBase):
>>   
>>       ASSET_KERNEL = Asset(
>> -         ('https://archives.fedoraproject.org/pub/archive/fedora/linux'
>> -          '/releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz'),
>> -        '8f237d84712b1b411baf3af2aeaaee10b9aae8e345ec265b87ab3a39639eb143')
>> +        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
>> +        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
>> +
>> +    ASSET_ROOTFS = Asset(
>> +        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
>> +        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
> 
> 
> As a general question, I wonder if we want to add some logic to the
> pre-cache job to clean up old cached files.

Yes, I also asked myself that question already. Being a "cache", there 
should also be a way to evict old files that are not used anymore.
Maybe we could update the timestamp of the assets each time they are used, 
and when doing "make clean", we also check the cache and delete the assets 
with timestamps older than 6 months or so?

  Thomas


