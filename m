Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1897FEC01DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4e3r-00006h-41; Mon, 23 Mar 2026 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4e3f-0008TN-Vb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:07:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4e3e-0005Xb-A7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:06:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso301405e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774267617; x=1774872417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PlDxlCm/MSaqxXseyRetYdrmnuFRpx7MkC1hJIxQ8l0=;
 b=l+ebLcVtHyN8VuSsubB46Fx5a6KGU//qyuQg2cFNpEp/FTMLtnZEBTyWHjfjwRWmBs
 CbwPakA6tzZQ5yGfm9vW8zmTir+p7kTWj5VBhWl8x0u1iXoQEnorDcgaVqRL8JgyrdHt
 ssSLLqE7pEO+uBjyml6XoS4Os6JdYRnDQTu+ntJQxs3v0iCA57ehAP14HFpCuk8ywY/0
 ObWIHV99ijzxFQT/HoLJuBmbyNE42ZGL+xIVqKKjuaLfiJjNlg5mzRb9gHp6pHsShZdi
 Lc4DtrABHVd+pds3u/VTu7dRgl8vTNLhCVjtbALhlpnAi4coP1B/ekzbuKRrL4gZBizd
 xSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774267617; x=1774872417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlDxlCm/MSaqxXseyRetYdrmnuFRpx7MkC1hJIxQ8l0=;
 b=UR0mJ1JpH5zTfPlLSfOOI84jnKp8f25FngBkX5oJ+x8YjoGyPDSMHPMy8yJr9tLJnL
 a/Db9WNRC1U+KOCjY1nZBKte/D4dFIy2RTJliPJmxt8lRINT6kuFY/FxpxCptHOgPSMz
 72NaPxYMmuJQImfWwsOc6wi8eaziqrSlYHFtUKS0Uip51hZ2fxuf/IgTPYTK5QCj98Nr
 9pT/hA9Iu07C5wbas/zQEVnVdZtK1ZwN5nLeZoIcSqn+Xww4VaHe7H4L0E8+3QBBfvAA
 +2+8yXfe1RuyQO6VJUEKVrFX+cVlWppR1TF6mIIqOWdC7Bna7CyzpsATUw+lYvli7MXr
 rArQ==
X-Gm-Message-State: AOJu0YxS0LAG6m2Qawv7RIBDXdPlYIHRDVYmMg6kEnpzlfgWoGP7n3A9
 IVxLn4FqVWDVeM+PaJlInmUN1GH5a/2MvLBpdwEJKh4ARZ54RjHyS3pkp/xJNqXvs/Q=
X-Gm-Gg: ATEYQzzvq/e41IKGEv0Bh9W+IS0b+mabGjSGEZ3lEkKkJoNgz6MEyjVJEqO2FsRcwnV
 LBxZossP/mI0uCrx3QfKhRQ46dOvPSATbgVYpLRe/XMiVaE/qAuhMN5vnyVmg2pox3guiiOdHuZ
 2pA0WoaV9hoUVk2X1l4yhBG7vW9EvUL4lAgHP9rVRJyF4fh82C4czD9Dk41MK5HMMjk3TuW+vTE
 /31J0F+6VqKdSxyXyBsSC/80WW1Ax1xn+0HJUVI+QKSmftfptNLLJIyI73SdyWvmDr6DZx+ylX+
 CRT0lB4/JnKyViaaY7JidToUDIRnPdhaKoAnTrmBdqUUucmU/EX1Rqk3+1Hu6W2ouSdNskUH8Ln
 P/QAv1Z4VulL2G8ukpSKMHyKy4dS7b2S45GORoMUq6YrtTej+TJhA1ILcDY8LJq5H28LAwLQ0hA
 wBzulb1g1RSNELq4Ki5daeqgD4Kylt24uZz509uz0JPv1yQ+hycC8BdE9Q5Uy/qWGZKw==
X-Received: by 2002:a05:600c:8710:b0:486:d76c:fa21 with SMTP id
 5b1f17b1804b1-486fee051a3mr164986095e9.12.1774267616658; 
 Mon, 23 Mar 2026 05:06:56 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7dc4a2sm313103895e9.5.2026.03.23.05.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:06:56 -0700 (PDT)
Message-ID: <26785143-4574-411c-8985-951ae0da0570@linaro.org>
Date: Mon, 23 Mar 2026 13:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] monitor: Correctly display virtual addresses
 while dumping memory
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260323095020.66658-1-philmd@linaro.org>
 <d0a6376c-dcb5-a12a-3b32-8a2c81f32b0e@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d0a6376c-dcb5-a12a-3b32-8a2c81f32b0e@eik.bme.hu>
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

On 23/3/26 12:51, BALATON Zoltan wrote:
> On Mon, 23 Mar 2026, Philippe Mathieu-Daudé wrote:
>> While reworking the address format width in commit 6ad593a75a8 we
>> introduce a bug, leading to addresses being displayed with too many
>> zeroes:
>>
>>  $ qemu-system-ppc -monitor stdio -S
>>  QEMU 10.2.90 monitor - type 'help' for more information
>>  (qemu) x/x 0
>>  0000000000000000000000000000000000000000000000000000000000000000: 
>> 0x00000000
>>  (qemu) x/x 0xfff00000
>>  00000000000000000000000000000000000000000000000000000000fff00000: 
>> 0x60000000
>>
>>  $ qemu-system-ppc64 -monitor stdio -S
>>  QEMU 10.2.90 monitor - type 'help' for more information
>>  (qemu) x/x 0
>>  00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>>
>> Correct the format width to restore the previous behavior:
>>
>>  $ qemu-system-ppc -monitor stdio -S
>>  QEMU 10.2.90 monitor - type 'help' for more information
>>  (qemu) x/x 0
>>  00000000: 0x00000000
>>
>>  $ qemu-system-ppc64 -monitor stdio -S
>>  QEMU 10.2.90 monitor - type 'help' for more information
>>  (qemu) x/x 0
>>  0000000000000000: 0x00000000
>>
>> Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in 
>> memory_dump()")
>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> monitor/hmp-cmds.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index bad034937a9..bc26b39d708 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -537,7 +537,7 @@ static void memory_dump(Monitor *mon, int count, 
>> int format, int wsize,
>>     uint8_t buf[16];
>>     uint64_t v;
>>     CPUState *cs = mon_get_cpu(mon);
>> -    const unsigned int addr_width = is_physical ? 8 : 
>> (target_long_bits() * 2);
>> +    const unsigned int addr_width = is_physical ? 8 : 
>> (target_long_bits() / 4);
> 
> Thanks, that should help, haven't tried yet. But is_physical used 
> HWADDR_FMT_plx before which is "%016" PRIx64 so should that be 16 here 
> to preserve previous behaviour? (Both 8 or 16 seem arbitrary, it should 
> really depend on the physical address width of target but 64 bits for 
> physical seems better as even 32 bit CPUs might have larger phys 
> addresses.)

This patch only fixes the virtual path, restoring the
behavior prior commit 6ad593a75a8.

For physical path previous format indeed used 16 chars,
overkill IMHO, still I neglected to comment I reduced
16 -> 8 in commit 6ad593a75a8. Nobody complained so far
but if you rather I can restore that too, as a "fix".

Long term my plan is to use mr_addr_fmt_width() here
for physical addresses:
https://lore.kernel.org/qemu-devel/20260226220226.20164-8-philmd@linaro.org/

> 
> Regards,
> BALATON Zoltan
> 
>>     const bool big_endian = target_big_endian();
>>
>>     if (!cs && (format == 'i' || !is_physical)) {
>>


