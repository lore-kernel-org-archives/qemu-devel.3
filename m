Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298DAC5AD4E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtVjp-0000m7-8J; Fri, 20 Feb 2026 14:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vtVjo-0000lv-4R; Fri, 20 Feb 2026 14:00:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vtVjm-00040q-Fx; Fri, 20 Feb 2026 14:00:27 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61KH2Enf3151657; Fri, 20 Feb 2026 19:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=APwrbD
 34v1eiar64hk8qsl5I7jU1bojc4zYHw+uJfAA=; b=jy/vnK51amUqHAZXK/4q8L
 mcjKMngQJpk4g9Y/uPeuh58sYWVAUKKSo10zcBV05EIDDNH1AheUqat4tvRgYYnX
 g0RhtTZT2dkwn6G+fHX0frIuXHWBQMwX6Hz41XVZBschBig3Tipx1zM3cKM8N3iN
 93QBdfeKS9DOcCN3bXQD/gqEepRk+CEPGkq7CcmotrMzsvTtO8lMrpNXBE399uaJ
 3sB6O/QaM9VYNQfrE2ZNPUmCou15N1zI7LIMrPJRjXi5y/3akckLU/Ld42+RMNdu
 fQmz2wXkhM87L8LABEgnzMYrFfF5bjSa4BimEchbEgxP5qywHFGQApQXOZ9tclRA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6scmws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 19:00:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KIdoap001883;
 Fri, 20 Feb 2026 19:00:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bsmdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 19:00:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61KJ0I1v52494820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Feb 2026 19:00:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8168F5805F;
 Fri, 20 Feb 2026 19:00:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7DB558053;
 Fri, 20 Feb 2026 19:00:17 +0000 (GMT)
Received: from [9.24.20.109] (unknown [9.24.20.109])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Feb 2026 19:00:17 +0000 (GMT)
Message-ID: <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
Date: Fri, 20 Feb 2026 13:00:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260219222717.GA1011077@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260219222717.GA1011077@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6998af44 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=L1kEF-V5z1niAaKuVtwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IwG26yItRvtc0h2cV3PRVsk4daNYQnnJ
X-Proofpoint-ORIG-GUID: IwG26yItRvtc0h2cV3PRVsk4daNYQnnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1NyBTYWx0ZWRfX2cXQlK7NWfB6
 rG+o0db1YHHaWlRHDGqFOgpYJW2xbmEzDs4qbOdNDMyva1zvK3fo9aUmVMBT0qeRQ35M9LZYAQi
 iEIO4wTH27akPnbJgfEG/9FbHVEP67tLouyz2Sb9iO/PBpzejqBwx08zUitKTAbZqdQy4cnsIzn
 0khwiNt8VwvVZT1/fY8ryagUuVsmrcQGCbN/xey0D1SmAii8/u7jiIrnozJXaJouuolgwMrLjtM
 qo9qGEkVjfbC/bbigbRQeHMI+Wwkv7Uur081PcW+nO3xafi6OT8qLPkReq6tj8FlVF+JZSBnkfY
 8sImtiSh+oRTTkos60y1anjdyd8k5p5nii/r5yCFMRf2eAV9QBWXXWXjB3chlrc/p3gLucjOj/3
 fA3ULA3Y3bEQLr2qTOOp60PXT5O6bnohuryr3ta/ti0iblXyORZO7beRV0ZmqTJRQA+WvC4RMxo
 nVycY1V/T/oYvwfh3rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/19/2026 4:27 PM, Stefan Hajnoczi wrote:
> Hi Jaehoon,
> Following the call earlier this week I ran a single fio job to get a
> clearer picture of:
> 1. The QEMU 10.0.0 regression that prompted you to optimize AioContext
>     polling.
> 2. How the poll-weight parameter affects IOPS.
>
> run      rw        bs   numjobs iothreads iops   diff
> v9.2.0   randread  8k   1       1         174944 3.6%
> v10.0.0  randread  8k   1       1         174285 3.2%
> baseline randread  8k   1       1         168908 0.0%
> w2       randread  8k   1       1         163718 -3.1%
> w3       randread  8k   1       1         165805 -1.8%
> w4       randread  8k   1       1         167388 -0.9%
>
> This time I only ran randread bs=8k iodepth=8 numjobs=1 with a single
> IOThread.
>
> Observations:
>
> - There might be an IOPS regression between v10.0.0 and the baseline
>    (9ad7f544c696) that your patches apply on top of. This is different
>    from the CPU utilization regression that you found in v9.2.0 ->
>    v10.0.0. I will bisect it.
>
> - poll-weight=3 and 4 improve IOPS to a level that is acceptable. CPU
>    utilization looks like this:
>
> run         %usr     %nice      %sys   %iowait    %steal      %irq     %soft    %guest    %gnice     %idle
> baseline   49.37      0.00     31.10      0.00      0.00     11.61      0.04      0.00      0.00      7.89
> w2         46.24      0.00     32.61      0.00      0.00     11.84      0.10      0.00      0.00      9.21
> w3         48.04      0.00     32.17      0.00      0.00     11.98      0.08      0.00      0.00      7.73
> w4         48.56      0.00     31.23      0.00      0.00     11.48      0.03      0.00      0.00      8.69
>
> poll-weight=2 is the winner at CPU utilization. I'm not sure if
> poll-weight=3 will produce an acceptable CPU utilization improvement for
> you. Do you have data or want to re-run to measure poll-weight=3?
>
> Stefan

Thank you very much for sharing the detailed measurement results.
I truly appreciate the effort.

Regarding w=3, I will discuss with our performance team to see
if the CPU consumption levels are acceptable within our internal
test environment. I will get back to you with more definitive data
as soon as possible.

Thanks again for your thorough analysis.

Regards,
Jaehoon.

