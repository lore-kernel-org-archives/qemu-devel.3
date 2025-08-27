Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C307FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJ5u-0004Hq-ON; Wed, 27 Aug 2025 12:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1urJ5r-0004GG-R3; Wed, 27 Aug 2025 12:33:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1urJ5p-0003b8-Im; Wed, 27 Aug 2025 12:33:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RBGouj019320;
 Wed, 27 Aug 2025 16:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FfsFBD
 WPoBpHkhYrVk5bohJ9ny1EkRCaLXrzMDcr83E=; b=sKZrsHmRXgypf6S3Kya6r6
 C0lZo/Nn1S6fii3jpFCYKpDMu9ndBWPK+1PXGnFsQT/z8B0SIezOGKbd9rTTTV1/
 rrH+s7XN2+BYG846M5IONVAWDYdCxx5Uozrm2YOoJ07KKrBqtXuMrIqUe06ARjcy
 9Ad/vYi/0Yg3uVWWsbpEzGdC16fhjLL7Hh2rwPOl6fuRQPwyhZyv2ZzzKayYZ8Sj
 NZ9WLKIE4oIaUbwhvpCuwEGu0ROw4g89n83ZzkqC4PIpxbtXm1w0OBeP+b7JYWNW
 njSjRy8rIbUUvWfw9wBZkxtCzKz4j3wsLLoLlO3MYMqoagXaGu+XLCu/hpvqO9Bw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975cfma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 16:33:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGH3Ho029986;
 Wed, 27 Aug 2025 16:33:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmrsfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 16:33:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57RGXXcw28050170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 16:33:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611665805A;
 Wed, 27 Aug 2025 16:33:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 389A358051;
 Wed, 27 Aug 2025 16:33:41 +0000 (GMT)
Received: from [9.61.148.204] (unknown [9.61.148.204])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Aug 2025 16:33:41 +0000 (GMT)
Message-ID: <d3d41828-c7e5-4b30-a7c7-cca5a9f0037d@linux.ibm.com>
Date: Wed, 27 Aug 2025 12:33:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/29] hw/s390x/ipl: Set iplb->len to maximum length of
 IPL Parameter Block
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-17-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250818214323.529501-17-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sQctFQg5Ew1NAo64I0UwiDVOwtaH6aYR
X-Proofpoint-ORIG-GUID: sQctFQg5Ew1NAo64I0UwiDVOwtaH6aYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfXw4o0r2uOEQt3
 yaCdmKO+hg/Z5gCYWshLsyWkLpynKO+F3twfHtfbKQFJR1cgAg7PepnojirPu/UI47J2IkhRg1l
 TYqz1hAgTX387lSodUd+jvRu+GK66ayl/MuVp4B8uJVOBNouaSOhqW6CM79u6sEUdUEDWkWcnfI
 TWxp2Lmp8VBeZjz9A2CXcrHJ0lAioVE/R5y5nxYANJtTx0USCCHXa2Btjr8hc6Zg0+GianXFLmq
 eshp/WgWxhERwUM856wau4JexN7opULq7P0is0v05WU9tQtoah9beB21k0FhjOnvv4ugsGyR++E
 7cAx5rMb5uXzy1eST6phb9EJT0GxxhhNn0HGOq78l5+7Io2WN3ir5x4/dKDbLlAUCdBGc09b1nP
 2esSpN+D
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68af3369 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=C9IQg14i1mWWDr6A2ooA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/18/25 5:43 PM, Zhuoying Cai wrote:
> The IPL Information Report Block (IIRB) immediately follows the IPL
> Parameter Block (IPLB).
>
> The IPLB struct is allocated 4KB in memory, and iplb->len indicates
> the amount of memory currently used by the IPLB.
>
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 6 +++---
>   hw/s390x/ipl.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 8ac0cee73d..d1a972ac8d 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -459,7 +459,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               if (scsi_lp && strlen(scsi_lp) > 0) {
>                   lp = scsi_lp;
>               }
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
>               iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> @@ -470,14 +470,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VFIO:
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->pbt = S390_IPL_TYPE_CCW;
>               iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
>               iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
>           case CCW_DEVTYPE_VIRTIO:
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
>               iplb->pbt = S390_IPL_TYPE_CCW;
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 3b8cc5474e..01922d80c4 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -100,6 +100,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   #define S390_IPLB_MIN_CCW_LEN 200
>   #define S390_IPLB_MIN_FCP_LEN 384
>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> +#define S390_IPLB_MAX_LEN 4096
>   
>   static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
>   {
This only needs to be done if the IIRB exists.  See comments on patch 15.

Regards,
Jared Rossi

