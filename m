Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB18D232C1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 22:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdyuJ-0002hn-Rg; Thu, 08 Jan 2026 17:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vdyuI-0002ek-3q; Thu, 08 Jan 2026 17:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vdyuG-0001On-LW; Thu, 08 Jan 2026 17:55:05 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608FUnNO012230;
 Thu, 8 Jan 2026 22:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tIaCEG
 PueUgXeW84Xt00HJ7NtmzcT5bcNcj0JE3gVfU=; b=X2emfJ0Q5kqaDWHQKN1+J5
 2IQt/yjtQna9mCvqTV3wJe7aNspLNWMnSumeJQKmDV4a/eFbzdlWwvCjVog1K3Zj
 9UgnFDzHntzdFvHxZ2OVmuzYTOyF+uenVhCJ9lSTTy03MdfoA1ZCL4kL4WQEGW7b
 y1kCJ/qzqb6Vs2uPWoIYq/U24go+S/gUAEdm6uDdoXsRNbTvRHB1Ew6jNrX2AD6G
 wQ/HGQMMJmQLTeZ3Jz34FupFACVCViicfWmP95BKx//pzz9rLh7gmcqR47JQED9Y
 lpae6VX22GKKcFT+R6+n6AgFyKQxRFcU8OH0ohJdVsv6gYOAyiuV0fJMBvpq5rNw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrty8t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 22:55:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608LroAJ014542;
 Thu, 8 Jan 2026 22:55:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeen9sms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 22:55:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 608Mt0j611272876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 22:55:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D23F5805D;
 Thu,  8 Jan 2026 22:55:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C91B58057;
 Thu,  8 Jan 2026 22:54:59 +0000 (GMT)
Received: from [9.61.255.109] (unknown [9.61.255.109])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Jan 2026 22:54:59 +0000 (GMT)
Message-ID: <b3a03c68-c011-43e8-8c85-e14fb7f39399@linux.ibm.com>
Date: Thu, 8 Jan 2026 14:54:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251208213247.702569-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=696035c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vi9klyI5-fu-b9GVpQgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0fKNBYTm86b1OMyIYL9GcQbwArrZsP76
X-Proofpoint-ORIG-GUID: 0fKNBYTm86b1OMyIYL9GcQbwArrZsP76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE3MyBTYWx0ZWRfX5GbxSHYIW66k
 /QhbgBV9/oOI6oJ5KKWrITqyI8cYrq5sd3122T0uX9C7rhE+1QM7mTHCxiILu0+HeTLzBC3Am8T
 bn7YiCp//pP8wTGMdEv9xHmjk9YOSU2hGkKGO96TWuvrwV/5uR+bgDPRs1Drbf/0oSzRmzyLFk+
 9Gidz4m+D51NGIRwbkEj0doPQNhcoCbzLs4yDL9ZjTWyQYSak+SpaaQQ/V+jW3N3v6k7DranJl1
 cNINtCKpqi1Ffh7xUnj8jyM09Z6y9QmbeGQfnJgPrnGQ3J6AnygWukjp1cdz72odRbVPNAuxyrK
 0kTmT33FQjq9WYlhhweo/YEAdWfqGyqfeKjEt8Bsekx0hcwG1Z/7shiU/RJODi6xgJzJoaqDCt0
 wU9ZEMc5mjk0MuFfvbnYA7uc8aN1X+CkNZ2VreseFJTkmyv8MfOgTOgQGGrRuPDs3mrItyDBAIS
 mmzLMcWFdwprIrttnsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080173
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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

<..snip...>

On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
> +static int build_vce_data(VCEntry *vce, S390IPLCertificate cert)
> +{
> +    uint16_t keyid_field_len;
> +    uint16_t hash_field_len;
> +    uint32_t cert_field_len;
> +    uint32_t vce_len;
> +    int rc;
> +
> +    handle_key_id(vce, cert);
> +    /* vce key id field length - can be 0 if failed to retrieve */
> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);

If we fail to retrieve the key, does it makes sense to build the VCE? I 
think we need the key to verify the signature of the certificate, so why 
not mark the certificate as invalid?


> +
> +    rc = handle_hash(vce, cert, keyid_field_len);
> +    if (rc) {
> +        return -1;
> +    }
> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
> +
> +    rc = handle_cert(vce, cert, hash_field_len);
> +    if (rc || !is_cert_valid(cert)) {
> +        return -1;
> +    }
> +    /* vce certificate field length */
> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
> +
> +    vce_len = VCE_HEADER_LEN + keyid_field_len + hash_field_len + cert_field_len;
> +    if (vce_len > be32_to_cpu(vce->len)) {
> +        return -1;
> +    }
> +
> +    /* The certificate is valid and VCE contains the certificate */
> +    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +
> +    /* Update vce length to reflect the actual size used by vce */
> +    vce->len = cpu_to_be32(vce_len);
> +
> +    return 0;
> +}
> +

<...snip...>


