Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82E1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjanT-0000Yd-82; Tue, 14 Jul 2026 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjanS-0000YQ-4Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:55:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjanQ-0003u3-L9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:55:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6fjD5481952; Tue, 14 Jul 2026 10:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hrqlII
 5rsadG7peficm9aeq9F3lmSiKpbkVg2UAJ0QI=; b=GBwc5b/4ZwJLM4goeX0gvn
 zr+yOagLHEOdaldh2l3xvZFUfftBBevfu79nO9eBg6MLrXbShYQnM54l9mV5o3UU
 MIMwja2PkaxyfvqzKLWG351zGCa+El7we1WwdgHXmDWOf3xCXHi2Zn32EdbvNHEW
 dv2PZYtHeXVS89YBqCvl1xLPYiqp0vRgYm3+dYRINYbLDbrbi3C4WJUVhKKAhf3v
 PUBUNLaV94uIU7JulOmsIL0Pjw2W1sBLccKf9/0p6DN9WR+puZvmwMLIGLTfLcW3
 YT8QksXomuXfgm02bzthNEcnYkLBJ04AEPz7j75kBAapV6Vmhv83mc+fO1D1ZyyA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwn6s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:55:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAnl8r000933;
 Tue, 14 Jul 2026 10:55:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhaa48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:55:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EAtNLZ26804844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 10:55:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A455220040;
 Tue, 14 Jul 2026 10:55:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4387F2004B;
 Tue, 14 Jul 2026 10:55:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 10:55:23 +0000 (GMT)
Message-ID: <982adc65-5439-489e-9214-417b6fe64d96@linux.ibm.com>
Date: Tue, 14 Jul 2026 12:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 84/98] tests/tcg/s390x: system tests
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
 <20260710214343.2065491-85-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710214343.2065491-85-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -kOeYF9t_VOOkjEc3f3wt9vJXejbH8Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfXziLn22IzVvVK
 SwFXaINPmyadmR5HgDgbKQoj9lQywXips1ac8Fg5vLYB8a1nV0GS9p9sApTIN6znf9bKjM5WlbS
 cRV3j+ybSfFMt5V64hCjSNiSc/xId9ECCJl5cZBT1/aJbOCeA+xKQUslCG3TRsK3+d9mUPAOwJE
 gWzI4P33VOwusKvFWfkdk1mtNYPvASd/zDO0uSAbR9GAz68yo+nhqIuqI+FzEoKKWwJ0b9o3qGF
 3cg6uPIDww1rPNNl8WNDuK719DsPLbJlMuDMByvH5xgbGr6hIG31YnHJrvbt03zMeGn8dV98G/9
 LcD4YLG6Up+8KngItpfVKJ0o3v/UyGp1lAbbogJE11tN75eMkgIeByEUa4rCaftP3EijKtzgXq/
 wUDQkcLzQOVmgngA/PKQExWfk6LuajQB0oHWJttIp8rPtWGbcgUsVgpsaJTKsg+FTUoxQ6WEIQs
 SH+I3a2ZbuFjeQ3vtHw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a56159f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=Fx7vqVy711-cX3CUekUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 42XqsfOdgNc_f4lCLIfCCf3PB0yB6CSZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfX//0Kxar4EvZ7
 wZhTaS0X7e7KtMgMUltqg5vV92sKLm4k9QLHRpaVOWPGDuUxE7OnXgW45QlMS+c2c2vV6b+T46R
 r3UIUe2xSADuzIiOm+WYC1EZi4aBzkA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140111
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



On 7/10/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target | 57 ----------------
>   tests/tcg/s390x/meson.build             |  2 +
>   tests/tcg/s390x/system/meson.build      | 90 +++++++++++++++++++++++++
>   3 files changed, 92 insertions(+), 57 deletions(-)
>   delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>   create mode 100644 tests/tcg/s390x/system/meson.build

Can we delete pgm-specification.mak now that both linux-user and softmmu
users are gone? With that:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

