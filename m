Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C6EF99C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxKe-0007QU-VX; Fri, 13 Feb 2026 12:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxKW-0006zD-QG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxKV-0006VC-AX
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48375f10628so5043215e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005106; x=1771609906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpQkjuPts7ed9WbRSc4zzk38/y8PFDy8Mhv4AV9vNvo=;
 b=JDorzx0NmoCnYJDjg20Fukpu8p5cDwmPTK+PUjE39EyrdbBcG/RH16cOV5kAASRpjb
 yaB20RbsweMVLn3pyqTEe1k/p5Fp1CSJcKc2UN1S1G4y/+nprWIBdjC3AtKz1Ixk4NCz
 V9tmbacSe0VFy/JurwtdKHjNArybezOgzsuoGzx1925UK+vBZlR46lww/P+mB0mWZz3Q
 V1Tlofqihj5MbUMX1mrrhVyKFu2cXpJye8uw81N/v9YW1muBHyJYHNrmMDID3rUSv4Zj
 bqJdwARi3UV1fhGtCzvozZmZaRbKzZkhKVJbDSmiGTjoNtjiLG2J01P6eBLV/9PcoxPp
 Fwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005106; x=1771609906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpQkjuPts7ed9WbRSc4zzk38/y8PFDy8Mhv4AV9vNvo=;
 b=ppQ4KTkemUlR7zsV0Z/rGMt0il2xWqbbAhk7vK0oFq1+MeiBUcr/HvolQATt9JvkYn
 Xf2IffG30vAVH5zLiL9AyS0xsH9ESu1Gg4SrK67F0I+KzSQ1OBgW8XO0CULmR1leGEXp
 ZTHWqJOAEY3VzOsf2H2NBjdJIHWAjLfS8aua4zjR9VAPXJJutsSl3sHEHgIZALth3wvx
 sXmX/tuGX6ivIBNFPPuPfJrSpYvtzplu3vfDoA7U9aVEp3hmPdoKomV/ON6NgP3oFrvJ
 A7ubgBo2P/dZQcJQBpveLQREb3ux907L26jIaB51a+jadz9Lu7S2ZXTr0lXqypSYWHyj
 s8+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxi0Ku84Slut/kB+2hOXuF/WVGI/136kr/p1zrZkdRMCYxIGw+LHs+3VMwRcUoHRtrz9AH+JB4KxoD@nongnu.org
X-Gm-Message-State: AOJu0YwoEapFosTC7wZvAtH2PJw4iuPY0I41GOIYBiKsM28xnE+FYO1R
 dPWNfJzWRkeLIYrQWDNCKlPHRpnzUfYaprPSzUtkdvTfKfFF4G1EO9IlA8s6LsLgywY9Q/nQKmp
 mqHft4ng=
X-Gm-Gg: AZuq6aLYbO/xirsUa4obLB6OZd+dHivdrWeQs6ZxftvV9sfZYoO8PjNM/7iXhuIAvDD
 VOcFaLG5ZelxuS6XeonzW5N/u0FQmcTC/PVba5rYjwm2pt5zSOEI/bW8+yZAHZSwBxaUXYqQ26l
 SFQAIaVJBPjDyrRtQd2EJdq7rIhnkvQhBRlxt5om/DFtJfhckxRZxfACPcB6BBkiEXMKgzWXmK0
 vgrdx8YHaQT7zGMraIJxJXtEdl+FLZMOsBIHAHKcpbJpN4Blsvs5Q9z6jS0wf82phbxoP2VJbyO
 qS2Kk6gkuuEAw+tbab6XCGJ+fRf6mVnwJVmiqBRGCGzolml/yi0V+ltSY33T2RUDCYT2Dd6+yb+
 zckKs4KpKWzjKdk2VNaZA3wk+2FQoJikTlne0lp/gZkfch0GFvluRHrOQanVFtSVcfQzVGdKKDL
 spoGpG6RzqfjZJNMz7sjI+cNZct/PZJr1ultWPATB5d6FmfTrhIOqNrIRixHtare0r5uTd0ZsyR
 g4V
X-Received: by 2002:a05:600c:529b:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-483739fc4d0mr51561985e9.3.1771005105833; 
 Fri, 13 Feb 2026 09:51:45 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e15bsm177455695e9.13.2026.02.13.09.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 09:51:45 -0800 (PST)
Message-ID: <3b917551-fcd9-4c5d-b22a-2b938723b8d7@linaro.org>
Date: Fri, 13 Feb 2026 18:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] contrib/plugins/uftrace: add riscv64 support
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-5-pierrick.bouvier@linaro.org>
 <14ee1f39-a8b5-44e4-b9f4-1eb08244c9cc@linaro.org>
 <d0ea25ca-5138-4874-9032-2870054e17fd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d0ea25ca-5138-4874-9032-2870054e17fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/2/26 00:57, Pierrick Bouvier wrote:
> On 2/12/26 12:00 PM, Philippe Mathieu-Daudé wrote:
>> On 10/2/26 21:13, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    docs/about/emulation.rst  | 10 +++--
>>>    contrib/plugins/uftrace.c | 87 +++++++++++++++++++++++++++++++++++ 
>>> ++++
>>>    2 files changed, 94 insertions(+), 3 deletions(-)
>>
>>
>>> +typedef enum {
>>> +    RISCV64_USER,
>>> +    RISCV64_SUPERVISOR,
>>> +    RISCV64_RESERVED,
>>> +    RISCV64_MACHINE,
>>> +    RISCV64_PRIVILEGE_LEVEL_MAX,
>>
>> Dropping the superfluous trailing comma:
>>
> 
> There are many examples in codebase of enum with such style, and no 
> specific direction in docs/devel/style.rst.
> This plugin is deliberately making usage of this for structs and enum 
> definitions, so better to stay coherent.

I mis-interpreted as the MAX number in this enum, not a particular
entry, my bad. All right then!

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> +} Riscv64PrivilegeLevel;
>>
> 
> Regards,
> Pierrick


