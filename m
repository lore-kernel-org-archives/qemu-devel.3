Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D178C5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsiM-0003vf-6F; Mon, 17 Aug 2026 04:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsiK-0003v9-H6; Mon, 17 Aug 2026 04:29:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsiI-0003Oy-Rz; Mon, 17 Aug 2026 04:29:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLWMq41866853; Mon, 17 Aug 2026 08:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uAjXUA
 MslYXYKKBXhAlhQCe4aFYDy2p48BTY7aXnk20=; b=RyzJd4dgVQzFillAWtlJEC
 gjdOWjAlXLged96OPatmbcdRyRf2rUETV6ju8rY6NEIEdmCsc0szF/aVZi09N3kn
 CXv0QKTmIU3DXm/CXoToDZ7r3/ACtuQZgp2b7qEyS+5OEb3WiWwyXY4MK/jeVFF+
 ThgTAgJQ5Kr3ybksq89GY3D86jHv8E2+p2gAslJtqLWvSMeL1kcU7S8dkXOJGNT3
 6ejBBIU9Si+PjBDlenDyF2T73ZZr9cfG4Pje21dQlmS5FBTV4YYsuotk0IRQMtr/
 igND+q2FYhZBAuRQXtx2TG/Gpv+X9R7CtyjjlbdyMSFaEJdNL0tabQtv5RnMbYfg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqh6fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:28:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8QJUL002488;
 Mon, 17 Aug 2026 08:28:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejw58w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:28:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H8SoqO40043004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 08:28:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35B2F20043;
 Mon, 17 Aug 2026 08:28:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A579820040;
 Mon, 17 Aug 2026 08:28:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 08:28:49 +0000 (GMT)
Message-ID: <49c9f364-6786-4949-a0e0-26f0a82ee168@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/19] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-16-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-16-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX0IVpMeNvS5v8
 hwCC6JkoKMcN81Vykg3irM/HW74SktHs/8pfX112wSamPvxU3EKHyta1DwnDQ6/NcLypXl+kwMM
 5TwjQn8xVYx/bteCYN80P7SLX4AtBlrD4TiSeD2k5ldAD+tlNOz+kbKLomwDREQHoGuAtQKMSVv
 lz1mDWSItsAFt7D/9dkxKP66gFrdHjeUJSWQGXnRg6e3sTzzJz+baAttq22IkE8eO/BSibvR//T
 UndICnftKV/kN1xwJ8kjR+fA5rhDC1NaKb/7jTsVqRJzG2dTAVeHj7Rz/m3ypdVS9A6vmna0CkC
 R81wbFwB4Mmyok1cCNpLIJy6/HYRVRywHDE1M9wQYCzZqI6Bo/Xf+T6k+SkRg565E/WB8bkG9jw
 JuUVIideG38fYrJBzzkjXf0M6LiWuxcMiyKIX1bGRIOglH30YJu4CHU8iaJ8EjybmweDMmxpVsg
 rTuJ7+LEvDJ5eMtQoVg==
X-Proofpoint-ORIG-GUID: zouY5WBnlzSw955TcMs-I8-YR-zbwdK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXyfSKu0bNUdPN
 A+QCEsTzEA808PuasOstwB8PZNIZUdpUnfUgyHFMyuw00j9pY5YH80mIot6e6rrb5EcRmUrJ+BC
 c7FT0w84n7TcjX2/BazZ6nIt0DaNtio=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82c647 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oP_v4j5VuBO_2k_MHp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zouY5WBnlzSw955TcMs-I8-YR-zbwdK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 ++
>   target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 95 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


