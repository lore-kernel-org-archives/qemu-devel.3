Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304CEC5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 06:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wulN8-00007u-Pw; Fri, 14 Aug 2026 02:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wulN7-00004s-8W; Fri, 14 Aug 2026 02:26:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wulN5-0000Fe-Jk; Fri, 14 Aug 2026 02:26:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4VfvN2471464; Fri, 14 Aug 2026 06:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+AUa/Y
 QRkEC2tgKPIyO/837M51AM0vy1HhmtFqaYz44=; b=jm6fMc6XnYr0p9wDT0C70F
 nCwvyt4S5xsjbRGeGhBi8r639XYvPYgpiq9eg4ez/+9oDkM6wErmwtsUQ3RxuvFc
 UkI/p1LPTFdyWP69CRmgFuTmdLld/MRXcebC4NKyJl0wqsNVl6RWb+Vcpy9Kc/i2
 NjP0Uc9DoZKRVGGqA5araLtuIZj9rFgXOXp7R9qWBa/ebmxm121VAZ7nbup7hFw2
 FrwwrXAHrC3qGGH0Td+e7JIDwMWr3fhGDFqleLalweuCMvF3inRQGbOpXTRFHvW/
 Y7heMe25uV5+XWyOS3Qr48z9rlg/0p4x7F+4/V9IK5dT9xD5890GDaBDwJInnYZQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0bfuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 06:26:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E6QMkr028702;
 Fri, 14 Aug 2026 06:26:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqeba1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 06:26:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67E6QLl460096910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 06:26:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C33F358051;
 Fri, 14 Aug 2026 06:26:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8719A5808F;
 Fri, 14 Aug 2026 06:26:17 +0000 (GMT)
Received: from [9.124.210.151] (unknown [9.124.210.151])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 06:26:17 +0000 (GMT)
Message-ID: <48fcfa92-71d1-4e9d-9835-5053ea508df4@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:56:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ppc/spapr: Split VFIO code and refactor EEH
 interface
Content-Language: en-GB
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-6-nnmlinux@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260520095446.64206-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0NSBTYWx0ZWRfX96p+IMjIpYJx
 NhZlVqF3KB+xJukcrwvbJJc7y0n+BP0XXjwB6lEbbw13c/AC8j5RSy2+dDGJ9oSPIp8I7ZlR0HF
 yGW/BYica3FbeJNe4TwRbv64NFvJlatgSNTRI2LydxA6uviuBSJJJ1q583T56wf0pepYTo0sprW
 Bppdn70YKQpAhi7HGoOQrx7R+3DotEBcAl3GbrVeV97yuQojkrolJXi7/EGvL+DJUqLKAAWtbY/
 RUsaUAcKU8JMl+0LIZwX0v7Z1ohLqf6u9EyhbIX+tHnonwNo3ZOw6oA01OVSol5w0Wl51U7seZE
 ekkPGfUSWoZovK0684NhbmSFLMHtWRESob85fihugC4sPBbX6c0Ja771mVBFmpP+/T1Os1yDg5Y
 jaCqlH2kHoIBQc2ySspTAY5aTpMfT3OqcVLk27DLoYILfOLzWzEuqeX6zKVSwqpSO0sHaqTlaht
 kAkS48hjHzJL5jMChGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0NSBTYWx0ZWRfX49ratfowL2Hd
 HOWKCgI4qd9YmKEcELLHZr3/Ugc/QoMOp+fmWhpOq42e2K/WfGUxubNBm5ARzUftkDyu8fGXsKB
 yFfKB3cfbTZxWTPqLLYYfWt5UgHW+FQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7eb50f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=gMOcjgtuyj0auw3X0MIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jRj-782jj-S01-pFUyR1odLhPEYHKasz
X-Proofpoint-ORIG-GUID: pMfFviymNaCztWbaRYQfN5Mj5-Fg9TkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140045
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 20/05/26 3:24 pm, Narayana Murty N wrote:
> Split spapr_pci_vfio.c into two files to separate concerns:
> - spapr_pci_vfio.c: Contains general VFIO routines
> - spapr_pci_vfio_eeh.c: Contains EEH-specific routines

I think it can be just named as spapr_eeh.c for brevity.

