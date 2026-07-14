Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235F9C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhvA-0006WF-UC; Tue, 14 Jul 2026 14:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhv0-0006Vx-Ad
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:31:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wjhux-00024d-Q9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:31:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGBr0l1813552; Tue, 14 Jul 2026 18:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6zTDck
 SwGRbkAWQ6lLWggRqH+5Pif+mMxWy3t0KZijc=; b=MOtcEqjvKtxJZDy+4ZZwKC
 ycipGvOqSeo6/+l6iTAeFwsGt+Df7Oo3vEnaauTLA3GvAfX+NzVU0bTLxayyb8vD
 lShk9WOH4csbzN9YFRGi+4NykE1mYwODXrJ6VjED5jMQGP6P3Aq1kdEfPGx/uMCQ
 7JNij9LaaYabHfHrrSfBE7JrHGplFqH5Nu/qnJjMKzPAQMCtYFk+ZDLRu0XkcqLi
 yMdKtE2yHSBLqjJzvy70FFN32/Yw2uSIYq0xtbwNfj1fwpxBf9Jvw1A2x1WFAUFF
 Z4eXwWfIRQ9ydoqn662/S32MkqeBMNUtpOTT26d4g82eUrhW3wb+hQT09jq2ouAg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt7se0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:31:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EIJdwl031144;
 Tue, 14 Jul 2026 18:31:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy3vbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:31:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EIVZIk62849414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 18:31:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEE4A2004B;
 Tue, 14 Jul 2026 18:31:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C12020043;
 Tue, 14 Jul 2026 18:31:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.27.233])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 18:31:35 +0000 (GMT)
Message-ID: <77f987f1-c012-43bd-ad6f-4ce8ddcf4a67@linux.ibm.com>
Date: Tue, 14 Jul 2026 20:31:34 +0200
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
 <6738c88e-235f-4912-84a0-fe3acfe50c06@linux.ibm.com>
 <e29c4eaf-b429-4566-a598-9cc18a8d1cee@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <e29c4eaf-b429-4566-a598-9cc18a8d1cee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ANElcFutSvv8b203KFo82zyFZstUMYNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX6gwWsWyw86Yu
 BRCh2AUAxeYgIZEMo3+4FhdyLjfdGuj2/hOrqqea+78Iz0fv4oUz/GNkvukjPOn3fqZCgNDs0H5
 ZB76+R9Pube6NoSR1A/2/4OC37dx0Tg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX4SkUmaW6yW50
 1S0g/5Kq1ZBEmHg/i9NNIz0inzA7/I7fisLOONrokuHjRhHj1nhPa1KIN3kBpW3SSnLmVMgZDGt
 z6e5jNdNc4T/q8P1YWG5moWpchsyuLXIoUcR/C2HlUY7hTnevNbEs6RAMSW3a7XIO0yxSjzy9Ft
 KC/gN2lzdxYXB/9OocPEdHveqqj0BI87ng1cAES9XOeolUfmAQyyCj3XdOGbYH7GQsyW8hwEe88
 2G/UumXXomNgflWCZXaHwtNBwwr7vq5w5LLhfQ7VSgwPsLmsptFKpwRfL5g3QtMC4WYL+eHRY8s
 X/BxeZTdAF3hSdC/vLTh7rWo1zvQs7oanP0N0sziKkR3p+Fn603RRnvxA+zzmkzqUhzPyifPd1l
 jP0sdj9QmL1WySx1CXJutO1T4S5JMl6b/2FpULCX9mB56NLIKkY4xMwJwcRhkY9sR/7qQSYIFw8
 4p8JDhpxTjpIWOvZ3ng==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a56808b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=OR8dJJI5HuxiOkfRPWUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: j7n2cUmMCbRUmME8Y0PWCt2036j0XxxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
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



On 7/14/26 17:37, Pierrick Bouvier wrote:
> On 7/14/2026 3:47 AM, Ilya Leoshkevich wrote:
>>
>>
>> On 7/10/26 23:43, Pierrick Bouvier wrote:
>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/s390x/float_convd.ref | 988 ++++++++++++++++++++++++++++++++
>>>    tests/tcg/s390x/float_convs.ref | 748 ++++++++++++++++++++++++
>>>    tests/tcg/s390x/float_madds.ref | 768 +++++++++++++++++++++++++
>>>    3 files changed, 2504 insertions(+)
>>>    create mode 100644 tests/tcg/s390x/float_convd.ref
>>>    create mode 100644 tests/tcg/s390x/float_convs.ref
>>>    create mode 100644 tests/tcg/s390x/float_madds.ref
>> Would it be possible to add an explanation to the commit message why
>> this is needed now and wasn't needed before?
> 
> Before the series, we had only some arch that had those files. I have no
> clue why to be very honest, out of "people forgot to add them".
> 
> Makefiles were "smart" and skipped the output compare when such files
> were not available. This results in arch being very inconsistent with
> some providing all files, some providing no files, and some providing
> some files. There was even one case of a misnamed file that result in a
> skipped check.
> 
> For consistency, the current series adds all missing reference files for
> all arch, and make their presence mandatory.
> 
> Does it look like a good reason to you?
> 
> Regards,
> Pierrick

Yes, absolutely. Thank you.


Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

