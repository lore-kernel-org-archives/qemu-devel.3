Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EBC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wybL4-00069T-FC; Mon, 24 Aug 2026 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wybL2-00068w-Hf; Mon, 24 Aug 2026 16:32:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wybL0-00025b-Mr; Mon, 24 Aug 2026 16:32:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVtBS2904887; Mon, 24 Aug 2026 20:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lwBhCI
 9QwPUf6FOSfQx7er/f1CCF82vIBT8GEo8YkVs=; b=chVJSGPVm7zODxT8SdEXg2
 QWn/6i+53hRQRkqsAGmaOwupdON/ht7sHeICah4ew8Fpq+wMJM8sq1AaedgsPhXV
 5W2kHEFDITNWuSA2HixjNz37vbJL8VRrv1aI7NS9L4Xk4+y9sZD/kK7Vby347bgU
 rh0E6eAPNRjGce2UO1fy4EUi7YIGjewZeMkTWpRlNEpH1mFeqnyk5DcUM6ojGJTY
 U2poOIOyVQQO02LotEa6OWdcIWJCA6Loz6qXudvCy1MVhTiKseUXcFsNvAZ3GpYw
 fZipz+ZqdITl6GDphwujNTh7ZiwkE5Nzmm4iolu6guXKEpzORlBnLc9L5ESVNDzw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx3ujy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:31:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKQOQY025223;
 Mon, 24 Aug 2026 20:31:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0k0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:31:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OKVuj362521692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 20:31:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9280758066;
 Mon, 24 Aug 2026 20:31:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A98158064;
 Mon, 24 Aug 2026 20:31:54 +0000 (GMT)
Received: from [9.61.242.67] (unknown [9.61.242.67])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 20:31:54 +0000 (GMT)
Message-ID: <e5951a59-6d63-4086-b2a3-8eb2d9381dbc@linux.ibm.com>
Date: Tue, 25 Aug 2026 02:01:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest after
 migration
To: Gautam Menghani <gautam@linux.ibm.com>, milesg@linux.ibm.com, clg@kaod.org,
 harshpb@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, anushree.mathur@linux.ibm.com
References: <20260824070353.40016-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260824070353.40016-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfXzKz21CBeJU0F
 o3U2aW0M/Zj8YQGKuMTZPOQZhFYsgKXkeCiP6e4BBB81wl+UPg/IP71Se7CJ5Y69m/HQnrffXyQ
 F+VlxTHicuKXyXmGDygioxHQWgsXS4Q=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8caa3e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=NIZVsFSOM9wEDLQ2xvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Z5OuP0oCZ7Higp38yTRYeg66sQFA0ZmS
X-Proofpoint-GUID: Z5OuP0oCZ7Higp38yTRYeg66sQFA0ZmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfXykHxy6X8cwXN
 7KI5toXM2le4CLuobfyntDICW4BBv+wLAb+o4wGd8bSDDS5Ou3/AqG+iWExmyIUckVp6feL6DiC
 Q6WYnRgDacCJjY4DPJzOS7BqfJii05QnoudKgHuYaXnEgTpWkWbWSZOdSgpbTJB2hwgk2c7yhaR
 92WgYvqcslCvvv3zfIBqa0EBe3HkgpNqaZQwSVB0B1RyMS0yEitAaORdU+iyZWuRrq26R/XhM35
 CTGWlueU1Jp5ePaWyj9IUywpkSLRw4nlkNsQaYjTFuB4KQQt6xK+69TfIoYHHf1ATR8D9fJkmNc
 bMGAYSfHEUnepF8pxT+vfM6UCgEGv4lKWDuxR83FHMtCoxLiCgXjiSktPnrdZKQTi5Ib98tXxHr
 LNjYEyU3AV7aR6TAvSfKLMaSZtfZK5xS4pYRQQpIbEdZILZG/WnQAoA5zMDnaIwTG7epkociFDu
 G2s5Y1GdzH8FnmaiBAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 24/08/26 12:33 PM, Gautam Menghani wrote:
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
>    00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>    00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
>    00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
>    00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
>    00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>    00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>    00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
>    00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]
>
> Fix this by calling xive_tctx_pipr_set() in
> vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
> present the interrupt.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   hw/intc/xive.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f473e6ac77..712498d4af 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
>               error_report_err(local_err);
>               return ret;
>           }
> +    } else {
> +        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
> +        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
>       }
>   
>       return 0;
Hi Gautam,
I have tested this patch and it has been fixing the issue which I 
reported. Here is my analysis:

a) Without applying the patch :

1) Start the guest and run stress-ng as below for sometime
localhost:~ # stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G
--sched other --timeout 3600000s
stress-ng: info:  [1464] setting to a 41 days, 16 hours, 0 secs run per
stressor
stress-ng: info:  [1464] dispatching hogs: 4 cpu, 2 vm, 2 hdd



2) Start the migration from H1 to H2:

ltc-lp7:~ # virsh migrate --live --domain sles16_anu
qemu+ssh://10.xx.xx.xx/system --verbose --undefinesource --persistent
--auto-converge --postcopy
Migration: [100.00 %]

3) Migration got completed but guest is not getting recovered from
continuous softlockups even while having ample number of vcpus and
amount of memory free on host and guest both -

[ 1336.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 977s!
[htxd_monitor:1337]
[ 1336.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1002s!
[rcu_exp_par_gp_:19]
[ 1346.015839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0
nice=0 stuck for 1090s!
[ 1346.016355][    C0] BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0
nice=0 stuck for 1107s!
[ 1346.016874][    C0] BUG: workqueue lockup - pool cpus=7 node=0 flags=0x0
nice=0 stuck for 1093s!
[ 1356.007835][    C6] watchdog: BUG: soft lockup - CPU#6 stuck for 912s!
[systemd:1353]
[ 1356.008835][    C7] watchdog: BUG: soft lockup - CPU#7 stuck for 998s!
[systemd-journal:570]
[ 1360.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 999s!
[htxd_monitor:1337]
[ 1360.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1024s!
[rcu_exp_par_gp_:19]
[ 1368.933835][    C4] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 1368.933973][    C4] rcu:     4-....: (1129830 ticks this GP)
idle=afc4/1/0x4000000000000002 softirq=3694/428556 fqs=259639
[ 1368.934106][    C4] rcu:              hardirqs   softirqs  csw/system
[ 1368.934188][    C4] rcu:      number:        1     444039 0
[ 1368.934271][    C4] rcu:     cputime:        3          8 1096165   ==>
1110021(ms)
[ 1368.934373][    C4] rcu:     (t=1140022 jiffies g=6177 q=1684 ncpus=8)
[ 1376.224839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0
nice=0 stuck for 1120s!
[ 1376.225307][    C0] BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0
nice=0 stuck for 1138s!
[ 1376.225428][    C0] BUG: workqueue lockup - pool cpus=5 node=0 flags=0x0
nice=0 stuck for 715s!
[ 1376.225548][    C0] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x0
nice=0 stuck for 1027s!
[ 1376.225667][    C0] BUG: workqueue lockup - pool cpus=7 node=0 flags=0x0
nice=0 stuck for 1123s!
[ 1444.006835][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1100s!
[rcu_exp_par_gp_:19]



b) After using the patch applied qemu this issue has been fixed. I tried multiple
migration instances between both the hosts and this issue is not getting seen.
Even I did try this same scenario with threads as 1/2/4/8 and for everything it worked fine.
Thanks for working on the fix.


Please feel free to add my tested-by:

Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>

and please add my reported-by too:

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you,
Anushree Mathur

