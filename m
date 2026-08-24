Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F6C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wybcV-0000Ry-35; Mon, 24 Aug 2026 16:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wybcT-0000RR-B8; Mon, 24 Aug 2026 16:50:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wybcR-0004mS-E9; Mon, 24 Aug 2026 16:50:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJW8cH2905261; Mon, 24 Aug 2026 20:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=miDbUI
 6wxvi/l40PK2mt7JOLfPsiYdlxgQwwrOOsLlg=; b=V6yhvLjVC0jWYOYHxvgnLW
 SpjmXmVmGGJfPX2EmtUJ0wkRvdPm3RbKYwG0J5a+Xs/YsM3ffZIlX+6NO882/LM3
 c21xg092dQMGpX+bC3+jrqroFYYkbVgiAbHB1V0TYIcfle19jpkneai7WIfXUGJB
 Yz7hIIp61Avj26+K0OVOZSrrh/Fwctfd13eGypY3eUSRomQ8uXxAxM1Gb2/3kz0S
 wOnh/8a0ezF/FO1mubNIavzZhhIiboY6WKu5vWAlcw1nF/6h2RKz4kMoHgqSTwft
 74SgVXfrPOAPaspUPvNMK4ghVSHJ82wPqXuhKHtMTOFBzACqqWjGDIf1cjqz/QXQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx3x7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:50:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKfINq025963;
 Mon, 24 Aug 2026 20:50:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag89j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:50:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OKo4Z225756002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 20:50:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A256058056;
 Mon, 24 Aug 2026 20:50:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D867F5805A;
 Mon, 24 Aug 2026 20:50:03 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 20:50:03 +0000 (GMT)
Message-ID: <a29c2ca3-842c-47b2-9b87-421ffe4d77d5@linux.ibm.com>
Date: Mon, 24 Aug 2026 16:50:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/15] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-4-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-4-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfX2MnNGXqBBS1K
 V69Lt04GqZ7HTUMQrEejKWd1iiboDcEWkg4gHejNeODSK0ZNdG5U/H6PJRcGhKdkYb/HCQ8UN3z
 7iQZMO8HHXUqZJRAm/Lhbh4mOIw/drA=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8cae7f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Va7e2OFEOCfotNsCPYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1MQiJktDeDH3DKHv6UNjmK1UPH2FcE7C
X-Proofpoint-GUID: 1MQiJktDeDH3DKHv6UNjmK1UPH2FcE7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfX7FtZ4COTPOHB
 9xHuTAD5V4xVkP1yIsELU1zva8SAti9OVNJp+Rxubn6XwArMBiI0Ltc9EGyxDuSzqPEjAVzaf69
 Z+cZXv5VGRBQK49tLMOMnvNr24rnmlmcHPJY9TttJD0JMQ2dtQgxwFXf9o2oM8oV1c7lhbNZRHm
 LauMaAQXWyTGOY96gc04DTUjbExqs0tx3bZ5EaWpDzxqls1I+y9Gyfp4h+tp1/sBcPlCVPImvO4
 BDxoYRq2tzRlovZjfg+2tqP8c3EsIemx9OUJpAd8mTgHm59qtO4EYns0MXHrveycaNxKMrwzWS8
 T99yL8F5Pm6ONCLTtfR9ceQdklB2pDJI5rT4R1HSz4cZvTU6esaWJyJgDV2+AKa4isUUU8rpblz
 8EGP3HD9FuJZ/x/Lhnmo/PI4HkurxUeaw1uUohLGB6LLQw1M3DKVXw+2IoL8Wak/FzLc9FSQG5M
 HWWq/B6XDubCVMwIbJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240173
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.

I would argue that this is not the purpose of S390PCIIOMMU until the end
of this series.  Maybe just re-word this to '... to simplify
S390PCIIOMMU towards a structure that contains only the IOMMU container
information needed by the PCI layer for a given slot.'

And propagate the re-wording through patch 12.

> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

I'm not sure if it was on-list or off-list, but I had asked previously
about re-visiting when the IOMMU is created as it relates to the
S390PCIBusDevice vs the PCIDevice; the existing lifecycle seems a bit
odd to me in that the IOMMU is a property of the S390PCIBusDevice but
rather than being created when the S390PCIBusDevice is created or
plugged, it's creation is deferred until a point where the PCIDevice is
plugged and associated with the S390PCIBusDevice.

I wonder if really it should be created earlier e.g. as soon as the
S390PCIBusDevice is created but only wired up (e.g. referenced in
table->iommu[]) once the PCIDevice<->S390PCIBusDevice association is made.

I think your approach here of moving many of the fields out of the
S390PCIIOMMU is kind of working around that lifecycle oddity to ensure
migration behaves as expected rather than addressing it outright.

At this point, I'll accept it since I don't think re-arranging the
fields makes the oddity any worse and it gets us useful new
functionality -- but I would really like you to look into this lifecycle
as a follow-on after this series.

So with that said and the commit message change:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




