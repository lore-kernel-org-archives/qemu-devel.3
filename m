Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CABC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8vyq-00031M-Vi; Tue, 22 Sep 2026 04:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8vyp-00030i-6I; Tue, 22 Sep 2026 04:35:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x8vyn-0008Nb-E7; Tue, 22 Sep 2026 04:35:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M05YB41075441; Tue, 22 Sep 2026 08:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=h45THq
 k1eSs20VxnHlchhd/kw9TpB1/MGoE3826mgSI=; b=ay1DL3fbPiqs6Pt5h/S8be
 5zVGK2gHd08XluQHIHnlp5dWiNvzF3anN847qbLxgmi63fzuv0/LWAIjqd+S5ZpV
 +q/TyrXSmVbr/LvowiMKep2gwkKVkYECwCAdK0kLOLZHtnQ5sy+NHVxH7AcLewhC
 BhwrEwAM7O9Qy1wzwpqrZa2l0hspx5/sKZaCj5g32vZ7kzPEKkZPpPa4AWITxEnJ
 7UrCX/6hn1zJq26CPONXoplbuXbGLtNhca8Gnapsz/kMYh11M+hgDCNu3l5Z/9jK
 k7yOqx8SlcOg1wj9cjnbKyFbT/iNlcGHeYJkIw/x0KB3xTyb3UV0Dyzy7O7PdAyw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1mrv7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:35:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M5RrZs2085626; Tue, 22 Sep 2026 08:35:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq95r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 08:35:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68M8ZnDD45613554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 08:35:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C91DE20043;
 Tue, 22 Sep 2026 08:35:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 600F220040;
 Tue, 22 Sep 2026 08:35:49 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 08:35:49 +0000 (GMT)
Message-ID: <28aae7f2-5522-4034-a23c-6b36135d8d3b@linux.ibm.com>
Date: Tue, 22 Sep 2026 10:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] s390x/css: Use datastream pointer for checking
 no-data CCWs
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-9-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260921184305.3791311-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fnkXreUMdH9tMTIRw4Ws7OiEdgYfnDbu
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab23dea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=9q8SRzXFsfU9OaCgb0EA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyMyBTYWx0ZWRfX9srDqVGbyfnR
 hhYUEPoeGXXQQpCL3L8UmPE+iiYukfNV0B//NoP7yIwacgmAhsvbRVhoy4kMOn+bxIiRwL2ECBy
 NoFhh7wWggZLuL2LXwUCPpx3rYkqcI0=
X-Proofpoint-GUID: fnkXreUMdH9tMTIRw4Ws7OiEdgYfnDbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyMyBTYWx0ZWRfX4lZDMWIgMEfQ
 zsi3gtlbHs7wCdWVlVN9yg1AIL/qYL7GaOvZFcxgu9Ku+D0yYe4D3xtHkBug4A4iaSdPFKMdWha
 fxSOSRZsW+G4b82WiyPB0Je8BMR3l/VBUPXAzqt/FmkPAc4Hnn8LAAHvdDBhwXEL7K+6Dp7SdtK
 fbspV7HTo2V6fV0goz5/J0diFmeNANYnry4qH/e0dQ0f9gZInViOk74kAaQCtZ5PmBq6FyE715M
 ULbtO+dcrXWHTNUWrtqOb0Xs7E5FEu+gOoZRWyhgdHqILjJK94v8RCtnJKPz8vtCIMQHVTojGdI
 pLHyMSQpf02KSZ0uUihx6rERO3H9Fb3TdkRc4aDC8j72Tt59r9VGcJ9C3fC2pv7mLlGnUUmBwcj
 gzTG8LrMdCVLeV6RWe43E0e3X0DjGMhnyYRjfSQxaGwAzCZx66nyvFOOw4f1j0ECt9o86Rbyjsm
 JQHvrf/peC0E0XqrA9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220123
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Am 21.09.26 um 20:43 schrieb Eric Farman:
> The channel subsystem will reject channel programs that incorporate
> 256 CCWs without a data transfer, but the existing check to account
> for this only does so for CCWs with a data address of zero. Other
> valid CCWs that wouldn't transfer data are not accounted for.
> 
> Rather than re-inventing the wheel, use the output of the datastream
> at the end of the entire CCW parsing tree to indicate whether data
> was moved or not.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/s390x/css.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 9da9128d88..10bebdcb1a 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1016,13 +1016,6 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>   
>       check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
>   
> -    if (!ccw.cda) {
> -        if (sch->ccw_no_data_cnt == 255) {
> -            return -EINVAL;
> -        }
> -        sch->ccw_no_data_cnt++;
> -    }
> -
>       /* Look at the command. */
>       ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
>       switch (ccw.cmd_code) {
> @@ -1110,6 +1103,19 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>           }
>       }
>   

These two context lines are the end of

     if (ret == 0) {
         if (ccw.flags & CCW_FLAG_CC) {
             sch->channel_prog += 8;
             ret = -EAGAIN;
         }
     }

so by the time we get here, every successfully executed CCW that has
command chaining set already has ret == -EAGAIN.

> +    /*
> +     * A CCW that transfers no data is allowed, but ensure an upper limit
> +     * is established to prevent long-running channel programs that don't
> +     * move actual data.
> +     */
> +    if (ret == 0 && sch->cds.at_byte == 0) {
> +        if (sch->ccw_no_data_cnt == 255) {
> +            ret = -EINVAL;
> +        } else {
> +            sch->ccw_no_data_cnt++;
> +        }
> +    }
> +
>       return ret;
>   }
>   

Which means this never fires for a chained CCW. The only CCW that can
still be counted is the last one of the program (no CC), and
ccw_no_data_cnt is reset on every SSCH, so the counter can never reach
255. A chain of 100000 NOOPs with CC now runs to completion, while HEAD
rejects it at the 256th CCW when cda is zero. As posted this removes the
protection from e8601dd5d0 rather than extending it.

Moving the check above the CC block (right after last_cmd_valid = true)
should do it, no?


