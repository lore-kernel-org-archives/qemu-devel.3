Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdPO-0000g4-45; Mon, 06 Jul 2026 03:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdPM-0000fR-DT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:06:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdPK-0003V2-RM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:06:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Slt3593989
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LYLw+NEnGGTFQEjcevm+HJdpUh29k6RCkUllU5CafWQ=; b=dg4H8FVsjvhvehbB
 V4azvq4BdKatIe5o0k8m+pzHoHYsweS5oARiPV4lWRhhlmGndyfTYP2/qqyjhpg6
 5wqb2PgNUi/xHPp2lKwRgQ3TtOp4r2aYBTW+oAFLKHddmtUSpSnhI7DQSpSexSOZ
 EfE0qfLevc5ANtYdXdOo+0i+BYgPD+9sL9KCRK5fT1cLNZwzrKfk/uqKC1FRYxGZ
 02adSdtzSxPjLzCzQNbqTCA7Q7/z62+yrZUDvtozI+tw0IrXc+P0vu8s3d7OTQeq
 Vud/9pZznCDOWjOP5F4QVvgyB9iUlBWU7iUWSpEnV/APEX6OcdYVD84QgJX+blCd
 RTALrw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgw9ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:06:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d3261c5cso224539285a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783321580; x=1783926380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LYLw+NEnGGTFQEjcevm+HJdpUh29k6RCkUllU5CafWQ=;
 b=F0lVWEAODxEpyUuxPB7D6NlCIpiExb9K+H5uhDiLjiB4j6PnwSnixhM8OUW6u4io9x
 u30CDotOdI/BXHRRxJ5cg9daW2VVPsFfn9ZjzUWt21kun7t2wzKjXVh2JemLJP/fQGMD
 bb5LMDR/5mbtCoh10s7rwvosoCl5VYnKZo9tfWgFo46BYqjlHkxV+ePKOO6EWVQoFAg5
 Da2rOOXhw7wle+sfSwIjIErayz6Xf1saCJlFoCwomaS8h3LRo5h4argPRI6Gep125pAA
 nmTN4zwhdGfzebSRPd/RnSu4XpzIEUuPPYSjkpixDfzNd7RwRvwqYInLxlnIFn4Y0NTQ
 VwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783321580; x=1783926380;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LYLw+NEnGGTFQEjcevm+HJdpUh29k6RCkUllU5CafWQ=;
 b=Meusr71G27INTZINl6mj4YnL9to1xSDi7mi4cLX9skOt3YQ/7eB6Yy34JTY8MOKkAk
 eYmIxn8W8oUJyk/75+uvKsKFZpFA+NX0gNYpRla8l/2zJ0CfQzdfXMHVZUI0x/d/Y8uT
 +xRsHdi+XGMvQQ7c/ltbWaPSUzS7t0n0BLOcDeNb/ngX5okPs5NsQVY5pbRjYph1jCmE
 2IlPbkNM3zkT8lpkFtriiDEy1WC4pydmAibHwdxxJluwL4RXp+iLmbtHP7P0GZZQ5+kZ
 nKukPmqqwZNe909b5FRq0Vw0t+pf6YNDaizDKclBrUNu+OqO1xi4DZJSaJWuJzbncYIK
 GTgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzbWoRLgxAe7w4RLWWeTJ9irD7mGwvkcyQTi1qYD9Cq43u/hbUN4a74RCkXRUz+k5LUFXq7oW3GouR@nongnu.org
X-Gm-Message-State: AOJu0YyoM3aNNQPoDAvMK2IF/zWdlgTE06xz3muAzk7m/gMxVpJ8pUzP
 8hQqXev9zx+Ko/SzsYraXT6e5EDaFUDiMll/bR+hU21T7mHul1JJe5zj6k8eL3BME0A3xEdNEca
 mhcCHM6O7D+qhcQzjcPaKKopxB7h5mDLx0ZMWAf6wAOQ+VaTerrvAmmqRFQ==
X-Gm-Gg: AfdE7cnh9FGUpDvKtYm+T2Z8pfXM1n87BdAzD1ljbrpb4r5x+DNYvaFeKmDXHOzIfV5
 2KpUcF/BPEdv5XY60ZQJiCZm5MCghayKDyy2FbiF20vG6O8Y/v7X4i89QqR2Ia537KOaF+aB4VI
 WTTTu/z8sasgirFkLccs9Bg+bNM08iD2iax1vFz7NZJl9m8aHmDSLMquNX3LXdK/Lj3mjP/GSwl
 YOY84Q/clWBIrnYre1fheKzL664jem8k9gOTYA+MzW1pKS4PUbyxZhQFvgv0k1IB4kiHvNqlH0y
 twZuO/RY99zgFzid7gZ/O8xxQVTn/NZH2Dt75A01bRpq1hU3QvywNO22tQwbeOgDVPALIyexxEx
 Tk+AAYQ+3LU/TTbcB8FQ3RToTQc8AVwZzi9Sh+o8iOAA+5GN7ql25tB2tALWK7g==
X-Received: by 2002:a05:620a:1b82:b0:92d:6961:9519 with SMTP id
 af79cd13be357-92e9a353d3cmr1205757085a.8.1783321580046; 
 Mon, 06 Jul 2026 00:06:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1b82:b0:92d:6961:9519 with SMTP id
 af79cd13be357-92e9a353d3cmr1205755385a.8.1783321579599; 
 Mon, 06 Jul 2026 00:06:19 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm20616278f8f.10.2026.07.06.00.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:06:19 -0700 (PDT)
Message-ID: <1c4a3649-79da-49ac-8b76-b3c70b0facdc@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/acpi/ich9.c: move initial property values
 into ich9_reset_properties()
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-7-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703135512.3213964-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b53ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: bKEhvoQPxDOwiPyalO9i0sHcPQjS2VDs
X-Proofpoint-GUID: bKEhvoQPxDOwiPyalO9i0sHcPQjS2VDs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2OSBTYWx0ZWRfX6Ww37BndN51R
 lnqYEexkwX85lq5xJIX/RCzRYg//PHdExnb0ciKCuw1g//apdaXtIiVmwpFv5rfkAbFZWgoJNDo
 /K/68k5CLWcJLeAft1qiefvfZc6WaOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2OSBTYWx0ZWRfX4GdPiydWWAKK
 ebCw9pXDwLItu9hc1beq0eXcH6eef4NNmsS7n9bmYUZ3gaoD1eXA0z7usb2ARbYqvtr5oM/2hUO
 6hTuP0sxtR1W56z4MW12LEVLXfpR/4i90poteHsgoN5cNcGXwvF2qn9qit9NXG1w56eLsXiRU9n
 zlVDCeLjPOWiePxfYFh7DJk+7X2rlnf2VIbz23ZbAg6/uL9iGPWg4QHBPV7Acz9lqrtnQUyOM6V
 bq2GMhzFvFOIdXNuCpNp8ylKxa/c+Rmdzpvijetkoks4bbJoattrLvwzXWAm2ggM0Z1eS1voJMB
 MLVEXm5imkEA796+wmDiYkrvf8TOWVu/TaG/gOVd8CXo0jlmQy8TXdARCLrymv+//pN7eQPOVMl
 d7DJ8Nvo+QD/nq2tUpFMHcqghHKI4QElsP9XaLeph+V/Y/Tn7k2TEpMhzF4wsB8KIK7vjP/3o0Y
 WVV1yC+ZLMjbjxKlFfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 3/7/26 15:53, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/acpi/ich9.h | 2 ++
>   hw/acpi/ich9.c         | 8 ++++++--
>   hw/isa/lpc_ich9.c      | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

