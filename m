Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A86C982CD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yqi-00085u-Sl; Wed, 16 Sep 2026 19:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqe-00082p-FC; Wed, 16 Sep 2026 19:15:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqc-0002dJ-PZ; Wed, 16 Sep 2026 19:15:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1XZr3041088; Wed, 16 Sep 2026 23:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4IPd5N
 1TqvHaIGpuUcxU9hcU1Ca8G3KYLoSfGpnLQRk=; b=SdVtYbrh3JG6UZK9tmf9t7
 R0IdQGwygSp4eqx+m950MC9Qe1bzijGCL3spfvTOi3+bI+ivi3CRSuHnSNW7nqTt
 QV3BSfo+YUrOdbEXOds8hF3q9hKEx+hwtt0EqgtwT9D5dmye2dJf4PxCmQY642DV
 AhGG15BDrmKBy5m2wmhY1rXIPts2f+wco/bmixeaozAjYTPdUXaku7DOxdMEhZ+2
 o0N4KeHgtnRHm/ZWj3jisiMlpT9WTZqYnmET8VyrtG8nHr82+xRKPj3HCDqGr+xl
 l0ryWnyNghuDnJTdqxz4zFegj8Fq7LkOcQjxJNXBhGI66vIC6Ph8qFPJ9X06yI6A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e7415-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMqbhu1713033; Wed, 16 Sep 2026 23:15:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0wqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFLtV26870502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFC6E58050;
 Wed, 16 Sep 2026 23:15:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0438958045;
 Wed, 16 Sep 2026 23:15:21 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:20 +0000 (GMT)
Message-ID: <e489ef6d-a9db-41de-8f90-c4c4e61a886b@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] virtio-ccw: Fix rc check in read configuration path
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-4-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX7rt5mL4QJwy2
 3KNfJSDZq39tT5hBZNSES4kI3eavW7MrSYbdMpqhR2FhxEguQPZHp3IrPD1cE4bL6SEM4GJGEmA
 ZVf1qFuGpPtrCV45aRWjL9ikBUygRWuDDRFtxmY2N03nf9/ItwrPmCbwbJNUAlK4PgUNegFBckL
 hylqiZC1oTtSmKxpQTbqFrU8rC2ygA9GwqGo38E9+V/xiEPsWwpCCDH/m4p+prtT1r+9vxXi4jI
 xm2+gCXNuZdsgNDYzu84nq0jXKT1/e3qtTpKLNLKTVi61IB2RjSg3U28+5nfccnXT3ZEUjFdUPJ
 YfUKB67JRzqDAe3zzqe/SYWigPMnS6I1w4NxTg/MORl2k42leKmvu4QG1EB/KGp3FtSZ6NShBUc
 6ZNPMnx69wDUEIUSz1vJ8auWciysdKaMEBxgjWk6QjuF2+3oDsaAujqmPPQLkGFtRifzcnFEVFU
 LFXU5WQoAHgtpFrRiBg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab230b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=ybHc5JIUn83iXE8OIx8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 66jMM77AnYH7gZBgQYEE701qqncuj_rs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX/jcgAKHQNQ31
 c/PWCpR89Ts2tQz/4KFwtBD0NRPYN9fmFSLUQKIYU0jQCQS41cwASE68u0QAPnijvd0V+ZIyQWi
 YHF4QA9wleTc/sne/Qu1gbtm0Hrn44Y=
X-Proofpoint-GUID: 66jMM77AnYH7gZBgQYEE701qqncuj_rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> Both the read and write config paths use wrappers around cds->op_handler,
> depending on the direction the I/O is flowing. But they expect opposite
> values in the returned variable to indicate success.
> 
> Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
> see !ret as success. The end result is some erroneous data in the
> SCSW response data, but the overall success/failure is correct.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/s390x/virtio-ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index d700db405b..4622c5d46d 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -475,7 +475,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          } else {
>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
>              ret = ccw_dstream_write_buf(&sch->cds, vdev->config, len);
> -            if (ret) {
> +            if (!ret) {
>                  sch->curr_status.scsw.count = ccw.count - len;
>              }
>          }


