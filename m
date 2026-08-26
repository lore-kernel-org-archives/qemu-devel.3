Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6BBC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8cA-0003Eg-7B; Wed, 26 Aug 2026 04:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8c8-0003EQ-HY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:04:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8c6-0004BC-VD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:04:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RiDe3783736
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8stbU7coVPFWK5rV5vmHK2x7DwLHot1PC+Kd9m6+rNI=; b=h/JwNaBJ9FcRgU7o
 Upyxufp5H5EhvQPFDnic/vee0iXChuG7uBBMezNbP/3syu4xRzdQkVLvMhJprJvg
 piZaLT0p1IBSWerY+hol1+CZPbHnfOje1m85SanWrckClEK0RSO2uIOXaqcnE8Ub
 LFTOEZM+NT21vnhxWXoZD13v/Ik9A6PmD6o2QkhH1Ps3PJRF9KB6UG8R0znOUuqk
 jrT/JGDou44nl14oJ23YSJGZtGWWA+4ke+Tk4MuPKmEkA18jk+zieJNIuzZxs8F+
 aZSCMfO2wcy24p0iLItXcmrEvTGB6NnVsLP2OI9pPGNgGFK+nkqo+eVGy+5RjgE5
 +egezQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9g8t1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:04:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so9229201cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787731440; x=1788336240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8stbU7coVPFWK5rV5vmHK2x7DwLHot1PC+Kd9m6+rNI=;
 b=Bw2DbJPHjLA/Gt6RK2zeXvUBBtkI6nlTiBsncKWrBa/lVYpIJhIpObO6EO+r+Wt+YX
 1HvPY962bVm5agGFNwqcRTHSErxlHB0C6jbmYKfCs1jlCcfBNCQaukoz73RSeQt1090D
 NntQnO4+NsfEfCkhrVdFNUV0R4784ttpHwAkIU0z3SR/9tAENeNhfCOwFCwhPJbe5STD
 gXOaN9R6QFQiooys2KNUc6SFc0qTShc+QkwQMH57VSFlQ84lWZ6ZNuciidAV/WvgnE3G
 XgtYLVCCsGf0xoQx0U/A2rLLMXsP2HP75njDPzptZHRRDyMaRXld05oQXI5DOyop9yrb
 6+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731440; x=1788336240;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8stbU7coVPFWK5rV5vmHK2x7DwLHot1PC+Kd9m6+rNI=;
 b=J7u5CQRZGDl3ZpgQtHdllpG0tWah/JpnGoG/1V9NMC1JfbLB877uL+2CqPk536AiVK
 cGMuQTgwrkbkA5bx7Xce0u4koaaIGVbkJgTwbw66V1H6vPn2UIwbQRYuBZTzd7iF+jfk
 n/x+lqLBhNEObVD0RLuJ9Hb4GKzjwMjbXCx+P/yA/dwQoE2F5ZRr45qIUuubRSXiDrTq
 obiPkypYSV30/p8kSlLDtGvHPz0aoJK1TSEnoceKeDPJDQb5g8qFzbFvz1c7Y5WdvCSZ
 kjYwFFAaMIOZfCDUs3ft7dk7pOg+OWer9YzUq1dFhQ6W+bKm9XKnULXnd4La4glBp4F5
 xz+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RouX1LbqgCdJw4GNiRpsZhvyW9h6CrO+RxvwmiVMjiYoBfieKqtDFcTZSwcH7Z3oHLT7DrIKHD1bOXG@nongnu.org
X-Gm-Message-State: AFuF++lsLWVemJMZpIPq9zvlTNmPi1cpP6PHd/03X1K+h3a6cLnOUfes
 qTmp7tCrdmSovP3z0N9wp2u1XosDCAxPahYd4H7O2BRQ/2yvum/z2j3tUK2OCe0W+pquvqqPHpv
 mmjZ21YNkQ7OU/PyyRcKkRacvSKXK/0awBPX6csJjo87eyzzL7QXagkhJDA==
X-Gm-Gg: AR+sD10VlcXeq9HQ2wgHhgTMl9u+5IWr+XnuXZ1ar4LIpJzj0hBeTx4RQ7sOXnI7bTw
 7wst9sdgirgBncBuRr7/IqwtKxRZUoB0NezGiTe4cB646ALlWlRnzWBpixGuSdeVDhNzMsgB5QM
 dO6Lii8TYhSWf3cXt1bei920r8aJzVitG4wYNTmlL/bY/g5RTXUeyEjqmZK5ZuECtSoHuQRQg31
 C25s1Kl319Osy77TrMS4AHBc9dZ20tprnCajLZTZFyOZnwG2pdryH17yKo+AodDdEkAj4TCsahM
 qyHVQMwSztvsFPfoh0pzEcGno5vpGKRym5xT4iMJLpsbHN04lB5WQYeebop+QRcSyiLtYMyJW4P
 4xTgskYEyeNtR5Ba1Wg44tDMWzC079OTg4fWHYK3Hgg0=
X-Received: by 2002:ac8:5cce:0:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e423233damr50070131cf.24.1787731440482; 
 Wed, 26 Aug 2026 01:04:00 -0700 (PDT)
X-Received: by 2002:ac8:5cce:0:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e423233damr50069741cf.24.1787731440032; 
 Wed, 26 Aug 2026 01:04:00 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca960d3sm18159035e9.4.2026.08.26.01.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:03:59 -0700 (PDT)
Message-ID: <237baa03-8f31-4be1-946e-b2c9a83dd0e2@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] hw/sd/axiado_sdhci: Add header guard
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-2-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826074635.2850931-2-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DjZMnAtdQScKfo5YMqyQhyPNOjx4C8MO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfX77gAEtqll4j9
 vDfEnR9DX2rTmxoippSor8xNx15A1b1O6Ho8eZ5WqCzAwcvIr+weasBZIhp1mPWiVvWtp4oVx59
 /yt6dCFZZs9RvfZLZECIrjVE1ZtJ+15IJGn/OaZLm4sF4QikNVbDwqhypoHQjmRohrJs3xysXQH
 WDHghCrcrL7K8dj3RFXW4qnE/UfvlhAgqocOt1Zo5thkUBHcqNzB20ZmK1mMvaxmn/Gf4b026tj
 XwMABITfbFfY6UmbZv+zsCsiHUeq8QolEXrtET9D7SPbp9IpbwLNRLe4KPGo8xtY5aFhGO89rhz
 5qaYyppfGuW4hHctGLlCSZSlhTClO7EkaZsWJy+byN3hifQ+c+hK6/+NU1YFNof9TulWJSSz0ZL
 JlGKDBUI7GuS1R91XMZqaA1tPDD/z+23jK0VSCxQZJ5FJhNMA7DUztqM3VW8x49cCTUwliHleoR
 CS1PLAwYW4zJeo3HMKg==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8e9df1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=440cDlBIAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_YfxY8EcIqgA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfXzwKo437zHn30
 4xrpVyOsGw5j/hK+Iu1uCma7/x7mT8+x7ck9jggC373l6fgp5lMJ4BWx7Z6F9PoV6i9JF7MXZYd
 afrJhlsN9u8fev2nMTwRsTISe9u8ct0=
X-Proofpoint-ORIG-GUID: DjZMnAtdQScKfo5YMqyQhyPNOjx4C8MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 26/8/26 09:46, Kuan-Jui Chiu wrote:
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Reviewed-by: Jack Wang <163wangjack@gmail.com>
> ---
>   include/hw/sd/axiado_sdhci.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

