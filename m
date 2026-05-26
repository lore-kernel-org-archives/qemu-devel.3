Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74A2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzB2-0001O3-RQ; Tue, 26 May 2026 17:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRzAs-0001Mx-Mp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:18:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRzAq-0003xp-MI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:18:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH11aI3289824
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qNRfr3+xh1lSEsX1bwasvbXcpuo74C1PTpke/ccZa00=; b=JIT+3R/i9oc0kJW9
 +I2ulZYR9x6Apr80WHpEgrUKSxAH39M3izLPrG3JNrzstcYomHRBe2U2bTf6J+9D
 vTl0GVgL68SogCpLZ1GrNML/FFT2gFXdGkWLK9/PlF7AWHfbADUXLQ2TUyNnlgNl
 Ii3R2NkYdRPdd0ONmT6xpaSWf1FP0PoNvIrYn5I+dOrYQF9BR6E+b9T5Aypw7ds7
 7EuW7SzeePnu0V1u2icBfQQ8+7ku6dUGTRZMiJhxeXSDx71etPfgS4h9/S03ro+H
 m4rHt/nX0u8H8ycwa/eLaBd8xQOY3nEodKCwIXyw4mqT0cHfCHdr1dbkQF/GdqvP
 9Mo9Lw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edf1j90tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:18:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49424ad88so101992446d6.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779830330; x=1780435130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qNRfr3+xh1lSEsX1bwasvbXcpuo74C1PTpke/ccZa00=;
 b=PNLk4qo/VgtuiBoCMYy2gMYNaOaRKttQ9Yz5sMhgUlZP9jH/cu/PkrFmmZDnmx2nav
 nJC9SfMK86ZPnXBFmALwoulUMIGqiJqJAvJL1Y5KNdFMd31mqRZLx5r/9M0FdImGkkas
 TnEFc2blNBaw+Z8NCeAr+yd0NrHCGtsh4ZDwkc3IGco0f744LKSgD1ABDlWSTCvuwyPG
 PdCUWf5ROdMq8Z0WxiG5mR3BtLjH+zFC/dklNkN9rwNIJ3UCW1tzfaHrObI1Zgn6PWjr
 MoPugGg0jUgR2FhGCTuZ7HfClTB+OhOs1f10l5cwcKDtr3j1d7RKkgCcTAMen4Vg8G/p
 mxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779830330; x=1780435130;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNRfr3+xh1lSEsX1bwasvbXcpuo74C1PTpke/ccZa00=;
 b=owrzFBCSKEKILSsuRm/YMUMeCYD7NtogDU6K38X5OrPz4gnh/J4fdXE2VjulMbcp7O
 L6BgpgxIUC2B3/H9ddMwB62BmYeLBFroPwTQISBkJ0GX4mw4+qh4m2zdyYIfQSDRPnvS
 znVdBbCJueBOU6rFj2NHXObtBGfEchb0o9CXUORIBBz4ujVlt4Z8IDwbW11lN/a3pQZU
 s2dkNFH20IAQor64igdmBABddLRKlCoZgNmvQ6oMWG88nx8WmjWLbNlAxhtUMriKZBUp
 BJgFdahUq4WavihBQ5R+6gEJlZtW7nF81YL2SDNKbvCUv3baS0caYOZgOdK6b5yj8YuZ
 UeAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rmOLfaxnYso6Fk1yMxB9gTmxuKqLcPGiROWE9MHADVZuqeh3iXI2wgSlaAwmtGdtUSlOOrjDr5u1A@nongnu.org
X-Gm-Message-State: AOJu0YzXcWBSSEnyZK/iY3puz/z05g1i/kLp1aQZsga2vDPSMmVKR0M9
 RugjMGUD57UDPdOOyIcvJ47cc436hL+3i5rxU266fhPzUmGXa2Fp74188rwidnqw080dTfZ+Kvf
 I9G/bXSTc0Niaw+wFB2HvkDiyLkHEdlQ4ZqXiD2ZlHlVAnQk2nJ+xMgL9bA==
X-Gm-Gg: Acq92OEeyxoHd1dat3Mn/by4HeQaO7Jg0iy3dWW0xPNTH7UcgdAISWbQkz/eAxjTX1w
 ly0NPQgqxvWr4njCsp3eQutKo0WKCzBpuPXcMm1DEUBA3mtWWY49jbk8CForDAupKDMSPOwnZKg
 ZvFzipFvpYTI44WNS4TlewFTxxp9KhXQGvUrv1oSPWXv4LiDkpPHTGnnHsKJadJ8imJ/kSjGRd5
 miArUuYhCUpceCCcq7K4H1DzfkEMtZnwoHHf+X4shpdYXE3UTEO8tdB+zfCEmaIy7zYtXRW5Ytv
 B7FjWqSsTy/UyOpOkrt/shJ46siL/pGmar2GuZUG8CR5NIr5pmnJL+zJziij1mM5PQ+h+Q7bMHN
 +w/n06Igse4RtsNsvmE03BFa8cla8+E27cB8Xe2GaOaWhcq7s04zWdEc4uiTBhyyIMB/YIg==
X-Received: by 2002:ad4:5744:0:b0:8ca:e41:aaf with SMTP id
 6a1803df08f44-8cc7b54b9c6mr326556136d6.20.1779830329985; 
 Tue, 26 May 2026 14:18:49 -0700 (PDT)
X-Received: by 2002:ad4:5744:0:b0:8ca:e41:aaf with SMTP id
 6a1803df08f44-8cc7b54b9c6mr326555636d6.20.1779830329511; 
 Tue, 26 May 2026 14:18:49 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc81306c57sm152323146d6.34.2026.05.26.14.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 14:18:48 -0700 (PDT)
Message-ID: <4670e49f-5c0d-4ad2-bcb7-8cb0833ee8f3@oss.qualcomm.com>
Date: Tue, 26 May 2026 18:18:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by
 default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-4-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260526095731.63525-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZNjnX37b c=1 sm=1 tr=0 ts=6a160e3a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=TLzj4CuIgxklPQOjxDEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4OCBTYWx0ZWRfX23NU6N5F0u7w
 58ifBTy6M4gPg/YKHJXpVIwzkbTQeP8k5IED+wYwOprCirJfX4V8OBM6O2yqCGDNi7x3CjLhlCY
 lR6Xv7iZ8ZqRbX7zVtz6Rhymd4PnAXZd2L9zh4BcgZPzZwSvWCN2Y3eLgB4oNMZdAs39Zw+D+x3
 7fBkQH3whe+yuhGxvqZWfcLzf901WUNku2gBx7cRKRZwmQdM2E17H+dAW8mCRT2ZeN8G+FBAKB5
 OS1xzA7Dn2LYMLWNFRaSTNwq/VMFYypCNYQcuhjja5DtdDkp4jbMlrUZtooHif1lXzGLr3GhrAd
 sQA37hYtDPJQTQ/r9BvJtTXmHvNh4NPwP7f//k9ZI5dJnGUI56X9oSPd417MaANAtDyQcNu3JBv
 kGtOHnWsjduvk9oX8KjPcgVbOGmh9lqqVjkE1vGqoh78gypf5s9iP3WYmYTMd5iSTs61hWwgaug
 dHNpTPKf0INuHnzRpAg==
X-Proofpoint-ORIG-GUID: CbkyiRSrfe4RRzBTjETVW-8MUYHb9O1p
X-Proofpoint-GUID: CbkyiRSrfe4RRzBTjETVW-8MUYHb9O1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260188
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/26/2026 6:57 AM, Philippe Mathieu-Daudé wrote:
> Per [*]:
> 
>    AMD MicroBlaze™ V processor Key Capabilities:
> 
>    - Configurable ISA support for RV32I and RV64I Base
>      Integer Instruction Set
> 
> [*] https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/microblaze-v.html

I am not sure if that's really the case ... the trick is on the "configurable"
keyword.  This basically means that they start with the base set and then
add stuff on top of it.

In the link above, if you go down there to a "MicroBlaze V Processor Reference Guide",
you'll get here:

https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/Introduction

And then if you click in "Features" in the left side, right below "Overview", you'll
find a "Configurable Feature Overview" table.  And there's a *lot* of stuff there.

Setting the board default to rv32i/rv64i will break the board.  Pretty sure Linux
won't boot with just rv64i, and I'd be surprised if OpenSBI would be able to play
ball.

I see that you CCed the original contributor of the board (Sai Pavan Boddu) so we
can see the author's opinion.  From my perspective, if the idea is to not use
TYPE_RISCV_CPU_BASE, maybe we can use rva23s64 for 64 bits (the feature table from
the link seems close to the profile) and for 32 bit I would go with 'max' because
we don't have 32 bit profiles implemented in QEMU.

A better solution would be to model a Microblaze V CPU for the board but setting
the default to max32/rva23s64 seems sensible for now.


Thanks,
Daniel

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/microblaze-v-generic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
> index b0494b1ac50..04a201dcd95 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -14,6 +14,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "target/riscv/cpu.h"
> @@ -182,7 +183,8 @@ static void mb_v_generic_machine_init(MachineClass *mc)
>       mc->init = mb_v_generic_init;
>       mc->min_cpus = 1;
>       mc->max_cpus = 1;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = target_riscv64() ? TYPE_RISCV_CPU_RV64I
> +                                            : TYPE_RISCV_CPU_RV32I;
>       mc->default_cpus = 1;
>   }
>   


