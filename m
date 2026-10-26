Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77A606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PxRd4i4M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHoy-00058I-FR; Mon, 26 Oct 2026 06:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xLHop-00057E-QN; Mon, 26 Oct 2026 06:20:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xLHol-0002Dq-UZ; Mon, 26 Oct 2026 06:20:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q2icNl1991022; Mon, 26 Oct 2026 10:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UeGzPK
 LxDdhOQn8niTkuoSrs3QSxWkclNHZxW20pb5A=; b=PxRd4i4M4b6mWdvsLJogJu
 JhGoBEv+bKwQ2nS3OI/SCCgre6Oq6gd6b0HjLYZdlACYttFsa49/tVcN9XQxL3xX
 NbmRJvd0/jxJjm3ete8ts1JGpj0UZVEXYgmADQw4oz1n8RSzc+doBiawPKuS0GiQ
 O0L9srL74/4TAT0xACwE5347ZrH99MIROKqECVy9XMZxQ4I5ggugkqikRizhq9k0
 zLQv0G2j1T3pRadqpU74YoEW2cv8XJSOC24c9OInxCJ9ieqmU/6ykXYm2mvPnIKl
 /nwnm0rAgHvcTVxxYUqH7EwSEncuuBeve+OXpA5BGXmlK4I0ZfAjBpUd7wBiy9lA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6s8j1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 10:20:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q7Ilwr1866617; Mon, 26 Oct 2026 10:20:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvddqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 10:20:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QAJuXE46268792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 10:19:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BE2E20079;
 Mon, 26 Oct 2026 10:19:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAFFB20078;
 Mon, 26 Oct 2026 10:19:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.153.24])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 10:19:54 +0000 (GMT)
Message-ID: <5b8057e1-7b45-40d6-b4ec-17178432c220@linux.ibm.com>
Date: Mon, 26 Oct 2026 11:19:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] tests/functional: teach tuxrun about launching
 gdb tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
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
 <20261019192704.3220373-13-alex.bennee@linaro.org>
 <41147e0a-c8a2-4060-903e-695e3977c8cd@linux.ibm.com>
 <87h5iezskx.fsf@draig.linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <87h5iezskx.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf2951 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=ZgqDKXDW9tkgL_YUEYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX+++t5kuZCeno
 JIhkCfpGm35CLzHBzI6LSmCRMtVs0y4LzPA60ZJnvhr/BjkmaftlLu/CdbNBHtHq6+/QkwjsAie
 82i5HXyE1AF6fd4NZAXPITT6bDJZHPXRjn/trctUNYaCy9Y+O8NlF0/Cai+bYZNpk+h8+9+gWaw
 lFZYckV8kzv6nwNbweOikEtzxxeXTKSfxY/bBrX5he8H+HTI8+Taui7CeC6mk64l0xX26bRBkWC
 VR0N8H3upzs+nYyZ5GRMvArD2a502eFwIJCBsl+8TBDZd8afrtXSwJdgCKaU4LOAIxSCsND4DF0
 5Ycn31VonPm/lmnJiCL1AGR8haR5hoCHV82nUt53MprN0kj3AN447JMET7XCCjDHd6V+HTtDsum
 SWBdf3oI5pP5zpxdrQeYbzhmz8VTsx8EyDcjso4fIi9dsKAIs/pHs/FrKu8w0ayhVyrwd4YUIrf
 QuNu3fSINDyGelQjJCQ==
X-Proofpoint-GUID: 5YLaX7kGiWRZWc8vx9Yc-si7W36qKMxA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX8R0fqu5dGUKa
 00FWXmQSLBoTcBhimubYcvoJSVpFfEzoRRfQgTflCK5ASWoiZl/LWyvFUkQP8rtDoH9JC/pXpGr
 0hepax5oj0X+Z/r1UXJWWtVyniZU0Pg=
X-Proofpoint-ORIG-GUID: 5YLaX7kGiWRZWc8vx9Yc-si7W36qKMxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040
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



On 10/21/26 22:50, Alex Bennée wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
> 
>> On 10/19/26 21:26, Alex Bennée wrote:
>>> This resurrects the hand run test script from d84842be6c5 (tests:
>>> remove test-gdbstub.py) and modernises it to use the shared test
>>> infrastructure for run-test.
>>> We then tweak the common tuxrun code to over an alternative "launch
>>> via gdbstub" helper which reuses the existing code but:
>>>     - needs a vmlinux with symbols
>>>     - drops kaslr because it doesn't play nice with symbols
>>>     - extend qargs with stuff normally added by vm.launch
>>>     - passes kargs directly
>>>     - runs with the gdb run-test script
>>>     - log the run-test output to the console log
>>>     - makes --binary not mandatory
>>> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>> v3
>>>     - mention the nokaslr in the commit message
>>>     - add a comment about it to the shared kernel args
>>>     - drop unused failcount
>>>     - remove stale comment about hbreak
>>>     - always delete the watch point pass or fail
>>>     - fix unbalanced tuple in sh4's direct call of fetch_tuxrun_assets
>>>     - simplify the symbol to watchpoint logic
>>>     - drop the mandatory --binary
>>>     - make the command copy and paste friendly
>>> v2
>>>     - add self.vm._machine to qargs
>>>     - drop leading spaces in print () calls
>>>     - add register read tests
>>>     - use gdb.Breakpoint for hwbreak as for swbreak
>>>     - drop flaky symbol evaluation, verify hit_count instead
>>>     - explicit gdb.BP_BREAKPOINT for CatchBreakpoint
>>> ---
>>>    .../functional/gdb-scripts/kernel_gdb_test.py | 162 ++++++++++++++++++
>>>    tests/functional/qemu_test/tuxruntest.py      |  97 ++++++++++-
>>>    tests/functional/sh4/test_tuxrun.py           |   4 +-
>>>    tests/guest-debug/run-test.py                 |  14 +-
>>>    4 files changed, 261 insertions(+), 16 deletions(-)
>>>    create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py
>>
>> [...]
>>
>>> @@ -132,10 +144,77 @@ def common_tuxrun(self,
>>>            special with the command line we can process most things using
>>>            the tag metadata.
>>>            """
>>> -        (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
>>> -                                                       dtb_asset)
>>> +        (kernel, disk, dtb, _) = self.fetch_tuxrun_assets(kernel_asset,
>>> +                                                          rootfs_asset,
>>> +                                                          dtb_asset)
>>>              self.prepare_run(accel, kernel, disk, drive, dtb,
>>> console_index)
>>>            self.vm.launch()
>>>            self.run_tuxtest_tests(haltmsg)
>>>            os.remove(disk)
>>> +
>>> +    def common_tuxrun_gdb(self,
>>> +                          kernel_asset,
>>> +                          vmlinux_asset,
>>> +                          rootfs_asset,
>>> +                          accel=None,
>>> +                          dtb_asset=None,
>>> +                          drive="virtio-blk-device",
>>> +                          haltmsg="reboot: System halted",
>>> +                          console_index=0):
>>> +        """
>>> +        Common path for LKFT tests under gdb. Unlike the common_tuxrun
>>> +        function we need to launch with the gdb test script and deal
>>> +        with munging the arguments for that especially.
>>> +        """
>>> +        (kernel, disk, dtb, vmlinux) = self.fetch_tuxrun_assets(kernel_asset,
>>> +                                                                rootfs_asset,
>>> +                                                                dtb_asset,
>>> +                                                                vmlinux_asset)
>>> +
>>> +        gdb_path = os.getenv("QEMU_TEST_GDB")
>>
>> By the way, there is a minor usability issue: if I set QEMU_TEST_GDB to
>> a non-existent binary, the test hangs instead of exiting with an error
>> message.
> 
> I can add a guard - but in normal invocation meson should take care only
> to pass the env variable if configure detects gdb.

I haven't debugged this, but I wonder if it would rather be possible to
structure the code in a way that does not lead to a hang on GDB failure.
I suspect that GDB crashes or GDB script errors may also lead to hangs.


