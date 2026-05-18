Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE739CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwxG-0000b1-Me; Mon, 18 May 2026 08:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxC-0000ag-PS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxB-000603-1D
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I7dqTE2891865
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/KYs/9HzaSc7sRHr9BHpeOOFAj3jhIo8nRRI6S/X20=; b=PngEaU8Hgc8KyXuK
 NScjeZrOoMcObauGT0NVHdwoY5g+yNsV8BwTWsBmDU4uMNNBjtnSo4KAtViCLMD2
 m4fF29Oq/EVabCNz1rwEp5HgAtgzVvi3UEogN4HcZjYcbpIYom2hSoqJwIxiL1Df
 dimN2ddjhxRkyKVE7E7N71TJWZV5RXUAcLFIHwzsOL+EmE+9sH4B70HQgLxF0Hyy
 +NQoMQu7KFyIFJLjHPEHjBHzkA70qRMw/t6RUKVyRnSVOztqbI36FKeNKF0HOBz4
 oEeWaYuxTzngbNZHEY+tNIAlk1ABowrnV5CAg6dFsw4nlhdF890YvuApZltixVWO
 +yUflw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk19501-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b459fa5f76so28918976d6.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779106810; x=1779711610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/KYs/9HzaSc7sRHr9BHpeOOFAj3jhIo8nRRI6S/X20=;
 b=YCTX5rjriWzQcqQ/mNIlMUgTyonEn9C+MfYLj9svNC56+Pv/7r0CX9G6vqqEBJXGeg
 jyJThUXITF5CmUUgEgOUgliWYdqZx3zXBLXNsbdO+zrIr+8K7ZoM/0CauTqIk7oV0v95
 kwV0OG9BMPajm1zP5o7MbrjscKrvYI3tRTfkj3v0NtagCO0qwvUtlLdIgZNt1n6vZcaA
 yBEu5576m6zmskSvXA4foYNEGVBcj0wl/N1cFwOQhTZVEY3X3j54NIaqi1kZYWrPKz+7
 nkoWP59UdexF+YIDbkX5RIpXRXPsXjf/0KROS17lB07nNSt6tqy6v7mdYDA4J42uG9G9
 YlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106810; x=1779711610;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/KYs/9HzaSc7sRHr9BHpeOOFAj3jhIo8nRRI6S/X20=;
 b=MSrWvsGYe8jTrqG2ZLGZ9d7XXTApvp8R7/jPBo94DahuVzIxxLlb65/vdSdOkWVeAO
 cQU4ZXJ0pnORRxJ31RY8y+WLDFBI4wC7nhxXgnDb2Xqwz9n1UWSeSRKEYopIt3Glkj1F
 HI6KKxrxrPSyn2V5fm0OnaDQ2HtdhOl9M5VDpbQyiueyRhV//6PutqnA/qULYJp5e7hF
 kDzl0eqKv9ET/HCxMHwWGvlCcK4f2UCbM1qbALh9o3PEkTrPSP2OvYkoTDxBCpqceJf0
 JYc8c2Ygqzn1u16djIRjj+ZsfvBXValgFoRMdp+/39YLSj4mfhqPkXoCJjXlvyAoMXrN
 5NCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LUx8mI3MWYksaQaafPOvCH6IV17mKHvG1BdKbZKfXG4PpuBzCb6QesojS3pZigqKDVG4lN5IgZ2kI@nongnu.org
X-Gm-Message-State: AOJu0Yz2zQHvZf0oH5JKqKo45qMjZIa8XMvGkkBXsunlnDPOdNiG07OK
 tLZWLPOtKczhDGOgjb1EBbLzRkXd8G1B7AginAiA3V2cdIP0995sIS5Ch0NI6VLuADLhdYuwbG9
 KsSSIk1h/cDT7iEpLa+lQ5za2D+bLRFfI/UJ10kB0aQVYt5vu5ZU+xldnFQ==
X-Gm-Gg: Acq92OE6ZR0pVyihUReo2sDoYH8cSdGr9cf2Yci1WZkkmxpCXDq3Dtb9rsifyPn8rbC
 tntSkwwTJMGrTELuyDSx7KJoI+wzLF1+5NhViZD1/zJ/vuGtQaCedTWPKLH6KmlosbUjSRpD9QP
 HQNg3xTBFwOp/w4xY3bsVJUR5ZzGVXZCnUOFH3I3rwmeiUK70Sefr1hrUpmwCjY/DdpDNyeaSfg
 gaFoc3HtLPSDjVm3KEyCH2C9gg1p2/p3LEvodRYC/BKFV35BDTUdsov70eBLtDAdK5EiyyhEre+
 j7xqXP+s3an/+VLZhFtAECnoIGP8iAZclUJBv4Ar7T6GMnvM3ScvLmLtKpyX+Pdm1ICKeva83DX
 u+BzfHKptteQTPx8ObsR2IiuWUKgfNcXuqMbbZre2lMb3e2ZjX+z8T71nwXs=
X-Received: by 2002:ad4:5802:0:b0:8be:3da0:bbac with SMTP id
 6a1803df08f44-8ca0f5b15ffmr175764196d6.3.1779106809298; 
 Mon, 18 May 2026 05:20:09 -0700 (PDT)
X-Received: by 2002:ad4:5802:0:b0:8be:3da0:bbac with SMTP id
 6a1803df08f44-8ca0f5b15ffmr175763176d6.3.1779106808191; 
 Mon, 18 May 2026 05:20:08 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361bcb20sm54130416d6.49.2026.05.18.05.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:20:07 -0700 (PDT)
Message-ID: <c24aaeb2-74d4-4cbe-a92f-1232b7dcbb46@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:20:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/intc: riscv_aplic: Fix level trigger IRQ in direct
 delivery mode
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
 <20260428160103.3551125-2-jim.shu@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428160103.3551125-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qQRBhd9nhONNAPKGdwQNvc0kB8Sg0uKE
X-Proofpoint-ORIG-GUID: qQRBhd9nhONNAPKGdwQNvc0kB8Sg0uKE
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0b03fb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=p3-ECv0yDWoYNiPIsKoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExOSBTYWx0ZWRfXz0m6d1OVaTF+
 30GCjlUveuBaxK/bCx1/iGgxkng+ZNmK8zcmtSiX+/WKajfttQfAuCr/IcH9HWuNKermi/WZ1xb
 1UjKT6mkkDnKtb66ztyg1ba/245MD7haH2LpnivWn4Yy4kmPVIGQpEZb4JCl3qOpB634N23lwL+
 Lsm0MgeSHCPHfZxpRspUkOoc3zUBpntbB69pK738TSyjKeLlyiWpLU8B45oJ2zDEIOs8wXY+VnM
 6Df/YIrDROy8Bp2Zfr0OUs9vWw4i9EAbBF4wdOg2KaaMZ9OvPkVRVsVmH8r2JU/mBmUb/WsMe1P
 f8v2Gc0jebM9cpyMxME2bxx6hUGq7XgM3mdm7xIg3coI5qUd2ulEJglK1Hy7AKzrG3LbF3eqMNs
 8BRp/P6k2Kc8E8WNavKq9ZQ6VBkLudjzrAgL9zhFS7AtFX7cUu6nAe20FhGHhAbGqipbLDFSbnk
 VpR5w1bLFckglsyCpSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 4/28/2026 1:01 PM, Jim Shu wrote:
> According to the AIA spec ch4.7 ("Precise effects on interrupt-pending
> bits"), pending bit of APLIC should be set/cleared whenever the
> rectified input value is high/low in the both level-trigger mode
> and direct delivery mode.
> 
> Currently, QEMU APLIC only clears the pending bit when interrupt is
> claimed in APLIC, but not clears it when the rectified input value is
> low. (e.g. IRQ source signal is low in the LEVEL_HIGH/Level1 mode).
> The software may receive an additional IRQ if the peripheral
> triggers one after the software clears the APLIC IRQ but before it
> clears the peripheral's IRQ.
> 
> Thus, we also clear the pending bit via the rectified input value in the
> level-trigger mode.
> 
> This change doesn't affect MSI delivery mode. Calling
> riscv_aplic_msi_irq_update() when IRQ pending is low will do nothing.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/intc/riscv_aplic.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8f700431114..791e0b01b96 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -591,14 +591,14 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
>           }
>           break;
>       case APLIC_SOURCECFG_SM_LEVEL_HIGH:
> -        if ((level > 0) && !(state & APLIC_ISTATE_PENDING)) {
> -            riscv_aplic_set_pending_raw(aplic, irq, true);
> +        if ((level > 0) != !!(state & APLIC_ISTATE_PENDING)) {
> +            riscv_aplic_set_pending_raw(aplic, irq, level > 0);
>               update = true;
>           }
>           break;
>       case APLIC_SOURCECFG_SM_LEVEL_LOW:
> -        if ((level <= 0) && !(state & APLIC_ISTATE_PENDING)) {
> -            riscv_aplic_set_pending_raw(aplic, irq, true);
> +        if ((level <= 0) != !!(state & APLIC_ISTATE_PENDING)) {
> +            riscv_aplic_set_pending_raw(aplic, irq, level <= 0);
>               update = true;
>           }
>           break;


