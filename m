Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91Oa-0006ve-7s; Tue, 22 Sep 2026 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur2@ibm.com>)
 id 1x90Wc-0006Nd-Hv; Tue, 22 Sep 2026 09:27:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur2@ibm.com>)
 id 1x90Wa-0006kP-O3; Tue, 22 Sep 2026 09:27:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBZiSY3332723; Tue, 22 Sep 2026 13:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZZpEcc
 HrXgZpcLsiKBUkqz8hq4Cc4hJy0oY9lVLbYKU=; b=FXGhudi8zlERKvMC71REf5
 ++QPbJXPW52aSDBn3CNikUcrRZTl9us1ZtHE6TC/G90KshwasXDATP2TBhRiFF7F
 z4vuA838YsbKSuZ2tisP9QWrQzg1kDhNMJ4lsYujuyPOXVMeyW8JHShMMsxIsmrT
 eIalQlY489DTGQibbwqTXsl597Ewa7eJlS4O9HWvJBh4O87/OCMb/V1G0WQIq0+A
 l6pQw8Qgn74znnzcHzaykPF7V8NWC9qxXoK3/wWDTth5vr4YwvyCN7e1yLvv4RI5
 9XmFc0ubh2K3ttzbltwsQNpsJg8mcZ+5bFT3l7/rzup1hCvSRBBBUVT1p7ZDH3+A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqdk9r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:26:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBWS7s2751901; Tue, 22 Sep 2026 13:26:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjsy9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:26:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MDQvdw64815452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 13:26:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 532A158061;
 Tue, 22 Sep 2026 13:26:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3AE05803F;
 Tue, 22 Sep 2026 13:26:53 +0000 (GMT)
Received: from [9.61.247.147] (unknown [9.61.247.147])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Sep 2026 13:26:52 +0000 (GMT)
Message-ID: <7deeb331-9027-46bf-ae9d-088f048243e7@ibm.com>
Date: Tue, 22 Sep 2026 18:56:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mac99: Boot OpenBSD/macppc
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur2@ibm.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260903115229.95811-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab28223 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YE3eV3kBTEzEQyOCPw0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfXwUw5H7ydQNUu
 4XGmGYpaZZ4Md+XZy2S7bPz1v0xbgbvszpoZXQSyQJPSCj1XAEMCfypPz3chEIkvi/5OlCT7FfM
 igy+LWENqCjzloG2he4A3w4wXsjYSyIpIepWYoC13AqCoU3mmGlR37gZU/NIDeLpAEBd4KQoeBn
 KWTNY+tTKYbIehrj4JYGngdaefoOxLkcmdnNhg9iqZXGVMMkKb2Rw2UzLCwTRo5b7uMLPey7RTA
 WQ7DgFkbLTzy12hnex6VwXAxSfm0xfr0mS2iqHI/vBLgRvzZePlj0hc0WwFlRZsDljqtr4vBtXT
 hiKJr/iml0DFzOuz3nDSH/tVdPwKiE3bjt6MmZ0CkEsTViqpXDM7UxiUX7RbxDu7sAaK3KDVNLE
 WsUWQ/qirZ7jF8iY5kILjNPeaAIcrwpcrFOG0NcGLHO8rMXYyhMnzlNKWlKhkagnmLSs5BlVItL
 OCK+kcuUJ5dJ+gOEkXA==
X-Proofpoint-ORIG-GUID: dqUNYtmhszVSjxCaul6xNh9mh_rK1sxi
X-Proofpoint-GUID: _yDuKBhsb8lSGknMGzvtLCZimkxfvivW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX+gawp87/im7y
 bl8Xzfz6t3CfpAVHSIl07z8ffzIWq0WlAGRUKD6DCOTTH+GaHNA/e4OIfnPAVSat1kK+0Z6yO6I
 nJoyKm+8m7JTmwXvObg4R/MW6Iq/kZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220190
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur2@ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2026 10:22:55 -0400
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


On 03/09/26 5:20 PM, Kirill A. Korinsky wrote:
> Greetings,
>
> OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
> reassert an interrupt still masked by CTPR; the edge triggered
> decrementer does not raise on zero; successful CUDA ADB replies omit the
> original command; and the fixed CUDA shift register delay can stretch
> packet delivery past the guest timeout on hosts with coarse timers.
>
> This series corrects these four behaviours and adds a functional test
> which boots the official OpenBSD 7.9 macppc CD to the installer prompt.
>
> P.S. this is second third to send the same patch because previous one
> had missed maintainers.
>
>
Hi Kirill,

Thanks for working on this patch series. I applied this patch set and 
ran verification tests on a Power (ppc64le) host; everything worked as 
expected.

Here is the detailed test summary:

1. Functional Test:
    Command:
    QEMU_TEST_QEMU_BINARY=./qemu-system-ppc64 ./run pyvenv/bin/python3 
../tests/functional/ppc/test_openbsd.py

    Result:
    TAP version 13
    ok 1 test_openbsd.OpenBSDMac99.test_openbsd_79_installer
    1..1

2. Manual OpenBSD Boot (TCG):
    Booted OpenBSD 7.9 RAMDISK image (cd79.iso) on mac99 with 
qemu-system-ppc64.
    Verified that OpenPIC, CPU decrementer calibration, and CUDA/ADB 
keyboard
    probing attached cleanly and reached the installer prompt:

    "Bochs VGA" rev 0x02 at pci0 dev 13 function 0 not configured
    softraid0 at root
    scsibus1 at softraid0: 256 targets
    bootpath: /pci@f2000000/mac-io@c/ata-3@21000/cdrom@0:/7.9/macppc/bsd.rd
    root on rd0a swap on rd0b dump on rd0b
    WARNING: CHECK AND RESET THE DATE!
    erase ^?, werase ^W, kill ^U, intr ^C, status ^T

    Welcome to the OpenBSD/macppc 7.9 installation program.
    (I)nstall, (U)pgrade, (A)utoinstall or (S)hell?

3. Patch 2/5 (Decrementer Zero Write) A/B Check:
    - Positive check: Kernel boots through clock calibration into idle 
loops cleanly.
    - Negative check: Reverting the patch 2 change caused the guest to 
reliably stall
      during early boot right after CPU probe. Re-applying resolved the 
hang immediately.

4. Concurrency & Non-Regression:
    - Verified OpenBSD mac99 boot with both single-threaded 
(thread=single) and
      multi-threaded TCG.
    - Verified KVM/TCG guest bringup (pseries) on the ppc64le host with 
different thread
      configurations without any regressions.

Please feel free to add:
Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>

Thanks,
Anushree Mathur

