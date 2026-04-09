Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84625F364AF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAujx-0007qE-E5; Thu, 09 Apr 2026 15:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wAujs-0007pX-Jt; Thu, 09 Apr 2026 15:08:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wAujp-0003Gd-RH; Thu, 09 Apr 2026 15:08:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6399DfGN2297410; Thu, 9 Apr 2026 19:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3fTQAQ
 E8+roh2sPNbkTH8hUOyrddgrzm4VfvDzCCNaM=; b=QxG8PCD6IFIUtyYCP085Ex
 7aKYomnGjet6FQ11dCAmAUwSD8jXCOishKZpPG8vvIKQvbzRu4vlihIEMayOAhuU
 E/lwyL/oP49Rnjt2cit5S3DVBegTPYNS9FuIkH6cKN89QgkU+xy3TQTazHqx/lxl
 39fOo/K12T31O2J7P7We/eShVQQhuKo/+P64NeRkF7W0ki0Tyv02LpGOnROB8kkY
 kww3ZtcRaQtzEJyUkkPPgT6dgpgWzX0pbmXi1eJfHG+me4YY/Z1qGjWM8/B5VR2Y
 bK6rPMVOddjXtAVUVidX2hhZ4+HzFosyGoU5hBWnv3aZfl+4F8WbaS6poPdqkCtg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g5t3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 19:08:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Gt5ui007942;
 Thu, 9 Apr 2026 19:08:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2n1q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 19:08:13 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639J8BmY17498762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 19:08:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B36058050;
 Thu,  9 Apr 2026 19:08:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3E2A58054;
 Thu,  9 Apr 2026 19:08:09 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Apr 2026 19:08:09 +0000 (GMT)
Message-ID: <55daa9f2-af2b-4076-8d08-752c06efd481@linux.ibm.com>
Date: Thu, 9 Apr 2026 15:08:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/30] s390x/diag: Implement DIAG 320 subcode 2
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
 <20260402221453.1602899-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d7f91e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hHZIFWYFNaKudbiwD8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xb1VHoS6QpDXaLlzEd4TDOLotM9O7xKL
X-Proofpoint-GUID: Xb1VHoS6QpDXaLlzEd4TDOLotM9O7xKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MiBTYWx0ZWRfX/4Kc6X9tVQhf
 wSdguPyAIakbvGP7keUZT+c+TpYdZf8dR4JgjiQKWnX4m1XSVPwTXxzR8/LoTTz6pufe3kFDLD8
 A1KCGh7KopwOB7MvK3X2LRyrbbKKF9KZhcCe4AU4rb+eYDrFHXw1+FHm82Zfxf6b0p0hQgTJm2t
 x5RqXl4jNUTCXhmXYILvMNS0btO/+KJE5qfBHos0FyK22icTftHLhRf5LFoR5BnLa25/CYjRPS7
 nxXH8xhrfZ1IWGAOk+U83G85gwi/1OeHFiOuITeUvn0/8G6GkUZBGTrwyoq9OzVTtg24bwcbHx5
 OqfSmf9YfFoOQ+u8RqaIdg/K84uxj/t3tsac9IQ6P0I9WV5agIPNsx1RH6ksio19ElXsn+bh90Z
 +5u+JCXBpwyhfXqbKiFVtAV10Z584SEFIyUqnk1SbsBsj86AzK+1Sgcj1kK8qut+b75Up52Ynnh
 UwickYgTPj78z7w4QAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090172
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
> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
> certificate store. Only X509 certificates in DER format and SHA-256 hash
> type are recognized.
> 
> The subcode value is denoted by setting the second-left-most bit
> of an 8-byte field.
> 
> The Verification Certificate Block (VCB) contains the output data
> when the operation completes successfully. It includes a common
> header followed by zero or more Verification Certificate Entries (VCEs),
> depending on the VCB input length and the VC range (from the first VC
> index to the last VC index) in the certificate store.
> 
> Each VCE contains information about a certificate retrieved from
> the S390IPLCertificateStore, such as the certificate name, key type,
> key ID length, hash length, and the raw certificate data.
> The key ID and hash are extracted from the raw certificate by the crypto API.
> 
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst |  24 +++
>  hw/s390x/cert-store.h           |   3 +-
>  include/hw/s390x/ipl/diag320.h  |  55 ++++++
>  target/s390x/diag.c             | 338 +++++++++++++++++++++++++++++++-
>  4 files changed, 417 insertions(+), 3 deletions(-)
> 

[...]

> +
> +static int get_key_type(const S390IPLCertificate *cert)
> +{
> +    int rc;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_check_ecc_curve_p521(cert->raw, cert->size, &err);
> +    if (rc == -1) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
> +                        DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;

small nit: remove one space to line up the DIAG_'s.

[...]

Other than that, LGTM!

Reviewed-by: Collin Walling <walling@linux.ibm.com>


-- 
Regards,
  Collin

