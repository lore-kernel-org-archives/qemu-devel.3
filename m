Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A7C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 15:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiZD9-0005uK-Mf; Sat, 11 Jul 2026 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiZD4-0005u3-Rk
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 11:01:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiZCz-0002tY-96
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 11:01:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66BEfwxR1169446; Sat, 11 Jul 2026 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YQL3wy
 sWOxi16ay2mHG00ggz6JJcnIVupd7/2k8UiZo=; b=S3SHHHw8noPenFQ7NETg80
 kXVB9/+L68asPASYwMwnvTE735zQI63WgL4CcgAxZVsnr2v4mMZGvFiutyL8hA0T
 ZGCopvfL3xx4DBG1TIbVvPML9wJkPKi3lAT5yVm+i+2Lba1NPQJOjvq93ILrcFIP
 DxyPPR/OPrK21uxFWyrTB/PW+YPQCCLpBeEAtLbBQAwWOz1YYIoWxu4Q+jqsJYmB
 l/g6jafK2zov879wpHATo/r0mmL6GuReT9PQ/o8GyPU2iUkhmVl1X8rmowBFyInr
 qJJhsU0W+skW4jwh2pG3iW7jeWLCG1aV6s22nf0SCx0lVwucf/JJ9iAY+CBhBT3Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf29sbcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 15:01:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66BEnkmg020575;
 Sat, 11 Jul 2026 15:01:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqpwdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 15:01:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66BF0rXV31523422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Jul 2026 15:00:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 168EA58056;
 Sat, 11 Jul 2026 15:01:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E96EA5803F;
 Sat, 11 Jul 2026 15:01:21 +0000 (GMT)
Received: from [9.124.216.136] (unknown [9.124.216.136])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Jul 2026 15:01:21 +0000 (GMT)
Message-ID: <a75fd34b-2146-471f-89af-90f61cdaa722@linux.ibm.com>
Date: Sat, 11 Jul 2026 20:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what is qemu_system_guest_panicked() for?
Content-Language: en-GB
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfX6izbXNM+u/jc
 xZduL3n4KcjpL3wtRhyCsKK2nqf8oMRMBzofabky7shKEbcgOBiGF+YiBXOoJxTynlOfBHXjZFd
 cd46CKCJgzxgky5JaM32KLLXWRr11qQ=
X-Proofpoint-GUID: eZNJw6n60Zg48Qo9u3r4r25dC62JMvMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfXzTIlH0kSHOEe
 JjMeEom8T7vCje1Z0syNhUcbNiOq+j7G2RPwFnvVhWa1ywMD5l+SxkQybQjT9ctSQz6I/Louy4Q
 U0xkxeDAO9UwkPo36wj5kJw8npzxL2qC4IoTujY6VQJ3w9UfaqyOYuXWlcvfQiGj5TzfaeEpLZ4
 Ss3wtj19Yh6CM5HX0j8lTp6Qqm8IHW2G2d+BtFdcyQRe+HX3PprPCUZJyqm6Nd9nd+QSnncMq1L
 kq8Kd/N5CD9trBXDyUkVExp+/nM3eDQnboRNoeUV2IkqTVmw8oRG/hYnPgncFwnV2pWghxantMu
 dP7XHmyGp2dwYlxRTNBaA/7b/vzQJ+TUV2+61w74kP3ULkku5JYx5f/IhchnezkZACLQ6aCzfUb
 MCffL0ycA4WBtsZjnJqG8fxhr/+ITqbUbls7TMfOBpVZ9P2Sl+wyL/mcGl4o//AmBDRAXAokjX1
 ocrTxK06v+nB9upsYAg==
X-Proofpoint-ORIG-GUID: DgFHqivXhhHmWjrSSHaAmVsTDOThezkQ
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a525acb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=E4-JPO3nfyr_mCP9PrkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+ folks who might have an opinion from PPC RAS perspective as MCE, 
checkstop related.

On 10/07/26 9:32 pm, Peter Maydell wrote:
> (cc list is a random mix of maintainers of code that calls this
> function, Paolo as "main loop maintainer" and a few others who
> I thought might have an opinion.)
> 
> We have a qemu_system_guest_panicked() function which causes QEMU
> to report this to the user and do one of a couple of possible options
> (shutdown, pause the VM, do nothing). This seems mostly intended for
> "the guest OS told us by some mechanism that it just panicked". But
> we use it more widely than that...
> 
> Cases which are "the guest told us about a panic":
>   - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
>     and CRASH subtypes
>   - the pvpanic device
>   - the spapr ibm,os-term RTAS call
>   - x86 kvm: tdx_panicked_on_fatal_error()
>   - x86 xen: the SHUTDOWN_crash shutdown subtype
> 
> Cases which are not:
>   - hw/spapr/rtas.c: if the FDT has no RTAS address during system reset
>   - hw/spapr/spapr_events.c: if we wanted to deliver a machine check
>     exception to the guest but the FDT has no RTAS address
>   - hw/spapr/spapr_events.c: if we want to deliver a machine check

I liked the suggestion of qemu_system_unrecoverable_guest_error() but 
let's hear from others as well.

regards,
Harsh

>     but the guest is still dealing with a previous machine check
>   - arm whpx, if we get an unknown/unexpected exit code trying to run the VM
>   - x86 nvmm, for an unknown/unexpected VM exit code
>   - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>   - s390_handle_wait(): not sure exactly what this is
>   - s390 unmanageable_intercept(): again not sure, think this is where
>     the guest has gone off the rails and we can't keep running
> 
> At least one or two of the above have comments to the effect that
> they don't want to use e.g. cpu_abort() because they want to give
> the user the ability to examine the VM after this unrecoverable
> guest error, rather than just exiting QEMU.
> 
> So I guess my question is, is it OK to mash these two categories of
> "we can't keep running the VM" together, or should we define a new
> one for the "unrecoverable guest error" case, or do we already have
> some better thing to do that I missed?
> 
> In particular, "do nothing" might be a reasonable response for the
> user to configure to a guest panic notification, since the guest will
> presumably stick the vcpu into a do-nothing loop, but "do nothing"
> doesn't make sense for "unrecoverable guest error" because we'll
> probably then sit in QEMU in a tight loop retrying whatever it
> was that failed.
> 
> If we had some kind of qemu_system_unrecoverable_guest_error() then
> we could maybe convert some uses of cpu_abort() over to that (though
> uses of cpu_abort() are a very mixed bunch, some of which should be
> LOG_UNIMP or LOG_GUEST_ERROR and continue and some of which should
> be straightforward assertions, as well as some which might be this
> new exit case).
> 
> (This query was prompted by a patch for arm whpx which adds a new
> qemu_system_guest_panicked() call for an unhandled VM exit situation.)
> 
> thanks
> -- PMM


