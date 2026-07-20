Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4F8C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvH6-0006Sv-SX; Mon, 20 Jul 2026 17:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvH1-0006Pr-Re
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:11:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvGz-0002OU-Ld
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:11:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJToCM3540584
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wOOo1AhdyJmLxlGfRPE+qU5jxFsOpOoyohlBjs9fNP8=; b=IEQW96YUKF7wr4sv
 S1BBeVqXd+9eJpvYvJOG4gtAge229oWz3vu+g+Q4PxZMaQnHuJD1rbojwFTn0/SO
 tk4OMkx0xLsw2agfSg+QbuCeyJVbRkKhzBrzDdQWLpkkNu7zMB15UmXCncj0pBR6
 cPzdQF9D1Qplf+xXMClmDtct9Zp+pMH/I+yZAkIm713WcA+IjYa74WiWtbc3bluI
 oEgt9Q1Ll2Gpj9XlUxwFJTg6mubTiVtvMDGKJJDGG5iLoQcqP18WuTzOjZAEljoM
 lPA1ObMM3jJLh+LwGYzDWPHgBKQTwLKNjY8/AyepGPWXOSx36MEnOurPp/bvSwZf
 3aanlA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2fah3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:11:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so206681811cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784581895; x=1785186695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wOOo1AhdyJmLxlGfRPE+qU5jxFsOpOoyohlBjs9fNP8=;
 b=jPJ6d/qvlKNFECilFPt5h7zchQqOz3qp+LGiqkCoAGsrnecmRcZ7+CUbIUSB8q2o3k
 0ElHXjdeAZflEGwSi1u9RRgIJkEpQaWYGBYWeau85iLkDrIBpQZa6Z9bi29Jqnd4/itT
 mKPKwd8N6vm9YepKpL4QUwcGj93rZ5ruaN0QEYfAhoNeT2OcWN7qRH1zFw1HahVqu6WS
 2rKt1d6GVdzHw0qgi56QitJTAn/eJrPD7RqVZTAk8oVRRxp+/wYCtGRgfukHVKPSHGj+
 bfc28HrkzcBUeornNECHcQ1OpNee1lpYztPa7EViitXtGyLdv/85afEIuizWbShxutVd
 nZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581895; x=1785186695;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wOOo1AhdyJmLxlGfRPE+qU5jxFsOpOoyohlBjs9fNP8=;
 b=ecvCweJ+rMso0xeSV+CJezKcPjOZ14niKnUG/EjbZ5zAcUQpcXviT8mFSDVYVWcqXb
 Dh9F0ukaBwJnzcduL0Je9bkqMDicrX/zANJ9WW97qKhTLqdaFMssXGsFu8+mUGPQ1dNb
 +XYz3XIbnkRxrwrG89ozmGrOigw/jXH80Bpz51xiYKTJIizeGwxzodfrOVVh7z5hk+Hv
 tYpELxtyer9G++6N6R7BWON9DBIPhj1ScYYNtinctDhiELaFpjrdGMJBnlUtPrXWX0pJ
 CVzRHzkBpqZtl0VcEnRtI81WfcW+vLq+cWowbPHd8mk7ECBN3e1i85sFy95+lslBea+I
 sCbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF7b6rcfxoLmtQu+jtWfNebhJke68XfO9ATBV4sm5HaTAnCG16vFVpFatYPR/XmpQWlvpXv3088Pyx@nongnu.org
X-Gm-Message-State: AOJu0YyCtrYwDw9CtKjEbr7SwTd9+WBBDYtx0dl6YGSHHEw8cajoulIK
 N0rIpVDsNXMFfoc2wGQwPwoxSycViYCo91271emw3/YWY1otWg+0ywMSSgXLvzvplerhyACA6iP
 /wnjwsQr1kektrEVV77/dkMpnz67vb2+Kh78iTSHM205ZfZGk4kRDMwenRw==
X-Gm-Gg: AfdE7ckRlTdiP1GdM0PAwwF5K1C0O4YYR9HhA8l8kOcySocJMhYH1p8Udm6ZmnkdN5L
 nx9k/U901bX3JOFUvUYaG/zcDZ4eWzk1OBBDBYiODHPH45k5YcrHMcUS/OSkF/HhPwvOg5+HVeP
 wSdz5lq4Fc3NB0ZAmlDpBA46DcbWaTj7wcjE8zin3c+vmEWAnP277Nl7TwUhdg5NlRjnu6HlGk7
 Ma+/OPmmOqCoie32Jm7M4NS6yQZnUZ/i7F95VYHsRbqmdTHhT8z1d5jWu8hfQ0HLZnUWI7hSye/
 XCvEzKpnMMP2Qa5SwKe2kx+5y8ZS60ftz3yAs9sNlXpUKaCUkdd8ESiQuxluM63mwqNW+SWvJmD
 L2esuR/Ca2LP8AmlVPMlDkjsxb75NdiYmM5Gz66J4h2eNQRtm4L8=
X-Received: by 2002:a05:622a:1a92:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-5213c7e502fmr156799061cf.27.1784581895256; 
 Mon, 20 Jul 2026 14:11:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-5213c7e502fmr156798701cf.27.1784581894672; 
 Mon, 20 Jul 2026 14:11:34 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa81b2sm73500375e9.4.2026.07.20.14.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:11:32 -0700 (PDT)
Message-ID: <6cc61225-d3df-4e46-bc24-ac1582079306@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 23:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/ide: fix ATAPI CD reads racing port reset and drain
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260619112158.304782-1-den@openvz.org>
 <280a9e72-2c3e-4064-8666-6f2603e32d8c@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <280a9e72-2c3e-4064-8666-6f2603e32d8c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ohRUv-MZmBMwAvnMrHwkSDtAw1qMh0Qh
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e8f07 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=yKEMG7WmrWSR15lrZ-AA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX2+UO6Af9hhUZ
 ZFjssuXp2OMr+7gYbmBJBTxeDTsfq90Tjv1SvRP3iAHP0PI6yC8Tgs5Zvzo68Dadiuepi7bA2Gv
 nwHxSYUFJdgxrUGUFIxTddr9uJMlF+A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX6nq5q0n9229g
 JKGsEaHm34sEZpDMSzjszq5Fv5uSJCXt0cFkvgIRvzH6bAezfswa4eccldyuVyysz1h/mS8HxCc
 hp/7Z7Bmq6ytU+ztiClo2E5qTO7/lMf1Tr1K6fz03KbJl+ZPfK1i5Z3oW2ZSzyrn07UsGs+UjaL
 4ZeYJvTPHCqTxtw3Hh/a06mI3l3J/v2e6E8QPJqoWjNtM8/tvkK83xrwZQQEyU+TyyERBiEWnhd
 w01Rfg4h73xJzpDujFHuyrnGAymqeyvwF+Iq9mRgVzR/tRF5fPaL+JypK7twHMi8tRRi9fY0ok6
 T4V1DtuKWJ1d7U0QE6jFY9RWOPJF1OVNinGmaN+rE9NouLWPR+JmI3HFHYoAGvYI4KDX3Eeb6fJ
 pJwluQH/JWSsZ2Gf0bufKLETu9MTACifiA3GZ45XYIXF+aiT3eNw4S1qiM+ZLoVKzYwkb9Acfjm
 1nTlcs5Hat8I9OGoemw==
X-Proofpoint-GUID: ohRUv-MZmBMwAvnMrHwkSDtAw1qMh0Qh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 20/7/26 09:58, Denis V. Lunev wrote:
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
> Hi!
> 
> if nobody is able to take a look, will it be fine if I'll
> send pull request from my name for this?

qemu-block@ is Cc'ed so no objection on my side but first send a
MAINTAINERS patch stepping up for IDE, so you can include as first
patch of the pullreq?

