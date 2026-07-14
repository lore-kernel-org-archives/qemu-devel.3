Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2ECC4450F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbZz-0005TC-Vh; Tue, 14 Jul 2026 07:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbZy-0005Sx-Jt; Tue, 14 Jul 2026 07:45:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbZv-00054H-MW; Tue, 14 Jul 2026 07:45:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBg6GX1195260; Tue, 14 Jul 2026 11:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XRMBds
 E7624obXoG7gQWrrh7YKQrQZXTgOIUys3vZj8=; b=khEM2gohQq5Y3tTWNuiico
 uMNLnisj8ROEuXC5/mZCIfr1sYM+SjQEOcIuKgwQ9pl8pGRG+TYGlTsScCpSRLkQ
 OspObTcTiMKEHne2TGq3gZm4GBC+CAFPhcvRHDRatqXPL56t5DuEtENW64yf2tZp
 g9dRTab7cEa/ux9caJsq5A+/8v6iE5eVF8oRJjLc1ZjoV8r9trS4RIibLo++20nZ
 90iHmRfqvHu98rd7AUAsTMBWrpZiuo34aIV5F0G+Af4TIyMf0u+TWpkT0K7ovQJf
 DGa8DBDkSsmV9KhLWqhdvJANS+tZxSKSmfTaSSn+H0nQZZ0fNebaoWpZyWfX7CmA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnf6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:45:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBYtVB028830;
 Tue, 14 Jul 2026 11:45:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgabsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:45:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EBjMwm31326610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 11:45:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A68120040;
 Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4018720043;
 Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Message-ID: <13fa7159-9757-4858-b824-6507494e0876@linux.ibm.com>
Date: Tue, 14 Jul 2026 13:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/17] crypto: Add aes-helpers file to support some
 AES modes
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562157 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=WUVNbM32cKeQYF9Oq8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXzkgvM/ahkiuz
 BJvl5yCKD9msBu/AlHJQEfTVuv/UuuuN5zH1KTISf+w8OocZOohUxLz1cea2DiWjc9hRJn8DEh2
 D/1166VJkdI/+Ebrgt2T7GUyX3Zw/fk+oEWvZOySsuQ5BEKxnWd9HkB8vK5LObRHtdBpqzPxF/T
 AIfDhJTMJyoTsDI/8kl23Y0wZJc8xjbVVC8Vq2AJE+jaKhHKY5Bl/cOqOu4PI2/5lHVLLXaCZcu
 UUIr2825cNbrcsssveAYFFBWgffKhtBsQghIPxsdf8QnzZ1f8agbAHmU3rpLxJKMVmsnE0mBEv8
 hHr2MftFrsNMpyM4HTVG4yj/p98ixIwymL/7hxsKm5QkwTJrOOnzTpyDBNtXwui7YwS800rW/iH
 Qz/jn3Ns6ZZgpeZt33NRTvz8CNcpLow8uiMMK26HyDho2q5++zSVgdoNDtgVEAy2Gprl9yCcsYS
 tNziaXIUBJUWebatFVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfX6ekDmdL2J2bX
 w+3LKhWg2T/lZYv4/fNudJhpn96o1WNkdB5sX1MEX89Lc4oeYgvCcwABZlcsnn+MMBVzUpRh1LX
 EtL6kEVIgV9Jyxdzec4BwMHIQ8Id/kE=
X-Proofpoint-GUID: jHlziirphkBA0ndbKNkzi_KghgiMvy-j
X-Proofpoint-ORIG-GUID: jHlziirphkBA0ndbKNkzi_KghgiMvy-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 17:28, Harald Freudenberger wrote:
> Add a new file crypto/aes-helpers.c with simple functions
> to support some AES modes:
> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
> - AES ctr: AES_ctr_encrypt()
> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
> and some AES related helpers:
> - AES_xor()
> - AES_xts_prep_next_tweak()
> Add header file include/crypto/aes-helpers.h for these functions
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
>   crypto/meson.build           |   1 +
>   include/crypto/aes-helpers.h | 116 +++++++++++++++++++++++++++++++++++
>   3 files changed, 223 insertions(+)
>   create mode 100644 crypto/aes-helpers.c
>   create mode 100644 include/crypto/aes-helpers.h
> 
> diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
> new file mode 100644
> index 0000000000..ff4aa0a385
> --- /dev/null
> +++ b/crypto/aes-helpers.c

[...]

> +void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *ctr, const AES_KEY *key)
> +{
> +    unsigned char buf[AES_BLOCK_SIZE];
> +
> +    /* encrypt ctr => buf */
> +    AES_encrypt(ctr, buf, key);
> +    /* exor input data with encrypted ctr => out */
> +    AES_xor(in, buf, out);
> +}
> +
> +/*
> + * Tweak calculation for AES XTS.
> + * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
> + * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
> + * This implementation has been verified on litte and big endian.
> + */

Nit: do we need to have this comment twice?
It's already present in the header.

Also typo: litte -> little (but I'm not sure if we even need to state
that in the code).

[...]

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

