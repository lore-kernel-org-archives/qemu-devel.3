Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E16E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruIe-00073a-4g; Mon, 16 Feb 2026 03:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vruIa-00073Q-2g
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:49:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vruIX-00018m-QI
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:49:43 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61FDsEA24098074; Mon, 16 Feb 2026 08:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VN6hw+
 Bo6aANVYPVi3cGVGyvWTnFELf49KNNqDVxGyM=; b=NCSDk/5CWNwC6a1iyOPTHE
 2Ti5NDc1OV9/dSNtn3XTzejC0Oas/4bBp2B7S3q9DYJOVygii2FBuokh1AhjgVqj
 Zrf+XAvc+q4dg/7A7YIAHrrTgGocIhYZI0yC9uxXFrnypNzzbZ9eFAspVeC9P05y
 gse+3jERDleAQOS4YD9loISJOuKgRCSAsZzIpDVXDltSBsGBUDi/eGDvQ/DNfVf9
 tJwh0HaQQa4s/X/kWJdSTAKJvwPTw/k1y97UW59j93MfF+wrpxcueQjsOVrOpunR
 TWzmoa1yjSXPpKt7Ima0aCsZhRF9IG50wjGIaKy993F0n8MoF03qCfo2hnGRWcQA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj6e1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 08:49:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8NCEO002862;
 Mon, 16 Feb 2026 08:49:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj4fnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 08:49:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61G8nWNx51642656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Feb 2026 08:49:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC2A520043;
 Mon, 16 Feb 2026 08:49:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB81020040;
 Mon, 16 Feb 2026 08:49:30 +0000 (GMT)
Received: from [9.109.199.210] (unknown [9.109.199.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Feb 2026 08:49:30 +0000 (GMT)
Message-ID: <e7eb830a-4bcc-4a27-a349-56d45e38eac9@linux.ibm.com>
Date: Mon, 16 Feb 2026 14:19:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, peterx@redhat.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260204172332.21367-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HsqBkC8jMMIIG0PJ7ETlzoHWzOSL7-d4
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992da21 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=3uas-pzL17UqV6fx6mkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3MiBTYWx0ZWRfX4IKvc2FbTx1Z
 r7RpdtaJwRr6R4DEIwx6HwJaziJScDORA4rf3y6cRu5pfg67yih2tZ//Ck1aKj0R34FzFPwjhMX
 h8Sm8PR6GzH9BnrHp8rWwZrCm80JrWZtFgyvWI9X0l//23Zze7Oz6IRCgmD2d2feV3l6JeUwmHQ
 FJ749XQ9fiKyFLG4t1yxU1UO+7h3r3Q/55t/+ArVezz3TtOASdDVQ1dsVz9gKRICZXj3UKMxLS9
 7hnunB2LwhVvhaKjvrFaly2hpH6ajxxr3+rM+R9FZUFHnJPeR8DBSrfctvOOcjoMH4xBQRnWDz5
 ecEJSvVAAV5gRQRqsihf8SJrmYXYMduFiXi3SRnWoV9soPHygjfIoqX8COS187+CazLhGzI0Jdd
 0kig+x53Gvs0JhEtIwwkptIHvjhl0AQx01zfu0gi1qGIGSnbKhsRvpuz5dyCNIQox6BJ+C3kNVm
 6fdUX4AOrirK0VKwfzw==
X-Proofpoint-GUID: sXimLXyok9KLii1xAQsWZ0LHiWfRlitj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 04/02/26 22:53, Fabiano Rosas wrote:
> Don't implement a custom migration routine at PpcMigrationTest and
> instead reuse the generic one from MigrationTest.
>
> This removes the dependency of PpcMigrationTest from
> PseriesMachine. Having one test import another causes unittest code to
> instantiate the imported test, resulting in the setup and teardown
> methods being invoked for the imported test class, even if no test
> from that class will be executed.
>
> If run in parallel, the extra setup/teardown methods that result from
> importing can race with the ones from the actual test being executed
> and cause the following error:
>
> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> shutil.rmtree(self.workdir)
> ...
> FileNotFoundError: [Errno 2] No such file or directory:
> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
>
> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>


Tested-by: Aditya Gupta <adityag@linux.ibm.com>

Thank you for fixing the issue Fabiano. Now I don't see any issues 
running the tests in parallel.
- Aditya G



