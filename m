Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6670CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgWp-0002EI-5e; Thu, 28 May 2026 15:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgWn-0002DR-Cn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:36:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgWl-0004vh-6x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:36:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGqeAq3545335
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4p0Mt7RpT5EEvm21fb7YUny775Q8OF/TNxHs7MQ84I0=; b=VcbEyy/T3BaV/vhD
 m+iE6cKn4a3sDXpBD184YZD+pHteSgjNtVKN4Z8GF1JzJ3ZBvVlpBUgFkLxkccB0
 qaDX5F6aBC+hmzmjnPJQYUmtLMJif1sL2t0kKzWb6PLwQ7o/56GIRUtZwe6+cbEd
 axyzpojpRQEGSFH4GvB3Qad8SAJy2CsI4S/H6o4wQiSCzxamzJaW+5u+Oajr3Ccq
 ctM9nbcrcYuFBG5PwgrXrPWmcKqJXE6U4K2E6YGk+MCodhH23mbGXXRlkPr16tXD
 fra7Y7gVW67Yaw828pBzCBQTlpUq34LlfhGOT1hvbibLf3mjlWI7CLdq8NJAgRxI
 IIkhcg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3vg51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:36:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdd327d970so8078931eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996981; x=1780601781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4p0Mt7RpT5EEvm21fb7YUny775Q8OF/TNxHs7MQ84I0=;
 b=RBaaECk97bgSg991meyNAtp7pvQFMJzlnIjRLb6NWXSYZhNO2+cwPYBg8ZTMzsoi9y
 ur3VjEqAYYp9Q0CYE4nIFOCCzjQiyookwd8nFA+N0Bpjfh8GkKDIJZwsxnv6qs6iOO4D
 DSOrjJqfABv3LB+0dAk/qwrhopZMHStJjH8GbfysoEugoIYJgqJ268kTTAEto8/JJj7/
 jtlylNN2ueesNzYhz2Mr6CFgI0pbDT9K0YebIfZk5LtjQtbI3F5AA2H/C7YnDRQgrkIv
 RLnl4l5TmSp4XjJIy+a8Db5zAypUhK7GjYWPwkFLw4Y12wcL0Qesmm5Vw4tdlMsN/stP
 97Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996981; x=1780601781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4p0Mt7RpT5EEvm21fb7YUny775Q8OF/TNxHs7MQ84I0=;
 b=a7pr0GNIqpgckcDtFRVb6L3l7jBSN2afXhog6PlV4QUdUfeL+XAJOsQNA5CserhP0J
 1rZBJKJA+njgOErJteyPGXp2PzVOLkziRUNyBOBhrOhQYhshhRv5PslaY7xoQQH0WJVq
 bTY4VIWfbsNR8CMJLKqwlzdCDi2R6NRTDlwID6L0BGdXsp/RonyWyaZmWHdzx2YRvmj9
 JXyUGJOJ0nX/ZpPVMYA+kFsdsXa6/JTP92M0VNxQY5PmVMd5tbe7pGZkaAPkVbLYDv2T
 7FIgCtUpllqcaV8yBYtYax1xSn8dBoYXc17wXJZAez0eKQgFAkk8Cvs1yVxZQRExEm4B
 OKEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ810QxDUG3Jcaldk+4Aqolxny7a+hGZXUkNhFvGH9lcfTHHoJnCXo/Lr5K1a0ytP94JYT045ETlNVxo@nongnu.org
X-Gm-Message-State: AOJu0Yxy1l7CD0xaxMeas5OQrEyV2UvDCcIWim7sMq3+8JBI4R2JeubR
 yH5WR0mKOhvyE2DjHeJ0COKBuWSuuUeOxDTaG+DqRu744MI6uKrCU3n/jybuK4gE10kFT2e+ocG
 D9rcycy59AwxbuDHAdKF4fIoivs4EnCP7TdTnKNL/aAtNFQeaBHkpAXOsGA==
X-Gm-Gg: Acq92OEpBbmsQLn3NFcx+xvscLEY2CCsntoN4lv/37TU1dXiSpcFZzcCU8u92kqK9Xd
 CoIe2OulVfpiZnX8ujm8CL47gNXsLvbELCbfFnMQfyBmWUlVWS/vwOOWIDT7JFZef90Bh4T2cFG
 ota18eGk5wc8PAtzClOR1yX06YI41aP8HvzVIEAO8va0Bd7Zs+MpS56gKf6f10UlMo4werxTT+R
 tq/7ZxwoxFmirs5hQQWGGqoT2SoBXq9O+f1MKBHRP9qMDVpV/OemG53aP9iFDVwFoU2LIV3W1K2
 ImJDWFpaI04c+Ak0/CDGongRdXZY/5w8f1s9pe39i7C/SyuBiawPd8AI/Ah9n72Aeofk/i6Oq3B
 rCpSAmzUDhk0Hzj4gVxFLwnpQIQAsZxAH1Y9LRYDjY9m4TlP0MuCFy55xKyNWu4eP0s2km+8ywA
 /w22Y2ftKFAEpEjEJM0rF8LNcb
X-Received: by 2002:a05:7300:aca3:b0:304:d600:8731 with SMTP id
 5a478bee46e88-304ea74619bmr12065eec.15.1779996980836; 
 Thu, 28 May 2026 12:36:20 -0700 (PDT)
X-Received: by 2002:a05:7300:aca3:b0:304:d600:8731 with SMTP id
 5a478bee46e88-304ea74619bmr12046eec.15.1779996980162; 
 Thu, 28 May 2026 12:36:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c7969sm127476eec.14.2026.05.28.12.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:36:19 -0700 (PDT)
Message-ID: <163e423e-a31b-47a4-a7af-a446a3b89fee@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:36:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/12] Add RISC-V big-endian target support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1zrCYCXuLMo7vawRkWYbDcDXDyfqJiXq
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a189935 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=gm80Tucwmrem-aL_JdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 1zrCYCXuLMo7vawRkWYbDcDXDyfqJiXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5OCBTYWx0ZWRfX/7xKsWz/aEzo
 TpOLUmsZycsGd53ChgLloGHJYUsIEqKil/zljVkyRxmaGmZUE/9Yblz/I2Vpsg+Nrc4+Lc21vos
 YzEfAyxtx6f1RHRSGGzDfVPIamSjgEMnkJaW9D9BSLG98I287j5U316D3tkPMl4SPxgDqZ1oXGn
 zsHN0EyyGk3acuDLwNgJ4bPqFqUvq7gE97cfM5cFIsxvSoIhd4TxTh1valzNzANJu51QCI2o+5d
 OARaEqQeA5RMNkywLrkzCHb1egiCYG3FgxTx0/LnTNsPWuWgkYlPijacB3GKvvq74b62Leld4Qt
 RaMoKBGBxYAlYXjpKlJMG+SYZjEXxITpeacqQLbju+DTgWZgGc7HhHWgnrMbJuCzFqODkcxgZpF
 Ci8BLYxIvCTZSh+Z+CU0/nreafGsm01TdtDeOa/zVMizbK0BHsNKPrt/owkSzyMfVwjXIa9hl3X
 F+Dg0c4quCtwb/s+ybA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> v11:
> - rewrite some patches while reviewing for mainstream integration
> 
> v10 cover from Djordje:
> 
> Hi all,
> 
> This series adds big-endian data support for RISC-V system emulation.
> 
> Following the discussion on previous versions, this series models
> fixed-endian harts, not a mixed-endian implementation where software can
> toggle MBE/SBE/UBE at runtime. The reset value of MBE/SBE/UBE is selected
> from the CPU configuration. These bits remain outside the
> mstatus/mstatush/sstatus writable masks, so they are effectively hardwired
> to 0 for the default little-endian CPUs and to 1 when `big-endian=on`.
> 
> The user-visible `big-endian` CPU property is exposed only after the data
> path, boot path, and page-table walk support are in place, so the series
> remains bisectable.
> 
> Djordje Todorovic (6):
>   target/riscv: Implement runtime data endianness via MSTATUS bits
>   target/riscv: Fix page table walk endianness for big-endian harts
>   target/riscv: Add big-endian CPU configuration field and reset logic
>   hw/riscv/boot: Honour data endianness
>   target/riscv: Expose and document the CPU 'big-endian' property
>   tests/functional: Add RISC-V endianness test
> 
> Philippe Mathieu-Daudé (6):
>   target/riscv: Initialize DisasContext::mo_endian once
>   target/riscv: Assert PTE.N/PBMT bits are not expected on RV32
>   target/riscv: De-indent some code in get_physical_address()
>   target/riscv: Remove target_ulong use in get_physical_address()
>   hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
>   hw/riscv/boot: Replace cpu_to_le32() -> const_le32()
> 
>  docs/system/target-riscv.rst                  | 29 ++++++
>  target/riscv/cpu.h                            |  1 +
>  target/riscv/internals.h                      | 29 ++++--
>  target/riscv/cpu_cfg_fields.h.inc             |  1 +
>  hw/riscv/boot.c                               | 93 ++++++++++---------
>  target/riscv/cpu.c                            | 15 ++-
>  target/riscv/cpu_helper.c                     | 44 +++++----
>  target/riscv/tcg/tcg-cpu.c                    |  2 +
>  target/riscv/translate.c                      | 22 ++---
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
>  target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>  target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
>  target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
>  tests/functional/riscv64/meson.build          |  1 +
>  tests/functional/riscv64/test_endianness.py   | 57 ++++++++++++
>  23 files changed, 240 insertions(+), 122 deletions(-)
>  create mode 100644 tests/functional/riscv64/test_endianness.py
> 

Seems there are some build failures:
https://github.com/p-b-o/qemu-ci/actions/runs/26537039673

Regards,
Pierrick

