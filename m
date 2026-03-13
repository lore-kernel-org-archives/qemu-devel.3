Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C5105F7A2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11hd-0002Jo-4W; Fri, 13 Mar 2026 08:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w11hc-0002Jb-6l
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:33:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w11ha-00032U-L2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:33:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D4GBlh2278339; Fri, 13 Mar 2026 12:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pZ0CkT
 pT4iJjLwNiuUBW7qD+8TM6i5Mqhy8FRQgm7Vc=; b=pA9cRzSRl/vn/O3ZQI3yuU
 Qh9692oXRVoNWhSGKX7OyNjief6BgoUWZu99QWJc4jHH0GdZ+4MGKCyyp4HwLD/k
 21FvlyfU3OVPw8gndSOQS9lztU6YpYSUeV1Gp7tzwOuUbSwvUYGVa+M1NSi7ByA+
 JpKix0kfi9MJsurS/vXFaobUX/5l8IZdcWOzow7Hunr6UHOC149DnkhRDub+qdAF
 fwPOmF/p5s5GyKRtiGuYpz/f6ih6pPVpt4AhJxsjihgIvEcDhnwe06Uk9X6BxO4n
 /Ws57PQ4MLtjSfX1mNQAw4OETMYJKsnK7RMdjDDmBrQnzdojtgf4dewa/RDIhmdw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91qra5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:33:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAHvi4006563;
 Fri, 13 Mar 2026 12:33:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pm3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:33:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DCXBWo5636708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 12:33:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C41E58045;
 Fri, 13 Mar 2026 12:33:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69E9858050;
 Fri, 13 Mar 2026 12:33:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 12:33:10 +0000 (GMT)
Message-ID: <3aa7c0b1-a6c2-4037-b0e4-20279204b503@linux.ibm.com>
Date: Fri, 13 Mar 2026 08:33:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] hw/tpm: Refactor CRB_CTRL_START register access
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
 <20260312041650.181411-3-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260312041650.181411-3-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fXfRP77EFe8zk3wy8YXWmjR1kQYRyH6L
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b40409 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=KPsyjuvybIxOXCdSSHAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5OSBTYWx0ZWRfX6TJ+vPNzGv2B
 LUTXxJf4qFJqgLnrOGghmRtwQ8FQMyqmlU+1o4Y0KfHrCC852mtAsocESKRwcHfv/TIIKCs3whQ
 OSVOo97YY+sjCyHd0TwOs12p4ZWKxciwJroEYYDpuBs9NsMlINJhItVq2D1tyANYCDkS5IvG15L
 nkpOm6mRyuQk40xpq08/jtYETxwhafU+AKT4M9WfChjXqmBE3TrJNoX0RqUv6J2VC+ZKr5zlJkb
 Pttepx4Alv2aiBSBqQ832Z9cqcGUKDDkapGGxNvCenPS6APW79TdIIWcb14nKhLqkz2Smm7DB5Y
 x1qF0cn2icyQIpar8J1NCqxTfzgwOeAHT3kIUxgWI86W23NN4/VWJO6z0PALabC06pQhdkQ3qhC
 MPHy44oOwqE2rUX2ghl/FbE43kS5gRSOqQ7H9Mwq7VeD6wLhMUTeWygVL0ZqgCrKkbCy9z661Kk
 hvPo8iJe5Q82WmWLi1w==
X-Proofpoint-ORIG-GUID: fXfRP77EFe8zk3wy8YXWmjR1kQYRyH6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/12/26 12:16 AM, Arun Menon wrote:
> Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
> No functional changes.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/tpm/tpm_crb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 0a1c7ecdc6..bc55908786 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>               tpm_crb_get_active_locty(s) == locty) {
>               void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> 
> -            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
>               s->cmd = (TPMBackendCmd) {
>                   .in = mem,
>                   .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
> @@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
>   {
>       CRBState *s = CRB(ti);
> 
> -    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
>       if (ret != 0) {
>           ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
>                            tpmSts, 1); /* fatal error */

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

