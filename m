Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32496C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0gY-0007Q7-Ju; Thu, 22 May 2025 03:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI0gW-0007Px-O5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI0gU-0000sJ-Qd
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747900185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+hKpZWy2HrnfZVddUMW9MUFAIeddvotB56qPw6UQdBg=;
 b=GzzRxP4E8m49XpbEqFCfBxgvPZglh6p+EQnh9ErLXbFqQYp8gyhMXrH0dQnRzE3kLHSlMD
 98YO4YD66bl4a9wuqVk2utjjdGLTFBlO8WqAowTjQ+gKj7jUUVc3NwTQgDpC1pPsBy87vl
 4X5/+SIP0humpULIfya34i8FG307yvA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-5WZMSmJoPZWwIg4Nigy4OA-1; Thu, 22 May 2025 03:49:44 -0400
X-MC-Unique: 5WZMSmJoPZWwIg4Nigy4OA-1
X-Mimecast-MFC-AGG-ID: 5WZMSmJoPZWwIg4Nigy4OA_1747900183
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb23361d73so878226466b.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 00:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747900183; x=1748504983;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hKpZWy2HrnfZVddUMW9MUFAIeddvotB56qPw6UQdBg=;
 b=XU/I9y+msJ0OKexT1S6+Ilwd7NCCR4+Iwdtk6O3d5N+Nmg5hIK5BkGyA1vjubd0fpC
 IWHkLnhiaDmn443Lvp36LH43oBcdDfZkJahIGaSJ3ywpTeEcS1WbOAKG2YzK1fADFzFm
 zkuNf1RNrcbmaNs4R5cwD04kJwGV4VO2rsE1N4Gol/NvFdIwMSvpTeCULk08AVbx5HJU
 Mu+VHMuJTYSAR2OapYCZ8RQ0R2DuCZEExnBbygV7OczW/rAvQBX+h8oo/0XgD3T2hLHC
 T8Fxl4/yn271rTwLv5RV2+ppX2bIkj0tfvmr0ce4ZpFNk0yg3CThYAt3tJ6I51i1x4Iv
 YBYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA65l4a5DyyjySY1eGtPuvmI69VA5vLFxkMAPAd7PgbmEDZM3Pe4bXxL7fLm0O331PdKhgPYuSOq+8@nongnu.org
X-Gm-Message-State: AOJu0YwJJximGnKpidXgz0Z7SR+cn6usEQz6foJ8stQ0atSIBAPLgseQ
 ZLkGI2fM8z/vBsHwN+yPc4G6AeLlcf9V3URbW8TSow0bCdoX9v9jOPT71U++tA2JmrkUUDBLt83
 jkDttpzbpTun5kplp6p10uApmsRtkZzWNzYCnqAwAUo6G5nUjkjaeCx7n
X-Gm-Gg: ASbGncsTWBjP0YinKeT4BvNSEJNXuZlpX/F9++HpRQZd2JFzQWjqCT84HvEp/tB7C1y
 6PUjUNbqNv1CJi8F9FleLiqx+xWJcZuUO3o4o1KXGoQXDG2uVgNkRTVhKqg10HY1T5vcaXrCgPe
 NIYvOHh5YwZgyaeoJZ00MIVSlPe0dMR9Mup2OdoD1JMcbWVlJdCRAGbs/7MPlwqix0QAo+sJC5H
 rwPYZpCz8opO+2O5gvMboGy6Aq8dNEEo1Ayf7rqwKdttzSQzodyjLDbtrjpREwAOgqZsmc2nHna
 sqGPBkeoa2DTa7cQkwF7/ftSrITkw6kojlL21deKLuc=
X-Received: by 2002:a17:907:9603:b0:ad2:2e9d:7517 with SMTP id
 a640c23a62f3a-ad52f32194emr2064545266b.8.1747900182831; 
 Thu, 22 May 2025 00:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdKv/iU0CbhCetZEU7/8N/al/k3MURuJN7b5Ngls1+yjyFUIKCQJ5L69q70EpL1Ksvq3reYw==
X-Received: by 2002:a17:907:9603:b0:ad2:2e9d:7517 with SMTP id
 a640c23a62f3a-ad52f32194emr2064543266b.8.1747900182407; 
 Thu, 22 May 2025 00:49:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4c9e62sm1032333366b.155.2025.05.22.00.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 00:49:41 -0700 (PDT)
Message-ID: <430eaa84-5695-4fc2-90d5-d488a204e999@redhat.com>
Date: Thu, 22 May 2025 09:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/05/2025 15.55, Alexandr Moshkov wrote:
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> anonymous segments:
> 
> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> * if `memlock=on`, then Size, Rss and Locked values must be equal for
> every anon smaps where Rss is not 0;
> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> smaps and anonymous segment with Rss < Size must exists.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
...
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 0000000000..a090e7f9ad
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,107 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that check overcommit memlock options
> +#
> +# Copyright (c) Yandex Technologies LLC, 2025
> +#
> +# Author:
> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> +#
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.

I just noticed: New file need a SPDX identifier nowadays to keep 
scripts/check_patch.pl happy.

Anyway, I now also tested the patch, but for me, it's not working: After 
setting ulimit -l to 2G and running the test, I get:

$ ~/devel/qemu/tests/functional/test_memlock.py
TAP version 13
ok 1 test_memlock.MemlockTest.test_memlock_off
Traceback (most recent call last):
   File "~/devel/qemu/tests/functional/test_memlock.py", line 60, in 
test_memlock_on
     self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError: False is not true

not ok 2 test_memlock.MemlockTest.test_memlock_on
Traceback (most recent call last):
   File "~/devel/qemu/tests/functional/test_memlock.py", line 70, in 
test_memlock_onfault
     self.assertTrue(smap['Rss'] == smap['Locked'])
     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError: False is not true

not ok 3 test_memlock.MemlockTest.test_memlock_onfault

I added two print statements right in front of the asserts to see the 
values, and for the first one it shows (after many successfully comparisons):

line 60: 4 == 4 == 0

And similar for the second one:

line 70: 4 == 0

FWIW, this is on Fedora 41.

Looking at the smaps file, it seems like this comes from a shared library:

7ff16c7c9000-7ff16c7ca000 r--p 00000000 00:2a 29149631 
/usr/lib64/spa-0.2/support/libspa-support.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   0 kB
Pss_Dirty:             0 kB
Shared_Clean:          4 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           0
ProtectionKey:         0

So maybe you've got to ignore the mappings of .so files in your test?

  Thomas


