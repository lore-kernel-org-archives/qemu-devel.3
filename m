Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C049606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YYtCwb7j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7ur-0007Ir-HE; Tue, 20 Oct 2026 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7uo-0007Fh-Vj; Tue, 20 Oct 2026 07:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7un-0003Cy-4W; Tue, 20 Oct 2026 07:21:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K1E5DP3640696; Tue, 20 Oct 2026 11:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CvmCqN
 6gfp0ltMv3NR0TI9VtE3LUEDjKPVakM7HvCRk=; b=YYtCwb7jmpDJvzLDhsNLcS
 JaD6MolhrTDEo56n1dtBb8H+YBCPK3FTTrqJWBc07Ke805wtLAVk0OXdyEQE0w8L
 I9HSGpZ/BhPh+zPnfuIvqlFjLs8uiDVsETHOubcs11AoeruE0H4i3Ix/DGBgvOKt
 yfO5S5my5cHkwEba8a76B+7B5GqsxsUeBe2GWVmDRcNadWQ65peUl4xRGlnX+Oqm
 k05OVSefB811fuER3gpY6LDErDEJxu5AQf4hGE19OmycDZoMnQpifgFGPKPV1Heg
 qTZkmB14/yMLiRMGvbrbGmED2EWoaLLDmwW8Am+ZJV1DPP/vxbJoGMuRZR9NEgkA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bagkm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:21:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KBLBIm1371188; Tue, 20 Oct 2026 11:21:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs000d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:21:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KBLOV951642800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 11:21:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD69B20043;
 Tue, 20 Oct 2026 11:21:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7A5C20040;
 Tue, 20 Oct 2026 11:21:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 11:21:23 +0000 (GMT)
Message-ID: <91dcf5d8-f319-49d5-820b-fd6c4da8d08e@linux.ibm.com>
Date: Tue, 20 Oct 2026 13:21:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] tests/guest-debug: convert gdb_cmd to an array
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
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mTzydUMgJl6M_JeTD-pSCqoUG796NSxI
X-Proofpoint-ORIG-GUID: mTzydUMgJl6M_JeTD-pSCqoUG796NSxI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX6/VVWFWQaTdT
 tZMGIA8MPapav9Dnq1IN4nee+1qgxaCQTH5W5a3EoEEGkyr1CHCoM+JPmno6a1n7ZhyBR9di8hl
 Kt66YkaP6lyQOcANwt/gf9pztQOp9dQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX8GQcTTigDpS/
 i8I4B+DGfVGlXl1nrxdTfHwdb3Y7xjGaM7LcxZp9AmGAQmT3jCJx4KDRbtRfSWUd2AAytNgf0rq
 ezTI2CzXy26+zKaUY+C00xVglvCoLvcEkNXFUI3UzDzopY2Lt6Kn31WvMWbZCdjCdAg0E1pM9T/
 UureZraU+NbEG/uPKFl7xfz1JL1W+/Zfm+k0Iq17NutGtwxbc8gCrBRwqfCrYPfh4LVx9AiG54T
 ZktG3IlTHWsdIrLyygLspLrKZ7KihxaEAjHqAOSnQyl5QG6kocAUHlTrr1dls/pCPf5zQ+KcBgl
 33uJA7Zc1ewd5CMj5mjrN/GcXQrXQ1yEY07/Ru5IVwo6Zge2Ykjqgy1YyIKDrHUIczBu0g674bJ
 Bf1Q74wEDcEqDJtaq4RHZiJvj2k1lYRngb+jBlA2ST3gC+RR7BM9+HG/37d+cAEU5frgYiKqz90
 wnih0sc8PvxcuuriRiw==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad74eba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=faOvR4p6BUOYKD1us8kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200044
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
> Passing a plain string to subprocess involves making sure the escaping
> is correct so the underlying shell doesn't get confused. This can be
> tricky to track across multiple  processes. To simplify this build the
> command as an array and execute gdb directly without involving the
> shell.
> 
> We add a mini-helper to make the log output a bit more copy and paste
> friendly.
> 
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 838c1c26971..e8b69f85cd1 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -51,6 +51,10 @@ def log(output, msg):
>           print(msg)
>   
>   
> +def format_cmd(cmd):
> +    return " ".join(f'"{arg}"' if ' ' in arg else arg for arg in cmd)

I would use shlex.quote() here.
It doesn't do anything to strings that don't require quoting:

 >>> print(shlex.quote('aaa'))
aaa
 >>> print(shlex.quote('"aaa'))
'"aaa'

With that:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

