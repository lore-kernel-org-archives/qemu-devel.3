Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D7D4662E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUz1-0003oE-JJ; Thu, 15 Jan 2026 16:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vgUyt-0003lS-KU; Thu, 15 Jan 2026 16:34:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vgUyr-00039n-GC; Thu, 15 Jan 2026 16:34:15 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FIvnSD025891;
 Thu, 15 Jan 2026 21:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1QoOA4
 PfTKdJeTD5XscHpdyknQX+/WxkYfd2TXlNmDQ=; b=q7f+zWmAIVhgrAi9/7dA7V
 80LXkqsLL2a9/8+gZCjBV8jwkBiYFy02XGWHvchLzvINaA8HNerI/FS10xV5XY0p
 H45Z/x2dtm8gdXoB36HlZVzy5Qb71aUPZD0ldCPlPdnG/5efn7uzI2ytWtRi84Gu
 +OEgzFUjY3BgW3z3owqDFbbTt/5FEfWVZVBz/tx4TfGn3K3qvGIPiA5MidEz3C6i
 LEJkqwYU40Rybr/Be5UxB1G/YeMQNINyr5AxbMKDoZoaotdRlWWF+d+4lbubIaX0
 FL7ZGhxOfo75C8UdbKPBGKELDO21KgD2JPpsYy+EQt7YqvHQOEnNhqHRyoXbXsQA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bpja4nef0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 21:34:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FKO3Rm025877;
 Thu, 15 Jan 2026 21:34:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kktm1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 21:34:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60FLY6iA63308054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 21:34:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1284958045;
 Thu, 15 Jan 2026 21:34:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54E9558050;
 Thu, 15 Jan 2026 21:34:04 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 15 Jan 2026 21:34:04 +0000 (GMT)
Message-ID: <e5a34764-4fa2-40c8-af80-8bd5aefd1e63@linux.ibm.com>
Date: Thu, 15 Jan 2026 16:34:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v7 13/29] pc-bios/s390-ccw: Introduce IPL Information
 Report Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-14-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251208213247.702569-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE2NyBTYWx0ZWRfX4QmA14DS07x9
 5gMcBF9T5L5KX9vfjjxgdTeYoDalgDoT2ZDgK1qrv82bjJ+Wk5gUcHJJDYb0te83Ma3w3threEn
 I2muD586WEaygsWgaJmaEBKMId+XsjtREDR4JlSvDuClfBBZ1RlbLnhIn12d6OsuKPRrezLTjlt
 GAQetrDuz4SR3oQtYRQ+T1lpnlPqAphrI6erKsuxJBpdl8YFUQvRtL3SqlYxuUKAAZMhYznfTJU
 iOxaTTbJh7y7POtHcpvH7ydBDhD90floi5Rk5dsvibyjFBkFdq+fI8vRN+WA/8WUo66zva8JeGa
 GXqZK3qd3xKcvLuooFTUp7ZNW3fwvktZ9KiM9/5zEYGO5eiLpBPhP0VGcPV8jEWraD1ZidKMofS
 IBAlt06qH+dooIo9gFtj+DGiZc6Muivc6dnPgIDDAQ1cVcJoFYVe0a2oUS9H/ynB9K6b9AiWVHN
 Zv92SOnVLSJL0YByHww==
X-Proofpoint-ORIG-GUID: L6OvBfliww9gJoooJLWwSOiH1UuJLwpR
X-Proofpoint-GUID: L6OvBfliww9gJoooJLWwSOiH1UuJLwpR
X-Authority-Analysis: v=2.4 cv=U4afzOru c=1 sm=1 tr=0 ts=69695d50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=vSUreBBp3LQBltKZeEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 12/8/25 16:32, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
> 
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst | 13 +++++++
>  pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index be98dc143d..29c5d59b99 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -86,3 +86,16 @@ Subcode 1 - perform signature verification
>      * ``0x0302``: PKCS#7 format signature is invalid
>      * ``0x0402``: signature-verification failed
>      * ``0x0502``: length of Diag508SigVerifBlock is invalid
> +
> +IPL Information Report Block
> +----------------------------
> +
> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
> +IPL Information Report Block (IIRB), which contains the results from secure IPL
> +operations such as:
> +
> +* component data
> +* verification results
> +* certificate data
> +
> +The guest kernel will inspect the IIRB and build the keyring.

This needs more elaboration.  Is the data listed above used in
the keyring?  Maybe rewording to "The guest's kernel will use this data
in the IIRB when building its keyring." ?

> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 08f259ff31..cc3ecc69e5 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -23,6 +23,68 @@ extern QemuIplParameters qipl;
>  extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  extern bool have_iplb;
>  
> +struct IplInfoReportBlockHeader {
> +    uint32_t len;
> +    uint8_t  iirb_flags;

s/iirb_flags/flags

> +    uint8_t  reserved1[2];
> +    uint8_t  version;

Is version used?  If not, merge into one `reserved` field.

> +    uint8_t  reserved2[8];
> +};
> +typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
> +
> +struct IplInfoBlockHeader {
> +    uint32_t len;
> +    uint8_t  ibt;

s/ibt/type

> +    uint8_t  reserved1[3];
> +    uint8_t  reserved2[8];

Make this one `reserved[11]`.

> +};
> +typedef struct IplInfoBlockHeader IplInfoBlockHeader;
> +
> +enum IplIbt {
> +    IPL_IBT_CERTIFICATES = 1,
> +    IPL_IBT_COMPONENTS = 2,
> +};

s/IplIbt/IplInfoBlockType

s/IPL_IBT/IPL_INFO_BLOCK_TYPE

It becomes more verbose, but it's much easier to read.

> +
> +struct IplSignatureCertificateEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +};
> +typedef struct IplSignatureCertificateEntry IplSignatureCertificateEntry;
> +
> +struct IplSignatureCertificateList {
> +    IplInfoBlockHeader            ipl_info_header;
> +    IplSignatureCertificateEntry  cert_entries[MAX_CERTIFICATES];
> +};
> +typedef struct IplSignatureCertificateList IplSignatureCertificateList;
> +
> +#define S390_IPL_COMPONENT_FLAG_SC  0x80
> +#define S390_IPL_COMPONENT_FLAG_CSV 0x40

Rename these to S390_IPL_DEV_COMP_FLAG_*

> +
> +struct IplDeviceComponentEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +    uint8_t  flags;
> +    uint8_t  reserved1[5];
> +    uint16_t cert_index;
> +    uint8_t  reserved2[8];
> +};
> +typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
> +
> +struct IplDeviceComponentList {
> +    IplInfoBlockHeader       ipl_info_header;
> +    IplDeviceComponentEntry  device_entries[MAX_CERTIFICATES];
> +};
> +typedef struct IplDeviceComponentList IplDeviceComponentList;
> +
> +#define COMP_LIST_MAX   sizeof(IplDeviceComponentList)
> +#define CERT_LIST_MAX   sizeof(IplSignatureCertificateList)
> +
> +struct IplInfoReportBlock {
> +    IplInfoReportBlockHeader     hdr;
> +    uint8_t                      info_blks[COMP_LIST_MAX + CERT_LIST_MAX];
> +};
> +typedef struct IplInfoReportBlock IplInfoReportBlock;
> +
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff

Other than the nits above, the data structure layouts are correct.

-- 
Regards,
  Collin

