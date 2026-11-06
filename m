Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302F606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TnXoyBgP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIdT-0002Cg-NO; Fri, 06 Nov 2026 07:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xPIdL-0002BZ-9Z; Fri, 06 Nov 2026 07:01:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xPIdH-0004sn-Aj; Fri, 06 Nov 2026 07:01:24 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6AiEKM976801; Fri, 6 Nov 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J5b1Dz
 YwiHYXK+V84ImxJiME6K9EoI4MCHl/rhMrzX8=; b=TnXoyBgP1dyiNol8NKiZw9
 13mVRVWWAjbqo92sh+wFJ/BYUlQXGaarNSJPZtBCyBQe6oQRU8XIFAQE0Af0rtEY
 r3KwGWCJQFiD6FpoPeazk42Tjh+nJpVu9vdWkj310rOQyX5OM+Qrd8wAjj2W3W1R
 iWdHWExLtL21op3+hukYAPEfWgt74xehibeanR2qT45nGfIpzVDsJby0VZqDiIh3
 B8jHc33c6s2W/X11HuY687N/dFT+IeX8tClanC1NgCcPb0Z37D+v1Qtd++aJ5+UZ
 d7WyxtEX8xE8qhyQsoBq1q2Kpqa3PN+DJ9qL+lBR75p7FLFoxzLRzZUCTUBzP1AA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbuys2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 12:01:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6AYtXL3221837; Fri, 6 Nov 2026 12:01:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mruhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 12:01:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6C1Iow20382242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 12:01:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A6055805F;
 Fri,  6 Nov 2026 12:01:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C474558060;
 Fri,  6 Nov 2026 12:01:13 +0000 (GMT)
Received: from [9.111.19.137] (unknown [9.111.19.137])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 12:01:13 +0000 (GMT)
Message-ID: <0115c9e6-e8d9-4ff2-97bd-ea0df6edfde8@linux.ibm.com>
Date: Fri, 6 Nov 2026 17:31:12 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/ppc64: add pseries virtio-blk
 hotplug test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>
References: <20261103141938.41147-1-anushree.mathur@linux.ibm.com>
 <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com>
 <23c28380-a70b-4b8a-bef6-78582af02139@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <23c28380-a70b-4b8a-bef6-78582af02139@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: srU32LqOullUXilp_TrRbRjnO2KmUqV4
X-Proofpoint-GUID: K0X2xG2u2Qxlej2o3JUinXrmxRT8qK5o
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedc190 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=s1h1Ss6MHEIMSXVCNxYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX2/RjRvlD0Kau
 zVbkvsCcI2W+OsRp/pPPmOKVEJAu3W+S9psUwly9o5QR5qfCPSj/ELu1G72v8zo+iQkMb+57+t1
 s9GGhqCT922IJhBG8Rf+bVY3RKn9RHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX1FL6oeDh+FkU
 8wOd1HCLgK+kSEmaxgFd3n0btJ06n+dlLxsBmdyECeESBU3eeWH9YMjH3lPWT6awAlPy7ozUZOo
 EkRrMA1r3gHfUCrQTVlPyBEi8lr3siDlMRstVl8h46ABnChVe38YJ1218AXcoEZXVtmSNN7m4xf
 FhnGnaRo2xpg/1/7UyWTFsXgtaYUnlL36Au1rvsqZqA22GUmlQ2+eB0j73yp2PzmMPbty7jVWkh
 cPKD5ugLOiIJuY2lurwEkkAgZ5XuvqIzt3RkBoDaInZgj2OiGPcLe315zqCqTUx96c8XNLQ7pmV
 ZZqXg/5oABuIezi93ZBKveX/5Lt7NLk9lw/EoL+MrwmhLcbB6HV3FtIfT0bRzAyWB1cdmizDAIq
 UL6mk2gQ+FCp74vu4Z+YnfBZUy3rlQr9UpqrSFDSVGNgtLEt9XoCsmUfIqESK2yNm9bLZ4gaZNi
 dTcLYzFpEHUe3PxHIpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/26 18:55, Cédric Le Goater wrote:
> On 11/5/26 12:14, Chinmay Rath wrote:
>>
>> On 11/3/26 19:49, Anushree Mathur wrote:
>>> Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
>>> disk on the pseries machine.  It runs with TCG, and also with KVM if
>>> KVM is enabled.
>>>
>>> On pseries a PCI device added through QMP is only enumerated by the
>>> guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
>>>
>>> runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
>>> the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
>>> image with those two tools added.
>>>
>>> The test boots with a second PHB (phb1) present so that the guest
>>> registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
>>> into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
>>> the QMP DEVICE_DELETED event and /dev/vda to go away.  The root 
>>> drive is
>>> used with snapshot=on so the cached asset is not modified by the guest.
>>>
>>> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>>> ---
>>> Hi all,
>>>
>>> This adds a functional test for virtio-blk hotplug on the pseries
>>> machine, with a TCG and a KVM variant.
>>>
>>> The test boots pseries with a second PCI host bridge (phb1) present at
>>> boot, hot-plugs a virtio-blk-pci device into it over QMP, and waits for
>>> /dev/vda to show up in the guest.  It then unplugs the device and waits
>>> for the DEVICE_DELETED event and for /dev/vda to disappear again.
>>>
>>> On pseries the guest does not enumerate a hot-plugged PCI device by
>>> itself: rtas_errd (ppc64-diag) has to handle the RTAS hotplug event and
>>> run drmgr (powerpc-utils).  The buildroot image the other pseries tests
>>> use has neither, so the test needs a rootfs that includes them.
>>>
>>> I am sending this as an RFC because that rootfs is not available yet.
>>> It is a new file, rootfs-hotplug.ext2, which I proposed for the
>>> qemu-ppc-boot repository next to the existing pseries images:
>>>
>>>    https://github.com/legoater/qemu-ppc-boot/pull/5
>>
>> Hi Cedric,
>>
>> I heard from Anushree that you do not plan to accept PRs in the above 
>> repository going forward.
>>
>> If you're okay with it, I'd like to fork your repository and maintain 
>
> Sure. please do !

Thank you Cedric !

Hi Anushree,
In the context of the above discussion, I have created this repo to use 
: https://github.com/raphael502/qemu-ppc-boot
We can maintain this for future use. You can raise your PR here.

Regards,
Chinmay
>
>> it for future PPC test development and usage.
>> Please let me know if that works for you.
> Thanks,
>
> C.
>
>

