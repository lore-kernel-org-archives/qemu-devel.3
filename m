Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29CEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRTY-0000aM-A3; Mon, 14 Jul 2025 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubPs6-0002UZ-5z; Mon, 14 Jul 2025 16:34:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubPs3-00052J-Eg; Mon, 14 Jul 2025 16:33:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EC9qXa014315;
 Mon, 14 Jul 2025 20:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ldO2pn
 qZcswy4CsebbcUPMvRhkI8/sGhiJd/50jECcU=; b=o1DbFNqeSvxWVmQwY+eB59
 2tblEaWCjaJYHW/ujD8+r5Ax2MYLrMZ4xPVJ4Dn6/EkprFJNgk0Vi6GWoOM2+zPb
 HAxhLA0b7f/IfX0+VjFbtBkLSrTOjwq6kcj6WtAcsOPciFjvpsu0pu7o0JvsQzom
 9eCPQrByjH/oZRtQ50HC0Dq45opbEIwz56sEB6ErYN/yus/n06At1+nQ+BvGuGfj
 ma69tX+QQbXvPelb2wXaWTd3qJlDMnlHey78SVIhFaWG82g5ZSbAu7RXEOKQrgr/
 9ZkK2dymQtD3F32p0UmQrLPN3e10XaSJ8K7M5G65gK4VzLSSm2B+ZQ+PVL9eEKYw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cuqwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 20:33:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EI7l2G025517;
 Mon, 14 Jul 2025 20:33:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pffgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 20:33:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EKXnqE25756352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 20:33:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EE2458043;
 Mon, 14 Jul 2025 20:33:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D610658053;
 Mon, 14 Jul 2025 20:33:47 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 20:33:47 +0000 (GMT)
Message-ID: <3554d5e0-fbc7-4fbd-8751-20ae65303134@linux.ibm.com>
Date: Mon, 14 Jul 2025 16:33:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/28] s390x: Guest support for Secure-IPL Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 brueckner@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-18-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -0g8vJ4zGP0MHu6FvViQ1q4vD572csnO
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=687569af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=9pBGCdmQIZU1aQmb22IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -0g8vJ4zGP0MHu6FvViQ1q4vD572csnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzNSBTYWx0ZWRfX6tEvYllb8RNw
 XJDOLgIKk18W2J6uuSRkXWv60wErAOTTIBN/zBciC9EK66gChN93YP2CsDWYloqa8QBf3qNXe++
 5b2Up20NoPHHnxtL5UyRQJF926vcxPlY/5fTIM7oDvS9j5BytBMAQhjsoFkWvJJx52uhB4byHNX
 8+KZh92VZoQOI6iYz45kY96XEo1T+/odtXR8G2k0OpoJZ6dlqtVRlepgqO27xnwf8bzveBHjYcg
 o/FjJ2dLzXfIPO1DQ4LKjBq+YOkGmDaDL8u8rHplDeVLdBLcs02P5/JOCPn98SP/a5qI9ciE9rc
 IwzkDh5ux/b9rSxnxpeL4xctBPZh5Pfq2OK77f02n4gxz7S+T6FppMIytvgpauFW/Btw+sX0u6y
 h/YWWBM+tE84xJyQWWWYXwQkPwV5zGPkMisT+novKRjjsm1ywNR4zIwBF2uE0Wn/Gyyn/xHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 7/11/25 5:10 PM, Zhuoying Cai wrote:
> Introduce Secure-IPL (SIPL) facility.
> 
> Use fac_ipl to represent bytes 136 and 137 for IPL device facilities
> of the SCLP Read Info block.
> 
> Availability of SIPL facility is determined by byte 136 bit 1 of the
> SCLP Read Info block. Byte 136's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as a
> check for consistency.
> 
> When SIPL facility is installed, the IPL Parameter Block length must
> contains value that is multiple of 8 bytes.

This has no relevance to the code below.

Add a comment that Secure IPL is not available for guests under
protected virtualization.

> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

I have a few nits below to about some code comments, but the code itself
looks functionally sound.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

@David, would you be able to review wrt adding this to the qemu_max model?

@Christian, @Hendrik, can either of you review wrt that it looks good to
add this feature starting with the gen16a model?

> ---
>  hw/s390x/sclp.c                     | 2 ++
>  include/hw/s390x/sclp.h             | 4 +++-
>  target/s390x/cpu_features.c         | 3 +++
>  target/s390x/cpu_features.h         | 1 +
>  target/s390x/cpu_features_def.h.inc | 3 +++
>  target/s390x/cpu_models.c           | 2 ++
>  target/s390x/gen-features.c         | 2 ++
>  target/s390x/kvm/kvm.c              | 3 +++
>  8 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9718564fa4..69d3328a3d 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -145,6 +145,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>          s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
>                              &read_info->fac134);
> +        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC_IPL,
> +                            read_info->fac_ipl);
>      }
>  
>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index d32f6180e0..bfd330c340 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -136,7 +136,9 @@ typedef struct ReadInfo {
>      uint32_t hmfai;
>      uint8_t  _reserved7[134 - 128];     /* 128-133 */
>      uint8_t  fac134;
> -    uint8_t  _reserved8[144 - 135];     /* 135-143 */
> +    uint8_t  _reserved8;
> +    uint8_t  fac_ipl[2];                /* 136-137 */
> +    uint8_t  _reserved9[144 - 137];     /* 138-143 */
>      struct CPUEntry entries[];
>      /*
>       * When the Extended-Length SCCB (ELS) feature is enabled the
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 99089ab3f5..3f3d6a80af 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -149,6 +149,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>          clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
>          clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>          break;
> +    case S390_FEAT_TYPE_SCLP_FAC_IPL:
> +        clear_be_bit(s390_feat_def(S390_FEAT_SIPL)->bit, data);
> +        break;

There's a comment above this switch case that lists features which are
not supported under PV.  Please add a bullet for "Secure IPL
facilities".  This single mention should be sufficient to cover SCLAF as
well.

>      default:
>          return;
>      }
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 5635839d03..b038198555 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -24,6 +24,7 @@ typedef enum {
>      S390_FEAT_TYPE_SCLP_CONF_CHAR,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>      S390_FEAT_TYPE_SCLP_FAC134,
> +    S390_FEAT_TYPE_SCLP_FAC_IPL,
>      S390_FEAT_TYPE_SCLP_CPU,
>      S390_FEAT_TYPE_MISC,
>      S390_FEAT_TYPE_PLO,
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index 7b13a95d98..956bd8a123 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -140,6 +140,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>  DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
>  DEF_FEAT(DIAG_320, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functions")
>  
> +/* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
> +DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
> +
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
>  DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 33ef5c190c..ab46204d9e 100644
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
> index 86486def23..6ee9bad4c6 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -721,6 +721,7 @@ static uint16_t full_GEN16_GA1[] = {
>      S390_FEAT_UV_FEAT_AP,
>      S390_FEAT_UV_FEAT_AP_INTR,
>      S390_FEAT_DIAG_320,
> +    S390_FEAT_SIPL,
>  };
>  
>  static uint16_t full_GEN17_GA1[] = {
> @@ -922,6 +923,7 @@ static uint16_t qemu_MAX[] = {
>      S390_FEAT_PRNO_TRNG,
>      S390_FEAT_EXTENDED_LENGTH_SCCB,
>      S390_FEAT_DIAG_320,
> +    S390_FEAT_SIPL,
>  };
>  
>  /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 840330709b..fc9cad32a1 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2520,6 +2520,9 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>  
>      set_bit(S390_FEAT_DIAG_320, model->features);
>  
> +    /* Secure-IPL facility is handled entirely within QEMU */
> +    set_bit(S390_FEAT_SIPL, model->features);
> +

nit: change this comment to "Some Secure IPL facilities are emulated by
QEMU"

When you introduce SCLAF, you could add that line-of-code directly below
this one since it's in the secure IPL family.

>      /* Test for Ultravisor features that influence secure guest behavior */
>      query_uv_feat_guest(model->features);
>  
-- 
Regards,
  Collin

