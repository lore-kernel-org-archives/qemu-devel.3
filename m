Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F24CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKWe-0003rN-MN; Wed, 24 Jun 2026 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKWc-0003qb-ET
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:08:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKWa-00045y-G2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:08:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5tuRB2522423
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=; b=cLmQI50TVfXms40J
 0xWm5HMbAmptufeRYStw80DEt7Sp5fWLZnlpfXeFN+Jc0mBHLjAv8wMAV8J2OWuv
 6UE1VgFBkwKiQinRQ7xvskZMS+XTWfRXOcS21P2Ix2Q8TVizqhfxys0A4VaqMOpK
 iaB5jm3cWkE/X9uJz3bIbChd7VCRar5MFu/XUO6AYj4X8/JSrMilxk9AAblqMbGM
 4TM6DNrUF1XIqrxNI668CeTSS8C8jaNdA/2UuCVLaW3HRZYmjLahsnhNRoqQzl9O
 VoYYduPnw52QMbYyn2xjbapqsxg0psTwwgJzuIEPO3aUd28Rqk6YdKkwcSmz/vmK
 1hLW/g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajhrmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:08:01 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6798c46f723so396343137.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782295681; x=1782900481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=;
 b=Jx3IHtaqwc+GDhy/3tKlcVnpG9ja5+Hloq2G0UKghOfLlTvaJzJktRQ76YrTqFAxgi
 ar8z5CWLIH9U6k0ZwdqEf8AOgl6t8rt7iausQrhPjn/sKcSRHA3PKSUiNUNOynu32vDZ
 81+kb9/1OJGx8vBk7E6ce80hsrarhSuWVYsT8v7mYmAkcKiCnr5S2/vSwXCi+4UYS9/2
 POBVLfj6ViRM7KmMC4Kb1m9QMtwcy9/VQTZqsmH/H2w1Wp8SIkS88jJ1mwPjk7aVdLE0
 v21ewpakENJNR3w1EKYL0yh7dbJ5CUE4L9HRB+u8RU/Vt8C2j31WzodQFEP0afWD+Xn3
 0vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295681; x=1782900481;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=;
 b=DWutCMvVhz7c1RURA2y8Br4sCAWj+xDRgSAwTmaRNrH+pskjNwYifG66DC+QO7jhN6
 zlx5xulrZb+Ri9eKcvLrF2oB+Yg/NAXw/rSjvS9NRC07f+YUcJ+H9itONKEkg8tLsJp+
 2eKrgXbUVQkWt61ZQWH/6JjfJlGMo7t+4cCEailGQXoG56Ed7nN1ZxUNRndN8DBA+4wl
 ZDShAfEFDZwb29CuYbuEHVVJPy1ky3cl/V7gWpnG47WNfMKevslm5iiNCyNZDIWu+NTa
 A6V2yLZUR9lvvEeloTYZbct3PoBMGAJlUm+2a/FETRBmfouAvBX4cXcHi6GOp6XaWTcK
 59hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W3nzDm8w6ICXxvPSOritR01QIzBZzxNyfuSzE0oBTNVPr04MfM7bRZuvsOGD1oHX2auyZ1x1w4Bgc@nongnu.org
X-Gm-Message-State: AOJu0YyBhsU+0LFTr6b0FhKQxZ8MO4kNcDYXQIUnbuODJsL2ad2VYrZg
 vnrT63uX7+1gqHKw1VTyVOV/cd3w6MpQC2jYP+IhiYu+NfyNfC4p05o1KUhfu2t9coKyrvpR/AZ
 dd0ShDEfoSlXBbiWOkaK2PnhoQ1SB6jBYmC7xXRPppDBS4qxolaw1K9i5ow==
X-Gm-Gg: AfdE7cngtJK8t0vwesEerkaiA9YypIeRV+nnsRl8vHeT5qJn+O4tYP7DUFUSTOiwxEf
 AcR1pQbLoGZNapJfLlxgbS+ml4/D+2o4PLWGSGptVbas5a8tE424QlHd4GTvIZc/ph1GDH2Ewqy
 B6SCY1jxNryuix8oMithDOavMKbI9oo5ecXf3EGrKfrdx7RYcVghlAOS5JxnXgeOYEoFfocdisG
 lttf/ao6HSlKRi7Iey5Ff+7BEOyGO8bJq6jhqGa7xHm13t27b70YNznpQUZTXTo5F5FXc92qvNC
 3Wq5VgDERzcBI/RfBVb+5omQrxnZSV55mrAbO5J3u10NTpvfrCJCZIDLw05RJkLr/mWiPrKKyUT
 AQSdQ9Em5xSMStj4+z+Z+cyH47/s4GyQJ/KiBwxWcg2IgkWozPHQl9MuBCMkSqA==
X-Received: by 2002:a05:6102:94c:b0:726:e608:6658 with SMTP id
 ada2fe7eead31-731133d342bmr1006880137.11.1782295680904; 
 Wed, 24 Jun 2026 03:08:00 -0700 (PDT)
X-Received: by 2002:a05:6102:94c:b0:726:e608:6658 with SMTP id
 ada2fe7eead31-731133d342bmr1006869137.11.1782295680523; 
 Wed, 24 Jun 2026 03:08:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f4bd36adsm869091a12.27.2026.06.24.03.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 03:07:59 -0700 (PDT)
Message-ID: <e7f9a860-56b5-4e7f-ba62-82133ad8aebf@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] target/s390x: Move cpacf sha512 code into a new
 file
Content-Language: en-US
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-4-freude@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624081029.23815-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX1tIo7nr4Amn6
 7aXOT+zmiks3sxBbUdcsaiK5VokgF2SbxmGVlaWaoM+xdJ6Jbp8WXk38wAdoV2SAXrAI40EMQSn
 sMXgJFVLdjn5X7IYWdIksrT4LTF6JxY=
X-Proofpoint-GUID: KnWGKaAr0iv2EtvghyRmjhmcqaiHzyAg
X-Proofpoint-ORIG-GUID: KnWGKaAr0iv2EtvghyRmjhmcqaiHzyAg
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3bac81 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VnNF1IyMAAAA:8 a=WjaQ4H5Iy4oAvfDZsE8A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfXyO7kIKSZqZQv
 iOCd4Tot2VgERFmVwSXzUkAv3EhZTmmWXgQ6eFc0vNaOM7OfGfl9C3+UpoIpUPkWsbXZMsbqPFn
 0BqmQ1SB4UeKh27K1SmsoAxOB+eDpe5Nz8EZMRhZz5S6Oj6Y/C9nK0oW7IhwJqP1eKaosGxeW1B
 RfysNzgNAatL1Xxp6YQOuuiC69q6IwAbsFAQ7anGcu3w9WI/nL2B3WlFsSEOlEeaDlEWQZSdBnh
 PVgrAN3P2mZA/+iBIqJusl6sDKwLnwZt5C03rZXSv15HXJfZRk2HAiemt2qgDcpXPbFULJxoYrK
 X69wZzsF9HxNOoLcTUMGOsGUFjOHGF5ViHplZaD88xUW8qczg6Yz23dMts8CJOK/L37CC5WnFDh
 8JCX6tkaw8vCcGrlZW6k93zfUcgRIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/6/26 10:10, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and add a
> new header file cpacf.h containing the prototypes for the
> s390 cpacf stuff.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h         |  19 +++
>   target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 227 +---------------------------
>   target/s390x/tcg/meson.build     |   1 +
>   4 files changed, 266 insertions(+), 226 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> new file mode 100644
> index 0000000000..a6e68f17c3
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf.h
> @@ -0,0 +1,19 @@
> +/*
> + * s390x cpacf
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef S390X_CPACF_H
> +#define S390X_CPACF_H
> +
> +#include "cpu.h"
> +#include <stdint.h>

<stdint.h> is already provided by "qemu/osdep.h", which all C source
files include.

> +
> +/* from cpacf_sha512.c */
> +int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> +                 uint32_t type);
> +
> +#endif


> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index f5189ce1c5..d731fc6c2a 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -19,232 +19,7 @@
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst-common.h"
>   #include "accel/tcg/cpu-mmu-index.h"

> +#include "cpacf.h"

target/s390x/tcg/cpacf.h ?


