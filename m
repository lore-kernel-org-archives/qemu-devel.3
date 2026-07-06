Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC1AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgj7f-000423-3x; Mon, 06 Jul 2026 09:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wgj7d-00041k-8i; Mon, 06 Jul 2026 09:12:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wgj7b-0004iY-KX; Mon, 06 Jul 2026 09:12:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666BIUJL3465400; Mon, 6 Jul 2026 13:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c/y6sl
 2AC9ZXA3VdGh/npFnUtVe9a5t+tYPNgb7yWnw=; b=VeOm/uyG54NJH3s4az9GxW
 1gGhjTfoaZqTCd2lzemyzQ49XdWHeKmrRPSWfaQouFjBfx0pRwePccZNKWMcwQc8
 GgPgBU4COw2UJuNp6i3Gd+/NoE7HGWStMfDs3/VQokX614/SzDX86yoE1QzsJmTl
 YgGzhJNfKD6uNo4GdDeI9rj3X0f4ZJwy0+43gmA4pldCiJzXIWwrH/9YVczAGs02
 uMB75uVoDNlAqzA7aUk6VNIB/3HkfN0BY+1v9EO45scOQVGuC32RIOfLLD239j9o
 CNXgsbaJZjseDOLm33rSdkxIgsLzG87ZZMkp/tB0rZDudr413EyAseemmuclPqLw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdj63u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 13:12:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666D4ppI014737;
 Mon, 6 Jul 2026 13:12:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwf1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 13:12:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666DCKBL28312014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 13:12:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79A225804E;
 Mon,  6 Jul 2026 13:12:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 448465803F;
 Mon,  6 Jul 2026 13:12:19 +0000 (GMT)
Received: from [9.61.71.99] (unknown [9.61.71.99])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 13:12:19 +0000 (GMT)
Message-ID: <e53af8c6-b854-44c2-b61d-2317ea2c0bd6@linux.ibm.com>
Date: Mon, 6 Jul 2026 09:12:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390x/sclp: reject invalid write event data headers
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-2-borntraeger@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260706091909.864405-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4ba9b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=oAhc_OkXt0xxt9SrcpAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfXyZIAVLz4Gj8/
 igtA+s1GM9cV9UXLJAPL6l6Qab9nH0d1MbAv/yKUox/LE5zACasB2YOKTNLgu71Xxys7Ep9nFVd
 WOrHR3948K1Ex8ie9IwTww5vAfx7KBYOrcqdqFMZXb8CsSuhyiVqKXz08hCJ5Signic1nk/lqJ/
 QE18T9Le0c8JZco4pw1NAL4DpvVrJYb280JsKvCaqJ+o4x10uLoqhPXEI+v+wDTLGVjJxEKoUUX
 vRnK3WaHGRmeVGdh6qM/W26IQY6YoPaQInLZAY6l8i173/9+CBh/WgPCOFxKENYch3Bhmg8m+xi
 4uJgY64nyeG+SZBBaY4m38VVgQM5ktKHOLfQgJkcOKbCXA4p5Y9CiAvSIVS28bk9h9OZ4JYa0q/
 xjH0VMV76RVoVD/3Ifg/XRs27zEfRu6NbppcpOcs/Fen6d5t0fFm4cVvCplosu07LLdZUZ/iFFX
 Uxl5bsEYGHYIwoL930w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX5orYaT4lTFir
 RrKavWm5shGIkggvRVOuslf1js0pfeWMro3jxhsIVtrV+PVp7A2/ZsuNYJDV1Y0834wTKattFwD
 436HKsqvf+4o8SSQkBih4sYRhtjrujM=
X-Proofpoint-GUID: yKy9YCC356ryf3_7ua-QnoXoF4QghFZd
X-Proofpoint-ORIG-GUID: yKy9YCC356ryf3_7ua-QnoXoF4QghFZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060130
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/6/26 5:19 AM, Christian Borntraeger wrote:
> If a guest submits an sccb with a tiny header length but a large number
> of event mask entries, the write_event_mask handler will
> 1. return the wrong RC (ok instead of error)
> 2. write to memory after the allocated sccb in qemu host memory.
> 
> Add the necessary checks.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>  hw/s390x/event-facility.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index fee286ea63..184c469bd3 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -286,6 +286,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>  static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>  {
>      WriteEventMask *we_mask = (WriteEventMask *) sccb;
> +    uint16_t sccb_length = be16_to_cpu(sccb->h.length);
>      uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
>      sccb_mask_t tmp_mask;
>  
> @@ -294,6 +295,11 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>          return;
>      }
>  
> +    if (sccb_length < sizeof(WriteEventMask) + 4 * mask_length) {
> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +        return;
> +    }
> +
>      /*
>       * Note: We currently only support masks up to 8 byte length;
>       *       the remainder is filled up with zeroes. Older Linux


