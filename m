Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549A8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNY-0002uY-1L; Fri, 03 Jul 2026 09:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfeNW-0002ro-QJ; Fri, 03 Jul 2026 09:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfeNU-0006nD-J4; Fri, 03 Jul 2026 09:56:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IVjM1814281; Fri, 3 Jul 2026 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NIaVn8
 Q4ETq3UDIiWWPhMcwd6cOsbEmENevq5rBx0U4=; b=eeR6Cjk103i2aHGT/A1wNe
 81umwxU/LsGkcar0xKHSInzdEXHO6wVowc79ex73Lz1zKbUk0mxMcRvT3uxj2Dom
 FOGtRHecZ9o7r4UG9RJS3vnnznH8MP8CNpzqrxI+T4NhOInftfuwfQcd599L23iz
 bP4a6z4G1w/EW8sAwweUmEZxXOW1UcBqIGowuegZrnw+j5OofIlrEXJ3ED7TJ0n7
 bplHkU9AsKX+AshJ8GWTEE4bTZRJ24WuDP8PFgSIK3zW7D5mpIS1iZAoX9ovXsLK
 7+atzFA49AMjxGhkNtAys1V0mnDW7aToBliqUeOrxXcsLSEbYSToMbkKuNi0/NSQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rff0f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:56:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663DnisD009982;
 Fri, 3 Jul 2026 13:56:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyrwn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:56:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663DuKQt22413864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 13:56:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5D2A58043;
 Fri,  3 Jul 2026 13:56:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EAAB58059;
 Fri,  3 Jul 2026 13:56:20 +0000 (GMT)
Received: from [9.61.75.28] (unknown [9.61.75.28])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 13:56:19 +0000 (GMT)
Message-ID: <6fa4c5f7-0388-4acb-bacb-f929ecff1a09@linux.ibm.com>
Date: Fri, 3 Jul 2026 09:56:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 23/33] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-24-zycai@linux.ibm.com>
 <26e6d55b2ea246f2c2602ff911f459c7df8b57b0.camel@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <26e6d55b2ea246f2c2602ff911f459c7df8b57b0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47bf87 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=b206u0OnBF6S4jO2i-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nnL8fDoqutC_WTH0JTDJm9mt5AenR8XB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNiBTYWx0ZWRfX6pwLMp6YNloy
 J5VksHhaZr/VVRd1how0IaRQ7Z+tQiuGbE7GhNEKb8cKrr5ZirWhTGALZvsDwxjqScpq8fftpiP
 XZv5sDhdTdRk0oFGZKxeJIQW0v5bIi45hjePBgHf8gHRGrQ4ZCumFBRqjAiupQU0hdlI7tZT5kf
 855Sa7Qi9By4UoK6aFRtteNHWBp0sM9r/x+ynNCkPcW7mFCLvV7N1hFaXE6J39mimjw2a9MjdbJ
 QZ3AmWIuDxjWrstbsP9Bm+0IlxW42DqEtfO+xFdux+aXtbvvwatSVNj7hH0MsbXU0d3GOOmQc68
 v4HrTXNu2m0jWeh8qwHrxpZiIj+aGKnmWCCQY4j1FqzKyL8mt5vVjsZgoWgQJu+fyiF96r2TwG+
 7y+Qn8UmQrnPlajeT82VFdzj9TOirA1v2a3IK/hxFjQ3l6JN2Mm06nA3aPsYnd6hju8CkPDbpD8
 Wh/XvgKvD641UOzXHQw==
X-Proofpoint-GUID: nnL8fDoqutC_WTH0JTDJm9mt5AenR8XB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNiBTYWx0ZWRfX+hdKpO95pZpr
 fdaf+azzqshTsEXveYoJ+xkQhnmiLkLC35VIQVb9EfXSybhcVK5z4B3B7Gj9gVVDjyLjdohIDXT
 C1QA2mSCfhOFQUhI91R19UrM3ccI9WU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 7/3/26 7:40 AM, Eric Farman wrote:
> On Thu, 2026-07-02 at 22:29 -0400, Zhuoying Cai wrote:
>> Enable secure IPL in audit mode, which performs signature verification,
>> but any error does not terminate the boot process. Only warnings will be
>> logged to the console instead.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities (Secure IPL Facility,
>> Certificate Store Facility and secure IPL extension support).
>>
>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  docs/system/s390x/secure-ipl.rst |  15 ++
>>  hw/s390x/ipl.c                   |   9 +
>>  pc-bios/s390-ccw/Makefile        |   2 +-
>>  pc-bios/s390-ccw/bootmap.c       |  27 +++
>>  pc-bios/s390-ccw/bootmap.h       |   9 +
>>  pc-bios/s390-ccw/jump2ipl.c      |   7 +
>>  pc-bios/s390-ccw/main.c          |  18 +-
>>  pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>>  pc-bios/s390-ccw/sclp.c          |  27 +++
>>  pc-bios/s390-ccw/sclp.h          |   6 +
>>  pc-bios/s390-ccw/secure-ipl.c    | 363 +++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/secure-ipl.h    | 115 ++++++++++
>>  12 files changed, 616 insertions(+), 2 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
> 
> ...snip...
> 
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index cd3d0776b0..7484429c9a 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -20,6 +20,7 @@
>>  #include "dasd-ipl.h"
>>  #include "clp.h"
>>  #include "virtio-pci.h"
>> +#include "secure-ipl.h"
>>  
>>  static SubChannelId blk_schid = { .one = 1 };
>>  static char loadparm_str[LOADPARM_LEN + 1];
>> @@ -383,6 +384,8 @@ static void probe_boot_device(void)
>>  
>>  void main(void)
>>  {
>> +    int vcssb_len;
>> +
>>      iplb = &ipl_blocks.iplb;
>>  
>>      copy_qipl();
>> @@ -394,7 +397,20 @@ void main(void)
>>          probe_boot_device();
>>      }
>>  
>> -    boot_mode = ZIPL_BOOT_MODE_NORMAL;
>> +    boot_mode = get_boot_mode(iplb->hdr_flags);
>> +    switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
>> +        if (!secure_ipl_supported()) {
>> +            panic("Unable to boot in audit mode");
>> +        }
>> +
>> +        vcssb_len = zipl_secure_get_vcssb();
>> +        if (vcssb_len == 0) {
>> +            panic("Failed to query certificate storage information!");
>> +        }
> 
> break? fallthrough?
> 

Thanks for catching this!

>> +    default:
>> +        break;
>> +    }
>>  
>>      while (have_iplb) {
>>          boot_setup();
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 5420443ad2..ca2737054d 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -40,6 +40,22 @@ typedef unsigned long long u64;
>>                              ((b) == 0 ? (a) : (MIN(a, b))))
>>  #endif
>>  
>> +/*
>> + * Round number down to multiple. Requires that d be a power of 2.
>> + * Works even if d is a smaller type than n.
>> + */
>> +#ifndef ROUND_DOWN
>> +#define ROUND_DOWN(n, d) ((n) & -(0 ? (n) : (d)))
>> +#endif
>> +
>> +/*
>> + * Round number up to multiple. Requires that d be a power of 2.
>> + * Works even if d is a smaller type than n.
>> + */
>> +#ifndef ROUND_UP
>> +#define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
>> +#endif
>> +
>>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>>  
>>  #include "cio.h"
>> @@ -64,6 +80,8 @@ void sclp_print(const char *string);
>>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>>  void sclp_setup(void);
>>  void sclp_get_loadparm_ascii(char *loadparm);
>> +bool sclp_is_diag320_on(void);
>> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
>>  int sclp_read(char *str, size_t count);
>>  
>>  /* bootmap.c */
>> @@ -71,9 +89,11 @@ void zipl_load(void);
>>  
>>  typedef enum ZiplBootMode {
>>      ZIPL_BOOT_MODE_NORMAL = 0,
>> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
>>  } ZiplBootMode;
>>  
>>  extern ZiplBootMode boot_mode;
>> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
>>  
>>  /* jump2ipl.c */
>>  void write_reset_psw(uint64_t psw);
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index 4a07de018d..48bdfedf1f 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
>>      }
>>  }
>>  
>> +bool sclp_is_diag320_on(void)
>> +{
>> +    ReadInfo *sccb = (void *)_sccb;
>> +
>> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
>> +    sccb->h.length = SCCB_SIZE;
>> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>> +        return sccb->fac134 & SCCB_FAC134_DIAG320_BIT;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/* check if specified IPL facility flag is enabled */
>> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag)
>> +{
>> +    ReadInfo *sccb = (void *)_sccb;
>> +
>> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
>> +    sccb->h.length = SCCB_SIZE;
>> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>> +        return sccb->fac_ipl & fac_ipl_flag;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  int sclp_read(char *str, size_t count)
>>  {
>>      ReadEventData *sccb = (void *)_sccb;
>> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
>> index 64b53cad29..a8a41cd004 100644
>> --- a/pc-bios/s390-ccw/sclp.h
>> +++ b/pc-bios/s390-ccw/sclp.h
>> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>>  } __attribute__((packed)) SCCBHeader;
>>  
>>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>> +#define SCCB_FAC134_DIAG320_BIT 0x4
>> +#define SCCB_FAC_IPL_SIPL_BIT   0x4000
>>  
>>  typedef struct ReadInfo {
>>      SCCBHeader h;
>> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>>      uint8_t rnsize;
>>      uint8_t reserved[13];
>>      uint8_t loadparm[LOADPARM_LEN];
>> +    uint8_t reserved1[102];
>> +    uint8_t fac134;
>> +    uint8_t reserved2;
>> +    uint16_t fac_ipl;
>>  } __attribute__((packed)) ReadInfo;
>>  
>>  typedef struct SCCB {
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> new file mode 100644
>> index 0000000000..2cfa16fb68
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -0,0 +1,363 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
>> + * signature verification, and certificate handling).
>> + *
>> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
>> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include "s390-ccw.h"
>> +#include "sclp.h"
>> +#include "secure-ipl.h"
>> +
>> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
>> +
>> +#define for_each_rb_entry(entry, list) \
>> +    for (entry = (void *)(list) + sizeof((list)->ipl_info_header); \
>> +         (void *)(entry) + sizeof(*(entry)) <= \
>> +         (void *)(list) + (list)->ipl_info_header.len; \
>> +         entry++)
>> +
>> +int zipl_secure_get_vcssb(void)
>> +{
>> +    /* avoid retrieving vcssb multiple times */
>> +    if (vcssb.length == VCSSB_LEN_VALID) {
>> +        goto out;
>> +    }
>> +
>> +    vcssb.length = VCSSB_LEN_VALID;
>> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
>> +        vcssb.length = 0;
>> +    }
>> +
>> +out:
>> +    return vcssb.length;
>> +}
>> +
>> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
>> +{
>> +    VCEntryHeader *vce_hdr;
>> +    struct vcb {
>> +        VCBlockHeader vcb_hdr;
>> +        struct vce {
>> +            VCEntryHeader vce_hdr;
>> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
>> +        } vce;
>> +    } __attribute__((__aligned__(PAGE_SIZE))) vcb = { 0 };
>> +
>> +    /*
>> +     * Request single entry
>> +     * Fill input fields of single-entry VCB
>> +     *
>> +     * First and last index must be equal because only one
>> +     * VCE per VCB is currently supported
>> +     */
>> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
> 
> Don't you need to convert max_single_vcb_len from be to cpu?
> 

I don't think we need to convert max_single_vcb_len here, but please
correct me if I'm missing something. If I understand correctly, the
fields are written and read in big-endian format, so no additional
conversion should be necessary.

>> +    vcb.vcb_hdr.first_vc_index = index;
>> +    vcb.vcb_hdr.last_vc_index = index;
>> +
>> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
>> +        puts("Could not get certificate");
>> +        return 0;
>> +    }
>> +
>> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
>> +        puts("No certificate entry");
>> +        return 0;
>> +    }
>> +
>> +    if (vcb.vcb_hdr.remain_ct != 0) {
>> +        panic("Not enough memory to store requested certificate");
>> +    }
>> +
>> +    vce_hdr = &vcb.vce.vce_hdr;
>> +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
>> +        puts("Invalid certificate");
>> +        return 0;
>> +    }
>> +
>> +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr->cert_len);
>> +
>> +    return vce_hdr->cert_len;
>> +}
>> +
[...]

