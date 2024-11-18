Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6533D591A8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5JF-0006s1-Cv; Mon, 18 Nov 2024 12:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tD5JD-0006rH-AM; Mon, 18 Nov 2024 12:13:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tD5J6-0001jv-Rf; Mon, 18 Nov 2024 12:13:07 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI9mUeO010230;
 Mon, 18 Nov 2024 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lWGH73
 +KUGYE5EQdR/XuPb2W511JrewYkQTN2Ivse0Q=; b=nzIEJqIOhuKLqijuHNiIVm
 AXXGm4p2rSPbxLzhrlQ0ueaId42cK62MNGc7VWniQmyG+QEiPQUInqoreV081R8E
 N9pBxgCTyVitUFJHnDX5reyMWs5ki21f+ARmCYMt2EqfRG1thxJNx3N3HK3SPyNL
 eD7IJqgp8xKggrppShIbsIL/CCzVFo3owmBs3LpPo4nxWrMkbdQbAeaHB3ImEX7S
 1DKMWPdNtLnpAbZdZZv1OcYmIAGu+Ovk6gMLH+mDW5QYNkATHGLsu/gv4W+qDaf6
 tXXahoKoxMACFvzvQ6SqPxYmTR60CpaGAMN+VW9tTjE8y3WkVc3BzN/M85WA5tuQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xjw7ues4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 17:12:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIF1UA4012123;
 Mon, 18 Nov 2024 17:12:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjjwba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 17:12:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AIHCnlT57606458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 17:12:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9712020043;
 Mon, 18 Nov 2024 17:12:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31DFD20040;
 Mon, 18 Nov 2024 17:12:49 +0000 (GMT)
Received: from [9.179.15.234] (unknown [9.179.15.234])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Nov 2024 17:12:49 +0000 (GMT)
Message-ID: <152401ec-84c2-43f6-a349-cdf5589b9a12@linux.ibm.com>
Date: Mon, 18 Nov 2024 18:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Jared Rossi <jrossi@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241115141202.1877294-1-thuth@redhat.com>
 <ee20d61c-88a9-480f-be64-084f737ee976@linux.ibm.com>
 <1d225ce4-a74e-4d55-85b7-6f7015cfb288@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <1d225ce4-a74e-4d55-85b7-6f7015cfb288@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U67QCfN72mLGOHuo-zijg-pHhHYLmQ0p
X-Proofpoint-ORIG-GUID: U67QCfN72mLGOHuo-zijg-pHhHYLmQ0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411180141
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.11.24 um 16:53 schrieb Jared Rossi:
> Loadparm set with boot index works properly and I confirmed the getter/setter are working as well.

So this is a Tested-by: then?
> 
> On 11/18/24 10:29 AM, Jared Rossi wrote:
>> Looks OK to me.
>>
>> Reviewed-by Jared Rossi <jrossi@linux.ibm.com>
>>
>> On 11/15/24 9:12 AM, Thomas Huth wrote:
>>> While adding the new flexible boot order feature on s390x recently,
>>> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
>>> devices. This property is required on s390x to pass the information
>>> to the boot loader about which kernel should be started or whether
>>> the boot menu should be shown. But even more serious: The missing
>>> property is now causing trouble with the corresponding libvirt patches
>>> that assume that the "loadparm" property is either settable for all
>>> bootable devices (when the "boot order" feature is implemented in
>>> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
>>> one "loadparm" at the machine level). To fix this broken situation,
>>> let's implement the "loadparm" property in for the SCSI devices, too.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2:
>>>   - Only add the property when running with the s390x target
>>>     (checked via the arch_type variable during runtime)
>>>   - Check bootindex property before setting the loadparm property
>>>   - Call the sanitize function before setting the property, so we
>>>     can now immediately reject bad properties for the scsi devices,
>>>     too (had to move the sanitize function to the common code in
>>>     qdev-properties-system.c for this)
>>>
>>>   include/hw/qdev-properties-system.h |  3 ++
>>>   hw/core/qdev-properties-system.c    | 26 +++++++++++++++++
>>>   hw/s390x/ipl.c                      | 19 ++++---------
>>>   hw/scsi/scsi-disk.c                 | 43 +++++++++++++++++++++++++++++
>>>   4 files changed, 78 insertions(+), 13 deletions(-)
>>>
>>> [snip...]
> 

