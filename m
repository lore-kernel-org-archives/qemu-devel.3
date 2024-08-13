Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C531DC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqHM-0004r8-BO; Tue, 13 Aug 2024 08:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdqGr-0004oj-Jt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdqGp-0006Z5-Uu
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723550697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hm76Ih3Z8sXGuCo0700NTk2e+j4pd96/pDpyBLORIss=;
 b=ZbrrgJtfkUO5Dkkbvcag0DPJJ+Nd5lGeWUSy5uAIJrzcAgk9VRl6PykCNCJV05IZ1gOXmJ
 lB76BrRDesC7lNLkJlxePUUGPv8TvTCrFxxBpBXQ4BQKEBoUXIhn7+QOhUYvQAyWptVwrN
 /Lanb7Q3MZh6vGkhJHtj03kNSefcMzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-KuzpkudMMFia1twKuSIyOQ-1; Tue, 13 Aug 2024 08:04:55 -0400
X-MC-Unique: KuzpkudMMFia1twKuSIyOQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-428207daff2so37086045e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 05:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723550694; x=1724155494;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hm76Ih3Z8sXGuCo0700NTk2e+j4pd96/pDpyBLORIss=;
 b=oRmTy4K7To/KefssQ6uE8rT9Dz4xUMMLTtfDJK+zzTlPxejOUNeWtFb0N8UhN3yHHi
 F+dFiRf1vlMnebLlKoPwVNMpOG2/UgE1NRHDQynf/95XpKOYx365cyjjWMwBWRRBifmT
 UEeWa9A0e3Si08qV7Ks+pyRoXrWmvfJZs6WhXrS+eFohpM1zUjTu5Z4yCKgdQhD+274N
 HPdQkVIO7Ktqi+vKWxMTjxXpch/yYFMq8Juu8ohcgJXhgwFaP0kXYd3LD63nRplhnzjd
 H3pyIOVHseTOfNpigwJjZEaZ5JHzNxJD+nigN21qB/Ge2AP4WbnhqwJyt6TzmcD5z0RN
 o+ew==
X-Gm-Message-State: AOJu0YwXeH1fQ1wc3HrwLB733jx5CupVuNOOT6n4mbMADvL7rJqcT3G0
 FCJxbqemCTUW3FOiwHRMDVxrilcdcz+D8MiDsdYZ9tbFs7AoHegpPlN0aATveGwnxde0EUisMLZ
 G2GCHU9oTOMvQP82PM2SAodRpBkPbT5nDxzeY9y9u1pRObjL/xnqY
X-Received: by 2002:a05:600c:4f0d:b0:426:5cdf:2674 with SMTP id
 5b1f17b1804b1-429d47f5c0dmr26740715e9.4.1723550693949; 
 Tue, 13 Aug 2024 05:04:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbajtwQ2ChoOYWGvnTPktdwhjCqnPtsOshKJSxoerQSh7xvqxGctxUqRikgRa4r3Y5dBT9tA==
X-Received: by 2002:a05:600c:4f0d:b0:426:5cdf:2674 with SMTP id
 5b1f17b1804b1-429d47f5c0dmr26740375e9.4.1723550693351; 
 Tue, 13 Aug 2024 05:04:53 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750e510sm136608945e9.13.2024.08.13.05.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 05:04:52 -0700 (PDT)
Message-ID: <ccbfe942-7a44-4f52-a100-73a852b81cfb@redhat.com>
Date: Tue, 13 Aug 2024 14:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/24] tests/functional: Convert the s390x avocado
 tests into standalone tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-14-berrange@redhat.com>
 <0f30e83a-2048-4dcb-ba41-47920c62e1e1@linaro.org>
 <ZqvIHb15uzWZw6Qt@redhat.com>
 <8756361d-fc46-4a04-bcba-9200d739c404@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8756361d-fc46-4a04-bcba-9200d739c404@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02/08/2024 15.25, Philippe Mathieu-Daudé wrote:
> On 1/8/24 19:38, Daniel P. Berrangé wrote:
>> On Thu, Aug 01, 2024 at 07:11:01PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> These tests use archive.lzma_uncompress() from the Avocado utils,
>>>> so provide a small helper function for this, based on the
>>>> standard lzma module from Python instead.
>>>>
>>>> And while we're at it, replace the MD5 hashes in the topology test
>>>> with proper SHA256 hashes, since MD5 should not be used anymore
>>>> nowadays.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    MAINTAINERS                                   |  4 +-
>>>>    tests/functional/meson.build                  |  6 ++
>>>>    tests/functional/qemu_test/utils.py           | 14 +++
>>>>    .../test_s390x_ccw_virtio.py}                 | 79 ++++++++---------
>>>>    .../test_s390x_topology.py}                   | 86 ++++++++-----------
>>>>    5 files changed, 94 insertions(+), 95 deletions(-)
>>>>    rename tests/{avocado/machine_s390_ccw_virtio.py => 
>>>> functional/test_s390x_ccw_virtio.py} (85%)
>>>>    mode change 100644 => 100755
>>>>    rename tests/{avocado/s390_topology.py => 
>>>> functional/test_s390x_topology.py} (88%)
>>>>    mode change 100644 => 100755
>>>
>>> Conversion LGTM, so:
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Now while testing I'm getting errors, but maybe pre-existing...
>>
>> What host arch / OS are you running tests from ?
>>
>> I got through the full set of testing on Fedora x86_64, so
>> wondering if something differs.
> 
> Linux s390x but I'm not in the KVM group, I need to find
> another place to run these (or ask Alex :P).

Sounds like a pre-existing problem ... I guess the test should check whether 
it can access /dev/kvm before trying to use it...?

  Thomas



