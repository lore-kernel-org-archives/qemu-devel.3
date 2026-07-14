Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68202C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaem-0003xD-O5; Tue, 14 Jul 2026 06:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjaek-0003wH-Kv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:46:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjaej-0002mf-4M
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:46:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6gW7t482925; Tue, 14 Jul 2026 10:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TQW11l
 Kc0xnoG+RxEEsvwudP14icsBtpR5GFqmkYXJg=; b=gTX51MFxtq7gr1xcDYTQbo
 0yhjGdxtuYdRQasjFmRp9tsQbvNY5LeWmc7+7SCe2ds/1DQeKpQgS/lvjygUgjCs
 qA32ZF/l5GrXTIQszbq7abQwhlbumcS5Q0eF+txqekopUaHEyPpmiKjy/P+/pOyl
 jxXlfLdJlyqMSOyPbla307Kh5C2vYnYLt2/2sh+fDqy1HbzBvGStPb3d+qQxb5Si
 kTTb1CnAXeGOelEHJsKxt2POa/efddyEnDekbjsJGKzD+whUMte2iJnshzaF7AgM
 5VMyvbvdyRt+jH2U8wnNOVgo560VLs+6iPLsRTvP1AmgWRH27IS9xkKu8k1yRf3w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwn5u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:46:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAYdt3018202;
 Tue, 14 Jul 2026 10:46:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nha9ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:46:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EAkNIX14942526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 10:46:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC4DE20043;
 Tue, 14 Jul 2026 10:46:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 740CA20040;
 Tue, 14 Jul 2026 10:46:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 10:46:23 +0000 (GMT)
Message-ID: <50224f19-0d71-4253-814a-b712e2199301@linux.ibm.com>
Date: Tue, 14 Jul 2026 12:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 83/98] tests/tcg/s390x/console.c: directly implement
 memcpy and memset
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
 <20260710214343.2065491-84-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710214343.2065491-84-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cOgt-k9vITX0vjl2LhMOX35hJDb3pFxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfX+ruB9VFd5/G2
 7GZNxR93gHQcZQTFF2ShzsrER6MA24xMWyQOixBgHKfELlU2Ql1/BEYNTA+gAZEhVMuYDOAgKqH
 6ah22PhBRZFHsm4NbPKK+/of2u+qOHk0HVGye5WlrtYVhabGKHWLWPlLY4sX4UyPBy9mgaOVpKL
 F0o2KBw5MFw4QsmHrYhySk5iEHTpfesMMgdgx6Q2uNkKa5RuLPxy0Jdb1nCstr2+aI2cn5Uab/P
 8A7LWlOgSlE+PzML5AOieriLDlbRZnfgxQAMy/teaIsIB7hRLfHw10xZOyNwaYMkEOV0HE/Qw3d
 Wf8Rv0jFz+h8/xX+g0ymIt++eAd5toCrR28aRmVArBu0v2KoXLNL7XTFmGe7XyH1pb1Ku7jn/Ke
 OWpUHGLQJ/bQ65TMXY8b+1iZwCv60og5uCZMN3R6gSGfxdYizaytf41v0/eKuhWIBD2cSHbbMRl
 +KrFyVKg647kwBjY7ng==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a561383 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=Yb_M4-lU1wa4LK9jRa0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4nSKNouiAzIkYoIgvZe5DWzbHkVmSbsD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExMSBTYWx0ZWRfX5iHmIIyVE5Li
 91OOk158ZC1CSyN/71L9tronjDrQ4RMd2rwrY8Y3s7MiO1MywaqrtcZKKNI5K6TS+dMzqcjjf3J
 lZNsWOEx88TcLYLK1tGN1mJHfAy08ac=
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
> pc-bios/s390-ccw/sclp.c uses memcpy and memset.
> pc-bios/s390-ccw is part of QEMU repository.
> However roms/SLOF is only available if submodules have been
> initialized, which is not not always the case.
> 
> To break this dependency, just copy their definition here, and remove
> include to submodules files.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/s390x/console.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


