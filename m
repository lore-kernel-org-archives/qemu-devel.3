Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD97C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuZz8-0001q8-D1; Thu, 13 Aug 2026 14:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZyz-0001ma-D0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZyv-0001x4-Un
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:16:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFwwnR3249305
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PWFJKPjiUmt2MzQeVSdtz6
 +I6h5J0GJ1E7SS22Bc2ZU=; b=i9P0McYtdYz9t6lpEeQncewevRg0h4yiVxMWJA
 j4+P8d2tQh8v2ko3emcxDUNqhIAfjATjE3ACGbrPeYI0esHXNFUpawWGkgnfZGM/
 8OZwqM6xSmfrM1jQdBQY/BuF0uioEpRLvK45/zZJu1NXOU4l0b0evFMV1jvS5uAS
 wx/qVUPglsQpFvhlgsnRy7PxHFd859NbDtSD64AuUad0Fgealp83JknpV4zo5Ju0
 efRb5T6dtc/KYptsebrqpFcV9P/Myud+22XetzMFC+LRvEMVhfC6zCTviVi/EjZ3
 /FtI3drB1uXd9nzEaL3qGvTAW26ltBud2hRTvVz19JUqHVcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1urp69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:16:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso2461141cf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645003; x=1787249803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PWFJKPjiUmt2MzQeVSdtz6+I6h5J0GJ1E7SS22Bc2ZU=;
 b=OQFpV4IpXsLdkjcEvksG0BekgXdBEQn+i9DZORCe7GR2Me+tklbWwxW/d5BsdhhRpG
 k3iLW8NrUhHLq+j2S7Rh0uFhBfEhoTW9aNmbVJySJZSQ3gPCT5U2/NyYUDWXTDYUcdQl
 4eR/7yy7B9nguoTadch3QOei0p7FpoMEDqgM68gdHcZ3I0hUVk9dm7sWeykXmOkRbuC5
 FZkJNZ1YesNSt82GT7XCEpzzS0Fftn8Fvm6VlpgP6XcMgUi0fRKRh8+/Va6HlWv6FVTG
 CE30dMuZCt+M2XTEPTdnVAsS3OcnXQ1EU8u/ws0HLdLtmGRPCTC2zY4mCbR0pkxRUdik
 LJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645003; x=1787249803;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PWFJKPjiUmt2MzQeVSdtz6+I6h5J0GJ1E7SS22Bc2ZU=;
 b=dBQ7X/rypnv3rbCA32CspfvcR0+PGtaoWpzGCKiO6Zeg+9DRUZG4Ttryj6gyFYQv5d
 INNJKYWSOABJtubL7ZzZ/7UgMnHLrnHoEx9xTvYCQPnUcqMNTfjTDFy2ALKzsmIrW7c9
 kLSwsabh51F46Ts6mDC87IsB4b14eLlzXTI8+CkavYQ+rLJTisleCCDzN+EbngFicbf7
 kKcl7BEmh1refijjIZPP/dbV1dOR5poju3Hc14XCnDqY4CxhiC1gkWLjWM6+Bj4LuDAA
 ABXCopNJo+g0U1cjBAI8C++nzPeorp1qTGrjpVPNJUsN22qmWJROw573uVcPQJoSmJzi
 8Dyg==
X-Gm-Message-State: AOJu0YwDEU7uoKAJ4qdroJeozj8idxFDnNs/ITAJNxcVPy+jvfpCeFTu
 9UXS+j+XHF8hoFi9d4V1pnOSWpHzCMNz/ZcX3+KGHhWkQ24p7NQwF6rs2uh3tz9DlA8LX6mY3Cj
 ljbzBZM3c4esWxMtjnFE4aqvwK5yelm28/O5aZtJR8HYhf4wLd78bAUbU+k4pmL2z4g==
X-Gm-Gg: AR+sD13CjFrQGwz5zWglX2tga4D7nC17j9wfurubxcE6bPK4cm70J3aPNkYDXZu5Mw3
 zj5OzX6fn1Bf6HVf+xXXOBJM+WyBhTzwnT1QIF/K7hmwk3rpl8AF3/TZpqo74L+ZM5eFDptfKs/
 BgobVp8aGjKa+cw0QKdlRbcrFkFIL87wdLTcSpwi+2eZgzju+z5litFUAtVANz/qGZ7tGtuAOWZ
 NLdv0eJHJWddEADcG/gfNsZfx45zVYPJOOp+q0hBxoQNJznyylT1zBwvWxX2CJZRD7qX0KtdSe/
 P8tYeZGegKUIjIXYHQNL88p2Uk6RtswiDFuWndr3FPQplYK+Ps+pQFhbvBtj6NZz452S0h8232U
 VUiMR5KNotPkRy8GG7npVqhqBw29zSrxxVjot1MRuRQ==
X-Received: by 2002:ac8:574a:0:b0:516:d781:589a with SMTP id
 d75a77b69052e-52d73d93483mr80959571cf.22.1786645003479; 
 Thu, 13 Aug 2026 11:16:43 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:516:d781:589a with SMTP id
 d75a77b69052e-52d73d93483mr80959031cf.22.1786645003075; 
 Thu, 13 Aug 2026 11:16:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c07d2sm1220943f8f.30.2026.08.13.11.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:16:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/16] cpus: Improvements around BQL locking,
 improving docstring
Date: Thu, 13 Aug 2026 20:16:23 +0200
Message-ID: <20260813181640.6537-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3TANmz2pHFayM2JRidx5JJnOWa1u4RQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXxWpEHNycS6Oy
 tMvNh5eTf3yRSLHwpf9z7tssdjE971damN06V24xfqX9AAFkKicAuxUeHAm65e1Jf7cOSOwsJ5i
 /WPkoXhkpaMaSLACLBPjQN+TrQKJRRRTq7035CegakR1v14iXMo0I/wouExmX/ze5Vv9gCo9+fq
 sf+nQGnp+qT6tlUFQ653XzTKmOroHxXH+yaWC8Qi7kEdmF58KbReDERG2xR0+XdSbNM3sCHZ2Zw
 F8uGfzRbcConjTpJm7NWcsvL9izfdlp6hk15OGZGbmyaM+L8iVlFYBmgx32VJX1UBF8RXm48+ar
 9N7zcn7Zr55W9IS6XGAY+Z7+WiZi6jMBTaP1eMu6FKRlkhur6n7xVKxrLmE4v9eICqSO6K5FsL0
 FCSfv6hgqpOfGf7/TP+7pah94+pA+Zbg2Y+6m998l8KWqzF5103A4T/GVsVt1VsNdgNq/aV6GLj
 nQJ94vsI3DSAqUvFHNg==
X-Proofpoint-ORIG-GUID: 3TANmz2pHFayM2JRidx5JJnOWa1u4RQp
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7e0a0c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=2yYdEO9dI-2tQnahI7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX4+12xcMT65vJ
 HyRl+7s7gdtP5ZkgfAVtYULY267Xd3r0taKX+hhBrBQd6U0uYOKzLe50monbcu6po2rGFVdipMx
 JKpIdVGQUKPYSJWTrBVSzjz4UXwJNFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
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

Hi,

While working on the hybrid-accelerator, I had to debug issues
with vCPU scheduling and BQL. This series contains patches I
wrote mostly as note for myself to better understand what was
going on. Please review carefully as I'm way out of my confort
zone...

Thanks,

Phil.

Philippe Mathieu-Daudé (16):
  accel: Label outer / inner vCPU execution loops
  cpus: Improve qemu_cpu_kick_self() docstring
  cpus: Rename cpu_stop_current() -> qemu_cpu_stop_self()
  cpus: Rename qemu_cpu_stop() to qemu_cpu_ack_stop_request()
  cpus: Improve cpu_pause() docstring
  cpus: Improve cpu_exit() docstring
  cpus: Document process_queued_cpu_work*() runs on current vCPU
  cpus: Slightly improve *run_on_cpu() docstrings
  accel/tcg: Use RUN_ON_CPU_NULL for tcg_commit() callbacks
  accel/kvm: Clarify use of @r variable in vcpu thread loop
  accel/kvm: Consistently return CPU halt state from
    process_async_events
  target/arm/hvf: Move flush_cpu_state() into the inner vCPU loop
  target/arm/hvf: Lock BQL outside of the vCPU inner execution loop
  target/i386/hvf: Lock BQL outside of the vCPU inner execution loop
  target/arm/powerctl: Move BQL assertions to async work context
  target/arm/whpx: Fix argument order typo in memory access error
    message

 include/hw/core/cpu.h             | 54 +++++++++++++++++++------------
 include/system/cpus.h             | 19 +++++++++--
 accel/dummy-cpus.c                |  1 +
 accel/hvf/hvf-accel-ops.c         |  1 +
 accel/kvm/kvm-accel-ops.c         | 10 +++---
 accel/kvm/kvm-all.c               |  1 +
 accel/mshv/mshv-all.c             |  2 ++
 accel/tcg/tcg-accel-ops-mttcg.c   |  1 +
 accel/whpx/whpx-accel-ops.c       |  1 +
 hw/ppc/spapr_rtas.c               |  2 +-
 system/cpus.c                     |  9 +++---
 system/physmem.c                  |  4 +--
 system/runstate.c                 |  6 ++--
 target/arm/arm-powerctl.c         |  9 +-----
 target/arm/hvf/hvf.c              | 16 +++++----
 target/arm/kvm.c                  |  2 +-
 target/arm/whpx/whpx-all.c        | 10 +++---
 target/i386/hvf/hvf.c             | 20 +++++++-----
 target/i386/nvmm/nvmm-accel-ops.c |  1 +
 target/i386/whpx/whpx-all.c       |  1 +
 target/riscv/kvm/kvm-cpu.c        |  2 +-
 21 files changed, 106 insertions(+), 66 deletions(-)

-- 
2.53.0


