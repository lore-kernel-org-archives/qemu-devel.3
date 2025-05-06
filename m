Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD33C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCK0a-0002ga-Cr; Tue, 06 May 2025 11:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uCK0Y-0002fc-F7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uCK0W-0000BJ-KM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746544495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S9Rx5fjuXqU6W7L9hiqlW3zm/KvXt/S4tAkzaORUBjg=;
 b=fzVfC7/A2IUraGXWUbfexZfAdnvDDIWylHJphr03FvqbMsF/b8IWmFxheDKg31hXXKslAR
 Z/gZe991eehzVfiaOHovNHkh/bsa5MwMBnHvj4mDMwre8KDAgKn+XXak84vzr+6cF3jTk+
 i3clCWXo4wKnihqGQJrjNsWFG3s3XTk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-NIx-ICVdN9eb3iMZb4Cgog-1; Tue, 06 May 2025 11:14:53 -0400
X-MC-Unique: NIx-ICVdN9eb3iMZb4Cgog-1
X-Mimecast-MFC-AGG-ID: NIx-ICVdN9eb3iMZb4Cgog_1746544493
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso1552240f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746544492; x=1747149292;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9Rx5fjuXqU6W7L9hiqlW3zm/KvXt/S4tAkzaORUBjg=;
 b=SwPvMoHzmtjM77kspdnr8tQXYIqRjLWgTKwlQEjfTJ7zD7ABB6wOvcGzk32KmXERAR
 OK8NSUOJd9fe+yfgj++K8PM1h2hgkGZ8bZ8/6lqNS40+wZWzme72M3PFhxGP+Zc3P/vF
 sEbYwNx8jWDyDfHQDwA+TieWm5nRtVAiByMD33WEF5Qw889F19uNum3WOAixe8lAd/LX
 trqCz8DTJd1JpgQX806kmTafqCZU2RiciQh4TBw9mVeLbmcKon5brI2XrAQ5lYnb7gpc
 J/2kLoAsRG2XuxpvZF5OMlfIYvTEW3JYWcK++2bto0VRQhgSW3UG39WatUgFm6a6/KNk
 DA9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpiCVYRLeQPmo4R8cU/WH8g2SBd7ipqP7uXAJVopnktzcuADshCahM5bb+SB2tNNIdUx75ALPfJ7QM@nongnu.org
X-Gm-Message-State: AOJu0YwpcuXPk+tiwCBNigESsr75f9dAYeAlx4/ty/GZqboL19SUiQJg
 zDuiq69SFMcBPgB4xaChpfpY/cOv++WxUroR7ycGznsvZVonAIJkqUJvw2AxEw+mCwEyttxijmN
 LJKE/XM4k+5rXQfuqkl6K9unTHwq5mdY/p71B8mmOhx0Ze6ogcTQZ
X-Gm-Gg: ASbGncvS2/GuTSZJtcHU5hdfB8eLf1FVmq4h0J+EejZeV1yhXi8oag+BP/CZ8HCRWrn
 tXp8zzZ0+/PWGJP5aM5Mr3Pwv9ZqVK+NtIJVF0zxbBCwT/c1MjfcWwuNgv8OOAlvWzyM5+RLWMI
 8XsCiXE7Gtma0hdfEW4OqQ+HJm4dfiY/2X7Gti1VylOIcSky88wilWzdC5NrC7uOj2A9ZQnStcO
 iFKFh3C88bF6Uyav0ttedco9e8Ii3L/6aJ3ekztCzGhwhhWV7ExG8Q4UxaMTD2e3YmyUDyTfIvL
 qb+4FN20h4KiniFapEm1W3UItdNFoUMVwQ4/sjwqWzo23CdeDQ==
X-Received: by 2002:a05:6000:1acd:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-3a09fd7dbb0mr9604244f8f.31.1746544492497; 
 Tue, 06 May 2025 08:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUvD07ZX9eC60atHFC+G6qSYLmuyskPjrRWkkvw3PgMvHrzcIVPIskcgGXw4aVEasDaOOmTA==
X-Received: by 2002:a05:6000:1acd:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-3a09fd7dbb0mr9604220f8f.31.1746544492090; 
 Tue, 06 May 2025 08:14:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7bb3sm14173442f8f.51.2025.05.06.08.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 08:14:51 -0700 (PDT)
Message-ID: <2476d134-e342-4c2c-84ae-4d5972c30a94@redhat.com>
Date: Tue, 6 May 2025 17:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
 <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On 5/6/25 16:22, Peter Maydell wrote:
> On Mon, 5 May 2025 at 10:12, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> From: Steven Lee <steven_lee@aspeedtech.com>
>>
>> Introduce a new test suite for ast2700fc machine.
>> Rename the original test_aarch64_aspeed.py to
>> test_aarch64_aspeed_ast2700.py.
>>
>> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
>> Change-Id: I3855f55c9f6e5cca1270c179445f549f8d81f36c
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/20250505030618.3612042-1-steven_lee@aspeedtech.com
>> [ clg: Added new tests in meson.build ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Hi; this new test seems to trigger an error in a clang-sanitizer
> build; would you mind having a look?

yes. I can reproduce. I will check next week.

Thanks,

C.




> 
>   Output: qemu-system-aarch64: warning: hub port hub0port0 has no peer
> qemu-system-aarch64: warning: hub 0 with no nics
> qemu-system-aarch64: warning: netdev hub0port0 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.0 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.1 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.2 has no peer
> qemu-system-aarch64: warning: requested NIC (#net038, model
> unspecified) was not created (not supported by this machine?)
> ../../system/memory.c:2798:27: runtime error: null pointer passed as
> argument 2, which is declared to never be null
> /usr/include/stdlib.h:962:6: note: nonnull attribute specified here
>      #0 0x617e4121b113 in flatview_lookup
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2798:12
>      #1 0x617e4121b113 in memory_region_find_rcu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2833:10
>      #2 0x617e4121a5a9 in memory_region_find
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2860:11
>      #3 0x617e411c21ea in rom_check_and_register_reset
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/loader.c:1317:19
>      #4 0x617e411d5ec7 in qdev_machine_creation_done
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/machine.c:1756:9
>      #5 0x617e403d4877 in qemu_machine_creation_done
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:2782:5
>      #6 0x617e403d4877 in qmp_x_exit_preconfig
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:2810:10
>      #7 0x617e403d9a3c in qemu_init
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:3844:9
>      #8 0x617e41301126 in main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/main.c:71:5
>      #9 0x7faf8202a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #10 0x7faf8202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>      #11 0x617e3f920654 in _start
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aarch64+0x161d654)
> (BuildId: f3f8c2ca821e695937a615bee293c4a5a336a6bd)
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../system/memory.c:2798:27
> 
> 
> thanks
> -- PMM
> 


