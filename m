Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B5CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Cb-000544-1y; Wed, 30 Sep 2026 17:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xC2CX-00053M-De; Wed, 30 Sep 2026 17:50:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xC2CT-0003Ft-FX; Wed, 30 Sep 2026 17:50:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UI5Xs22437631; Wed, 30 Sep 2026 21:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nvrpS5
 f9qtlTdQRUSZ8OmRHq3PqCnHm8PNmP4fVkZ/g=; b=KbhK0+lmKQ3JvYdAA6gTeB
 H7x451rAmbRE1vMWdKuRGWZBE5qJ9QDYpRObgEMAsJazDTF+vDhcr4Y5ygpn9e7C
 9n+0TTptJmrHS5RYJUaBwJz7sYgkk4T6SbfEG5U9yDZai0uT0p+g+peKR6HDGybI
 wBJ8JGhySjm1tjGp60wH5XaBXJsEqnUskWRx+fO00b/99SBnJj1hRojhJsTFjoc3
 YnIASIC/dbmGlLi4H/RoR/mgKL69leyYQNzR3dAiZr9pa1om9svmix81BGRgl2VA
 l59LF7DcJrgxG/efXiqbXcLFg1mjfmtyvFMi4v1wDJ5KoHGalKzsyKqOOPNA2ZHg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feer0f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 21:50:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ULNkl84150092; Wed, 30 Sep 2026 21:50:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7r2et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 21:50:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ULonGR31261352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 21:50:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B4EC5805C;
 Wed, 30 Sep 2026 21:50:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E55858054;
 Wed, 30 Sep 2026 21:50:48 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 21:50:48 +0000 (GMT)
Message-ID: <c7698784-60ee-48b4-8a44-e1703bd82d43@linux.ibm.com>
Date: Wed, 30 Sep 2026 17:50:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] s390x/pci: Reset a device in error state
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-3-alifm@linux.ibm.com>
 <523a3e09-856c-4adb-8134-9a4dc44e16ba@linux.ibm.com>
 <623e5974-639a-4db4-9d78-cf85932ee398@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <623e5974-639a-4db4-9d78-cf85932ee398@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd843b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=oTXOmIb9yhupPgeh4ZoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4OCBTYWx0ZWRfX3D6WgQArgmfx
 mlMLXs2Nm9dW0pwOpfHPUVVM41Ne049JEeiQp9umYBq/C6PIedJXRNpO1pfU88THPg0flAiHEjN
 rq2WIdIyWr0kDdHOuco4vlTYezkkckg=
X-Proofpoint-ORIG-GUID: FV9nERAqV-5eG3Qh4vyCeKjZf1-7X_mI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4OCBTYWx0ZWRfX/H/8t5NuVTmY
 38z1a9RRaPzqPMWISsitDXBpwmgAsaqg7/jMOpThxXoKjMU6AuScG0qL1MdmSQPwk1K+EJ7RfCb
 R5Usx4sRMDqWD6riQFeT4GRDpY/Q+gnKhThVOaelQE2LMGLAQ0izmVk7JzweMXTRhCgHbap/SC8
 gLk8pCfaGbylnqQRPGIgBTdgBz5YAVieudaUpf+bw0bA6Lt+O8zrd3647SGDFK1mVr86/m9PZ3m
 tA85c+V6ErcQkxTNMrnnm1CwtXK6at59m+sWFND2Rfbhu0igQNlW2divH+0+UT2mfwSgiZ+M6fa
 p2pqgUvwCAtGelHFLnV44uBZcB5iazfSzihuIc/FHBY/zoCCNxM1CtRMwrRCSdfyEUijGRp9kbR
 I9JaH0F2Z+Dqm1iBrgV60CJs10YLlOMfpYE131XuTlH7Q99E9HaAulAbx6+3PUnnWvNscZ16R34
 rs2MBk8OAStwGAqGmXg==
X-Proofpoint-GUID: FV9nERAqV-5eG3Qh4vyCeKjZf1-7X_mI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


>>
>> You mentioned in the last version it's because this happens on the
>> disable path, and there yes we will set the device to ZPCI_FS_DISABLED
>> right after this -- but what about any other case where we drive this
>> reset path (e.g. subsystem reset, reboot, and the ISM-specific extra
>> paths)
>>
>> Note that the non-error cases are ensuring we either leave this function
>> with the device listed as disabled or standby/reserved.
>>
>> Would there be harm in, after performing the reset, doing
>> pbdev->fh &= ~FH_MASK_ENABLE;
>> pbdev->state = ZPCI_FS_DISABLED;
>> for the ZPCI_FS_ERROR case now?
> 
> One reason I didn't change the state was also because per my
> understanding of architecture we need the guest to clear the error
> state. This could be done via a mpcifc instruction (oc=7
> ZPCI_MOD_FC_RESET_ERROR) or through a CLP set pci function enable/

That's an interesting one.  This series doesn't change that path, so it
just resets the error state but we don't actually take any action, so I
guess we just hope the device will now work and just didn't need
recovery on the host or a disable/enable cycle.

> disable cycle. So if we leave the device in disabled state after a reset
> without the guest driving any change, I think it might present a wrong
> view to the guest. I am open to suggestions if you think it would be
> more appropriate to keep the device in disabled state.

I get what you're saying, but the reality is that this reset code as
implemented is going to get driven in a few ways:

1) During the guest-initiated disable, quite likely in response to the
PEC we injected if the device is in ZPCI_FS_ERROR.  Here the guest is
responsible for clearing their error state as you say, but they're
already on the way to doing that when you come through this path.
They're doing the disable now, next step will be the enable.

2) Subsystem reset that is potentially running in parallel with the
guest recovery action (or the guest is not taking recovery action at
all).  Here I don't believe the guest is responsible for clearing the
error state actually -- either the device remains in an error state over
the course of the subsystem reset (the way it used to work, because we
had no way of fixing it) or, if we already did host recovery, we have
reason to believe the device will now work and so it is free to be set
to disabled because the guest will no longer have the prior context to
believe it is responsible for clearing any error state -- it thinks it's
starting 'from the beginning' due to the subsystem reset.  This is
exactly why we disable the device in the reset path for an enabled
device (that isn't in an error state) today, because that is the initial
state the guest expects.

To say it another way, when the subsystem reset occurs it will trigger
the device reset for all devices on the bus (plus a special direct
invocation a bit earlier for ISM devices).  And the expectation after a
subsystem reset is that the devices will be in a state such that the
guest can clp enable them.  This is the case that I am concerned you are
missing with this implementation -- if we hit this path during reboot
(and we cannot assume the guest issued its own CLP disable during the
reboot) then the next thing the guest will try is a CLP enable during
boot, which I think will fail even though you will have already done the
host recovery action.  And I actually think the failure will be not due
to the state == ZPCI_FS_ERROR (because enable ignores that) but actually
because you never disabled the handle -- so the guest will get
CLP_RC_SETPCIFN_FHOP.

AFAICT the only way the guest will be able to clear that up and force
the device to be usable again is to do a disable/enable cycle AFTER the
subsystem reset (or use the mpcifc) to clear the handle.  That doesn't
sound right either.  Yes, this is likely a small window (subsystem reset
at the same time a PEC comes from the host) but I think it highlights
the problem with leaving the device in ZPCI_FS_ERROR / handle enabled.

If you think placing the device into a disabled state straight away
won't cover architecture, we could consider a new state to track when a
device is in error state (ZPCI_FS_ERROR) vs a device that has been reset
and is ready for the guest to clear the error state (ZPCI_FS_RECOVERED
or something)?  The disable path can go straight from
RECOVERED->DISABLED, but then the subsystem_reset path could have logic
that ensures all devices that are ZPCI_FS_RECOVERED get moved to
ZPCI_FS_DISABLED (and their handle masked to disabled) before the guest
starts running again.  Any that are in STANDBY/RESERVED/ERROR stay that
way, and everything else should already be DISABLED.

I'm not sure if that overhead buys us anything though vs short-pathing
right to 'disabled', because I can't think of a case where we reset the
device on a path where the guest isn't either already doing the
error-state-clearing action, is no longer responsible for it, or the
device is being removed from the guest configuration.

Thanks,
Matt


