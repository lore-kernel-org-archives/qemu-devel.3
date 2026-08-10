Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09498C5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtGPA-0006i1-Qy; Sun, 09 Aug 2026 23:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGP5-0006hQ-5w
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:10:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGP2-0006x9-VT
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 23:10:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LFArs765338
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Nm7Dxp0A1e6S3+mvBaAnePaSC1yCnSMJMGNoqyi5z4=; b=BVbDaryXPafgWsoC
 WNqbnK1MFtsJXPrKNG9omUGszmB9F7EdOtoXK/XrmSFVVki/FZn37XUetYpCy9fc
 ciuE3AjWtDoYqzK1XmAbJJxr7pnMkhDBihczTYtDjmdJZPF9v1qgdg2o6PQkPV0j
 +aLealvZdldU8jZUcMtzqBSHI35cmGgKXE9D2ccY2vZguIb0qVW1K4SfE0wYhUAo
 ClF3NYoy/OKgnHwuHTivQu0pXWno+3eGqXIUCbXGflxoQVZD5C7iwZgIIrDChBA0
 H2KM3btg9IR5uG/3oDWnufFR0YWeip9/pRwsi1HxxMZIEIW4F5WWkB1vGEyTZ19Y
 AYCeTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy19kgkk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:10:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso15647971cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786331414; x=1786936214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Nm7Dxp0A1e6S3+mvBaAnePaSC1yCnSMJMGNoqyi5z4=;
 b=Ke9dVQNBOsHUADLw+Wb+SZxTvbFO68bIe2cBmcCw2Clrblj2KxJuDPMNGjiu41tOJG
 FodQmpdrimJ+H20fEAI40euCRmrbbxWSeDrYjGewYelkU4ZX0yhh/wrTWAwjtORYfQfy
 AOWfLXmUxCfLXJOWeoQPEm70cYKKfX6bm0bUIyKCN2+xDOfeiOL9FEkaXxGkYXleyGx6
 vTDT61RtfNyv2gxroQZVAfOGaP7q29DiL1FLDMd095Df+xfQVhdSmQvcM7CkTrg11JWA
 R2s7pucHDhCMErp5KBy2k4vQ35XLcwMerpRv//ltym6MrIZGqRATujbko5nFj9SW4VTQ
 mKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786331414; x=1786936214;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Nm7Dxp0A1e6S3+mvBaAnePaSC1yCnSMJMGNoqyi5z4=;
 b=fWJMBvuErQ8eFIE8x89UDq4K0Yz75gfn3m5OUEi4h3uayBrc4/eJ89SO7unMYy7y/J
 admRwWXPyhSh5/tc9E5jDMJW+QHS+SCzd4WrIr+Np1D8Iz+e/vcOipQjCQ/O9BLC+OHw
 vjNOW9vS+inAinXeZWre5+yRFQserGNbR5lAtAJmUhe3K7RJ5wokBm3t29WrwPLIlBwP
 JYDJzho14gYxptdA/lvIXqi7Z1VCoMnuFplD6TR04x3Xxar5h/ot2ytZiS2irAi5rawn
 RxActv460QTSc6s/OHhMd++KxsZ7i/YQEZARoa7hS8kHY79qppu1v8OzZW3BqC3Jitai
 CQ1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp60g7jEszCUfpieJIaOnyc3f4MrtYuPIdSZv52bHyvyPs03/c2BGbW7znh5ui3rekECNwXQQBWal7t@nongnu.org
X-Gm-Message-State: AOJu0YzT1xb1gqokeFjzIdT8+0yOi1m5SRaO81mgM7b5cg6KIe7d9R4B
 RGPWbH966eZTseiyN7RmuvGaKKy38jXJ3YG3a6TTZ2qqO4s5ihOeMsZ9uMDorOHKuIw/6FUElLl
 vFSdJoJlThzDrCcIOLBcIQ18/l55sr/eC/t3qCUZ7Bxq5JE8Y8wovsPohHw==
X-Gm-Gg: AR+sD13qMtjB0o0FL+fWw0qdjOI9FVdGCtYHXk//wvMixJdgz0AZVSbbTD9NRs0NuQG
 tx28ksMighi73eok2o4Yqu8JEcJo8E1rnrihO57cvN8a0ODfPPY9Hg77CQJYJYD3uoJtZ4qtrR8
 KcsKNS5qgVyOckk2k4kUwZSg2gZgRluecbX+4Je3VqmMsl9Br/DpdwkgzPjYzxbmxzHD3UqMEfj
 6SMxgHBI/q+IPMRLDTiZwJu6M0r2EXyxjQwUsNY1Nvnc6djCMUv8XNtyKwJEuW7N8ea+NgPhJ6W
 HXUbvJET2zDlde0sVZ4fVTeFyD4GO8A9RWJKNdZwad1G780riPtV4TlLUUe9gVsDGPUA9YAoZKB
 irBy38m5Mnxzokx+aXVDqHCSJo5D+hvYZPEQ=
X-Received: by 2002:a05:622a:1a99:b0:51c:1a9b:fa0b with SMTP id
 d75a77b69052e-52ce5fa51b7mr430586461cf.10.1786331414082; 
 Sun, 09 Aug 2026 20:10:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51c:1a9b:fa0b with SMTP id
 d75a77b69052e-52ce5fa51b7mr430586191cf.10.1786331413688; 
 Sun, 09 Aug 2026 20:10:13 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995d8737d3sm146559975e9.4.2026.08.09.20.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 20:10:13 -0700 (PDT)
Message-ID: <27d23dea-ccca-4d1f-a104-68361a4022f7@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 05:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: use ESA_FEATURE_ALIGN64_MASK
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260807131912.2608661-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260807131912.2608661-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8_n-en5y0r98Ns1AK64gWj_OZA6EkKeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX8i1wFrDM7jfK
 +n0xK+QN1f9yBtcH6xk0ITjECuHeWgGkI/+94Z4bU6oX555hMqj+bn5Qo1cGn94YSZFPelspxZB
 X9Enm38uizKCttgZB/2QwhI2kQrmjgcJUhLDUSpCddMfrOaZJ63Q/JAfj/EP0V9c/Im1h8P0EjC
 FXKMai/P/z5BaAi8P1N0ZyKlMhAf6Eh0KjGfX19ca9dbARWCsG+u+Kkt5qDSHGMakJSZN+Ka53y
 w+29wEOXoLFSvaOl8daaEcEjsH3FtHnce8MQ5S3eXAx8MM4illea6GsfjRD+mVCwOk8rPSXSEiz
 a0RwR8YEzu68mVfjkrpicEL1wpFA0rcdbMS0UyMQRHoYAUfc4/PQKM8Afuckagh//wpik/xQtzs
 goRS6Dbn3ThrHNUyVXhMeXNzsyduAlgLfS/WbX3GDY6ywhkyyqWCq5bINB6Ns4cc147UG7SNt6K
 /qhPq/3ZF435f5Mrn7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfXziY6aa+gv7R+
 cjR7ZjlKOIklFr50c/uvxNBzH6omIk5/0xnxuCu8cmgIxSOmSOWMfCn5l1z8hx1coga1avtYxjF
 5SG7HuHjJybNCOPv4FiTg+/D0Nyzymk=
X-Proofpoint-GUID: 8_n-en5y0r98Ns1AK64gWj_OZA6EkKeJ
X-Authority-Analysis: v=2.4 cv=abxRWxot c=1 sm=1 tr=0 ts=6a794117 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=i4_ie1WIf3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100023
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

On 7/8/26 15:19, Paolo Bonzini wrote:
> Do not hardcode bit 1.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/xsave_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

