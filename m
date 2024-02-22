Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F34C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 19:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdEPZ-0003br-RZ; Thu, 22 Feb 2024 14:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdEPY-0003bS-86
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:07:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdEPV-00021n-Mc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:07:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d953fa3286so58306065ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 11:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708628828; x=1709233628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xpp4DmdZelqa3/qJH9FOo7tBbfaeZKlhtvUdGDFXTJU=;
 b=AfA9gTU5ILQRb2B3kTe31HSuLRY7yRkSYNVOMqfG4VxwrkG6r3fjsR4lfb1cyruRHw
 NjEeyN7KTswzXqxPpWbiCVItz1W87HOi1PpFOx/P76iXleXaD9dRBeOwsCOMB3mrBYsv
 kdJs6/jUdKD4YBoJ97XlHaGwPjGhZBvDUlDAVLaWclHUZiofiU2X/Id5abHleTJXe+oR
 M/qoYmMZ4f84MFva+n+yxaqv9wdW8It2NMcnELw8/9u4fqTeWuUGJxRHaoW0JB1lYjxF
 bBdmtJn+jlm87wsJj8XZEEnKtNhyvpDeKGHqiI1+CYM4XLdotx5344iTWQufqhj7ic/+
 b2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708628828; x=1709233628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xpp4DmdZelqa3/qJH9FOo7tBbfaeZKlhtvUdGDFXTJU=;
 b=FY+avE9kYiGmiu4lRlcKdsBc+0tdnYyowRXTksE9Ww20uM9cTG2JHJWI5fOWcw3ASL
 35bMqYUf+7+gMN1pREgNQjwPUFgnbB6mniUUhKng/ovyFMtxDtmkdCy4U7cJzLbWEfKh
 RI+8s1BunTtFQHHnqApwjE5KBYGkkZh5dr/ebeRm4hUownor5ioZiUD2lS2RPH/IZwBf
 wGvQWE1AigxuFotHNlQNALHwtvubAOWR180NbQWrd0FQQJAVPu9Ia2nn0WL66ts5+8kg
 RX9tr6FOBuOrc4cJOJokAZVI9bHri+tS96hs913Lx4dI+Lt4MT6wV1QXVQibEbjJ7CRa
 bnmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrZaQsQqRB8/p+RqEeDKyEO4IbklAPEkyiBWylktPgY9+f+E2A/LfJ0+cu40nzsgyrVQmbhhc0VKgRLv5WQ8JWnCbHhe8=
X-Gm-Message-State: AOJu0YxW9IXPW6UnsNv8APD/3+NgzDl2g9aF7HKS/RkTAKMYp8i7fIiS
 t1af4NzpTKSamiSyxjELmEsNiwUwcEzGzyjeykMIqN+/D/YQszI5uxfu2tJDJV0=
X-Google-Smtp-Source: AGHT+IHYPc+1zNyyTsVAXwA+p/shYQGyroZNvCYgD8exWDzjPlr9OZ+6sz29FkFBS4Cg7TRMOFO+ng==
X-Received: by 2002:a17:902:ea0e:b0:1db:eec6:5b9e with SMTP id
 s14-20020a170902ea0e00b001dbeec65b9emr15783481plg.65.1708628827907; 
 Thu, 22 Feb 2024 11:07:07 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h22-20020a170902ac9600b001db5eb52911sm10315032plr.89.2024.02.22.11.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 11:07:07 -0800 (PST)
Message-ID: <1cf87044-8830-49da-92c8-406316260e51@linaro.org>
Date: Thu, 22 Feb 2024 09:07:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3 qemu] tcg/i386: Page tables in MMIO memory fixes
 (CXL)
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/19/24 07:31, Jonathan Cameron wrote:
> v2: Changes documented in patch 3.
>     - I have not addressed Richard's comment on recursive locks as that
>       seems to be a more general issue not specific to this patch set.
> 
> CXL memory is interleaved at granularities as fine as 64 bytes.
> To emulate this each read and write access undergoes address translation
> similar to that used in physical hardware. This is done using
> cfmws_ops for a memory region per CXL Fixed Memory Window (the PA address
> range in the host that is interleaved across host bridges and beyond.
> The OS programs interleaved decoders in the CXL Root Bridges, switch
> upstream ports and the corresponding decoders CXL type 3 devices who
> have to know the Host PA to Device PA mappings).
> 
> Unfortunately this CXL memory may be used as normal memory and anything
> that can end up in RAM can be placed within it. As Linux has become
> more capable of handling this memory we've started to get quite a few
> bug reports for the QEMU support. However terrible the performance is
> people seem to like running actual software stacks on it :(
> 
> This doesn't work for KVM - so for now CXL emulation remains TCG only.
> (unless you are very careful on how it is used!)  I plan to add some
> safety guards at a later date to make it slightly harder for people
> to shoot themselves in the foot + a more limited set of CXL functionality
> that is safe (no interleaving!)
> 
> Previously we had some issues with TCG reading instructions from CXL
> memory but that is now all working. This time the issues are around
> the Page Tables being in the CXL memory + DMA buffers being placed in it.
> 
> The test setup I've been using is simple 2 way interleave via 2 root
> ports below a single CXL root complex.  After configuration in Linux
> these are mapped to their own Numa Node and
> numactl --membind=1 ls
> followed by powering down the machine is sufficient to hit all the bugs
> addressed in this series.
> 
> Thanks to Gregory, Peter and Alex for their help figuring this lot
> out. Note that I've included one patch from Peter without a SoB
> because so far it has only be posted in the discussion thread.
> 
> Whilst thread started back at:
> https://lore.kernel.org/all/CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com/
> The QEMU part is from.
> https://lore.kernel.org/all/20240201130438.00001384@Huawei.com/
> 
> 
> Gregory Price (1):
>    target/i386: Enable page walking from MMIO memory
> 
> Jonathan Cameron (1):
>    tcg: Avoid double lock if page tables happen to be in mmio memory.
> 
> Peter Maydell (1):
>    accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

Thanks.  Queued patches 1 and 3 to tcg-next, and adjusted patch 3 to use BQL_LOCK_GUARD as 
suggested by Alex.


r~


