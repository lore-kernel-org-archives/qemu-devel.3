Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ADDC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTJr-0007zI-Fa; Thu, 02 Jul 2026 22:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTJm-0007yv-TX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:07:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTJk-0006QU-13
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:07:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319ap32356019
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 02:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kdqNozVJTg5LLdjc+PWakoeB4IknaCmuEVX9AzK7Hvw=; b=ND532IVCIIQjsowZ
 nf57TruGUgj+6OU3lTm3OOL9S84PY9Z1yELnTB8/IgOiYfxV3PmfInuIJjBGuItQ
 HkTbCsIvOYn/T9sQvc7QXrAereXrXKjzBDntw5Y6OzTM67zYD81ePyaAkVGeG+4z
 YxA5zs/T2ADj1DGYv3AlgpXgl/07exhNgo5GFcAVIM7lId63HZo3/0g7svGxbiP2
 PSAvUbOv2RZcCc0+vo6Pqktr0sD4p7yvgFmlGCSgdzrLSnYL2g9WC64Mv4dhnMXu
 9cj1vTNa3bQ12nHWmYrzYir8pztG0gcDRGvfC4IWIu5YafaisiQx/bfeZXqaSXlv
 om9/UQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc36fv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:07:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915c364ae3bso6801485a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783044462; x=1783649262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdqNozVJTg5LLdjc+PWakoeB4IknaCmuEVX9AzK7Hvw=;
 b=OqkuKF0wlSXdGSZBFXiWsNrtPtK/4zPYZED6I3YGBvP0+soMwtcHlrwLHiFcYuPZ3Y
 suaIwwYbrghA5JxK4TyaXjYzAkNwwXXgY0V668lcvkl0i52AIfnrEH/4oUZix3ijFRUS
 de93Q+gvD5T4IyYTCJCRs1xlZfzYUTD19+hJJ98dpNZRbYe8qQ5qLNmyuBikZ7Wj+EL2
 IwZ9oZfXQNu+g0D0N6zC+VeIVw0ScN5rvp3bQhaTT3IvP3hWUCe9o8bMUV6+Hb+hD+m6
 LDwLfJyf0Ngggssr1910WbWXvzkk+mGfUidwm3x3YwEa+xDbOUCg3OY5CCW96wiDvZLu
 ENvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783044462; x=1783649262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdqNozVJTg5LLdjc+PWakoeB4IknaCmuEVX9AzK7Hvw=;
 b=gfkSYCwj1+97INaunZkmL8PaiPAFAgVdOZqJFYrfFL8QQ2Xg4hM1s+J1Lg8sqpwlhP
 H7/FLzelFCvvNuRHGm+MoFSCDBtLo+M988ukqlgD1xSYEcCF2aHAU3ZfGRjuCqDlIY43
 RFoMcbSRG/x7deF4W6at3rdOVNiiA6AzS29uFoOiz8nnm5KvLFfOhhRfRRLBcA3aQKED
 2MEzKp4TXiNNlBep//Pqcta2S6pB1oQDwpFriB8a2hY460EXi/Wk2IH9c+eozKkGnSOe
 XmDQzwZOLiaoWrEeV0Bp7ucivz71vm1OlZH5quCdEnIuJAiFnR8cABVEhWnZa7NOcevs
 1olw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VtowzpMYnZ04e8Ir7nuWTR+jOuMzap+fFBQxDI7x9DVPbnna5aYSxOcVDk3pFLXJYTl/0fMttgmD5@nongnu.org
X-Gm-Message-State: AOJu0YzEfwTAbkyStMkFOFXZtmM7hp3ctZ4UDGuooP0nauJyE8z4Ie4E
 f8V+QLXJA6zGBYILDFPXS8VHrBG9oDrOxI2fGoA+KAgriqByor54Qs8qobkZyP8WtyRRDv9uzQn
 cGKbaiQCDFN0gZc1sJ0hVbgQjkwiBTLEApyZ3Ja+6aLrQWh2iioNo5WkQPA==
X-Gm-Gg: AfdE7cl8kJTXbt96fqoAx8Ew6V7KXyqVctRHOGH9qSEfd199NI+tMGxDnouZ8LwcE3d
 ZbT854CxREWRVtrECTgtG+YzTDnx9JYNpS+KyPQA3nGsHZszWvMy6C3BnB2zth6C94Ec9l6c6nJ
 vhSIynPFU1dYJrM/FxQumO3TIn2lc/8/9kXiWBZZXKZNoqIwH1YTmvLVUsJGxTH2OPETinnCfZo
 zhSX5DtntfoEfR9NRcHVFAhTEDKx63ULDQ2yOCnWsNCvOlmJM/2UZ1gHdFZv19xleohthjU6ETJ
 uxDthpUn7c/cbNF24m2DGb5aq/5vc+Xnn5aFDOGww0bHahVFQZrjsVO4SdvTdLd7tvCNoMxxVoF
 5zE0GgVAcRwLj/2UJejEvgiXH2NkwhBfgJHBRrC7qxoA9ZWCp7/UhtAv0uvR+7Q==
X-Received: by 2002:a05:620a:25cc:b0:92e:68b9:6b50 with SMTP id
 af79cd13be357-92e785062ebmr1148773185a.57.1783044462179; 
 Thu, 02 Jul 2026 19:07:42 -0700 (PDT)
X-Received: by 2002:a05:620a:25cc:b0:92e:68b9:6b50 with SMTP id
 af79cd13be357-92e785062ebmr1148771185a.57.1783044461510; 
 Thu, 02 Jul 2026 19:07:41 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14183030f8f.4.2026.07.02.19.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 19:07:40 -0700 (PDT)
Message-ID: <28c14e21-9382-4d4b-bde0-622d4dca9bf9@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 04:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/23] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-18-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630043107.1511076-18-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eVTEIanQH2nODYhu_5vsQI69Jf6alIwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAxOCBTYWx0ZWRfX6w7z+v9lc94v
 qozxseFAwnqljhZnSDecka0lXICWvIskMQYwJGrBrxvYIXDt+Ztet1HaS7NZz+KIXmteB4m/HCL
 6Ypyzp02oiFXvPebIfLdrp1Xo4cUnoHE3lVYA9Tg2q9/Cixm8NqhAIBv5JN+GKxNHgom4Vgh+v+
 bFXAPSPv7gmFFgjsuLr4tQHQIA0OiIHnbMeXoXCOcj+mBS3J1Gxo3l2MBEkbooxLLt4tOCPPIql
 EBsVwxl9LWF4icG4lShtjkqnJ5btks+RZkzBUUZmaArKltUDjhedJoC8pVcqvOAgYDnfO9maMp3
 nbunX0Mh2AKXqdphdQOCgk2go/zIcPoYoX73HMjKpLR8zEV2wrVRKI+w1n4g5VHIAYXJBbSkj0B
 uw5lecmggN4UUOcvMgomsdio7T+4Ku9/Ix2RYD3e/3ZLqSmTk3aLGqXHfrfrxsEfmuSSZwqhFfU
 P0tFyxI/4vzjG2qaEDQ==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a47196f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=5CnL1EQKMmUAPhqxv5sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: eVTEIanQH2nODYhu_5vsQI69Jf6alIwT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAxOCBTYWx0ZWRfX7+CNPl4nEdZf
 3m3oI9G94+auU+hzUMHVAcsLFSyFYJa4Bn2dWBcWldCnxjL/bCbxXJOzz1U8KD3QXNjkiXI5hC0
 c2pp8EKMvBKhbr554HrSotbXlqZkUFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030018
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

On 30/6/26 06:31, CÃ©dric Le Goater wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> According to VFIO uAPI, precopy initial_bytes is considered as critical
> data that should be transferred and loaded prior to moving to STOP_COPY
> state to ensure precopy phase would be effective.
> 
> As currently defined, initial_bytes can only decrease as it's being read
> from the data fd. However, there are cases where a new chunk of
> initial_bytes should be transferred during precopy.
> 
> The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
> reporting a new value for initial_bytes regardless of any previously
> reported values.
> 
> Implement VFIO_PRECOPY_INFO_REINIT feature:
> 1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
>     VFIO_PRECOPY_INFO_REINIT available.
> 2. Request a new switchover ACK if initial_bytes increases post of a
>     previous switchover ACK. This ensures the device is not moved to
>     STOP_COPY before initial_bytes has reached zero again.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-13-avihaih@nvidia.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/devel/migration/vfio.rst     | 14 +++++++
>   hw/vfio/vfio-migration-internal.h |  1 +
>   hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
>   hw/vfio/trace-events              |  4 +-
>   4 files changed, 80 insertions(+), 7 deletions(-)


> +/* Returns 1 on success, 0 if not supported and negative errno on failure */
> +static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
> +{
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
> +                              sizeof(uint64_t))] = {};

What is the point of using uint64_t[] here?

> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags =
> +        VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        if (errno == ENOTTY) {
> +            return 0;
> +        }
> +
> +        return -errno;
> +    }
> +
> +    return 1;
> +}


