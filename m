Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A893606A338
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o+t2YQa3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJIeX-0007Oj-N2; Tue, 20 Oct 2026 18:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIeW-0007OJ-Gl; Tue, 20 Oct 2026 18:49:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIeU-0003tI-PM; Tue, 20 Oct 2026 18:49:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KLE6QE1864449; Tue, 20 Oct 2026 22:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8zJlbl
 XkcfEoZdiMjRHCYgY9nOBFKjRUKmEr7KK05r8=; b=o+t2YQa3C3HJUKngjeEgn4
 8qSOauHK76WKpEvgOTNBkHI2g2p/ztlTgYaYRB2Ubdi75aI5YVjRDuxzfLszqBf0
 LJhsonVAG7+m/K3midsdzLHxXvoseNQthDRtVHeZo7RDWe+eqm0Q2tusmhMCfII7
 5OL/Z1sYits/WlEYdSjf+mosFDOIAErfN+zKAWMYW2xlohtGMqXCoFR0BNbyCa4x
 Vy1yoY8n4mruOiPPt1ZWtx9qJU10dCPk4uowdtTvFAAF7Vj54jzWn2MC9yzsnH0X
 dma7smQBGR1Xz06JooEF9eeWmi8gRm07iPCEO8fBh4+/nUD1YiYDRe09vOAUco4Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bdssc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:49:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KL5BM52034153; Tue, 20 Oct 2026 22:49:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs2hp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:49:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KMnUSu50790812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 22:49:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D5C82004D;
 Tue, 20 Oct 2026 22:49:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5060D20040;
 Tue, 20 Oct 2026 22:49:29 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 22:49:29 +0000 (GMT)
Message-ID: <882f34c7-5863-4ca7-b154-38afff099da9@linux.ibm.com>
Date: Wed, 21 Oct 2026 00:49:29 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] tests/functional: test_acpi_bits requires TCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t8sD2CjJbtFugig-8FOQhX3NsszbGEaq
X-Proofpoint-ORIG-GUID: t8sD2CjJbtFugig-8FOQhX3NsszbGEaq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfXykByXr7unaBK
 RuO+2/VjGqXtTi8II+tAx/o2HNq0jzJ+WImT1xgixh9ZpTdrpbuvUp3IUNHikVMk6YWnVEtzPsC
 l+lj79UMgawA17yKiEtmhVPjO2Pn4IA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfX4dCAKAL4fa8k
 b75urjLqpgWNZmJ+0G/mILCL71IdlPp9fW2sUDKyFiW0qonw+CxgOJ0mcdHEDAGuAux9Q/Esf13
 u6L4I8QcQcxPTX9eZNKQ88xC0vGYZQmwm9QS2hHuSiQBaziSi1j8lCK04URkj+S3T9iWfN99kfA
 7L604g4JBlZHc8XcBfFLseCQ09YzT9nHaKjfJW6sRVLdqPaHV0CLdYzS3K9Lw44I+DiOVDgcUki
 qVRTfr2uTjp9oUcCCiZXCidsHbuo2Ag6wPM8UxX3i9NTF52YTsT8yT/TU0q6WTi0oZK02VL4tlI
 MwK10mhrcQfXCbhHpZpGb+IaH68ZjtJMfw0A2FGhXJI+RHsGyDKD8VHjwLhV3o2vDeAbMuordhQ
 wJctNeekyLZ4y7Rnr/t3VMMZ8kd3TE3mNFzZyr9jp1miUAJC1mX9OcFU19IqmOYRiujhMuxxPAK
 CV6ljPQAFkjSxTtBnNw==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad7efff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=za3vJQkon3u0YJSlD1EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200090
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 21:26, Alex Bennée wrote:
> Running a full thorough test suite on a KVM-only build fails due to
> acpi bits needing icount, therefor tcg. Declare the restriction so the

                             therefore?

> test harness can skip it.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Message-ID: <20260930164649.433573-2-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - add comment
> ---
>   tests/functional/x86_64/test_acpi_bits.py | 3 +++
>   1 file changed, 3 insertions(+) 

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

