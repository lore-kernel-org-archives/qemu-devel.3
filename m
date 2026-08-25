Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F5BC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysMp-00087t-2J; Tue, 25 Aug 2026 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wysMm-00087K-Ix; Tue, 25 Aug 2026 10:43:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wysMk-0007Ry-V9; Tue, 25 Aug 2026 10:43:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEYopl010470; Tue, 25 Aug 2026 14:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=JOMyEm4A8T4pJ5QWwzf7b65G9MXajgnhlLLD4+cVeOc=; b=GUvqfSBQDc+O
 R+Ot9y0fGswJDzg+h4Gl+lHiSdNI9amtp5hJ3xLkGjDGEBffPyuXPtXN1gxicLrQ
 /WjAaWjurXuFzEPYY3wbE6HxnSsE6lSj/+ksC1M8NA3EatgzdYmD5kK/S1NRmqa1
 01IO3SCJTWgK8fEykFVG0Dxc0yFq4sAazakDAXB4UeJUGShnX8OgsKoNYBcr40yk
 nJtdjQWjhtywMgvwHnQTLkA9uEurWaQceDHYXpJImJdGPKDqfkQVli4k6iLICkrb
 ySB25Ql9hOvr9Os4JokZDPoN3a8HlhNkfDm0rz/i7qj/sb+PcBfIjYMK9cXkUmvE
 7Gj9m8ztxg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726egr92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 14:42:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PEfllb015801;
 Tue, 25 Aug 2026 14:42:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragcjrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 14:42:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67PEgs9857737478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 14:42:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B32458053;
 Tue, 25 Aug 2026 14:42:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4DEA58059;
 Tue, 25 Aug 2026 14:42:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 14:42:53 +0000 (GMT)
Message-ID: <7a5a04d4524d64a0768ed57486da20cec62cafc4.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest
 after migration
From: Miles Glenn <milesg@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, clg@kaod.org,
 harshpb@linux.ibm.com, kowal@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Tue, 25 Aug 2026 09:42:53 -0500
In-Reply-To: <20260824070353.40016-1-gautam@linux.ibm.com>
References: <20260824070353.40016-1-gautam@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8da9f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=cJ0tejSf9BN8paWhmWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyMyBTYWx0ZWRfX1ma/E7lzU4OC
 OOU8Q0q1kR0cO2MjCRJy7C/A/UWmTiKmbZYTnZkqAisS0J0Jmoh+Ux1IfCnY4Ie1bGf5VQDt6mX
 1sXDxegnoihGowRRYnbZTAVtqdmIk9U=
X-Proofpoint-GUID: R5J0oXUK_thqXHILZiN_A13Cm7bEeyKO
X-Proofpoint-ORIG-GUID: R5J0oXUK_thqXHILZiN_A13Cm7bEeyKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyMyBTYWx0ZWRfXzgKRSlqQ+6WA
 uZvMkuw2fARcQBcMrRhOO+Te9qX6GIw+yjyb10Hjx9hnvkQK/qlh+htDgbObPbnwZIky3WUe+Fl
 qmMvBRNq/1XxE28UZwzmrA09vNFoLnow26w6G+fUADhthmvW6O8fyAJDAneUGUiO6lUCPFbJnQx
 J6zj3b6bKON/56/Uo1qA6DcLQOyAhFAi4ohmESm+icahLd1qvInmyxMLJkCW62KLojYqox1XZiu
 7HZOGQo53wjxIOPfV0kIMGb9aksE1SSSDhWJqF3hHgBaQgd7MsJyaLVGyoXuLCZKZXnE2he3sii
 tlImkUMhfg/tDrWhrFYde5Cnwu8VJ1GO6HMF6h6E/i/qX+R2W0SkeAwbUCa1/ZinrtpjZbYj+mB
 CzmVNbdPFYePOxtwr3pgKT2edV9ik6KMOWh6ZWMxgC9Cx3+45HkK+3fyT60943Ph5YsjGTd+vMN
 lUaxFo91f9FoolcB3Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mike Kowal, can you please review this?

Thanks,

Glenn

On Mon, 2026-08-24 at 12:33 +0530, Gautam Menghani wrote:
> When a KVM guest is migrated to another LPAR while a stress-ng workload
> is running, lockups are seen when the guest resumes on the destination
> LPAR. This root cause is that if there was a pending interrupt for a cpu
> on the source machine but it was not presented yet when the migration
> started, the interrupt is not retriggered on the destination LPAR. This
> is evident when running 'info pic' on the destination LPAR:
> 
> $ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
> CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
> CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
> CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
> CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
> CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
> CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
> CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
> CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
>   00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>   00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
>   00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
>   00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
>   00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>   00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>   00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
>   00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]
> 
> Fix this by calling xive_tctx_pipr_set() in
> vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
> present the interrupt.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  hw/intc/xive.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f473e6ac77..712498d4af 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
>              error_report_err(local_err);
>              return ret;
>          }
> +    } else {
> +        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
> +        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
>      }
>  
>      return 0;


