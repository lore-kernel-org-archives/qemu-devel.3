Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198E7C5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyjfo-0002dv-3w; Tue, 25 Aug 2026 01:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wyjfl-0002dT-VT; Tue, 25 Aug 2026 01:26:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wyjfk-0003jC-7T; Tue, 25 Aug 2026 01:26:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2VeBc3730138; Tue, 25 Aug 2026 05:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sG/5sQ
 TtY/jslxxD32W1LKnRO8sCq7kWnY2kpZf0ilk=; b=mJdUyeZyuCwKtixzm28ow7
 6N9F/DD/D0wJIdK1QspijHBwsLQGFgIMUC/XBa7psj1YTMidhAViVNdp9XJt1PmC
 Vx2zqzEYsO59t1uY5AAyfOhMVcSOciZYW+MFLD+KPY/tmCe8osmPZnH96Ar+/Zam
 0lZKqDQwb0lTQQWj5OO0pxiB5s2zJRm9V8W0Xc0LyCkbMvOiUtDkawibXNHCJ8c+
 NhNyaaW9tfQyRpodaCAoYdX8plQygXjKql8SkaN+knbHIz+PeC6Kkt9tFnNtqXBw
 /pQ0irzfsvbnJfid76qzzWvemxNorEF9ukRpxxlFNoNgeLIAxsYXC4BBc+tRRFOQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393x4ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 05:25:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P5BWIO025209;
 Tue, 25 Aug 2026 05:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jtbyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 05:25:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P5Ppog48693688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 05:25:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B06420043;
 Tue, 25 Aug 2026 05:25:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CA5B20040;
 Tue, 25 Aug 2026 05:25:49 +0000 (GMT)
Received: from [9.43.98.150] (unknown [9.43.98.150])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 05:25:49 +0000 (GMT)
Message-ID: <a45db1dd-fef3-4ca3-aa07-953cce6193ed@linux.ibm.com>
Date: Tue, 25 Aug 2026 10:55:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest after
 migration
To: Gautam Menghani <gautam@linux.ibm.com>, milesg@linux.ibm.com, clg@kaod.org,
 harshpb@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20260824070353.40016-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260824070353.40016-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yx3rI1SiwV1CbcF7EkB-RXhcNxVqlBSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA0MCBTYWx0ZWRfXzP8cqEKE8OB8
 QsXVfYkB851BO2uXR4m2deY3l+hWRlfyAdAbgSP0/7jxFaRjcT/XZOpMlBQgLFfiMnEdObJ8IlJ
 SybWRVqIzu/snRNwXiGzBghAeYIsDsNMMBuCR+vvBf8ssUNSQT651VhZOWmLrOlRxJVqNJU7Irr
 u7Nz/nK3GkzGaIXDC/0kNenk1Pb7Hu2a+TzBx1G5qQssEfOuNsHPg4LxRLD6HCpZI+jUkG4LKpg
 ORQ5zteZqAI7ykCFpTH8QAP0vdgsyVaIrz+CHdNXu/cU0u3BPLkHSD6DwPbBYHiix3e7RRwKDo9
 cHhdzUD26NZqnYv+MUpQmTQAFNOKb6Sfe0qaTXK+63+SLhL8sVNnor3vArVo+VNvuPGXK58+GOL
 pTqleCHzhhtQR/76vEuhZhE+/DCDtOgbyaHLILpKx6i+Q2V9Pzxc1sg+bjBEkRTOXyZleqKVL4I
 QgmOEUym3QaS//LSd6Q==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8d2764 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QvyuWRs2yhtwxm2qb2oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA0MCBTYWx0ZWRfX0aPO7UlaznVi
 /8yxsDIt9tbga43k0ozlk1SMGVFiR4+xitNAw8nXz75g2Bh1Pbb+1CGaCkvUyQyQZPqhj/iJZrE
 w3/xqpRV9i7TDDz3IqF6qKi3693bCs8=
X-Proofpoint-ORIG-GUID: yx3rI1SiwV1CbcF7EkB-RXhcNxVqlBSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250040
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 24/08/26 12:33, Gautam Menghani wrote:


Hi Gautam,

I was going through the implementation and had a small doubt regarding 
the scope of the fix for the TIMA rings. I can see that we are 
explicitly reading and setting the PIPR for TM_QW1_OS:

> +    } else {
> +        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
> +        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
>       }

I guess vmstate_xive_tctx_post_load is a shared device code, I was 
wondering what happens in the case of the other rings? Should we also 
force a re-evaluation for TM_QW3_HV_PHYS or TM_QW2_HV_POOL to avoid 
similar lockups in those configurations? Or is this issue strictly 
coming only in the OS ring in practical scenarios? Please let me know 
your thoughts on this.

Also, one minor suggestion. Since this logic is going inside the else 
block of if (kvm_irqchip_in_kernel()), I feel it would be better if we 
can add a line in the commit message mentioning that this specifically 
fixes state restoration for environments relying on QEMU's emulated XIVE.

Thanks
~ Nikhil

