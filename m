Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8211AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwMpW-00031d-Gw; Tue, 18 Aug 2026 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwMpV-00031Q-IS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:38:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwMpT-0005Bu-Do
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:38:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE0ekw1427006
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8PcXBwPddVAb0Au1zfATvgVwO56KWyF73vu7P1vFTE8=; b=TIv0kcISl3FpEtLA
 oSxzgbdYE9xKapg+oDdJXGeuUq6bCuniyC2vRZIiWb3B2jVLTpT+iVGzCvO0UNDT
 C/U3clUmVMin1kSIdXGJwpmEW6+q+zgM8YN2+sGW5idSqKDaSx3u5QYjIRQxFutF
 +Eh1NV2t/S8c5lVLSvZFZy1cAPbOor/q+DuzrrdpEb8O6m8NEGrUGHcQLz0bUHKi
 V4CwsJpJmzDrLCB/R4RA4IEUL2JBiVrMcN7eUejwIL0Ja770uns6wOxWbkUvtTcA
 JeWlGw4LvEq/aDIsiTQ5aSRcoMoky1h/E80waqTwahv3BkqeKUQIMttaqedZuu0x
 ZZvVEw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb19pyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:38:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so1058702a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787071100; x=1787675900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8PcXBwPddVAb0Au1zfATvgVwO56KWyF73vu7P1vFTE8=;
 b=Id14C2rtRxJTIh4qS0mDo4DTCOscbCFW3DI85WG6lcaDQY0YTElyKNYznw810GEKbl
 YAdwIZgbB8+FRZ4nrCFua2W3BVjiG0ac/DJiyjnZHbHuwjxTWYkAcX/7lbmgmQ1g2ZLx
 6xnLKwD7NFDy4hRFyBtzP8pekqcsmuILmp/aR2HGR51muYYUng3P8TxGx6s4e1S5a6AP
 bQ0JCbZtXMGatRMBszEMNKYWY69Q9lId6uMl+EClYmWt+Voxorgslb66olcaVR0QKOja
 yUxRBUw08hZ0BrjFheqJccQjNy0djHwmnq5mkShhxvY32lnokZEybAWLi182CKZGYNR9
 /H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787071100; x=1787675900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8PcXBwPddVAb0Au1zfATvgVwO56KWyF73vu7P1vFTE8=;
 b=eJBbXcqNUvELtNQ8Yxr/boXEkQFxiVhCcyP5mtwF04SU5OB8IvWSOtYboXb9+GlD/y
 /NKZxeA8+laM3ujJPmZzmXUiHUgFn0A+8HlAbQxZ9/dD3HHTdhYb1h5tsJQEew22ak/5
 GMUEGlG1D4mmQQ/Psk8KseCvnSpqc03wlGp7Rt8/8qMDH2i6uLdNoOR5iISAljinsJAV
 wEZptNlhTtwdMXgUW27sXAFEa1jzH1TmptxXHbMgsZ3R7Ldj00D85evPTKIfq98FCJ48
 NWGW9fWm2BONMN2ZnDL+hOIW8k7iykjEo7g7w6ORDXy1h3HvjW1HU+BhGydR1u26D0nl
 vCPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYxMUv3RAJlTa9g2yzLc4jW+3muUhtTC+YaC9QdkQwF8cjl8GdBC7MDMtmrwuy2sr6Ehm2YN8ePDjc@nongnu.org
X-Gm-Message-State: AOJu0Yw1VGsvMnLObIbB0750UsXPCNj5Ksel6BYAQDtwnPhRIpCcLPiF
 zTVCk5mJcY3j2QYhdEACUADrTPCfSYgiSZeW9s2PPI6Guk2KrcjSqhQmuG1vqrf5Kp7EYAzY1F4
 pnh2R6KrtdM8HuYd2xZXGLSn8YjL8ivrd6dfT35iqPY9SiUOPdrvM4EU9XA==
X-Gm-Gg: AR+sD13WJ5hJAhRWRF1C2O2uP08LxG3fAP9qrzA5BGs1LhDznr4HGW4ZTbX90gVbdit
 k34Z/NT3aq66pmpNacrVA+rFbiCreAr6NZlW6t+YJV+ghy10xf8iTXgw5NwxfoBvOKZsJ+/dcjH
 r8YJ+EECuuKdHwSjzRg6xuaVNAp94l4zXg7RrXm35jh3fmB6KcJ8QrzXQ7eQ7I19JerU3OMePLX
 uKbk5nGM8hA1rvY29o03fZ09752Ghqv5MnqIVe063cfsAfLn82kDBpEIwdS8DeePNuoKGwt6je/
 eN+ueXP1LRiNy/9kEm2xMHByZ4H5IcshhNhVga/UVwAdmyZjglDMrD5RdAp9xd80WjEabYiup21
 R0Yw9gZwPtH5+ZI0LOYcYvgkeMM1eG8XNB1ZL2pONrI6ExBoh8CHwajssi6gCFgwgtLYc
X-Received: by 2002:a17:90b:2e42:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-3955f1b64b4mr9030850a91.18.1787071100310; 
 Tue, 18 Aug 2026 09:38:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2e42:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-3955f1b64b4mr9030771a91.18.1787071099667; 
 Tue, 18 Aug 2026 09:38:19 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415305a0afsm26662996c88.4.2026.08.18.09.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 09:38:18 -0700 (PDT)
Message-ID: <403cb8e2-5f3d-4c5c-a509-fc13b4cd50f9@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 09:38:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] accel/tcg: cut per-block dispatch overhead
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
References: <20260817190038.580257-1-mattst88@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX/hyuBQLKO2bS
 n/VOVsy/uyR+I2fpgUl4fjyz0hpwTr84+gF2N0+C4h8hdErC32yWdzEds73mnpOctlxWK3YuiQJ
 RQOMyhKEdaHO7i87rpWQnNMqupkqhcrMGY8UFOJWE9b2Xq9uJFOFT1/L1k7X4yhjgLRod9tm1tr
 9mvzFQm+rKek6Y0wHlHKbWm5Nc81FM+ZEPWdN2JoIoNIjslYWwOEGfgL8wopaFASHSLhRlJBSQs
 kIKAo2bSNqtEtpadu38OP/5n4/Z79ek2a1WFr2Y1aJ1MEBAUmFVg4/AXwkw+EkKGRIq3FRGYTDy
 d7DLt6VMrNuSZKDsoue/RHqUJBLDmM8HMryV82uRQ+vFaFYb3L0KmMicGIuORvWYP56jLRT0rTO
 Nw+eyIYfKDduLKGMWe+vRMDWXxSAXQiNxs8ieJYiJp8lHV/R0KgwEpJa9fIQOY2QDmcE1+Bo0ai
 pVHS/P33Eg5f2o8HKjg==
X-Proofpoint-GUID: _2ny0raZ92RwUrCWwgdkoqQtCSZSelsJ
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a848a7d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=wEogZCwsr7ACtS07IPoA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: _2ny0raZ92RwUrCWwgdkoqQtCSZSelsJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX8ldKcctKkiRC
 ZSIuVd6jc13si0TcN7teMtlEkVaCxaSiNH5DoDtvyeoeLqw381sEUL5vPHJ7EyMZSgVxVXst2Mg
 UDomBzOqqMW+jPylZQB5VXKMrW4uCrE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi Matt,

On 8/17/2026 12:00 PM, Matt Turner wrote:
> For guests running large amounts of code, most of what TCG executes is not
> translated guest work but the fixed overhead around it. Blocks are short and
> there are a great many of them, so the constant cost at each end of a block
> (the interrupt poll and the can_do_io stores on entry, the dispatch on
> exit) ends up dominating everything else.
> 
> The workload throughout is qemu-alpha running an emulated alpha gcc 16.2.0
> compiling the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64
> host, in a --static --enable-lto --target-list=alpha-linux-user build. It
> executes 34.2 billion TBs at 6.04 guest instructions each, and 24.6% of its
> TB exits cannot use goto_tb. That is a representative shape for any guest
> whose text is much larger than a page: indirect calls and returns
> everywhere, plus direct branches that merely crossed a page boundary.
> 
> The first three patches are ordinary cleanups that stand on their own. The
> remaining five are marked RFC individually and are where the interesting
> questions are.
> 
>   1  accel/tcg: cache the result of curr_cflags()
> 
>      Recomputed on every one of the run's 8.4 billion dispatches, from
>      state that changes only when gdb enables single-step or a log mask
>      moves. Cache it in CPUState and recompute from the four places that
>      can change an input.                                        -5.10%
> 
>   2  accel/tcg: enlarge the TB jump cache to 64K entries
> 
>      4096 entries is too small for a guest running a large program;
>      tb_htable_lookup() is 5.73% of samples. 16 bits is the knee of the
>      sizing curve, at 1 MiB per vCPU.                            -6.02%
> 
>   3  accel/tcg: skip the can_do_io stores in user-only builds
> 
>      Two stores per TB that nothing in a user-only build reads: 68 billion
>      of them over the run.                              -4.55%, -4.32% wall
> 
>   4  RFC: tcg: probe the TB jump cache inline instead of calling a helper
> 
>      95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
>      cache. Emit the probe inline (hash, three guarded loads, goto_ptr)
>      and call the helper only on a miss.               -36.51%, -27.05% wall
> 
>   5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
> 
>      translator_use_goto_tb() refuses to chain across a page. In user-only
>      builds the invalidation path already covers what that was protecting
>      against: every mmap/mprotect/munmap reaches page_set_flags(), which
>      invalidates and unlinks. Lift it there, keep it for system mode.
>                                                         -2.42%, -4.68% wall
> 
>   6  RFC: accel/tcg: only poll for interrupts in blocks that can close a
>      cycle
> 
>      The icount_decr poll needs to happen once per cycle in the guest CFG,
>      not once per block, and any cycle must contain either a backward edge
>      or an indirect one. Record both during translation and emit the check
>      only for blocks that have one.                     -6.81%, -3.10% wall
> 
>   7  RFC: accel/tcg: poison the jump cache instead of polling for indirect
>      exits
> 
>      What patch 6 leaves behind is mostly blocks flagged for an indirect
>      exit. Give the inline probe its own jump cache base pointer and point
>      it at zeroes when an exit is requested: every dispatch then misses
>      into the helper, which returns the epilogue. The poll becomes a
>      pointer swap on the request path.                  -2.79%, -1.94% wall
> 
>   8  RFC: tcg: fold a guest displacement into the host addressing mode
> 
>      tcg_gen_qemu_ld/st cannot express a based access, so a target with a
>      displacement in its encodings materializes the address with an lea
>      that the host addressing mode would have done for free. Fold a
>      preceding constant add into a new argument on the op, opt-in per
>      backend, wired up for x86_64 user-only.            -6.29%, -3.29% wall
> 
> Each percentage is against the patch before it. End to end, measuring an
> unmodified build of the same base against the full series, five runs each,
> interleaved in one session so that host clock drift is shared rather than
> attributed (mean, with the run-to-run spread):
> 
>     instructions retired: 1,646,129,294,236 -> 738,003,153,831   -55.17%
>                                     (0.16%)           (0.03%)
>     wall clock:                    134.934s ->          75.189s   -44.28%
>                                     (0.30%)           (0.99%)
> 
> Both endpoints ran at the same 4.782 GHz effective clock, and the .s files
> they produced are identical.
> 
> The two figures do not track each other, and that is the interesting part:
> what the series removes is cheap, well-predicted, highly pipelined work, so
> it retires far more instructions than it saves time. IPC falls from 2.55 to
> 2.05 as the remaining work gets less regular. Patch 4 also cuts
> L1-icache load misses by 39.1%, because a dispatch no longer jumps into
> qemu's .text and evicts translated code; qemu's own .text falls from 38.9%
> to 5.4% of profile samples over the series.
> 
> Every revision was built and measured separately, so the series bisects, and
> the emulated compiler produces byte-identical assembly output at every step,
> which is the correctness check these patches most need. Two new alpha
> tests cover the hazards the series creates: tests/tcg/alpha/test-xpage-chain.c
> (patch 5) and test-indirect-irq.c (patch 7). Both fail or hang if the
> mechanism they cover is removed, which is what makes them tests of the new
> behavior rather than of the old.
> 
> The RFC patches need eyes I cannot supply myself. In rough order of how much
> I would like someone to look at them:
> 
>   - Patch 5 reverses a deliberate decision made in d3a2a1d803 on the
>     strength of an argument about the user-only invalidation paths.
> 
>   - Patch 6 moves system-mode interrupt latency from "bounded by block
>     count" to "bounded by guest control flow". The bound is one
>     straight-line run between cycles, but timer-driven guests want a closer
>     look than I can give them. Its soundness also assumes every goto_tb
>     destination passes through translator_use_goto_tb(); no target in the
>     tree bypasses it today, but nothing enforces that.
> 
>   - Patch 4 treats cpu flags and cflags as translation-time constants in
>     its guards, reads a jump cache entry without qatomic_read(), and puts
>     knowledge of the CPUJumpCache layout in tcg/tcg-op.c, where it does not
>     belong.
> 
>   - Patch 7's restore in cpu_handle_interrupt() races a concurrent poison
>     from another thread. I believe the existing barrier around
>     icount_decr.u16.high covers it, but my testing was single-threaded user
>     mode.
> 
>   - Patch 8 only examines the immediately preceding op, refuses any access
>     with a slow path (so user-only, and no alignment check), and leaves the
>     i128 pairs alone.
> 
>   - Patch 2's 1 MiB per vCPU is easy to justify for a single-vCPU
>     linux-user process and less obvious for system emulation with many
>     vCPUs. It may want to be sized per target or made tunable rather than
>     raised unconditionally.
> 
> Patches 4 and 8 are wired up for alpha and x86_64 respectively; everything
> else is target-independent, and no other backend changes behavior or needs
> touching.
> 
> Matt Turner (8):
>   accel/tcg: cache the result of curr_cflags()
>   accel/tcg: enlarge the TB jump cache to 64K entries
>   accel/tcg: skip the can_do_io stores in user-only builds
>   RFC: tcg: probe the TB jump cache inline instead of calling a helper
>   RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
>   RFC: accel/tcg: only poll for interrupts in blocks that can close a
>     cycle
>   RFC: accel/tcg: poison the jump cache instead of polling for indirect
>     exits
>   RFC: tcg: fold a guest displacement into the host addressing mode
> 
>  accel/tcg/cpu-exec-common.c         |  48 +++++++++++-
>  accel/tcg/cpu-exec.c                |  54 ++++++++++++++
>  accel/tcg/internal-common.h         |  22 +++++-
>  accel/tcg/tb-jmp-cache.h            |   2 +-
>  accel/tcg/tcg-accel-ops.c           |   2 +
>  accel/tcg/tcg-all.c                 |   1 +
>  accel/tcg/translator.c              |  77 ++++++++++++++++++-
>  cpu-target.c                        |   3 +
>  include/exec/translation-block.h    |   6 ++
>  include/exec/translator.h           |   2 +
>  include/hw/core/cpu.h               |  23 +++++-
>  include/system/tcg.h                |   9 +++
>  include/tcg/tcg-op-common.h         |   2 +
>  include/tcg/tcg-opc.h               |   9 ++-
>  linux-user/main.c                   |   2 +-
>  stubs/meson.build                   |   1 +
>  stubs/tcg-cflags.c                  |  16 ++++
>  target/alpha/cpu.c                  |   2 +-
>  target/alpha/translate.c            |   6 +-
>  tcg/tcg-op-ldst.c                   |   3 +-
>  tcg/tcg-op.c                        |  86 +++++++++++++++++++++
>  tcg/tcg.c                           |  86 ++++++++++++++++++++-
>  tcg/x86_64/tcg-target.c.inc         |  61 +++++++++++++++
>  tcg/x86_64/tcg-target.h             |   3 +
>  tests/tcg/alpha/Makefile.target     |   3 +-
>  tests/tcg/alpha/test-indirect-irq.c |  53 +++++++++++++
>  tests/tcg/alpha/test-xpage-chain.c  | 111 ++++++++++++++++++++++++++++
>  util/log.c                          |   4 +
>  28 files changed, 676 insertions(+), 21 deletions(-)
>  create mode 100644 stubs/tcg-cflags.c
>  create mode 100644 tests/tcg/alpha/test-indirect-irq.c
>  create mode 100644 tests/tcg/alpha/test-xpage-chain.c
> 

I was curious to give it a try and see if everything works before
helping on review, however series does not apply on master currently.

Could you please rebase it and send a v2?

Regards,
Pierrick

