Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7AE10A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n3U-0001bV-9I; Thu, 26 Mar 2026 11:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5n3S-0001au-28; Thu, 26 Mar 2026 11:55:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5n3P-0008Me-Sq; Thu, 26 Mar 2026 11:55:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QAjeHe3303794; Thu, 26 Mar 2026 15:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xRMyDv
 hvuIppyyFRzEtqqeBgP8034EnKcmGwlvk+sno=; b=NxBuLaGDKprQQDvBB9/fNn
 CR39nZWPf0Y1zv3Vsn7e2CWe+AcfhoY9kzz9iYld1N+rfy8jjEsr5WZE3tTptoVR
 0yDNe/kJgMFCVQDKkB1fFdvR5eEYa5yYgjM4xc3s8mXNjVsxj+7K5/9GsgWwE4+W
 s9XufG0/ysPdQrjzAzBsh3rK9wX+hgN1PMsjhUNBcyllvIRAoFeASYQi1t9nCOTK
 CwzDKBvjhDd/0SJQ7QDIoAL7rxRYEGdMPFgRTBq6x9BSbLNxfNpBEBebO7kRUW13
 Dt2RXLCDHombEoVI3tX33wkCcoNGiIRvGMtVeZZ3IZD+QNr3SR/MmrghQnijiN8w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumw2fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 15:55:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFctVN026681;
 Thu, 26 Mar 2026 15:55:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m3hf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 15:55:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QFtMAj29426176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 15:55:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E3475805A;
 Thu, 26 Mar 2026 15:55:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6858258054;
 Thu, 26 Mar 2026 15:55:21 +0000 (GMT)
Received: from [9.61.246.71] (unknown [9.61.246.71])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 15:55:21 +0000 (GMT)
Message-ID: <738e8d90-b08f-4ded-bd8d-3155a665a725@linux.ibm.com>
Date: Thu, 26 Mar 2026 10:55:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, stefanha@redhat.com,
 fam@euphon.net, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com> <87o6kckntx.fsf@pond.sub.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <87o6kckntx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jUJyHYcSrxiu13eVmXZdKi6Gxkcpuz9b
X-Proofpoint-ORIG-GUID: jUJyHYcSrxiu13eVmXZdKi6Gxkcpuz9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExMiBTYWx0ZWRfX+xP7DHDwogpX
 QEuCwNnrQrnoyQO//Z6l0HIwUcd/+DhpWYEnFMtZ26APf6m5AgqVGlLmRpC0bI2bOnlCOaJbCsz
 sCSGkmSPK0tccOR41Qye8Xkd4ZVWrzhc1++7t41TpdalfXpGP97F2Dz+opBO7xQ+k2G0fShnABz
 t582UwuzArC1Gdi94/tq0rAYsjfdWHw+DrIcgPggd8xvzCQi0P0+5Op4sVa2OIgZFtXyF/21US1
 BOxjK9jQR77WSEPiWtDsjsIO2suA+yC4cuyPOSgMAfRlg8pGysz4bnJnjVVgVTUWcRXiFcmB9QE
 rPArqJUxjBwahTmITmSS2xuFTdqkg+/uyeLLwm34sSuJI2aHvB+SPkY0W5358SL6wxg2wgoQrlX
 F5vhvsIqezsHo4QcGCi5eAJqcoYaQBnv1ACZJ+LXU/6DYYFtiA3F1J6C/ex8tZprYxFjwZ4f8nR
 D5oBIOYHLMZt1nL+Ynw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c556ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=A1X0JdhQAAAA:8 a=wUdAAK9_4Np1DJtOBq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/25/2026 9:04 AM, Markus Armbruster wrote:
> Jaehoon Kim <jhkim@linux.ibm.com> writes:
>
>> Introduce a configurable poll-weight parameter for adaptive polling
>> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
>> constant, allowing runtime control over how much the most recent
>> event interval affects the next polling duration calculation.
>>
>> The poll-weight parameter uses a shift value where larger values
>> decrease the weight of the current interval, enabling more gradual
>> adjustments. When set to 0, a default value of 3 is used (meaning
>> the current interval contributes approximately 1/8 to the weighted
>> average).
>>
>> This patch also removes the hardcoded default values for poll-grow
>> and poll-shrink parameters from the grow_polling_time() and
>> shrink_polling_time() functions, as these defaults are now properly
>> initialized in iothread.c during IOThread creation.
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> [...]
>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 28c641fe2f..39d17010bc 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -85,6 +85,12 @@
> Note: this is IOThreadInfo, used only as return value of
> query-iothreads.
>
>>   # @poll-shrink: how many ns will be removed from polling time, 0 means
>>   #     that it's not configured (since 2.9)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.
>> +#     Determines how much the current event interval contributes to
>> +#     the next polling time calculation.  Valid values are 1 or
>> +#     greater.  0 selects the system default value which is current 3
> Does query-iothreads actually return 0?  I'd expect it to return the
> value that is actually used.
Thanks for your feedback.
Expose IOThread default poll parameters in iothread_instance_init() so
query shows system-initialized values for grow, shrink, and weight.
Also, I modified iothread_set_param() so that when the user input 0,
it reverts to the system default values.

>> +#     (since 10.2)
> 11.1 most likely.
Thanks for noticing. I'll update the version to 11.1 in the next patch.
>> +#
>>   # @aio-max-batch: maximum number of requests in a batch for the AIO
>>   #     engine, 0 means that the engine will use its default (since 6.1)
>>   #
>> @@ -96,6 +102,7 @@
>>              'poll-max-ns': 'int',
>>              'poll-grow': 'int',
>>              'poll-shrink': 'int',
>> +           'poll-weight': 'int',
>>              'aio-max-batch': 'int' } }
>>   
>>   ##
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c653248f85..feb80b6cfe 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -606,6 +606,11 @@
>>   #     algorithm detects it is spending too long polling without
>>   #     encountering events.  0 selects a default behaviour (default: 0)
>>   #
>> +# @poll-weight: the weight factor for adaptive polling.
>> +#     Determines how much the current event interval contributes to
>> +#     the next polling time calculation.  Valid values are 1 or
>> +#     greater.  If set to 0, the default value of 3 is used.
> The commit message hints what the valid values mean, the doc comment
> doesn't even that.  Do users need to know?
>
> Code [*] below uses it like time >> poll_weight, where @time is int64_t.
> poll_weight > 63 is undefined behavior, which is a no-no.  Please reject
> such values.  poll_weight == 64 results in zero.  Is that useful?
>
> Missing: (default: 0) (since 11.1)
I agree. I will update the doc comment to give users a practical hint,
for example like this:

# @poll-weight: the weight factor for adaptive polling.
#     Determines how much the most recent event interval affects
#     the next polling duration calculation.
#     If set to 0, the system default value of 3 is used.
#     Typical values: 1 (high weight on recent interval),
#     2-4 (moderate weight on recent interval).
#    (default: 0) (since 11.1)

I will also a check in the code so that values exceeding the maximum
allowed will revert to the system default.
>> +#
>>   # The @aio-max-batch option is available since 6.1.
>>   #
>>   # Since: 2.0
>> @@ -614,7 +619,8 @@
>>     'base': 'EventLoopBaseProperties',
>>     'data': { '*poll-max-ns': 'int',
>>               '*poll-grow': 'int',
>> -            '*poll-shrink': 'int' } }
>> +            '*poll-shrink': 'int',
>> +            '*poll-weight': 'int' } }
>>   
>>   ##
>>   # @MainLoopProperties:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 69e5a874c1..8ddf6c8d36 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -6413,7 +6413,7 @@ SRST
>>   
>>               CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
>>   
>> -    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
>> +    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,poll-weight=poll-weight,aio-max-batch=aio-max-batch``
>>           Creates a dedicated event loop thread that devices can be
>>           assigned to. This is known as an IOThread. By default device
>>           emulation happens in vCPU threads or the main event loop thread.
>> @@ -6449,6 +6449,11 @@ SRST
>>           the polling time when the algorithm detects it is spending too
>>           long polling without encountering events.
>>   
>> +        The ``poll-weight`` parameter is the weight factor used in the
>> +        adaptive polling algorithm. It determines how much the most
>> +        recent event interval affects the calculation of the next
>> +        polling duration.
>> +
>>           The ``aio-max-batch`` parameter is the maximum number of requests
>>           in a batch for the AIO engine, 0 means that the engine will use
>>           its default.
>> diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
>> index 9ab1ad08a7..4c38f36fd4 100644
>> --- a/tests/unit/test-nested-aio-poll.c
>> +++ b/tests/unit/test-nested-aio-poll.c
>> @@ -81,7 +81,7 @@ static void test(void)
>>       qemu_set_current_aio_context(td.ctx);
>>   
>>       /* Enable polling */
>> -    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
>> +    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, 3, &error_abort);
>>   
>>       /* Make the event notifier active (set) right away */
>>       event_notifier_init(&td.poll_notifier, 1);
>> diff --git a/util/aio-posix.c b/util/aio-posix.c
>> index 2b3522f2f9..13b7f94911 100644
>> --- a/util/aio-posix.c
>> +++ b/util/aio-posix.c
>> @@ -29,7 +29,6 @@
>>   
>>   /* Stop userspace polling on a handler if it isn't active for some time */
>>   #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
>> -#define POLL_WEIGHT_SHIFT   (3)
>>   
>>   static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
>>   static void grow_polling_time(AioContext *ctx, int64_t block_ns);
>> @@ -593,10 +592,6 @@ static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
>>       int64_t old = ctx->poll_ns;
>>       int64_t shrink = ctx->poll_shrink;
>>   
>> -    if (shrink == 0) {
>> -        shrink = 2;
>> -    }
>> -
>>       if (block_ns < (ctx->poll_ns / shrink)) {
>>           ctx->poll_ns /= shrink;
>>       }
>> @@ -610,10 +605,6 @@ static void grow_polling_time(AioContext *ctx, int64_t block_ns)
>>       int64_t old = ctx->poll_ns;
>>       int64_t grow = ctx->poll_grow;
>>   
>> -    if (grow == 0) {
>> -        grow = 2;
>> -    }
>> -
>>       if (block_ns > ctx->poll_ns * grow) {
>>           ctx->poll_ns = block_ns;
>>       } else {
>> @@ -640,8 +631,8 @@ static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
>>                * poll.ns to smooth out polling time adjustments.
>>                */
>>               node->poll.ns = node->poll.ns
>> -                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
>> -                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
>> +                ? (node->poll.ns - (node->poll.ns >> ctx->poll_weight))
>> +                + (block_ns >> ctx->poll_weight) : block_ns;
> [*] This is the use of @poll-weight referred to above.
>
>>   
>>               if (node->poll.ns > ctx->poll_max_ns) {
>>                   node->poll.ns = 0;
>> @@ -831,7 +822,8 @@ void aio_context_destroy(AioContext *ctx)
>>   }
>>   
>>   void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>> -                                 int64_t grow, int64_t shrink, Error **errp)
>> +                                 int64_t grow, int64_t shrink,
>> +                                 int64_t weight, Error **errp)
>>   {
>>       AioHandler *node;
>>   
>> @@ -848,6 +840,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>>       ctx->poll_max_ns = max_ns;
>>       ctx->poll_grow = grow;
>>       ctx->poll_shrink = shrink;
>> +    ctx->poll_weight = weight;
>>       ctx->poll_ns = 0;
>>   
>>       aio_notify(ctx);
> [...]
>


