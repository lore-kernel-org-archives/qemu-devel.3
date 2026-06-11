Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A84CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXk0v-00068V-Em; Thu, 11 Jun 2026 14:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wXk0n-00067n-HG; Thu, 11 Jun 2026 14:20:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wXk0l-0002gJ-LN; Thu, 11 Jun 2026 14:20:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCe6om722246; Thu, 11 Jun 2026 18:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6IUnld
 lvbwm9SKC+zVm9a5j0UYy9JpxQQ+uCv9Qifog=; b=WSVGOZChdImkLbJxrOxsl+
 rxK/phcMlX6CAaML5PZUvefV5Roft+adb0cyqH8US/aF+fBUFYvgmsoXW4AzAh4e
 tswnYvjxz8Z6GNGtXqa1R/s+3fStUW4jSp7/HXYmGHS/y+SiwXvuPj64VvzAXHxU
 zPzp1ScPXpsKdR8KH5r6GSnAt1TyFFQ3u3wksEqXt5ae+q6ti+ISogZwi437Glao
 zWAEXX2DI0hiScqjEezhJ1f1kCSQrqjNjC5pboI8bqjCdSfFbH4mqcV8jZGsmn/O
 mUNlK0ylf0KYclhYvgb6ulF93IrAQgWRz1mJe68pqnEjFOGuSAN5pDkfXxxHakZA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ddb74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 18:20:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BIJicB017963;
 Thu, 11 Jun 2026 18:20:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09vdk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 18:20:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65BIK8SZ61014346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2026 18:20:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 924B35803F;
 Thu, 11 Jun 2026 18:20:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B573958055;
 Thu, 11 Jun 2026 18:20:06 +0000 (GMT)
Received: from [9.61.99.146] (unknown [9.61.99.146])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2026 18:20:06 +0000 (GMT)
Message-ID: <4b0b8f0f-1a12-4c7f-a591-3e7ea662a42e@linux.ibm.com>
Date: Thu, 11 Jun 2026 14:20:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 30/32] tests/functional/s390x: Add secure IPL
 functional test
To: Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
 <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
 <daaab4f1-2ddb-4189-b705-2be3907d1e77@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <daaab4f1-2ddb-4189-b705-2be3907d1e77@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MiBTYWx0ZWRfXyJ41rvw4L1sb
 t39viJ0ZIWqxmnGcQrIW7N9AmyyV8sLBCUWUjEEuB+EDfa34fjsYuju/4R7SkUbY9Im/MipnxpR
 BopxGvkl1jdROJijKN1lgEgRJP8bYPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MiBTYWx0ZWRfXwHzRk94ggyFj
 zy3MYI1s9G2mEFNTChKs+16rdoEPKQrhYm/mq97mhWMV9RfoMsX+wFLuVFou2GHEyFtQHFBfDZj
 5EYK+q37BCxASRIjiZGr5fYP/1X6RtYlrmS43brCf33U3kOMrXmfT/b4U+/z4FIsB/Z9eqLNIi0
 j8CCLV4QO/A2nYlM+itM3dvoc8MJgjSxGkx3OfYpXbOIdlyL8XP6BbLM9iuLS5Zhbm1Q6KBnfog
 V0Uuf0xdoyJ8Otx8FV9t5dErbsriZC67NmC4xTDKnAIzNzlv+qfvIYl2UnJx7SXLP3N11bw3IcN
 ycyOiJhD7RYMTT4BkpdsMIKszINXG5hP9rtoBgAW6rEJlxTCP/YrSQQN975USnnk1KBJcMOYjAf
 uLQmrrzIiTrrpk+D37nm2i4auGjJC1Ozgl8IbalPU5WHKGq6vr+fCVhQpFPgme7SCSaOzO5tEpM
 Stn/5WjX+tWxY0FvNDA==
X-Proofpoint-ORIG-GUID: Hm4BvIb4wxctatw36RhR_gQVvQMkLEpK
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2afc5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=BnHzzpFj9uJG--qHjwwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Hm4BvIb4wxctatw36RhR_gQVvQMkLEpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/8/26 7:49 AM, Thomas Huth wrote:
> On 03/06/2026 20.50, Eric Farman wrote:
>> On Tue, 2026-05-05 at 16:19 -0400, Zhuoying Cai wrote:
>>> Add functional test for secure IPL.
> ...
>>> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
>>> new file mode 100755
>>> index 0000000000..0980daace1
>>> --- /dev/null
>>> +++ b/tests/functional/s390x/test_secure_ipl.py
>>> @@ -0,0 +1,148 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# s390x Secure IPL functional test: validates secure-boot verification results
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>
>> A general comment, you'll need some form of docstring for the entire file, and any classes/methods
>> defined later on.
> 
> Yes, please make sure that the "pylint" does not complain about your file 
> (minimum is "pylint --rcfile tests/functional/pylintrc ...", better is 
> without the rc file).
> 
>   Thanks,
>    Thomas
> 

Thank you for the feedback! I’ll add docstrings to all classes and
methods and make sure the file passes pylint checks in the next version.


