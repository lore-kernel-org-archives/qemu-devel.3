Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11801C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOlO-0003AD-1A; Thu, 02 Jul 2026 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfOlM-0003A1-Ub; Thu, 02 Jul 2026 17:16:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfOlL-0003K4-8B; Thu, 02 Jul 2026 17:16:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662JIOv4529425; Thu, 2 Jul 2026 21:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7UoP77
 qyU4/owT3xQBWXc7tFkFPGqDmWa7OPSG7RRz8=; b=kK6wCL2CmB7+kDNkoxLIMQ
 bpDxpkm4kl0Wf4kv2IO3QVJjNQqboumZ+vRa+41eLcOnrRfFl3hpvouhgCFN349D
 kiPhx3jnneKhMlJxQ9kc1WCTpJemviBPivh9D4vpr8CSIKi89f8TpqtN735T/yIq
 k4LFLzj837/4yvCoqUb8PRWBgeTfdzQ8PXcblS+bdJfhQJvz/+xHX9c9djUgaE6I
 mZAiaYktMwWRLPdfopdOuQM09sSruKNQ9mo2pbBPbbfWUhk9N6GttwAiaKdansDE
 fCfx9GCEQWD6B105Q+xCRDz8MD63xX8/jOnsdgR/W/OMKOg1ASCXpcKDoErqOScQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n643mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 21:15:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662L4dhu025256;
 Thu, 2 Jul 2026 21:15:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhynkmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 21:15:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662LFq7858524036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 21:15:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1555658059;
 Thu,  2 Jul 2026 21:15:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E31C58053;
 Thu,  2 Jul 2026 21:15:49 +0000 (GMT)
Received: from [9.61.151.121] (unknown [9.61.151.121])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 21:15:49 +0000 (GMT)
Message-ID: <bda22b7e-7ed9-4d87-b19c-8b7082595159@linux.ibm.com>
Date: Thu, 2 Jul 2026 17:15:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 31/35] hw/s390x/ipl: Handle secure boot without
 specifying a boot device
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-32-zycai@linux.ibm.com>
 <5935d754-5e22-4926-84f1-2dea52d9455e@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <5935d754-5e22-4926-84f1-2dea52d9455e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIxOCBTYWx0ZWRfX3S6gWU/DN0Hl
 AQ2wflhWDgi0Q57O8A9X7nkJ9cFjiyrhI5Zup1UAfnOiQRvaotSnjvnHzIctfa/2Xe3Z4QEMR2R
 XQahY363UJUxc2Dq3Rnj3ceTaX6jZcEYnbUMuuoZOdEFdZpcXpdzvCa/Jix6DBuYlPQb6EFqPQQ
 8HOEGwNvIRDzfzZw9/nQSonuwnc0nRkDyN84Z6A7Cd5Bv0YvjX6l376nd+qF591XzonVQJrLCk9
 jZgncbdrUDqdbXXwFp5ODQLRKmu63BvDrnmsrg7fvrt9N85vODe8WonBiRwSofuCj6PSTAx8Y8n
 50IDxQkQmoRvABqp4DuYGR1NdQGnDcHEKEYV1OHt4UuUuLfrpSeAFD6slrxlJsftypjv9XTCAAX
 KFFR3Cde1GjFGYibo7O8jzpjlIokf80/W2vvZ6MAf2dZsBylAXty1l3RKoCT6ERhZ970FYq5LRh
 UKmHi7gQ9PkDJhkDGGA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a46d50a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=6S18NRq20EbNkitYd3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GCqBefivvjPR06T-gdpnGD68J2d4KzJ3
X-Proofpoint-GUID: GCqBefivvjPR06T-gdpnGD68J2d4KzJ3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIxOCBTYWx0ZWRfXzmz4/k6Aakmc
 /2oRlThMJQIl8Ovx1y2mFya7CfyuYqwBaceJwXLb1OCHevC0QKs73Jm52UiClf3pJ91F2BM73Gb
 v2JLB5X7Cz+z6FvTCtl7bpREg2XohtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020218
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Thanks for the feedback!

On 7/1/26 11:28 PM, Jared Rossi wrote:
> 
> 
> On 7/1/26 4:49 PM, Zhuoying Cai wrote:
>> If secure boot in audit mode or True Secure IPL mode is enabled without
>> specifying a boot device, the boot process will terminate with an error.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/ipl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d6a783d9f..f4e01b6918 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -865,6 +865,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>           cpu->env.psw.addr = ipl->bios_start_addr;
>>           if (!ipl->iplb_valid) {
>>               ipl->iplb_valid = s390_init_all_iplbs(ipl);
>> +
>> +            /*
>> +             * Secure IPL without specifying a boot device.
>> +             * IPLB is not generated if no boot device is defined.
>> +             */
>> +            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
>> +                !ipl->iplb_valid) {
>> +                error_report("No boot device defined for Secure IPL");
>> +                exit(1);
>> +            }
>>           } else {
>>               ipl->qipl.chain_len = 0;
>>           }
> 
> I think this check should be introduced quite a bit earlier in the 
> series when audit mode is first added.  Audit mode should give a warning 
> and continue, then this strict enforcement could be added with true 
> secure IPL mode.
> 

Sure, I can move it earlier. However, my understanding is that we should
always exit when no boot device is specified, regardless of whether
we're in audit or secure mode. For example, if multiple boot devices are
specified, we would verify the current boot device and terminate
immediately if it's unsupported in either mode. Based on that, it seems
that having no valid boot device should also be a hard-stop condition.
Please let me know what you think. Thanks!

> Regards,
> Jared Rossi


