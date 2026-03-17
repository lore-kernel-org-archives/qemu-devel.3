Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE6F33805
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2OKB-00015s-Mh; Tue, 17 Mar 2026 02:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2OJx-00014v-1f; Tue, 17 Mar 2026 02:54:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2OJt-0006td-W3; Tue, 17 Mar 2026 02:54:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H0X92Y3176840; Tue, 17 Mar 2026 06:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6Csnos
 Vlo8uX5z4cVY700H9kXGpveAG1afKDgQs1bgM=; b=bhhEBxemh2dLbUvnF2OI9N
 CZP8qT17Dm4s8jBA1mB+4wi2v0zQXM4+jFaDOgQOLqwJDuKRDUuFqaLP73jlGNxs
 MY/obmFRwYKTHDhZVRilMPvo0Daa4jOFhC8a3ehovhAh0yHCS10w22Q9xWrqioBw
 iCMa0f0S24JrbaFDTgKC54rYV6LCUBb6OWQZCDYgtdwuAcu7YHMZJu9xFe8nb29y
 6Gz3a8Imrd/aPirioHwCgFAsS4XfGgnC6ubqHFyZ7lBEOUYwcuvlELhj8wqrWrRa
 85jH3turJxESF2x0ZVloGMzXDaH3OzNa0E/LvJFuG13r8FrmsLtoETZUBru5RXAQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cu1e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 06:54:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H6CYaE013997;
 Tue, 17 Mar 2026 06:54:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy02gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 06:54:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H6sIhC29098562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 06:54:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ADF85805A;
 Tue, 17 Mar 2026 06:54:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E0F58051;
 Tue, 17 Mar 2026 06:54:16 +0000 (GMT)
Received: from [9.67.86.225] (unknown [9.67.86.225])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Mar 2026 06:54:16 +0000 (GMT)
Message-ID: <655c1663-787d-4a42-a90e-36798506c303@linux.ibm.com>
Date: Tue, 17 Mar 2026 02:54:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/30] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-23-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b8fa9c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=bsw2H0sJ5yV3TC_93pkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA1NyBTYWx0ZWRfXyXYe2p15tw8l
 o3arb3Y12gAZxYr7AN8K+k2qJ8GYYJk/RhbabY4Syz9KfTPHwIEn+pJx+76haHyE97SVjT/8sY0
 u2JCCLVMApQI4FqfTW5OAneqwA7qfiMeQJJfqksxGqWKiuBpuCFlmGK9/ji+uOczHbNmNvPEGql
 FmkRYgwEqYhjm2I5BUNMhrMaZ2Bp/MV41MG2WWqewucHntmVRCA031Gr3FZuxCkWbeX3BsWq3Xe
 4sUvWfvYxkdGPKA+ruR2RxFQhgaJ8U8xMEzOpOwc6CRCezUQU6bLcmMy8K4ovHP+EYG+73CyEge
 Rs8EW1KgGiwm8ZJrSlei7klMSJcwAVFkUpYRUSxfSYcn71K0kyRpZ9Y6ZA8aUGc0oy29VMParSy
 c7GDmaOMcdjdDxeIzBHtsXDKm5Iz5d7zUJ0VN3a1MlKCYJzR1Qpndxg9LhlxJeTO4IRSYwX8vU6
 X66R5o6yXdlUssbBoxw==
X-Proofpoint-GUID: r9TPIZB7JeDgoZer16U_WwtdF-SBYCrB
X-Proofpoint-ORIG-GUID: r9TPIZB7JeDgoZer16U_WwtdF-SBYCrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 3/5/26 17:41, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
> 
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
> 
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
> 
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
> 
> When SCLAF is installed, its content must be evaluated during secure IPL.
> However, a missing SCLAB will not be reported in audit mode. The SCALB
> checking will be skipped in this case.
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).

This goes back to my comment in patch 19: who/what is going to make use
of the IIRB? If no one or nothing will inspect this data structure, then
perhaps it's sufficient enough to simply log the errors?

> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h   |  29 +++-
>  pc-bios/s390-ccw/s390-ccw.h   |   1 +
>  pc-bios/s390-ccw/sclp.c       |   8 +
>  pc-bios/s390-ccw/sclp.h       |   1 +
>  pc-bios/s390-ccw/secure-ipl.c | 314 +++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/secure-ipl.h |  42 +++++
>  6 files changed, 391 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 1b6cb3231d..9518fcb1dc 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -136,10 +136,20 @@ struct IplInfoReportBlockHeader {
>  };
>  typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
>  
> +/* IPL Info Error Indicators */
> +#define S390_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
> +#define S390_IIEI_NO_SCLAB            0x4000 /* bit 1 */
> +#define S390_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
> +#define S390_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
> +#define S390_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
> +#define S390_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
> +
>  struct IplInfoBlockHeader {
>      uint32_t len;
>      uint8_t  type;
> -    uint8_t  reserved1[11];
> +    uint8_t  reserved1[3];
> +    uint16_t iiei;
> +    uint8_t  reserved2[6];
>  };
>  typedef struct IplInfoBlockHeader IplInfoBlockHeader;
>  
> @@ -163,13 +173,28 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
>  #define S390_IPL_DEV_COMP_FLAG_SC  0x80
>  #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
>  
> +/* IPL Device Component Error Indicators */
> +#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
> +#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
> +#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
> +#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
> +#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLA    0x2000000  /* bit 6 */
> +#define S390_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
> +#define S390_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
> +#define S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
> +#define S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
> +#define S390_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
> +
>  struct IplDeviceComponentEntry {
>      uint64_t addr;
>      uint64_t len;
>      uint8_t  flags;
>      uint8_t  reserved1[5];
>      uint16_t cert_index;
> -    uint8_t  reserved2[8];
> +    uint32_t cei;
> +    uint8_t  reserved2[4];
>  };
>  typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
>  
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index a0d568696a..7d1a9d4acc 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -82,6 +82,7 @@ void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
>  bool sclp_is_diag320_on(void);
>  bool sclp_is_sipl_on(void);
> +bool sclp_is_sclaf_on(void);
>  int sclp_read(char *str, size_t count);
>  
>  /* virtio.c */
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index e3b6a1f07e..5dbddff9ae 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -151,6 +151,14 @@ bool sclp_is_sipl_on(void)
>      return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
>  }
>  
> +bool sclp_is_sclaf_on(void)
> +{
> +    uint16_t fac_ipl = 0;
> +
> +    sclp_get_fac_ipl(&fac_ipl);
> +    return fac_ipl & SCCB_FAC_IPL_SCLAF_BIT;
> +}
> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index cf147f4634..3441020d6b 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>  #define SCCB_FAC134_DIAG320_BIT 0x4
>  #define SCCB_FAC_IPL_SIPL_BIT 0x4000
> +#define SCCB_FAC_IPL_SCLAF_BIT 0x1000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 68596491c5..840b88a699 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -198,6 +198,12 @@ static bool secure_ipl_supported(void)
>          return false;
>      }
>  
> +    if (!sclp_is_sclaf_on()) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
> +             " the hypervisor!");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -258,6 +264,286 @@ static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
>      *addr_range_index += 1;
>  }
>  
> +static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentEntry *comp_entry)
> +{
> +    /* unsigned load address must be greater than or equal to 0x2000 */
> +    if (load_addr >= 0x2000) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_UNSIGNED_ADDR,
> +                          "Load address is less than 0x2000");
> +}

I think I still would have preferred some sort of assert-styled function
that could be used in place of a lot of these simpler functions e.g.:

```
component_check(load_addr >= 0x2000, comp_entry,
                S390_CEI_INVALID_UNSIGNED_ADDR,
                "Load address is less than 0x2000");
```

(Might need a more fitting name, though.)

It's basically the `set_comp_cei_with_log()` function with a boolean
parameter up front.

> +
> +static bool check_sclab_presence(uint8_t *sclab_magic,
> +                                 IplDeviceComponentEntry *comp_entry)
> +{
> +    /* identifies the presence of SCLAB */
> +    if (magic_match(sclab_magic, ZIPL_MAGIC)) {
> +        return true;
> +    }
> +
> +    if (comp_entry) {
> +        comp_entry->cei |= S390_CEI_INVALID_SCLAB;
> +    }
> +
> +    /* a missing SCLAB will not be reported in audit mode */
> +    return false;
> +}
> +
> +static void check_sclab_length(uint16_t sclab_len, IplDeviceComponentEntry *comp_entry)
> +{
> +    if (sclab_len >= S390_SECURE_IPL_SCLAB_MIN_LEN) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry,
> +                          S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
> +                          "Invalid SCLAB length");
> +}
> +
> +static void check_sclab_format(uint8_t sclab_format, IplDeviceComponentEntry *comp_entry)
> +{
> +    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
> +    if (sclab_format == 0) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_SCLAB_FORMAT,
> +                          "Format-0 SCLAB is not being used");
> +}
> +
> +static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
> +                             SecureIplSclabInfo *sclab_info,
> +                             IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    uint32_t cei_flag = 0;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW)) {
> +        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
> +        if (sclab->load_psw != 0) {
> +            cei_flag |= S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
> +            msg = "Load PSW is not zero when Override PSW bit is zero";
> +        }
> +    } else {
> +        /* OPSW = 1 indicating global SCLAB */
> +        sclab_info->global_count += 1;
> +        if (sclab_info->global_count == 1) {
> +            sclab_info->load_psw = sclab->load_psw;
> +            sclab_info->flags = sclab->flags;
> +        }
> +
> +        /* OLA must set to one */
> +        if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
> +            cei_flag |= S390_CEI_SCLAB_OLA_NOT_ONE;
> +            msg = "Override Load Address bit is not set to one in the global SCLAB";
> +        }
> +    }
> +
> +    if (cei_flag) {
> +        set_comp_cei_with_log(comp_entry, cei_flag, msg);
> +    }
> +}
> +
> +static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab, uint64_t load_addr,
> +                            IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    uint32_t cei_flag = 0;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
> +        /* OLA = 0 - Load address field in SCLAB must contain zeros */
> +        if (sclab->load_addr != 0) {
> +            cei_flag |= S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
> +            msg = "Load Address is not zero when Override Load Address bit is zero";
> +        }
> +    } else {
> +        /* OLA = 1 - Load address field must match storage address of the component */
> +        if (sclab->load_addr != load_addr) {
> +            cei_flag |= S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
> +            msg = "Load Address does not match with component load address";
> +        }
> +    }
> +
> +    if (cei_flag) {
> +        set_comp_cei_with_log(comp_entry, cei_flag, msg);
> +    }
> +}
> +
> +static void check_sclab_nuc(uint16_t sclab_flags, IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    bool is_nuc_set;
> +    bool is_global_sclab;
> +
> +    is_nuc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
> +    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
> +    if (is_nuc_set && !is_global_sclab) {
> +        msg = "No Unsigned Components bit is set, but not in the global SCLAB";
> +        set_comp_cei_with_log(comp_entry, S390_CEI_NUC_NOT_IN_GLOBAL_SCLA, msg);
> +    }
> +}
> +
> +static void check_sclab_sc(uint16_t sclab_flags, IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    bool is_sc_set;
> +    bool is_global_sclab;
> +
> +    is_sc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
> +    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
> +    if (is_sc_set && !is_global_sclab) {
> +        msg = "Single Component bit is set, but not in the global SCLAB";
> +        set_comp_cei_with_log(comp_entry, S390_CEI_SC_NOT_IN_GLOBAL_SCLAB, msg);
> +    }
> +}
> +
> +static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
> +                         int range_index)
> +{
> +    uint32_t addr = psw & 0x7fffffff;
> +
> +    /* PSW points within a signed binary code component */
> +    for (int i = 0; i < range_index; i++) {
> +        if (comp_addr_range[i].is_signed &&
> +            addr >= comp_addr_range[i].start_addr &&
> +            addr <= comp_addr_range[i].end_addr - 2) {
> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
> +
> +static void check_load_psw(SecureIplCompAddrRange *comp_addr_range,
> +                           int addr_range_index, uint64_t sclab_load_psw,
> +                           uint64_t load_psw, IplDeviceComponentEntry *comp_entry)
> +{
> +    bool valid;
> +
> +    valid = is_psw_valid(sclab_load_psw, comp_addr_range, addr_range_index) &&
> +            is_psw_valid(load_psw, comp_addr_range, addr_range_index);
> +    if (!valid) {
> +        set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_LOAD_PSW, "Invalid PSW");
> +    }
> +
> +    /* compare load PSW with the PSW specified in component */
> +    if (sclab_load_psw != load_psw) {
> +        set_comp_cei_with_log(comp_entry, S390_CEI_UNMATCHED_SCLAB_LOAD_PSW,
> +                              "Load PSW does not match with PSW in component");
> +    }
> +}
> +
> +static void check_nuc(uint16_t global_sclab_flags, int unsigned_count,
> +                      IplDeviceComponentList *comp_list)
> +{
> +    bool is_nuc_set;
> +
> +    is_nuc_set = global_sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
> +    if (is_nuc_set && unsigned_count > 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_FOUND_UNSIGNED_COMP;
> +        zipl_secure_handle("Unsigned components are not allowed");
> +    }
> +}
> +
> +static void check_sc(uint16_t global_sclab_flags,
> +                     int signed_count, int unsigned_count,
> +                     IplDeviceComponentList *comp_list)
> +{
> +    bool is_sc_set;
> +
> +    is_sc_set = global_sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
> +    if (is_sc_set && signed_count != 1 && unsigned_count >= 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_SIGNED_COMP;
> +        zipl_secure_handle("Only one signed component is allowed");
> +    }
> +}
> +
> +void check_global_sclab(SecureIplSclabInfo sclab_info,
> +                        int unsigned_count, int signed_count,
> +                        IplDeviceComponentList *comp_list)
> +{
> +    if (sclab_info.count == 0) {
> +        return;
> +    }
> +
> +    if (sclab_info.global_count == 0) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_NO_GLOBAL_SCLAB;
> +        zipl_secure_handle("Global SCLAB does not exists");
> +        return;
> +    }
> +
> +    if (sclab_info.global_count > 1) {
> +        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
> +        zipl_secure_handle("More than one global SCLAB");
> +        return;
> +    }
> +
> +    if (sclab_info.flags) {
> +        /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
> +        check_nuc(sclab_info.flags, unsigned_count, comp_list);
> +
> +        /* Only one signed component is allowed is SC flag is set in the global SCLAB */
> +        check_sc(sclab_info.flags, signed_count, unsigned_count, comp_list);

There's `check_sc()` and also `check_sclab_sc()` (and
`check_signed_comp()`, which is similar).  At least with the first two,
the functions are very easy to mix up (in fact, I was going to suggest
renaming check_sc to check_sclab_sc).

> +    }
> +}
> +
> +static void check_signed_comp(int signed_count, IplDeviceComponentList *comp_list)
> +{
> +    if (signed_count > 0) {
> +        return;
> +    }
> +
> +    comp_list->ipl_info_header.iiei |= S390_IIEI_NO_SIGNED_COMP;
> +    zipl_secure_handle("Secure boot is on, but components are not signed");
> +}
> +
> +static void check_sclab_count(int count, IplDeviceComponentList *comp_list)
> +{
> +    if (count > 0) {
> +        return;
> +    }
> +
> +    comp_list->ipl_info_header.iiei |= S390_IIEI_NO_SCLAB;
> +    zipl_secure_handle("No recognizable SCLAB");
> +}
> +
> +static void check_sclab(uint64_t comp_addr, uint64_t comp_len,
> +                        IplDeviceComponentEntry *comp_entry,
> +                        SecureIplSclabInfo *sclab_info)
> +{
> +    SclabOriginLocator *sclab_locator;
> +    SecureCodeLoadingAttributesBlock *sclab;
> +    bool exist;
> +
> +    /* sclab locator is located at the last 8 bytes of the signed comp */
> +    sclab_locator = (SclabOriginLocator *)(comp_addr + comp_len - 8);
> +
> +    /* return early if sclab does not exist */
> +    exist = check_sclab_presence(sclab_locator->magic, comp_entry);

Could just merge this into the check below:

```
if (!check_sclab_presence(...)) {
    return;
}
```

> +    if (!exist) {
> +        return;
> +    }
> +
> +    check_sclab_length(sclab_locator->len, comp_entry);
> +
> +    /* return early if sclab is invalid */
> +    if (comp_entry && (comp_entry->cei & S390_CEI_INVALID_SCLAB)) {
> +        return;
> +    }
> +
> +    sclab_info->count += 1;
> +    sclab = (SecureCodeLoadingAttributesBlock *)(comp_addr + comp_len -
> +                                                 sclab_locator->len);
> +
> +    check_sclab_format(sclab->format, comp_entry);
> +    check_sclab_opsw(sclab, sclab_info, comp_entry);
> +    check_sclab_ola(sclab, comp_addr, comp_entry);
> +    check_sclab_nuc(sclab->flags, comp_entry);
> +    check_sclab_sc(sclab->flags, comp_entry);
> +}
> +
>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>  {
>      if (zipl_load_segment(entry, sig_sec) < 0) {
> @@ -304,6 +590,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>      SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
>      int addr_range_index = 0;
>      int signed_count = 0;
> +    int unsigned_count = 0;
> +    SecureIplSclabInfo sclab_info = { 0 };
> +    IplDeviceComponentEntry *comp_entry;
>  
>      if (!secure_ipl_supported()) {
>          panic("Unable to boot in secure/audit mode");
> @@ -335,10 +624,21 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>              addr_overlap_check(comp_addr_range, &addr_range_index,
>                                 comp_addr, comp_addr + comp_len, sig_len > 0);
>  
> +            comp_entry = (comp_entry_idx < MAX_CERTIFICATES) ?
> +                         &comp_list.device_entries[comp_entry_idx] : NULL;
> +

This took me a little bit of time to understand why this was happening.
It'd make a *little* more sense if it were nested under the if statement
below.

It would read better to `#define` a `MAX_COMPONENTS` as well.  Could
just alias `MAX_CERTIFICATES` so both use the same value.

>              if (!sig_len) {
> +                check_unsigned_addr(comp_addr, comp_entry);
> +                comp_list_add(&comp_list, comp_entry_idx, cert_entry_idx,
> +                              comp_addr, comp_len, 0x00);
> +
> +                unsigned_count += 1;
> +                comp_entry_idx++;
>                  break;
>              }
>  
> +            check_sclab(comp_addr, comp_len,
> +                        &comp_list.device_entries[comp_entry_idx], &sclab_info);
>              verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
>                                          &cert_len, &cert_table_idx);
>  
> @@ -391,10 +691,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>          }
>      }
>  
> -    if (signed_count == 0) {
> -        zipl_secure_handle("Secure boot is on, but components are not signed");
> +    /* validate load PSW with PSW specified in the final entry */
> +    if (sclab_info.load_psw) {
> +        comp_entry = (comp_entry_idx < MAX_CERTIFICATES) ?
> +                     &comp_list.device_entries[comp_entry_idx] : NULL;

Silently accepting a NULL component makes it seem like an error should
be thrown, or a special case should be handled.

It looks like these `check_*()` functions only need the `cei` field of
the `comp_entry`.  Instead of passing the entire `comp_entry` to these
functions, pass something like an independent `cei_flags` variable. The
functions will set the appropriate error bits where appropriate.  This
also eliminates the various checks for `comp_entry != NULL`.

Then change `comp_list_add()` to accept the `cei_flags` field and set it
in the respective component while still accounting for the
`MAX_CERTIFICATES` check.

> +        check_load_psw(comp_addr_range, addr_range_index,
> +                       sclab_info.load_psw, entry->compdat.load_psw, comp_entry);
> +        comp_list_add(&comp_list, comp_entry_idx, -1,
> +                      entry->compdat.load_psw, 0, 0x00);

Why is the exec component added to the list?  It wasn't added before
this patch.

>      }
>  
> +    check_signed_comp(signed_count, &comp_list);
> +    check_sclab_count(sclab_info.count, &comp_list);
> +    check_global_sclab(sclab_info, unsigned_count, signed_count, &comp_list);
> +
>      update_iirb(&comp_list, &cert_list);
>  
>      *entry_ptr = entry;
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 69edfce241..4e9f4f08b9 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -16,6 +16,38 @@
>  VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>  int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>  
> +#define S390_SECURE_IPL_SCLAB_FLAG_OPSW    0x8000
> +#define S390_SECURE_IPL_SCLAB_FLAG_OLA     0x4000
> +#define S390_SECURE_IPL_SCLAB_FLAG_NUC     0x2000
> +#define S390_SECURE_IPL_SCLAB_FLAG_SC      0x1000
> +
> +#define S390_SECURE_IPL_SCLAB_MIN_LEN      32
> +
> +struct SecureCodeLoadingAttributesBlock {
> +    uint8_t  format;
> +    uint8_t  reserved1;
> +    uint16_t flags;
> +    uint8_t  reserved2[4];
> +    uint64_t load_psw;
> +    uint64_t load_addr;
> +    uint64_t reserved3[];
> +} __attribute__ ((packed));
> +typedef struct SecureCodeLoadingAttributesBlock SecureCodeLoadingAttributesBlock;
> +
> +struct SclabOriginLocator {
> +    uint8_t reserved[2];
> +    uint16_t len;
> +    uint8_t magic[4];
> +} __attribute__ ((packed));
> +typedef struct SclabOriginLocator SclabOriginLocator;
> +
> +typedef struct SecureIplSclabInfo {
> +    int count;
> +    int global_count;
> +    uint64_t load_psw;
> +    uint16_t flags;
> +} SecureIplSclabInfo;

IIRC, `SecureIplSclabInfo` was invented in these patches to help
consolidate some fields.  Unless I'm wrong, you could add an
`unsigned_count` and `signed_count` fields.  That will clear up some
stuff in `zipl_run_secure()`.

I'd also suggest prepending `global_` to `load_psw` and `flags` here to
make it clear what they represent.

Put a comment above explaining something like "Custom struct used to
consolidate SCLAB overhead".  Anything to signal that this isn't a
documented s390 data structure.

> +
>  typedef struct SecureIplCompAddrRange {
>      bool is_signed;
>      uint64_t start_addr;
> @@ -33,6 +65,16 @@ static inline void zipl_secure_handle(const char *message)
>      }
>  }
>  
> +static inline void set_comp_cei_with_log(IplDeviceComponentEntry *comp_entry,
> +                                         uint32_t flag, const char *message)
> +{
> +    if (comp_entry) {
> +        comp_entry->cei |= flag;
> +    }
> +
> +    zipl_secure_handle(message);
> +}
> +
>  static inline uint64_t diag320(void *data, unsigned long subcode)
>  {
>      register unsigned long addr asm("0") = (unsigned long)data;

Functionally, I think things look sane.  Please look into a way to
simplify the functions that exhibit similar patterns and reduce the
number of parameters required by each function.  SCLAF is a bit of an
abstract concept, so anything to make code simpler will help out a lot.

-- 
Regards,
  Collin

