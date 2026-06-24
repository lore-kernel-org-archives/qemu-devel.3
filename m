Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E9ACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRLS-0002tb-Qm; Wed, 24 Jun 2026 13:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRLG-0002sx-O7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:24:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRLF-0000jk-4m
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:24:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfgfZ3756511
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7khpyy0KMZ9m6bjepM+MHL9rPEOEHxRLNu+PKq1qyV8=; b=BXkL8C5twlSzIvB+
 3d/75CIQOSnIg5Rye5fT/4WsXYCDcsiF0xDadSy0l/THvHWdm3l+vOiE29ozXmnk
 gvrFUxdKJTEZod+J3J54Rj4vecEPp3bjIGuBeWJqoaYUm5uJ2MOG2GG3Q0zZuOTX
 lYwQXP2LjP2Zs9RnYcTSA2merXW8bR59M07ekpN53EpwnX9IKWYJi1qiQGJ5rFyj
 xMLwBDHWMUP+/Y7glnhekMQ4xpv+QNNWlrOLbStcMkusAbf7dnvF6/1mhwsjAdzo
 5mlVsXnUOuZSp+JiA+48vNcJLY+zKNwECWMTyEiP0BonIxWtqSLZJAct2Oj7n8rw
 j4KhzA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ar3esu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:24:45 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6a2b8b91dc5so519977137.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782321885; x=1782926685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7khpyy0KMZ9m6bjepM+MHL9rPEOEHxRLNu+PKq1qyV8=;
 b=BOw084LTIo7ywNEg50xXAAzjltCVh5skpWNHe+/Eu21Qokdxk7M4d2puY5dreet3jG
 LyvzfpbSn3zCN9CyI66f/jC5cwNoX/Q2F4Mjq8CY838y9guZ2GI/U0UJKEo+Qs6zVvrX
 hnRqy6Oojsm/vzKSMI9opz8m6k5ytoxMZMOm2upxLeM0DAlnKRmVtxNLJu+rIKGj0PBx
 eqwbKBVGD2w8hha1hm5sVRHT711uLhAchGG7IcylO3ST9UIbQdTaGlS/k3Fs3o6H2AJ3
 ei9BjQOJNFg6ipaiA9KnERVDTv9GVbmcnFnhuR0wnyNIC8IH+G8TblNzEMsYbpWRGJae
 UyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321885; x=1782926685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7khpyy0KMZ9m6bjepM+MHL9rPEOEHxRLNu+PKq1qyV8=;
 b=A6NqRVPhaPYTs4g+5k0cDY/UI1VF2Mxd6PpwcaBcpBq62boQSrFGCsiIO1gII0TEM/
 wBMX5FGKY2oicZruJBJ+wPA0Q07cX4KhRTgKC55inpF05gGANwAdiixDavM4rDf0N0Kz
 /ZZThtg04r0JVOiBccclaVuQWOTiOgHJhByzDk9Fi/5OKB88xMEgxllH9zQ97Zw9zhhs
 cfJ59IlJNS/qI+l4s4qj8Q1AI+0uHcSOJ5glKTAx+HMdweyVzo7VF1JmUU94yd5Q2DDe
 49aJwxxChZuFEGVexxDvDM1i5zeQSTXwTK9Jg2oGWSMrCBR4mk8gXGd007gZ/O4wenZ9
 EXOA==
X-Gm-Message-State: AOJu0Yz1GWZ5ok/tshiTZQj43OGuWjHnBuW60gA7vE04YwSrAI+bshH0
 25NdzxTJcGjbfAkYO+ZWeJfpamKEZvsXAZuvC5MHyTHu7i+KboHXM6RieB+3yygKkxXA8oujYRs
 hu/Aq0ux2+zbfeC0gGU3E8pgyF6Gg7pI9V/IudhoHAeog2QQT3mmRXf7gTw==
X-Gm-Gg: AfdE7cmmPrKSUbJfVADY7T2EiV+jDodMplXWfQJ9vRZsKzlbhGAoKQoD5QynKJchtA/
 OAs/Se02KLSIsIXlG5gtHnqwXGl0tpMZl/5fIi8eFQJoM2Xlt8n96Aqc3w3fNdVCNOmTw1NSbYk
 7Im0UgSbd6p8d/VqiRlisDxGN7b+IqpcW0oGi7LdUCMOw/pAIwtxEG4N2AmKnxHNr/xtJLgYeZ1
 WtHFIRNgR5PoUU+jjPEqKjDzg2PVmaJkScI8aLzD66PMwcprUpS8scXT3OTy9aHltAAiVrmP2Bq
 LtYVW+h7pI8r+2lZwgK7K+41LrPkpZStkPw5mBexxaVM/dRTaL46icmv5VXdaRc55KBolbJ7k21
 bJevIfI424M1Wf09zOy5RfOXg68Rjzz9b985bVw6TLB+/JlLA7T70O6xEiH5NYQ==
X-Received: by 2002:a05:6102:1490:b0:631:3377:dbc7 with SMTP id
 ada2fe7eead31-7311552ef75mr2640139137.20.1782321885071; 
 Wed, 24 Jun 2026 10:24:45 -0700 (PDT)
X-Received: by 2002:a05:6102:1490:b0:631:3377:dbc7 with SMTP id
 ada2fe7eead31-7311552ef75mr2639853137.20.1782321879731; 
 Wed, 24 Jun 2026 10:24:39 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d51sm7059804f8f.15.2026.06.24.10.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:24:39 -0700 (PDT)
Message-ID: <b48769df-a283-40dc-b323-3c07a5ea2c26@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] docs/specs/fw_cfg: Document all architecture register
 layouts
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
 <20260529174639.451353-2-peter.maydell@linaro.org>
 <931c8511-8c13-4134-b562-d4766d1a101c@mailo.com>
 <CAFEAcA_9KQsiCM0WGFYEonu-Afrv=zVrssv2ar2DgG1AMrw2yw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA_9KQsiCM0WGFYEonu-Afrv=zVrssv2ar2DgG1AMrw2yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WWpbElekqaReFDdeLV57OA06ACytEdc2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX5roHFlXmWWNT
 +ZXiDnvFXUPTWtkyjsSj0Nq/wsScuLibNcEVHxnThhNBr0z7nS6yRXpdxOKfCaPhj4NzllNVad/
 UCClwXmc2cFtPUlC9FLriOgKtEj/F34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX1UFGpTAx+lab
 Mz143qTOHvvQ2vXyZ+SWM6p6YKmKwO4APGflNlabFv6op0bWaFF10HV54VBOBZtH17EIWZp0JkE
 c0B/weOqqTdpfZeCDiLmlFwfdp/o4Pl1z6z4MFRoDl/RCz8f6yFT73rR3XfYS14uc9sRtYiN3wf
 OdXmt3f80zzUKI7akWqd8llImPDcQEsbjEx4+0Wg02XU4I2q+JFHlTgNTxikGIrXDUws5W1jfRQ
 vgk/mzjFEB9SbHsEN+hj0Hg7ee6bR2w2swmIeU7othdUuxRT7iOnnlwm2JqF6mLetHtqTakUMYT
 tFLElQN+27gtk5nUnQq1yjuZBNahEbqZ9/lypTJIogbnc6NMqKLwr/LOIoWs6auKx7csgd6NDVE
 3VGBm6pHeOcr7I1iQrUy5GtQdNgChQ==
X-Proofpoint-GUID: WWpbElekqaReFDdeLV57OA06ACytEdc2
X-Authority-Analysis: v=2.4 cv=EuLiaycA c=1 sm=1 tr=0 ts=6a3c12dd cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=S56xvJB5AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1m688CsLQ5TUZgtBZRUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 16/6/26 11:29, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 08:08, Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>
>> Hi Peter,
>>
>> On 29/5/26 19:46, Peter Maydell wrote:
>>> We implement the fw_cfg device for more architectures and machines
>>> that we let on about in our documentation.  Luckily most of the new
>>> ones (notably riscv and loongarch) have followed the straightforward
>>> layout that the Arm virt board picked.
>>>
>>> Restructure the documentation to present this as the "standard"
>>> layout, followed by the other layouts used by various other boards
>>> for historical reasons.  This adds PA-RISC, SPARC, PPC and MIPS.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    docs/specs/fw_cfg.rst | 28 ++++++++++++++++++++++++----
>>>    1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
>>> index 31ae31576b..7e2fe0851d 100644
>>> --- a/docs/specs/fw_cfg.rst
>>> +++ b/docs/specs/fw_cfg.rst
>>> @@ -84,15 +84,35 @@ increasing address order, similar to memcpy().
>>>    Register Locations
>>>    ------------------
>>>
>>> +For a memory-mapped fw_cfg device, the standard register layout is:
>>> +
>>> +    * base address : Data Register (64 bit)
>>> +    * base address + 8 : Selector Register (16 bit)
>>> +    * base address + 16 : DMA Address Register (64 bit)
>>> +
>>> +Some architectures or machines have a different layout for historical reasons:
>>> +
>>>    x86, x86_64
>>>        * Selector Register IOport: 0x510
>>>        * Data Register IOport:     0x511
>>>        * DMA Address IOport:       0x514
>>> +64-bit SPARC:
>>> +    * base address : Selector Register (16 bit)
>>> +    * base address + 1 : Data Register (8 bit)
>>
>> IIUC they have both the same base address.
> 
> This one's confusing, because the code for both sparc64 and x86
> fw_cfg is more lax than what we document.
> 
> The sun4u code does:
>      qdev_prop_set_bit(dev, "dma_enabled", false);
> and:
>      memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
>                                  &FW_CFG_IO(dev)->comb_iomem);
> 
> so it uses the fw_cfg's comb_iomem MemoryRegion. This is the
> same thing the x86 ioport version uses (except that for sparc64 we
> disable the DMA register), so it's the same layout, with
> the selector register at the base address and the data register
> nominally at an offset 1 greater than that.
> 
> The implementation in fw_cfg.c (fw_cfg_comb_mem_ops) doesn't actually
> check the address, only the size of data written, and dispatches like this:
>   - 1 byte writes are ignored (they used to be data writes in ancient QEMU)
>   - 2 byte writes are selector register writes
>   - 1 byte reads are data register reads
>   - everything else is rejected by the .valid.accepts function
> and you can use either baseaddr or baseaddr+1 for any of that.
> 
> What I opted to document here is (a) the same thing we already
> document for the x86 ioport interface, which uses comb_iomem
> and so also is not actually checking the address values, and
> (b) what the Linux driver in drivers/firmware/qemu_fw_cfg.c uses:
> 
> # elif (defined(CONFIG_X86) || defined(CONFIG_SPARC64)) /* x86, sun4u */
> #  define FW_CFG_CTRL_OFF 0x00
> #  define FW_CFG_DATA_OFF 0x01
> #  define FW_CFG_DMA_OFF 0x04
> # else
> 
> We could document the lax conditions that our implementation
> actually enforces for both sparc and x86, I guess, but they
> felt to me more like an accident of implementation. What do
> you think?

Looking at it as an accident of the implementation, we are good
indeed. Thanks for the clarification.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> thanks
> -- PMM
> 


