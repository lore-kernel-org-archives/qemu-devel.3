Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D40CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4ZA-0003I9-FQ; Thu, 04 Jun 2026 05:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4Z8-0003HY-GE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:40:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4Z6-00072A-GZ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:40:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UXeL1132194
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9YdSVdULWV9QsfnzZQsnmDQeMltSPy7sm8fj/9xURaw=; b=B1ZUW2VKz5zTr1uM
 qvCRmxEoYFgqcy91q7wmZtBdewspWWrEpxatcWqV4aGzVxLSsVRagPmciDF5XtzA
 RcHmRkMuAaqAizlnF0DuhXvVUvTXyQUrAlh9/+GFiQa9cKDD/0ps3gFyMMDu3nWZ
 WMzQSPi3hz+tKqZArjhGqD1T6svMtZgGb/3oNVMqrZJjwMtVaRTcrx3IBngsg8HI
 g8Jp+FymEv1udW/slV+jS2ikTG9LofDIwGdR954BN/FGrxZneYWeK5cQW0DreHqd
 kSoFtDJUgrud/wVHpX3+538PXoerb1BFpqP+lPg9aAiiJelCi4lYnUhRTGDjJRid
 mfWK9Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsg8jt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:40:38 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-963e6319d22so113389241.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566038; x=1781170838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YdSVdULWV9QsfnzZQsnmDQeMltSPy7sm8fj/9xURaw=;
 b=aZzNhO2b9deFydPzwhCGwYizgswzuEzNoPc3Nd4nYlTP0kbRmkcQNEcs8ZkNJdI8ZL
 z6aIyn92nW12ikNO+hb/F4DZ7lhCoIt59tujBsip3E5kv5ECNAgazb98Vo51DLKXb+br
 1WMe8mZEHXWb976/ZDzK6LOB8t6SXMhnGGzFCcN6VvroIT1NBqU+LwLwTWDu/ikgGeUI
 uhRxWDyshcjo8ZkP56nbsvQAeGgw0ir7YYE0gFIH5cEEMhRImM8zj4585ao92l79GIUJ
 nHlgjBiT/2tUzMcpJVyKxMYb5XSiCbvWlF8b1MYEwSpWLrSEXVS2vqd4WJwxJptcnmN5
 pVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566038; x=1781170838;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9YdSVdULWV9QsfnzZQsnmDQeMltSPy7sm8fj/9xURaw=;
 b=XxDyOCVjtugwIGZi7IsCH28DwAtZrc3obAM5ayAKG0vyzguMjJNsyB2wK8QKsiKGO3
 cF/8xNnL6n7FXPn5jp5Ic8Cuup5E1WT1AxAcOJuse1spXmQTgjmKwcEG3QKZ+Cj1HCiT
 BAC8lPbnrkLj0GG0rX3ldTTzU0RB2MzHa+6RcVxQAw7vKE62czxkan/3x6jjzcjbK4Jn
 601GhHfX0zjFjEMB3Al68zTKOxXEMg5fdvM5tKhYsktPh+J/5apt7x7mMZwkz9Y/McUQ
 d6wogjqQtcG9prftw3xg0DufutlEyAbTMuzSUjDaxTZLOPD1ZZZ8A45C35a0XFDQXL+7
 8E7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/e/zl/7ihGXuLcWN1bAxW2JllzusWREy+DindloBiC2Q47UgWoDB0nAEHP4MUCX5MoSwt0SBMjlDEc@nongnu.org
X-Gm-Message-State: AOJu0YyWwXZGHVE4KeQcB+eP7ZL6EMuFJGdTsMj9NMQitwL8atqWA59Y
 g4XO6umddsbtYQgJovunDTf5fGfX9/bXenTGLdSLzU9iHHexJATiImmUI/d5fukAoXS8nbauxq1
 nk7B1EeAlgk172nqejw7GEoOt/0Pjtil2wq9RpOzwwx8c8ZgQ55qo1HEgMQ==
X-Gm-Gg: Acq92OHUUtZhcpMz/zDAeC/Mo/W11nv6DIB4hgzVVMDuggQB/XygKzqrxCWiV+5zrQt
 FoZO7nWGhHk5S1TIK14rBSG8CDoi+ZwiFJ6yL6CSM5oxtQE/keR6CYT8aTiZde5SG98iiVPu75y
 egTcD6eV+0B2BkeD6+TmPZQh7jxRB0fuveyM8vIKA4fIbmk0e//2YRMzew5Au5wNr70r7y2yqM+
 uV04S/wPGy4jO9aXI/gndCK3VpP+WrN3GEqQfI+XALlLmBnJtCUeShgeSE7E6Ce17yo482lxNIv
 YVQfA8oDvRNNqrLMcxPIMIY0P7k4DaKzSOrC+n6HF+TNsI8NAd/fzUQjAW+ZghmQDu4E7lqN4Az
 KYrKte4Ir2dHG4aj2oJqhwLRzhpmAERMEGmyaHrXODoRFAUewhhPzt8NiZdqGRKTSMycI
X-Received: by 2002:a05:6102:3c8e:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-6ec4c6a62d8mr4258055137.28.1780566033189; 
 Thu, 04 Jun 2026 02:40:33 -0700 (PDT)
X-Received: by 2002:a05:6102:3c8e:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-6ec4c6a62d8mr4258045137.28.1780566032598; 
 Thu, 04 Jun 2026 02:40:32 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413f91f22sm3997260241.5.2026.06.04.02.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 02:40:31 -0700 (PDT)
Message-ID: <383936e5-fcdf-488b-8f77-17fdee41243e@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 06:40:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/riscv: deprecate 'debug' CPU property and
 Debug 0.13
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Tao Tang <tangtao1634@phytium.com.cn>
References: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
 <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
 <ahz7-1OomsZTMIz2@ChaodeMacBook-Pro.local>
 <b063eb61-a246-4f10-bac2-ee9272afcd2f@oss.qualcomm.com>
 <CACPK8XcjabfXiDLNm5WoaypfHKbGRggqLL3gob2FWz2TZf0ZZw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8XcjabfXiDLNm5WoaypfHKbGRggqLL3gob2FWz2TZf0ZZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ijr7m2UhUFTn7-PlukcY-Cb53zaZmxGR
X-Proofpoint-ORIG-GUID: Ijr7m2UhUFTn7-PlukcY-Cb53zaZmxGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MiBTYWx0ZWRfX2uOeXLCaNpS1
 /M6kleJX2554wtEBv0+rTyATvZPozdgz8Loh8RTwAqtQOIsNBGw0efMU0bmizOkQ6TM5k3B4iNL
 wDwhH2ceqvzxtHLGYs499uklgywBt8mBuACx56tmWEICQLedjUCe58Lt0uE6s2Gh8Ou2gbdED4g
 LEQOjYV9naM3JjOtfV9FxSkGZ8nUPdl3VXvMPF6fLzeB4qi7QK3YmrqecFgYfqQgFErXskG5ICL
 rPIztfDSFImGdMc1CzuedzXwtsaIYXt90NfO0gseoyjmaRSyGBe1HzStIDaQOoheBlxTL8D6jV7
 VKaEcO+7CoAw73+F1Fy+X0tPPCtrKNrmtwIbPyCUUnvOC6ztrmjOFvDg6p22t/WiRWQCasAdvN0
 /6cYPlWHjisXOwrTDIzFPlEe9o4Y0CdnBOd7HsFCcni+mwv+cYlp2XJ9G3rrvViD5tG5Zhk2LYS
 IVXBLr7+KLlZ/IdG9AQ==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a214816 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fTdHOzJe4hWYLAdQJIwA:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 6/3/2026 10:09 PM, Joel Stanley wrote:
> On Thu, 4 Jun 2026 at 06:27, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 6/1/2026 1:04 AM, Chao Liu wrote:
>>> Hi Daniel,
>>>
>>> On Thu, May 28, 2026 at 10:12:14AM +0800, Daniel Henrique Barboza wrote:
>>>> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
>>>> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig' that
>>>> is, for now, compliant with Debug 0.13 that was ratified 8 years go.
>>>>
>>>> We're going to add more debug trigger extensions, e.g. 'sdext' [1].
>>>> Thing is that 'sdext' and all other extensions that will follow are now
>>>> adherent to Debug 1.0, ratified Dec 2022.  And so it happens that Debug
>>>> 1.0 and 0.13 are not compatible with each other.  This makes support new
>>>> Debug 1.0 extensions like 'sdext' harder because we would need two
>>>> independent code bases for each.
>>>>
>>>> We consider that most of the RVI ecosystem already moved on to Debug
>>>> 1.0 and is now going towards the extended Debug 1.0 extensions, and we
>>>> should follow suit.  And the best way to do that is to leave Debug 0.13
>>>> behind, by deprecating its 'debug' flag and making it an alias for
>>>> 'sdtrig' that will eventually move on to Debug 1.0.
>>>>
>>>> The following changes are made:
>>>>
>>>> - 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
>>>>     cpu->cfg;
>>>> - All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
>>>> - Two explicit getters and setters for the 'debug' property were added.
>>>>     The property will simply get/set ext_sdtrig;
>>>> - vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
>>>>     will impact migration between QEMU 10.2 to newer versions, but we're
>>>>     still in a point where the migration break cost isn't big enough to
>>>>     justify adding migration compatibility scaffolding.
>>>>
>>>> Finally, deprecated.rst was updated to deprecate 'debug' and inform that
>>>> it will be now interpreted as an alias of 'sdtrig', which is now going
>>>> to be compliant with Debug 1.0.
>>>>
>>>
>>> This patch conflicts with Alistair's riscv-to-apply.next branch.
>>>
>>> f71708fedf target/riscv/tcg: disable svnapot if satp_mode < sv39
>>
>> Based on recent discussions with Alistair (check the "QEMU RISC-V Call" thread)
>> seems like we're postponing this change because there seems to be interest
>> in keeping the 'debug' flag around, together with the 'sdtrig' extension that
>> we need for your 'sdext' extension (and for the riscv-server-ref board).  Seems
>> like someone is going to send patches making it possible.
> 
> I think this was a reference to Nick's work (I got credit for a bunch
> of things Nick said on the call, so swap out "Joel" for "Nick" in some
> places):
> 
>   [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT Ascalon support
>   https://lore.kernel.org/qemu-devel/20260114044701.1173347-1-npiggin@gmail.com/
> 
> I encouraged Nick to get it out on the list early, to make others
> aware of the work that had been done.
> He mentioned there's some further improvements to make, I'll let him
> fill you in.

I missed this series completely, sorry about that.  It got caught in the
middle of my working email transition and I failed to notice it.

 From what I can read in the cover letter this is exactly what we need. I'll
throw some review comments there so Nick can send a v2 with some R-bs.


Thanks,
Daniel


> 
> Cheers,
> 
> Joel


