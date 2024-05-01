Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2679C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ENJ-00065F-CH; Wed, 01 May 2024 14:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2ENI-00064y-6i
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:08:12 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2ENG-0008JP-CU
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:08:11 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51abd9fcbf6so12004466e87.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714586888; x=1715191688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Orkl9zCZhsRNHMqW5MtDCq3yG85rft+nv8mfFixYf4w=;
 b=AC2s026QUUZ4c6Lq73CwIRYNog1GS2KhyWUep9c9+zh8XlpQcXUxTDvW0TvFsL6WvC
 mHuDLWrrpE9PzmRS5DHwooUjhwDU8kLi2b+yZ4WXVgc5+2qeHs77SGyRmAqwLDTRc6uh
 B2qwzwYDS3OpHSVb5NyKOTrqGFqg6+ZT9n4MFfIp7GQEjevCiaRkw/0aMZPIcW4Jjmvh
 2H/GqU7otO1UqQLycxal44QY+vuhLSCL8rGajWftlk9hrX+O8FNywuO7zi0Mer7t9xG4
 HsbJZAg+pP21gzX3joOzj8TSENOJYkUcxywMvqribL6rPNypImtEUq0a1x6z66N/z5/M
 XPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714586888; x=1715191688;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Orkl9zCZhsRNHMqW5MtDCq3yG85rft+nv8mfFixYf4w=;
 b=Fwb/ot+IV3HIvFRRPheDjomiqmjyUw0vLMvOp2ezsR7MMXIKPCeKfYVJwPNrk2lJ5y
 G2f+jwXHG+bdBVaCBkpjO7euetvDwDsmg4RMBc54lUvB4+9StFidM8k0LapJypM9XZ8M
 Krzn4crTi/JShrYrIMq6Krf/53qNJevSPsZI8Yk0qqe5xI14BHc/JZQ6PLBsoBl6wlnl
 r8fCpxIwIE6P5idxp7oZHuMIUJ1servqO14/xuWK58AVA8X3owavPEAdoPABRKczmXF7
 zXV5EQNIuK4u1CowVSwL7AQ34pErc6D27viq36joJ6bTlte2FO3+X3qIbMqhemuEy7rn
 vjcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcthgdzAsKMGQwMzfsyWudPDLaGzfghGx6iLK2vCRmzI5FelYKnO9xfkWeav8EFXO1O8TQuiIlFmlV7l9KCB/+QZi+z8Q=
X-Gm-Message-State: AOJu0YwBqDndqqlD7d7xCANdMprP6o7yBfK3h9OKeuSilNnKI8y8lCH+
 iSPBZFzPFGYMUpqk1g+loKN358pdpURnWvj8yqghkcm6caavggta7/ce0mLICoCq7gt4vAfjrUr
 oJS0=
X-Google-Smtp-Source: AGHT+IGUQhub6ZNNd3Dq3fz4YJIuH17vmwRw1G1UZNzXpi8dvWcYB7DRoZm1PkaH5xhWaNnXcXD2dA==
X-Received: by 2002:a05:6512:1388:b0:51d:9291:6945 with SMTP id
 fc8-20020a056512138800b0051d92916945mr3266952lfb.44.1714586887994; 
 Wed, 01 May 2024 11:08:07 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 l9-20020a17090615c900b00a555be38aaasm16473140ejd.164.2024.05.01.11.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 11:08:07 -0700 (PDT)
Message-ID: <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
Date: Wed, 1 May 2024 20:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x136.google.com
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

W dniu 22.04.2024 o 17:21, Richard Henderson pisze:
>>> For Arm's CPUs they fall into two categories:
>>>   * older ones don't set MT in their MPIDR, and the Aff0
>>>     field is effectively the CPU number
>>>   * newer ones do set MT in their MPIDR, but don't have
>>>     SMT, so their Aff0 is always 0 and their Aff1
>>>     is the CPU number
>>>
>>> Of all the CPUs we model, none of them are the
>>> architecturally-permitted "MT is set, CPU implements
>>> actual SMT, Aff0 indicates the thread in the CPU" type.
>>
>> Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
>> Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
>> model that CPU type yet. But we should probably make
>> sure we don't block ourselves into a corner where that
>> would be awkward -- I'll have a think about this and
>> look at what x86 does with the topology info.
> 
> I'm suggesting that we set things up per -smp, and if the user chooses a 
> -cpu value for which that topology doesn't make sense, we do it anyway 
> and let them keep both pieces.

Aff[0-3] are 8 bit each. On those cpus where they exist.

So "-smp 512" (maximum allowed for sbsa-ref) would need to be split to 2 
clusters by 256 cores or 64 clusters of 8 cores each like it is today so 
it is backward compatible with whatever assumption firmware/OS does.

But if we go for 'newer, better MPIDR_EL1' then maybe it is time to set 
U bit [30] if "-smp X,sockets=Y" where Y > 1? Or when NUMA config with 
multiple cpu nodes are setup.

Also a way to know which AffX fields to check on firmware/OS side would 
be nice. A57/72 use Aff[1-2], N1+ use Aff[0-3]. Sure, it can be checked 
by going through cores, reading then MPIDR_EL1 and if 7:0 has same value 
on all of them then check Aff[1-3], otherwise Aff[1-2].

