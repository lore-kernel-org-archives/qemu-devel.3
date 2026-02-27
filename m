Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104DCFEFB6D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 16:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw0ZU-0007g4-LM; Fri, 27 Feb 2026 11:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw0ZT-0007fv-OL
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:20:07 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw0ZR-000082-RE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:20:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48370174e18so12995275e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772209204; x=1772814004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TuuFK+dd0dPi17DwheH5acKMCsHWPLrrxxz/I/oW17s=;
 b=b9NHbD4RUwbqqgEUHGt3oJUS8f6XudklZigdlgUa8HkrnUoX1KX4mRWDaWJPW1r1B/
 BbHn3H95gNEv+t34koZcWl8E//y/0SX1AFk5qeyqPP/OJZgZR1e3nRTvr42uDvwTxrdu
 jBko27ob1i+CVfaItDQdEhE901qoeGwbUkZCBmnfrj15trbIxfqmLI76Oa4ToTWPeEZf
 oGpT4EjHNuTA96iwUy+0RYGr1cg7JIJuF+D1UR4l8BwTgWko0yvdrNXnETNFdnXKGcUl
 LfoFwiLOu0mvRJbSbEmvuvqfOJnBUfv1NL0PAHLIzgah6wVuwL0d8FiEdoJue3t+Yogl
 /cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772209204; x=1772814004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TuuFK+dd0dPi17DwheH5acKMCsHWPLrrxxz/I/oW17s=;
 b=WNwICbokduQ//V9WJbwCXI6JiqKPXs9+mI2gaYc9M+vaTevW2BBFjpdj4btLhA+G8b
 FuwEen+pFZbeE3HvFYr+HQUSZ2Zq0pMLyeQ2yViCPQsOioiuR05u7PHHRiMcXkM72XWW
 6fk8JO/eWyR+5NEvTx6bt+mYyf0QzWjkw5Zz7kkIgxgukaoyxpjUE1VpyVcSTjetw9tx
 AC4TWFdAXXkBNimHg42dXmXB+4wkLnKQjaokkr3APw+FIIJVv9pNiTCuQv3Rl4+dtwfD
 FSe4B6Hu1wGgJqOv3p0zSu1g9tUDSmHi9Ax7xmTYjFt2gkHAwLWadfsYs9M8Tg/dmDL4
 tOWA==
X-Gm-Message-State: AOJu0YxKccydJnqnEu2azzMfNcH/JCXKAAX6CRp8xcK/ROsHJi5WTDj5
 l6zk9SEf7s9m/6l8jj1iBk3XJEsxHgysIl1nPGJTurqKEFPqLP4qckfBzrb3u4ZOo6Q=
X-Gm-Gg: ATEYQzxTnQeLjDvy4Mfan3iWN2SwCRBJYfdogFogLabm0eYECGvZOe6B+fzd0V2Drj4
 tPeNGsN7Gl2iJ3jv90OxdLIz14f2nBp/Hu1eRgk5DZkHbIWX+JC2KrnktEkR2110ZoBBnABOSCX
 N6E+ROT0RvuMH1HyG7Gl1ipxS19q5Y+dPa1u1zujHloGoM9DXSaZxF6Joe2RSxIOYiAuBfMKFcQ
 cvayQXcr1FSL11RuWNGp0ZkH/4kHIyX/G0CQCmRdtt0obKvBEBVS3GaNt4UvxOy6IkIi1v9aR0h
 S2Kz4ub/9SgzJSuc086uepICuMldaLGmIhIGcBTbREZlUoHT3rTbimdtvJVW897xK1qHweLXa5G
 z3o64hChPeolB18Wg6/mJqp4N+ldTx9fSZJdEVvcPxTECA0uXVggeuzbepDrV85SycEJ+TomPAC
 RfgTJirBqQRsr8nu7t3+vd5UhnqCHnmWa2DVQGmbG4pHnYJCclfaVW4mtapie9Ditr/Q==
X-Received: by 2002:a05:600c:5308:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-483c9bde0f0mr54697105e9.35.1772209204000; 
 Fri, 27 Feb 2026 08:20:04 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a25dsm7654200f8f.21.2026.02.27.08.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 08:20:03 -0800 (PST)
Message-ID: <d5c13592-a028-43e5-b3af-7fdc0a3533b1@linaro.org>
Date: Fri, 27 Feb 2026 17:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org>
 <a3e183e3-4196-f3d0-f221-d93652e7d3df@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a3e183e3-4196-f3d0-f221-d93652e7d3df@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Zoltan,

On 26/2/26 23:35, BALATON Zoltan wrote:
> On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
>> Use the size of a MR / AS to decide how many address chars
>> need to be used.
>>
>> For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
>> to run 'info mtree' displays before:
>>
>>  address-space: I/O
>>    0000000000000000-000000000000ffff (prio 0, i/o): io
>>        0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
>>        0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
>>        0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
>>        0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
>>        0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
>>        0000000000000060-000000000000007f (prio 0, i/o): sm-tco
>>      0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>>      0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>>      0000000000000020-0000000000000021 (prio 0, i/o): pic
>>      0000000000000040-0000000000000043 (prio 0, i/o): pit
>>      ...
>>  memory-region: pc.ram
>>    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
>>  memory-region: pc.bios
>>    00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>  memory-region: pci
>>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios 
>> @pc.bios 0000000000020000-000000000003ffff
>>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>  ...
>>
>> and after:
>>
>>  address-space: I/O
>>    0000-ffff (prio 0, container): io
>>        0000-0003 (prio 0, i/o): acpi-evt
>>        0004-0005 (prio 0, i/o): acpi-cnt
>>        0008-000b (prio 0, i/o): acpi-tmr
>>        0020-002f (prio 0, i/o): acpi-gpe0
>>        0030-0037 (prio 0, i/o): acpi-smi
>>        0060-007f (prio 0, i/o): sm-tco
>>      0000-0007 (prio 0, i/o): dma-chan
>>      0008-000f (prio 0, i/o): dma-cont
>>      0020-0021 (prio 0, i/o): pic
>>      0040-0043 (prio 0, i/o): pit
>>      ...
>>  memory-region: pc.ram
>>    00000000-07ffffff (prio 0, ram): pc.ram
>>  memory-region: pc.bios
>>    fffc0000-ffffffff (prio 0, rom): pc.bios
>>  memory-region: pci
>>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios 
>> @pc.bios 0000000000020000-000000000003ffff
>>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>  ...
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> system/memory.c | 27 +++++++++++++++++++++++----
>> 1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 4d276307da5..abcbdaadcd7 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) 
>> MemoryRegionListHead;
>>
>> #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>>                            int128_sub((size), int128_one())) : 0)
>> -#define MR_ADDR_WIDTH   16
>> +
>> +static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
>> +{
>> +    const unsigned int bits = 127 - clz128(mr->size);
>> +    unsigned int width;
>> +
>> +    if (bits <= 8) {
>> +        width = 2;
>> +    } else if (bits <= 16) {
>> +        width = 4;
>> +    } else if (bits <= 32) {
>> +        width = 8;
>> +    } else if (bits <= 64) {
>> +        width = 16;
>> +    } else {
>> +        width = 20;
> 
> Why 20? HWADDR_FMT_plx this seems to replace is "%016" PRIx64

HWADDR_FMT_plx predates support for int128_t and 128-bit wide
addresses. Using 20 chars is sufficient to align our current
uses.

I'll precise that in the patch description.

Regards,

Phil.

> 
> Regards,
> BALATON Zoltan


