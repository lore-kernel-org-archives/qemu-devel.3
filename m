Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D217CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruRxp-0000MQ-58; Wed, 10 Apr 2024 03:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruRxl-0000M5-Vp
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:01:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruRxj-00007s-Fu
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:01:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so3696421a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712732497; x=1713337297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSMpefpPlVRHtIoz+DVV1AllA/AA5Rg3BEMoRtdPdII=;
 b=ArXE1DL+QOawUYplQhmOXhk5b+PKe+8Pd7Nzcz7SdwRvmcn4ClD4iuhy+zwXK0vw3d
 yUkuEyLtONTT3RIfSTO/16N4/bDomdEzjYjSS4xSLG2oVnFV2jd1TkSAz+RIBOY8vncg
 GhuEQ5eTqbaLInbRw6OkF5v3X1MNQaxcH9XkB8uIsatlP/gwGjC6gqTJlel2X//9IbPH
 qBhgw9A3ciDh9pFtzDhYoCSPXfy8NJwEDvX1nTw2SPkPq2jW4UW2ZGO41kjveBwJB05A
 I9auasdwbea1n8rwLPcDs8nxqmom+2LI5Do80owocJPafo1qgELnZ05JbFajmmToYeOS
 xSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712732497; x=1713337297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSMpefpPlVRHtIoz+DVV1AllA/AA5Rg3BEMoRtdPdII=;
 b=hZJG1yVlSLVFEF0bmSOiCZIF8oeF1IY7BCaF3Sb5MxbbShkvxIzixxG0cV21jfWTZD
 TDF3rojujRg6JqzgEQIeBI/Nqb0VZkD3R98YIt7viWbsaYw+IFFxj5PDhrCrKBUvLsUt
 IosXaVPjiNjrTSOVvNXm3HoDD8yCgYMRGezrnpyZ76LCswghEfhGG9/z0owGgiLiNRTB
 3M3d3VQRXhXDN47gvVbRFHoiSKqtoLpXz9NZOWSBGlZdn4twmrxLoTzJMlWl4YhDKuBM
 3He95WwyqXO8a2frS2hZAQaYuejrDkW/dCFUOzqpyIVT1LCtjrj0QxTPgDsC3v8DyrkB
 EgHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyMyNWg+gnjCDwzuzOWTyqY+b8Ml+bKL1g0itlRQEShRkrqljlHP4ySUm1IpMlWzH+BhbtYg35m3bgWvn6MYPpVaR8Wks=
X-Gm-Message-State: AOJu0YwYNYgljyqRDynVCAzyJSdtcf/shZpZQJ1CHRON//hT1J5t6RVP
 wAizVapZ9+1EkazSNKSmf6Y00xftDnySERHwGT3U0XdQa/hxqB7wYh+mO92Kc/U=
X-Google-Smtp-Source: AGHT+IG63QLYRP+gi9Y8ZSrwkYG52BqH4KQH/hA8o8xwqzOhtj0uUHYr1QXRaejSGDHxu+BHvAutVQ==
X-Received: by 2002:a17:907:9725:b0:a4e:21e0:2e6e with SMTP id
 jg37-20020a170907972500b00a4e21e02e6emr1106362ejc.5.1712732497530; 
 Wed, 10 Apr 2024 00:01:37 -0700 (PDT)
Received: from [192.168.69.100] (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 p26-20020a17090635da00b00a51bd07b525sm5174428ejb.66.2024.04.10.00.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 00:01:37 -0700 (PDT)
Message-ID: <8ae74afa-3eeb-490c-ae6a-73bba02813a6@linaro.org>
Date: Wed, 10 Apr 2024 09:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0?] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>
References: <20240409180450.31815-1-philmd@linaro.org>
 <94c118ab-9cc9-4a9c-931d-7ba2b9acded5@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94c118ab-9cc9-4a9c-931d-7ba2b9acded5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 10/4/24 08:53, Akihiko Odaki wrote:
> On 2024/04/10 3:04, Philippe Mathieu-Daudé wrote:
>> If a fragmented packet size is too short, do not try to
>> calculate its checksum.
>>
>> Reproduced using:
>>
>>    $ cat << EOF | qemu-system-i386 -display none -nodefaults \
>>                                    -machine q35,accel=qtest -m 32M \
>>                                    -device igb,netdev=net0 \
>>                                    -netdev user,id=net0 \
>>                                    -qtest stdio
>>    outl 0xcf8 0x80000810
>>    outl 0xcfc 0xe0000000
>>    outl 0xcf8 0x80000804
>>    outw 0xcfc 0x06
>>    write 0xe0000403 0x1 0x02
>>    writel 0xe0003808 0xffffffff
>>    write 0xe000381a 0x1 0x5b
>>    write 0xe000381b 0x1 0x00
>>    EOF
>>    Assertion failed: (offset == 0), function iov_from_buf_full, file 
>> util/iov.c, line 39.
>>    #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
>>    #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum 
>> qemu/hw/net/net_tx_pkt.c:144:9
>>    #3 0x5575e659f3e1 in igb_setup_tx_offloads 
>> qemu/hw/net/igb_core.c:478:11
>>    #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
>>    #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
>>    #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
>>    #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
>>    #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9
>>
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> No clue this makes sense, but avoids the crash...
>> ---
>>   hw/net/net_tx_pkt.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>> index 2134a18c4c..6a8640157f 100644
>> --- a/hw/net/net_tx_pkt.c
>> +++ b/hw/net/net_tx_pkt.c
>> @@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct 
>> NetTxPkt *pkt)
>>       uint32_t csum = 0;
>>       struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
>> +    if (iov_size(pl_start_frag, pkt->payload_frags) < sizeof(csum)) {
>> +        return false;
>> +    }
>> +
> 
> iov_from_buf() uses 8 as offset, so we should check if the size >= 8 + 
> sizeof(csum).

Indeed. I'll respin a v2.

> However I doubt that it is worth to fix. I think it is fine to remove 
> the assertion (i.e., remove the requirement that the offset specified 
> for iov_from_buf() must be inside iov and instead let the function() 
> return 0 in that case).

update_sctp_checksum() seems sensible enough to be fixed for 9.0.

Reworking iov_from_buf() is for 9.1. I'll let someone else do that.

Thanks for the quick review!

> Regards,
> Akihiko Odaki
> 
>>       if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, 
>> sizeof(csum)) < sizeof(csum)) {
>>           return false;
>>       }


