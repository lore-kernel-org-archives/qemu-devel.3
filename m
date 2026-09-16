Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FBAC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uxW-0001cA-Dx; Wed, 16 Sep 2026 15:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6uxO-0001bR-9l; Wed, 16 Sep 2026 15:06:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6uxL-0008BU-Hx; Wed, 16 Sep 2026 15:06:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1oYP2330705; Wed, 16 Sep 2026 19:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=15GuLz
 F4AOHB54gtuyhlI8nhRuVlQM8oB875DVwEXzw=; b=qTBg8sIZf8NPKtqQ+KnRFd
 wrTV7V6B8LbQYRTPU9ihvHjpkg+U5RVgJgDbcfdq09tKcgDXQTYhOZffB4ofSR5x
 3UaUyurMGFzy/fhJngAMxCrLoYAGspKCtn15zDdbCs2x25K/vwQUqDuKFE7Fu6Zj
 OgKbKB1ln4U5mwbL0gP3TlhG3GsKhxj7UEq8tuShMFniwKcYWqgnt63kLggbTkt2
 HYYRVdb+0p2KjCB+Xfjn7KHeQB0LQ4VoYjXmiKLNqmCMcPTiO4aVSpU7ZtuZjDQM
 O0Q+yCWwNPfsowJukgzmVGDp9B6+/27bNx4avUNR2NR6Qa0yglKvCgCTP/Tig9PA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqef37-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 19:06:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIvNfV2599781; Wed, 16 Sep 2026 19:06:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d8hbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 19:06:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GJ5HUI65143124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 19:05:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD1C958050;
 Wed, 16 Sep 2026 19:05:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8F9058054;
 Wed, 16 Sep 2026 19:05:58 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 19:05:58 +0000 (GMT)
Message-ID: <3687f02c-a0fb-4801-9b45-e32bc87dd248@linux.ibm.com>
Date: Wed, 16 Sep 2026 15:05:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/16] s390x/pci: implement IOMMU replay
To: Farhan Ali <alifm@linux.ibm.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-2-kshk@linux.ibm.com>
 <2c2bf867-a11a-4591-88bf-bf38d114d364@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <2c2bf867-a11a-4591-88bf-bf38d114d364@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI2MyBTYWx0ZWRfX71GT+ODKdtRY
 H/2BQYlQZCpT9Qd+fDghLCD5B3xCwBhohCGGs+BMEMTO6XxM4OP5U9b6jG7lXc3Kcne9SldZV9G
 WaFiIvzoTyU3uIuB9ydjpoAfY0PAPPv7JnaJhgZkbRCpK3ELcE4R2VbGXCqoOnMdPfUHK6KfdZm
 O8Ul9J9sWgjF/XLvuvKUK5rDnz/MfrGrqnfGA4NCap7HdcXqABXpQYimDcEev3wNMREdrxykamZ
 xRtPf5/OHcshR2aaELWHMwytwkUEbFYq1SpqDtT+fxDoHihQjGlsrTxMYhacdh4MegbhUXpufZ6
 lbjkMUDSKWfTpLoAj6YFLmUDvTGVww0k8vywpw8YremkEpKhD8cZrqR303eTPLXhDDj3jlpnPIw
 WXVSHc9O5pClQfMdE/hPkx2WTLbrr8bjG3w0U4KvuJNo5UYlIlJW1fOpiiWmqKuITrYrJfRb1/K
 aLyFIaRG7uMHLc1cQqQ==
X-Proofpoint-GUID: ZdiK9UTCSyK2kP40qpNB0Na1wzvRm9Ji
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaae89a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=0e9WF9UnTjJJvBxcjfUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZdiK9UTCSyK2kP40qpNB0Na1wzvRm9Ji
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI2MyBTYWx0ZWRfXzAEcbTXesjDd
 e8PCaGxn76GAmVbs26HY4F/0MrIMKlBVgNluUQvFISZuJaVYDjawPjoCMujHZhYOJoXcYf+VrUa
 5oxLQgbMQi0FAkTpYdussX7IhGx3cc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160263
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


>> +                    pbdev->state = ZPCI_FS_ERROR;
>> +                    s390_pci_generate_error_event(ERR_EVENT_PERMERR,
>> pbdev->fh,
>> +                                                  pbdev->fid, 0, 0);
> 
> A permanent error will indicate to the guest that PCI device in
> unusable, in that case would the guest drive a device re-initialization?
> Would it be better to generate a ERR_EVENT_SERVAC to allow the guest to
> attempt recovery and so drive the mappings again?
> 
The problem is that if we hit this scenario, we've exhausted the vfio
DMA limit for the device, so there is no way to create more mappings
without freeing some other ones up.
In the case of a RPCIT, we can ask the guest to try and free up all
stale/invalidated mappings to make room, but in this case
1) we have no mechanism to ask the guest to do that
2) we are in the middle replaying only the valid mappings, so there are
no invalid mappings to flush anyway -- so we're really in a permanent
error case here -- the number of vfio-allowed concurrent DMA mappings is
less than what our IOMMU wishes to replay.  AFAICT this can only get
solved by forcing the guest to throw everything out and start over.

I think in reality, you would only hit this in a migration scenario with
a vfio-pci device (which we don't support with this series) where the
vfio DMA limit is lower on the target than it was on the host.
If you hit this doing IOMMU replay of a vfio-pci device without a
migration involved then the limit should be the same as it was before
replay and it should have been impossible to map more than the vfio DMA
limit (so if you managed it, a permanent error also seems reasonable
because there may be a deeper issue).

Would an 0x3a trigger a total wipe of the IOMMU contents that we were
trying to replay?  If yes, it might be something to consider if/when we
support vfio-pci migration but I'm not sure it makes sense under the
current scenario(s) where we should never hit this path.

Thanks,
Matt

