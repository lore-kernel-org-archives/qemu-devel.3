Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FFEFC034E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw1x-0000XF-Si; Thu, 23 Apr 2026 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw1V-0000Sq-2Q; Thu, 23 Apr 2026 11:31:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw1S-0004lq-Jk; Thu, 23 Apr 2026 11:31:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N6g4jj3516951; Thu, 23 Apr 2026 15:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iwXSsO
 DN2+7boj8NrskZGZiiqiFSUbQvG+2m7uNCH3g=; b=dv1iuhW3vXACorQIWURLqt
 Y9YyurHa1PP0buKhV01vbVpG4fU0rlMO/pVVTt64PhhGIc3CejlV5Cc9nVGaNcRh
 xMeJaOPHHovxJpWrur5tWwBlp44M5dARrEr5Jc2LQ/Oe9516yXieWBDMllVpYolI
 WegdOQlRQRsfjyrm5+1U7xZZUAWuvhaqrnZXovD9wWIE6HiFXxg9yFclArTzGSIV
 5EzmIOrv54A/qGBDyXrTgGFrEQiUFNs2zaKp+pe+lt6eAwS7JJ396ZAlwLWOiM+U
 eUzskd1LL+vYLwkUF2GEFZfl61PgJmxL/URtXReq9K8xUo9YNE1S05006IA802zQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu29e8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:31:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NFKPTq017161;
 Thu, 23 Apr 2026 15:31:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyf5yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:31:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFVCBR51315128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:31:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E5C420043;
 Thu, 23 Apr 2026 15:31:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 024E520040;
 Thu, 23 Apr 2026 15:31:12 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:31:11 +0000 (GMT)
Message-ID: <967885ce-9a05-42b3-b2ca-b228c8bebd55@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/s390x: Compile vec_helper.c as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-7-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MyBTYWx0ZWRfX7SIYGc7ke6nT
 5d6YVdTh6lBx4q4uW4WvRTZlrM+JOWpm3bmzDJ74WR2/vDpcTS6vgadvfzAn56rnoBohXPRZbXC
 lKT4LDyyVfit/QeUi3paLXgkzDLRD+5aBD2WOn7B61mPQT2O4pW8/c25rx3KAO7hGby0cJyjhrJ
 kj2ZNS4WMcTg0LzeF+zwwwl7pmnoEUggUolJOEVWw51CJy7VcM+HDYh00H38gtnUMqqy0hHU/j/
 r092yHMvawm6uBgvOVbOc0Ly8i8HO1Z+ByKSyCnFonma4VimU3lV69PrMeQtN21LGcamSX4zLsq
 2n6F1dmUc6mcbrFt06kGOjZRdThjfHdlQ+RiESmfSodhT3ZcUpBSWiTG7DKXsYN+JUjPK99UaAZ
 uqS2l3Fe+x0Iyaa6+d+AdfmhcRJBZndU/JjPUW+QkxR0iEsTOtuuR1XOyVuPpCxCscDcHoABQ1t
 w4mX56Pb7e+go46Au4w==
X-Proofpoint-ORIG-GUID: ZkEAfFCVth3asf5gxLcPnhP9DgdiOM1l
X-Proofpoint-GUID: ZkEAfFCVth3asf5gxLcPnhP9DgdiOM1l
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea3b45 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=UX6aIm688bfipJbzXcUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230153
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


On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> In order do build vec_helper.c as a common unit we need to
> replace:
>
>    "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"
>
> and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Unrelated but could VLL / VSTL leverage the Int128 type?
> ---
>   target/s390x/tcg/vec_helper.c | 34 +++++++++++++++++++++++-----------
>   target/s390x/tcg/meson.build  |  2 +-
>   2 files changed, 24 insertions(+), 12 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


IIUC, we are open-coding these functions because the wrappers refer to 
target-specific abi_ptr and are therefore effectively deprecated.

Does docs/devel/loads-stores.rst need to be updated to reflect 
this? Currently it states:


``cpu_{ld,st}*_data_ra``
~~~~~~~~~~~~~~~~~~~~~~~~
[...]

These are generally the preferred way to do accesses by guest
virtual address from helper functions, unless the access should
be performed with a context other than the default, or alignment
should be enforced for the access.


And it's a pleasant surprise to learn that `for (int i` is in fact 
allowed by docs/devel/style.rst.


