Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D691ACD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV9vh-0004ns-Hg; Thu, 04 Jun 2026 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV9vf-0004nY-RI
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:24:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV9vd-0002Ct-Qa
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:24:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Eg8q31132195
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 15:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z34VMBSkLAda0waCFv/8ApCrQvwxHud//PoDFeggOIU=; b=pRr5J4Q5SsK28IC5
 Pw495jH29DbEgf3tHdfxpTUbkBjd8i6afVfiaR6jddLoFvW/4Qi8WoOMa3EzbEqb
 b6Rn1kNUHWQNO3h+Txl4pisZDRo9IvLh2SozvwqBmyHnJuIAFdOiG1iKVi9QO/9y
 STUNIJT4Lxquto+l9rBIkTZMah4me6yD7NU6CwQqBxsWQLtGvw2PsjigNBYY6W2v
 /Re4b3CMHHqEHLGFEoHjNl/OdCFV7bs0D45YvRl89BylrvaQG89TP5egyPqwlYgL
 3PWs4l87mzVaVBKp1RRdWa5sIBKUBhaafJO41reh9G/eVUYRrJ9UEN9sznEfZZnp
 0wgoFQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wshnrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 15:24:15 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137d003cf09so243662c88.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780586654; x=1781191454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z34VMBSkLAda0waCFv/8ApCrQvwxHud//PoDFeggOIU=;
 b=bHvY70NkyHxaPJrk+fFQdg1Bcsm2yCy7zxeB2QWWnni9cfBm51L+08RCTgYHKJM0LM
 VOEYbxX8OcqohxUhrtpPJyZM0IuhjsEzGE+loDUfp9IE6LnqwDEnmKt1rRdnysLA0eg/
 yhOX/1DmbHX7jFY2bxpzL4QDCP/fdEZKuqvUPgH86V2T/u4y8TUP1r+GSKo39a/Dl56B
 PG/4c0bcL+WtRg5U1A4r2dB5H3e6MXiySdsv+u+zAoOw5sNfxS1UHqcZvt7FrZmGJ2LB
 NtSrQckEDR3xMsYg3kjMYtuShMPXKRPRBnsjzqUaCaWzUCZOk4v2byl9HyQ9snHffkYY
 XwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780586654; x=1781191454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z34VMBSkLAda0waCFv/8ApCrQvwxHud//PoDFeggOIU=;
 b=OVziA5yfdh1wb57p6OoOTUF0BZ0Eqyur0CzK7xVcggru0W4vNDzdknYAVhBBDOLEip
 WlhLiAAb0ZJhLErVS+vuRYV6esWw+0gkAl6u/Dza/pgIJokw3eC1V5N3rA3eAutDjOzV
 OhQuWVftz8cAtZBEVV+OXOwm1g2Jm65iqHiuIsvZej+ffS6v9e4G82Hclj3t4rsR+UIJ
 qKKEN5J7sh30qpHdNpQrBO4+SJxdooVPsJdiaOtuK2230KV8s3ahbCDgzYEnfA2hBD1B
 PsdquQWJXJrpUxyf5t+c5sbAI4amxpu7bLjUk49eUb4T6j5PDoTld6L24Ksxz/R1JOpr
 O/0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r9GoPjVST1JlkjvpR8g5K8OKchse2fMA0mvdOGJcf/yURxKBfKXtfY/LIEXMakNBcASMXdGxG78jA@nongnu.org
X-Gm-Message-State: AOJu0YyQNcucJN3L1hPbMwEXZNOeGQ4nw9NSup8Pcf1P/H116BO9jCNa
 t316YOEClXFSK860bGTZG63Vwz+aspPitMQ3kzpBa32NplmtMWbdTa5ST7jp371CYxTGt7EkSRy
 AfNmEkDdqEXZsNo0NYDFmd7Ps9CCYo3vL5JQcWE61v9/Q5XNwgTEx404J6Q==
X-Gm-Gg: Acq92OEOkgYcuUBEIVeBdPJoAgXQWBccjqOC5a/+3JgAtKsNJVCmP/R71Ra0Bi/GGNE
 HaZIUVxf5ciqAFFL6QE+xOKWMYApnQq7HPVzhUfmRQh96HKu4Ji0q/jbPGoEer/DHR7TFCCeIkg
 rn+H6Rpc112yQy+ykvh42nH5SdtRCCg5hsGfxwHyADuBRmhqGlBIerC2clVwu9rkZXsrqdkh7oK
 NVm/n6xup6IK/bXRwX8h+MhPeICmaM9Z1ibhM6ivwosI4t5TaHyBLBkdrCToLLh10CJ1nXd4h6w
 9eFT+wUBmNd3zk6pEEnMrAARcWaig6pSWakESo2lKJf06w7xkC7h4S8Q/opbmUuiL1kfPjjHZhd
 Ro5BON0QBvHg5wtZHT2BVXCC4Fb1+J2ARxkCAQUjhKVyf1p2I5ASGEqSp3DkdVFc70D2ddX0n/y
 u+IbpzegSqPDD63g==
X-Received: by 2002:a05:7022:252a:b0:138:11a:36f with SMTP id
 a92af1059eb24-138011a0788mr1109316c88.1.1780586654484; 
 Thu, 04 Jun 2026 08:24:14 -0700 (PDT)
X-Received: by 2002:a05:7022:252a:b0:138:11a:36f with SMTP id
 a92af1059eb24-138011a0788mr1109297c88.1.1780586653946; 
 Thu, 04 Jun 2026 08:24:13 -0700 (PDT)
Received: from [10.110.73.124] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539035sm4098149c88.11.2026.06.04.08.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 08:24:13 -0700 (PDT)
Message-ID: <3a076897-ee9f-4422-8daf-ea44223eab59@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 08:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, jamin_lin@aspeedtech.com,
 komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
 <4696cf03-08ad-4de4-b782-4d5c253b2cef@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <4696cf03-08ad-4de4-b782-4d5c253b2cef@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2sryLdoOK7Sc0fP5ug4XwwYFc4-fFYsw
X-Proofpoint-ORIG-GUID: 2sryLdoOK7Sc0fP5ug4XwwYFc4-fFYsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1MCBTYWx0ZWRfX+6lP2JM8j1wP
 Y5Mr0UGobw+xgkoXD7Vxj55kvJPSQRJe5bq1LWGSQ3wif3XHEmtMmkY7a1W1Pb1pBj+CW3ompW3
 UEK2CntR1m00qwp+VJi7DCWVLxVRP9PeFGGzj1mOg85Op3pB3QZMb76mm7Ibtw5nf0q3bIZ+tem
 gSJngj5qZEwe+4JrH/hv8xGHRX34oTyNM8fwXUouqb9fJn0sKLH/sqXhAcuIhGsFVy8Yow61nmB
 wyMX92i1PoJhNLylgB1rD1d4lU2Ac9cB0tW99Yos3wH4pVrN7P2oPrGpSCEDAH4R23K6p44cjOu
 DvJAwN3t1JzhTBkf5+/rbEDjElE2IVjCigq4EEYTn4lIsJQmb+T4TX8xPYGfR0whec3DaRgoZ+G
 X2+Y2rG2EcRF1F3pG2bCrF3OrtpkzbJG2MZNNA5PebHuowmqe9gLEKJytA2B3SUEyQRn5SbkqbE
 PwA+VBNvzvuh8iU9S7w==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a21989f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=m7QrvvxiKC36mP_aVbMA:9 a=PRpDppDLrCsA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040150
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 6/4/2026 1:28 AM, Cédric Le Goater wrote:
> On 6/4/26 02:07, Jithu Joseph wrote:
>> This series corrects the DesignWare I3C controller's advertised CMD/data
>> FIFO depths and cleans up the misleading queue-capacity field names that
>> made the bug easy to overlook.
>>

...
> 
> 
> Jithu,
> 
> When you sent this v2, you did as a thread reply to :
> 
>   https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/   
> 
> This confuses the b4 tool and, in consequence, Jamin's Reviewed-by
> is not collected it seems.

Sorry Cédric that it broke your MAINTAINER flow ... 
(I used to follow similar threading while sending newer revisions in LKML a while back) 

> 
> Can you please resend as new thread ? If you can can collect Jamin's
> Reviewed-by trailers it would be nice.

I just sent out v3 with Jaimin's tag here
https://lore.kernel.org/qemu-devel/20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com/

Thanks
Jithu

