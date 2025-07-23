Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C672DC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uehkX-0004zd-PA; Wed, 23 Jul 2025 18:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uehkT-0004vs-13; Wed, 23 Jul 2025 18:15:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uehkQ-0001pD-Mv; Wed, 23 Jul 2025 18:15:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NKVtLS027632;
 Wed, 23 Jul 2025 22:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/K4jlx
 bgupkrqCbdD0nVrT0XeuQ2EZcrUs9wMlv+t+U=; b=K93Lhsm3ZuiBhJBrfAkNF0
 3+xwiQIySEXcy3Ww0j8YtIuKeq9ngT2LI3m6OUJ9yJ1B0LCiMxg/PbRZXI298KB6
 bz8A39UZCke0vkA9BCYgoXY1BD9Z2syRmg5mMqcbivwq+zHH47uNljv3KDKmY13E
 Uer5wlDwLxJJpUd2xd7+rA3xObKj5OrxafKyJYfBHdR6uR926TJWv7GGzOHIbDEp
 JPd2aLN/sKayjTpByFkzIDTu8qZcXtDDr/OA2dcXqdG9Xr8ZaKyu23t3X5lOdoNo
 9iI7/ThrIlnRJaodYKoi3hdhlLowlqAv90XHsjfk/M1TAhW8oqU9My4VUkPz8g1w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5qa3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 22:15:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NKbeaw005057;
 Wed, 23 Jul 2025 22:15:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8g0x1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 22:15:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56NMFWMT18940654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jul 2025 22:15:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCAE25805B;
 Wed, 23 Jul 2025 22:15:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B12E58058;
 Wed, 23 Jul 2025 22:15:31 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 23 Jul 2025 22:15:31 +0000 (GMT)
Message-ID: <6bc858c5-ad3a-4445-900f-5aba34011553@linux.ibm.com>
Date: Wed, 23 Jul 2025 18:15:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MCBTYWx0ZWRfX+Yu0oY2lGirq
 d5iGXGdkab6BTy0ql7AmNLnpm11JDFtwxo4SkiiKw+vOXmeCueG7F1L53zbsyV7/oAP0aCE/Qlc
 VFvPOM4YL0xYYX+AAmFV1hQ7xXkZhKZD+E1N/1dDUaAb3f4zLTA8o6PpKtntZDJEfIqSVjzapd6
 QEF8F/VWzJzfIhDKGuDJwsS6xzFfl8HYCWfHvHGrclzWRO3fJLXaK0NW3OMjjFynxRFABZgcTnr
 TQnff3nVzW3IxD/Is6Gp8uL8iuZDIf1R1tm/vWNBmZEwW3S8TAX9NSR9sMobxJBl8wf5x+9i8Kv
 HOURj9/fVa9gx0Mqesm9ix2uwjjd2d7i71OL1ZPwGLSjmBKEGdh3Hc+KxVYnm+Q6R5mReQMk3oM
 3T9ub2ILybmSi2h4aegeqETw0KRT+rxh+2USvMFghDvObwSotzr4gAM4IXf+Ek7BlAIuHCG+
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=68815f06 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=ge0uEXs9HacO7RU2KJYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TBOXDnnp_HqJahL8sF9uitJuoqZPjvxB
X-Proofpoint-ORIG-GUID: TBOXDnnp_HqJahL8sF9uitJuoqZPjvxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 7/11/25 17:10, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates.
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.

This is general DIAG knowledge.  Remove this sentence.

> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully.
> 

Please add more detail describing where the data that the VCSSB gets
filled with comes from (s390 cert store), how this subcode is useful
(e.g. getting num of certs, knowing how much space may need to be
allocated to store a cert).

There are some #defines for the VCE (cert entries) and VCB (subcode 2
data structure).  Please elaborate on them in the commit message.

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/diag320.h | 23 ++++++++++++++++++++++
>  target/s390x/diag.c            | 36 +++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 713570545d..3916a2915e 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -11,7 +11,30 @@
>  #define S390X_DIAG320_H
>  
>  #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
>  
>  #define DIAG_320_RC_OK              0x0001
>  
> +#define VCSSB_MAX_LEN   128

This is just the size of the struct, right?  Why not just use sizeof
instead of this define?

> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
> +
> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000

FYI: need a bit for subcode 0 (as Eric mentioned)

> +
> +struct VCStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t total_vc_ct;
> +    uint16_t max_vc_ct;
> +    uint32_t reserved3[7];
> +    uint32_t max_vce_len;
> +    uint32_t reserved4[3];
> +    uint32_t max_single_vcb_len;
> +    uint32_t total_vcb_len;
> +    uint32_t reserved5[10];
> +};
> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> +
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 7b9b47a171..1f7d0cb2f6 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -191,9 +191,13 @@ out:
>      }
>  }
>  
> +QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != 128,
> +                   "size of VCStorageSizeBlock is wrong");
> +

I'm unsure of why this is needed?  It's not necessarily up to the build
to determine that the data structure sizing hasn't been tampered with.
See below, which may help clarify where the 128 bytes need to be checked.

>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
>      S390CPU *cpu = env_archcpu(env);
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>      uint64_t subcode = env->regs[r3];
>      uint64_t addr = env->regs[r1];
>      int rc;
> @@ -215,13 +219,43 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>      switch (subcode) {
>      case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism =  0;
> +        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
>  
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
>              return;
>          }
>  
> +        rc = DIAG_320_RC_OK;
> +        break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        VCStorageSizeBlock vcssb;
> +
> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock),
> +                                  true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }

There is a piece missing of the "negotiation" between here and the
userspace.  Userspace must set the length to a "minimum of 128 [bytes]
...; otherwise, a response code of 0x0202 is returned ..."

So, you're going to need to read the VCSSB denoted by addr and check
that the length field is >= 128.  Otherwise set that response code.

Check out function `get_vcssb` in the kernel cert_store.c file for guidance.

> +
> +        if (!qcs || !qcs->count) {
> +            vcssb.length = cpu_to_be32(4);

Please use a #define instead of a literal.  4 is denoted as the length
set if no certs are found.

> +        } else {
> +            vcssb.length = cpu_to_be32(VCSSB_MAX_LEN);
> +            vcssb.version = 0;
> +            vcssb.total_vc_ct = cpu_to_be16(qcs->count);
> +            vcssb.max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
> +            vcssb.max_vce_len = cpu_to_be32(VCE_HEADER_LEN + qcs->max_cert_size);

This field is suppose to represent a constraint imposed by the cert
store that denotes the largest sized cert that it will allow to be
stored, not necessarily the "size of the largest cert currently stored"
(that is reserved for max_single_vcb_len below).  I do not think you
have such a limitation in place, so it may be safe to ignore it?

Kernel only prints this field for debugging.  Your code later on doesn't
utilize it.

> +            vcssb.max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
> +                                                   qcs->max_cert_size);
> +            vcssb.total_vcb_len = cpu_to_be32(VCB_HEADER_LEN +
> +                                              qcs->count * VCE_HEADER_LEN +
> +                                              qcs->total_bytes);
> +        }
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &vcssb, sizeof(VCStorageSizeBlock))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>          rc = DIAG_320_RC_OK;
>          break;
>      default:


-- 
Regards,
  Collin

