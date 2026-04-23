Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C334FC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvnT-0004lw-L2; Thu, 23 Apr 2026 11:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvnR-0004lP-K3; Thu, 23 Apr 2026 11:16:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvnN-0007W8-BG; Thu, 23 Apr 2026 11:16:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N7GX0M3515313; Thu, 23 Apr 2026 15:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kDdWvi
 exPc8JfNpwMYGEQHN4+gl7jHjB10bbT/w+4w4=; b=mYl6OJFFgJI8Jl9xnu6eG4
 0x18WQqVO1+ObZBSdau3etUTRFh0x8QPJm7W6xVNtiPVX7kmwH/Myxg+E1hs7+Bu
 yzs0G28zAKJ4iz9HFlRbpQ1eBh75RjyBmYyigeiAM2t1YTNpd3yY/jZv12QlkuaX
 NNkDI9Au4voaXJ0vJ/Qt+hl+0e5p8rcA2NFD9IcTyk8RFEksj9ZvOUq6/MvpfMOa
 gOkMLnRjZgTTUMmy1oyNh280V/ROJFS3bVFDur6fPI27K+MWkFX2aHDleT8TsU4R
 mHCnYviE78p3l4dFbhKWIaH1Sv7N3+DZc1c7nAbLs71X17DeU0SJVop2Tnr4o1yQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu29cdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:16:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NF5SKS017178;
 Thu, 23 Apr 2026 15:16:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky74ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:16:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFGe0e30540454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:16:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D28220043;
 Thu, 23 Apr 2026 15:16:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01FE320040;
 Thu, 23 Apr 2026 15:16:40 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:16:39 +0000 (GMT)
Message-ID: <f9313fda-3374-4b51-8594-3dbce3c1d1b7@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/s390x: Compile translate.c as common unit
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
 <20260423135035.50126-6-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX4yZIGhl6gEAj
 KRkSLXVe5byvFM9ofQ5aqkmjbivlAzC8eRf9BrftgsztCmzgS/xUJoxdP4Qr0KgOGCjZpGvzF6g
 PIZjx3WHthtomK52WNEFLKvyEDByVjRnP+RZKbYDAntglORTdnbQPe53TCI+nDPRbtd2THDr/Su
 8X5KKhW032MylZJfmtkkzaOHD482XZh0hV3K3nWyfQGEuqo4modY90zJoci2h7iF0cZhKh55IUy
 9D+eZvJQilrnLmw3/Y5FXw49ah/e3NOTOIqLFdgCaa0as4ER5/qGapIlXE1xB9ZI1ki2ZFcGRMc
 AZJGpm+J9R/Oane/G8NVz/PnZY5zQbtX0SdBpi7IIwy65V4BfBOW1/IzPfg9Fstfxo9RY7r+jX7
 yh14dcAwL78zTWNtCWJBcYcSnRKrVpsgxklTPRMSflP25YkRuPhIw7izd701WH0iLvuxs9Rxq0d
 2FTrVKR85jUyUVtP7VA==
X-Proofpoint-ORIG-GUID: xY4tVvwFHHF9AnVhIBpTX4XoUHAUpYV6
X-Proofpoint-GUID: xY4tVvwFHHF9AnVhIBpTX4XoUHAUpYV6
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea37dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=hGxi2LaFjyUuuG466sAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> In order do build translate.c as a common unit we need to
> replace:
>
>    #include "tcg/tcg-op.h" -> #include "tcg/tcg-op-common.h"
>                            -> #include "tcg/tcg-op-mem.h"
>
> and:
>
>    "accel/tcg/tcg-op-gvec.h" -> "accel/tcg/tcg-op-gvec-common.h"
>
> taking care to define TCG_ADDRESS_BITS, which is fixed
> for this 64-bit target.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 6 ++++--
>   target/s390x/tcg/meson.build | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

