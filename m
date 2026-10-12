Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A302CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCEC-0000ix-94; Mon, 12 Oct 2026 05:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xGCEA-0000ij-W5; Mon, 12 Oct 2026 05:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xGCE9-0005BP-7m; Mon, 12 Oct 2026 05:21:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8iIMc2184024; Mon, 12 Oct 2026 09:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3TWDIB
 A4mC7bvPUdJInVuhuzC6B1bRWPOoD7N6/YVM8=; b=I3ZqA0K9M0p5ORMX6fOoI9
 6l5EjAFgn0KPHYME7qQMt39GVjuRbZ0aXP4p3OYloBMgystKKpMpJ4afUVJ/5eER
 lTGEh0ut8O+MUBLmQR0TX8sm7+yBGdvG28wNXrC4HHmrzBW+YLpomg6O9qbp9Jid
 5bjeqTHoBtaqOHayyB3kvIsE8sJok4rWGooU/bbM5tni9gSqPM1DHbeNO+jjzSxJ
 r2N/i3txlNgWpNowRw34H4fSRjcPmfGSQW2ughaR+i3G9EtyBCDt3M/zBQchTJzz
 mAJerxw6g7c2jFvYS3tPMsCUL/SbuGUluBoXD79gdDz4xQPpZ7t5DXaxHEMG2cKQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh83tq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 09:21:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8K2v21014097; Mon, 12 Oct 2026 09:21:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gve5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 09:21:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69C9Lb4G17760716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 09:21:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C59E72004B;
 Mon, 12 Oct 2026 09:21:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A7820040;
 Mon, 12 Oct 2026 09:21:37 +0000 (GMT)
Received: from [9.111.21.86] (unknown [9.111.21.86])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Oct 2026 09:21:37 +0000 (GMT)
Message-ID: <d0b0e42a-dea5-4154-914b-82c33172a065@linux.ibm.com>
Date: Mon, 12 Oct 2026 10:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/tcg: fix register update on guest memory
 fault in cpacf_aes_ecb
To: freude@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, iii@linux.ibm.com,
 richard.henderson@linaro.org, david@kernel.org, cohuck@redhat.com
References: <20261008154455.369004-1-andy0x48@linux.ibm.com>
 <354513f2ac7e565cd22362db4aa5459e@linux.ibm.com>
Content-Language: en-US
From: Andrew Holden <andy0x48@linux.ibm.com>
In-Reply-To: <354513f2ac7e565cd22362db4aa5459e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfX3MujbyumVw/W
 5p9Nrc7KZ7vVSKKIh1yWYXvXTWQ4P+6swSMnhmZJrAYhk8SoYHpy6NWDzm/x4mWhNRX7kESBT2e
 g5JoBKkch883uX2NeVYefkY1aIuCb0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfXwRQoT+RTuqiM
 IYAcCHVnhDwLmVGjmRiPQSGcB9siE6/rHpMBMuzxl6iumelSHOM8t9AA188FAbfaDc74tLo2Aq8
 qA+8OSK3/qfQfr3biQ21ufI0vRVgfVwcENUisAWxJAIBmYdBm093rmzIBahzIMB9Rw92PxSxa/0
 uLQqET+LIZV0ItD7bz6hCo32GPSbtrj9edcgEe7JuitXK1Cs2wGEzCGMHUmKjwZCIinRsRbdib4
 QasrMnmlFj18MfzhuS/+7Av66c+T8DI/NMQLZSVFFUhNn/MNxBXLLEBLHxYpEclvQ0T9LE6MekU
 eLiorMquOp7jlgQG+pVyOz3GmhQ+oxqvaD7yYOAVXoTtnbJl7vdk58qHJJZU+9vzVwyit+/Q4Vl
 UWRX2QbfKfBXOOJ7Ue6ClgXPPQG4HK03INCTowwDmHvFzPkD4NwvrGXWjo8CgLU7f4fWX8KiwUy
 foOFfgRsjKa5RYoq2cA==
X-Proofpoint-GUID: kjsPXDjRhrTBshHn41o6i5GqR8RMn1tu
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acca6a6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=uGJjggsikuYQE1ib5KkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: kjsPXDjRhrTBshHn41o6i5GqR8RMn1tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120036
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 09/10/2026 08:42, Harald Freudenberger wrote:

> Try to hold this bunch of variable declarations as a
> "reverse Christmas tree". I am not sure if this is a strong
> coding guideline for qemu but there are a lot of open source
> projects insisting on this. 
[...]
> A comment here like
>   /* update registers at end of each loop */
> or so would be nice.
Will do both in v2, thanks.

-- 
Le gach dea-ghuí,
Andrew H

IBM, Waterford IE


