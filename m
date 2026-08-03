Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89CDC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqqqc-0008PS-6s; Mon, 03 Aug 2026 07:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wqqqU-0008Os-Jj
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:28:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wqqqT-0000VK-14
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:28:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672Llogm291101; Mon, 3 Aug 2026 11:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PvIo3U
 dH2lDW4G0Snvo9ET9T6hZlXw9C/6GHalyVMS8=; b=SFXxRv3Wf0HVnRuFvbWQ16
 d1SsRY4REiY1/GdCDm21f4wQickhREgrZkor54XQxoeVm0DoEFNgQ2EuuUbN5Hqe
 PAwZVhDXo7nZ9GiZeJTaYLxBZeGMMqSWdwjQPrwAFJMTVEYhjAVvyZzxWNFwFC7R
 jFiklpaz0X/PYH/m2URI3UbPOowpS+6p6MGkl/MjQCw8i0FsgJYICsimD1pjhLDZ
 0Gjw3JLG2JFSqnUkO+e9T1IEOfixS0aizCMx1e/dbp5GkNYrhrQVpZmL0uK40MBb
 ko60mG219b9OOHN+ZBCB9U9X7oE41jvtI0bV0SE6HEL+jYsRP4QXOks5mJHF2szA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eug3ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:28:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQNWo020509;
 Mon, 3 Aug 2026 11:28:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycv4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:28:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BSUnQ30409088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:28:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96B8120049;
 Mon,  3 Aug 2026 11:28:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FB2E2004D;
 Mon,  3 Aug 2026 11:28:30 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:28:30 +0000 (GMT)
Message-ID: <e2c129f4-77ac-483a-909a-ce824b1785a8@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 083/103] tests/tcg/s390x: user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-84-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260728044248.137626-84-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3qD0gp-ueSjsCIgjxyPCq_rQZQsse4zs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX/cov4V8BZMHa
 5uLzqaUxkHER5w4DlrWd38yOgtdBNbh0p4a7Qxs5T1Poqh30JK1H9TUONqR9WKzAC7lP1dACWaq
 y/IZn3iR2HDq7JzCVPFA8tDxh5LtaNM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX2n1KwmMzMaFS
 OC27rlBNYZCKmWhSqzmGb6tG07oxYGTgMaJV1pt2V+n+yCmgcJ0dypxUiMKeJSoQy+MtveS57gX
 /bW49rNoOQJdAnd/AHZffg/2aTrFh5CQDaKd8I2EeH0N7w2FOrxL6knD5K0IxkfI6+bcDvuW6d+
 afo/xD8gyLIMP8WpTGRaR6WZXXucVY0lovpPHr34MikUQFlmM5EyGl19EjG5TpAMZQ2TVKM3m/8
 gotLCaORXnaeWoSJt3grHVGR6SuMZLE42AFoZoZWgNazcBcee6jpAfH6/QR7Pxr3/9mckmu1uX0
 bVlt9HUrK5QhnV9IyXsgPuRTIurUHDrgHIJCl0GqelU4XxWcMGDx5E+6hdBzwgdL2Tc6yqZMbhB
 cyyMg26iCHU5YeA9QYfQzo7e8ucprHhBTi75cVr4J0+W8pOOTvH3Gyvc10asEaPlYxx3yaRG7ZI
 rIjCI1NW5VtR5Yh7ROw==
X-Proofpoint-GUID: A3zo_wGw44MDm2veZAGPU-ePi9XWPr8_
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a707b61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=zq3j2UT3UYmOdI0FYFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/28/26 06:42, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build           |   1 +
>   tests/tcg/s390x/Makefile.target | 127 -----------------------------
>   tests/tcg/s390x/meson.build     | 138 ++++++++++++++++++++++++++++++++
>   3 files changed, 139 insertions(+), 127 deletions(-)
>   delete mode 100644 tests/tcg/s390x/Makefile.target
>   create mode 100644 tests/tcg/s390x/meson.build

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



