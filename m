Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD63CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 22:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1u3m-0007oJ-Lc; Thu, 25 Sep 2025 18:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1u3Y-0007kd-4O; Thu, 25 Sep 2025 18:03:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1u3O-0003bj-Hy; Thu, 25 Sep 2025 18:03:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImj6Q018668;
 Thu, 25 Sep 2025 22:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DnoP0w
 cPXAzhk0WsUk8S6+Muxy0kU3eei9D/vuEQZuc=; b=nCRwXRvuehnfSqh2OKztGD
 +SXfgDbqPtGLJLiKJQ+5lvZ9fiPvuyHdqUuwHNzfvyxAB/KeAuPD64aVdQlgEZ0b
 Qh6s9Y7fHNUeOunMYlUOTrt33HVhtMw2rK+17eYv2M1cjJmI4MUqWrjLXKhkSIzb
 mhgyDQiYZk6gPEu1IRlaPmephJBBC17zZ74v01b6/Ej6mz/HbUcQZih86q5F+Kz4
 FmpreJy6tW3KnX/0pcakkaUPgey3Baq30NUa7OYYypq2yonGC5+lUfKXMU1U2zL9
 nyNNurjMbutstVRnPwYhlp09Y8gZbg3fbAQ2yaPKbtbbzsDFyypQOZ1cRnuJPjWQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbd8wk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 22:02:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PLeEfr030039;
 Thu, 25 Sep 2025 22:02:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm8y9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 22:02:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PM2ths31981900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 22:02:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB7B58050;
 Thu, 25 Sep 2025 22:02:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5046558054;
 Thu, 25 Sep 2025 22:02:53 +0000 (GMT)
Received: from [9.61.254.10] (unknown [9.61.254.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 22:02:53 +0000 (GMT)
Message-ID: <0153da3a-c725-4c85-82a0-d7d62bddceab@linux.ibm.com>
Date: Thu, 25 Sep 2025 15:02:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/28] pc-bios/s390-ccw: Introduce IPL Information
 Report Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-14-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d5bc11 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Jok5gbZ5FRWlxEaBzpcA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX6hdF3elifoHW
 siaMyR7/EIZsppFLUtpr+DPmkghVtSiK85rG1DFCfFPEUKCxQZD0JSaWCiO5KoPg9hrvIL8KgIX
 wnI5dHewRgZZPDSvD2EM7c0hWGndEq99UU+uV+gIwBrITTmYZTkZIb647lLcFYubllcwm4C2F/F
 HqN+AttDLzpt9ggKoSJW8pRu/6SSVNQ0I+qi++E9ecmzpgj6cyGPF054cTwq46JW22nEiTXoHkb
 iiSUgzdAJFT7GNcNZpN1HFiRN668V9Ei2z+tw5pwVzZE5CNHfoBngIwflVajMVgBKc1s00u31GK
 g3zhXsQp06SZbwJhQnmiaHAFk17mVBFVNmyJcAtDCldrSSCCoSA3SDZd2bdlgnf+eQfFPFCB1XK
 uEZwIRZJoU5wYaA5xSy1ZfFl/IXZ0A==
X-Proofpoint-GUID: BIqs2h6JazE1rL20bPEkTrEVxZN45Q8v
X-Proofpoint-ORIG-GUID: BIqs2h6JazE1rL20bPEkTrEVxZN45Q8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
>
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 14 ++++++++
>   pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
>   2 files changed, 76 insertions(+)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index eec368d17b..760a066084 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -71,3 +71,17 @@ Subcode 1 - perform signature verification
>       Perform signature-verification on a signed component, using certificates
>       from the certificate store and leveraging qcrypto libraries to perform
>       this operation.
> +
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
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 08f259ff31..bdbc733e16 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -23,6 +23,68 @@ extern QemuIplParameters qipl;
>   extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>   extern bool have_iplb;
>   
> +struct IplInfoReportBlockHeader {
> +    uint32_t len;
> +    uint8_t  iirb_flags;
> +    uint8_t  reserved1[2];
> +    uint8_t  version;
> +    uint8_t  reserved2[8];
> +} __attribute__ ((packed));
> +typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
> +
> +struct IplInfoBlockHeader {
> +    uint32_t len;
> +    uint8_t  ibt;
> +    uint8_t  reserved1[3];
> +    uint8_t  reserved2[8];
> +} __attribute__ ((packed));
> +typedef struct IplInfoBlockHeader IplInfoBlockHeader;
> +
> +enum IplIbt {
> +    IPL_IBT_CERTIFICATES = 1,
> +    IPL_IBT_COMPONENTS = 2,
> +};
> +
> +struct IplSignatureCertificateEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +} __attribute__ ((packed));
> +typedef struct IplSignatureCertificateEntry IplSignatureCertificateEntry;
> +
> +struct IplSignatureCertificateList {
> +    IplInfoBlockHeader            ipl_info_header;
> +    IplSignatureCertificateEntry  cert_entries[MAX_CERTIFICATES];
> +} __attribute__ ((packed));
> +typedef struct IplSignatureCertificateList IplSignatureCertificateList;
> +
> +#define S390_IPL_COMPONENT_FLAG_SC  0x80
> +#define S390_IPL_COMPONENT_FLAG_CSV 0x40
> +
> +struct IplDeviceComponentEntry {
> +    uint64_t addr;
> +    uint64_t len;
> +    uint8_t  flags;
> +    uint8_t  reserved1[5];
> +    uint16_t cert_index;
> +    uint8_t  reserved2[8];
> +} __attribute__ ((packed));
> +typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
> +
> +struct IplDeviceComponentList {
> +    IplInfoBlockHeader       ipl_info_header;
> +    IplDeviceComponentEntry  device_entries[MAX_CERTIFICATES];
> +} __attribute__ ((packed));
> +typedef struct IplDeviceComponentList IplDeviceComponentList;
> +
> +#define COMP_LIST_MAX   sizeof(IplDeviceComponentList)
> +#define CERT_LIST_MAX   sizeof(IplSignatureCertificateList)
> +
> +struct IplInfoReportBlock {
> +    IplInfoReportBlockHeader     hdr;
> +    uint8_t                      info_blks[COMP_LIST_MAX + CERT_LIST_MAX];
> +} __attribute__ ((packed));
> +typedef struct IplInfoReportBlock IplInfoReportBlock;
> +
>   #define S390_IPL_TYPE_FCP 0x00
>   #define S390_IPL_TYPE_CCW 0x02
>   #define S390_IPL_TYPE_QEMU_SCSI 0xff

We should avoid packing the structure and just add QEMU_BUILD_BUG_MSG. 
Overall the patch LGTM. Thanks Farhan



