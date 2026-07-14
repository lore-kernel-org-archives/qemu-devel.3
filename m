Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjc6Z-0008Sb-R3; Tue, 14 Jul 2026 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc6R-0008Ov-62; Tue, 14 Jul 2026 08:19:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc6P-0003Cx-NS; Tue, 14 Jul 2026 08:19:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfvuf1195025; Tue, 14 Jul 2026 12:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PR2MMR
 p6D6bH6r+AGwKtkLdn0oI2XqQ9GgHAQZFH1D4=; b=Hshr/gEi9/kit393anQ4wG
 P/FvNBg8dtZ/wwJCQqc6HvB4I8pVDb1Jjt4ijkUpDcyagbrz7Ht9l6bUMznNHWdV
 MDFTNBtExUkJrb/JnZW/2YIQQdA9oFi9Jpfe559ZQY+AxQ4Vcf2oP7Oy1eGU49RR
 tbmQ0Oh8XGLRRFacnrAoewHyNetuuUSMKFRXGFmrySf4gF7dXneoso4YDIimsj4f
 t++JZ/bCWIXwwuGwxreTuMbVrxCqMMAWaRvqBvaGUTXlQvXlk+CPAejs5u9hZOiJ
 dqXAkUTdzoZVayj5pY4cJL6NmJlswjGZD9ap4IHE5XJTq0sEspRt5eAbmUs5rahg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnkdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:19:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4jWC008499;
 Tue, 14 Jul 2026 12:19:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw2td2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:19:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECJ3ew50069988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:19:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9ADB20040;
 Tue, 14 Jul 2026 12:19:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0E9120043;
 Tue, 14 Jul 2026 12:19:03 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:19:03 +0000 (GMT)
Message-ID: <aa20be1a-146b-41bd-91cf-407cfc6813a1@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/51] qemu/typedefs: Declare CPUBreakpoint and
 CPUWatchpoint globally
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-5-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a56293b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=o3MmJ17ztR_1a3fD9IoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXzhthc1Duys4R
 uTk3jPk8Eu3K+3cnSDNAfJBGJ+gdLVOU/eoTXeHOluoOtX+FFWK7GLTDJ5GLf9SFolQDOwV3r8q
 r6h6F/gHvLY3XtZTfgNEHAP7Q4wOXpVwOvSWPLeeuEzIptboawcc/InltqgsQ5oF7jZIdOJcN8U
 dB6UCkn6ILxcNFl9ZnbxLbo0SCrham+Zri/gugcuYf58XrnoajoMUP+gmBLIupV3iTCdoMPadb3
 qdC7C/QCm34q4IlLUTSyN2SmarjL5Mqjdm4bnkFWh0eplAZhrJTwEADd993vj66QVH7C059Qo3F
 UPnQw8gDTssXvRK+vI0WP7dApiSPn1p1E4z8vzX16AX6AZ3FDgxCFDbauYnPx7YbCiogy+31xer
 h/HGjBEwDuK9tzkjI1bK5yfezBy8jp6kk2eDDLOBJRDpit+BupXTMnktY60ksUJCfZHXaPxeces
 7wg/PtGp6yN7fsaBe3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX5mrgVUvZD/WC
 7PoQsGAJxcvJReUC+HO8BR3n4ANHJtutdAPKVcbq4jmw1vZWHLrfqz7iN9u4zp8A8nz9piTPgYv
 C7lyyGPKb29bIcN5QpDrqPZXfoJde8o=
X-Proofpoint-GUID: m3-LTVzKCMWSWNgO7GxQNthAFFfb4NWF
X-Proofpoint-ORIG-GUID: JOAwPkW414OrQaPQcyyatjKDTtnIPbXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140127
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



On 7/10/26 22:53, Richard Henderson wrote:
> Adjust all uses of 'struct' in the uses of this type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 8 ++++----
>   include/hw/core/cpu.h     | 2 --
>   include/qemu/typedefs.h   | 2 ++
>   target/arm/cpu.h          | 4 ++--
>   target/i386/cpu.h         | 4 ++--
>   target/ppc/cpu.h          | 4 ++--
>   target/riscv/cpu.h        | 4 ++--
>   target/xtensa/cpu.h       | 4 ++--
>   target/riscv/debug.c      | 4 ++--
>   9 files changed, 18 insertions(+), 18 deletions(-)
Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

