Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B5C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRWT-0007MR-Na; Thu, 16 Jul 2026 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkRWR-0007Lv-Q5; Thu, 16 Jul 2026 15:13:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkRWP-0002dl-Aa; Thu, 16 Jul 2026 15:13:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGftUi3741647; Thu, 16 Jul 2026 19:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lP42QA
 nIo1YZ1Xscfjx0MkwvCkJa6z1nsORXKrWjYDQ=; b=b+NEwU+A97C9Y2wwp2HwGn
 Bxszx7O2OLPopXN7oVgLgHMTtDlOREzfuJWk12ZN26ifnYMlwkRE1Q4JvR0N4iqL
 IoeofuExx4yXsPSCI/HTPeKMfHh9jSM29cXxeSMeBYHdV1GsWYovIID8cysC6mb6
 DSecWRAuGl/vgpPLzJF2mOVRa1JdUpqAd04DDiYXM+CifJhRF83bAqZYEg/szbMX
 sbHTXLZV+EDW1Phou1wcZynwAM6rsi0Dvd/7MW6lK/9CKqZlE31QMfc5rEk4ohZj
 rGvBXscHbDRszSZq3HNzlMplRy1YTmflf26BBBQYQ8dzkisLQL6bLmst5++004nQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc1vbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 19:13:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GJ4c1W017377;
 Thu, 16 Jul 2026 19:13:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qep43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 19:13:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GJDH1p57344462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 19:13:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2A1020040;
 Thu, 16 Jul 2026 19:13:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A98020043;
 Thu, 16 Jul 2026 19:13:17 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 19:13:17 +0000 (GMT)
Message-ID: <f7bac53c-07b7-423d-9097-597f22de24cd@linux.ibm.com>
Date: Thu, 16 Jul 2026 21:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 47/51] accel/tcg: Use addr/last in
 tlb_flush_range_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-48-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a592d50 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=SMBLCNIavdkbERnTIUsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX5jnWhrGwIKww
 itMj92kv5NjBzpUTeDoDLF1TgGY7yXAhkIdKA0Gu3grvp8cmhzXQqMRt25Xg3KUcZgOlqLGqkcF
 DP/s5mo69V1NcCr48qGABV4SPy3s/Q93avmL8Je2fT7S9tiL0Vk5dsSVLcUD3xFGb7UFb0N/Sqi
 k+39OwOjfMeNVOwYNFvN7RWrWtjEZCc07mQ0SgXr6fIg/bplKC+ZK+iyMfkzDzO+MX8zTwvnwug
 CRYihhJFoz4BOZjMk2wfQFRQ+DwlbOXGC0+dxdqJUiUMaEqlRq3xGoLVkiYfFvbeTwCkrKhYsJI
 L7jsFABmEdlXBQuiLewIn/0lj//PsxC7zZXsyC4z1/eOFDVPcqkJF4NDzqqSOTpYSAt3n809Neq
 QFJdznoKaMn8c+Jmc3BRmVSmNGVpGwo8m8FJcHxYDJxE/YLgISZNAH8SjcxlG7S8Kr2AYGwWzHH
 f+F2peiPiaCHGbachhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX0t4ipo1aBnBp
 2meJAmJ6nIILdWI4KGdnR+W+BHA9pnsPjigi7INJsFSxItNXPgt1jwLyRekVx+L6XkGrEbSoWKA
 erJksN62Z0PszNtx+eGbTFDGYwW9kTc=
X-Proofpoint-GUID: pwBL4LUWX4JeUIKW7D9H_HKfmFxMb0Jw
X-Proofpoint-ORIG-GUID: BD3nRxU2iYPSe9BDgd9KFuqFsGxcrcW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160197
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
> Change from addr/len to addr/last in the implementation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 71 +++++++++++++++++++++++++---------------------
>   1 file changed, 38 insertions(+), 33 deletions(-)

> @@ -733,7 +736,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
>        * If the length is larger than the jump cache size, then it will take
>        * longer to clear each entry individually than it will to clear it all.
>        */
> -    if (d.len >= (TARGET_PAGE_SIZE * TB_JMP_CACHE_SIZE)) {
> +    if (((d.last - d.addr) >> TARGET_PAGE_SIZE) + 1 >= TB_JMP_CACHE_SIZE) {

 >> TARGET_PAGE_SHIFT?

