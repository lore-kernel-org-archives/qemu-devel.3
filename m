Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6BBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjafe-0004oy-Ly; Tue, 14 Jul 2026 06:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjafd-0004n3-Db
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:47:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjafb-0002o5-RL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:47:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6gOsN2860538; Tue, 14 Jul 2026 10:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Vzd14v
 G35BUZsLnW2b/kftkVwOQjzPTxOLzKXUmja8k=; b=kGcF+KxdrLT0yjWLBf+NSV
 9IZNy/VHrISd2jcdARRk/scl4K3T7SeUz358gke6G/Va+4Exs+z+YTe8H9z61TJn
 nFqX5McpJSBoAs5T07qc7aie5iL/djUmvqwjDVCgIBJf0VhgjemqkzkneMxVFjRo
 26WOzjgSp5MYjodtHD8U9zMVuXH7zOznuf/goMcolTCHgJkjGOmUJ0yJWOLS/dzr
 Lqv0avivcMELZfQas3AUZ2NWGrnnLtUwIa27euXDiMwVD0JHRQpaUxYFJpXaKPSK
 8H6UtpFpAJM8LTPyQoU/QbCVriTNhse5YxZ9HWpbPIjiWOr76mvrHreP9Z5nAhbw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33679s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:47:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAYeJt012537;
 Tue, 14 Jul 2026 10:47:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw2g9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:47:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EAlHfx48955752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 10:47:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EA6720043;
 Tue, 14 Jul 2026 10:47:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF1BA20040;
 Tue, 14 Jul 2026 10:47:16 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 10:47:16 +0000 (GMT)
Message-ID: <6738c88e-235f-4912-84a0-fe3acfe50c06@linux.ibm.com>
Date: Tue, 14 Jul 2026 12:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 81/98] tests/tcg/s390x: add float reference files
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
 <20260710214343.2065491-82-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710214343.2065491-82-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfX7m3oXJNHiM8e
 G8O6Ee2aTJ/EfBuepK677R65lag4rrv34p4SrtRUCSlXBPmTwjQFDnz9FgmCKHy2wvZYzme5ODb
 yXmY2/z5Vc6jHpCESwoweXNu1rMvEQE=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5613b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=c1kGjMDNEF9VsYCui9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: no7vz5O-QgxJbersiQS6dMNrnYwKcCzs
X-Proofpoint-ORIG-GUID: HKs78s8WAuUbtVSqYYJKl57Fr9d0IJa2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfX20CV0ayLTtre
 9AudnqJB2B2w5BXVt0HHrwIAlpT4vjUVstFASGq5I3iCleYPi/lV6nR/Yyw/Od0sH9nCXb8Ew6Q
 eWpEERGGU5Xd8rdCJmHPZsigDXHKXUeTxAqQIhget6DGKgnECwnjGdXNn2TQNm6HkLGRl/Xa1uF
 bOzlxKP4bLjDCnJwoJvGgAVfwXC13zuC0sgcG4FzPMNhR2zd89akbu7vWdhrAD3RP6YEkoAJfQT
 9xONOqPfrdgu6sc+7g0n5BouS+zWbF4F1Bsee+2EYHtbeVqaz83Fdc03B4rFByIYOKRcJCbTTs3
 Djd3IXHZp/axFI8/nGU8GBAElds7mdsh8I2MX3pgaoqSPcYWK9EOHmS396E+aVIC5zs5m84Csy7
 EChd01MTPFKaMA0obSgLV9DeT5bstI1hi2g2ij7kLOMEfptY+wX2WTlPkYy4ZrNGNCTXZoB+CfR
 Sb7eCzufq/2qekFFfTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140111
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
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/s390x/float_convd.ref | 988 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/float_convs.ref | 748 ++++++++++++++++++++++++
>   tests/tcg/s390x/float_madds.ref | 768 +++++++++++++++++++++++++
>   3 files changed, 2504 insertions(+)
>   create mode 100644 tests/tcg/s390x/float_convd.ref
>   create mode 100644 tests/tcg/s390x/float_convs.ref
>   create mode 100644 tests/tcg/s390x/float_madds.ref
Would it be possible to add an explanation to the commit message why
this is needed now and wasn't needed before?

