Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605E4C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqs8I-0001KN-Ta; Mon, 03 Aug 2026 08:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqs86-0001JA-V7; Mon, 03 Aug 2026 08:50:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqs84-00063R-Lv; Mon, 03 Aug 2026 08:50:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673CHeJV2018378; Mon, 3 Aug 2026 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U2Mb0g
 1CcCJNXTKVw1hg7SBjYJM5305/Vmv5yE76774=; b=aRITPn648Y1B+mzUzgjtZi
 iFYP71So5gzOfx1QvwayGRscHS9/e4jumxlsEr7NLNRruFsI61Wz83IO7gYXiKX9
 VM71V1imzqlDsAnvC9U39RCSqz2E51CM9IxfTB3PFd0yNl3U9xfqZ6JyMbVYssZo
 CKse+juNuyOhn8FTn/CpevGL0QfBOk7j9R2p7Ayy0iAKdSGG2ZWMK9Ppje0rBTkZ
 pRI9mE+CcnVMKVwfoHlCiIZy5GGCZLh4Yw8lGrcXBK7tjdQL3cd501qLlGsyrd/9
 JZ1UVVZMnzHa/CXJXwvQeJ//TSrtF8UofB/j8R9OhSciZrQrj8guhUdMJqEHu5gQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rsgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:50:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CfFVR019175;
 Mon, 3 Aug 2026 12:50:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwfcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:50:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673Cohtf45547786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:50:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB6802004D;
 Mon,  3 Aug 2026 12:50:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F76F2004B;
 Mon,  3 Aug 2026 12:50:43 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:50:43 +0000 (GMT)
Message-ID: <7d7352af-b0a4-4279-b301-714687f9d46d@linux.ibm.com>
Date: Mon, 3 Aug 2026 14:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 46/51] accel/tcg: Drop stale assert for vaddr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-47-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX6RZ4txgvwXYa
 crQbabxlAestjE7oGs+X69+lzfBhXq5GWAmip822ZmWulCvZ98KO/HQYEhiQrZZ6Pksh6iH2m0L
 eJH4cp2BlDJB/9hYPqkSC2VxDlbi8Uo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX/Q72OotE4ECI
 qk9cE2Nyp1qExwDACAwUnbx2bS3TRV/TKPopvsIg83E9/8n0IQ3N9KMadSMwoxmpj0iU2yYleUe
 YYtwN9AelxZG2nqKTZU1qA7XiqCX4tMiBDC6MT56RNV3cKovohjL3eC4Z3qmY/agXca8k81vnJA
 iKeX2LQOIZ0MlmdS+uytx1ZvIcK0IFfHn8go6+QfX2OjXqq5CbpchRJdW2RpU7s6vp7lc4bLYc1
 mBfCCi14ZLBSCUeZGZICIeZsxwriEJjn3s6cz7mTojuvv4u/muuXJuwg5pYcgGH9833WK4zQm0Z
 B/yJW6ht606kZ+ZgWUgFv6O7gFNkl4+cNSZ+ctyb5hAzdVUMwS52jIt1+3BI6638jmBN3fU593j
 ouxDNzJmwc7zIxUlzOImOqYHY8THMKqd3NRleEJ2Mo3iRffXbkUOQ8xydROVstXwUFpAZ3wI8oH
 lpwIRAkABt18k5hz+pw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a708ea7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=qhOfKEHLbIVasD_96nQA:9 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: auc26dkYp-XnTj8vL0JCynkZ_m9yKw09
X-Proofpoint-GUID: hr6QFTj401ZMeSwHQAPInTgkNJqpnIZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> We no longer support 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 5 -----
>   1 file changed, 5 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


