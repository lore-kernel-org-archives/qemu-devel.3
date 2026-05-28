Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA35BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgH4-0004Zn-L4; Thu, 28 May 2026 15:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgH2-0004V7-6Y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:20:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgH0-0007dO-Bu
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:20:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHNpoP3203243
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VMvyRP4MTdBnKvWRacxFGVybBpoKF4ApF1rAKssPg78=; b=jTEj2y23Pc+Exx4y
 XeDiFgg2j7dv2VXQNEN1683gk8B32MR7a6sn0DNU+UR3x4MEWl99QOL6a+JqQBYl
 qYBlm8jOsMPmHc+dtQnPap66eF2YECG3XLMGtl/oftFaDzhg0yBI4P41TJaANoaW
 0J9VFD7zA04+GkugCzsu1tNtnp6+Hh2470hDCVPvtzPoc8+Zn+0QsbvA3zr4htkU
 sfm83uT8VZ7vPzwBb8HyXjSxVuFXLNN1ImZ+DD8CLTjg66tJr9he+yFQRsyYOksX
 5FtpH087dvY1esEDAMAmRbV14KvHyPJpXolL+LIS88tQFi0RdzzPRjvEzNfILti6
 J9FYwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynmfa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:20:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304bbf2423cso2536429eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996003; x=1780600803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMvyRP4MTdBnKvWRacxFGVybBpoKF4ApF1rAKssPg78=;
 b=cyenTNnUVjre2PPz9lRLj1fVJEV7/vEqZjpYTiZhf1iYm+eL6uvSvhLT6GN+nzTZxZ
 HSUXqjLhbMkBKshVhg8GsrTiMBO3kJ3fB2ua1LA797yc3qaOgiJxvQ2JGfaQCKhBVj0t
 XRTHlNJPvYpQAyPzQgajvEwjtslo/+3+l1XwLiogCZ5SWzCDWobayxQqtsUHHbeoylcf
 G8HZIz8fwCMlOC7+LEbo59mhHpcqG+beaqYDSt2+WJgwN1Fn7BrxEhKdTKfIleU2/nii
 Gip+j4g0oW1u2Zf6xOegVxAIq09xZf25agISbaV1ToDocOBUypI6QrIylXKu9VFGUuGE
 doBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996003; x=1780600803;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VMvyRP4MTdBnKvWRacxFGVybBpoKF4ApF1rAKssPg78=;
 b=MKuGem8U3iuSuUqV3NsOjUrrpirrXYibMus0GAUu9Wk2V8UPWstwwAFN4EapweyZ9B
 kLw7FoH9S7u+PX0Q5TynWWdkg1Gwvg90zSCtaDPMrRyQNm3SjvFTS8tGPGllYI58iwsq
 AKr/atFcp21aRhYMOq/1gwhM4g1K+6hRKsIA+Psy+DHzpt/uFWP9+HUx0VZkASq8pJ96
 L3uI7lVHjmsNXfQCguVrek9vY0b5rLOwWxndfyqP/ksNBe+iZe17s9LGnC23Sr1q81fq
 kTx3++7U02T5io2tS7zYS7d5ujX+7+swWTko4Wd9K7jK8B2OctOsRwru2wF75+BUyRES
 qgHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mi8LII4BKOExBLvUc4AlAubnD7oWvzQuU2tFVtKIxc8hcmnb7M3W7iRR+Zhnmv3FBhar2Cf/qpidv@nongnu.org
X-Gm-Message-State: AOJu0Yw4fJs7Wh3Czcy5ngu8ii/rk8gJuBByDIDxiQbGsnI+ekP+D5Sj
 6epeOyOENFfCuj2gGBg53y8agxLx6uqQT3Jb6BXC0TDXNIoTZ1idfwSBCraKlv/6I3O6sNhIrTD
 ifZCJJ/cX1ggL95u9fpnGDuAlRNICu3GcbIOKhjiLptTUgLoJtlAPEgpWtcvv5bSjUSRY
X-Gm-Gg: Acq92OGcL7tSioCR8a3XF3G0Ru+ssYUkSOviAQZW0vMOpwnP4Sd9bU49jtq5aKhR9LP
 URfVRx+WZGw2G96gKAe4If8Bc8Cyw9CvhMBc+URrTl/JwZI+5z+zY4rVEOKHZ/Z2VySI0WHKnrX
 +U4XKodV5OZXuMZnnpLPvpzc4dGLFcVnXCKP7Z+wkaaqr5ZLBH07WYZkRfr6J4J9F19CDEsPqZX
 W13G0QXSCfFt4xi3gT2a/oMjJ5VZxqu9QFx01qXfF/lE0kcFKWSbBsm8Rkc4ZeiXWGnjrNJ63j6
 D5wK/Bcwnf1UeLWfnASDeIwEGAQGNSVcwWTP8dzsc5ahIwz/B1BYrz18Rl5vmIfL0KzhDQkbysO
 6A4QwGHMPWrhdSmQArg10+G5aDudOZpeVjDsSO5cnaORzdhm9lTqWktWNY0cptlH+hcSZDY/A+L
 ljpu42a5hmmNArxviYiaFrB1t3
X-Received: by 2002:a05:7300:2142:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-304e9405226mr136229eec.32.1779996002968; 
 Thu, 28 May 2026 12:20:02 -0700 (PDT)
X-Received: by 2002:a05:7300:2142:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-304e9405226mr136199eec.32.1779996002350; 
 Thu, 28 May 2026 12:20:02 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e973c26esm106371eec.11.2026.05.28.12.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:20:01 -0700 (PDT)
Message-ID: <ef09c1f4-5e8c-4ced-9a5b-feedb07ea7d2@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:20:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/12] target/riscv: De-indent some code in
 get_physical_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NCBTYWx0ZWRfX4hGMFUREbq8Q
 yQhfY1gA52mRrWARSJ6Bh0MFYX0+UVs/GwFvvWsTqSa2laya08vsrcUJDKzTAQ8n8mHM8stkTQn
 c/ulpZsOUpLHHBukp/BvHAyxvdruiq7pPqwpQS1GH8N8cgIyF0UXeVnkwHpb/XXxkBFcuNJwHPm
 YoxMpi/+Q81z/Yvc6S2llmz6a5exjknXXvZrrrxOjgwDoOFwSgBIJFvxeSjioYUghsm7eOpaThz
 peFIY3cKk/w97tAcMXhAA3lYlyxHA28S8LuxonbHkqWYATPpNUBjRR6Mk598xiBEvy8RrfynSRB
 ie2gH8u9ASDD4rM0zji6ZOFyv8AlxDKunp5RlEPc1tOF8V/fimpf4vtvxpVn5UKVmTLJ5YPHHoN
 m+D7B5+F5m0POy4YTiUamVTNZrHeaar2NTRaxvVC9RAvbJfPyWa/Dl8EGx0RXnnEgHmTAFWm1z3
 bIZksacliEC3zf8Jjug==
X-Proofpoint-ORIG-GUID: AKk8y_NoMIR85A3WEgON_B-y4w1YV22i
X-Proofpoint-GUID: AKk8y_NoMIR85A3WEgON_B-y4w1YV22i
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a189563 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0mYzyVw72CmaQtKscwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280194
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> get_physical_address() is quite complex already. In order
> to make the two next commits simplers, de-indent one if()
> ladder. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

