Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2B4F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6Vc-0001jb-DZ; Tue, 24 Feb 2026 23:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6Vb-0001jT-FH
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:28:23 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6VZ-0005tT-Ox
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:28:23 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7985fab9203so11734007b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993700; x=1772598500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6JyrmpKL+6CRQMNx7frWFp4ZmEsFcAZ9B5xmV8QXX14=;
 b=CwlVtYxYLM/n3mAUgmSkrenWj9nfeSJWWsIHiPCQErmNP3nB2twU7BfpswBWqAefzb
 Ol2MsW44AdAJdHNGbEZHGmPEKJEImxBAUYsvAP4mTjWJUOiCieUeOyeCpEs5qom8YNO/
 qxxUjK+/Tp6DnIYxmx8YdjRcb1zz4dKPsEp+UUY3/BJRXX7D4HSiitYofUd2BQ//BFJ/
 yPK0BZz3uqvAXiuKGZp44tNPwW66ITCCv9q9quca5PJogkKeJfNH0c8tC1ZKcbwHeHNp
 8Yp/Uas/n0+bCfmGznDks4R+54PrvBcxfuNI3pPskSLw6LaHMVDM9lXmt5dTkLcdixhw
 40gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993700; x=1772598500;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JyrmpKL+6CRQMNx7frWFp4ZmEsFcAZ9B5xmV8QXX14=;
 b=NPeDL2BnUM+FqCsUWu2lHSUfWYwa9EPzy9U1cufRqIlRkbGbLd5WKb4UDKZmmafgle
 QK6yKqXRAIveGUNFfCakt2OdHIpiQSIBbIekOgMi1ambwd1UJBtFStsVh555v+3dfxgX
 VssQf20BlCXDRVrgGIfmSyLLCnuNyszipwqmuhOagrR7sSq0ZPN1CJIdGiNLQVQ5hc/5
 XPUZMAcVXDfohtfh8YYWqYueodSZE/Ig4xR8t25ZaQpy286qh8tsGbGoEH60bp7eB3XE
 Nx8D+uC1DUcLeQmIKLJCq6TFM8mvokM+dgkYJUNHusSy2Wf9oYgB+AKhyqGkY3i2t79h
 SO4Q==
X-Gm-Message-State: AOJu0YxvrpY61svZm1ZDahfz0R51VrSjIwmRZCcN6+fvx+W9M0OVuNPY
 H6UiFHZkCg2vuj1WONvADJ0aZhAxa/BHARHJT9xR4XDlgtuJ+UgAAzGIsCkBXRKFry1CZIgASqr
 FSulIZlA=
X-Gm-Gg: ATEYQzygVKbruiMfgmW5uwoRDChmT/yParB6F+4N/9ack69t5OY/GUUhueKPXOotae9
 CuRyvLLvaGMdT97RtqNs4Lgmb3hkntoBv3WFjqmywH5lT02QF5niTel92kJ12L6EdIpBmNqEnFj
 wWVlTr1Fi9TZZ1MY7oyncZrb2SHExZqkjdYAJorVTY3cxx0EKCaaL1DnP7Uoy3DsmN6QIzIqVgT
 cV1WlSZ7mUQtE4P4S1qvPquSAVLu6Brprgd2ohi/0h7fZOdmYsu9yW/GAn8JXjMhlq4MNgUjTfX
 l1GbWqDLCtyGkmCITIWtitSpQAoXbCqZ+iNlCQ0w4DzgDusjWQhEWUy9RZkXF2yLFn0HOysEKVm
 4qxgo1fjfZWrR/Ul78SunKTGE+f/tf1DSDzpjaHuqsTtmoG70b91Op14BaSQbqzh+WZWYbUctQe
 nicXhP0aOFGQr8KnsxQKCIzRzRm5U6Os2K63VyfAN9hPOUMpgqkMDHqfdZtsvCWUI=
X-Received: by 2002:a05:690c:6085:b0:798:11ac:d0ac with SMTP id
 00721157ae682-79829043301mr133253867b3.53.1771993700502; 
 Tue, 24 Feb 2026 20:28:20 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79855dea188sm20071797b3.26.2026.02.24.20.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:28:20 -0800 (PST)
Message-ID: <c17e9534-3570-44ac-bcb3-159142b50052@linaro.org>
Date: Wed, 25 Feb 2026 15:28:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] target/arm: Support SME for KVM
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <CAFEAcA9ChSZchdz+17-ee3CzWK6g_BsbEz9_DQ--F+Ek037JLA@mail.gmail.com>
 <9cfa73f6-824a-4c35-8c1a-05d28d58c437@linaro.org>
Content-Language: en-US
In-Reply-To: <9cfa73f6-824a-4c35-8c1a-05d28d58c437@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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

On 2/25/26 15:24, Richard Henderson wrote:
> On 2/25/26 04:08, Peter Maydell wrote:
>> On Mon, 16 Feb 2026 at 03:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> RFC mostly because the kernel support is not yet upsteam.
>>> This is based on
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme- 
>>> v9-0-8be3867cb883@kernel.org/
>>>
>>> Properly testing this will take more time.  I'm not 100%
>>> sure how to confirm that the SME registers have the correct
>>> value across migration.
>>
>> Am I right that patches 2-8 in here:
>>
>>>    target/arm: Remove aarch64 test for kvm
>>>    target/arm: Move kvm_arm_sve_get_vls within kvm.c
>>>    target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
>>>    target/arm: Move kvm test out of cpu_arm_set_sve
>>>    target/arm: Drop kvm_arm_sve_supported
>>>    target/arm: Remove kvm test in arm_set_pmu
>>>    target/arm: Drop kvm_arm_pmu_supported
>>
>> are preparatory cleanups that don't depend on the new
>> linux-headers changes?
>>
>> (also maybe 10 and 11)
> 
> Yes, 2-8,10,11 could all go in now.

Indeed, we may want all of those prior to

https://lore.kernel.org/qemu-devel/20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org/

and the change therein to arm_cpu_sme_finalize.


r~

