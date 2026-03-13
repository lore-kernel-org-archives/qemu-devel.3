Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D428105F78C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10bD-0002LA-H9; Fri, 13 Mar 2026 07:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w10bB-0002Kp-8P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w10b8-00013d-PS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:22:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D6dh862205911; Fri, 13 Mar 2026 11:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gSDtxP
 zRvdjTFAk4GlbKKn+ScGKJnaf8FIGCHZB0JP4=; b=l2Hqrml2Bl5YAThx1DcDqx
 cCf2a0pXMm7Ml559KkrWYLNh5dF78Z6xODxXx3YHl4a6Jw7yZRyeQ0A3EzBkr3yq
 bAambrCYg5nPzCXY2RkKC+B+PnMSWQbPBnUN9xA+Ox325TT1dzIdmRQ5k3hzLNbr
 fPX0DQNJfwjuixs/GDBmhGDkmsTqv3z+5cnqEwT+qUO/qUBgj2ZgLpqKBFxpqRDO
 EGOhCOzT3tGgGTEoXQcJGPHeYG9YWE9ayvuKMiYptf2kxnFZ/n/Mdl0Sv25dR1TX
 iERXrdn4ajYv3PLYUQPxT5zTg8JopKnYe6vgXtEsh9YTN9i5IHnHTxCx8A/+bLKg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98f715-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 11:22:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAL9fV018371;
 Fri, 13 Mar 2026 11:22:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha86e72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 11:22:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DBMOFm56623440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 11:22:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82E4820040;
 Fri, 13 Mar 2026 11:22:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1394920043;
 Fri, 13 Mar 2026 11:22:23 +0000 (GMT)
Received: from [9.124.217.187] (unknown [9.124.217.187])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 11:22:22 +0000 (GMT)
Message-ID: <84652150-2af1-451a-8dc1-11f2718dd253@linux.ibm.com>
Date: Fri, 13 Mar 2026 16:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] PPC PR for 11.0 soft-freeze
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
 <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
 <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
 <abEDACgG6T4N9F0P@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <a2db11f6-9183-442a-952e-faaec9f97313@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <a2db11f6-9183-442a-952e-faaec9f97313@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b3f375 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=YMn2DTr_xqvraGRWJu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SsROQXg_iRuWyeGE_d6Il5a5eoKHCNbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NiBTYWx0ZWRfXwIyAevOUMHIm
 pQZKOG7OeBA6yL6xkfi+Xg11Av/QTGNzd/cm9lk7tc/5G1icWdy/p+OUyCJW52x1eBNax2/5tkB
 lcFUtt1oSRvDXH8PROZ+Wo//cs0evkGR5EqdM0ZuYOZp1ffDLTM01TfAMuNFWeGDShSFZw8DVcy
 FRtnA/2bQBJot7SE94RIoHlF8q0ojRkwS3nNYSxuuh3KbGFo5VluPu9sqroKwvnNLll1ZQri4ZP
 sDtHm0NdlDpETBdKqrmmPYFzny2j9mjhNlQU6Mov+E0n+vkj37zcY3uqIT8Jtj+zIkb7LheVafk
 9Nzj3KN7dDiCJVrF7qrVsAj5ICGVel5jw16QG9uFmss90zRU3Jb4oxibFqYMsaETFhuRmzKi+K1
 y1tZGdLenY+4AqDydjtq4iTrbwV2ku4N5GOArXHJo65xhNVKvRImls+yjR5wKmPt49zESLgCkyi
 KF63+IFiWlD7LnWClAw==
X-Proofpoint-ORIG-GUID: SsROQXg_iRuWyeGE_d6Il5a5eoKHCNbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/03/26 13:23, Thomas Huth wrote:

> On 11/03/2026 07.03, Aditya Gupta wrote:
>> Hello Peter,
>>
>> I run the pipeline everytime before sending, curious about the tests I
>> missed.
>>
>> 1. How can I get the console log of the failed centos test ? Or how to
>> (or if I can) run that test on my system ?
>>
>> I did not find the log in the gitlab test's artifacts.
>> Surprised with the failure on the particular centos distro.
>
> The console log can be found here:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/13431423958/artifacts/browse/build/tests/functional/ppc64/test_fadump.QEMUFadump.test_fadump_powernv/ 
>
>
> See docs/devel/testing/functional.rst for information on how to run 
> functional tests locally.
>
>> 2. Is there a way to enable these tests, or to get access to these
>> tests: aarch64-macos-build & x64-freebsd-14-build
>>
>> I read these are run using cirrus ci, can these be run on our systems,
>> if not on gitlab ?
>
> See .gitlab-ci.d/cirrus/README.rst for information on how to set up 
> the Cirrus-CI for your own cloned repository on gitlab.

Thank you Thomas !

Will read it.


Thanks,

- Aditya G

>
>  HTH,
>   Thomas
>

