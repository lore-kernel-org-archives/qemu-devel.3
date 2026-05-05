Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA92FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLpX-0002Ot-9z; Tue, 05 May 2026 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wKLpW-0002Ok-0B
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:53:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wKLpU-0004US-71
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:53:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645AtNjF067384; Tue, 5 May 2026 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rykLm4
 i/yvLcUi8PCmQqFEvPsgCxn0ZOLZDPyHDHXls=; b=YX9Wlmv5LFKzB3RqoBea+7
 FILkSBfMFdxtkp/gpcpKX6F9KTKCJpiir1AsIBDGoZxyuFlludXM5Bymw8N4MZ0L
 kIc3FCj4qnJoPy7YsmlH7sGFA9hmqrzN6tJh2B8op9oafMb/d9yvgYzjVCAvutTQ
 DXHFqshDehR09LcB62TyV7mjvOzF7uFhdZqK6OUczvm3mjA8yj3g3O+4pH1YGtnX
 7AgyVWVoZztqOc+6hhYpXA9fYr4tpejqzgqmO18zimMvMxTkb3Dt+l8IdIINOUuw
 gebE9JGrxzjTyjqtvK6RBdCo3/+WCwQXRteG43vwRSQ5y9UAHuFl6lc72ljachhg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1dh0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 19:53:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JOf8r001935;
 Tue, 5 May 2026 19:53:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yaxuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 19:53:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645JrAFj14877396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 19:53:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E895A58052;
 Tue,  5 May 2026 19:53:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5168C58069;
 Tue,  5 May 2026 19:53:09 +0000 (GMT)
Received: from [9.61.162.242] (unknown [9.61.162.242])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 19:53:09 +0000 (GMT)
Message-ID: <1c2bd3af-6d2d-4f14-9410-2f49052c01bb@linux.ibm.com>
Date: Tue, 5 May 2026 15:53:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/qtest/migration: Fix A-B file build
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20260429231025.30818-1-farosas@suse.de>
 <afobo6vVUd2Pga76@x1.local>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <afobo6vVUd2Pga76@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DKsv-ejt-3ROuyLmRtiuJsjLVjYIgCpd
X-Proofpoint-GUID: DKsv-ejt-3ROuyLmRtiuJsjLVjYIgCpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX15OTYtV+NEvO
 JoOpjNRW4z+D43Mw29UCXMIir3fGYI9fsKkhTA652WEJ1H4RrbIYTcOYutGSWG4LJGNjs4Kncut
 y+dRkgxC/Y9W1R4u+AvvsYohZUkHfpwDwuF3mTa5a0MKYDxEiMU0yMqyCS6iEi9Uo32mPnJpPVK
 4m67PExbG8a8PIdkPxnXC+gMn/sEnnlU0dPIh+2ue/JLeg+WXGo6sxhfkpXCCLMg6nfyz3qC1wO
 FE6kr3LcVJ7WcT1j3glGag+sI5guxS+fLmtQnzqNn70ckqc2kQIPByxFDj9AAv9/4DPYBPTtkJu
 rISasX9KgN5uH59UGMdrk8B2ItK2omerHJ9yrd4HQO/uY1qX+ahUx0FHEiUVEKu5gMRq9gYqLzw
 mU4Od/8p9zGcDRPkNf5jE+b3R0TAw0m6jjO/ovPdFTbn0poQ4gzMdPKrrxzz4sLOxAmGBF4H90Y
 uXtgw0yL7zuj9K+t2Uw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fa4aa8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=0ekQI7rM1xc2eIZ-y9MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050191
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 5/5/26 12:32 PM, Peter Xu wrote:
> On Wed, Apr 29, 2026 at 08:10:25PM -0300, Fabiano Rosas wrote:
>> The generation of the guest workloads for migration-test is all
>> broken:
>>
>> 1) We moved code around and forgot to update the includes from the guest
>> workloads at qtest/migration/<ARCH>/.
>>
>> 2) Since this code doesn't build by default due to the need for cross
>> compilation, we also broke the s390x code entirely by removing the
>> libc implementation from sclp.c.
>>
>> 3) The build adds a blank line at the end of the header files due to
>> how the sed command used to remove extra variable declarations is
>> written.
>>
>> 4) Must be too long since we last built this thing that powerpc
>> compilers would output BE by default. Nowadays we need -mbig-endian to
>> force it.
>>
>> 5) Format of comments needs fixing to please checkpatch.
>>
>> Fix everything. Most changes are trivial, except for s390x where I had
>> to reimplement some of the routines from sclp.c. Compiling that object
>> file in doesn't work because of its various includes that this
>> standalone code can't provide.
>>
>> Testing this change (assuming x86 host):
>> $ cd build
>> $ pushd tests/qtest/migration
>> $ make clean
>> $ make i386
>> $ make CROSS_PREFIX=your-favorite-cross-compiler- s390x
>> $ make CROSS_PREFIX=your-favorite-cross-compiler- aarch64
>> $ make CROSS_PREFIX=your-favorite-cross-compiler- ppc64
>> $ popd
>> $ make -j$(nproc) # must build the tests again
>> $ QTEST_QEMU_BINARY=./qemu-system-<ARCH> migration-test
>>
>> Fixes: 9f4278837d ("pc-bios/s390-ccw: Use the libc from SLOF and remove sclp prints")
>> Fixes: e1803dabdc ("tests/qtest/migration: Move common test code")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Since things are essentially broken, I queued this one directly.  However I
> don't have any knowledge to review the s390 changes, please s390x
> developers do so and if things need change we can do follow ups.

Thanks, this fell off my list.  I did at least test on real s390
hardware and cross compile for i386/aarch64/ppc64 to verify 1) yep,
s390x was broken before this patch and 2) I can test s390x successfully
(as well as cross-compiled i386/aarch64/ppc64 on s390)

I did look at the sclp re-implementation, that code looks sane.

@Jared as a follow-up can you look at the possibility of cleaning it up
so that we can go back to using shared routines for this test?

[...]

> I somehow generated different a-b-bios.h for s390x after cross-make.  But I
> verified both versions of s390x_elf[] work here.
> 
> My gut feeling is it is a compiler difference causing different code
> generated, even if there's no real functional difference.

I also see a difference between the a-b-bios.h generated, and also
verified the s390 test passes either way.  My assumption is the same as
yours.  In my case I was using

gcc (GCC) 15.2.1 20260123 (Red Hat 15.2.1-7)

Thanks,
Matt


