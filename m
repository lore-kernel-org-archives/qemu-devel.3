Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1yo-0001YO-Bp; Tue, 07 Jul 2026 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1yl-0001Xq-9e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:20:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1yj-0004hl-Qj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:20:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dtvr3209705
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GUuEiYPwUs/DY0VrUFfJTUEPO0NFv1ddFZW4MmxOaIs=; b=cbkf74sZqOVsyEL2
 WLRpTk1CIbW6llkksQDAq/ps+L1Nau5uTqWuLmF2RIsEswdAUopNc89KruMv7w64
 V2lcpvwv6GL2B+NzIvH78nXPYhepOZ0iefbBDPHCpPVmaKP+73ngulBWTnR4gkmJ
 3mRA2p2SVVGtF42rrsg/1VyMmftlEsRUm6XXGZL7r6Oh8ToFa/tGPXZdTPHbKXuv
 qVf/k6ZS/HF+8VF4cl07lRNTiC395IhDVbnOgAJOAnSshKKMqiXrFCFOXtoXbaov
 anXqVUYEgrrGmhoouu9lYqF5AnaNCS3x30dtUCnxQYDm0ZxGIWIUkmHpDNimnkEe
 hioUBw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8n70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:20:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso81465891cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416031; x=1784020831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUuEiYPwUs/DY0VrUFfJTUEPO0NFv1ddFZW4MmxOaIs=;
 b=F6Q7r0n+F0V5W/ymOVDXOC7N7imcZOMukbxDHY/FRdNTz7Jyh2xjqRfgMiQPM1SPIz
 JgPqd0dXGKSRKJAuwgyi8x2H8Ott3xfHEGYfFzYcg4Wql374FvXl7YEX3WpTNiB8+31/
 iJ9gJGVREzWumz2OVvEFIjI0/O9ULrI28TFEjaFXpe/SZT4maS+jNLjqpyX/gFNtmtOU
 d1Iw7WmcN1hpphlQlB2YXBfkZOnt+bsw46okoPS79UjmiBvjjOUzCgROxT2FqrPypmHn
 wUaJMIIf6MRbWvo/G+nQskloThdIpsz5jB0t6un9eBvNYHtUcrcqb70SzgGzqtPlfKQg
 4+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416031; x=1784020831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUuEiYPwUs/DY0VrUFfJTUEPO0NFv1ddFZW4MmxOaIs=;
 b=Zi2RK8UWetbagwNW6aQwbh0zkbpM9C3LCcz8/AiqndZdJ6Jt0mRjMXl0KPS0uedH4u
 qi4fF5ULpJuC6g4/nB5dnHsZMoHbO5//oXCb49ak8X2ES7sgc++Rm1g4phjuSEuMcMFI
 AS0msJ2a6CeGmpe/WH4QIw86l5EO958Kam/i4uKGti4+UBIE2obKJgz4mig6F744k7ZR
 Iu2HsPL0kCmsDNL1y8hBhcwNBsHmZ1btllU52JFdiZdMhdxPkxyChJqTMsaTWV0P+poS
 6Zd1GpDhf4TMOgYVlwOQBFweMwf/ni2AH/AfAPPmuu/k6hecP4OeNSMkETLhQHhS9Ahz
 7jcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNJNoOWZrVyHnZG0y0I1FIgJFN0KWlDXthwpxzG5jvPTzQTC1cLK7opN1ylXpeW10l6/NRZIgpON7b@nongnu.org
X-Gm-Message-State: AOJu0YwcmMbnqHMfo2hqAcBrmwSFTy6pV8ZWaRI3xcEoljDAOqT+XxjY
 FKKbWPOjSX5R8E2fwTIyTnS9j1lhKLoWmIJczEwqcCAHna+rWWVivunzPfViKPMCvKllXY8lX1w
 jSxBHsUD56D+WUdf+hkWWVcp8eY1Z6l8QXPTDRJI/0nS20VgvJhenirlaEg==
X-Gm-Gg: AfdE7cngdOuU42LQWiuQrGmIYtb62noLSc1W7NYIRh5oQAjedMdIIl6Iz7lN94cfOAd
 mNHMxPEXanlsHeUpbbU//ca8uizS1y/xFnzj4m5TQ1uDjLFR9n9I6GXkYh+pt+Gw331mqSqITQC
 XpIpPGy2KoapQhY1Z0lK5eDkxvkJEl6dxG1u43MCbdkicQNbhL/ZGMF22bozD7akfBGLNheZqkD
 1Kw6KpROmatBBt7HajNo97vnYW89m96Jf6yt+5hnlpd82kwhkv+E+y29viqQtahT2c7Jky80kxg
 yoS6V+6MB+ffNyaKwUTdoiyfwIFNcNNwfgUh0KRolIKC4fj+ok+mlcWVr9opj4T77VxRpdpkNtL
 oC6Ot490aLa8IKtSAmqnaaceh0qlbdKocnlWqKSgWHX4Ife8EpmuAE2G8jmDVUA==
X-Received: by 2002:a05:622a:c03:b0:516:d612:d1c4 with SMTP id
 d75a77b69052e-51c748a0c68mr49237781cf.52.1783416031421; 
 Tue, 07 Jul 2026 02:20:31 -0700 (PDT)
X-Received: by 2002:a05:622a:c03:b0:516:d612:d1c4 with SMTP id
 d75a77b69052e-51c748a0c68mr49237471cf.52.1783416030890; 
 Tue, 07 Jul 2026 02:20:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad8563desm90872466b.24.2026.07.07.02.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:20:30 -0700 (PDT)
Message-ID: <95030cdb-5a1c-4dd7-88ec-b989dec18f92@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/i2c: pmbus: clear output buffer on write
Content-Language: en-US
To: Titus Rwantare <titusr@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com,
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-4-titusr@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706230056.1888992-4-titusr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cc4e0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: fu_6fOMg8U9FT3O_Rood-XNEkZX9IgJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX+1K8NB0/IINp
 XTHrASCfpqnGLkuC1NYvJeVe+rrI06zuATRUt6JmDNEdYBHwcoMmCs2ZdFiFUhATsYuJGKrRs+q
 8Uv/JPnT8eEBlJ77oMbtqda86bBbUNwN3aBp4XpPF2bIiGZ9JYsFAP4fuCL8tYZIP7qFLs/82ki
 FIF81NZoANZbc6CWd/ON72vGG+tceftOXmb/xDebOtGgTUKT7V6u5Yvbydsi3aEKV/eEaPZbCqN
 je0tbvKiY0eLjuXJC1tWAmPZAi3HB9AkKHdHsM/S9Fer9CHo15KpSablJh7yC90jWVXQSoL6CGA
 yx1Wro77ubE/qZp+sm9Ov0U95xcZ1ZlL7eFwMujbkOOKCAypOohVdAIp0yCMKbqxj+GwhOUW+b9
 WVkzJq79PI9b6LEkBrkVdpBtv01oYnr4aKFURwg3jvm8vXt+KVc2//4Vyt+C1HN6XIMG49iiwcb
 K+2EKVU3h4u0ovIp0mg==
X-Proofpoint-ORIG-GUID: fu_6fOMg8U9FT3O_Rood-XNEkZX9IgJI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX6Q9ujMIsiEVZ
 ol80zMojmeNmo0MUePnkCadAgA0+D1KX+7g78VIZGnYnNUvDZlmOWlciBGNLOKS6CQo+YuofnIo
 cgdWr4VzhTaMbAmKM89Mxu5Ho+/Y+1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 7/7/26 01:00, Titus Rwantare wrote:
> From: titusr <titusr@google.com>
> 
> Generally we expect a PMBus sensor to issue writes after all pending
> reads have completed. If a data read needs to be resumed, this state can
> be tracked in the device model and the pending data placed in the output
> buffer.
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>   hw/i2c/pmbus_device.c      | 10 ++++++++++
>   tests/qtest/adm1266-test.c | 10 ++++++----
>   2 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

