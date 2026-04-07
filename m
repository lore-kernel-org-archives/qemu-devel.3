Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDE0FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABX0-0008LW-4V; Tue, 07 Apr 2026 14:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wABTp-0003zm-Et
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wA2wu-0003lp-9X
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 05:42:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376e2Ii3402637
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 09:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mHEBeuyhXPxHHQEXJ1T92cQl5I6QXhJaM8qyQp9SlpU=; b=UxVROUeeplL1r7af
 /osMtCsi7bZ1B1/P38WoVZ8O7McbEsBB18l2/0Gbal4xQMLeM++vxBb+lC+xYH1n
 TaJkclB/HGidnRxZBADhsGh5kBC0ktKj6o0m8OmjbviPqacsuVuj0xxYs3rNFWLr
 4uYKMULYDJBqenP4L9Er9GkiV8wOJ5j6H9LKfcakj/qRwuN0OJ7OKiQK9Re8A+Ta
 ByKWKBQLO1HTtokkk5zZngjbnM+RwgD/+gbFRn6i6tvwI39pzMUGIjUVQ7XEMsFv
 BE7zs7r3lerQReV6KtFpVl6y10DdmH8fw57xEEV0ZCTkzdKrwZx0dy/XjC90cWoI
 MAcGTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht3en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:42:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ccc035f125so1824705eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554938; x=1776159738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mHEBeuyhXPxHHQEXJ1T92cQl5I6QXhJaM8qyQp9SlpU=;
 b=X4CZyYBsNj0iJP941QMf3WuB5M/mhNeTEZwT/SMS5Vy5+/qtSpITrWayE9XSVRJTyx
 1c8kM2aCIjLTtCB+4eM9aKgwGOZXBXoH+rc49Rbya1Slcs+mfc7UYijL9e6eCqHFciO2
 Z6rxTRVG7Gg0cd7APd2Ff/V4SsAwfzLRDWuZ0EMvPatUtafSeDfNtgCbVdDfWNX+r1dk
 vHJqe1ZH7ObyXqDuX445vWpBlI55go/GwLGLiQcm733PArUwErfGi96RVVPuMHvgQtbV
 bPpVnIohH1aau/qSrqTSNDePvl6ayZhhFr8hVBmIM7pHR9uR7W7i6VTubulciFiuXN7K
 roDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554938; x=1776159738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHEBeuyhXPxHHQEXJ1T92cQl5I6QXhJaM8qyQp9SlpU=;
 b=kPxMdQbMQISdnseIXxLd586gg3xyh8/O/+SCX1jkUYlB1X5cKXHxUbd3IpuVP8Ak9Z
 hTr5IR9rr1MaLF4mB9FBp6TdSIVeU+x9gT84IUV2YG6EtRXJaemhouOsBfkuRXdFap8Z
 FC8VsU7JjfQHKhKUl1FPWVs7O3GGXbuZvWmuTn3PGh3KgjlE3S+k0etCHOvK5ZgPU9fQ
 nYM3tle+8O2m4YfKq8r2l9sR3+jcRYF4OZR14LkwPvTRWVxpj3VzVHRCdByVdr97OQtt
 VVm/yV3mefs5mDh8Q1k8q4r442KfA0yPKSfLHDIocYdp3EOGhQu0C6GrJnEtezcRNTWJ
 goog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpQdZNRe4Yt1uY+QOQhTp7uXlQXfAWHIN6yugS1nC6A/l5GE1cUNc31lTXdIwnhTgnW50gzY1YyMku@nongnu.org
X-Gm-Message-State: AOJu0YzLDkIMPZ8zmaVLalHImtp6xW7T5CvhKWJ7zzSdfgBCot1pDhGQ
 vHKklJ886+Il4hNyHrI7T5vSwZ4WbV2etmz6F59KzuQ2d9J2OlbZ50KLsYv3J0nt/AECGUbeyDz
 tRBsOISpVIJmGyZuC6sz0BhC/rNf3JfvO1FAU9pnwu757X1ruxlzTLtB39Q==
X-Gm-Gg: AeBDietF3WHxL97W+jDdg7IHTdcNgqSjDAjGlbg5b0MfHZo5sE8M7dNepnWcFd5VZsK
 lbhEhCcLGaRrCpf0v8NxM3ikvsO8Evye05z1pcBLn8vPJl74ew6DrDH9cpddzYG2OVpv1Qr5VAW
 YfmPDI1Ar9YhCxrqPzVKryFy7qtV0D4U66VgT9oWuiwQkvU+AoB/03O+P6aPHTC+hRt8gWNnpVE
 fEEZBHShh4oYM/icuQ2/EZJX78pcUafCLG0y1YhlGE0pkfwZ85ww6/FJ5lRkgwTbncYTyzkUMr/
 avXSyWzaTZv50paSWM6wrAueymi3IcEJMUckDdguuNvbzknWIUhaOuWZDKrDyL3pUn0mDqqJPfr
 3F8DnTf/J0dvTsFWzkN6O1QC8KivHhX6ZRvTYFowJ/8Di3dNrXB+m86IE
X-Received: by 2002:a05:7301:4090:b0:2c6:ebf6:133e with SMTP id
 5a478bee46e88-2cbfa2d2ac1mr5877521eec.8.1775554938405; 
 Tue, 07 Apr 2026 02:42:18 -0700 (PDT)
X-Received: by 2002:a05:7301:4090:b0:2c6:ebf6:133e with SMTP id
 5a478bee46e88-2cbfa2d2ac1mr5877505eec.8.1775554937851; 
 Tue, 07 Apr 2026 02:42:17 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cae7e3ec57sm17678887eec.1.2026.04.07.02.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:42:17 -0700 (PDT)
Message-ID: <bf11f440-0921-4561-b064-657893c76173@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 06:42:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/timer: ibex_timer: Update IRQs after writing CTRL
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-5-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OSBTYWx0ZWRfX+03EmadFmVGC
 febT90Wu4CthAUipM5PmtcjTiR1+rQsdquwLmAor1LklzbUQoqPx37z5P6d7OE84icT1hGAwfxG
 BaYpKzsg3TN7feb0TGCqlo2TpiEp1bH9/90QDtnRrY9xE4S2lcrSDjOhgCr8OrJjTzN/L+ktKFh
 Uv9HHWUMF5ehbGOuSbwLZ9FhKL9N4ZPQ4p77b9bhy49LDbYmtkjE/6xWQNlU/1EovcJ7BcZok2J
 RbWYaWEmP/pfbu8+OM5Q5Easc4dpBqhYL7NxOLa+5xsNG+5QBDTRZUZ9YctEAKxOTXYiSSSMvI5
 lFMfbMwrf5r0e0X3Q0btvgPXTCmRaaOV/+DdhGyLh+FnFWz2T60f/KC5RNs4RSSDi1YPPvQaF3c
 BaoXyzAaSnG+AF5Vd5+OrKjAzOcj3buCUgEmcxVnbi46cy5H3CC5xJ3s06wqYrRO023501jpSPs
 OZ3zfCmwfh8yMeWUj3A==
X-Proofpoint-GUID: iVSTS8vbOFLbqitUFtem4v1YDTnFfnIe
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4d17b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=UOqw556B9czlxbsWkWsA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: iVSTS8vbOFLbqitUFtem4v1YDTnFfnIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When writing to rv_timer.CTRL after setting the compare values the timer
> doesn't fire as we don't update the interrupts. Ensure we update the
> interrupts after a write to the rv_timer.CTRL register.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/timer/ibex_timer.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
> index 0f12531934..571633803d 100644
> --- a/hw/timer/ibex_timer.c
> +++ b/hw/timer/ibex_timer.c
> @@ -193,6 +193,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
>           break;
>       case R_CTRL:
>           s->timer_ctrl = val;
> +        ibex_timer_update_irqs(s);
>           break;
>       case R_CFG0:
>           qemu_log_mask(LOG_UNIMP, "Changing prescale or step not supported");


