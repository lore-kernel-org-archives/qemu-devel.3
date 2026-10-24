Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CjYrtKjc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NyNEdogC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV5O-00069e-V7; Sat, 24 Oct 2026 02:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV56-0005pE-Uh
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:18:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV54-0004d0-PO
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:18:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3Z9QQ530311
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DtNai4iru49VuTlgw1AWjb+JCx+CbjlTTNkJMxWD/Mc=; b=CjYrtKjc7zb8Buy4
 gd2QbjmCMLHrOY6CimIfluikmIycpujr9RLWjtD7IZbVUb4ygSAcgJD8IBN8ggZj
 t4tspkpr9//cXHais7CflA0739nRvQlpNKH+0drncB44qFG7IHRgurpQKjky7zLk
 4t5d0H1YPN2UsiaXfGdj2tp9lYwZONojSQeyp1WmQ6937ocik0dNy5zGCfobSNfh
 b1emisaHr5LBcIebAmI51kdM1B8IiJM0BDP1eqBFBFP5wfvDTigsUfED0ZSGNBif
 AIPDK8Fa1iR9fgONy7t4G8hkYxiWJ9kstq3QIN0s6HoVNFIHnq/Xz06pMro5qTl4
 EITcgQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3g9e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:18:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so2021896a91.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822690; x=1793427490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DtNai4iru49VuTlgw1AWjb+JCx+CbjlTTNkJMxWD/Mc=;
 b=NyNEdogCNSHeFVBRN8tmneMiAEI5YTh9LB7cD/eddZJyFq3fE9I5vWX+sRiUP3dpsO
 mRJ8JZEBiDAia6EG9XW83Fd9ZEvyKX8rscUIkHrtexP8HGd5+9MFpZ8oEol/k9IBfb+a
 AaECm6RJVbelV5ha2lwEDxLyuxyd4EGVNRBwsT5zkWlrAaGuMm3JV59yKurovG6R5V0D
 kJDPnshdqTNA+QeZ1PBiXkHGHixbFXDSK54EQEoDqFqB94cWCm0VJrqzS+kBsjpBHadk
 VLeUBniP3uEEfqpJxoy1JRIBZ+codLE4vXnyn6XyOU3cY1b5I/dEPuZ/hEJl/WesivcH
 3Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822690; x=1793427490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtNai4iru49VuTlgw1AWjb+JCx+CbjlTTNkJMxWD/Mc=;
 b=EZymzaSCV9sfXeR78SwwZ8DsOpaeWIFuC369TTbkCqT2pO1HgWL3MMRL5Qvz4+Jwjp
 nB08XeMGpkNZvTX+p8lMQJEcFLxHspkfdAnYtV+W3mr+b7CyJDQTKBfogVCwjCMP/syF
 ASb13PX9IVFihuncZYgNIj2yJPrATExz9+9gNAgbUC2U6ocfRfF0BwbDLCcVybohynwv
 XBMVFkudyNNjaX5B/OWhNQknRGc9auzvU8ZcyOu3hrNEoFPPvp7zdN0O+CrfDqRcvxeQ
 l1afJMkgmNMf/V6UulFjGU0ibxFEXblOhl+1cZ+IIVkdyuOw8DyyP1t4cQm4xVp3gOV2
 y4Ww==
X-Gm-Message-State: AFq9FYIjLGS5B6PMfKa4BQXDxo+Nrpq6n23vJ0sH8xv05lwURYKIcdHD
 BmFszsU0kTLkuxsi8fFIUho0OMVNvSXg//zQvKrho0q4NAGKpd5SHJ5vMGqCsAzs87293d1I4su
 +hVy7GY8nLiEfiCgmN42+vfEEuE8qupdqYgQtQzsxEUK4K0DmB0IbJIknDpWjIdQgSg==
X-Gm-Gg: AYBFou2CipxFzc4/RigzwxQwMhkJJMDWz1YtEjffehD2BDLcLgJ0Upe8k2xqH1nUMdR
 k/Sy0CRAskFjOIEDpsyQtH/l148yOjgqZ+mkGu+gH9AYu5a5QOJ4speycawrikt5f9Kq/L9c57f
 xpDMnhcTK27GNgzJw4JEnVelYDSdIITlDePFooqvF1d65wLjmJUtcZAs5MWLx6BiK+D7WJszJJX
 iMXLvPnJCfvLlRgpxmDQpbJigA6rHZmMnKZVEgoO58chOt5kKsQ1Rx+JpBOnYoZ1BBc08DRg/aM
 DDn3mcU0l+PPBPf3qrlt0lNbFWP/nj/+4mcFr/6qdZ3dwM7V5s1igCqIQLUcu8sfUR4+cHeurfb
 6k7NfZdaz4vn+fWKlI/TQ7xyvIA1+wF4PImK5haqYYuBpYvpW1D4DZg7p
X-Received: by 2002:a17:90a:d885:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3adeb5a5749mr656722a91.20.1792822690248; 
 Fri, 23 Oct 2026 23:18:10 -0700 (PDT)
X-Received: by 2002:a17:90a:d885:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3adeb5a5749mr656718a91.20.1792822689751; 
 Fri, 23 Oct 2026 23:18:09 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe9078asm1677428a91.10.2026.10.23.23.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 23:18:08 -0700 (PDT)
Message-ID: <fc101930-5bb5-434f-8994-42a99d136fa7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 23:18:08 -0700
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k0UTDjjc-0ddTvWPh0O6xCBtVPbsNwWa
X-Proofpoint-ORIG-GUID: k0UTDjjc-0ddTvWPh0O6xCBtVPbsNwWa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfXxAEnfTohCUkM
 sLnIFlNxbFyYoG9sMCtm3WpHk/2SpZwSmDCsPOL47SrjGd5hyHQu+EeeGabdJgYcHNrrwYUmO+n
 m799R/vVDLSFI6utZYHKKSsTn5Sh1/I=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc4da3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3L8PxQU4OuXOupvEXQoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX7qJjdywnhJ1L
 xLBC7P1tOuQcBb9a9yoNv8OYD4XhADEI4dpEsxTcIOTa1MjOgE+wVwr3Rt+ujlfZpE32lQO7wKe
 rhWP4+5Sh7dVmI7wHkuqKT70ylmOt60dYCVBkneW/veB9QROVYPcVNVBGgjnkJNVRTNRAs8bXIa
 /1qKA+6b6eBPjMjen9rePLM7ic6eD7YMpTHeU2nVECnX1++YizD9JSCXHFfk6yYbT+PpNDH/Nic
 NZhrdlT6Veefyl40116v4pYY0oV9uGAGFk2u9ufmIGEltJWaI1nCSfuv5uPhoCSIfnAeKJ5kQN6
 vsNSAhHpKpoyfDlK3ndrFgVu8ztsWk9S4bu2GimMT+siRS7dD+5tEy71XqhRJtv0JHelVMxIir5
 bS+dPeGsAy711KF1DhdsUafCOmz2bqtc637BQNH6DEUX8u5vscWooBQV1a9FgUDoTwD0u2neMA4
 VHc4NOKevFT++Y42VTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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

On 10/16/26 4:22 PM, Pierrick Bouvier wrote:
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
>    missed the virt machine since we were always picking the first target avail)
> - add an additional commit with the rest of softmmu commented for future work
> 
> Pierrick Bouvier (9):
>    target-info: add target_base_riscv
>    hw/riscv/virt: make machine available for riscv targets only
>    test/unit/multi-target: check QOM types can be initialized with any
>      target
>    hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
>    target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>    target/riscv: prefix helpers conflicting with other arch
>    target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
>    meson.build: add riscv64-softmmu to multi-target
>    meson.build: list all remaining softmmu targets as comments
> 
>   hw/riscv/virt-acpi-build.c                    |  2 +-
>   hw/riscv/virt.c                               | 14 ++++----
>   include/hw/riscv/virt.h                       |  3 +-
>   include/qemu/target-info.h                    |  7 ++++
>   meson.build                                   | 18 ++++++++++
>   target-info.c                                 | 11 ++++++
>   target/riscv/helper.h                         | 24 ++++++-------
>   target/riscv/tcg/bitmanip_helper.c            |  4 +--
>   target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
>   .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>   target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
>   target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
>   .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>   target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
>   target/riscv/tcg/op_helper.c                  |  4 +--
>   target/riscv/tcg/tcg-cpu.c                    |  1 +
>   target/riscv/tcg/translate.c                  |  4 +--
>   tests/unit/test-multi-target.c                | 34 ++++++++++++++-----
>   19 files changed, 113 insertions(+), 57 deletions(-)
> 

Sent v3, now based on general helper renaming:
https://lore.kernel.org/qemu-devel/20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

