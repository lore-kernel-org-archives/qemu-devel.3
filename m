Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7FDCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcROD-0004GG-2C; Wed, 24 Jun 2026 13:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRO8-00049D-Et
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:27:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRO1-0001oN-5j
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:27:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfMoY3580071
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mM4JdLGwehvjDcdilw+6yeAuND1jA1QnxXMl8TCNvL0=; b=IwmJZig5lokAfo+Y
 P6Wmt5PYuC52M2wPO+KLvoA5M8Qq7IfmPjeOFIPRDEHvDuTytrKeN0HVjH9xsmsr
 qd+OFh59s1j7DGWP/I8nnSvmW3dyazvRXDEz1wcuGr2Ba0oVP+F8Me5cq3XXV6zn
 PPR7MLNaPgSwXmDtHrH2/oPyLqr/X+6E1GAFbij+H3RZOukfGAVZBRl0mPzmitj0
 K0oDpv8feTmt81dmw3dZcwvm87PKLGfmGx+1PMvXXlhc2/E1zyKST9/PT7l3InfU
 3BVjf6h2zYHLc6fB8kIxBA1Sj5fjTpmWgxQ/sjXtXZh2hhaRPVQggL3QaIBi5HA3
 jmGtIA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq2dc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:27:40 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-966d2fd33b1so305952241.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782322060; x=1782926860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mM4JdLGwehvjDcdilw+6yeAuND1jA1QnxXMl8TCNvL0=;
 b=UKi6SwUG+3xoCsyQ1q5SRXEQZfmbl2pULGITwhN2wjaZXjTq85Sz4iCYn61Jphojp4
 z1V78HJJuya/qCgXz/1O/ZI63ofrs01aJTXI+6vFHaPbOvIxqlDtX9m94nJk3GuxHvj+
 +EICvAP/QL4A1WU7XeipKNpxhf4xBVrT9HALPiTxy6gio7lBD8P+dk2wEdyS7tG5xUL4
 3iBvakb7urYOdtMcdAyWaLvc2mEZdxcqj9q+8kl3NYT0eupz5HcdOhlYhzOREf24vInH
 cuh4exgmT94ygAOoQpg51O4gRHK29vX0lfeSS93ZGTtNw2G81H7XxaqaC9NQ/yWNEgdv
 p54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322060; x=1782926860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mM4JdLGwehvjDcdilw+6yeAuND1jA1QnxXMl8TCNvL0=;
 b=mRaIz9Wn0tAbylz4EUIDZlyTjhmAhFo2fpkoSf4w1tvzo1zFuYTy2iXPO9m+3jmqgv
 Zkon9NnOJJOB6ck3CbTcOrxdxR78fqhE7EuAvm/q4+KqUhXjdIyqNAHR8RFK/ATOaRzZ
 WCs/M5qESzj97w93nrwTA5EAa5UA/8730fpHfvAjTmN6flJXgTBOmspW52L7knwjJVSD
 YZiHy4eZTNwLO59qwkq0qILnUfSg5VaxHAOEhwYqXlQw1Vs0VUsHkWR2+Byvs6xFOSHT
 6+bLZzWVrm3JdHO0quYyJr0YouSx/6tiXsOjnTsyUG4MA/JxJXgyPp2MCugWWAJMDExt
 lDGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpt3sFMnGNus+MjxDFgnlYDcs5AxZd+1mfESvxJMT1y2TAyy7SIp6k9tjlpQ1ltPbD1o3Un5+yhiReO@nongnu.org
X-Gm-Message-State: AOJu0YzgFb6wi7pxSnS/B8hkj3chw6V7CLm7G/RB41luNwq51FT4pTG6
 sT7OR/7kNEJ8bJXAaz1t9Vkq2KKhOwfrc6A+bFJJGlFxyCjlWq9pyWrucxdxs11gkT3VRF44KRV
 6Ucjr9VbSKrlhS1b5myWlo6rtwjNohuNOjMfDQHLTq3p2Rf9shIWaJnzmLA==
X-Gm-Gg: AfdE7cmMBJmKRN2Ef9JxvcKuzcXVckkOORq5h6FkaYpKly9jz3JlVr7hjmHNgrqsWUT
 D/wtNNxu2jehTj5jkh9lZM5nTsOrG2Gk6H30y2cZhUsujkqI5jBPBy4wS2GkFaVAt44ZX0PXRnC
 UCS9LhWXsklsa9FSqCS/ueFUABAs4oZsWBj79dK4+AZ6SVNBlyB3YE0FHuDDRMWk6UEKw/Ko2Dk
 vw/at65RirQ8V1J6FzDv2H3dlhqTwEn1t6oSZWPdQsvy5glM4FaboGAUL2p4rS8c5kwnB/BPXwP
 EsTOqCtZJGL3NG9fE6fzBrlE+h1nhvmyR4G40Lh4BNW+wgSkFpNQTc/sExpiUZ+7xw3tIHpZV/X
 QQY0upZsChp54l9FnPmQBMIPGp+ikvwz6uM3hktAWZDTuHuLQDgqZ3fnFNZyw0g==
X-Received: by 2002:a05:6102:8001:b0:71d:3739:76ba with SMTP id
 ada2fe7eead31-73115b4b84emr2390307137.25.1782322059673; 
 Wed, 24 Jun 2026 10:27:39 -0700 (PDT)
X-Received: by 2002:a05:6102:8001:b0:71d:3739:76ba with SMTP id
 ada2fe7eead31-73115b4b84emr2390134137.25.1782322055677; 
 Wed, 24 Jun 2026 10:27:35 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926401a21asm6906515e9.1.2026.06.24.10.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:27:34 -0700 (PDT)
Message-ID: <184a872f-df14-43bc-8404-788ed4707e52@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/nvram/fw_cfg: Remove support for I/O port fw_cfg
 without DMA
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
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
 <20260529174639.451353-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260529174639.451353-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX4kilI9GvsX6A
 o+O0k1H1rTadSVR6qhXh7n+E9yB/kfyrAP3/AvCNf5GFcWxPCwrP5Tk3GaO3mD/PcATHqE2uQWY
 ig4tWV89h0i4jMCAfMzu1nJVPD5G/7I=
X-Proofpoint-GUID: S-DSDMowoUOwUxix9Ovz1wHcn15ATkRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX4k0OYEaGtN8S
 aiAwpM7XS1TY9yceUYL3hgPfal2O7jsAgYik5rwlbAMCgrzMSef55p2VyTTGHPRv8XwDl7GJCqh
 3ra67It6LA/aVC69I71j2QEkGZHhFcyDpZqnnJg4ZCRwkKqtZEJ9+bdkFcOBIXGLS2L6iRx0M9f
 /I64dr2AUiCPAfHUKPMHI3x90RIBUylJKKlZCLaSZrrPS9dXTgBmuV8M8HGujeYSe8oFaWuOc58
 5ONa2zq4Sq0dq5Zp20YGwlo8f1WkEBKSMRi8tzNVXhi7L5CRfTLnxUGEE6ORLglFpgxo7FdO3pA
 Jd8LZ7isOBKVDM4bF4fZQHNloPW9/IuyEgW1VD2wBjUhCBKD18DjElXYiCUrCvoJ/i8e2bWasCz
 H1/PXXH4V/MtqS9RvOKT5qRCIvVogQ==
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3c138c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8s6yie7EuDRsEhuZ9bEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: S-DSDMowoUOwUxix9Ovz1wHcn15ATkRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240145
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

On 29/5/26 19:46, Peter Maydell wrote:
> Currently fw_cfg_init_io_dma() allows the caller to pass a NULL
> dma_as argument, which causes it to create a fw_cfg without
> the DMA port or DMA support. None of the callers use this
> capability: they all pass &address_space_memory.
> 
> We don't really want to leave the door open for some future x86
> machine type which doesn't support DMA for the fw_cfg device, so
> remove this, and instead make the function assert that it has a
> non-NULL dma_as argument, like fw_cfg_init_mem_dma().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/nvram/fw_cfg.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

