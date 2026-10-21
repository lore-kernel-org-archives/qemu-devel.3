Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21069606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=okkdzdGA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NNuxp9xz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJb1k-0006b1-GL; Wed, 21 Oct 2026 14:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJb1i-0006aY-OY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:27:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJb1h-00012N-0r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:27:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpLw6454466
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzVIXiUlhstdslGDDYqh2i3kb8dGWvRpsiREFihiDrE=; b=okkdzdGArJZJkkDE
 mhr1qWWOn55rjkIl+FknOGamBbDFalJxos1P3kK6Lz8uW1I287vG4FHx1d23YfgV
 UzvHSd+hnVPaQ9A8u1def9yDuBDiG+HnriKB0DzbCfZRnK5DKryt3k/c9ZF8J7et
 hJ9IzD2KacwvPH3wfA4jRrKzDQe3InwNx4vc4WBM7I84wGqSA5DBz9JtEIGUa20a
 GZeQlLzpu9xQ2didxn8N9z8pEA2ktJRTdBFP/wQbBYz2wRW+OYZN7iXiI6YXAcTA
 NpBE1fRnHe3o8ARh4JCXWeZccxHf5qMXOBiqpaVoIE9ez5yONW8aM8napwaEDmXk
 hrX8gQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex589drb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:26:59 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-151ba226e1bso1785958c88.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792607218; x=1793212018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MzVIXiUlhstdslGDDYqh2i3kb8dGWvRpsiREFihiDrE=;
 b=NNuxp9xzJoK+XRHPUf+V4H0FfyPGo4V7GquUOHSfZ6BE9zn980LPcXuyvoq9DtjoFp
 BDj3OASSqc4J86efayRDzxbeXdt0uroi+Wn4FtBLOzaEAGZbrP+vvNMbWuhGha/bUrkc
 hHQBHiVj/FTyfu/Eq2WIhgz5sTM42Jg3phV7SSnOF0T2dUxPFo7gGVtafHnvWAgcy1gV
 FkW0xGEW8Izjtcps8TOc4t1yO4Yj9O7z+NeA15y12TQroUcSo10+DEAWnP4ljEMEA9X4
 pDW9Z/shubTQfrYbL+1yqTy3tGNcQaC0WpP+5u5Nr15rO3fbpHhbcPLsUL2pFJVEHsGE
 cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607218; x=1793212018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzVIXiUlhstdslGDDYqh2i3kb8dGWvRpsiREFihiDrE=;
 b=rYcJkSprQjDK/XA+lqScyCr13xpIU4n5M0yQKrClbSwes8xptST9n0ZY2BGesxc2uH
 YlFpY2JmIfEe7k50EQQIoZJXBcIl6NjG/H+qfB4klVMmRLg45qw19qMv9xcHQ+VMrIQ5
 /2x5o36N0WZVSvAV2Z2lWyWtmQQjioyquKdJ8l0RbtnAvjaNA4BRBfh5fjSrwDi6c2Ih
 pb9gh22uEdU4T2mFLh/44TBSzsK260Q5+z4VGuLFBKmSyJjsxdPlivq4FlejacRSRqit
 0qLJnkx53WyAVXufv66PDkVyRhRUHZEhKP6SirmOooFyRdFuIf08WS5Z/r1QK2t4XWWv
 ZSvA==
X-Gm-Message-State: AFq9FYIYC6JADF5RkDBMN94FfsU4NU1tOMWCV+E10ih2qM4XWBpSz4gF
 E2xHqqmL83LHp8WVx4PmFLcMXJsgfwTaN1ENdVEbOGO0zIS6yyaMvIwZH9CdctditbUiU30uwjG
 7JBDl6G5UC2CSsvQxM5zgf+3m3Hkx2dXi8YlgYGGlJTEV5o+RC1QripTwcaaKtj3WFA==
X-Gm-Gg: AYBFou2xw2haVBeE/YtXo2wRqGI8b3z41yY0LIqkkoR+tvhdix7tzWEwPMPdHIx3VbW
 GqmfpzOawdVZsCpOTXkteUlyPqDCG753Jfw0p8I7CI8EWD6O81E+A2lbjG6Ko8R19ublkE7c8Su
 WpnHXt03AEBlS1pgaKG15+PmTI+YOwfXxhVXwmdh1N6/Esf71/yrVCunFekfd5Fxm2KqnLEOgIA
 GvHVMdLM3jBwvJ6N/9+Aabw6P0a0Wa8p7TCVY9EYbI1h8JSJ0gzQ77J7YY16I2h+WGh9drpZ5XN
 3U7phwD3KfbYSiNrdyrjGbWBO+wbqMnCQUMj3Q7uxyW1/oQo0VbEFPNVG9BZEgBNB9rIwJe1aCB
 4WTRPK7jkCw3pQCltSAY3YuzHDtw6qT+sxskwE083dC4RV2og5PXs9Wg7ZfNrXx6355SWYg==
X-Received: by 2002:a05:701b:2806:b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-190a0428c2cmr3321337c88.3.1792607218146; 
 Wed, 21 Oct 2026 11:26:58 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-190a0428c2cmr3321306c88.3.1792607217439; 
 Wed, 21 Oct 2026 11:26:57 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36741f753f7sm9052719eec.27.2026.10.21.11.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:26:56 -0700 (PDT)
Message-ID: <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:26:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX02QY2G/xSSYc
 KJvoQuYC0PeRf9wAtomQN6+jJAr7Wf/l1FKPDWYVPfwWa5ZQAnZcrYDISntsxYqlpDAaNE4uxJ0
 LEo+E/GTPXbYOSG5X3yGEmRMWjO6Kgw=
X-Proofpoint-GUID: 3W9eeHHUBuMoGNuZjQnkj9nXDgNCWMmf
X-Proofpoint-ORIG-GUID: 3W9eeHHUBuMoGNuZjQnkj9nXDgNCWMmf
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad903f3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QNtHADRA2rtuJ4AbM9cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfXwcnhbWX6Myz9
 nKSDO9rX5D9qdonOLtR645PMqrfH8nMI/HmKDO6ceBl4ekZ7mw4/gYZPIDXJg0qyAfjDzV+gW08
 16QVEx5t1kh1/3DxwC7GkKl+rYYJP3v5WprxN1L77ZgqaKH5ZO5LRgATWfUGbh0zPUtcAon8lB4
 o4QFhdX4JXygrZ20MhB/uennEhuKF7Zab1NRipuLBg+Vi40Z2BFAWOQ31WzPMGgRpHjkk6cDae/
 Xa2MjDal5oG0rlQAXEE7HeGhEktXzoH/NzOnozg/eThHP1VcyEh5Gj8JPllK63EKbZIy50ssqNv
 TK0LoYmdOObBLHgU0GwlTlsoCaEdMEzGLwD+85f+x6sLLTg17mYgzpk1VhqxaS17CUq53uYHtmN
 zuwxxMUVre9Hub0nmPnAvzxmXcMGcTwkgBvYPaqHSX2E1K91DxowVmGzwNTEG6LxJy4eh7hwoJW
 rynWe5SN4H3jg5uWHJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/2026 4:22 PM, Pierrick Bouvier wrote:
> This series adds this target to set of multi-target.
> Changes are straightforward: functions and helpers renaming, and one type
> restriction for this target only.
> 
> While the series applies cleanly, it will need those additional two series to
> build multi-target test binary:
> 
> - Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
> "multi-target: remove dump functions duplication"
> - Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
> "multi-target: remove qmp_query_cpu_model_expansion duplication"
> 
> Usually I prefer to wait for series to be merged, but I have good hope to catch
> the freeze date if current series is reviewed, and send all three at once.
> 
> v2
> --
> 
> - make virt machine only available for riscv targets
> - enhance multi-target test to detect duplicated types between all targets (we
>   missed the virt machine since we were always picking the first target avail)
> - add an additional commit with the rest of softmmu commented for future work
> 
> Pierrick Bouvier (9):
>   target-info: add target_base_riscv
>   hw/riscv/virt: make machine available for riscv targets only
>   test/unit/multi-target: check QOM types can be initialized with any
>     target
>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>   target/riscv: prefix helpers conflicting with other arch
>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
>   meson.build: add riscv64-softmmu to multi-target
>   meson.build: list all remaining softmmu targets as comments
> 
>  hw/riscv/virt-acpi-build.c                    |  2 +-
>  hw/riscv/virt.c                               | 14 ++++----
>  include/hw/riscv/virt.h                       |  3 +-
>  include/qemu/target-info.h                    |  7 ++++
>  meson.build                                   | 18 ++++++++++
>  target-info.c                                 | 11 ++++++
>  target/riscv/helper.h                         | 24 ++++++-------
>  target/riscv/tcg/bitmanip_helper.c            |  4 +--
>  target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
>  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
>  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
>  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
>  target/riscv/tcg/op_helper.c                  |  4 +--
>  target/riscv/tcg/tcg-cpu.c                    |  1 +
>  target/riscv/tcg/translate.c                  |  4 +--
>  tests/unit/test-multi-target.c                | 34 ++++++++++++++-----
>  19 files changed, 113 insertions(+), 57 deletions(-)
> 

Except if there are specific comments, I'll send it as a PR tomorrow,
with the two companions based-on series, and with the current helper
renaming, as there was no comment on general helper renaming. Helpers
renaming can be reverted as part of general helper series.

Regards,
Pierrick

