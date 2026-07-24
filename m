Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A685C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9Hm-0003Og-S5; Fri, 24 Jul 2026 02:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9Hk-0003OH-O6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:21:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9Hi-0001NZ-TJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:21:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4l9EB3139468
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hc65AQfaTqFXdqmrKBgkjBdMdAgzM5w/Qxcp3RAW/iM=; b=V7wz/jkIza7hfPKS
 VoR2C2rx37a8i0IkBzMf9ZZnwMiAPrD6x/Ko0U4aYjPa25FD12JnAbfyX6FltJTw
 7fjUSJeVmcLumOeT7PuvwJBYsEnoUX75v0HK89Z9Flhhfqz3+sXDU6l/9/juCjSN
 G4DYNpNhhCSLsj3U7OgKxGvC2lVjhr7DOhFLFn3DGX3gQ8MJs6GOsBes8u5VdR6I
 M9g35n8bCqDsilBB6j+WGUAF4ZSYYaT/e39Wy3cIs+WalooLPm50NMTHW+HvHWtd
 /DMZdPA2lEdSfbl0KJqdniBLXFdmQmcdnbHo1mrWqCxQI/CodwCy7qPiRKID+cvP
 7HCa3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkn9a33pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:21:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so1094221cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784874076; x=1785478876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hc65AQfaTqFXdqmrKBgkjBdMdAgzM5w/Qxcp3RAW/iM=;
 b=PadjB8PyguoKOGe76pPtLP7vTBvd2PY336T0OSWLgAVpK0adlkrGnMGueqH1EjefOt
 EenlTQI+J1kBn6f3R8oOMzvnmDquTr8OGUY5NZK/EGuM2olHQzACCLQ4eWWFngOnNP6P
 nDuhg72xzUjOCPqMQDKn+RhknQHa7QkvtSawRmGXImVr09GMgcgprEHtJ/MkmaisJINt
 mb2Efc4i7rd7YpmnW33DhdJuFTYvEIRILtEVzyfuKkVVoW5tM6zh8FitoEDpjd5shRru
 otej81d5S+dK9r1LGrjob5OOTLTibolObFE8XuWPUNyeEjNLHfaizE5DIKnUJWzZ/aAi
 Zvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784874076; x=1785478876;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hc65AQfaTqFXdqmrKBgkjBdMdAgzM5w/Qxcp3RAW/iM=;
 b=g+05udjp4hoRuNS5EL4IfOau9/WwlzjMnN+CXMWklBunxdUUjagJyBRa+lITOoOXKF
 +1oqNLhOgugJClX+Bt4Wx6C6iVG+Nm/jdeN0P6i2C6vRr6yxJTDOImyG5VfQKRPsGuIt
 nKUv7jCshbg5EKhM0arDGP0iwoPrMiyI+70enVeM8QeKW6qU7YHwBZCi+rs5BxlDIWTE
 J24W9Kh6Cfg5TITsA3bpOrvN4RGqtszEfNVuJ/4Udv7PlmMkQ1jzpxoswSJL9C4qw6kL
 2sIqB+4dyiBcDV0WTakPeM3igeSwXilAjR3Qt2wTFXEFoqVE8763hzG2wQQocD6viWHJ
 3mwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpJm5QFc7iOBTUu9PPQXcwv3PXwEnBOMnoY4hcG5Su0sT7yISGZfFyA+aO12G14W8OqK8sApGBUuRR@nongnu.org
X-Gm-Message-State: AOJu0YwWh/he952IwCIMFYn17O/AhJG85r2RmSt//wvND2ysTgJFzg/N
 8dl0PXCo23IJoo7IoLJ1S56PMaTmdkya+zSWROlPWvTz44GhdOkay4OrZA5CgvJepbAMtdWOFoz
 SWHmeFWHu1rPloIa8W8IRjHIjqS82XAxXZcqPXdeazdVGEHowcLrwCAtUZQ==
X-Gm-Gg: AR+sD12KbE0ESu+6se8SY9JuUG/3eZwhTp06ZT4EGA70m/o9+wngmoG7XviJQW1a559
 2JOudX9ui8xexx/DNMIzBgRCFw8wz95wHnkdlOxOFuJmnJoM1HullRFeuS4vUQI4BtiwPVbbRND
 XiYBt3tleLSPz2xNCeQgy13YH+trxhvihSb30jSDycV14lsESvEBAO9QH+JXCO6ciNDfhXbdIAO
 D3mL60FvjuC/L+S95NiREyiL4O/Z8GkRthT28VIvkP8salKEdWej/KqFirIeCw5pGbGeHInvgYB
 wMZ1br77cDMfjFPI25eOi215w5+Pgfe7LqstKH7j9uTTZrvY17iEiGqIp8QeTjFq9BgjWz579HG
 7P6F0qCmvVAFK7dyWCKpKo4BJjWI=
X-Received: by 2002:a05:622a:283:b0:51c:1408:6c13 with SMTP id
 d75a77b69052e-5283def0605mr56266411cf.44.1784874075950; 
 Thu, 23 Jul 2026 23:21:15 -0700 (PDT)
X-Received: by 2002:a05:622a:283:b0:51c:1408:6c13 with SMTP id
 d75a77b69052e-5283def0605mr56266191cf.44.1784874075464; 
 Thu, 23 Jul 2026 23:21:15 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm22306900f8f.37.2026.07.23.23.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:21:14 -0700 (PDT)
Message-ID: <e310e5d1-8419-4087-a967-68f806c67fa9@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NSBTYWx0ZWRfX6xLLzghSTw/y
 WHK1in73Pk268SsW/mnbCQTlzzf3RdX94R3lYCrDgtaBt/7hnnDA6uUjBSJnXeYr4gtx2EWkl3z
 Jubd37DE8HMHQyABrDY36HJufdip4PvAsDUHnD0dRY+BRGMF9MAjqG9iNqXwK6QJwXEZl/KJsis
 sxyoOn9ytvLXRwtH2V1RdmH3wHEnhREUQ8hxDwp3lW/sg9wIk97a8uwKRTx4rfTuXUZF0juiexQ
 RU2ZAG5MCHQ7R5/Wp+ILv16sRBzS85nG/8EaYfIb7SSFwCSe/ufuhZLMlRN5VPzEQN7mfk1P0RN
 mQ4luX5ufNT77DEVOut60fLdjRYKOXqRwj32Dxux+yMq25hHKOpcHm3A0hNXlnGAfA6YnRpA9Yz
 zsyqus1X/9lDb0sKIvFZUzF9nDWUWkE+GElw8lZJ12mQdLCwZs7Pf8yDPk+wp5EEZfbea6qpmiL
 ETmkbUXOTPHgUHvDGUA==
X-Proofpoint-ORIG-GUID: 4yCEtZ5HsiudI4XZ35Sk-1MmyfIEW4iv
X-Proofpoint-GUID: 4yCEtZ5HsiudI4XZ35Sk-1MmyfIEW4iv
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a63045d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NSBTYWx0ZWRfX2RJlU89XEy94
 d86jbmYN57sbYAXZhHS0ME2+TnhrxQaq5XuNPWNH/t4yVTKdmdLPm8g9Jn1AqgkzQpAOo3Pa+lu
 gnudReq9ox4SC1E/wqa2rNHWEXQGKAo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240055
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

On 24/7/26 02:09, Pierrick Bouvier wrote:
> In the next commits, We'll replace the logic to filter QOM types per
> target from a static one (based on INTERFACES) to a runtime one, based
> on is_available() function, that can be overriden per class.
> 
> Introduce the new interface we'll use for that.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>   target-info-qom.c              |  5 +++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> index 91be415ed33..83eb537333b 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -14,6 +14,21 @@
>   
>   #define TYPE_TARGET_INFO "target-info"
>   
> +#define TYPE_TARGET_SPECIFIC "target-specific"
> +
> +typedef struct TargetSpecific TargetSpecific;
> +
> +typedef struct TargetSpecificClass {
> +    InterfaceClass parent_class;
> +
> +    bool (*is_available)(void);

Hopefully we won't have to call this with heterogeneous machines.
Otherwise we might have to add another helper:

        bool (*is_available_ti)(const TargetInfo *ti);

> +} TargetSpecificClass;
> +
> +#define TARGET_SPECIFIC(obj) \
> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
> +                       TYPE_TARGET_SPECIFIC)
> +
>   typedef struct TargetInfoQom {
>       Object parent_obj;
>   } TargetInfoQom;
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


