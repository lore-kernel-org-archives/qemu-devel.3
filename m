Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF39C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrRY-00059X-HL; Thu, 09 Jul 2026 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whrRX-00059P-Ds
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:17:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whrRV-00086C-Dz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:17:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DvwpX2002005
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C5hxwYSgg5qs4JZ8Xj/5oBNw8JeP66Cx5M71kUg6wNA=; b=EcAC3GMCgQAzylbe
 YhZ0T6szNYzBQefDyMvLym2Hihq+wxBiCh6nAoRWo/WIl87DUvN6qd76SYr8BlEJ
 sFnOb2la6GmTcSVSz9uzaYjrGo+LszU6yuV24n4/aPMPdCSz1p3sRNfSKJUCBKBn
 WYcF9uxCZzQwAS1SRqvkTw63sQZmuaka4ha9fImsDczXGORCmjMliYWS4YfS2pAv
 LaTXcVvLBWRKNYp/qF0GUt7P1ZuY15WgVlZDokjst5XHh1fIflv4ei1PPgDFFezA
 gzYZNPo/76T4/+D4oL5aL+LxfYPayG8Y/xLrRcN9a5MYxK6vwxnxs1ikQuSqzCLS
 7dDtIA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3tn2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:17:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso120111cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783613859; x=1784218659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C5hxwYSgg5qs4JZ8Xj/5oBNw8JeP66Cx5M71kUg6wNA=;
 b=cTMZj7fZaWoGhqsnWPBLf1/kpTerpZ6c+Jr1XWnostS/g9iktXyWcgSyinKOvSQ0ja
 jQfHg7TGtzhlLW2TPmybQmTx1IEXoAtPW89vif4K3zLVbKEKu3LIUPbT2Dw5GkB0uAMu
 avVLKsEqRTKaBny3EcxCnSQJnE280MfBMF76PEJJCDHrii8JzfKqnN3vZkqgbBXu1Ero
 zW1Nowj3RrWj0Cblq//mF+4rngVMgksNQjTIMq2/Z8+WO+rQwo+G3ZcYwfh0ExO/RNVZ
 ptJL/X4IkhIp+B8Cds9zLGp2FA6W92jyIFeCikw7wcG8CiY4gpaKn1hfjKw+WiKLBT4+
 qSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613859; x=1784218659;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C5hxwYSgg5qs4JZ8Xj/5oBNw8JeP66Cx5M71kUg6wNA=;
 b=l90C68x7lF3SE+x5y2meRJuytzCLrNXeOYhGymVHglmXgKud2vX/p5AgV9u5ikGvQN
 1PclhtixVAr6J6sOJsKvcTeM88TFjJrFwv/O6LU7JfUHjt3pZs1qHj5CV9wgW0C6PC3G
 WjGnHNUHJBD8jeKB2ervFNk0sHo+bbtEwiN+fRqbjSRgMIfIiV2ZytYCMocWPn1A2ujm
 YH3Es+h+rDVS7g83rlBAlOr0Q45zZMHino3tUIMBWSfQXyYCAQmkqdftmVlwCp+5oMFz
 hMDg6TSzLU003mCceBgCP+C2wjhTzREdr3c54oVa2ecC0dusYkHC7yaxjFttcQikO3Ri
 zlFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEj88J2HaKoUbA9x+v1mOU0eMXBtQUEqCZGr1QsdVms+9e22zdJz4US7qeoT0j3flDVfnvO4Zwfsfx@nongnu.org
X-Gm-Message-State: AOJu0YyvrnXmZKrsJGs5PRCPs9c/sUARHyJ09nRQiGCteEOTPY0c1sop
 ePgxqaaEfmqDrtMmr2AjqLe6V48Ul7gl/2iM7AygxwtRHUD3G0ahd4RP3pty6tLD6ThFo87O9i6
 wwUQvdLqU3NKnttMQs7G4hRBu8yGYh0fvAcp97SBDTZk/Wxp6whqBm/BuuA==
X-Gm-Gg: AfdE7cnotehuuaPFaNWH0GzYEYjjJ8ikOHow1P3zaCku2lLDQnfCjAXbhAaL/CK8Slx
 XkMrzZ/7OO1L3RDIG+4r9QMFCAFfCzkdzNzZPkJA5fLb8lI3ce+PVQJGebuRFUS0TLR5c17xP6N
 HClINrVDHx0beFAuo77bD57CtX1dbM4o9E/5uPJkh5vgARP5ifFKOPzwnvngzdItqerBXq1elCI
 NMCPx3vdRftmMjhBV3UUQHcnh3QQ0xeq6xc+dcAmvJ/HWK42YbcCtQekJp/ScqvG/KsY6mrM6ic
 nM9PMlvvCmoqHQUIMlG38KygqDbcBC1Bs8N8wuCo3jKgK4wJbqwSSMQpcDcRGi1esNA4jfNoDt9
 BBOeIY1vfaNl1XUNiMFnDlRneHE9ZssBTGoyLrlW3luD/v//qXG0fYt0WoMEqfQ==
X-Received: by 2002:a05:622a:1920:b0:51c:291:82eb with SMTP id
 d75a77b69052e-51c9b62a87emr44555001cf.14.1783613858564; 
 Thu, 09 Jul 2026 09:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1920:b0:51c:291:82eb with SMTP id
 d75a77b69052e-51c9b62a87emr44554591cf.14.1783613858130; 
 Thu, 09 Jul 2026 09:17:38 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a3652a02asm9090736a12.11.2026.07.09.09.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:17:37 -0700 (PDT)
Message-ID: <3fc6d811-e666-4c5c-bb85-94fc9bf102de@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 18:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260619112158.304782-1-den@openvz.org>
 <8f3c11a9-64e6-44a3-bafb-9ac5d91d67a0@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8f3c11a9-64e6-44a3-bafb-9ac5d91d67a0@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YEQb02ZPAwtle4VpfvEF05E5lTK0tNwe
X-Proofpoint-GUID: YEQb02ZPAwtle4VpfvEF05E5lTK0tNwe
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4fc9a3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=yKEMG7WmrWSR15lrZ-AA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1OCBTYWx0ZWRfX1on6rSDE+pqw
 HFtErDRLni8515Wz8lOMvyZQ+fDiYEDztEHpEx7Ltni5sl8zrhi2sAgK0uU2Ab6CwFx7W+eBjLe
 /o3rQw6peSw+NN2RHjID7KgGcCexH1o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1OCBTYWx0ZWRfX67/6+hHB5zn3
 QPpCnHAUF66InXyb+75/tike77sQxw0J8nCE6W+SChzQqET0qY3nMPSLp8GkY2z86PuDAWzlH8G
 eu6m08vLWihKaGFGcdp0LaUZJMZW6rs0g+ExaIwljj9WYasVDo5MVGBmgxiF73IrABzXvHI9F+y
 iETogz/EoT71uQ9qQ6ASBLYuCQIvxmCgBUYSLd4j77QtBxmApP+JqzPutMch8E1qBMRjTxote5B
 QMccd+/t10nyCuPoVl1hQw+wJOtdKe32xV59WD+Bwq1D506fTOq8CPr4wr7trh2zjxSWU9MwKjt
 C8N5bq6STyB1JmmZDTgcIJaV3Ivayjo4mgRpMFoxC56h8DD7NmjOwLO+Y3WZ/1G0ShUSeb76TNh
 zAAD+3i7+O5Iv+QDn66LwcpD8Tso20X/3egeo88H3XpDXYvZ/D0IYAY/PRoW0DrTWDtaL0kTDZu
 dw6OELHyLOzr9VF1DEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090158
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/26 17:22, Denis V. Lunev wrote:
> On 6/19/26 13:21, Denis V. Lunev wrote:
>> An in-flight ATAPI buffered CD read (ide_buffered_readv(), used by both
>> the PIO and DMA reply paths in hw/ide/atapi.c) can collide with a
>> concurrent port operation, and it breaks in two distinct ways. Both are
>> guest-triggerable and reproduce on current master.
>>
>> Neither was found by inspection: both are real issues reported against
>> the qemu-kvm 10.0 downstream -- the crash from production, and the
>> deadlock from the downstream live-migration validation suite -- on
>> CD-ROMs backed by high-latency network storage, where a backend read
>> outlives the guest's SATA command timeout.
>>
>> 1. Command engine restart -> NULL-deref crash (patches 1-2)
>>
>>     A guest can stop and restart a port's command engine
>>     (PxCMD.ST 1 -> 0 -> 1) while a read is in flight. The restart re-maps
>>     the command list and clears AHCIDevice.cur_cmd, but nothing tears
>>     down the outstanding read; its completion then dereferences the
>>     cleared cur_cmd in ahci_pio_transfer() / ahci_dma_rw_buf(). This is
>>     not the COMRESET path -- an engine restart does not run ide_reset(),
>>     so the drive's transfer state is preserved and the read still runs.
>>
>>     Patch 1 cancels the outstanding I/O when the command list is
>>     unmapped, reusing ide_cancel_dma_sync() exactly as ATAPI DEVICE
>>     RESET already does from the same MMIO context. Patch 2 is a qtest
>>     covering the PIO and DMA reply paths.
>>
>> 2. Concurrent drain -> main-loop deadlock (patch 8, repro in patch 9)
>>
>>     A multi-sector PIO read whose byte-count limit spans more than one
>>     sector must fetch the later sectors of a DRQ burst from inside the
>>     completion of the first, asynchronous read. cd_read_sector_sync()
>>     did that with a synchronous blk_pread(), which queues behind any
>>     drain in progress. When a guest reset reaches
>>     virtio_blk_stop_ioeventfd() -> bdrv_drain_all_begin() while such a
>>     read is in flight, the nested read is queued while the outer
>>     completion still holds blk->in_flight, so the drain never finishes:
>>     the main loop wedges in the drain with the BQL held and every
>>     QMP/monitor operation blocks behind it.
>>
>>     Patch 8 reads the whole elementary transfer in a single asynchronous
>>     request, so no read is ever issued mid-burst; cd_read_sector_sync()
>>     is removed and the DMA path is unchanged. Patch 9 reproduces the
>>     hang via x-blockdev-set-iothread, which takes the same
>>     bdrv_drain_all_begin() path a guest reset does.
>>
>> Patches 3-7 are the test groundwork the deadlock fix needs: they fold
>> the IDE CD-ROM read tests into one parametrized helper and add the
>> previously missing coverage -- multi-sector DMA, and raw 2352-byte
>> READ CD on both IDE and AHCI -- so the rewritten ATAPI read path
>> (including its in-place 2352 unpack) is exercised on both consumers.
>> The test patches pass with or without patch 8, keeping the series
>> bisectable.
>>
>> Patches 1-2 stand alone as the engine-restart crash fix; they are
>> included here because the deadlock work shares and extends the same
>> ATAPI read path and its test scaffolding.
>>
>> checkpatch is clean on all nine patches; the new and existing IDE and
>> AHCI qtests pass.
>>
>> Denis V. Lunev (9):
>>    hw/ide/ahci: cancel in-flight buffered reads on command engine restart
>>    tests/qtest/ahci: test ATAPI read completing after engine restart
>>    tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
>>    tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
>>    tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
>>    tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
>>    tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
>>    hw/ide/atapi: read the whole elementary transfer asynchronously
>>    tests/qtest/ahci: regression test for ATAPI read vs. drain
>>
>>   hw/ide/ahci.c             |   3 +
>>   hw/ide/atapi.c            | 180 +++++++++++++++-----------------
>>   tests/qtest/ahci-test.c   | 201 ++++++++++++++++++++++++++++++++++++
>>   tests/qtest/ide-test.c    | 211 ++++++++++++++++++++++++--------------
>>   tests/qtest/libqos/ahci.c |   8 ++
>>   tests/qtest/libqos/ahci.h |   2 +
>>   6 files changed, 433 insertions(+), 172 deletions(-)
>>
> patches 1-2 landed via Philippe, thanks a lot.
> 
> What about the rest?
> 
> This is real obscure problem observable in production.

Since IDE is listed as "Odd Fixes" and no listed maintainers
commented for a month on a fix, maybe you could step up as
a new one... My 2 cents ;)

Kevin, as core block/ maintainer, any objection?

