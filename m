Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF5C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UNe-0005Bs-J7; Thu, 17 Apr 2025 14:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5UNP-000597-33; Thu, 17 Apr 2025 14:54:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5UNK-0006ru-0m; Thu, 17 Apr 2025 14:54:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HIPU1J003083;
 Thu, 17 Apr 2025 18:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r2PXBj
 wnll7LPm8G29W5r4UCMLji/Ho1jASrvncgBgQ=; b=g/r0scMU7mPy9FJepXdON7
 8KwNNmOitoTC4EeLlF8o26Es3JWPd/dVvBt8mDwmDxGA3P8qkMeMm26F6/Ag2BUu
 jRer8xu5u6hd7ezK3cgWPOBAsg/qo9l12A1wfAWY82uW/kFh5XYr/5bU+7sE9Jlj
 1/UNHd/gwJV7kolq7IXJ648Ip0u6QXq5S3yuKo4/qh7t6QAfkCOtMpzqKWihM084
 Cx3TNgXW8ZpN2awI5OLdy+r+sFnbQRaOqUmLOtWtFyhN/o+LxMEZQK2AV/sxS0hn
 zTyQRJTwfovcrJoawgz/t0NOqCpd+3vQHNGtCDssha6o2X4kxwylZ7cxk10pAVwg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462yjjakx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 18:54:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HIGOpV017170;
 Thu, 17 Apr 2025 18:54:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m7282-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 18:54:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HIs85l23986860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:54:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 577165803F;
 Thu, 17 Apr 2025 18:54:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2A4E58061;
 Thu, 17 Apr 2025 18:54:07 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Apr 2025 18:54:07 +0000 (GMT)
Message-ID: <9f3e4869-e4ce-4480-9c6b-4ed2030e81e2@linux.ibm.com>
Date: Thu, 17 Apr 2025 14:54:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/24] s390x: Guest support for Secure-IPL Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-15-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250408155527.123341-15-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lkwoAEo1Ht-BajLxPX_oGRdxnv5HeEH-
X-Authority-Analysis: v=2.4 cv=MsNS63ae c=1 sm=1 tr=0 ts=68014e53 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=s11BkKu2StZtikTM1toA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lkwoAEo1Ht-BajLxPX_oGRdxnv5HeEH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504170136
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/8/25 11:55 AM, Zhuoying Cai wrote:
> Introduce Secure-IPL (SIPL) facility.
> 
> Use the abbreviation CBL (Consolidated-Boot-Loader facility at bit 0 of
> byte 136) to represent bytes 136 and 137 for IPL device facilities of the
> SCLP Read Info block.

This should *not* be used to label these bytes!  This facility is
represented by a specific bit on the entire byte, and the other bits are
used for multiple things unrelated to CBL.

Just use the generic byte-naming scheme (e.g. fac136) for now until
these bits are defined and a better name comes up.  Further, you only
need byte 136 for the secure IPL bit.

Further, explain the significance for the dependency of ELS in the
commit message:

"Byte 136's facilities cannot be represented without the availability of
the extended-length-SCCB, so add it as a check for consistency."

> 
> Availability of SIPL facility is determined by byte 136 bit 1 of the
> SCLP Read Info block.
> 
> When SIPL facility is installed, the IPL Parameter Block length must
> contains value that is multiple of 8 bytes.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/sclp.c                     | 2 ++
>  include/hw/s390x/sclp.h             | 4 +++-
>  target/s390x/cpu_features.c         | 3 +++
>  target/s390x/cpu_features.h         | 1 +
>  target/s390x/cpu_features_def.h.inc | 3 +++
>  target/s390x/cpu_models.c           | 2 ++
>  target/s390x/gen-features.c         | 1 +
>  target/s390x/kvm/kvm.c              | 3 +++
>  8 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 5945c9b1d8..bab65955b7 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -145,6 +145,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>          s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
>                              &read_info->fac134);
> +        s390_get_feat_block(S390_FEAT_TYPE_SCLP_CBL,
> +                            read_info->cbl);
>      }
>  
>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index d32f6180e0..97af95a78d 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -136,7 +136,9 @@ typedef struct ReadInfo {
>      uint32_t hmfai;
>      uint8_t  _reserved7[134 - 128];     /* 128-133 */
>      uint8_t  fac134;
> -    uint8_t  _reserved8[144 - 135];     /* 135-143 */
> +    uint8_t  _reserved8;
> +    uint8_t  cbl[2];                    /* 136-137 */
> +    uint8_t  _reserved9[144 - 137];     /* 138-143 */
>      struct CPUEntry entries[];
>      /*
>       * When the Extended-Length SCCB (ELS) feature is enabled the
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 99089ab3f5..e9371569cc 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -149,6 +149,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>          clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
>          clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>          break;
> +    case S390_FEAT_TYPE_SCLP_CBL:
> +        clear_be_bit(s390_feat_def(S390_FEAT_SIPL)->bit, data);
> +        break;
>      default:
>          return;
>      }
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 5635839d03..823fcf8b90 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -24,6 +24,7 @@ typedef enum {
>      S390_FEAT_TYPE_SCLP_CONF_CHAR,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>      S390_FEAT_TYPE_SCLP_FAC134,
> +    S390_FEAT_TYPE_SCLP_CBL,
>      S390_FEAT_TYPE_SCLP_CPU,
>      S390_FEAT_TYPE_MISC,
>      S390_FEAT_TYPE_PLO,
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index 65d38f546d..f874b9da6f 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -140,6 +140,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>  DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
>  DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")
>  
> +/* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
> +DEF_FEAT(SIPL, "sipl", SCLP_CBL, 1, "Seucre-IPL facility")
> +
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
>  DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7d65c40bd1..a83c27dcb8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -263,6 +263,7 @@ bool s390_has_feat(S390Feat feat)
>          case S390_FEAT_SIE_CMMA:
>          case S390_FEAT_SIE_PFMFI:
>          case S390_FEAT_SIE_IBS:
> +        case S390_FEAT_SIPL:
>          case S390_FEAT_CONFIGURATION_TOPOLOGY:
>              return false;
>              break;
> @@ -507,6 +508,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>          { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>          { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>          { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 52c649adcd..d973efbf72 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -697,6 +697,7 @@ static uint16_t full_GEN14_GA1[] = {
>      S390_FEAT_SIE_KSS,
>      S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>      S390_FEAT_DIAG_320,
> +    S390_FEAT_SIPL,
>  };
>  
>  #define full_GEN14_GA2 EmptyFeat
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a5c5150c04..f418102b7f 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2517,6 +2517,9 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>  
>      set_bit(S390_FEAT_DIAG_320, model->features);
>  
> +    /* Secure-IPL facility is handled entirely within QEMU */
> +    set_bit(S390_FEAT_SIPL, model->features);
> +
>      /* Test for Ultravisor features that influence secure guest behavior */
>      query_uv_feat_guest(model->features);
>  


-- 
Regards,
  Collin

