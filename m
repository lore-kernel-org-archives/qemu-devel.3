Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE2CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbm1p-00059i-7T; Mon, 22 Jun 2026 17:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm1j-00058y-SU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:17:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm1h-00068G-NV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:17:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZjfc1629288
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Q9IbL7RqWm82Uy3uj/sLFTghqh6w6xKa+GckrFNIhk=; b=mLt9SfnK/2tKsKmj
 H9EiHNKJhCjq51F3X76Gfq35td9euwlnnOnjS7eYnK9yVcT6WaoEr5le86GNUcm/
 70+qdp1HQ2Vy/XtuxdkWBn+cXbnHlY23icjnkt+CYSQWZCMLnSMZPEGwoqAUqIOu
 6r6E8RdRepwHXqy8fXHB6j1LkyDGciEzapumltRm23nI4oVo5KFhBH2sYelfeEIJ
 atevKCFxtkN4grKlYRSyT6Y80A8xpWhKUNJCDnnJNvzu0uPjlbilU3988AB2dq3s
 mRhKDkY/opJ4aiI8T8tTPmuEPB7a1ArASoXFaaJRwurrbaajK1KzX4wFD1Sblk76
 J+cIQg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq28jn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:17:40 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6798c46f723so3271542137.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782163059; x=1782767859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Q9IbL7RqWm82Uy3uj/sLFTghqh6w6xKa+GckrFNIhk=;
 b=bwaQ3Vne4vQkcWiA/hW2aSq7vNZCC8jMjUaCWFpEx9JsFaiSzzauxi35YBB69O0F4C
 jis2S3CgNk1dmXUCBPN/3qAyHb9RfAvss/a5SmwaSpW17GgAYFAquVDQf0LFOUimB/b9
 8Y760sqxzuw2rrRKnWNt5q40YbuGcLMCBnH2CQOJjyyScf8N6vne42IV/3LmYA6v8F4B
 qwuW/KxR+LKpchDGUWDFNkBZZragymY+OM3yJgetxsuhcrg5YzPdX9juQLGdDdteTXGi
 Kugt2z5jpJHJ4s+yN8RHbdymQ2LVh6lSKUBhJVu9wEZwHEoDqx0gKx2SMA5bIbqwB226
 Le5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163059; x=1782767859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Q9IbL7RqWm82Uy3uj/sLFTghqh6w6xKa+GckrFNIhk=;
 b=CVKbEIXs5nmq7n52U/8TTHfQR1Q7X/knod4k7ihBXYt9C3sEJkfVfAFqOFHaFsMTd9
 JQCHgvqMKk2/hn5R1R3sTcmP/SQ6IDnJQiOg2vI+V7JV9ynIzhMS9kIKpRajB3EYLU3Z
 0Ba4sTMqx2GIi5Dr45tx7PvzYAEdLkukzSNWmqreub652bvBhHXpHKJOdlDcsFQSM2ag
 H50MCIDXucs8McdmEzWUOhxXaGrNEx8T8gdA5Ww3CpTWw1ErLvs4uD5d7T4zBo2yPb8S
 RWIkaRzHLi69hzk/Iu67loN3EvKA/qpIGuChq7IXfwCQh1W+Zl4CGrwzASwl/Faf78So
 uD5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zWsxsh72hfxeKDFca5bJ8yYus+TuzYIqm5uJ7AuqXRe4wPR/VNlItyeItlyJdxdPb+cmJFjRT3+r6@nongnu.org
X-Gm-Message-State: AOJu0YwfvgvAnJ8InPl2RFJNqoAxbk/I4YFOdgHiliZ9d5fPKmH0PMBz
 lDPfoxX9TPD4ztktbSyXWBHodC5MQjcIVVzpfVDO2W27RzYcnrHLLbO2Ay4iuC1WxftGCTzznUm
 q6gwDfqiCGFCcuB+OM0LOkWMp1ZuqnTPz5CcXzX+jWVuNfqOSSUR1cyRX6Q==
X-Gm-Gg: AfdE7cmyneF5sNQoZzhXB8QiZXqxL1aoKcnFKaexOyJC5IOV1rWG4um1cXSgBckgwmd
 r9fwbMzmZ+4of6HwVLu+xbIVnVWp6lRwfaqE6zU4M/DmMJvc4WDY+Cydhd40yunCf8m9Z7vr5ve
 w397nic9PxDEal/Pjv7fqq7w/KUHzmDYmzblTR+JX66deE73CwR6wRoeHvcYZDdzpmr379QaFT1
 2h35NOb7DVym18ZZZ1WtGALO8jMk3OscmmeuWSJOT7pKc4WHIrhRftaUgey/Bxy3bNWJfNyaHWp
 BzH6wEAEaZf6VSTQXNGn1Y2Ai2IB6sMdf5ADcVF7LvCB1o54T+7UIKSk5+XbvPaY9spz8HotNP3
 aYYIBo8GwrLGOV7XmoD6RjEfJBR+4t3q8ChN3ZPnjAOtT3paoGeyZEMBFLowBKw==
X-Received: by 2002:a05:6102:5486:b0:634:92c:bdce with SMTP id
 ada2fe7eead31-72a022d2d7fmr10027456137.12.1782163058734; 
 Mon, 22 Jun 2026 14:17:38 -0700 (PDT)
X-Received: by 2002:a05:6102:5486:b0:634:92c:bdce with SMTP id
 ada2fe7eead31-72a022d2d7fmr10027443137.12.1782163058337; 
 Mon, 22 Jun 2026 14:17:38 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788282sm42387274f8f.17.2026.06.22.14.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:17:37 -0700 (PDT)
Message-ID: <9e12d61c-a1e7-48a3-afe6-f249f979fed8@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb()
 to riscv_imsic
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-24-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-24-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0uPq8gwF51HSepIDZkrDnfq0KQH9E5rt
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a39a674 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 0uPq8gwF51HSepIDZkrDnfq0KQH9E5rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNSBTYWx0ZWRfX95F8m8I6dIfJ
 iweX+P0YAfvxlkd7vbPQhh59yZzscOKdxmwljY5+U56sMSahIVveqV6qQHo3vHJ2lbbpZqhoiKH
 9POJYAMJlOlJ9eJ9NlWxTD5/RX3Pdqm+Wr7fzgb1UGZ0YekX37teDiGe8I/V+fFHDHj78GryRfB
 eN2zKPH7vrEnzHnGOHu67h7MMLmRVitrwz5dF1+OcHq/BXzDwq21RWhfyQqij/DR7IdwufoGW2h
 wdSNhmwz52drFzAPaFOVwuSCDYT4c2LlZ4Hum4GdhDHrRJTgWcayhuWKtAAvdtGi07YiyJYGsQF
 IDfe+9B4Vtxw/57l5GHuKA85ZRIWarHfi1op9+Wd3WpPN1YLhaiOOzUg74j7uWZc3YqYZyE4lVP
 pi5TQRh4RqImD3IQRkzkZFctWnpgKLIs5MC2oNEdMYC2qLQ9XczLAshCEP4406iKN9mrDIjpvzb
 NPI/TnctdHaCCeRRfQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNSBTYWx0ZWRfX35vM4iooiLfs
 HAAA0oX+UvKWKIsXgIGYhB9WUizENVsaXPT+XWJqGp/RB7ObGg4qH+gj4JLQF1u+9dXtTFsDFI8
 M6My4MsWlEsRKhrpow53L4e9kSKM7gc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> riscv_imsic.c is the only caller.  Having it sitting in the TCG only
> cpu_helper.c gets in the way of --disable-tcg for no good reason.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/intc/riscv_imsic.c         | 11 +++++++++++
>   target/riscv/cpu.h            |  3 ---
>   target/riscv/tcg/cpu_helper.c | 10 ----------
>   3 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

