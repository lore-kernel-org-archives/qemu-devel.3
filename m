Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1A1C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLZH-0002Sr-FP; Thu, 30 Jul 2026 03:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLZE-0002SU-I4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:52:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLZD-0005gI-57
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:52:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U6aaKX466124
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u3DhXQLaHpVHjsvedMLVM0pletVMZqXBRNDRovZOhzs=; b=I+QHFZ2bc3YGBx8S
 oSRhkB7LTDwWQN98gEJvu08HaLbTBmuPNZgD/OcrCcctfokQI1XZq93BS9FXv7Pa
 ThqFSeeMDcMkcprwOtDFjVc1HoMhLneJq6h6pJAWNlZtfHKBwTe5WhP4zUIiEHx0
 Pw4G6UjWypLWJFCutF0zS1/k6dh5vRH9U0nBTGc5Fx2jb457G/pZNpCdlkis6l77
 EENFpWxvCEYJNTolQMoAjX3BqDumaq+zcuQinP/BeIPsbSS0ypjw2K3vZW7uOE7J
 hcs0NNypyXsLDKKxuQgJnz30BUQN+x3YAyuRLH/zRiX5n2Fvbpj//yNAHlx2FNHK
 0q0B/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr18d8d31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:52:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso34834221cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785397951; x=1786002751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u3DhXQLaHpVHjsvedMLVM0pletVMZqXBRNDRovZOhzs=;
 b=ee+39u5zHahxZaQTijhHPXqUrQ4Q6AWr2FiOMz1kvkTyY6jndssDXdZH4BBLnbhzTO
 EhkO67pH331EImRjFSQwQEziyq6paoaEn1yvyFrXk8ium8L3ZZnes1qd2jJ1g5f/P14C
 +fgQgoAgvhf3f92oAtLTX6Sa/LYd5EAcIAoCC9aaGAJlmSPMxOL3OiVodvQaVwCu6kCt
 tPTA6WQxTZBMO4xqQjV9cSbMRhi46YC6QlYcncoSEeW5lfU2HGLMSEdKbMVjRsW922KN
 ldPk0zvnY9S4UUN8Du65a0TrXxQmi3W93UJSMzv0DFD9e3okLLEqZZ8TM78BVI/vxMqG
 HvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785397951; x=1786002751;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u3DhXQLaHpVHjsvedMLVM0pletVMZqXBRNDRovZOhzs=;
 b=qvGybm+lXKDMoxwi1zCCVfCS+Buts1b1c0zX+aCj3tQy1qfzb+KjWx5scF3Lx6P7kp
 4elCD5+vwT1o9n9Usp9gPDZbNqaBmCXLqnS+QtjL3z4bzlAlLXgwpm49PWt31CChcc/k
 3P6VnA5WYxj26Jz+Iq/hvmphYMN9kRx+XpZ3uhThxpQZ/D5katsGMwzz/TqAro+ueM5B
 KmSS8eUh8RPU4uGwBMvq2CFHKMbqk/TYalgj4Et9yjvtuROl7TsyrkLTLIMPoyfMHqSw
 FeE7uY8skkal1opHjansOxQTLT2TJfJi+j/areowrPD3cZJFpKT/eWp/rTAwQNrBWcdA
 +sPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIFDbWP6pv1BtKC7n+Gd4+COahJFQdHunb4RjSn/SFdB8zBRHDRe+wrBaQXuHm4QfSyj8c15sH/rQ8@nongnu.org
X-Gm-Message-State: AOJu0YwBhLCu5vTjXkVEI3ivSIAcvlzyGymYnxCqqDfDA7JM7P0lJVGY
 QW+zu14O5nG4PqMokjllR4k8Ix2rqqPQJQ7y+MvT0zex/PdA1KhdLkvHfQuva3dynFaLIsbXlcX
 Hf78J/ja9R0HLEyR6EEOOuzNc3nv1XDqD0/gE8QcJC9Fk1IBjwe23WebJSw==
X-Gm-Gg: AR+sD12jLe5WsftEJLAiwawQxds7JUPpbzVGV+wJSJU/N1pi2UgPMXE934uu+svZl5S
 O+fO732/zf4L4351qIYJieRzrlbF2nJVpDI7uzK4uM4eFDjyD3Z2glCm4Hm+4NjxZCoDR6EObcn
 4jUoBdhqSrlf7nRdsmnRwC0xoBzsZeALnfIEwDAB7zqc7H6msNOivn6/mKCbO8zlUwTICGXzRzJ
 oAm7cHUwF1GESd/gHFkkSvSmjc7Nr2B/+W31GVZiadQLECmd5BW2Pm8ODt5UBjlw6e7yBO1plOA
 ng6jHT7RIz0suh0MPqltto7OW1KcomhXeka0YTrBeqwJ0TCVl3DyaAyA/WCr+7aKwwLC94Jjdyb
 YHWCth/RK5lvRBY5uFKWRE3C4S/aGk/8NtY+kQPx1+kooUlgQ8gE=
X-Received: by 2002:a05:622a:c5:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52b386752e7mr15842191cf.40.1785397951475; 
 Thu, 30 Jul 2026 00:52:31 -0700 (PDT)
X-Received: by 2002:a05:622a:c5:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-52b386752e7mr15842101cf.40.1785397951136; 
 Thu, 30 Jul 2026 00:52:31 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc6asm4213783f8f.18.2026.07.30.00.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 00:52:30 -0700 (PDT)
Message-ID: <5206e712-6421-49b2-ad36-1180d5cc7af9@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/50] tcg: Expose tcg_gen_ussub_sat()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-6-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730031025.12926-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2cVdrgi-OqTry6YV28JEqeW4sANblU4_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfXw/NsqiMs45xi
 DLGXYUDYwj3i3r2zAk0hS9CA+6qgVIpWDkTJkrc6e/fSeJCszAKG60VLA2g4pLI+yJq3aGQUe5d
 RLVXDBfmd3QgsSlFrn9cK/9sWas/Coo=
X-Proofpoint-GUID: 2cVdrgi-OqTry6YV28JEqeW4sANblU4_
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6b02c0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfXwR+dNu/ApN/w
 tVfhFINhXn0SN/Fbddu38ouvcqtaxA1GV5Ozt9qPKLXXetrC9WNq2QmbyrqzyHdEXAoLPcSYfG5
 HmLwlLTL3FPirKaBjv4WMSQQxdEni7lgycboDb+lRUaRXeohZ/OWVxCjqPvBywEamCOrdU8D23E
 4AtJzq2qh8ctl+NIR2Y44afMoaAqDdvjwFdVrwwSHYIhKVr9L/7ciy6o2AMknLpNUbAYVQXoVCI
 EDE8/JyFlHtqd1a+uMdU0VIarMJKvTVH61gXTxepy+A5XZriwJBpWTAWemZqrDr6kp/LG3A//o8
 yiGPQ7JWLEUDRHe51muDxlWFEgiZZKUQsLi9ax27hZ+JiO/AJxW+n9VnJcGZ2Bi5VELsWlYis4b
 1welkIG8G1icv7qzGidmixYcU12UIbQtQZKiJH0P9vQo8Gv886eTrdPwpF13FKeD74sV+lJi4yP
 OVcZTAMJk3k/7ZAfL+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300055
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

On 30/7/26 05:09, Anton Johansson via qemu development wrote:
> Maps nicely to LLVMs usub.sat instrinsic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/tcg/tcg-op-common.h | 2 ++
>   tcg/tcg-op-gvec.c           | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

