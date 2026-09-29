Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF9C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBS4q-0000Vm-48; Tue, 29 Sep 2026 03:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBS4d-0000VX-Ho
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:16:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBS4a-0003Dj-UM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:16:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47AEK2126504
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XY9Ah7lq+cILdOX9K4KsQDK4CZyg0SmvxRHPZkT12+k=; b=mBjkcCcy+2q1dLKD
 p24+hNrNNAB+wcF8Y+yK35c6dZiWgn6Y7gl9D3MraldIfqyxPlZR98YVSL6s7pjs
 S7WiiBp58Rzv3EhbdozSxBl9zlmCCBpqTpADMJat368NSDIJzWa/l1v5in/4bIc1
 +Bl1fEbhHB+1+jAnaJUcYgtCVIQbvRCUUY8aGKmN0eChxP6EzxpZneo14wo+PP24
 O8eMJtynESBNioeFO9PpMmtdRTMlRiRdWErXJOifBlq4NEHfs8yWCSUURIq0MOm3
 wZ7oY6hW4KF7lNpndWcm+Iqm9PFZiLmeIBZ9xINBt1lJYOUaZmOQeDhVwH/wGWY9
 fMuPdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9bu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:16:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so404970585a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790666177; x=1791270977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XY9Ah7lq+cILdOX9K4KsQDK4CZyg0SmvxRHPZkT12+k=;
 b=XOar3WDjBx+f/Uuf8fulI8vf3KNLUgQc3mRqvTQxF3YrDpIv/l9UcPQ4ZzY+4IK8N2
 +jSDx/i2uOAB3cKJ5G785KOEBIV/Ji29N8M5bIe2vs7V86gJ7QFnQM0Vo2efHY4vGfZN
 vWCn7FxVhdus12fc9Aa2vXx9AgiZTZ1J86/sQAkI/pGTgHIG8O9QuAJq4pOgt8la26Au
 s0J1aI59nJHAZzBLcFVaG//3PJQarYnaHW4oW71Y/RhloXLgg3znszf7cjpEo2e7g/87
 lFrhAAF2GjQFMl9ZqooXr7zBml+EKqVb6JGQvlLv4wcES6DzF+wu/gipJfdXRdN0zVXO
 ERMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666177; x=1791270977;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XY9Ah7lq+cILdOX9K4KsQDK4CZyg0SmvxRHPZkT12+k=;
 b=p5aHxAAwgj/INHKwEtDqLAmR4Vb59ZXvR/km7EKss8h1RpBoFH3K4j2r7ioOUyzptE
 97YOvRzwaKRFOlRGK/ct4oIuEMcCpdS148Aclj+UrzAMzKX9Wu+ImxrbOaDPkUDVrZBS
 puASPWYYgPRs2IPeY0920n7Kiyo+TXFYG5zIH/g6vvpdLvmZOpK+Abqgg4XZXE0srTrz
 UKk9WoRpVq3xUWOrtVekyxf5Mj2dLdccs61gdLX9t5fUo2qgl/qQzRZiYiDF5+bImuxB
 /zwJmDEIQnKCKaCOEwe93tUUqLfEu7Ewg25daoN2CLmBy0zgOeXFAkGGy+tvZ3OSJCJ8
 c81w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvPe9Rix+1KA4WARvO0/YODksoqzRBKqELXV3SSG0QazJKn58uncviP49KTc/dxTiLrlZw2ktVJfGA@nongnu.org
X-Gm-Message-State: AFuF++m7NAGf3L/AqTB2WchPQyg49Ld+9QpWOVigjcIIV90MOHh7Edty
 +FF9dng1Xg/YL8dBa3vN24IOZ0IV4DB9WwH4avriz4mdiBllVhxHolFvEDDsyg+CveoNzwcH7wb
 21Zv8T8e7FFX0HUbEFf5Df23ApvzMUs2q84yY/TsRSSyPVvzjkFGp1j/NGA==
X-Gm-Gg: AYBFou0J1rDES3bh+lA7p6hw+inKb6VhWiDZG8sUeIVs/9TC3Id/3FqGviwRigOP9Yc
 w6IRv6sfqBC8w3EK5QOwvOevZjpbwL4IXm4760zQIfFmCmKnbv8WE6g9TJ9EhblBH7PWFL+a/Xl
 +EI0vs8rLfOQLSN2atebEiv9AAlnKu4ZOdNKJ9zoOracrpM4hj41jvleodAAxann7K1bEgkb8vB
 7Qu36obc4fzVYjDVdglOTgDToTLg6laz1vFANXuT0W++IVsbP5ZtYi+l5tCu/nv6OHVPja+gyLl
 QsxX3Ne3s77qmWYy7htghUfLX0L5j7CnVeIuylk6MLX/+SWleiFKp5Zp2SgitOv6uWU0cnAbs6w
 olCSKJTfFfdeqePFFOlsjEhf+d7JjgGbmBA==
X-Received: by 2002:a05:620a:170b:b0:93c:2724:625d with SMTP id
 af79cd13be357-93c43bca4e9mr2541742185a.15.1790666177042; 
 Tue, 29 Sep 2026 00:16:17 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:93c:2724:625d with SMTP id
 af79cd13be357-93c43bca4e9mr2541739085a.15.1790666176457; 
 Tue, 29 Sep 2026 00:16:16 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm50355185e9.6.2026.09.29.00.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:16:15 -0700 (PDT)
Message-ID: <8ed6ee25-57b4-4068-b526-c9370934bd84@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260917082618.1076988-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb65c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=P6VLCaHPnUf0m_vW-YQA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: a7JCPCwQ7qqJgSkheF5NR86gkTSkTWe9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX+MjKkvsK8yp6
 nLg6N97H9+cwcFLsvaUpYRezogulKONBGPEE6YMZ47s4PQp0ndKZTovbOIQNekZy8z9Z3X7AA/f
 vUvXeKf6xdfWGlAzZ7x2CXaVs0OEvmA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX8R8tbVgf0qWQ
 HF88HMi4n/o3+A6ozOOKguJhjR1+rLcA8x/9zm0Lq9mYbq3md5dtLn7W41UZ2NMPUgIHd5bS/Gr
 0UWm+7UrS1RReVJPIw0q0OwYMRCrV/pdpWebhuyjtrX6QoOZ3pJVNxo2sgsX6IHUoTXBMZXDAEc
 ttxOdQ44maCrH2GwvNT7sfZ5a3HtCR9MTAmYtJRSZEWyfDp++3CT3rULH2bDG33POZ/71Dby1AK
 7Ld9eS8QFw3lUkBWicygBTTZqOmncL4ac8zCY4O1UroezD9fYyuBuEE/D1oT0arTFFzjRdFs2Jg
 CfZsz3A6bCyXTwEdeWjcrogGySAFE/OqsVheNbKs3qTt1glo9lTM1tbhRgCkKEk0nJz4gMxvNLq
 h4EZSYwBZuvjy14rrHRWK3JcKTTPU3ZSnyFORybclaCPBUCIWjNhgpMQjonjyKh29xW+twaoMjw
 wkRLZRgw1Qv1/2V3AEA==
X-Proofpoint-ORIG-GUID: a7JCPCwQ7qqJgSkheF5NR86gkTSkTWe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/9/26 10:26, Richard Henderson wrote:
> From: Matt Turner <mattst88@gmail.com>
> 
> curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
> and from the cpu_exec() loop. It recomputes the same value every time:
> 
>      uint32_t cflags = cpu->tcg_cflags;
>      if (unlikely(cpu_single_stepping(cpu))) { ... }
>      else if (qatomic_read(&one_insn_per_tb)) { ... }
>      else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
> 
> That is three loads and three branches on the hottest path in the
> interpreter, for state that changes only when gdb enables single-step,
> when one-insn-per-tb is toggled, or when the log mask changes.
> 
> None of the three has to be sampled at dispatch time. Fold each into
> CPUState::tcg_cflags where it changes and curr_cflags() becomes a single
> load of a field that TB lookup has to read anyway.
> 
> The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
> CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cflags()
> can recompute them in place without disturbing the rest, and conversely
> tcg_cflags_set() ORs in its bits without disturbing them.
> 
> There are three places to call it:
> 
>    - tcg_exec_realizefn(), so that a CPU created after the command line has
>      been parsed starts out with the right value. This covers user-only,
>      where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
>      copies tcg_cflags wholesale, so a cloned thread inherits it.
> 
>    - cpu_single_step(), which changes one CPU.  gdb is the only caller that
>      matters; in system mode it runs with the vCPUs stopped, and in user mode
>      gdb_continue_partial() can reach a thread that is still running, because
>      gdb_handlesig() stops only the thread that trapped. That is exactly the
>      plain cross-thread store to another CPU's CPUState that
>      cpu->singlestep_flags already was, read back by that CPU through
>      cpu_single_stepping() in curr_cflags(). This patch changes which field
>      carries it, not who writes it or how.
> 
>    - hmp_one_insn_per_tb() and hmp_log(), which change every CPU while the
>      vCPUs are running, so the update is queued with async_run_on_cpu() and
>      each CPU writes its own cflags from its own thread. The command line
>      spellings of those two settings need nothing: they are parsed before
>      any CPU is realized, so tcg_exec_realizefn() picks them up.

Noticed this commit while rebasing hybrid-accel work. Could this new
helper be useful for this previous discussion (patches 38-40)?
https://lore.kernel.org/qemu-devel/730b4fca-e0fa-4e99-a092-f63aadfa57d9@linaro.org/

> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
> build configured with --enable-lto:
> 
>      before: 1,646,994,254,249 instructions
>      after:  1,562,204,796,597 instructions   -5.15%
> 
> That workload issues 8.4 billion dispatches, so the per-call saving is
> small but the aggregate is not. The emulated compiler produces
> byte-identical output before and after.
> 
> Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against a
> run-to-run spread larger than that. The removed work is a few predictable
> loads and branches that the host executes largely in parallel with the
> surrounding dispatch, so this patch is worth taking for the instruction
> count and for what it enables, not for a time saving that can be measured
> on its own.
> 
> v4: Update the cflags from the HMP handlers for 'log' and 'one-insn-per-tb'
>      rather than from qemu_set_log_internal() and the accelerator property
>      setter. Those are the paths that reach a running vCPU, and the monitor
>      is the only thing that does. Suggested by Richard Henderson.
> 
> v4: Queue the per-CPU update with async_run_on_cpu() rather than
>      async_safe_run_on_cpu(). Halting the other vCPUs buys nothing: the
>      queued work already runs on the owning CPU's own thread. Suggested by
>      Alex Bennee, who also asked whether there are cross-vCPU updates of
>      tcg_cflags at all. With this change the monitor path has none: the
>      only remaining writer from another thread is cpu_single_step(), above,
>      which is neither new nor made worse here.
> 
> v4: Move the stub to accel/stubs/, which is where the other accelerator
>      stubs live.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260901034808.3524945-2-mattst88@gmail.com>
> ---
>   accel/tcg/internal-common.h | 11 +++++++++--
>   include/system/tcg.h        | 12 ++++++++++++
>   accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
>   accel/tcg/cpu-exec.c        |  3 +++
>   accel/tcg/tcg-accel-ops.c   |  2 ++
>   cpu-target.c                |  5 ++++-
>   monitor/hmp-cmds.c          |  7 +++++++
>   system/runstate-hmp-cmds.c  | 18 ++++++++++++------
>   8 files changed, 79 insertions(+), 12 deletions(-)


