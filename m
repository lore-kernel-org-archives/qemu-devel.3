Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122DCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkzd-00031h-2F; Mon, 22 Jun 2026 16:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wbkzW-0002zV-95; Mon, 22 Jun 2026 16:11:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wbkzU-0003l4-Ck; Mon, 22 Jun 2026 16:11:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmZPI3938281; Mon, 22 Jun 2026 20:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HPQgA/
 /pdBW5NM+qaYWBQa9uywZgcO2UpXU9t7YmKzM=; b=ZpoZp+AOr7cf8ZpCXp6Den
 l3j0Rb8PQnefrhkE8ICSEuwYCFOYODeFDKDMl8lBw523srT20EVJyuitmrB97mts
 c5UM/2OHI/6XuKFYa6GKIZ2OOb51ZwqVwjcOREhi/7QbDVBmjRqJTQ23oXNTCq7J
 sLEU4s8Vb2Fc2IPmLt64HVQ8Xv28EfK7SHuecyCINaJaMjeAUoQpVo2PybqjTdar
 tVV2wcpzAnUsL1ozJkurctOpdSTbA0Ql0uM7/IboaHZaPgmZEGyIWzKUJKccYFfL
 h3AsFJ0GgYMTiU7Co2cyhlB/pLgi31JUkeVnhbif6uoXhLpxbuJ9hKlfRYi4Ddag
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4b5ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 20:11:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MK4dfk021055;
 Mon, 22 Jun 2026 20:11:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dfyqpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 20:11:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MKBOJT47710506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 20:11:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E2EE2004D;
 Mon, 22 Jun 2026 20:11:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E1F220040;
 Mon, 22 Jun 2026 20:11:19 +0000 (GMT)
Received: from [9.124.219.133] (unknown [9.124.219.133])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 20:11:19 +0000 (GMT)
Message-ID: <b5f2adcb-2c58-431d-aa16-87f299f8c880@linux.ibm.com>
Date: Tue, 23 Jun 2026 01:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/functional: Add remote interrupts test for
 PowerNV
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
References: <20260610090235.3665904-1-adityag@linux.ibm.com>
 <20260610090235.3665904-2-adityag@linux.ibm.com>
 <1493ce3f9eb33b680bcc41fcd433af3e2098d725.camel@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <1493ce3f9eb33b680bcc41fcd433af3e2098d725.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE5MiBTYWx0ZWRfXzigcLDvbab/j
 RwdJEMlp1XVZBLBaqo9uuJCTe6U8BFVuvDOmAFGSRqcDec//Po2Ja8khmBfsPRMkBx3HjuhPxVf
 fRvaJKM5N0ec446Ybefh/B+8++9EtNA=
X-Proofpoint-ORIG-GUID: 9EU0KWoRKMQsIBgsCVEaITo30Z2k1kvG
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3996f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=_pTC7v-JNlh9ycCcCLAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE5MiBTYWx0ZWRfXwAzza66EY9T1
 EKZZzulQy6KL7H80nZEY538fweERjKmQDhTr5LZYaEoNpx971gvcnpNH2e6aO25C1fld6CACHPC
 uEB+GCys2BuhCcXHQ3eWvCjg32ed/SqOZyk4Ytf0+6MC6b3iKG7HULQ5ENLaqKSU4AGDcozF/+2
 /oyoH1uzaKXgbu6vRdu8UEYldEMGEq6cGWcQ9KXHU21cSWMFvT9VIirGSRRMDwRhFnzJp3pmX8i
 o9kzQX+BJbZMqIOQ5QYTKbjfPMHRSti76zqU3wwWhZaUqHXOIKSdFPgXSM0tk2BzKehSrrIQvJ9
 L9h0qwBt68xbiklnRgngQc0BfKqD1/9IbWxJD1R4zvs2m/HQLff7PnL4WR6oQWFWKiCXHhIBnpC
 1TvVUTUWf25dUfuqY4WxQISineYwau+dgejNkfP5vPc1rCx8aNQt+AyUpHrrpeQCMf04HnmsKmw
 x6wcTGu4lkszeFsJOkw==
X-Proofpoint-GUID: Sulg4wWO65wbWJlxyH_X_xFi2OnANhG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220192
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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


On 12/06/26 13:11, Shivang Upadhyay wrote:
> On Wed, 2026-06-10 at 14:32 +0530, Aditya Gupta wrote:
>> +            '#', self.panic_message)
>> +        exec_command_and_wait_for_pattern(self,
>> +             "CTL_IRQ=$(grep 'eth0$' /proc/interrupts | awk '{print
>> $1}' | tr -d ':')",
>> +            '#', self.panic_message)
>> +        exec_command_and_wait_for_pattern(self,
>> +            "echo 1 > /proc/irq/$RX_IRQ/smp_affinity_list",
>> +            '#', self.panic_message)
>> +        exec_command_and_wait_for_pattern(self,
>> +            "echo 2 > /proc/irq/$TX_IRQ/smp_affinity_list",
>> +            '#', self.panic_message)
>> +        exec_command_and_wait_for_pattern(self,
>> +            "echo 3 > /proc/irq/$CTL_IRQ/smp_affinity_list",
>> +            '#', self.panic_message)
>> +
>> +        # Generate network traffic to trigger remote interrupts
>> +        # Ping QEMU's user-mode network gateway (10.0.2.2)
>> +        exec_command_and_wait_for_pattern(self,
>> +            "ping -W2 -c5 10.0.2.2",
>> +            '#', self.panic_message)
> Hi Aditya,
>
> Thanks for this amazing test. But when I was tinkering with this test
> case, Even if i changed command to "asdf" it seemed to pass. Also, in
> the logs, sometime ping sometime it might fail.
The testcase wasn't that good, I had explicitly written it to just see 
if qemu keeps running, and doesn't crash on remote interrupts, as has 
been seen in the past. But yes, it's better if we actually check if ping 
caused any remote interrupts at all, since it wasn't checking that hence 
the testcase was passing.
Planning to have a check in v2.
> pasta:review-aditya-qtests$ ./build/run python3
> ./tests/functional/ppc64/test_powernv.py
> PowernvMachine.test_linux_remote_interrupts -v
> TAP version 13
> ok 1 test_powernv.PowernvMachine.test_linux_remote_interrupts
> 1..1
> pasta:review-aditya-qtests$ cat
> build/tests/functional/ppc64/test_powernv.PowernvMachine.test_linux_rem
> ote_interrupts/console.log | grep -C5 "ping"
> ...
> 2026-06-12 12:59:26,316: ping -W2 -c5 10.0.2.2
> 2026-06-12 12:59:26,340: PING 10.0.2.2 (10.0.2.2): 56 data bytes
> 2026-06-12 12:59:26,343: ping: sendto: Network is unreachable
> ...
> pasta:review-aditya-qtests$
This can happen if eth0 is not up yet, will handle it.
>
> Also the interrupt counters, I think we need to verify the cpu where
> the intrrupt is actually triggering.
Sure, will add it in v2.

Thanks for reviewing shivang !


- Aditya G

> ~Shivang.

