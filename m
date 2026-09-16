Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0317C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ulB-0005kk-SK; Wed, 16 Sep 2026 14:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6ul7-0005kC-LQ; Wed, 16 Sep 2026 14:53:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6ul4-0005eE-Hv; Wed, 16 Sep 2026 14:53:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1oR64057586; Wed, 16 Sep 2026 18:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xA6+Uh
 RNvPqMRAKQDU+6ihrd1XZRzphjHsfb5oJO1Ng=; b=G8AMaBzctSUic5Dv4LxL1l
 gLSifzzwWuySFRVgkWIq6FfgQNbJ6DgSo3N4ZrmDtjYLCDd+66yMqNnxzj4O3e9F
 beC2bLkUIMZ4FFIxzp1knJyHG3+O26baDghAHKNl7csRjZhVPmPl34P8gQtkbuD+
 c92DTE8QuI7xf2EYclcDpgVa6xIoGbJ8aTCwx2CfNvaNlkk8ZJIOoDbzk7HAiQJ5
 mA3JioHv5JP+rAPa+1LUSab84n3VoG+j2wA4IhbfTJ9SdM/wBAqK7GPdCJQQ8o1N
 KzSHWOuru8M/T4JFgiLj+e8wHqWCeQBwBEd4kI5linHotKSV8gNig0R6ptef7gPg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hxabr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 18:53:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIqPsN1713090; Wed, 16 Sep 2026 18:53:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpyweyx3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 18:53:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GIrFBv35586316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 18:53:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0612958065;
 Wed, 16 Sep 2026 18:53:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEC8F5804B;
 Wed, 16 Sep 2026 18:53:13 +0000 (GMT)
Received: from [9.61.249.152] (unknown [9.61.249.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 18:53:13 +0000 (GMT)
Message-ID: <022821b3-aca6-4b5a-9219-2d22615c2178@linux.ibm.com>
Date: Wed, 16 Sep 2026 11:53:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260911152137.676602-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI1NSBTYWx0ZWRfXz9kuIVHia7J0
 JzIR+tGKgj8kcrwFi4WKU8ZaBLQrA1XXA1jvCiroL2S4vyAErKoIi5Zq6srx1QLNhd3XGIZ5TD7
 8T2LUZIE+lwx58T7xZKl9/zEpsWdjwHiKoD+6kTSJ+I6Fv+0mZpBjlfIjl4lqRaO2PAGve4nWg1
 L509Xfuevf81UXcSGMKKWMuyEoYuKRP7+REF4Y/rpY5qsi7awib2juTEFCPWji7Z+qZV7kKCgc1
 WNzK7JtSOCt5DC0fcxY0i6jvwKs8tUeLUovPjspLS+zdmnFWHdOZ5Nx5PS16s/xgM3EqhUaaXQ2
 gA21cQ8OvpMZwmwcn9kGnV2T5SzHMX0MfSl3D9SHv9d15yQt4xGrCR58c407yZRpymDFX6zCk+B
 kFxaQNTk0HNvQNR0J8rGehVGC7gtEdUTosOn9OPULHOHAJZHcOV6ckTgyz3uDFyJQaP4I8wkafS
 qFoSTMApxfCjIuxEpqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI1NSBTYWx0ZWRfXwyqHpvAj6WKz
 kAP+qlQFmbYQUUrr5I76Vqp7RVrAR85fP88WAOS46FrWJYWOHSm4vTNcycGxrWUVqFU0L3FBGGf
 V09aWMFjksBNkIfgRIYssoupyN5bDjU=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaae59d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=GjvpRQj45VN3qK-tGu0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jO3WXxJ3tVbliaRBwC9nmJAyE6oO0zx_
X-Proofpoint-GUID: jO3WXxJ3tVbliaRBwC9nmJAyE6oO0zx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160255
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
> Extract the pba, pal and g_iota checks from reg_ioat() into a function.
> Make it external so that it can also be used in a follow up change.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c         | 39 +++++++++++++++++++++-----------
>   include/hw/s390x/s390-pci-inst.h |  2 ++
>   2 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index f93db10c81..c7f96417cc 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -1024,29 +1024,42 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
>       return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
>   }
>   
> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
> +                             uint64_t pal, uint64_t g_iota, bool report)
> +{

Would it be better to pass Error **errp instead of report? I think QEMU 
that is the preferred QEMU style.


> +    uint8_t dt = (g_iota >> 2) & 0x7;
> +    bool t = s390_pci_is_translation_enabled(g_iota);
> +
> +    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
> +        return false;
> +    }
> +    /* currently we only support designation type 1 with translation */
> +    if (t && dt != ZPCI_IOTA_RTTO) {
> +        if (report) {
> +            error_report("unsupported ioat dt %d t %d", dt, t);
> +        }
> +        return false;
> +    }
> +    if (!t && !pbdev->rtr_avail) {
> +        if (report) {
> +            error_report("relaxed translation not allowed");
> +        }
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>                       uintptr_t ra)
>   {
>       uint64_t pba = ldq_be_p(&fib.pba);
>       uint64_t pal = ldq_be_p(&fib.pal);
>       uint64_t g_iota = ldq_be_p(&fib.iota);
> -    uint8_t dt = (g_iota >> 2) & 0x7;
>       bool t = s390_pci_is_translation_enabled(g_iota);
>   
>       pba &= ~0xfff;
>       pal |= 0xfff;
> -    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
> -        s390_program_interrupt(env, PGM_OPERAND, ra);
> -        return -EINVAL;
> -    }
> -
> -    /* currently we only support designation type 1 with translation */
> -    if (t && dt != ZPCI_IOTA_RTTO) {
> -        error_report("unsupported ioat dt %d t %d", dt, t);
> -        s390_program_interrupt(env, PGM_OPERAND, ra);
> -        return -EINVAL;
> -    } else if (!t && !pbdev->rtr_avail) {
> -        error_report("relaxed translation not allowed");
> +    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, /*report=*/true)) {
>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
>       }
> diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
> index 38268c256e..b53113ddbc 100644
> --- a/include/hw/s390x/s390-pci-inst.h
> +++ b/include/hw/s390x/s390-pci-inst.h
> @@ -100,6 +100,8 @@ typedef struct ZpciFib {
>   
>   int pci_dereg_irqs(S390PCIBusDevice *pbdev);
>   void pci_dereg_ioat(S390PCIBusDevice *pbdev);
> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
> +                             uint64_t pal, uint64_t g_iota, bool report);
>   int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra);
>   int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
>   int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);

