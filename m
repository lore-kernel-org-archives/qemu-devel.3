Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9421BE6E7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDaN-0002Za-F8; Tue, 03 Feb 2026 05:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDaM-0002XS-4s
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:24:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDaK-0000GT-5h
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:24:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-482f2599980so26306375e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770114279; x=1770719079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cY+rIj4rJ/0OVDhoBXhH5F0+ZmQpVWsBXHp5HVio4bY=;
 b=tdbHPIzGHMCgm/C/L4wiaGFwIej0JPtk1tPMO1DCQPhT4ylHFZ+6pRMc1SzNzuaNab
 duLJZS337hUjubdp+i/ScMD5Ru56693rSjyrW0fkehWGZ9E2SClhia+yxpfR9XtkyXgG
 tHHGK4XHu5/Ar0/nrR0+IX1A/4P4KvEW38xGLWqQ3SUFx51hqEgXsVVtLHnn5JwE1hwV
 XiesamV2mb90SsKD5wNiigxqn6CZGikAHZrsd0nnaqMeSo+kAC24GUD2q1Tew8crK5GD
 RRoccn4OuvE7XBqLXJNwePfGXuRbz9mAaabPjNB9hs/HIl3fx+1rf4wnAHsD4YhCB4NI
 2zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770114279; x=1770719079;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cY+rIj4rJ/0OVDhoBXhH5F0+ZmQpVWsBXHp5HVio4bY=;
 b=hHDYnjyCMtx/pfafQoVCKySqjzbzsmsAM2YYACPIEO86BYBLcxM1OAYe2wh7I26+Z2
 a2Dv9bQE+aVBP579TKSMPDIDmk3C1iskOyRGB1wmO+Uz+2J5cRrAjZKXoggqzeSgIUq3
 actzOg/H5+LUK6ro4DjnnTMWtcf4BJU23Ayr0ww+NUFwsr1hyElzcEmqBZBspF3S7xmq
 cbjy1lRuNprAJQWy3gGEsI9Zrn0a+afZyYVMsn1aHJ/SRlqdKTtExc8jSDDM6TEwucqy
 zA85A1Ppbbh0vUK1yOO1gIatf1Uc9Tp/pyZicJMF5FOCWSTsd2lCGqpGJAKrlljo4RmV
 AAHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBVAVnHiwHKx/Nu7dV2bV9B1nkQxnk+Dd8gSbIuk6Cm9Kwke6rrRtJi9hpZWLgj3x8p2fesUUcz8J2@nongnu.org
X-Gm-Message-State: AOJu0YxsE4SOfNj84FMjdTrsk5SccJBeUKbqJwwUs8mscbS3ONEUs4jS
 A+RtOlwjUJLQKKsMXVYVMGWZVnWHIs5ZL8Xsw6NyANFzfumKDQkoPAmKBbExCP/0jTw=
X-Gm-Gg: AZuq6aI2v84TWnFtjbDmxEY45KR89aOv2/mffGdAgiva3mbmunFUIBjFwJr+bEmiykS
 HsvN2b/utFOyjNwLYCCMIMDSph3ax+6ASkMjs8tPWaHVJmi/vrIzrsxQ/QV6HMBOVFmgkYwzX6N
 KPwAAXvybHExPLYr06gnnUBnDSD9r9pbOG1BsF/7nULZxchVrZ5wScQOCl90Qt5+4PmlIwXK0Gr
 04844idxFHdaDzZFtHEgRev7f7hYkZgR/sHoO9hM3ke6CENE0A7s/rtRkuNRFpGuhjNfG76iz4S
 qsbwiRcPjgA/7whGcT0ERYlh+UsPmFGA2ne9uhYSZ5ry2440wSkUA1H7nPxUeYCGWI6eDN6HdGL
 aTe2whz5XiNhU/7FyLv2+TGPlVhux4RdWh8ZxzLq/wCEc31FzagQW97p3PQbBOyWh5FH/7QD+dR
 kYcl+VqRyeYtfRo0Fi2PMbkgHIbolA73xKj3CIygoxEpI/6rBYXJiwDA==
X-Received: by 2002:a05:600c:c04b:10b0:482:eec4:74c with SMTP id
 5b1f17b1804b1-482eec4094fmr110497305e9.22.1770114278608; 
 Tue, 03 Feb 2026 02:24:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305153842sm56335955e9.10.2026.02.03.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 02:24:38 -0800 (PST)
Message-ID: <8c813812-40c7-43b4-b796-b4ec7003484b@linaro.org>
Date: Tue, 3 Feb 2026 11:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix iotlb_to_section() for different AddressSpace
To: Michael Tokarev <mjt@tls.msk.ru>, Jim Shu <jim.shu@sifive.com>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20260128063907.2066100-1-jim.shu@sifive.com>
 <b813fff4-3ea9-4712-9878-4c81aff6b0a5@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <b813fff4-3ea9-4712-9878-4c81aff6b0a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/2/26 09:05, Michael Tokarev wrote:
> On 1/28/26 09:39, Jim Shu wrote:
>> Current 'iotlb_to_section()' API only finds the sections from CPU's
>> AddressSpace but not other AddressSpaces. However, If address space
>> translation is over IOMMUMemoryRegion, like ARM MPC device, it could
>> return section from other AddressSpaces, which will break
>> 'iotlb_to_section()'.
>>
>> To fix this bug, store complete MemoryRegionSection pointer in
>> CPUTLBEntryFull, and we can directly use section pointer in it w/o need
>> of 'iotlb_to_section()' API.
>>
>> Besides ARM MPC device, the upcoming RISC-V wgChecker [1] and RISC-V 
>> IOPMP [2]
>> devices also require this bugfix.
> 
>  From the description it feels like this patch series should NOT be
> picked up for qemu-stable, since while the bug is here, but it only
> happens in a very specific narrow case, and the fix is rather involved.
> 
> Please let me know if I still should pick this one up for qemu-stable.

No, you are right, the issue this patch fixes isn't yet reachable by
our current code, so not useful for the stable releases.

> P.S.  This is for the first time when I'm asking if a change
>        is *not* for stable :)

:)

