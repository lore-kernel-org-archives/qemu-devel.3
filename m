Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACC8C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 22:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrNwY-0005gk-M1; Tue, 04 Aug 2026 18:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wrNwX-0005gA-6N; Tue, 04 Aug 2026 18:49:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wrNwV-00074O-N1; Tue, 04 Aug 2026 18:49:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674Jo5YX1859543; Tue, 4 Aug 2026 22:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K+t3uI
 jfRkcVHh3i+UAC1VOqZb+h/oXtN/ORqUHMaAE=; b=WIHg5GbQmAK45i9okwTy0r
 b3ysq7oufJPQfdXUEMB39UW3hFcUEEZVTps0SN8z6FEk87W8vpzK8WQyJ5sbHioa
 cD/qwAvg6KtlwaZLWpw6s0nVd5T7pPR7SsqGSWUZ5yZfuS8fxQT+zWnNwuBTU/a/
 4XboHB82AwCVKFhumpYBXe04QjjGe6XoiGgWtUxSYTCR4VJm8ybYUv2KlG73+aWd
 knvzrQREDmGDXHWR7fRzPZ41NtAI+YiMcS6rjQnKw9Uxu8ykr3XXmxa5FBKbpqtK
 GqRQ1NDvk52ZL01WKFniKOK/oihazt/r/pz95T0sW6VLVJ2sbCzX/sLr3CqvRJAQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euqsjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 22:48:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674MQFpU001693;
 Tue, 4 Aug 2026 22:48:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qm6f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 22:48:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 674Mmtuk37224714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 22:48:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02DE62004B;
 Tue,  4 Aug 2026 22:48:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A4120040;
 Tue,  4 Aug 2026 22:48:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 22:48:54 +0000 (GMT)
Message-ID: <69f53a7c-83dd-46bf-81a1-7941f4b6c5f5@linux.ibm.com>
Date: Wed, 5 Aug 2026 00:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/18] target/s390x: Support protected key AES ECB for
 cpacf km instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-13-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dqCe9d2UbyP-Dx0xVda0LGJcF1u-yn-9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NSBTYWx0ZWRfXz12FxwiFscGK
 64NACJXZxO+KP9TbhMZgAN4nOnpxDCvvzDdHHm7BcPb1G/qJNTDOQqk/aaThylGbB0uGDBnc7E1
 tdrO4Cd25+cfbKXCW+Doc6H1HIUZ07E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NSBTYWx0ZWRfXzsji6TSR2aOA
 lpaeJ8rVqJV2MW8g2mfITJCFdRAqqH8c3+V04ssAWW5UTLBtnStnitLCR0akn8CmktZJGj0GHBQ
 ToxEFOb1yHDmXsOmMcw/iPlLau/jWIysrj1VIyrknbjb0iLpXzdwrIVgWrIL39RwiXlSbX1WzKh
 c3EVH2aqPa/BBU1bo62NvwrjRFZgpoh5mzKrIgWRdsYsYCVgsAN08fEhgh70HdPPBBiZ4Wrxyii
 5g97rfUvtkAKe0mvJfj933rIF/4TBAmPGKd9/R4DPZD55vcN+Gh9XRPzMltbQ2zr3fpfM9GqDrb
 fwMkDfmcl4i1E+akbDllsF+PzeAQp+hZlNowdcblQLL6q6H8RG7fqRHGJKMd+BcPeHYVhVdMFGz
 TY6bNbITZgwjtIRduvftTYkV01Vc42pnMT90mkxhaXW5OKVcj+RVsl0nu8C1B076qgeeXJMmIzI
 ywdLyMQdCR0jCy3Q2sg==
X-Proofpoint-GUID: dqCe9d2UbyP-Dx0xVda0LGJcF1u-yn-9
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a726c5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=W9WUg5CHmUAy3lohqJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 8/3/26 18:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
> and CPACF_KM_PAES_256 for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 91 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 105 insertions(+)

[...]

> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
> +        if (mod) {
> +            AES_decrypt(in, out, &exkey);
> +        } else {
> +            AES_encrypt(in, out, &exkey);
> +        }
> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
> +        len -= AES_BLOCK_SIZE;
> +        done += AES_BLOCK_SIZE;
> +    }
> +
> +    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
> +                             *src_ptr_reg + done);
> +    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
> +                             *dst_ptr_reg + done);
> +    *src_len_reg -= done;

Should we update registers after each iteration?
Otherwise there may be interesting effects due to swapped out pages when
running in system emulation.
Blocks crossing the page boundary is a similar issue, not sure if it's
that easy to solve.

[...]

