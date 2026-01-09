Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92C0D26D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJ1b-0005cl-Ih; Fri, 09 Jan 2026 15:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1veJ19-0005V9-Lj; Fri, 09 Jan 2026 15:23:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1veJ17-0001v0-4Z; Fri, 09 Jan 2026 15:23:30 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 609C0Bwh021540;
 Fri, 9 Jan 2026 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rW9PXn
 pwrANmh5FuLC/CQqEDpkUDH0Ty9jjXjHYL5Qs=; b=VptIFHgeMBc6TUcbp5vFd3
 L9wCCX/V90ykFnhhazouCaCUFC8WLnbEanLm5z0lwf747EF01qKiO/Q4EID/xxk+
 TBDeZcnpAJzRkGj6Qt2aCKZvqbIPFQJzoYYSBORqascxoGHCEcGLkP6CV5F6PMFS
 BRFBezj9kzoknyupGL36GXB4V5n7FjVGLhbq9YnRj0uN9vs3EdQ734sNKfI5ArCt
 kIP0l/er4KFluoz9Xx83ym52tr+1GCqWZMIj0QEM94lbidZK5MX+pk115QsHohs1
 heH3eiIutzL4YQVxITYQcWZNZJc2EJKMNp8+oFGK2zPjM9UCVfKWvMDO7FrwCllw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betru3nse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 20:23:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609IeTS6015656;
 Fri, 9 Jan 2026 20:23:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdesy5dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 20:23:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609KNNfg33751616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 20:23:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF16A58056;
 Fri,  9 Jan 2026 20:23:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777C158052;
 Fri,  9 Jan 2026 20:23:22 +0000 (GMT)
Received: from [9.61.246.33] (unknown [9.61.246.33])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Jan 2026 20:23:22 +0000 (GMT)
Message-ID: <c6c6f951-213f-4e1b-914f-c910a6ded518@linux.ibm.com>
Date: Fri, 9 Jan 2026 12:23:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/29] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-13-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251208213247.702569-13-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=696163be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=dU5sLyg9tPbDZ2Ciq6MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rRwL0MMPBjgs-3MrV8qUr94RpqAiAEvx
X-Proofpoint-ORIG-GUID: rRwL0MMPBjgs-3MrV8qUr94RpqAiAEvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE1OCBTYWx0ZWRfX4bV+NDTPbwEY
 PNOKRWkWmRdHr5WxZZkPMXzCaaCcmpoyc0+yr+gRlDduHgzJ1/mJ4bJTRtf0ctkv2deGw8kNWJK
 zy5XHt2WhaUNJLfrsB3lTN9gjxR29PmgroRvVr3B1E/mdEmVuM7Gol7URLQ43NInIBfKh+jFc08
 44RGY32U1TKLZ5iJdNuCXEEMaV/WXe7b4PvaFNTHAuwz5dzutjZMZd8cQGNBCN0O8TQ7htO2Uhs
 nfqjIxGxCxxoCLF+VUAKM7Cw6M7db3/NF9YVfQ098OpVAJgiiYvHe9wblkI3DBlhFGSrdOjHEW2
 pCvexW1S33I8dpKrin96ecW7vfefMJ+Pb/xjX9qYIXy1Ik453V1C22YpKR+yXPvkfH0scjPpFOM
 7DtnKuGEkxIF7ideGrMUxr/IBsuRFOOPEVofkEPbQajp+Jq7vZtKAQkznt74cKNkVyd/Eeax9sS
 UjkGWzN0PAypOUoFd0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
>
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
>
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 DER format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SigVerifBlock.
>
> The DIAG handler will read from the provided addresses
> to retrieve the necessary data, parse the signature file, then
> perform the signature-verification. Because there is no way to
> correlate a specific certificate to a component, each certificate
> in the store is tried until either verification succeeds, or all
> certs have been exhausted.
>
> A return code of 1 indicates success, and the index and length of the
> corresponding certificate will be set in the Diag508SigVerifBlock.
> The following values indicate failure:
>
> 	0x0102: no certificates are available in the store
> 	0x0202: component data is invalid
> 	0x0302: PKCS#7 format signature is invalid
> 	0x0402: signature-verification failed
> 	0x0502: length of Diag508SigVerifBlock is invalid
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |  17 ++++++
>   include/hw/s390x/ipl/diag508.h  |  26 ++++++++
>   target/s390x/diag.c             | 103 +++++++++++++++++++++++++++++++-
>   3 files changed, 145 insertions(+), 1 deletion(-)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 84a1691e1b..be98dc143d 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -69,3 +69,20 @@ that requires assistance from QEMU.
>   
>   Subcode 0 - query installed subcodes
>       Returns a 64-bit mask indicating which subcodes are supported.
> +
> +Subcode 1 - perform signature verification
> +    Perform signature-verification on a signed component, using certificates
> +    from the certificate store and leveraging qcrypto libraries to perform
> +    this operation.
> +
> +    Note: verification of initrd is not supported.
> +
> +    A return code of 1 indicates success, and the index and length of the
> +    corresponding certificate will be set in the Diag508SigVerifBlock.
> +    The following values indicate failure:
> +
> +    * ``0x0102``: no certificates are available in the store
> +    * ``0x0202``: component data is invalid
> +    * ``0x0302``: PKCS#7 format signature is invalid
> +    * ``0x0402``: signature-verification failed
> +    * ``0x0502``: length of Diag508SigVerifBlock is invalid
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> index 6281ad8299..9c493f7273 100644
> --- a/include/hw/s390x/ipl/diag508.h
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -11,5 +11,31 @@
>   #define S390X_DIAG508_H
>   
>   #define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +#define DIAG_508_SUBC_SIG_VERIF     0x8000
> +
> +#define DIAG_508_RC_OK              0x0001
> +#define DIAG_508_RC_NO_CERTS        0x0102
> +#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
> +#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
> +#define DIAG_508_RC_FAIL_VERIF      0x0402
> +#define DIAG_508_RC_INVAL_LEN       0x0502
> +
> +#define DIAG_508_MAX_COMP_LEN      0x10000000
> +#define DIAG_508_MAX_SIG_LEN       4096
> +

Based on my understanding, these values for component and signature 
length are based on the max that is possible today (v6 discussion 
https://lore.kernel.org/all/8c43bb15-5aaa-4dd5-8776-686c546a305c@redhat.com/). 
These values are not defined in the architecture and its possible we may 
have to update them in the future.Maybe we can add a comment for this?

<..snip..>


> +static int handle_diag508_sig_verif(uint64_t addr)
> +{
> +    int verified;
> +    uint32_t svb_len;
> +    uint64_t comp_len, comp_addr;
> +    uint64_t sig_len, sig_addr;
> +    g_autofree uint8_t *comp = NULL;
> +    g_autofree uint8_t *sig = NULL;
> +    g_autofree Diag508SigVerifBlock *svb = NULL;
> +    size_t svb_size = sizeof(Diag508SigVerifBlock);
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
> +
> +    if (!qcs->count) {
> +        return DIAG_508_RC_NO_CERTS;
> +    }
> +
> +    svb = g_new0(Diag508SigVerifBlock, 1);
> +    cpu_physical_memory_read(addr, svb, svb_size);
> +
> +    svb_len = be32_to_cpu(svb->length);
> +    if (svb_len != svb_size) {
> +        return DIAG_508_RC_INVAL_LEN;
> +    }
> +
> +    comp_len = be64_to_cpu(svb->comp_len);
> +    comp_addr = be64_to_cpu(svb->comp_addr);
> +    sig_len = be64_to_cpu(svb->sig_len);
> +    sig_addr = be64_to_cpu(svb->sig_addr);
> +
> +    if (!comp_len || comp_len > DIAG_508_MAX_COMP_LEN || !comp_addr) {
> +        return DIAG_508_RC_INVAL_COMP_DATA;
> +    }
> +
> +    if (!sig_len || sig_len > DIAG_508_MAX_SIG_LEN || !sig_addr) {
> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
> +    }

And maybe a warning to indicate the failure is due to 
signature/component length being larger than our currently defined ones?


> +
> +    comp = g_malloc0(comp_len);
> +    cpu_physical_memory_read(comp_addr, comp, comp_len);
> +
> +    sig = g_malloc0(sig_len);
> +    cpu_physical_memory_read(sig_addr, sig, sig_len);
> +
> +    for (int i = 0; i < qcs->count; i++) {
> +        verified = diag_508_verify_sig(qcs->certs[i].raw,
> +                                       qcs->certs[i].size,
> +                                       comp, comp_len,
> +                                       sig, sig_len);
> +        if (verified) {
> +            svb->cert_store_index = i;
> +            svb->cert_len = cpu_to_be64(qcs->certs[i].der_size);
> +            cpu_physical_memory_write(addr, svb, svb_size);
> +            return DIAG_508_RC_OK;
> +       }
> +    }
> +
> +    return DIAG_508_RC_FAIL_VERIF;
> +}
> +
> ;

<..snip..>


