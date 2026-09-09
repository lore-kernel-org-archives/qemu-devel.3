Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115BDC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PEs-0004EI-Fx; Wed, 09 Sep 2026 16:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PEl-0004AP-QL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:49:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PEj-00053R-EN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:49:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JI7wx2896197
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 20:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9LTa7ZqnCfcxe2A1k2KyaoI364ha3WHTvARZ/wYwA80=; b=L9kLd8xO7x/XjBO3
 O35Yl0ZqKt3MstcDUODzNJTMMNApi+Z9NPsVNHDjEfkxALsWLwSr1Yv5aMJN8U7y
 DjNdCoxD1+XA1N66mq4CM7EnPsj4R3c3poFn4eegIuVi3ev/GSrFX4wAW/IVohvG
 1G/Dqjh5C0whADxxra2ptU6Yc2vPKe0obCmD2WowtCgYxnUT2m4QpJ4ZVyAFDS0y
 iBfsN2xqbq9jydLAvwc85YqcEkk2UjXNmWN78z1v9l5rlHNN1w4VGAFWmYqjQ/lb
 EPg3A2DqCRKyRLWxasUn8oFezR0zsMhpMPedkQS7zSk11XH5WbHbBgYyozGeXSxT
 3i3YPQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcygrgqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 20:49:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e80ce3597so112190996d6.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788986967; x=1789591767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9LTa7ZqnCfcxe2A1k2KyaoI364ha3WHTvARZ/wYwA80=;
 b=VyXCfT2WXF13ldcS/fQeYrPRTcNill8ndsnEme8+WjMNlOaf0NVuHepMarNaDxqgOw
 3z/30gPxkBkyZOnpAxO0uZez+QbLwtLjSgaSfLwwIZWf09wyqe9HBKg4XZ+Nu/502RrU
 oFYybun3HvlUQTzNQgFXYQy8fv0uANHKGCmljgIQ2S2SkD6i0b05ZVtdoV8lWYPAjP7D
 9tXngAnHSummUIzxoQb5TGdhLD7TsF3k0sfsR0ZjLsMNghahphpY/n1eipLRhXP7MYaR
 0ENC+3v6cVKU6ZdibO1k6CS9zmpCWSm+gpq1RXc9qKUHxfEMgRUgcjAllfj0CiYj6Qlg
 e3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986967; x=1789591767;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LTa7ZqnCfcxe2A1k2KyaoI364ha3WHTvARZ/wYwA80=;
 b=Xp4b4f/uNEbkPcppLONvzfG1/eCBovKzFfWtxMCXMJVEalPuK2FgYNspuulEoYVyjM
 2j+94cHdFKkFWHI0ZCWgNxzKIatKNz5CVI5dSJRBpMb9Qv5Y7gPnra28fYE7akEkcsZp
 AL4d+rD2o0O7gEh0ycE3L3A++hoiZhfZnJgQ6w9+LyjQoOEbj5LwTlFWUeOvGLBIcKXe
 iBFzLJZN0ZX2guo8Un2mi6LPkgdJ6H1DYlMqbFUy/NccMdH9unilkNvp+kDGmE3bMZub
 YkTFbGAtkg3jnMi3g9kdNKqh+ie00E3rRpRzLs8AjLzSjubTGwrB7pITx+8MxwPhiQn2
 QOXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvQGKew2tAtm2O36JENoPfRWPbahQtcwUTUQbNB/4aP7eFEDo4EHvYO/+QpRHoTVb620VQ+EqVigKk@nongnu.org
X-Gm-Message-State: AFuF++lf0a1FUp0nDUPi7wtE6HcX4i8kn/Ok/euZcspl6c9HjRnARWxl
 p6L9bv9utfLY6t4ljw+ojwRTxQRsOCWGW4fC6nT7AGAGP2kFyGGB+rqcDdHMaSdvIKDf2eYP+tY
 LxRlgOqlMd5RkahUJ5y73wUXxSixOyLJZKQBsPCGLYjLVhWfOw+vdZLTSMQ==
X-Gm-Gg: AYBFou24PaZRaXUcmfLctmTUYSvC+aNyHgbMDSyLJrIYqaQz5Q4wFVYr1TA/B8QFdkG
 b0NjGxze/oQaa8z9rozzvJojP7Hxm81gI5L/gQ2s5nR1wHzxB7FeRYLCcg8iO2lbN0YEq/xEyLB
 43Ac6GJ6xDA8VzxSpN6+2h0dIPbYOPelSV3vQVgKzR+rBz6LjcQXQp1NbHXrBRTH5QA2HlnAkgx
 DaZyP3Mv+dXVwiBDz4Nu3fALcKGJKhIyhPT1XSUmLFAQRZr+84tdt+CIVFUCzQDIaS0S0n+xbND
 8PvSjMYDnq76G5Dzacsxq7r/3OdMPNDyK4FMbhAXq+iuBQPML/Vhs8jt3yLvu/vZ9U5B0Lb24Ht
 fHC5iU/TP4UUXc/PhliuRcydF8oZTr0sN0gQ=
X-Received: by 2002:a05:6214:858d:10b0:910:3451:b181 with SMTP id
 6a1803df08f44-9103efd4489mr33418036d6.34.1788986966677; 
 Wed, 09 Sep 2026 13:49:26 -0700 (PDT)
X-Received: by 2002:a05:6214:858d:10b0:910:3451:b181 with SMTP id
 6a1803df08f44-9103efd4489mr33417236d6.34.1788986965877; 
 Wed, 09 Sep 2026 13:49:25 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9104fc73ea5sm105336696d6.39.2026.09.09.13.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 13:49:25 -0700 (PDT)
Message-ID: <083828b1-5847-4fb7-8872-725dac0c2f1a@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:49:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] RISC-V TCG PMU correctness fixes
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzMyBTYWx0ZWRfX1jab48PlMvdP
 eT7mfJ1ziMHLx4qjwNOl2cHBnbNYEM+YMKUA5VIUrwmNU4XSFTmEVHJy+VVDvkGqXgGjHrFBBeZ
 eeIr2T15DFltzLZHnC5EN2n2THPDrcnF4ZguTwHUm+Qhw72tzWWdapoelh3QpOQwe+jXNhXqLxZ
 JUz19ssPt+AR9iV3shzeP8Wm0AoVnyMlf5GoI8Fek+URgvVEOqAu1D74Y9fdmAzIt96+E2gLL2x
 +nHHVWytnKiXpfwCBDYdy3L2WWEbdui2kKzUFrgqNRFT5HjT0K5NDn3AUUAcVcN1g4vrjcDBHWW
 VAabDVuYVIhqUEICfZIaD7ycyg6mdYquXk9dH5tpuw+SM67EBMapdgwTC67zFvad/PdiKLWm+Xf
 qoEfeweKAxGymIoo4qsiNCvIiaKUjoAIqYNTxeozB8BpizJrtUOSU4PxvwCW2yPcLwUso7B8Acg
 iLX094RJO7u3OmW8M3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzMyBTYWx0ZWRfX7vp2Ax+UDLjs
 B3LHALzY5B2wQETWjtZcU7gxhN2Toc+/KFPaaTX2ukgcd47GUM0NU+z9lPkwydIrvwK/sO4Bzw7
 rKBXGC2q1fi1u4UVaYgHoRZRz1sgrTk=
X-Proofpoint-ORIG-GUID: VrYge05iacrAHy-pkTvjjhtLzITcAtUK
X-Authority-Analysis: v=2.4 cv=VONIDNPX c=1 sm=1 tr=0 ts=6aa1c65d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=X6rMypcUmwSNIqAgvc8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: VrYge05iacrAHy-pkTvjjhtLzITcAtUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Tang,


I took a look in all patches and they all look LGTM code-wise.  But seems
like we need a new version of all patches rebased on top of a recent
master, using a new meson framework instead of Makefile, otherwise check-tcg
won't be able to run them.  In theory is as simple as adding entries in
tests/tcg/riscv32/system/meson.build and tests/tcg/riscv64/system/meson.build
instead of Makefile.softmmu-target.

Given that the series is based on the v1 of "target/riscv: fix RV32 fixed counter
accesses"  I believe you can re-send v2 based on the new version Zephyr Li
sent:

[PATCH v2] target/riscv: fix RV32 fixed counter accesses

This v2 has additional scaffolding for meson tcg tests for riscv32.  Might as well
use it to rebase this work.


Thanks,
Daniel


On 9/6/2026 1:37 PM, TANG Tiancheng wrote:
> This series fixes RISC-V TCG PMU accounting, overflow notification, and
> migration. It is based on Zephyr Li's "target/riscv: fix RV32 fixed
> counter accesses" [1], which is a prerequisite and is not included here.
> 
> The patches allow multiple HPM counters to select the same event and
> preserve counts across selector, privilege-filter, and inhibit writes.
> They use consistent cycle/instruction sources and compute the shared
> overflow deadline from all eligible counters. Timer callbacks queue
> checks on the owner vCPU instead of racing MTTCG execution.
> 
> Migration saves counter values including pending increments and restores
> destination-local source baselines, event mappings, and overflow
> scheduling. A new cpu/pmu-fixed subsection carries mcyclecfg/minstretcfg
> and identifies this format. All TCG CPUs require the subsection; loading
> older TCG streams without it is rejected. Source and destination still
> need compatible CPU configurations. KVM PMU migration is unchanged.
> 
> The reset changes preserve the final counts in the old privilege/V mode
> before entering M-mode with V=0.
> 
> TCG tests cover RV32/RV64 counter accesses, delegated registers, selector
> and filter changes, multiple counters per event, overflow notification
> with and without Sscofpmf, instruction exceptions, and reset. The RV32
> HPM tests also cover full-width accesses through the shared counter path.
> 
> [1] https://lore.kernel.org/qemu-devel/20260905092810.660-1-fritchleybohrer@gmail.com/
> Based-on: <20260905092810.660-1-fritchleybohrer@gmail.com>
> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---
> TANG Tiancheng (14):
>        target/riscv: Preserve PMU state across event selector writes
>        target/riscv: Support multiple counters per PMU event
>        target/riscv: Use VM-elapsed sources for fixed PMU events
>        target/riscv: Preserve MINH on delegated config reads
>        target/riscv: Preserve minstretcfgh on RV32 minstretcfg writes
>        target/riscv: Fix RV32 accesses to delegated PMU registers
>        target/riscv: Preserve fixed counters across PMU state changes
>        target/riscv: Require Sscofpmf for non-fixed event overflow
>        target/riscv: Rebuild fixed-event PMU overflow deadlines
>        target/riscv: Apply minstret exception accounting to HPM counters
>        target/riscv: Process PMU timer expiry on the owner vCPU
>        target/riscv: Migrate fixed PMU counter state
>        target/riscv: Clear virtualization mode on reset
>        target/riscv: Preserve fixed PMU state across reset
> 
>   system/cpu-timers.c                         |   4 +-
>   system/cpus.c                               |   6 +-
>   target/riscv/cpu.c                          |  17 +
>   target/riscv/cpu.h                          |  14 +-
>   target/riscv/machine.c                      |  92 +++-
>   target/riscv/tcg/cpu_helper.c               |   2 +
>   target/riscv/tcg/csr.c                      | 281 +++-------
>   target/riscv/tcg/pmu.c                      | 793 +++++++++++++++++++---------
>   target/riscv/tcg/pmu.h                      |  29 +-
>   target/riscv/tcg/tcg-cpu.c                  |  10 +
>   tests/tcg/riscv32/Makefile.softmmu-target   |  42 ++
>   tests/tcg/riscv32/pmu-fixed-rv32.S          |  90 ++++
>   tests/tcg/riscv32/pmu-minstretcfg-rv32.S    |  48 ++
>   tests/tcg/riscv32/smcdeleg-counter-rv32.S   |  84 +++
>   tests/tcg/riscv32/smcdeleg-event-rv32.S     |  69 +++
>   tests/tcg/riscv32/smcdeleg-minh-rv32.S      |  70 +++
>   tests/tcg/riscv32/sscofpmf-event-rv32.S     |  91 ++++
>   tests/tcg/riscv64/Makefile.softmmu-target   |  63 ++-
>   tests/tcg/riscv64/pmu-cycle-controls.S      | 104 ++++
>   tests/tcg/riscv64/pmu-lpad.S                |  69 +++
>   tests/tcg/riscv64/pmu-reset-vs.S            | 102 ++++
>   tests/tcg/riscv64/smcdeleg-minh.S           |  70 +++
>   tests/tcg/riscv64/smcdeleg-sxl32.S          | 219 ++++++++
>   tests/tcg/riscv64/sscofpmf-cycle-overflow.S |  58 ++
>   tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++
>   tests/tcg/riscv64/sscofpmf-overflow.S       | 134 +++++
>   tests/tcg/riscv64/test-minstret-ecall.S     |  26 +
>   27 files changed, 2223 insertions(+), 467 deletions(-)
> ---
> base-commit: b23a62773a7856299cbb3782e64968b6a92c792f
> change-id: 20260827-riscv-pmu-correctness-fa880fd9c48d
> prerequisite-message-id: <20260905092810.660-1-fritchleybohrer@gmail.com>
> prerequisite-patch-id: 3dfb379e910f47acaa9e94ac5766045f86e76799
> 
> Best regards,


