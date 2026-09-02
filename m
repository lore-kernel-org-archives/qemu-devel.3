Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0638FC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sCE-0000Dy-Gb; Wed, 02 Sep 2026 17:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sCC-0000D4-M9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:08:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sCB-0000sT-6V
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:08:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHANn1382952
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xDOXBJRCpioABg/gSrevrqRCavymnxSozJuNhjdgD68=; b=VlZDTiCMD9Dhd1wv
 Mgeef8EyrkM5aoZlsuKoXSpDM5U+dG0dDBAt31yE/V7+6PZXSRwcqdLSscoum77N
 GS/L79UZJnvH0ix+6j4/cbRxyNFwpl6VTWFJ0r4Wef9FwkOPJ0dLcEPQf3VQS2Ft
 GT3/6YWGDa9djX8/U4fxx0OM1O6ydIYWgiCTs7qxIx/KmwPuzyMfwjBEiVVl4whN
 iI360OF21FarDJGw8++GLSHGoa1T+lXtrTl7bvu38qgDQjxfvYllZPmiE27tvFYM
 ugoJTWF6z9XaBk0iGmSbQOhlRJ/CT/dpeig5zAceac/Vi7uA5js6+3G9sBDGBJvA
 cre8Ug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja22tj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:08:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9382f9430deso310445585a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788383311; x=1788988111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDOXBJRCpioABg/gSrevrqRCavymnxSozJuNhjdgD68=;
 b=hs9yCcBKLRbzoPFAZN510gW225oFTf8UcjbZ1Zx6zu+AeUn9B2XDHqBbnqI+ullgc4
 /lUoFzTwRRiQE1vKVD/DhSj+alMYsutmJ1M2Cs/wHrd7S9N26jTJpcCPJYKS4y4TkHha
 4JhicZ/3szhkBRmRRa05wpsc9H+iooxitDb9pNAukPXG/EbTF8OFKX7IuPUnoI40XxeD
 ugaAoo2o5QxiINqUuU6DL6MaMwaC2luIS1v73wQCM2GSu51BD5d/v/hbvHbbmU3E1C4Q
 tMquuONWH5K9nLrK7cD7jLVKsa+E33I7LmvO4GLCRHHwmS2zl6fLUNYBNQ3El8UHSQNr
 Tjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788383311; x=1788988111;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xDOXBJRCpioABg/gSrevrqRCavymnxSozJuNhjdgD68=;
 b=IZQbUqeSccFqGVnnGzu+ymDUqeNbY72PnxRTSHs2HBnJoqt9jdD4myKrxM2pzlOT5x
 1rztgarX1/KMRqLVTA352VJJPiS0CZGJLXRibSqOrb47PbeVtpoJO28wIRWNcF+MMZ/p
 HV3QTBF0p6Xjvz98fWZzUR1f1qxppwkAOUZfLuoqpb5beQdHTxXL7GqFnOesAuZ4IMt7
 aaObuPLkRp78Fvz43IcrzRB/MIE9dxlghCzjw6a/7OnZtI5g4/VZh4j27VRjnbET5Kwo
 iJ6qwM4Vuh3irFzOlL6IxUzuTDg5HjKJBhf1SPqPP66x6qczMjrLcHnJ/NCYoUtOjjqk
 fHMw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuHZTZ1mRc8s+hxRAg18VfSFLKnp9/Ntc2lzVnkuSmvslpPToOibKRjV/dLQ9bOiFOytMvMvvTTuH+@nongnu.org
X-Gm-Message-State: AFuF++kr3luLy8dAOzlUmrTsWM8kzW0sKFAjmkUMbSvxVFiJ6im1mrMQ
 YwDBgH//dPWr7/EWSiLpJf43KSrZ8H5mCs4Y8y9pe1xAR+fkwnzfgrhjbq1zEOVQHPL46UwSIo1
 t1XF+aZZv73JCPrx/eLAg1tAISIO4eussshm42Fp79hU5Ma7kKZHeZC8r3A==
X-Gm-Gg: AYBFou1fO3hkHJlcpAUTGIvZt0xiLmCA/K08WuzxeLMQH+MO1siHnrLIp7IumsgMAt/
 eMM6BYa6KCBN/Sl4q2428O0cK7dTmFLpb6Ukk62LKrEhgt1QCWtqqIum5kistPulRvnY1czSpPz
 j8Gt4+DwaUOIs5zr3+4WcTkbRFN6Un8CCY1n0FpBqXNfeGjixBwE4trFiDsjq5AKrMxm5dEhS8V
 K1YObbg32QJb9Q5uU95UPZ+IV/apkX/c2uxeN8nFSt/pXXZ8KAu5GyK3FPxKppbtFETymIxzyju
 Xg7KwfWXb2HFfwNhP5T0E/pugOm6uXa81kv1g4v6gWgWm2hHis6ATGwEvraGaG4EMVnqsfscBr2
 SCA0DnF3kRhnaRIqy9zONzXCFwx2AsxOJXg==
X-Received: by 2002:a05:620a:2803:b0:939:4a2a:51ad with SMTP id
 af79cd13be357-93960fd3bc7mr1047918785a.38.1788383311104; 
 Wed, 02 Sep 2026 14:08:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2803:b0:939:4a2a:51ad with SMTP id
 af79cd13be357-93960fd3bc7mr1047912585a.38.1788383310704; 
 Wed, 02 Sep 2026 14:08:30 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d9c6sm18768295e9.11.2026.09.02.14.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:08:29 -0700 (PDT)
Message-ID: <785b633f-5761-4844-8cb3-84fb31336835@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] hw/i386/pc.c: convert pcspk-audiodev object prop
 to a class prop
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 marcandre.lureau@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
 <20260902144207.2553037-5-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260902144207.2553037-5-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dr-6CoKSGN6C_OvnZA30WCKH4zIPcMD0
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a989050 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=AqYkckc_seYA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfX6Ut1lu7jrn27
 a+hS6VGhNzD4WTG4o+KcRDwLxcsw14y9FDaGhPslvF7q4ukQ6O5H3s1Uyx9voSQbw5rM+0m23vr
 +Tt03YGQqdkqBGCEdFrUGAUGbp21JNc=
X-Proofpoint-ORIG-GUID: Dr-6CoKSGN6C_OvnZA30WCKH4zIPcMD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfX20Bc5sTJQ6Ik
 fdU06m0drb3QU5xq7G5VFM72CYJ8SYB0tTw/TEPodkzpu7qVB6GoBsvTo3YeD6PLelgLDHrg3hS
 DGQAqCXP+AUlp00PzEu04s6xCTNCGiDS77kAZIHGcQh1cTtMjI971YqpsJWzdqojIwrhtUjsuhd
 cMQ63tOsC5a8PmEXE8t+uiLO3hUBdCl7yqcU/piMS+PRLEOBW52vG16CFM5iMm20itdi5wBB83D
 KDTYUIKe/3oZcOzzoCzmy+LclABgZIXhqSzcew5ulamDkhK1TnhryglLHptOZHrAB3fsvv+0++x
 bUeSckPinDtpv4IcO4O5gPSsCWToOZMAFyzYOt541B5+qpjIdlNRk5XJOcYHx2d7jj2E+iTVuEM
 deDJniXc/DLWPCUQLsGr5qAP7m0NL0bi1GfM9I3Pk3lQ//7ELtE4veFNcNvlDdI9Y/WjfdzTWLb
 lTAtc566BXK0ZeWCZzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020187
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

On 2/9/26 16:40, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/i386/pc.h | 2 ++
>   hw/i386/pc.c         | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

