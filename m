Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8DFF589DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvQ4-0004r7-Rv; Thu, 23 Apr 2026 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvPS-0004nC-5P; Thu, 23 Apr 2026 10:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvPP-0006In-Mp; Thu, 23 Apr 2026 10:52:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N6ooT83229044; Thu, 23 Apr 2026 14:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wSUDnX
 EYwAfWKXIVPLVfFpw3pDJ/UwmKesLFe6+qCic=; b=gHdJasYKvQoeEDlTYkVjOh
 ffghMr2KRGKk+cvxOxeXd+oZmXEpZ+zukoqk9GtPLoYKVncc5lI4JNVkJVc6Tb07
 TOf2KVq8LGHXWaJv5YS3bhGxlhq2iRH9yFQcirzeAV6QdCbf+Ao+U48u61HmCAJJ
 va3U9XMQy+f8sPszHBQOpkpCu407ABMCdJZlfAI3y5oWD9vUbbVUaawfsXbS0kun
 O++kkKfG5tCm6uYqIMbAiq0VZfl4dLkHHH0o2/YqFvDgajFHIR637KBD9JW/1fX7
 D4/yzU8aZvKNeuMBfplYVtxxSjuwNRBa2Fnb5hsEf5ux9aW7UjGnwkNpcV9jswmA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu297m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:51:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEoU23017995;
 Thu, 23 Apr 2026 14:51:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxy1s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:51:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NEpqVm57868584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 14:51:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB62820040;
 Thu, 23 Apr 2026 14:51:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48F6C2004E;
 Thu, 23 Apr 2026 14:51:51 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 14:51:51 +0000 (GMT)
Message-ID: <38d862ea-a10f-434b-bbe3-0101f5d6ce53@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/s390x/tcg: Compile various files once
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
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YO1MVQDvC4pO2SLr9_wkyTjQ9HX56OsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX8WRpG8X8Tc7v
 bbWrj2G5yM9fBpdiCyFgWzF1xM+z5QiJ0qZqf3mLi9YwfqWZjLClJ1vMhVDh/UMC2SApHRGgybd
 RjMirc6PEe2Koy0Yp8RiSJIfhPsEIUrHygRXKA5KdBT4MosZ5DUixTVQwV9QDyXRnjqHz36S8cy
 zphnFwWVxdCmswWAxFkPkmzX0PzukGHHn0CBv6rFJwoomlPCeo50HiRx2knI3RGdbWsiB/hUnaJ
 4d+nsM+RPggybh1j2K9zld28zObhu2I+KjOLyA05dp2+1VAmMsMtPnc0/jp46TaDb4Ua+d6rQNJ
 Xi97+Bd5nIDjUopI+rzLpLFv2eYawIr0Vt1YWAlselot+gXmUSHZYzHlhHQlu6kANnyfSfYLXEj
 5OTXFqA7JFnf1Jzyr2Ln/AMmTX5Ek/Vt+HmSPaY64o6C/iM8fXiC7E2xazHw3gtSr1+sLmyR6Le
 jgXwitmFaVA8Jk3qI9g==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea320c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XMrjGKu4AhFhdr-ovocA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YO1MVQDvC4pO2SLr9_wkyTjQ9HX56OsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230148
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
> When a file doesn't use any target-specific knowledge, it can
> be compiled once as common object. By moving the file to a
> meson 'common' source set, we ensure no target-specific API
> will be ever used [*]. This series move early few s390x TCG
> files to common because in the current state it is cheap
> enough to do so, no need to procrastinate.
>
> [*] https://lore.kernel.org/qemu-devel/beefeef5-96ba-4645-a01a-7ca96055d93a@oss.qualcomm.com/
>
> Philippe Mathieu-Daudé (9):
>    tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
>    target/s390x: Do not compile KVM stubs for linux-user binary
>    target/s390x: Introduce common system/user meson source set
>    target/s390x: Compile few files as common unit
>    target/s390x: Compile translate.c as common unit
>    target/s390x: Compile vec_helper.c as common unit
>    target/s390x: Have MSA helper pass a mmu_idx argument
>    target/s390x: Compile crypto_helper.c as common unit
>    target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu in STFLE opcode
>
>   include/tcg/tcg-op-mem.h         |  2 +
>   target/s390x/tcg/crypto_helper.c | 80 +++++++++++++++++---------------
>   target/s390x/tcg/misc_helper.c   |  7 ++-
>   target/s390x/tcg/translate.c     |  6 ++-
>   target/s390x/tcg/vec_helper.c    | 34 +++++++++-----
>   target/s390x/kvm/meson.build     |  2 +-
>   target/s390x/meson.build         | 25 +++++-----
>   target/s390x/tcg/meson.build     |  8 ++--
>   8 files changed, 96 insertions(+), 68 deletions(-)

I assume this series is Based-on: 
<20260423100229.2941820-1-peter.maydell@linaro.org>?


