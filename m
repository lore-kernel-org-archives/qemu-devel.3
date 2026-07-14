Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D515EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjc5o-0007Fb-Kx; Tue, 14 Jul 2026 08:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc5f-0007Co-9V; Tue, 14 Jul 2026 08:18:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc5b-00035e-MX; Tue, 14 Jul 2026 08:18:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfuC41222842; Tue, 14 Jul 2026 12:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pX4ik/
 S5DtXADHi303x9J9wuMKjeeNYUChDSNJ8hFTw=; b=Ohj/7jn8bszmbq2BFRKVFL
 F4yZlqV763X77SwajO68Pzs3urAoKynq1NSk2HXvaub+JqF5xMoCB1lozPWhBvxN
 l9XlshuHX53g/k6VmyioktJuN2Bx9nUps7BQ8kyAZEbPk5esMRNMaBCk1NTWid0u
 JnIMN7GqLG4cJrVKIAqZI8vzeVRF4i2i+yb6D5ILCyO4N9LeP0ZQs++hI4GuOnZj
 aETO7cPVNRliRy+CSfBW2/+B7PczbjrvJt5NIglxS+83g7Peo7VcxIO/fL5SmNGu
 6dlbAAB1Pyh2Uaf1ADRkPOc40rSb4kTJfAuu0ffOekCi5EzupBzrAVQoxhKc5GKQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt62tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:18:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4hbp013872;
 Tue, 14 Jul 2026 12:18:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhakch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:18:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECI6vm53936552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:18:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3C7520040;
 Tue, 14 Jul 2026 12:18:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E782004B;
 Tue, 14 Jul 2026 12:18:06 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:18:06 +0000 (GMT)
Message-ID: <9cad3810-8730-4075-90d3-7ec8b79c5a1e@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/51] exec/breakpoint: Merge watchpoint.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: WncKR8PNXX6xAJki-ptN4kjVYlmWFf8f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX8Wm9Fv6cEFrU
 P6JdjEhB2ZaZtoU2QAblMyKN6HuDnxtQQB8U56xnDWKgwFESGJ1T+1blEVGaFQJ4Kz8LkGu5p9K
 51JB7yXkLfzEDDVr/Q/nj4gQv6kAKek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX/gfYZ7bv9E3k
 gOmUr+1UTdVV83/h9lhz3vIyRUVkk0D4dJCsSNoXPFKj+cHXomcSUp82E6+d71vHXj+MA+9HUfE
 74bgBUndPkyV36g0loax0SrdVC/JymTVyW7U2HScn1CICbAaoX/eg2RDGRsLKKuML2GmUFH+oTd
 o0H/hXdy5ouGth6AScHHGJ3A1mN519cPyWnnUiCgjJvSF3RfP8O2FxRoPAOBx92f2N/94hcxGVr
 1H1RDYUpslVe7T30CYET6O1lwB8XmicSUm2QazTeFgjxP30qO/UTSdBsNCfXy/W3D3eJ666aMkK
 XNiAiY1AzCXB4B9tikFQsMV63uxGpSiLL59z5dA6L1Bt37dPftKDuGiSbp1bEcb0YXyrA4c3VO5
 QNlz5eefarFNs20I2+OuNrQ3c1y8oTOmsIB3dA0crHBGJOqrvkF0LN4dVVPgiE0J2uTZDPgV58p
 OPex0zvQbLDMdKO0j5w==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a562902 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=8TNr9PKFoCkyBVw7TowA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ghkMKP6E5H8-MJQcNxwWagJg4j6qpZkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140127
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
> Move the contents of watchpoint.h into breakpoint.h.
> Adjust all users of exec/watchpoint.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  7 +++++++
>   include/exec/watchpoint.h           | 20 --------------------
>   accel/tcg/tcg-accel-ops.c           |  2 +-
>   accel/tcg/user-exec-stub.c          |  2 +-
>   system/watchpoint.c                 |  2 +-
>   target/arm/debug_helper.c           |  2 +-
>   target/arm/tcg/debug.c              |  2 +-
>   target/i386/cpu.c                   |  2 +-
>   target/i386/machine.c               |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  2 +-
>   target/ppc/cpu.c                    |  2 +-
>   target/ppc/cpu_init.c               |  2 +-
>   target/riscv/debug.c                |  2 +-
>   target/s390x/helper.c               |  1 -
>   target/s390x/tcg/debug.c            |  1 -
>   target/xtensa/dbg_helper.c          |  2 +-
>   16 files changed, 19 insertions(+), 34 deletions(-)
>   delete mode 100644 include/exec/watchpoint.h

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>


