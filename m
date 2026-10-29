Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nlbfsEGa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYHi-0008FH-PO; Thu, 29 Oct 2026 18:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMYHe-0008F5-O2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:07:42 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMYHc-00074Z-Tt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:07:42 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-48e9476e26aso25777fac.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793311658; x=1793916458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FGkYbtZS9uBXcqjR58d/dorL/Ba6n5z3JaiLgPTm8No=;
 b=nlbfsEGaSG1qI/q80JUrcyF2RfFUrnllk6BjZ2936WHSR6HFim/C6gN4cfcF19tWy7
 KclKhjBVyVjJaOZMqxNRwuE04PevzmwSSu9F1ahcC1c79VWEE7s+jmPN4MGC0Iw01zc5
 vik/Nd1GYUY9R2Th/KVRjf6/+E+3y1hpmVcB1pFST/QwCdcH8ahbRmsn7q9HxilzBd/3
 tzo8ZfH6KOahv3+RoiY60oGMjrXuetAVAVMO0cI10HwELyHY1huNBUiCHduEnU8o7zKM
 RpDZ75qNa7rygoO40dFVoNJ55j1I0zWQ115MG3/7i6+KB2MpVgryW0aE/75teuEf8h9H
 xRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311658; x=1793916458;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FGkYbtZS9uBXcqjR58d/dorL/Ba6n5z3JaiLgPTm8No=;
 b=RguOn1dfc0EnQq18KsiGvGEIIyXY3SsIb+4Kba5o5NCC4gmacABV/mJ3dmjzFJAc8g
 uccgWkkwlMAP4VUlAxcK1epthpNZY1Z6QeRPLx+Od9zndddAgsboo4ZQPDneXXpu85ff
 SxifHCmgbHeZA3ThXz1RMeFpsSxg5LN5Yt9LqXFy4x8EJ1Il4nn8LbLpW8JkyAHgp921
 HueyMp6Z8fTkbiK9pG1oCwGRHoeYB0GMhYquTGa6zhaBJvjWsEf5DUO09OF8kUimxDt2
 HNC0nHpv5FGCPw0sqapM1Vh48htsCmABPlqZzXK4lt2SCUZ5Zf4N3jLBMdzQWiy9aTan
 ZSpg==
X-Gm-Message-State: AFq9FYJ76TZeHQlGnzWa3umkoYn0Y//IYRI/XgZWhfc+PWC0V4LEEKOD
 6u4Uxm36f2aUPOhtOygesOVOrBMIpeUJ2/wE90b5NIWExTjCx2Y5KP4n8AtYBc9zzYQ=
X-Gm-Gg: AYBFou3mC7FuA8VOj4kj1S3gF2yHjVMtvBXGE4d8Kej9hdM2Ps0aZMhL9AETN0wZfUn
 W07/0QXSCNuQQPJVsqLI+SS5zYdm4lsnF1UjC4LEEDaSHKQHOvwXUj1bWZ9pqhgfIFjfKLqojAQ
 88n+wg79myL7OTNRnIEJCe/BeN93XiE2V1M+sJKU2pKk5kQUvrp22aC9hb5DgPtJG/rqRI+0RF2
 zuYhTx/kT5uC/2q9bGlF+Haiepsu91/yBxufWFvcVpNcSRFvRuzTrt4NseXiRNi8qgvHf6IYcof
 ih+9/JrzMIEgaCCndART/4+JwB5XnmBg46xAniuttRVTQRNPvYOOhZ5Lo194XI6PUv3aXihhuY6
 glXCv/r4a+16k4P82w6hXGaCvOheRygoBaD/uMN5XkTK/wQrtvIcrsfVS6aw53bIHrbZyZ1wQ3p
 xCL6Qp9f/53AHyTlEoHFdhUuem1fpydYygjhCA8IcZc1IyzvUQhN1H9uzzq/rkWfcFpSYybBMrH
 xgQhyuuyEE/v+9QfmUkHV6/rME7dv7cP+ahl3V/Byr+RAismm069Xx71tcjgpO7hEG5VCIyYE/D
 57I0c/ny4AMz3Mg3448uEoDqzQZcGiFH/5T72UXORIZqSEnbSD+ruwNWTnaEnvyiXaY61y2CfiI
 GrYzt5tXKe6g=
X-Received: by 2002:a05:6808:23d0:b0:4d6:90d4:6bc with SMTP id
 5614622812f47-5640ddae7b2mr493109b6e.46.1793311658285; 
 Thu, 29 Oct 2026 15:07:38 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c22:98e:45a8:3c43:1165:d4ba?
 ([2607:fb91:2c22:98e:45a8:3c43:1165:d4ba])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe0fda0sm170699b6e.13.2026.10.29.15.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 15:07:37 -0700 (PDT)
Message-ID: <0fc36ee2-60da-41e1-ae21-41e0ff21b156@linaro.org>
Date: Thu, 29 Oct 2026 17:07:34 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/78] pci, vhost, virtio, iommu, acpi: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <cover.1793207602.git.mst@redhat.com>
 <16d3c4db-6548-4c68-acd3-2eddb59cab5b@linaro.org>
 <20261029142810-mutt-send-email-mst@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029142810-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 13:31, Michael S. Tsirkin wrote:
> On Thu, Oct 29, 2026 at 09:45:59AM -0500, Richard Henderson wrote:
>> On 10/28/26 12:13, Michael S. Tsirkin wrote:
>>> The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:
>>>
>>>     Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>
>>> for you to fetch changes up to c155e7e9e025b60ce17e26a7c382d86f3f9c9fee:
>>>
>>>     virtio-net: add mtu-from-tap property for automatic MTU detection (2026-10-28 13:11:16 -0400)
>>>
>>> ----------------------------------------------------------------
>>> pci, vhost, virtio, iommu, acpi: features, fixes
>>>
>>> multiboot can again load 64 bit images
>>> vdpa-dev now implements guest_notifier_mask/pending
>>> pci bridge can now configure the negotiated bandwidth
>>> tap can now auto-detect host mtu and expose to guest
>>> amd iommu can now attach on non system bus
>>> vhost-user spec now has its own mailing list
>>>
>>> Fixes, cleanups all over the place.
>>
>> New failures:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/17577211343#L867
>> https://gitlab.com/qemu-project/qemu/-/jobs/17576922092#L185
>>
>> Use of sudo in containers where it is not installed
>> (functional-system-centos, functional-system-opensuse).
>>
>>
>> r~
> 
> I dropped the test patch, thanks!
> head at 592bb52d87a1a07172656a91cf5c38f63b5f6c60 now.
Applied, thanks.

r~

