Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD91C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww36d-00009f-TI; Mon, 17 Aug 2026 15:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ww36b-00008N-6k; Mon, 17 Aug 2026 15:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ww36Z-0003Rt-78; Mon, 17 Aug 2026 15:34:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVcg2307190; Mon, 17 Aug 2026 19:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=15Qy4c
 DMMzc+uej/F03E1AAabnwJ6AXkBn9ikqzOnZs=; b=ZuMaOpCTct88+x+QhxYdsq
 s2vfAVseUiLagd+i/7DjsUEPzV5OUJw/mdyklqqNVMaLvLKUOMHlzq7DmwwCRzkK
 zfj53uGPZeiZDAyGg0MagcBFsxCG+AHT85juYQu607wIKEkpczsH4p8qXIy/+sTp
 oA/vwQpyTjaJZCSVxThFyFGhJquIFgFcm5MrFPXeu2ospsjTycqhSLW2cm3uOhda
 tH8JykhIQIFX49fTIvy9t5XOtjL4BRTtYefhqAuWBwdwY64cR6DCMZ2HZQgzl01t
 S82LLo3H/AHNx3PyEravC/Fdb7hcY3+3Cwe9fPyHcU/oofVUP5iuhKacXuOeu8QA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqm08n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 19:34:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJQNQ7017260;
 Mon, 17 Aug 2026 19:34:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvyhej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 19:34:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HJYZoY39780702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 19:34:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 304B058061;
 Mon, 17 Aug 2026 19:34:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4983258058;
 Mon, 17 Aug 2026 19:34:34 +0000 (GMT)
Received: from [9.61.135.83] (unknown [9.61.135.83])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 19:34:34 +0000 (GMT)
Message-ID: <0d26ced3-a75d-4d97-83b1-918946cbe6c7@linux.ibm.com>
Date: Mon, 17 Aug 2026 15:34:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/s390x/ipl: Add secure boot support to PCI dev
 IPLB builder
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-2-jdaley@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-2-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfX3Q10emp2zMZN
 KMMq2vLm5VTF9PHjNmFrrBFle9bMsuMYfbzWR94i6VjqgYtOok4zXwJBRSwupGDOCmQKLWY8XqA
 VQnnjUG3Up1Do1ypTDp1K3XCZ6iiuzwzlqk8bGCFAR5pKJr9vaR/WEyyZmAotSdjC+uoeoOK6Zx
 Q/vJ5sWfklSXWuInuKO2P9VQTuiaUmoWLBHxl/GnLIJT+Kpu/hKrpZAed9ZF3rVf3PgM6tuWH/e
 hEqTssGnS40lcXMZUAZ9biCszKL2S0GEx4lwH52fz5NwTnKlK1NRIzME7IXnh0PX5YVPTTbqAeV
 cSgPUi3gQfyXqaNNR740HU2+5WKJTEmun7dxzTjOW+7MCnvgIDpZFQvdW2D5zRN/SkrgFqUq4j1
 TL5Q4vtfgk7C5A7+bDYri8V5xZt990Jc75FWJxxcyM9DHBTAial0rNdONluN7X26jFUmJ0NTg9G
 mJMeeWX4qroTZ61j61w==
X-Proofpoint-ORIG-GUID: 8gPXqXgXIuxiL9x-44Duv-USQTkJUfp0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0OSBTYWx0ZWRfXxlRmd+C7SA0w
 x59xCBudF8k6sJ0mCw8T5ZtvCUHZuSixRWSy5wJYBO2dUe+1JX53B5t/9kZEAMG6LxYr4MU6MZO
 1LM42TkmxNJiLQ9IxlPraMlwiq0/QAo=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a83624d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=a9JAC6N6xCBNM2pEOWoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8gPXqXgXIuxiL9x-44Duv-USQTkJUfp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

On 8/12/26 11:21 AM, Joshua Daley wrote:
> In the PCI boot device case of s390_build_iplb(), call
> s390_apply_secure_boot() to update the IPLB when secure boot or audit
> mode are enabled.
> 
> Secure IPL is now supported for virtio-blk-pci boot devices.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>  hw/s390x/ipl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d59ed36c78..b0da3cbb27 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -599,11 +599,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>  
>      pbdev = s390_get_pci_device(dev_st, &devtype);
>      if (pbdev) {
> -        if (s390_secure_boot_enabled() || s390_has_certificate()) {
> -            error_report("Virtio pci boot device does not support secure boot!");
> -            exit(1);
> -        }
> -
>          pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
>          if (pci_lp && strlen(pci_lp) > 0) {
>              lp = pci_lp;
> @@ -625,6 +620,9 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>          s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>          iplb->flags |= DIAG308_FLAGS_LP_VALID;
>  
> +        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled(),
> +                               s390_has_certificate());
> +
>          return true;
>      }
>  


