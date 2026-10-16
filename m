Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4C1CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkcb-0005iL-S3; Fri, 16 Oct 2026 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkcR-0005hw-9Q
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:17:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkcM-0001qD-Ri
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:17:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE68fF2455291
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S5uMNty1nE2VjEkKXRRWJKh1DFeo51XI96LId0uilOw=; b=ONP7W+kLC4KRkXuJ
 ozh6eiTWGMsDS59WQ3Z4Lca9s62lsT5nxjMMkpqFHBiXyniLMHDTbQmtzdlXj71d
 X/j2kB0GCsdbGebZ/72iq49MrJwmwkki1Y7vS9GzNRUlgWD4wps25S72Rr4/LBT6
 c9A2HwFib73iVoQD0bOpLDPwjhkxqoERn49pd17xESykXsjaQuK41w9ph/oyxAi7
 N21T8AF9xM+7jOklcHAPoJDnO+hDl6Y1DXJ4b3QrqeHPQ91EWM2UeF/oyi6xILAD
 kmjfbP/c3Lgdp3HPtLRBpWpSrQ9B/wtNWZpo0uS7ZzwWNA5mGZuJhyITFoy7mO/D
 oAC4tA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ystw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:17:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1385535eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167431; x=1792772231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S5uMNty1nE2VjEkKXRRWJKh1DFeo51XI96LId0uilOw=;
 b=bdk3rlD+1qQHWhaHxuj6vy+TE+0xgBEI+GepsJBDU+bBlQWGpYhRqrg8e4BGEyv2P2
 zxeGwpxNXgxWPayOdAOkghcv4pdFeEjKeUK4AgOniGr4k7CjFGGn+uSbvMZq/nH7rZxt
 syNLegYSjHJ8q6rpQa/Arrva3hwRDnnKsixRfdsUdexIL4CaFP6VR6hHaLft94HipvUs
 yVooFyHvJZtL008+4myDsWyS39jUyyFbUZT1FZk41s+ApC0i1F2vMbMRDyS20vbbFpja
 uWQyNWLy4cacG2g2l3OsOjWtRRIawtJSAq9QRxk867HNPMxSVJ64s5U9KbxU68GarNuN
 dqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167431; x=1792772231;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5uMNty1nE2VjEkKXRRWJKh1DFeo51XI96LId0uilOw=;
 b=Fz6UWOsLExTavh1bE+53+bkTLNEiKycqWcK/vjAyXIODkeSz9DBKQo2p9XlVAfSa7I
 RtVRy5p0UCVV86aydP/Df8B9+Qn9lCkhQdjBPi+suiG+ukvTqV/nW/PjQF/P0Te3IRY7
 nrsh2dNTc1YzfNGmU5ZdqDJDIQ4rVBmcWtrenaY6Y55zcHTNAOCI621+n7+8+Ny7o+Gq
 aaUCv1IZMMDk35WtIuaOxOyTCyFS0lZ8m0T2xEdyBWQY92IHG/dTPzFyaQa0RMFNY/59
 nJnE5AhJLgZhfj4UOgUKYgfS1TuJ6pdQxggmuhTqE5GcbR6zDLEOMsjtlFyyvuaEW3Gg
 NJTg==
X-Gm-Message-State: AFq9FYLuUeATGawc93RxBlTpilt6aQD+uYVDLtMToTU5/9u3Z6JC7ln4
 75otZcqwmjZsXtEfEq+Wg87hfMrWrxBntLzsXMkqqz8Mt5uAv+kWGG6WccPTER1H+QS6VJb5joM
 5vk/5BczIdBJkWB4o6+DAGMC7v8JlD+CPvtIGo/BzyuAuqrFfQ9fH8QXrgfdlZ3Jnhw==
X-Gm-Gg: AYBFou15SLwbCJiuYm/4cl3M0T0iqUEtTR7ojsecZq3VvyQxKAhRdBJeGqTXx8C59v6
 bPkH5h9/GnQ+rSEvwjM4cAj0la7ktvoXN63pSjmvfblmqGSA1eImoKeMIr6T3HVjD8ABmkHXomm
 2cL3Kyd3WzeL4F5GR+SebDj14dUhEnI+2NqEULijMAK/7HPBZtwpoGdNj/thy7TxroM7WLvWJNo
 bGD2TUUocW4iXnky/Np5S2fTW2G+woWXoXvMK8Bl2OsvMMifr+S+O+XlFPd3KsxoCdLkm9/ni3y
 yFPRm8mAjahQtn+slo9+dkZ/OcoGbaRU/sMuxXbE/077PiUdBdtln25e4LZOYNGk4HUnJPidHic
 L2er7hjD7jwNaIvSy30RrKj+WEue+FnVD/XFFnZJ/Q4hbC/V2sQKUuz+9SLod7TmzSFTEcw==
X-Received: by 2002:a05:7022:43a5:b0:152:dd1b:4fa7 with SMTP id
 a92af1059eb24-18511eb69acmr578499c88.19.1792167431421; 
 Fri, 16 Oct 2026 09:17:11 -0700 (PDT)
X-Received: by 2002:a05:7022:43a5:b0:152:dd1b:4fa7 with SMTP id
 a92af1059eb24-18511eb69acmr578448c88.19.1792167430691; 
 Fri, 16 Oct 2026 09:17:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c2e7bf4sm6275690c88.20.2026.10.16.09.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:17:09 -0700 (PDT)
Message-ID: <a90c37ef-c034-42ad-ab54-abf8b9546ab0@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:17:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] multi-target: add hexagon
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VgKVpAFy4hY2kqydAd6lfAOHPtjK9JRW
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad24e08 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Q9RrAthI1Nh1P9Vuh0AA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NCBTYWx0ZWRfX6upqAvUWbQe5
 lo1Niiq0LYtURoe6+bPP1dB7bVJI9Lpgi8HSyisEkmMc9HQghN456a+TvEB/3+YIhIigalLIMAs
 pLLztnDdcRNwDrNo/O1CWo/E9Axjdpc=
X-Proofpoint-GUID: VgKVpAFy4hY2kqydAd6lfAOHPtjK9JRW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NCBTYWx0ZWRfX190l7nN96lLh
 bUvQXnM3G4MpLj9oyzOIMhZgxm53w1cFPL+r75PbBmzSgP2OPEx+ksBJTkTKzLBSdSua6hkSHs7
 Bn66oDyhxWEv65f75ZmDyo51bD/AqhvZeF0l4DMResAe7TtYEecexFyDChecvpsFA00RzokR61Q
 hlJpYssagkmfcI7DOZGo69HIOCdGpxx0sjKNFz2NDPzTHee1fqzNWoPTTL36agg65gDEdCJ8Byd
 iUEKznXlYL0PbvFaTSHnN3ExabZk3QAvfGprywV15avV27YNOlLOlRoBsSY3Xl9WwojJNtzJQmA
 niQvlusBHuj2EUxIh8Jan3LsH8F8rsvfhow60bjt2TuAqYnha1RDNI98tZcEEA4MOl3GkvHZ/ve
 jm6a9QhRk5BdFSYJLxLtesZzUKd80OW7lwedh/3KJ6gVWLm5uf/MGnOiKTAY8EOm42btAqTOVtz
 7VCtyBm8Uulp2GBvKGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/14/2026 2:05 PM, Pierrick Bouvier wrote:
> This series makes hexagon compatible with the other ones we already integrated.
> 
> The biggest change is to introduce a semihosting interface, since existing arm
> symbols conflict with hexagon ones. This is also need for when we'll integrate
> riscv soon.
> 
> v3
> --
> 
> - constify some semihosting operations (now taking a const *cs in parameter).
> - edit commit description when using new interface in semihosting
>   implementation, to reflect we don't check if semi_ops is NULL.
> 
> v2
> --
> 
> - rebase on top of master (one conflict with helper renaming)
> 
> Note: this series is fully reviewed and I'll send it as PR on Friday if there
> are no additional comments.
> 
> Pierrick Bouvier (12):
>   target/hexagon: prefix helpers conflicting with other arch
>   target-info: add target_hexagon
>   hw/hexagon/virt: make machine available for hexagon target only
>   hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
>   semihosting: declare semihosting cpu ops
>   target/riscv/cpu: constify cpu parameter for riscv_cpu_mxl
>   target/riscv: declare semihosting ops
>   target/hexagon: declare semihosting ops
>   target/arm: declare semihosting ops
>   semihosting: use new semihosting ops
>   semihosting: remove common_* functions
>   meson.build: add hexagon-softmmu to multi-target
> 
>  hw/hexagon/virt.c                   |  2 ++
>  include/hw/core/cpu.h               |  8 +++++
>  include/qemu/target-info.h          |  7 ++++
>  include/semihosting/common-semi.h   | 24 +++++++++----
>  meson.build                         |  1 +
>  semihosting/arm-compat-semi.c       | 56 ++++++++++++++---------------
>  target-info.c                       |  5 +++
>  target/arm/common-semi-target.c     | 33 +++++++++++------
>  target/arm/cpu.c                    |  4 +++
>  target/arm/internals.h              |  2 ++
>  target/hexagon/common-semi-target.c | 30 ++++++++++------
>  target/hexagon/cpu.c                |  2 ++
>  target/hexagon/gen_tcg.h            |  2 +-
>  target/hexagon/gen_tcg_sys.h        |  2 +-
>  target/hexagon/helper.h             |  4 +--
>  target/hexagon/hex_mmu.c            |  2 +-
>  target/hexagon/hex_mmu.h            |  2 +-
>  target/hexagon/internal.h           |  2 ++
>  target/hexagon/op_helper.c          |  4 +--
>  target/hexagon/translate.c          |  4 +--
>  target/riscv/common-semi-target.c   | 37 ++++++++++++-------
>  target/riscv/cpu.c                  |  4 +++
>  target/riscv/cpu.h                  |  2 +-
>  target/riscv/internals.h            |  2 ++
>  24 files changed, 161 insertions(+), 80 deletions(-)
> 

This was merged into master (2cab0c10632960c01972727608196984d52c93bf).

Regards,
Pierrick

