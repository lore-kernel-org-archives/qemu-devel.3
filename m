Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0EC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtFc-0002ZT-8N; Mon, 17 Aug 2026 05:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvtFS-0002Xv-Fo; Mon, 17 Aug 2026 05:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvtFO-0001DC-3r; Mon, 17 Aug 2026 05:03:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVtf53636306; Mon, 17 Aug 2026 09:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yeWnVt
 VTz89MJpF//teU1pDJjrrUDlieDgYwlcmm8n8=; b=FxxTJMDx67OGeIjOSj+z5L
 S2pVUYvjxDwEvYvoYJ33NTalIUtQNF49GB4cSTECro0XevQxDfEoOJquVdiJbF05
 B6XYi+FzOG9QYOzt1Ozgd3cY0Baij+lBD3OhgEP1LyaS2vWOAK5W+ReTTJyEn+fI
 E29IpO6Hcc5Z4wkkOOfM76m+VfaRQ7qstGNhnP5gvmOJZoLWf4u9CmAraX7DNvJC
 UAGMgtD9Y+tvev7jKQPMOEjgAZ4kCz/I3p1E1lkuTfdyqsxkegRi6MIJyBwa2eAP
 1S80bi8a1+dHGW7fIHq6eDCPpzkiC92q+PYC1usiVTALgq1TPKhJMolwnZuBj4cw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhksdc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 09:03:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8uIsi023709;
 Mon, 17 Aug 2026 09:03:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epwf0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 09:03:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H930Au40829328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 09:03:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B240B20040;
 Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FFB120043;
 Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Message-ID: <733152db-5b26-443a-b1ac-5fc1886f60ab@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/19] tests/tcg/s390x: Add tests for CPACF
 instructions
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-20-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-20-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfXxVzqd8MpQIJx
 F3w9OlOQlTEmWIvz/M5FrS+SqdDNKq8g2WNM+mbgF57jvfyDQ7k7PIh54feHA30BTzU4gBEv+UT
 6P+3atk0lFObciocLn04g8LnzEOzg/hl0b/ZlZ+XHm4uZlpE5B+E+BK/HHVk3SpgTZYW5XkzNWo
 qaUAiRsJsg657sgJWeXm07rnMdrBKa1poYmRpmWrlae7ydvm8+FYP4sd/LdfEZltbhVspYV7gpg
 niwxC1Hj7vngvKJ6dvE/bTnZQAGQ1gf5MiRkP+WvSvLhasGkWALZ13i+IVUEXbqk5lvSpgTyonl
 JFmUS4VbUc5ocstSY90iLvOMEZwc8x/+OIhYO1IJp+JdcX5lc0oRG53CtYxVTPQ8mQ9erHBo3XE
 uM2KrmWodNmEYaoK49xYYYbvcJo3zK7O3x5ujswfEy+uK531jJUt19CVcVzyPVD1CDZOaR1kd0k
 gMy8QhdK2xHZZglzNTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfXz8KRzDi7u95f
 ybFvweBFxkoOyY1UMA4PT4EhS7ac0e2xklRqGtOHbxI2JPymzY6xpNfacOM7vOd763PiwlWdIxK
 X7T6q9gv5Smxcs8hMzVyBtRi8YKiuCk=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82ce49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=uJYxwXyaNrLBgnZ-awYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4E-Lf6DwPzM7j-bu9Sj063Bf_pJxxeAt
X-Proofpoint-GUID: 4E-Lf6DwPzM7j-bu9Sj063Bf_pJxxeAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170067
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



On 8/6/26 17:13, Harald Freudenberger wrote:
> Add simple tests for the CPACF instructions implemented:
> - kdsa - minimal as only query is implemented
> - kimd - query, sha256, sha512
> - klmd - query, sha256, sha512
> - km - query, aes 128, 192, 256 with clear and prot key
> - kmac - minimal as only query is implemented
> - kmc - query, aes 128, 192, 256 with clear and prot key
> - kmctr - query, aes 128, 192, 256 with clear and prot key
> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
> - pckmo - run query and check for SIGILL
> - prno - query, trng
> No test for kma, kmf, kmo as these instructions are currently
> not implemented at all.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h        |   7 +
>   tests/tcg/s390x/Makefile.target |  10 +
>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>   tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>   tests/tcg/s390x/cpacf-pckmo.c   |  45 +++
>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>   tests/tcg/s390x/cpacf.h         | 571 +++++++++++++++++++++++++++++++
>   13 files changed, 2798 insertions(+)
>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>   create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>   create mode 100644 tests/tcg/s390x/cpacf.h
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index dc29834cf8..2f0cabc85a 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -223,6 +223,8 @@
>   #define CPACF_KDSA_PSIGN_ED25519   48
>   #define CPACF_KDSA_PSIGN_ED448     52
>   
> +#ifndef CPACF_H_INCLUDE_FOR_TESTS
> +
>   /* from cpacf_sha256.c */
>   int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> @@ -254,6 +256,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                     uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>                     uint32_t type, uint8_t fc, uint8_t mod);
>   
> +#endif /* CPACF_H_INCLUDE_FOR_TESTS */

Could you please split this header in two instead?
For example: cpacf-arch.h that is usable from both emulation and tests
and cpacf.h just for emulation.


With that:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

