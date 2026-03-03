Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68415EDA693
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSPD-0008CE-PZ; Tue, 03 Mar 2026 11:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxSPA-00089L-4t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:15:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxSP7-0006GR-FI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:15:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so58831f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772554521; x=1773159321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jv1pzy1zvuJuL/I3jnHWuW4Eq8oBan07Ohy9SOuBJS4=;
 b=XxkJO/ZcuUr2CNbYcGCJpXKNaFuItGlzMzGNcJiWiGd6mRrJfKudVL3bvl66okKwNv
 LllAzxdLp5a7fYM+bV2u0U5C4uRT04ZqlLtZ0yiymzQiICXLk/YR3iYlQU7KHijrAcEI
 1Y8/X8FL08vHRpcksgcs6uJxOb4YUABJ1cajdx0Uza7JVdDgxSnpdLqc/mbQUooobt9B
 wTmbMdB6dYmkNIeYlbWds8wrPk3rJh+gOFuDDjOjBS1YrOt4Pf5rAsZm0a4/rrPZr3Kq
 mhmT6cG+hLJdPCrK7RIeJdxXGfWZLRLOUbP/EKlOUgarQZhhHfwcLnkKI/tFmIDskBOe
 QuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554521; x=1773159321;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jv1pzy1zvuJuL/I3jnHWuW4Eq8oBan07Ohy9SOuBJS4=;
 b=vM7NsjPFotOJIGFNX+6c81Z7hdwBbZLzctz47jaxGggRoCpNY5fIoopadwi+VKBQv/
 6yqznNsvhTBM6qJgHgcs+JJWSpkS8bnuaPTNvDcxl+QdxMViZ6iDNtlZOl2FaYo8+HbH
 gftng1LqNheu8/BDwubVRlxD+ATqHVd3dRR4uzPxzf92MMR17dyT4Ien/6btk9T73IZm
 O2IiMMcdvcP9x6lYQ7N2QAiz+Z81xCWJTh634Ey0P4WpwvFWE8KpH3zpq6/rN9rV3L+T
 xMx0jsRr6swDqyIJEZHgxqFGo8B7V2EYYBpDRKZvVm5neEvfvwwi7li07TTF84XBWntx
 Su6Q==
X-Gm-Message-State: AOJu0Yz1UBKIQw1CBRip9+qSQXJTN1Xz47fCGOgX/s0SDQOcCxo3Rsqg
 7hJgw+2aNm0UgNvlOdRasxENq2n1HlzoDQH7aGOGNtjnokHcEpQzDcqzt4rA4zf4Egw=
X-Gm-Gg: ATEYQzwdHqVu/kBskvtmQvBoLrGFOQWsS3bFRKuXoBYG4KqFPNMih3igZFqbLqHeUvB
 ImlUpFsNWnb2vEdL3l1YdOwv8GIQwVmOeYxozlbS1n6A8OyJmY6MBhWs/ptAhyu0VYKQl6jgoC7
 UJst2RUgSxfRziKKWtEEAW7yx2LI7ItJQISW6Ka7CHlqPuEzz++0+JGciN7In8n3eKhu8rOB66s
 uxRIQteMCZnN5OC+e5q0Cudzzg4P0GC/GdIiOvEorPrGAGPxjl/pf8SLBMF2BG3rjlzyd4HAlhf
 jPpPjXT7t7e0Og2Jn/g/O5PBekMeGoIUTaGcHASoLaCoE7k2Ive/vuJB+3CB3F2T3Qdq6uNlFpj
 B2ledsB8jBt8d0aMGqOwUXPnjRKRptFI9YHz4t2UZW5TjQ9Awo7AR5s68ZYhECB3Y0lKSp1eMix
 AxxmqGlXaHydysb8vQZhEVGYY2XPJqiLT568DXSIYE6PyUNZS4xaVLml3WTS2eWgq/xQ==
X-Received: by 2002:a05:6000:1a8b:b0:439:b486:ba71 with SMTP id
 ffacd0b85a97d-439b486c4cdmr15513818f8f.56.1772554519274; 
 Tue, 03 Mar 2026 08:15:19 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm21229669f8f.35.2026.03.03.08.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 08:15:18 -0800 (PST)
Message-ID: <ef6b34f6-7e72-4aea-9436-c2bda69c2c0e@linaro.org>
Date: Tue, 3 Mar 2026 17:15:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
 <8a2872f3-dfbb-3fed-dd95-3cd474e3ca2b@eik.bme.hu>
 <82dfe6e2-22c1-4df1-9e49-a2c7a2970082@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <82dfe6e2-22c1-4df1-9e49-a2c7a2970082@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/3/26 07:21, Akihiko Odaki wrote:
> On 2026/02/27 7:22, BALATON Zoltan wrote:
>> On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
>>> physmem.c defines 2 stubs which are related to ram-block:
>>> qemu_ram_block_from_host() and qemu_ram_get_fd().
>>> Move them with the other ram-block stubs.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> stubs/physmem.c   | 13 -------------
>>> stubs/ram-block.c | 11 +++++++++++
>>
>> Maybe should be the other way around moving what's in subs/ram-block.c 
>> to stubs/physmem.c considering the the functions these stub out are in 
>> system/physmem.c and there's no system/ram-block.c.

Fine, I'll drop this patch if you think it is not worthwhile.

> 
> But this stubs out functions in "ramblock.h" (though it's not
> "ram-block.h")
> 
> Regards,
> Akihiko Odaki
> 
>>
>> Regards,
>> BALATON Zoltan


