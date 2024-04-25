Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00eh-0007iT-Gf; Thu, 25 Apr 2024 11:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s00eY-0007dF-6R
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:04:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s00eW-00064H-G5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:04:49 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e9e1a52b74so258126a34.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714057486; x=1714662286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faCSBTG7e2G2iAZaX/10h/2e6c2RfDsBfjuTVhn7P5k=;
 b=in10mLlRbp3dVsf79Wnl6zGmRJwaMPVSGZeH1rJNu5OUrWt6vyOsxT5FqN+v2aOGl1
 ehI1WH2kqSz+TkXkvN7VPth0gNocQeSV3rZknIFLxG90DLGpGQVLkgwSdzIS5xurVy6g
 u8pp4Jq9KLcA0t55g11rez/ZuwudJh3Bzm0GbzHMd/W+rRaE+EOkXmBW5vRQNsEhv2XD
 zfHRbbb6VxazsjpO7nkHJrr27LnTbHJtWPHTS/dtKGDrChtvph6/gNNnXw6uRAN0B5dC
 fMCuFA3scLC9JHH8zrUjX6VOwnjs8roG+bdEyD19a70u5S/ZtQ8++khD5GwJCfJpuDts
 YTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714057486; x=1714662286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=faCSBTG7e2G2iAZaX/10h/2e6c2RfDsBfjuTVhn7P5k=;
 b=WDM3MxOF232saV/js5Ghroo2WYJr6XIv58goY0Qaq7YPMzhuQqlqmM7ewf2XdkRu6C
 zwR0p66pinYtj0ooC4CHZ+33njtwXo0xuH+RGXIHpFoO1XnJxPOB7KQdzCSvUREiuwhh
 8J+FjDogd57Z/XjbeeKDwwwcvHI9J5I5xt+Ih3dttOzmO6sbtGrHFW7Q3TgzLt3cFiIA
 OeBR0f2WMcIQoiAhU8TIspkarbuYqHr7nVsvOg0fMFPalI9jemSwNYQxHSrjMyOiCuN4
 5Vol46v1IKUNlZR3+sC0vZnJdYy68qsdv2wIgnKGT6TLQ19USxouPulaOfWZrFCqIXGJ
 2Nuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW8yBG1++LU52gbkcPX4DopagLqwATMK7ISEUTMd5an5A6EmuhoCN0jBHKFeQDLy0Drcyi1kY7vpEMXUaa+GUXl300H+I=
X-Gm-Message-State: AOJu0Yzl/RQ5LPJcn9+JBCbCV6lY7qgCkP8Ed1Og1wKrKKcP4IQIHl64
 SjE4iZmGr1t6o0LzfApbEL3RM2bMl2KeZ2aSjGl6WvXYyWu77Afkd/VYqzyOqGU=
X-Google-Smtp-Source: AGHT+IESMI8HaUiIfZ4mF/eSZRIsak/evxxconFmpWwsHjQIfGqtkD4WVYlgoaOvOw8Nk9htC5MYnA==
X-Received: by 2002:a05:6830:1046:b0:6eb:7c4e:70c1 with SMTP id
 b6-20020a056830104600b006eb7c4e70c1mr6172562otp.37.1714057485816; 
 Thu, 25 Apr 2024 08:04:45 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d?
 ([2607:fb91:1ae9:8637:9f94:1f67:75f4:ea2d])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a0568301c4f00b006edbf653880sm32198otg.54.2024.04.25.08.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:04:45 -0700 (PDT)
Message-ID: <f8aee65f-7cda-46a7-8c13-3d3645f130bf@linaro.org>
Date: Thu, 25 Apr 2024 08:04:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
 <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/24/24 22:11, Thomas Huth wrote:
> On 24/04/2024 18.21, Richard Henderson wrote:
>> On 4/24/24 00:57, Thomas Huth wrote:
>>> The following changes since commit 13b1e9667737132440f4d500c31cb69320c6b15a:
>>>
>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-23 
>>> 17:35:57 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24
>>>
>>> for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:
>>>
>>>    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * Update OpenBSD CI image to 7.5
>>> * Update/remove Ubuntu 20.04 CI jobs
>>> * Update CentOS 8 CI jobs to CentOS 9
>>> * Some clean-ups and improvements to travis.yml
>>> * Minor test fixes
>>> * s390x header clean-ups
>>> * Doc updates
>>
>> This introduces a failure in the migration-compat-x86_64 job:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/6707154868
> 
> It wasn't failing for me:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/6702058896
> 
> And according to the diffstat of my pull request, it's only touching test files, docs, and 
> s390x stuff, so I somehow fail to see how it could influence x86 migration at a first 
> glance. It also looks like the job is running on opensuse, and not on CentOS or Ubuntu, so 
> it should likely not be influenced by the changes in this PR.
> 
> Could you please hit the re-run button of that job? If it then passes, we're likely rather 
> facing an intermitted failure that might have been introduced earlier already...

It did pass when re-run.


r~

