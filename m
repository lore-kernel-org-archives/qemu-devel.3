Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2046ACD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcnJ-0002OU-FP; Mon, 08 Jun 2026 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWcdW-0000di-GU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:15:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWcdU-0003KO-7V
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:15:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFSHq3596150
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QvLGwqWiWaJY04FM5UOTzAyLrBtbm0YHwGMaJMLzEiU=; b=HcfVqhZJhpj3iB7Q
 2P9KUcurCpxdYYLuhTyrYqKSTynIlxxxLlxmxiyv1d7mlEnfqmBmD9s9SRLApbj0
 Sn0ZKrhzaj7mrHsWURvr4Ka/klK5ytbQY/X9gWjNjsXb+GNCBhr2hpUyG8hKTLWv
 mWaXGDZmg3rtJp3/g8+/Gc7hzY9SGWn4dKfyeSfDEKUDstEcxSMcRpA7KhSmtmaw
 /638LW9+KlJ8Hu9MJKxYPyomIUNsVrNAbKd+xdKfMsqBKDpa+5bGqGhmtAkFkvOE
 Gq5fBR88lzIb3e4qNZ5H67wv7YHiz7ebuYDOPuLT07PRy5CsOMuGWWUqpN4jS3U+
 trsxvA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj9g7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:15:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-59eba8fe530so7024698e0c.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780935333; x=1781540133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QvLGwqWiWaJY04FM5UOTzAyLrBtbm0YHwGMaJMLzEiU=;
 b=UNHPkZfQk1lSFR+PZFC+ySaFkjsWnAbfKb8QzAXPY8CCvIoRXXzmRxntDiM51NtFVP
 npNl/doBS/B4x7WHFnnPPnPf3YjHgngtXox3RPvOXCoZc94XBklCUPIu7DHgaCIcLq5+
 yT1kCVVNEgI3/4Iegil2Tw5CdJfAViBLUcsqT7L7elFqw1oiMhatvX+YADVxwuTA9klw
 GLXTW/sblpt2KNOmwvTZNkqUSPgZJ7qOj/83aQtiLH+mnkewMqk9wY2E/TgWsTjVAVyX
 4YVhebQNOjRxJU2ItSWU3F20Tw7lhIGRQuPTvu4h35+qjlf6rnSyNZ5TLJt6I2ak/yVx
 VTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780935333; x=1781540133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QvLGwqWiWaJY04FM5UOTzAyLrBtbm0YHwGMaJMLzEiU=;
 b=lmlY5JmOGmO0wYIAxJ1ekE+NGkfaQ8xHSq0/DHMz4h6vmL0LS6fwje7CjWW5Eswjfo
 E0HsLyUfAOiTwJdGlybwclP0KEqdc/UdBeF3ELkVmGJeQ4n8O8+PBgHo9FZXFQWpTUjC
 hOZE372mJbY1x8LlHPFQ4dqi4yaIQNEs0nV1SYLXqOClm7+Aoye8Dyro7hD+DXbZ9Ijp
 P6LEBfig7Wh2Sz1UfWCDnVoMQqwXJWanJEQZraMjRAKBFUtu5XUhVS3dLzbdu7pl36j4
 36bWB7Bzv0NjZULvb5aoXZ0Ao0KeazOxNwaJ8dI3eGWnbjlqFSAGz/AR1mwCwM4VnjjK
 HQ3w==
X-Gm-Message-State: AOJu0Yy++OuC2CHlgUK4ovoiMOfy1UchsVs/mc4Cfp1Cbnz0V2Q+aPAU
 /ekqQ023BMh+I9bXMgUXmZ3OWpL0BCjMgKqzQdjt5OsQtPmaraNj7BFLHhHys0Hf1g9QYXFlkLT
 eHCQa2ZZgdoIFvHjLZOL9WrWvgyCPNHYoOmeUm+wRCAFMWDW+wac4OXBM2A==
X-Gm-Gg: Acq92OFVpPuAKsgZaR1Dz0BQj8L2QkkUIYsJtoAoQWwnNDf6jhazc2ZJZL5sVDIha5E
 WChuXFu2YSfds9s399wrhu5rYrXGxw63Ar9TalIqi3VQd4j4fu913MESX+KcYQzJMwME3Afshdo
 Zqtcfq+krFKat2mhx9aimOxVZcqAXha8/NvbC1QX4OUzJ9bD+qspXFrkw02ketGkZqk2EYRGkdx
 EDLgErAdLD7UYiGL9G5/TG6EPQ8M77UvmZhKdwhmIliBFd8xacXPGVNpd7HN71VKbtSO4I64Uhb
 j9lIKK9Q42cFWc+ozrh1MCd7/IHWLstjHBS6wwDH+SOn6WO5jYhAxPwOXKqe9p68lGUnB+NMEVO
 RIq+PmWQvN7u6dj103ot9cLJ+kouDHZQTkXf6V0PzQ1STnFZQhdY0TvpkJcHipA==
X-Received: by 2002:a05:6122:906:b0:59d:ac8d:e130 with SMTP id
 71dfb90a1353d-5ac508eaaf4mr7954696e0c.9.1780935332841; 
 Mon, 08 Jun 2026 09:15:32 -0700 (PDT)
X-Received: by 2002:a05:6122:906:b0:59d:ac8d:e130 with SMTP id
 71dfb90a1353d-5ac508eaaf4mr7954653e0c.9.1780935332396; 
 Mon, 08 Jun 2026 09:15:32 -0700 (PDT)
Received: from [10.156.84.244] (180.171.88.92.rev.sfr.net. [92.88.171.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd663sm469175685e9.10.2026.06.08.09.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:15:31 -0700 (PDT)
Message-ID: <765f6842-13a9-4670-ae2b-05534641dd02@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 18:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86
 fw_cfg I/O ports
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-4-peter.maydell@linaro.org>
 <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
 <CAFEAcA8uLpCA2kCzqM2jii+jigd-mRYgpVCfb=qvwZH4SU9Gzg@mail.gmail.com>
 <d9abaa0e-abf2-4eef-9292-171b55588f4b@oss.qualcomm.com>
 <CAFEAcA8iD_SPwbHr5+OgyoR9C-R6+y5SuQmPO3QFUunfA_Og6Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8iD_SPwbHr5+OgyoR9C-R6+y5SuQmPO3QFUunfA_Og6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wNYeN7DN35DCtJ2ZyZ1YnGCwSp1VbFVt
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26eaa5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MkcZI9oj5j1oI9ZXKOqVmg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=KKAkSRfTAAAA:8 a=zS5til6ZNeLPpk9jJM8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wNYeN7DN35DCtJ2ZyZ1YnGCwSp1VbFVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1NCBTYWx0ZWRfX1zx3b+FttJPs
 F8A4VKbxNafPvorodBaao/4m+I2Svq1FF/muAYmsusigXrUfiX6ynVywm4p5Zg35NqSQ525amqZ
 /sk1E3+eiimwD+bOFhqz4jx4dP50RLK0RgZ//ZjLh3N+b2qtkIcMckgrHMRBUkOcf+FHaMHIDGI
 YMDL7PvujKvOFNIxs0poPwFGip19D+ZTprYbEH3I/9eqyMYIHrzNCodmFNT/2BWRcFdt02UomWS
 Jd18yGxvPlreIrg8LCmK2bo01SzhJZMQJqfOQ/PBpowONUh2HzjbRw1SqJNwqlkdaB2wgwzi/7i
 h7c8XN3C/hchIriBEpWbR0P3553VjkDD7JFahPyFRcikFYUtC0AQwwf8hxGbAJ0J9X5sA3IYra8
 L+C1gBs+VoqSBONmHinEflK6ybMcqMAzp5SDKRRxuC2Ku2ARkisAN6XL9RRbkVUIjIvwlf3B+ou
 HZd1TbQaEk26LJd8Dgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080154
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jun 2026 12:25:43 -0400
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

On 8/6/26 18:11, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 17:02, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 8/6/26 11:12, Peter Maydell wrote:
>>> On Wed, 3 Jun 2026 at 08:08, Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>>>
>>>> On 29/5/26 19:46, Peter Maydell wrote:
>>>>> The fw_cfg_init_io_dma() function allows the caller to specify the
>>>>> base port number of the selector/data register and the base port
>>>>> number of the DMA address register separately. No caller actually
>>>>> uses this: they all pass in base + 4 for the dma_iobase.
>>>>>
>>>>> To reduce the risk of unnecessary variation in what different x86
>>>>> machine types use as their fw_cfg register layout, remove the
>>>>> dma_iobase argument from fw_cfg_init_io_dma(), and have the function
>>>>> always use the same "DMA port is base port + 4" layout.
>>>>>
>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> ---
>>>>>     hw/i386/fw_cfg.c          |  3 +--
>>>>>     hw/i386/microvm.c         |  3 +--
>>>>>     hw/i386/pc.c              |  3 +--
>>>>>     hw/nvram/fw_cfg.c         |  8 ++++----
>>>>>     include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
>>>>>     5 files changed, 22 insertions(+), 12 deletions(-)
>>>>
>>>>
>>>>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>>>>> index 45a3747908..be3fb5f8aa 100644
>>>>> --- a/include/hw/nvram/fw_cfg.h
>>>>> +++ b/include/hw/nvram/fw_cfg.h
>>>>> @@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
>>>>>                                         Object *parent, const char *part,
>>>>>                                         const char *filename, Error **errp);
>>>>>
>>>>> -FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>>>> -                                AddressSpace *dma_as);
>>>>> +/**
>>>>> + * fw_cfg_init_io_dma:
>>>>> + * @iobase: x86 port number which is the base of the fw_cfg port range
>>>>
>>>> s/x86/ISA/?
>>>
>>> This is specifically x86, because we use this where we're
>>> wiring fw_cfg up to the x86 in/out port instructions. There's
>>> no ISA-bus version of fw_cfg. Anything other than x86 should
>>> be using the memory-mapped fw_cfg.
>>
>> But this "x86 port number" is really a address on the ISA I/O bus.
>>
>> Maybe make explicit we want this method restricted to x86 instead?
> 
> I do, which is why I say "x86 port number".
> 
>> "ISA port number which is the base of the fw_cfg port range (restricted
>> to x86 targets)."
> 
> This seems more confusing to me because it brings ISA into it.
> We don't care about ISA or not ISA, we only care that this is
> an x86 I/O port. It happens that on the PC the x86 I/O ports
> can be handled by ISA cards, but it's not relevant here.
> In particular, the fw_cfg device is not an ISA device.

Fine.

