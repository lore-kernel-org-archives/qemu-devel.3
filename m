Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1444ED3EE84
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 17:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viy1g-0002Bg-Nj; Thu, 22 Jan 2026 11:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1viy1d-0002AH-KM; Thu, 22 Jan 2026 11:59:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1viy1a-0001AU-Rx; Thu, 22 Jan 2026 11:59:17 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCjvJR022334;
 Thu, 22 Jan 2026 16:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XOvCnd
 vv7MSpLbAH47SprnQE85D8c2NuybyM0LZvmew=; b=TMP/zhE8St9xTsGF8cIFd+
 fLuzY24sF3RwjORGeOfcuBu0fq/xJcX+WOLZIXVr7Wf4wY5vh5CnmdZWVcaZfehd
 Jg9RB0fqgVZb52MxTqL5kKlEfVCn8gWzhYwBLuby5XOksZksMtGs2QCbkRUsrmmW
 Xecd4fvo6XGs36pQFiMFwxleLSR3xv/ZiMtDegoyhy8FD+QdvcqkfSooazBOdgGw
 8o0xWq+6jyWoK6nMzG+IyKSa69cDxx+x9ZW5dKrnjbEMrHIHDhnxOs7rnSYIEYf4
 RrguZvJFBdJWQlugrTMO8LY7a8TiZgrWwI0e58fxr4ZNct1EmEG4+klCrNiVY2pQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612durs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 16:59:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEwtNn006427;
 Thu, 22 Jan 2026 16:59:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1u5ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 16:59:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60MGx6Ev30015746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jan 2026 16:59:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8E5F20043;
 Thu, 22 Jan 2026 16:59:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6807020040;
 Thu, 22 Jan 2026 16:59:06 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.153.49])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jan 2026 16:59:06 +0000 (GMT)
Message-ID: <c29ba170-d046-48b1-8cda-f0e4ada4f276@linux.ibm.com>
Date: Thu, 22 Jan 2026 17:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test DIVIDE TO INTEGER
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-4-iii@linux.ibm.com> <87jyx9mwcn.fsf@draig.linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <87jyx9mwcn.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: esgpjrJoR0l_RI_lKx5gZM2MSP2qE5Zb
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=6972575d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ggeJbR9Gv5eI8NL8StYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: esgpjrJoR0l_RI_lKx5gZM2MSP2qE5Zb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOSBTYWx0ZWRfX4JSSbQlwrjbx
 2MBcN8MpexPw8ZmKbzHsMgvgZQNKafafMCi/wXD33DwlOEC8AIRIlHQU0/AhTUE7eLMxP8Vst+D
 SI6iAOuc/Y5KOV4vxAddOV5MJRvL2FKck73nMhn1O+zrtVBWaYCaPJ9w4CrOaGB6rtsI1/04LS4
 dIFbA4J1qTU1q+ywEZ9++EUh2ACBnqp8BUaGGiVnovViB0ZpPcmjC9EmNbzRE5FoRQIYUxxwh1X
 Rlm2eBAQXecemXo/qxs2+VZ1GNaJSlB90CeGuaxi/bWlG9WW957edxJW289PLn7PSfZaJs5deA2
 uVENqR0XsD7OhhlQtjj0BOaCJiuhWkj9hSiFU9C0hVylnx1VMKX4V9xCJrm++rVDg95XTMaRa1k
 8DHocGN9UmDNWHlq5ZW3WCrLh3FM4OS7++BI1MXzaMKHw1vI9MPWiKI4l71Do7vOy6yqmdVIRLH
 LRGtA88TEg2Amsg3a/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 1/22/26 17:43, Alex Bennée wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>
>> Add a test to prevent regressions. Data is generated using a
>> libFuzzer-based fuzzer and hopefully covers all the important corner
>> cases.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   tests/tcg/s390x/Makefile.target     |   3 +
>>   tests/tcg/s390x/divide-to-integer.c | 215 ++++++++++++++++++++++++++++
>>   2 files changed, 218 insertions(+)
>>   create mode 100644 tests/tcg/s390x/divide-to-integer.c
>>
>> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
>> index da5fe71a407..d5ec01d04fd 100644
>> --- a/tests/tcg/s390x/Makefile.target
>> +++ b/tests/tcg/s390x/Makefile.target
>> @@ -49,14 +49,17 @@ TESTS+=cvd
>>   TESTS+=cvb
>>   TESTS+=ts
>>   TESTS+=ex-smc
>> +TESTS+=divide-to-integer
>>   
>>   cdsg: CFLAGS+=-pthread
>>   cdsg: LDFLAGS+=-pthread
>>   
>>   rxsbg: CFLAGS+=-O2
>> +divide-to-integer: CFLAGS+=-O2
> As we generally compile -O0 to make life easier for people debugging
> behaviour via gdbstub could we have an explanation of why -O2 is needed
> here? Is it the same reason as rxsbg?
>
> <snip>

Yes, this is because inlining is mandatory for the mask argument, and 
-O0 does not honor always_inline.


