Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0392606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DE1JfLC6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbdJ-00046O-UZ; Thu, 26 Nov 2026 10:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xWbdH-00043p-JW; Thu, 26 Nov 2026 10:43:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xWbdF-0002OZ-E6; Thu, 26 Nov 2026 10:43:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEYdjm422285; Thu, 26 Nov 2026 15:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=mGu+pfpOv2oJ/dK5DxXV1d8g/SQD
 BYULDbpMGcAXpHQ=; b=DE1JfLC6fwFtf5Moln71XkKoYlS4/L2OZVviDorViJ1o
 8/8h4PebWGmPASnyNaAkBfi6iRvWbeH36SubRMxmii3z+kexsTICs4zsKAhWAm3o
 ecUSfdyxtEt879gU8Qpbbsgwn97Lw04G5esoO5AxVNGYiuuLzqbK/UfCgVXNul9d
 rJS+T5R4Rbp/UJy8eU10i5p0NvTYn+fWJbOrPlQXi72SPRb7kWCEqQrAKi5Cgl5c
 wY3A1n8qg2PsZOLziN7Bl4Aq7DcqmOIJ4q8D+06C3Me/RuHMwWFbwc6iZ0RKtHUS
 Nvz8ov5wk89ZrRWG2SxX7ulD3++C8i9gYUrHLL/Ybg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fksyqb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 15:43:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEYEpE2483639; Thu, 26 Nov 2026 15:43:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcv016q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 15:43:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AQFhRf830016206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2026 15:43:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF49220043;
 Thu, 26 Nov 2026 15:43:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C5BD20040;
 Thu, 26 Nov 2026 15:43:27 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Nov 2026 15:43:27 +0000 (GMT)
Message-ID: <5fa22932-3a6c-4b77-af53-a2d187e7603f@linux.ibm.com>
Date: Thu, 26 Nov 2026 16:43:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Wolf <kwolf@redhat.com>
Content-Language: en-US
Cc: qemu-block@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: performance regression due to 0bd5a1b3d60c "block: Fix corruption
 from broken RMW atomicity"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX0t6wNxbVMooq
 +36ZNPuuKtdriEWUIr+fxAu/YdhgMhkUVk3B5ktEAPWpOm8bArgey6BAqLTdxAinDm3IQjzJpfm
 blblDBfpMLjkUm+RWXzzufcQqLr0JK4uGTwyzwBZsD/zcMmI8nUMWHSJzGf185VlHZH8j4gfMVX
 xc55XkWoRo2axl6ikK3F4Y2uIczQGtlPZYeYVqEnwjrV9+aQ/Up2EuOirwoF4nQwCRxzB0U5uV/
 ajYh7SjW4Y1AMYjOgwnkkEWrSRkzoPYgx6LbKLoXq8l9z30na92Ne2v1knsgeA+8S2+vKfi7EdG
 papvjIa44fJiDZi3mwqWD01A7YSR5hivcV+9BbPmzT6X+HI3wyonqjOPzlHOolrvrW5YSuUxG9+
 yJXmfFZpCMEdK26Jt0gMEvNiAZevrmKywFdEOYuAkVv4IXZYubCTz/KPbzz/bnWgS8BuMhibkIa
 roBmQXiuEJAayykS8Jw==
X-Proofpoint-ORIG-GUID: _xp4PDZLx-XQrj8SlEl8y_fRKWS-nTB_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX/aq3BrAuqtZI
 7ORVHqQI5EkMbb/uzHatPBh94hWKT/75Uo5DSd/GOJdwjAhbjTsv+MTEdrGmR3lPNFCggDsF9cs
 Qis+GCvoiF72gxT3Z5u4f8V0wWLK/I0=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0853a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=602FRLB10v8c0KfTTxQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _xp4PDZLx-XQrj8SlEl8y_fRKWS-nTB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260061
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kevin,

the fix
- 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
results in a pretty hefty performance regression for my nvme disk via virtio-blk and
multiple iothreads.

I uses AI to analyze and summarize and the result was seem legit from what I
can tell, so I paste this is verbatim.
I verified that 0bd5a1b3d60c is bad and 0bd5a1b3d60c^ is good.



## Description of problem
Since commit 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
and the follow-up cf4f672c11d6 ("block: Remove now redundant
bdrv_wait_serialising_requests() calls"), tracked_request_begin()
unconditionally calls bdrv_wait_serialising_requests_locked(). The
`bs->serialising_in_flight` fast path that bdrv_wait_serialising_requests()
used to provide is gone.

As a result, every request, including plain aligned reads on a setup that
never has serialising requests, walks the complete `bs->tracked_requests`
list while holding `bs->reqs_lock`. With a multiqueue virtio-blk device
whose queues are mapped to several iothreads, all iothreads share that
one list and lock. With N requests in flight, each request does an O(N)
pointer chase through list nodes that live on other iothreads' coroutine
stacks, so most nodes are remote cache lines, and it holds the lock
while doing so.

The RMW race the commit fixes only exists with misaligned writes, e.g.
512-byte guest sectors on 4k host storage. The setup here is 512/512
(logical block size on both host and guest), so no request is ever
serialising, but all requests still pay for the walk.

Effect: multiqueue throughput stops scaling. Adding queues and iothreads
barely helps, no iothread reaches 100% CPU, and the host NVMe sees only
about 40 of the 128 requests the guest keeps in flight.

## Steps to reproduce
1. Attach a fast host NVMe namespace as raw virtio-blk with `num-queues=4`
    and an `iothread-vq-mapping` of one queue per iothread (4 iothreads),
    `aio=native`, `cache=none`.
2. In the guest, run 4k random reads with one job per queue, e.g.
    `fio --name=t --filename=/dev/vdb --direct=1 --ioengine=libaio --bs=4k --rw=randread --iodepth=32 --numjobs=4 --cpus_allowed=0,3,6,9 --cpus_allowed_policy=split --size=16G --offset_increment=16G --runtime=20 --time_based --group_reporting`
    (the CPU list puts one job on each blk-mq queue of a 12-vCPU guest).
3. Repeat with iodepth=64. Throughput goes down instead of up.
4. `perf record -g` on the host shows bdrv_find_conflicting_request() as
    one of the top symbols in the iothreads, called via
    blk_aio_read_entry -> bdrv_co_preadv_part -> tracked_request_begin ->
    bdrv_wait_serialising_requests_locked.

## Additional information

### Measurements
4k random I/O, IOPS, same guest and config throughout (two runs where two values are shown):

| test | master 2026-11-05 | master + suggested fix below | distro 11.1.90 snapshot |
|---|---|---|---|
| randread, 4 jobs x 32 deep | 542k / 566k | 693k / 741k | 494k / 505k |
| randwrite, 4 jobs x 32 deep | 533k / 534k | 700k / 707k | 536k / 538k |
| randread, 4 jobs x 64 deep | 448k | 830k | 445k |
| randread, 1 job x 128 deep | 339k | 368k | 333k |
| randread, 1 job x 1 deep | 12.9k | 12.3k | 12.8k |

The same 4 jobs reach about 839k IOPS when run directly on the host
NVMe, so with the fix the guest is close to bare metal at depth 64.

Other observations:
- **Profile:** before the fix, about 10% of iothread cycles are in
   bdrv_find_conflicting_request(). In annotated code, about 88% of those
   samples are on loading the next list node, and about 85% of
   tracked_request_begin()'s samples are on the shared list head.
- **Splitting the list confirms the cause.** Splitting the same NVMe into
   four dm-linear devices, attached as four separate virtio-blk disks (each
   with its own BlockDriverState, list and lock, same 4 iothreads, same 128
   requests in flight), raises throughput from about 440k to 613k IOPS
   without any code change, and bdrv_find_conflicting_request() drops to
   about 1% of iothread cycles.
- **Not the usual suspects:** changing iothread poll-max-ns, host KVM
   halt_poll_ns or aio=io_uring vs native made no difference to throughput.

This was measured on s390x, but nothing in the affected code is
architecture specific. I expect the same behaviour on other hosts with
multiqueue virtio-blk/virtio-scsi and several iothreads.

### Suggested fix
Restore the fast path inside tracked_request_begin(): only call
bdrv_wait_serialising_requests_locked() if `bs->serialising_in_flight` is
non-zero, reading the counter while `bs->reqs_lock` is held (i.e. after
the QLIST_INSERT_HEAD that is already done under the lock).

Why this keeps the race fixed:
- **Marking is atomic with respect to the lock.** A request is marked
   serialising (`req->serialising = true` plus the serialising_in_flight
   increment in tracked_request_set_serialising()) only while holding
   `bs->reqs_lock`.
- **So a zero counter means nothing can conflict.** If the new request
   sees the counter as 0 under the lock, no request currently in the list
   is serialising, and bdrv_find_conflicting_request() would return NULL
   anyway.
- **A later serialising request waits for us.** If a request becomes
   serialising after we dropped the lock, its own
   bdrv_wait_serialising_requests_locked() walks the list, finds our
   request (already inserted, `waiting_for == NULL`) and waits for it.
   That is the ownership semantics the RMW fix relies on.
- **The one remaining difference is harmless.** A serialising request may
   already have decremented the counter in tracked_request_end() but not
   yet left the list. It has finished its I/O, so not waiting for it is
   safe, and this matches the behaviour before 0bd5a1b3d60c.

With a local build containing exactly this conditional, the guest numbers
in the "master + suggested fix" column above were measured.

Remaining limitation, not addressed by this fix: all iothreads still
insert into and remove from one list under one mutex per
BlockDriverState. At higher request rates that will become the next
scaling limit for multiqueue devices.

### Fixes
- 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
- cf4f672c11d6 ("block: Remove now redundant bdrv_wait_serialising_requests() calls")

Both were backported to stable-11.1 (v11.1.3) and stable-10.0 (v10.0.15),
so these releases are affected as well.

Christian

