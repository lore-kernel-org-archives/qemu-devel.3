Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFA606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mPA0Hinj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D3xaM1b6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOg0-0006NT-9B; Thu, 29 Oct 2026 07:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMOfx-0006NG-0i
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:52:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMOfv-0005rx-1p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:52:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vCUM2912438
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rUWrSWFRRwrzwwP7XR2j308k8VdiOEXOGO7IzPr+ozk=; b=mPA0HinjEgON3B4E
 LzZAh0T9UV0SEg8jQqis3yCHpazPXtcqYXoCyyAVTM1353qoqFAmWNW8VjM2EizU
 Zt7TrzeSy0oWh9iAJHerxOx8TpeI3V2WJ8FZw1b2aWGvutk5uHZQueDdByQ7GCgw
 0Po5gwCMt6EGmG92OcI+i3EFhI4Kf9M8pF2ZeXUXZttJBt9lKetwp1fYdkHgt5fy
 hjVRZiB65B5yRvT3gxs06jwge06AxiP4iSTivN4TUHn+FPAmmaQvn6/V88Qc8oGV
 6Ne49/Glr+0eo87ymbHEln/UDdn18NlV7exaQuySxziY3F6IU5L6JHs3kjqIoFki
 4Mgmpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bske-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:52:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso462319485a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793274724; x=1793879524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUWrSWFRRwrzwwP7XR2j308k8VdiOEXOGO7IzPr+ozk=;
 b=D3xaM1b623odyga/pwYtthAA/fzXe09Ge/HSIdbF/gheL0phBQgK3wokWtV3rhBWWj
 tdiUTS94BFtDTuKDjqj8kvK6yS/nhZPYUli8tD9tXFTvE1HrBYiMdfffSch91xDJWg3R
 s2keP4vEnd8w3pPu3i67lYTnFgEP1aiWnAhuYXuCtkw84l3l2WWE6xvjVp83TeFaIgSh
 P74ckQohkXX9Sp/M5syPbbqJYuM7pMj/0oHjrgcr0v0cDD2DoZ8p1j6TDu6KsDIOsXfP
 rnY/3XBVxHKGDD6uELslt6q9Kpn0P4yMg73lM9lGMXepxSJgUXox3e3l9ol8TqE191sJ
 1u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274724; x=1793879524;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rUWrSWFRRwrzwwP7XR2j308k8VdiOEXOGO7IzPr+ozk=;
 b=YDMBPwO9s7O6HftkYuGDjEI3h3pOi34NWAmm8F/TKJB7qQvR8b6iWt3QrHAiSi/hkc
 VaX6VV0UeimwK4zPgK6KiMMKUvsjf/4asfgaN17jKHmVRBTYqrO9Lqvtf5ebivLCVMpE
 o9gyzF2GtHG6ikEgvaXX/7AC5vfhJlBXmi+BJx6odRuw/ZnseSUKQbQ6I4s5UGOfzNbr
 yHSgR4KI+1Hbf4zcv83CPBgQucOS2DFdLALt5fTmymbbzs8QkilL2lKJNtysjurbxFDw
 C755I+4uSMa7VIVQdXD75d9KEA/6DaLptqauKbavFE4TO8d5Wbatrm4UayP9UQ7nM5Z4
 hTog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMV3t0OrMm0zdZxi9EYeReQYhXbjZd2PpUEAnjC5RLWueyHXW6gqwqxJ+ombC88Uv49hnoryaT6VGd@nongnu.org
X-Gm-Message-State: AFq9FYLxQnEVMWoimQxjwUcQ1NFy2uaY5yoq1Sf8E4IEWEAT3SSxOze8
 vhMblTxqI46wXBjJSkpw075DuGJ3CRUjeJu9bIIySixCVxrHgRqwIPipBn8Fm1zuAF9nR2mHoqy
 XPP9nxsQQv81rTKB/D7qU8WRi+t3yQLmqUzLtBALpjqRgHYqSwxB2VHrLAg==
X-Gm-Gg: AYBFou14G8t0nvJ8hLLArkXcoK2vnmfg5kkjWZCGadkW0qapHcCKWOZe5Uy96WWWuB2
 7iPFeYd1RRDOqPy29s+/ZOD0/y/D9ahcshIa6NN7Qdjki6eIQbeUHdMRXKS7dehJa5uODnnpQSH
 7Qrw1xubomE/CvibVn28JM8ipAWL7bZ4/p/qBH73ky/q1R0ZW86BB3gs0FWgVfpGyPSOZ4N/KIF
 tSTGBiFYdFynAzFyQh1eUXnTSzXcOqixjIkxiWrlziz95JgtoHR7l288OoZqTY0J7D9rm/YgTXi
 O7Uzs3jbUSZrPcBLTiU1S/XXKD47/0mCWOpIWk9mlF6PzJbHc3xe9ti+ScWQCpRHOE27D47rF6b
 YhliedTCP4fIIQUThgsYrYi5PsGB79Vme38H7XTptsWYVESq0Tf0Qs5tWDkSUlj1P1wRqZQofsf
 XKFcBESDoLndEwaHowahavbtE=
X-Received: by 2002:a05:620a:2a03:b0:93f:25c7:a4e1 with SMTP id
 af79cd13be357-94408a5f806mr807364785a.26.1793274723559; 
 Thu, 29 Oct 2026 04:52:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2a03:b0:93f:25c7:a4e1 with SMTP id
 af79cd13be357-94408a5f806mr807360885a.26.1793274723023; 
 Thu, 29 Oct 2026 04:52:03 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm68733605e9.2.2026.10.29.04.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 04:52:02 -0700 (PDT)
Message-ID: <8edbe136-24ea-4066-81e6-b2820b9f3de3@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 12:52:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/loongarch: Replace kvm_cpu_has_msgint() with
 cpu_has_msgint()
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20261029085654.78806-1-maobibo@loongson.cn>
 <20261029085654.78806-2-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261029085654.78806-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae33364 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tdkB5wmZ504VIhczwYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 1Wj4Cw7LwD3mxZAfjwI2dtq_ObE8Iyfb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NiBTYWx0ZWRfX6UcHQHE/HNU7
 G6S06vqorouF9fipcChVnMsKD4fG+ZwXUPm0wnk+3eJgDq7dS+gJuad/OSUAKWZXAxSIHsd7Vg1
 yocmwSLyLCYTbxCYQRibegWhs13z1i8=
X-Proofpoint-GUID: 1Wj4Cw7LwD3mxZAfjwI2dtq_ObE8Iyfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NiBTYWx0ZWRfX1ONy4p+H+K3E
 /mVqFEYgUi4gJ5zMHYb6pQCGjScRg9En62HuP53t7ZhWsz/82jkGSCQNnInG0CBQDo8y5RMbHoY
 aIsD/dt5/Yd4GtwhP/VEA531GV4tsAFcudCeG9FpoebaGS8dfGCSZctyoCzdcNRSPGW5isV2UA8
 /GbPH4xFrrvUWXI1OmRmZb8hXGQ3ovLzqlOLufzKgPFb8valTPmF8TKvWqNJ6npdY1VuZjnud6x
 tUwVvYspjsQXk6y8bdzkoNIGKT596xKohHZh9s6pROA2r3/USgQfD9N1gWp3IGzbRuDcewYTgdh
 bSOftvYyTPw/7kTxNMsXCrnckL4vh1EQlDOgTOH74zlYSVfDvSC+r8Q6aP1bteBSqssb3JtjOz/
 44ZwpZZxLEcK2ueILgEVL8T42AwJ5oEKh89h8OmpXCG+UD1/JlZRlUQaclU5/O+3bN4W4Ew0tQs
 Q04xEOKnY7+SjogJ3Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 09:56, Bibo Mao wrote:
> target/loongarch: Use cpu_has_msgint() and FIELD_EX32 for cpucfg
> 
> cpu_has_msgint() is more generic and can be used in TCG mode, so use it
> instead of the KVM-specific feature check.
> 
> The cpucfg register is 32 bits wide; use FIELD_EX32() rather than
> FIELD_EX64() when extracting its fields.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.h     |  6 ++++++
>   target/loongarch/kvm/kvm.c | 11 ++---------
>   target/loongarch/machine.c |  2 +-
>   3 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

