Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973D2F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBIEx-0008Ht-A0; Fri, 10 Apr 2026 16:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBIEv-0008Fu-5b; Fri, 10 Apr 2026 16:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBIEt-0002aV-Kf; Fri, 10 Apr 2026 16:14:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AF1f4F2316587; Fri, 10 Apr 2026 20:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kfvwNI
 2gOa3l8AZ2/vsOSUvc1ctLZ1s1lcM2aATiiJI=; b=n+4W/hA16jFeg0e3hgZCgj
 /NkCEkY1CqMoJsjzV9vipZYkP9NuVAbreljrV7LRKnK2kcDdFzY7obDH7085BLyz
 fy+RkeYwjYXbOiMJfKRXB5lR2I9edozln9Fdk7aviVyQtfYhwcjULpPwaY988O8/
 EJGESwSjVjjzHiaOl4j8Ouq42sJOBSjRdURd1icOtV9Adyo75nECVXb51Zhkr4O9
 cFBwrHnypm6kfMyCw96XWoD6oEKEAt9wukBRe1x6aoUiCORAl7ilT0ssQ+ZjZG0Q
 V01qbYP4O7GoJxm87L4bz5Pe2Tp+EKxTrCEYU8K1OnN9psYpAPRaTe4V49GYESYA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2gc04p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:13:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AK7Iw3013902;
 Fri, 10 Apr 2026 20:13:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4hvm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:13:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AKDvsn19530318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 20:13:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FABB5805C;
 Fri, 10 Apr 2026 20:13:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D877758051;
 Fri, 10 Apr 2026 20:13:55 +0000 (GMT)
Received: from [9.67.17.158] (unknown [9.67.17.158])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Apr 2026 20:13:55 +0000 (GMT)
Message-ID: <dfb12dba-3e8f-40a1-b198-c8bd5d1457c8@linux.ibm.com>
Date: Fri, 10 Apr 2026 16:13:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 24/30] hw/s390x/ipl: Set IPIB flags for secure IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-25-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d95a07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=YyEUnw4G0FhARttIG-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H7T_RTinfMUWQE4pdnpekGkpJYW6QNu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE4NSBTYWx0ZWRfX5AIMcJzC84HR
 WS8VxJKwnDwL8KSPqtjYgPXgnxPKPn9WU9MDBrss7yGpRrU8RRJLe0G3ulsNwdyAqh4WgDHbnRf
 LXUFmJIVDhSvPKiYPBMOGqCFFuwPIYl3D84kGeWeaoGw5dYHEVOihyVqyQ8kuv8SWtkNvewKHfe
 xjG36C/WDuubd+XCtNMECNfUsBSbHa4WIV1oZNNnWDbJPERZZCmVrCo03n0K0Sv3b4BlEpfuIzI
 5MUIJuKwnV019P3amjG4bfOECr5KQi8gJF+ln4r0eQVbadqw069jKEwUqLzoYEtDHUFTbuYGRCu
 dwQyofy8mpD60Sc/74pFn93TVIMYhi1Y213m4AqktTffwXPeXW8QSSOjG3wE2rPpsIe9LDJ7gWw
 gfPz0mALvFzwvOlEWOpPh/3UqhpWHTkcoXeejjIFAEBwz8se/59tWZcLit8znZmBuNkLZXkOXQY
 S2Y9BO81QwRES2Yxfeg==
X-Proofpoint-GUID: H7T_RTinfMUWQE4pdnpekGkpJYW6QNu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/26 18:14, Zhuoying Cai wrote:
> If `-M secure-boot=on` is specified on the command line option, indicating
> true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
> bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.
> 
> Any error that occurs during true secure IPL will cause the IPL to
> terminate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index f4311f6d62..67e8231c76 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -468,6 +468,11 @@ static bool s390_has_certificate(void)
>      return ipl->cert_store.count > 0;
>  }
>  
> +static bool s390_secure_boot_enabled(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
> +}
> +
>  static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>  {
>      CcwDevice *ccw_dev = NULL;
> @@ -524,6 +529,18 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>          s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>          iplb->flags |= DIAG308_FLAGS_LP_VALID;
>  
> +        /*
> +         * If secure-boot is enabled, then toggle the secure IPL flags to
> +         * trigger secure boot in the s390 BIOS.
> +         *
> +         * Boot process will terminate if any error occurs during secure boot.
> +         *
> +         * If SIPL is on, IPLIR must also be on.
> +         */
> +        if (s390_secure_boot_enabled()) {
> +            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
> +        }
>          /*
>           * Secure boot in audit mode will perform
>           * if certificate(s) exist in the key store.
> @@ -533,7 +550,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           *
>           * Results of secure boot will be stored in IIRB.
>           */
> -        if (s390_has_certificate()) {
> +        else if (s390_has_certificate()) {
>              iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
>              iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>          }

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

