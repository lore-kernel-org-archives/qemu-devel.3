Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjYuD-0008IA-0S; Tue, 14 Jul 2026 04:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjYuC-0008I1-7M
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:54:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjYuA-0003iw-HP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:54:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6fs00559242; Tue, 14 Jul 2026 08:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=A5+9GL
 x0ehNvR7jjsbz1ogatgHSuV77L6wqcR8au/n8=; b=QcMgPfPdBrg7J15v4m1uOk
 rtAvU8K5JMFqP9a6mrD1AM3rXIZibOc7oT7ZrZcK5kZdhEcPvZ+Zo4M8k0HD6Psl
 6YGzLsYyEFTCgeNo7pFNZzeH/ScgmI0Md5K8RQaKVUMVOndRxii3WYHfnluhB331
 g0h1x6XVPJxrPiqQOqUMM3xBwZdUEbvUVKs7W4DfQ+lT31xlj7aLPAJqvHxplqhK
 j0XCDs2xVgmixyNw3wnXn6MAPF9tRauotwK8Cj9zZlGNaEWDtf4Dzw1lYM5+YFg5
 4LLo+AF8iRR1boCgdM0ZuN8rFdCglX3S2wN5hNFcKjsPmhnwKWOgoFuvGjnu9wOQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxd5kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 08:54:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8ncIa019754;
 Tue, 14 Jul 2026 08:54:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy1jsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 08:54:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66E8sBpm15270180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 08:54:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A750320049;
 Tue, 14 Jul 2026 08:54:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3781C2004D;
 Tue, 14 Jul 2026 08:54:11 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 08:54:11 +0000 (GMT)
Message-ID: <584dbebe-6105-45a6-ae4d-d0fb4fc6eaaf@linux.ibm.com>
Date: Tue, 14 Jul 2026 10:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 82/98] tests/tcg/s390x: user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-83-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710214343.2065491-83-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VMqU-6jC1czyDztAcJeOfZ9WBMe9QnzB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX72hAIkh5cO8Z
 BnVmCf3/rySKVpej0IzrAfk4Fcc9sgq/zfNZI1FIh7ISfSjaGyD1Wanis5VPuMHx9bahwxVJiAg
 DJMoUhVqIeRUQw6Zck36YvX3on701dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfXy0gFn/GCnJoW
 4RjUI8E3QN5RA1ZTOmhyptW5mxa37CtCxEf1EdxpkConWNoS22qp2nW/tx0WRdAPYUjtPBjDRL1
 QEJcMPIZc/gU/pdsEwyv++1fPhgeXCXKy6vBezViJchK5lJ+Tz8p8YReqJTRdHxqRcu63C4gTGT
 nY4EWZv4iSb7l7ZQYZK8KhOL4g1GxxblzkHUw/NiT5gWwM+8MDGHchfpznXB/UmZVZ2jkGZ1O9C
 aAtP8fznYTDD5fdRCZrXmu6a0w6biaZqW8/Q0Ukn9UIQbl90gatp9lqfbocedOtkdCvf9l7zRK0
 8Tgu2tb6MArjcuOJDt665GWtqCoObwX69Maz69CHzg/xylZ+yagLFWiCPGj18X1skmqb3acoZVd
 zE/Q/yFKxXV+olqyf+BepK5lIcsDw0hQINITPMeovdZU4iKwmSANueEIicTE6CUe61DgK3CnGOP
 7+7zVJcNEw40PijEShg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a55f937 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=EUspDBNiAAAA:8
 a=r4FInzllVyHwdzRR_9EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U3smGnKz6fUilXaGmQKFWGjkWvKUHeSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140090
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



On 7/10/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build           |   1 +
>   tests/tcg/s390x/Makefile.target | 127 -----------------------------
>   tests/tcg/s390x/meson.build     | 138 ++++++++++++++++++++++++++++++++
>   3 files changed, 139 insertions(+), 127 deletions(-)
>   delete mode 100644 tests/tcg/s390x/Makefile.target
>   create mode 100644 tests/tcg/s390x/meson.build

In general the s390x tests work now, however, I get:

155/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-fma 
                                         SKIP             0.09s   exit 
status 77
156/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vfminmax 
                                         SKIP             0.07s   exit 
status 77
157/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vs 
                                         SKIP             0.06s   exit 
status 77
158/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vcvt 
                                         SKIP             0.06s   exit 
status 77
159/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vlstr 
                                         SKIP             0.05s   exit 
status 77
160/164 tcg+tcg-s390x-linux-user - qemu:s390x-linux-user-vxeh2_vstrs 
                                         SKIP             0.04s   exit 
status 77

with the series. Without the series these tests do run:

   TEST    fma on s390x
   TEST    vfminmax on s390x
   TEST    vxeh2_vcvt on s390x
   TEST    vxeh2_vlstr on s390x
   TEST    vxeh2_vstrs on s390x
   TEST    vxeh2_vs on s390x


