Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B7C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQ2Z-0004VV-3P; Mon, 28 Jul 2025 11:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ2X-0004NT-Ds
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:45:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ2U-0002wL-BF
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:45:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so36590685e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717520; x=1754322320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rY0v7k/dw6unnph0MReYmUnw9SMcCiOlNIJaa1RobAo=;
 b=HF26QGCCpXvTqV2EEC7KGzYsE7M7/ZnHZsP0qwRUgeb6tUBma7rqYyoPrxlR/HMTI/
 Zv/oesD3JrHQsKbg6pt4/29Z5QRp/8+LRBj6f1ohp72F8hmocD80z+EmJsVQ9/RmrJY2
 O750W7HrarnxAitV+O7CSj6bz2w7ZMf1tLpOdftqOd7DF/O+ZcrKBzvLmKHWpxZLkw1w
 yqymS9XmpZLfO92ip8LXdTNIGZIajhIY9+bOdHzwpvuYXHFLnVHYOnB5JmAihPsbuYBI
 tV9WuQpjD2A6q79yzig0yOnVOjo/PHcqYvVLF0jqvMIS/FG0BjWX7rQCoasx+/q+22DU
 T5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717520; x=1754322320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rY0v7k/dw6unnph0MReYmUnw9SMcCiOlNIJaa1RobAo=;
 b=Pc+TgCJe/k1vzPAMZP6Q51/sp6dqf1z76RA9vzUFjqSIns7zfQ+b9Y08FSJkQutYbr
 zEUJcgVbOWmUdTSbkhzD5CKgNLMB0P3BOFtdY5HFQaWZvtQpKvF/7RQoKymGCl12OJjd
 H6oreYOFmkh0OQbRWb7V5I0thPCRuebeePQskm3FvNFBq/rv51MJU1f2fSfGQSuoBfpB
 l+DppmB3MQdVhqfkyP9VE1OTyyoKuTwPhIzDbZDaWuOVPBRGRsiwTkhuQXqNtrZyvH/s
 5D22E+67CjQy1xIzQNpuVzbbnTofpCyWx1YvjN6HHJ90zH4D2MgOP7peh+dVM6qKaTUe
 mR+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg3PQlUn8LN1aA3JGavK2A66frV9ATKxGkqX4MPnIgRAzC76zWvgNs9y/mA8UJeuCoFu9c8mBiJCtJ@nongnu.org
X-Gm-Message-State: AOJu0YwFYmQ12nbZCo6v7UhUlat1WwHmmIObDSsRJn0uCZX+qBX0Un/Q
 1z1BIceMSjNahESZqXteyAvo6sRjvilzIPyZiJ0zLbhVTh++lubtikWzbV7X2mcd1iA=
X-Gm-Gg: ASbGnct2SkwTvVC+r4AGBFx191LA5SBKG4DAZlUeSYkkWpnqN7oUkJ0SyWsq3jy3a54
 nDCukrULYimyhz0I2Ubi9P75D+x3BtABwWMUM0sYku/pChwUIGMyxNgOcoMeYSXFlvkBB7Q8/hN
 eVhG10yfpUvLMr4VLzRPHxdAaLBPWtXaXrkZ0A5VgfDcBNMNVuI8f8B+DODNku9yQMsAIJGjApR
 pBvZUnBaI1U+C/wthdi9MkxG4mhxp22ibwc/g2vRbTtfYSZM4fjpcEwNmgViyeNxPW92vjmiwcm
 casSfq/h6kC+o0vRKdLo5V30VOQqU/huATVzpiKEUCcfcHzA44NG2ASgq7P6/kFGdmQl1tnOtvX
 UlXRiz4EPIAqtll15AscsCKkbxaWiz1cEyIf5wKW4BfyJ8vcd8GgiXOoptPTKdYYJxw==
X-Google-Smtp-Source: AGHT+IEoRaiBuA3mYibzAxYAJXaAh1FnucvAEpsoiGWdoDZpRhoMR4bWi4aUuAs/bbF4Z5nb/HukMA==
X-Received: by 2002:a05:600c:138c:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-458852502eamr39179655e9.33.1753717519872; 
 Mon, 28 Jul 2025 08:45:19 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586f88ce71sm127331125e9.0.2025.07.28.08.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:45:19 -0700 (PDT)
Message-ID: <fc1c2643-ad83-42aa-8b74-fa0a0ec9d46c@linaro.org>
Date: Mon, 28 Jul 2025 17:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: fix use-after-free with dispatch
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 24/7/25 18:11, Pierrick Bouvier wrote:
> A use-after-free bug was reported when booting a Linux kernel during the
> pci setup phase. It's quite hard to reproduce (needs smp, and favored by
> having several pci devices with BAR and specific Linux config, which
> is Debian default one in this case).
> 
> After investigation (see the associated bug ticket), it appears that,
> under specific conditions, we might access a cached AddressSpaceDispatch
> that was reclaimed by RCU thread meanwhile.
> In the Linux boot scenario, during the pci phase, memory region are
> destroyed/recreated, resulting in exposition of the bug.
> 
> The core of the issue is that we cache the dispatch associated to
> current cpu in cpu->cpu_ases[asidx].memory_dispatch. It is updated with
> tcg_commit, which runs asynchronously on a given cpu.
> At some point, we leave the rcu critial section, and the RCU thread
> starts reclaiming it, but tcg_commit is not yet invoked, resulting in
> the use-after-free.
> 
> It's not the first problem around this area, and this patch [1] already
> tried to address it. It did a good job, but it seems that we found a
> specific situation where it's not enough.
> 
> This patch takes a simple approach: remove the cached value creating the
> issue, and make sure we always get the current mapping for address
> space, using address_space_to_dispatch(cpu->cpu_ases[asidx].as).

Very nice.

> It's equivalent to qatomic_rcu_read(&as->current_map)->dispatch;
> This is not really costly, we just need two dereferences,
> including one atomic (rcu) read, which is negligible considering we are
> already on mmu slow path anyway.
> 
> Note that tcg_commit is still needed, as it's taking care of flushing
> TLB, removing previously mapped entries.
> 
> Another solution would be to cache directly values under the dispatch
> (dispatch themselves are not ref counted), keep an active reference on
> associated memory section, and release it when appropriate (tricky).
> Given the time already spent debugging this area now and previously, I
> strongly prefer eliminating the root of the issue, instead of adding
> more complexity for a hypothetical performance gain. RCU is precisely
> used to ensure good performance when reading data, so caching is not as
> beneficial as it might seem IMHO.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/0d58c660689f6da1e3feff8a997014003d928b3b
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3040
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/physmem.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)

Patch queued, thanks!

