Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29571C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiDf-0007E8-UD; Wed, 04 Jun 2025 03:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiDc-0007Da-RT
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:07:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiDa-000637-Bt
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:07:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso64781275e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749020840; x=1749625640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rynHoh/ptHQn79UIbvWjfxdaG778iHkl/vBKiHg1RYw=;
 b=A+tc90QrxWR3E/aHxReWBaPucWHaklx6C1qkFsltnyGDd7diw+HoL8wrTufml5Pk/0
 twwJb1MgBC5u013157CmCzYMDo6925KCiA8/y8L6yLP3fx30/HDZnFOtf7MjlFaGmkwg
 loI3Mzh7PFjkYuVGWh9HYXWmj8miVopwxn9SgtHQgfLEcCtyEGMPUGgjTwShCaFDVGct
 VfgfjAUBxa8S2jHKrsqzx9occt6bk8trSOvWoSybzp76fl03Ub2DrTGLQr9Qv9GqQ2m/
 tsZX5n451/agx3PUtNb7O2jUUKqBHeFDyTsJKyXsWjzrU4pt6vOEiMZ0WmtsH9PNj7lI
 Bp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020840; x=1749625640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rynHoh/ptHQn79UIbvWjfxdaG778iHkl/vBKiHg1RYw=;
 b=E6F+Sz6i8F9lFpwIG6QXJQi0a/oYXu1F79QElJBn1Pra9T3h7tslcZZHWxdvpRP2rX
 BpkIh4L3M/X69C950hYfNrm4XtCBEfskzZWL4B8HBMWBhW6kEormHZzAeERabO0n7Z/I
 GCdv6vz3Lty0OsAJGT7T0b9F6XutXcn9RrDuRSiPoF/mM+piOx0yJzZOHxjFYDUWUPBB
 o/y6WDqlEk7OKwyFYvPtkmoKvYlGAf4/la7KfFlfRiwbaMEi4V8hIseB2kHD6A7sAL3L
 BVwgJ86pIDDVHNnk8ggOmr8xFmrAUO6zyrtBaAxc4qDpEQdo9flWvxwcy2rpeOiXCwtq
 tHpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOlD6FmKXivfuendTwZx+wEAHPmB0DasuLbCu5hT7oDGShanXluYygCbWP2YG8upfZBbGI4EI8CFds@nongnu.org
X-Gm-Message-State: AOJu0YxCtupGPMjoJck8JhuNavbQ4BCJNTaRAcRcnEQ7JotyNkeyQnMK
 CrCI+oxlg67jOxxYniQUlLqq0YFBGaWhFgxGN5ToM/bxpenZq62OpsWcPC+oDuDCPHk=
X-Gm-Gg: ASbGncsZvQD+81fpVwqBdjNarrNK8yMD3Q1cyLk/+2cedCicpzdJEndKEJXvp1M90kE
 kGyuHsq8xQlGY1MFoPeQi9Gcg7iAtwpzk+GbROyXwFI4jTdMpTlM2Xq1WhCDjrHGM6oU9EKE7TL
 rlS4/iyDu4VC5Xmj9DsGCibi4myoW+vrG6FSeYq3CnqzkMxDdukIR7nkWEfOVDN8ZxGBiB8OGy8
 ugDDJaCZg5iAVIOmuU20osxQm9+qiA4gCiYIFm5OjC7cWB4QnNOUhu3TgAJyJyoGRe9PFJway+1
 rNqR35bIbYWs/6bTjL0c9TvNvnQJAN3P81ku7c3hS8l4ehIWpw2ZrgQKmPxFjbgtXmqpuN+bTj3
 rrlKvk58l9mlKjADc6V8=
X-Google-Smtp-Source: AGHT+IEaOQMBwhucriFQuSYHiyVKAzIs4Y+2yBVrARU//lSRgdyMwTjXS6QjfyZ4yqCU+ZcONMeUzA==
X-Received: by 2002:a05:6000:290b:b0:3a4:f7df:baf5 with SMTP id
 ffacd0b85a97d-3a51d67f465mr1045724f8f.0.1749020839829; 
 Wed, 04 Jun 2025 00:07:19 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009f9d6sm20540149f8f.84.2025.06.04.00.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:07:19 -0700 (PDT)
Message-ID: <0c0545dc-6ce1-4580-9d21-6f31d39e0125@linaro.org>
Date: Wed, 4 Jun 2025 09:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/i386/pc: Remove deprecated 2.10, 2.11 and 2.12 PC
 machines
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250501223522.99772-1-philmd@linaro.org>
 <4ac8c8b0-700b-4fac-ae4c-6531fc6b682e@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4ac8c8b0-700b-4fac-ae4c-6531fc6b682e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/6/25 03:30, Xiaoyao Li wrote:
> On 5/2/2025 6:35 AM, Philippe Mathieu-Daudé wrote:
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series includes the 2.10 to 2.12 machines removal.
> 
> For this series,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

> Besides, please add more patches to remove hw_compat_2_{10,11,12}

Are you asking for this series which was posted more than one month ago?
https://lore.kernel.org/qemu-devel/20250501230129.2596-1-philmd@linaro.org/

> 
>> Philippe Mathieu-Daudé (8):
>>    hw/i386/pc: Remove deprecated pc-q35-2.10 and pc-i440fx-2.10 machines
>>    hw/i386/pc: Remove pc_compat_2_10[] array
>>    hw/pci-host/i440fx: Remove I440FXState::pci_hole64_fix field
>>    hw/pci-host/q35: Remove Q35PCIHost::pci_hole64_fix field
>>    hw/i386/pc: Remove deprecated pc-q35-2.11 and pc-i440fx-2.11 machines
>>    hw/i386/pc: Remove pc_compat_2_11[] array
>>    hw/i386/pc: Remove deprecated pc-q35-2.12 and pc-i440fx-2.12 machines
>>    hw/i386/pc: Remove pc_compat_2_12[] array


