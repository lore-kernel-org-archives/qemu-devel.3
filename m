Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6199810A88FD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pHR-0006EQ-M3; Thu, 26 Mar 2026 14:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5pHM-0006ED-ND; Thu, 26 Mar 2026 14:18:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5pHJ-0003Ju-BK; Thu, 26 Mar 2026 14:18:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QGKJw1510743; Thu, 26 Mar 2026 18:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qg47D9
 sArcLJS6kQ8TDXUvK7NZN401TB5GtjtdYJqoM=; b=KUtihxadH2sz7drzf8zy74
 vohvqqnS6VgEfx4gtGSZ/6EreSg81vMifHGvvxZMmjIVEYfAe5kRoR7PXIA9vjtS
 b+R478fzKaH8bT+5AwPzGHbIoLKoopo/FFixHzHONXjD7w7AlQcVP1YlzKj7z5Un
 I1cwBJwEjdgqwNkyU/ylGYi+9JVzyVbI6VVpoalmGEwGAlwaCemDSYmL8wiRZ8tR
 9Hi/rMv0zhiejvuwCOwSGEgA4eTMoAQwqqDW7TUfcvafwXRALkwjSvXP0rRcvGCd
 tCsGArO+4v2P7iFpQDqU+Klrc58H2/Y0Ce2O/n+POYOG35GAJ4sMst/DjvfQTWBQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa6mej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 18:17:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGRGMq026771;
 Thu, 26 Mar 2026 18:17:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m42tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 18:17:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QIHlha6685652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 18:17:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EECF5805C;
 Thu, 26 Mar 2026 18:17:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E91E58062;
 Thu, 26 Mar 2026 18:17:46 +0000 (GMT)
Received: from [9.61.246.71] (unknown [9.61.246.71])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 18:17:46 +0000 (GMT)
Message-ID: <c2df581b-e8ab-4fbb-91ae-08d17eb52878@linux.ibm.com>
Date: Thu, 26 Mar 2026 13:17:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] aio-poll: avoid unnecessary polling time
 computation
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-2-jhkim@linux.ibm.com>
 <20260325172236.GC701300@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260325172236.GC701300@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9NOp8Ukv8gtDqDSTSmdzgjN1ePgTbz-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMSBTYWx0ZWRfXyneHjI87MCp/
 e/9BpE13w4jIqrUI9ZJT//EaQhejgkdaLk3pWiDlDcGr75NC3va/XGIHRSkvSJ2abUWhHOiinKL
 ZAtgFexOwgardXTT01IkSOMmraujfaO20sr5aeNQ6XEhNqVm6rs88CjuZpvMTuJ6F4tpf+G7Kha
 kU+at7/qEkkaCpMBGHj3kpxVd7RvJCxJfXB/FwycOMG+nMD5ZpN6hPn95rzKhYeUs5GcCc0bRYc
 3APCSyJEEi6guUfe12/5K+UXNkCDKFJOQU1TTwBcOaDJ7/bV/wa5MGf6a/ptKIbrzIl1lmoRZKs
 KGRX8m3BtmLinFpqKwMT5mBQHMBTihGfDSLf8Vom4LEpfX9I+nbtuomyyHIolquK2I/nWfB9EeI
 SWhGHxiX8tb+bH/kzxBaXMDjvoJUc3hryVw2F/p8Pn3E2v/UYNrfIvXlWfIsK3ajUgcVysyfkdy
 +2R4fJV6mSVvRrDPqlw==
X-Proofpoint-GUID: 9NOp8Ukv8gtDqDSTSmdzgjN1ePgTbz-L
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c5784d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=aZu_EBGKBwqA9dl09EAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 3/25/2026 12:22 PM, Stefan Hajnoczi wrote:
> On Mon, Mar 23, 2026 at 08:54:49AM -0500, Jaehoon Kim wrote:
>> Nodes are no longer added to poll_aio_handlers when adaptive polling is
>> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
>> aio_poll() skips try_poll_mode() when timeout is 0.
> Skipping when timeout is 0 seems risky to me. VIRTIO devices disable
> guest kicks when polling mode is started. When aio_poll(ctx,
> blocking=false) is called, we will skip polling and
> ctx->fdmon_ops->need_wait(ctx) won't detect an event either. aio_poll()
> will return without noticing that the VIRTIO device's AioHandler is
> ready.
>
> Is skipping when timeout 0 necessary for performance or can it be
> dropped from the patch?
>
> Aside from this:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thank you for the review!
Removing the (timeout != 0) check does not cause any issue on my side,
so I plan to remove it in the next version.

However, I'd like to clarify: when timeout is 0, is there any concern
in the try_poll_mode function below that I might be missing?
I just want to make sure I understand correctly.

static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
                           int64_t *timeout)
{
     AioHandler *node;
     int64_t max_ns;

     if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
         return false;
     }

     max_ns = 0;
     QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
         max_ns = MAX(max_ns, node->poll.ns);
     }
     max_ns = qemu_soonest_timeout(*timeout, max_ns);

     if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
         /*
          * Enable poll mode. It pairs with the poll_set_started() in
          * aio_poll() which disables poll mode.
          */
         poll_set_started(ctx, ready_list, true);


     .....


Regards,
Jaehoon Kim.



