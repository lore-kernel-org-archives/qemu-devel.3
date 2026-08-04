Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C1C561E6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrN6h-0007oV-MF; Tue, 04 Aug 2026 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wrN6f-0007nj-8W; Tue, 04 Aug 2026 17:55:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wrN6d-0000d0-Ng; Tue, 04 Aug 2026 17:55:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JnJjH4117986; Tue, 4 Aug 2026 21:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=z2PRr+
 ebiDNPFCRFsxDhHwssp8h/2KdJvtnlzWvxUfc=; b=tqRLZZOQ5r7CvlIGmrQkJL
 WeIR+BTmxKAv2DHwLpyJSid1jmc+WLFJHGGvnizQxcyAeF6LFeTpEplyNbR+TIM6
 Jr3+ZcnS8Q405E2JoYoLnuoBCpTow74byY+7QvFPiIZfY/TbPu0KoP3IKiHLkuaP
 Q+E9EUqfDDEn1UXuXf56fKLeFak0lWRG56umRVy3WqBaX7vuAwT3MoBtMD6/QynY
 4GKXW5UwmGRjf2rwh/Mrpbe203iyrK/BzfKahxWRcVMxcToCV/ZsmYEZC1r7WPbi
 gvqvW2fagOeNxY9AXNAd31T/XLP2zh0amDTYDJhAvHI2Vy5SYhX3Z2BixG93vJVA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqr2sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 21:55:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674LfMHE015894;
 Tue, 4 Aug 2026 21:55:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qm1jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 21:55:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 674LtGph30409162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 21:55:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6CA820043;
 Tue,  4 Aug 2026 21:55:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1878F20040;
 Tue,  4 Aug 2026 21:55:16 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 21:55:15 +0000 (GMT)
Message-ID: <93c0ca90-dc4d-4739-ab95-abb9237a8b7c@linux.ibm.com>
Date: Tue, 4 Aug 2026 23:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/18] target/s390x: Add helper functions for copy
 memory to and from guest
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qMExwnLBjRKhbWGo7O7lHvh1JIxUJ-s-
X-Proofpoint-ORIG-GUID: qMExwnLBjRKhbWGo7O7lHvh1JIxUJ-s-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX9ZR74rx6QbRQ
 4sgAU21sI83BtQWzWMLG0B1mQKhyXZiYBpw1scVOyrOCTBUWf8+EUzybSTQCaJGMjNwizD0+aF5
 iCt1kQhVwXkiXAE+JoJzMeENGihg474=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a725fc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=StHepGPFupVIGor_3S8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX4MuLbm9Fg7Dn
 5UFpioEAlX7qmACmWnTfCkLZNYLasJmT1elGVSgIyyBIaKyI4LE6XKCezHnzixzevucdFZjL0/p
 VAvli0ad0a/IWlSvzGPbmBWBPbqtglptwKR2hy4YeGRg/2/4p7eVluXVITYLK0QQs14S3/LSsrD
 4ASwMk9rcg+1L0lFEN/pHcJm07pCZxUYAuG+EI5o05VCpBqu6ynCWwg1jFDDQomSu8eYCcwXv1M
 8CrQMob/Z+SFvhgt+N7DfFeJUTUA9GNK3UxcZjVxSJmAiQl1xplQa+zwrThhOX4VvDyfZsclF7E
 2XmzxKmowPG1U7TazcwJjbaF9pOwxqQTuCjufYkx8XIfVGtz1cw34tvCNWCRmu0DRgJuDnzw9Yx
 mhenzi4I0uGdTnuMH5HQ+1sTfthZayo4tP1w2eljRaWgbzGrdq1qN9Sd4C1xfzeqqtT2xFHjJDB
 VtY+DGHTUNLElfkTV6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> Add some simple helper functions to copy memory from guest to a local
> buffer and the other way around:
> 
> - read_guest_wrap_u8()
> - write_guest_wrap_u8()
> - read_guest_wrap_u32()
> - write_guest_wrap_u32()
> - read_guest_wrap_u64()
> - write_guest_wrap_u64()
> 
> The reader functions read from guest memory into an array of
> u8/u32/u64 with BE conversion. Similar the writer functions write an
> array of u8/u32/u64 into guest memory with BE conversion.
> 
> All these functions are intended to be used for the crypto
> implementations thus are located in crypto_helper.h.
> 
> Rework and simplify the sha 256 and sha 512 implementations to use
> these helper functions.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf_sha256.c  |  63 ++++---------------
>   target/s390x/tcg/cpacf_sha512.c  |  63 ++++---------------
>   target/s390x/tcg/crypto_helper.c |   1 +
>   target/s390x/tcg/crypto_helper.h | 100 +++++++++++++++++++++++++++++++
>   4 files changed, 123 insertions(+), 104 deletions(-)
>   create mode 100644 target/s390x/tcg/crypto_helper.h

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



