Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2866D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUWv-0007Tt-PW; Thu, 29 Jan 2026 11:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlUWr-0007R9-HB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:05:58 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlUWo-0005Ma-E5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:05:56 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so715196f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702750; x=1770307550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYi07XaU1f8hUSEvcxIBU7UsbTXDtt07yN6OycZpo6s=;
 b=ZHPXdgHt/kzq30P67TquuaXN3kguEQosPr7RLftRVFTbFSVuJwQyDlIG4RWFslZ6RM
 5BVd2NxgbXHlldcydmgSui51HXXeFk+AZ5JWtF2XsleA2XiaULTdHGznx4kQDk4gAkTs
 x3OxxgZYISMzKN1WVNc3CCHRnfyQQPt7y4k9D4NPRggMFc9XajWEYVGsZYB3S0j1K/3E
 jvsZJlwsj8/HB5Nfx2p6EuDVJo2JjZiayOK+xsoj6CO+otc7K0pfxADGXREvCyJ5ndI+
 Mnx7sBCAp0bBCKWh81OH0QCBMi8qxGlEERX02ineCB0Yqc7jhcgpnwAm7CaIr+pwf4cP
 UbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702750; x=1770307550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYi07XaU1f8hUSEvcxIBU7UsbTXDtt07yN6OycZpo6s=;
 b=pfs+ugrqKwa1asBwSnayOwrZ6lu+6dR9R07MCcQxB+ZESSCWWov4YaKb3WyhHKW2Ps
 gumI2nBBauZL3/lgar1elcfSZo27eUW7sg1h/ZgFj6KMkVn5lMKDUsD3f/HBDGyg6FR8
 Lebda757xx58T3JZn3G+LksWC/tZMf4BbMkYG7i+BTL4ucRRTPDjePVhWhP9MaXopDK/
 WehtzBBuKTaktgQgfihcHLeoXtpwy8BXVsHW0ogbMG+lTHxYv7f+2FypXaecNFceKkFJ
 XDpf+VeaNTkePuYzIu9qqWTbbDOpWxZRQ79wc2CdqcdVO+4b5eSYwFi/Aq8efgAuvCOH
 PHaQ==
X-Gm-Message-State: AOJu0YxcupFz3cQfY4u688K5s1AYtBYtwn/xbku4Q5PSJyfCArvWU48y
 2UeuQm5GRfZ1xxTZP45olROp2FZzNe89I6oWNexucqtLDczpmaccv/hUAmr+r6eOCac=
X-Gm-Gg: AZuq6aLQIKL2jeF61yxOvjE3m4Q570sKDD10s7y9iQ0jyfRiOMU/nyG0+xTe4tFU8V8
 gJ/rcIOV/liZ2mZ4nnd0V+jlsMeQCXCYWYHDDcWVF15fUGx7Iyot2d9asRpf10lfvamKiqbMX0C
 dFfllOdRP5j4/stbtyEFpxu6WNEMhdLBsnOMFQNJLQ5kBISbMa7IXQCap22i1J55mLElvTGPipG
 FvdasH4HJR2605HGu1kuTiwDe2b3DnF4LgyjXtn6ys9E8Hu7dQN8BjIkbMZVtcPbfOMZgTClLWR
 c4nW4KKK/fpIv44l71Pvtios7wQ6e8Bngf4oPu9mDV2Dz/NLr/9TRt09o1sRwALbR+wtIZhZBqR
 /psjFwuaMWVR1V6DafuAxOyuBYf+mP+bPPlzQ+L+NQugpuVDoiPQXX1lvRB4rb71YX/j7/6drd4
 guK9YsDLSxWF+SdEpEB3TNjtlaPMEfN1AjGNfCEfWwLibBIgganvh9vQ==
X-Received: by 2002:a05:6000:288e:b0:435:953e:5897 with SMTP id
 ffacd0b85a97d-435ea2104a8mr5058714f8f.25.1769702750429; 
 Thu, 29 Jan 2026 08:05:50 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm15636995f8f.12.2026.01.29.08.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 08:05:49 -0800 (PST)
Message-ID: <760b9862-4258-4b3c-ac99-a49593c23f51@linaro.org>
Date: Thu, 29 Jan 2026 17:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] monitor: Truncate target register using ldn_he_p()
 API
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260129133241.35990-1-philmd@linaro.org>
 <20260129133241.35990-8-philmd@linaro.org>
 <fd61c54d-b271-580d-a3d2-98b08f920cf2@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd61c54d-b271-580d-a3d2-98b08f920cf2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 29/1/26 16:06, BALATON Zoltan wrote:
> On Thu, 29 Jan 2026, Philippe Mathieu-Daudé wrote:
>> Rather than truncating with a target_long cast, use the
>> unaligned load/store API.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/monitor/hmp-target.h | 3 ---
>> monitor/hmp-target.c         | 8 +++++---
>> 2 files changed, 5 insertions(+), 6 deletions(-)


>> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
>> index 5738b47bb03..257605a1c96 100644
>> --- a/monitor/hmp-target.c
>> +++ b/monitor/hmp-target.c
>> @@ -23,6 +23,7 @@
>>  */
>>
>> #include "qemu/osdep.h"
>> +#include "qemu/bswap.h"
>> #include "monitor-internal.h"
>> #include "monitor/qdev.h"
>> #include "net/slirp.h"
>> @@ -65,6 +66,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
>>  */
>> int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
>> {
>> +    const unsigned length = target_long_bits() / 8;
>>     const MonitorDef *md = target_monitor_defs();
>>     CPUState *cs = mon_get_cpu(mon);
>>     uint64_t tmp = 0;
>> @@ -83,11 +85,11 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, 
>> const char *name)
>>                 void *ptr = (uint8_t *)env + md->offset;
>>
>>                 switch(md->type) {
>> -                case MD_U32:
>> +                case MD_I32:
> 
> Why is this changed? Doesn't seem to be realted to what the commit 
> message says.

Good catch! This is due to a broken rebase I suppose. The change is
explained in patch #5 "monitor: Have MonitorDef::get_value() return
an unsigned type".

I'll clean that up and respin.

