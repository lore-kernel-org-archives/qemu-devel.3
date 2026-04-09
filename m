Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB66F364AF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvHw-00017i-7v; Thu, 09 Apr 2026 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wAvHu-00017C-GZ; Thu, 09 Apr 2026 15:43:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wAvHr-000678-QL; Thu, 09 Apr 2026 15:43:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Btf6c2326504; Thu, 9 Apr 2026 19:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pwu/GO
 ti/LMvT0MMO9Q6w6HxagD+3bgEP/yj3HKjAxk=; b=s0DcmGvA+f62QDK+SwrGAd
 IadQyjXVZG1Qk5WMDHthXzxhaNQgEWqi4JBQxw4Iu41EZGDi3QCP8tzKpDT33tJe
 OFoel3x//rMRar82CGq4WEFZUii/Im4ePFOcaQy+N6gYFRkeWedbqGOZH6n/b7c6
 /nQ0+2ZfqpnSnrIWqtg2RAKHnfnb3R/49nT30LE5AYBzLKSBKh3dH9ic+Jbp4n2j
 xHxlSM9E/MG2e5FLTGZAF6zwgjIOU6UnjjeSK/R8HRf5I75nU20B+hMn98kctdf8
 xWz0dv7/nBjmUjbCcC8NsbkhDyi5isDGNZpwGCUYlJOpKY/ObwVxsrgRXxlQzyCA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2knw6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 19:43:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Gs6Q3007887;
 Thu, 9 Apr 2026 19:43:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2n5fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 19:43:30 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639JhSmC4915894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 19:43:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9F7158054;
 Thu,  9 Apr 2026 19:43:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DE8A58050;
 Thu,  9 Apr 2026 19:43:27 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Apr 2026 19:43:27 +0000 (GMT)
Message-ID: <c71076df-61b5-41dc-888f-941fe1babef7@linux.ibm.com>
Date: Thu, 9 Apr 2026 15:43:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/30] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
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
 <20260402221453.1602899-16-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NyBTYWx0ZWRfX71uDMlZvMURe
 Y7ka9/dozLKK7wrXgmq1xniJNLW8raHDxPJiYyIsPoPuwumpwf1z+qrEvQ+79A9T+x793f5I/+D
 3dxCN+WRpOU6c8t0Tyc5ofKFtDGehBpJQYM3uMvUiybVxsbHB+Xh4wEbuNh4hs/rq5khk/n3b5X
 CA7fmhvHjCENj0lqwCfUkWtzuc8pEQF5O3k49jzPukm1Z4V/ACwdsXgTvcWlNlBf0/ArSB7o+V/
 +FM10D0qq/PbboIBNFJUjfVTreuLGetLIIzGttw9wArQUPk6ACXSg8boscbFVyldepJZjjZZxoO
 be5ttDvr0ALOFxmHCIKpUIkXU1kxPMvR9bDOgQGmS0r31fNJ7x6BDxDP+53ctfsy2oGyWloMYs5
 RtEA07xZ8eQlxYNzYbCqsdHapFlj/x4QZFjevo8uHGRsN1HpRRWyC3kSdzSIF0FJJwAJhnnjPyc
 +3ywPy400xkLmMLFU2A==
X-Proofpoint-ORIG-GUID: 6d3pN-_VGajC0hKcvVt2ViSGqezM9QyL
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d80163 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=cmNwAlJb-CzU7YONYswA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6d3pN-_VGajC0hKcvVt2ViSGqezM9QyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Add IPIB flags to IPL Parameter Block to determine if IPL needs to
> perform securely and if IPL Information Report Block (IIRB) exists.
> 
> Move DIAG308 flags to a separated header file and add flags for secure IPL.
> 
> Secure boot in audit mode will perform if certificate(s) exist in the
> key store. IIRB will exist and results of verification will be stored in
> IIRB.
> 
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c                 | 21 +++++++++++++++++++++
>  hw/s390x/ipl.h                 | 21 +++++----------------
>  include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/s390x/ipl/qipl.h    |  5 ++++-
>  4 files changed, 64 insertions(+), 17 deletions(-)
>  create mode 100644 include/hw/s390x/ipl/diag308.h
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fbef46aee5..f4311f6d62 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -461,6 +461,13 @@ S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
>      return &ipl->cert_store;
>  }
>  
> +static bool s390_has_certificate(void)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +
> +    return ipl->cert_store.count > 0;
> +}
> +
>  static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>  {
>      CcwDevice *ccw_dev = NULL;
> @@ -517,6 +524,20 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>          s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>          iplb->flags |= DIAG308_FLAGS_LP_VALID;
>  
> +        /*
> +         * Secure boot in audit mode will perform
> +         * if certificate(s) exist in the key store.
> +         *
> +         * IPL Information Report Block (IIRB) will exist
> +         * for secure boot in audit mode.
> +         *
> +         * Results of secure boot will be stored in IIRB.
> +         */
> +        if (s390_has_certificate()) {
> +            iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
> +        }
> +
>          return true;
>      }
>  
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 57f6a072a0..6967ecaf6e 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -23,7 +23,6 @@
>  #include "qom/object.h"
>  #include "target/s390x/kvm/pv.h"
>  
> -#define DIAG308_FLAGS_LP_VALID 0x80
>  #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
>  
>  void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
> @@ -90,21 +89,10 @@ struct S390IPLState {
>  };
>  QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>  
> -#define DIAG_308_RC_OK              0x0001
> -#define DIAG_308_RC_NO_CONF         0x0102
> -#define DIAG_308_RC_INVALID         0x0402
> -#define DIAG_308_RC_NO_PV_CONF      0x0902
> -#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> -
> -#define DIAG308_RESET_MOD_CLR       0
> -#define DIAG308_RESET_LOAD_NORM     1
> -#define DIAG308_LOAD_CLEAR          3
> -#define DIAG308_LOAD_NORMAL_DUMP    4
> -#define DIAG308_SET                 5
> -#define DIAG308_STORE               6
> -#define DIAG308_PV_SET              8
> -#define DIAG308_PV_STORE            9
> -#define DIAG308_PV_START            10
> +#define S390_IPL_TYPE_FCP 0x00
> +#define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PV 0x05
> +#define S390_IPL_TYPE_QEMU_SCSI 0xff

Aren't these S390_IPL_TYPE_*'s already defined in
`include/hw/s390x/ipl/qipl.h` as an enumeration?

[...]

-- 
Regards,
  Collin

