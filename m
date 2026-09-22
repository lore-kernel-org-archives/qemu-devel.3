Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79955C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x92AT-0001T4-1N; Tue, 22 Sep 2026 11:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur2@ibm.com>)
 id 1x92AL-0001Sb-SE; Tue, 22 Sep 2026 11:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur2@ibm.com>)
 id 1x92AI-00010d-AN; Tue, 22 Sep 2026 11:12:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5mFI3071798; Tue, 22 Sep 2026 15:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dTEK+W
 cvPHJJcUosEnh7j7hIb34kRKBZFOI5sYwSAcA=; b=OSZA4j0QHW5c1845NyScSe
 OIYXpofYLr35DNaOstnqb0Scgn8rV/lSh8zay3dODOQQiHSDJzpkYtgjZQLKtjCT
 XKvHIgaDGmFekFhKLepM9bsttmpiAo9BsGfMqUbEz8cuyB4RLjXcGAd259quChuU
 7sre2csrXinwd0gg6ATFzWPeW6pG1KHzpA1wcsNmsZLSLeqKjGEpw8i8og0bizCq
 Tlh5RPqyVrq5zktyAcOx0VY6a1uqGTEDf9Uso/EslwzOOMfj5CywsXM5AF+g4yss
 peWuYqmKLeM8kXq67lLRj/CNFd9uXC2KRrJ9cRlb2uTJm3BDe+If7z5NkzciZdLw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1pg96-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:12:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElVLQ3046781; Tue, 22 Sep 2026 15:12:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqaf19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:12:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MFC5p631261236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 15:12:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C92F58060;
 Tue, 22 Sep 2026 15:12:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD7758056;
 Tue, 22 Sep 2026 15:11:59 +0000 (GMT)
Received: from [9.61.247.147] (unknown [9.61.247.147])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2026 15:11:59 +0000 (GMT)
Message-ID: <4f345c4b-bdd2-4605-a571-78d57c9d9509@ibm.com>
Date: Tue, 22 Sep 2026 20:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mac99: Boot OpenBSD/macppc
From: Anushree Mathur <anushree.mathur2@ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20260903115229.95811-1-kirill@korins.ky>
 <7deeb331-9027-46bf-ae9d-088f048243e7@ibm.com>
Content-Language: en-US
In-Reply-To: <7deeb331-9027-46bf-ae9d-088f048243e7@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OegN5P0NzrZnMZvGj27yAJQZCRbQH8d9
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab29ac6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=DuDDZcE7xSdUjtGOBSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX9pFm11TQ2U9Z
 eZLk1f18vp7Wtz3yBO01j9hUJ7MhzfJ7nTJlHw6hahZUncRE+J/8IWU2jhEcL3GrgMzthZ/ZdN3
 ZxEf6qvFqlVa3b6MYa1zdssc4rk7QN0=
X-Proofpoint-GUID: jJP4yfMFNYc-n1IRpYzJSenlVs-rODqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX92kZllXRwTZp
 y+kPf+iRCh0i3enLGbWa6R1GCXPP7Wmn5fgmbcb22D1J+sWkn3vy3Ha5OxmFxnQm2m9/lKz8bZ0
 zGMQ7p3qNVZM0ba4KhApRz2jEIjywCmhNstRt2QSwtAz0sHAIqTFxePcZSFgEX/YuFtUjgyUBcU
 EqnXDWsfRhBTc7wSnOYPv36/NrG6XhKqXwC6SvQw07xfB+FLb5r8ikWLrxp7yC/7QGa0ZJmCoQg
 wyaCuAR3MC5mbKIbI6og8nIPz2+nJsydXxU1epGtKuM1SYTbC+EoEuoA2+zczJLcDKudnovBa0o
 KZ7UU6SuxCvgI27wbgils27AJk3ou8Xm852tUQtdJtWif6m9Dx/KxlY9yhEMOR/LtAV8+hSz1+K
 mtmlRByRTC2iFr44JVduztCeDsVV4XGVMSmLEt/2vtZAl+j+PMQJmrOvi9s3E89OrK+VpYHeejf
 rJapLd1y7/yXJUZlUZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220220
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur2@ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 22/09/26 6:56 PM, Anushree Mathur wrote:
>
> On 03/09/26 5:20 PM, Kirill A. Korinsky wrote:
>> Greetings,
>>
>> OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
>> reassert an interrupt still masked by CTPR; the edge triggered
>> decrementer does not raise on zero; successful CUDA ADB replies omit the
>> original command; and the fixed CUDA shift register delay can stretch
>> packet delivery past the guest timeout on hosts with coarse timers.
>>
>> This series corrects these four behaviours and adds a functional test
>> which boots the official OpenBSD 7.9 macppc CD to the installer prompt.
>>
>> P.S. this is second third to send the same patch because previous one
>> had missed maintainers.
>>
>>
> Hi Kirill,
>
> Thanks for working on this patch series. I applied this patch set and 
> ran verification tests on a Power (ppc64le) host; everything worked as 
> expected.
>
> Here is the detailed test summary:
>
> 1. Functional Test:
>    Command:
>    QEMU_TEST_QEMU_BINARY=./qemu-system-ppc64 ./run pyvenv/bin/python3 
> ../tests/functional/ppc/test_openbsd.py
>
>    Result:
>    TAP version 13
>    ok 1 test_openbsd.OpenBSDMac99.test_openbsd_79_installer
>    1..1
>
> 2. Manual OpenBSD Boot (TCG):
>    Booted OpenBSD 7.9 RAMDISK image (cd79.iso) on mac99 with 
> qemu-system-ppc64.
>    Verified that OpenPIC, CPU decrementer calibration, and CUDA/ADB 
> keyboard
>    probing attached cleanly and reached the installer prompt:
>
>    "Bochs VGA" rev 0x02 at pci0 dev 13 function 0 not configured
>    softraid0 at root
>    scsibus1 at softraid0: 256 targets
>    bootpath: 
> /pci@f2000000/mac-io@c/ata-3@21000/cdrom@0:/7.9/macppc/bsd.rd
>    root on rd0a swap on rd0b dump on rd0b
>    WARNING: CHECK AND RESET THE DATE!
>    erase ^?, werase ^W, kill ^U, intr ^C, status ^T
>
>    Welcome to the OpenBSD/macppc 7.9 installation program.
>    (I)nstall, (U)pgrade, (A)utoinstall or (S)hell?
>
> 3. Patch 2/5 (Decrementer Zero Write) A/B Check:
>    - Positive check: Kernel boots through clock calibration into idle 
> loops cleanly.
>    - Negative check: Reverting the patch 2 change caused the guest to 
> reliably stall
>      during early boot right after CPU probe. Re-applying resolved the 
> hang immediately.
>
> 4. Concurrency & Non-Regression:
>    - Verified OpenBSD mac99 boot with both single-threaded 
> (thread=single) and
>      multi-threaded TCG.
>    - Verified KVM/TCG guest bringup (pseries) on the ppc64le host with 
> different thread
>      configurations without any regressions.
>
Missed to add the space between Tested-by and name so resending tag in 
correct format for b4 tool to pick it

Please feel free to add:
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Please feel free to add:
> Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>
>
> Thanks,
> Anushree Mathur

