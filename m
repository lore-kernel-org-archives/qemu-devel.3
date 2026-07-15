Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB39CC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1eH-0002D8-8W; Wed, 15 Jul 2026 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1eE-0002Bq-Qo
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:35:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1eA-0002kM-7w
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:35:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3bVm851015
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 INx8WOn/gqsXNq7ocXUEbFrikUxKWDWkuTXljKCWaa4=; b=O63Ali0Qn54GqZKE
 EE2Bjpg/rlJLGQJBy9Jy3l/ZGKV4uI60Sv2YTAeyVtX3wRU2HKSS740UHzmUsbeF
 Lyt2VFbI1kc8bXdIG6UmXRQFLGYgN1vLw1AN1CXIkZsyQEkOyY6LUOTeg/TDY+Yt
 hZspSw4++9wXg+RQNaYsEkVSSiRYOkjMJEYbn19RklxcxyikW+19Z6bRdvB5/QuA
 6zxJrpWFTsp6ol9S0ubwPzc9tb6Jps+aj335EilmLRlMENp9mspoHlP7wB3tjdjT
 NO4QAtYOMBxWt9sAgx1Qec6M7EF4P9mUdG3CFV5Nurool/bREXVoMgBuooC03IOH
 ru94Kg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wsur4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:35:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca3673560so104224155ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784129740; x=1784734540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=INx8WOn/gqsXNq7ocXUEbFrikUxKWDWkuTXljKCWaa4=;
 b=Bie5fEo0EzdKV9Urj1hYBfdp2+afEkwuQ2l+1ELaOnpF8P6bfzdNEoJsnrKiIVhB75
 MPvBGV77+gKwKuBsj6KK2moH7GdmpHqXO2mgMuOLjBC6JxDp2BQYcI/IJ/fzSuuF0RfQ
 z+yTbGKaLWLPsO1O6S9dlwxbBxCtLbrmpvPC1OoYgfGRrpat1Bfwmze23RjIxJYO83J3
 YZRrhi3ybEDn7wXU+UfLiKsmrr8LxVqqvTG9nnrUGYKd0xIEfWT+axeNKkatN7fd2f+0
 brusobwGPjELkSLNDWuDrptZzGhoNxDQxJbh9KNnuYVu+cbXQkslMlZ3Hz0hwnVdkT9m
 c9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129740; x=1784734540;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=INx8WOn/gqsXNq7ocXUEbFrikUxKWDWkuTXljKCWaa4=;
 b=UHWl7SYSHshYGAzkqLbLZRMy7U3E43DSOCK5BsVAWCHFv40my7CNowCHwNN1fezHKz
 A2xyGPmkeMR3szgp0Gz/9AZugWFWkZZez7GMBjnKGXpSX5V8t+DgJdgadTxNqv3JReyX
 jSoWltOpSayizJXg1F7fWfd8WcVMR6F06kYXXZTfZpw452pALVQaVhwH1J8LuRy+lXj6
 KmYG1pjEI3kJY8dX3LbgVH95+9GAuOlKindxk1LtFOCVM3HbjFPxGmCykxyB4XtchuNK
 4d3AgOIl2o6CsEkg4Ul96pkmhjsR1xV4P4a7S8dW4ZLnbSSjmeeq72ok3ZT2bMY0MKiY
 fN7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RolLq9Y43oHZZW3Oik9x59I7mOAZIqabdE74Hp5fAcGrMooXj20kcek2fRV1fvX0XThv3RXPmQrVEMJ@nongnu.org
X-Gm-Message-State: AOJu0YxmCcm94eULvyz/uL8oyBns2RXxYwzpnLgdelBmbx7MS3oMve33
 dffMLRy8E8v4qdpea8uz9bKfg6h8SPIl0vbR3PRNqtPYV4MgcC/PVPhZNycZ+wuSGzqpOeiK9/6
 D0a1wHkM96jRhTW5UUqAxRFA5/zTr0e/f7jrQWqvTQwD5p5iAEOKCsHhM9Q==
X-Gm-Gg: AfdE7cmNvqOBwTyZ3K3O6NqwB8FIMHPeM17hltqtmI6ylZeJ6y3grND1RaZI0eVGrnf
 vsZ2DtNjI9GLu0/1yH/boUbgfwPjvjwfMsBoSVlRAtG7T/uKN3VHwiC1iQwYsqkQJ7hHEAdsZci
 vI2A48mKPLSgTgPTcJbrHKk1IBSAeQ+AF8uJTMbraXzakDgraFKlOpZs8JOhzb8M0wYK9VvUQ7u
 ta3l/jtIJucrune9Mx356AMUej6KGQGyEVgrxqYocXGaXuJwL+VZEaxUaviHG5qSLT8tRC2eAJB
 76Q89w9ofpEFhbOejgnXdjQAzgTRJQ4IrWmCEOWsn0Fpzc1cQiyI8SgYGJMTxHHx7I0hmRjBALH
 VOnsTrKZGDyZaybvQw7IF/5UXeZsSu1lbs8O+vTL8ivyrxKrly3fgP8gEFLc/f5i+nnWGCUTLUm
 WLOhg=
X-Received: by 2002:a17:90b:3e8d:b0:38d:a8be:a592 with SMTP id
 98e67ed59e1d1-38e1af127eamr6364987a91.19.1784129739681; 
 Wed, 15 Jul 2026 08:35:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3e8d:b0:38d:a8be:a592 with SMTP id
 98e67ed59e1d1-38e1af127eamr6364933a91.19.1784129738865; 
 Wed, 15 Jul 2026 08:35:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm3049820eec.21.2026.07.15.08.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 08:35:38 -0700 (PDT)
Message-ID: <04ce4c2d-7f4a-4bd1-b020-676048078732@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 08:35:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/2] contrib/plugins: add dlcall to call host
 functions from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711094523.622997-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0CNmgGmZfCuBhIeZK6Qav1m38P_1pstg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NSBTYWx0ZWRfXwz9GmKsb426P
 6341Kjs7g3/n6WHvdBXcIj2SB14qK5GhEtYGAwbIuAE367RUuukh+U+RSCukT0/Mea1xRN0iUD4
 zU2rGJg2b9LTDF1lQEpL0Ve1sfF2qwQ9bImQZbiVapTUKSd9pTlZ7NAnydfZ+uFRYEq7bAsjVdh
 5CdNT1MKbbO/7Usnx03RBaZHyF8BMuH2n2Plz8KpTDnqLs2ge4RgN6wZVNOS7gcp5CQWn1M3tOe
 tE3fN0Dfzo9jaoFQQwpepOQM5M3uN5XPIxmhJb4dSP1mYmiZ/GeZRins08nGyx4+VZsRjJK1/60
 Tda96PqSpusl6v1Co/AYfUfqfE4SgjFjzOrS1R4lps9xfUIcUMYstkuFoagTvtXXv+wpiKOMhZ9
 tZvMxQ0WcG7ScwQTl7FYKJgmXkeamwgLTn4Jvv+204s61laTTyZH62FWOXTcclRJhwLdTd58S5k
 iuQEfMVaAp9Bbjk5v9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NSBTYWx0ZWRfX1170wf1Lc3kj
 iX8jWrHq72l3lNsFneWd/iAO9mXHV43aV/CQ1EyxCcgdpDwpBsOGApMqEmbZFfMZL12+knkMnv/
 oylCxQRk5+huOtzUKLOeLDkWnRWWTb4=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a57a8cc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=vnREMb7VAAAA:8 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20
 a=0bNnEfQXDuzMK60hm14A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 0CNmgGmZfCuBhIeZK6Qav1m38P_1pstg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150155
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/11/2026 2:45 AM, Ziyang Zhang wrote:
> Hi,
> 
> This patch adds a single plugin, contrib/plugins/dlcall.c (~250 lines,
> no changes to QEMU core), that lets a linux-user guest call functions in the
> host's native shared libraries instead of emulating them.
> 
> It is the natural next step on top of the vCPU syscall-filter callback that I
> contributed and that was merged earlier:
> 
>   https://lore.kernel.org/qemu-devel/20251214144620.179282-1-functioner@sjtu.edu.cn/
> 
> Why bother? Because it turns slow, instruction-by-instruction emulation of a
> library into a native host call. Some results, all on completely unmodified
> guest binaries:
> 
>   * minizip (the stock zlib utility) compresses several times faster, because
>     the actual deflate runs natively on the host instead of being translated.
>   * Real OpenGL/Vulkan games run under qemu-user: SuperTuxKart and Hollow
>     Knight are playable, with their graphics calls going straight to the host
>     GPU.
> 
> How it works
> ============
> 
> The guest makes a system call with a reserved number (4096 by default) that no
> real Linux ABI uses. Its first argument selects a pass-through operation, and the
> rest carry operands:
> 
>   syscall(4096, op, arg1, arg2, ...)
>           |     |    \............ operands (pointers / values)
>           |     \................. which pass-through operation
>           \....................... the reserved "magic" number
> 
> The plugin registers a vCPU syscall filter: before QEMU forwards a syscall to
> the host kernel, the filter runs, sees 4096, performs the operation on the
> host, writes the result back, and tells QEMU the syscall is consumed, so the
> real kernel never sees it.
> 
> The whole interface is just a handful of primitives:
> 
>   * query a host attribute
>   * dlopen / dlclose a host shared library
>   * dlsym a symbol, and read the last dlerror
>   * invoke a resolved host function with a void(void *, void *) signature
> 
> That is all the plugin does. It knows nothing about zlib, X11 or OpenGL, or
> about any library's calling convention.
> 
> The same machinery also runs in reverse: when a host function needs to call
> back into the guest (a qsort comparator, an allocator, a GUI or game callback),
> control re-enters the guest to run the callback and then resumes the suspended
> host call. This reentry is what lets stateful, callback-driven APIs work, not
> just leaf functions.
> 
> Why the plugin belongs in QEMU, and the rest does not
> =====================================================
> 
> Only the plugin lives in the tree. Everything else is ordinary userspace:
> 
>   --- userspace (out of tree, not tied to any DBT) -------------
>       guest: unmodified program  ->  guest runtime + thunk libs
>   --------------------------------------------------------------
>                  |  syscall(4096, op, args)   (only crossing point)
>                  v
>   === inside QEMU: THIS PATCH, ~250 lines ======================
>       dlcall plugin:  dlopen / dlsym / invoke a host fn
>   ==============================================================
>                  |
>                  v
>   --- userspace (out of tree) ----------------------------------
>       host: host runtime + thunk libs  ->  real libz / libGL ...
>   --------------------------------------------------------------
> 
> The split is deliberate, and it is why only this one file is proposed for the
> tree:
> 
>   * This plugin defines the most general interaction interface for native
>     pass-through: the magic-syscall ABI between an emulated guest and its
>     emulator. That contract is what every pass-through implementation builds
>     on, so it belongs in a stable, shared place.
>   * It is also the only piece that is inherently QEMU-specific: it plugs into
>     QEMU's syscall-filter hook and runs inside the QEMU process. The argument
>     marshalling, calling conventions, callbacks/reentry and per-library
>     coverage are not tied to any particular DBT and behave as ordinary
>     userspace, so they should stay out of tree rather than couple QEMU to them.
> 
> Background: we presented this approach at KVM Forum 2025, "Lorelei: Enable QEMU
> to Leverage Native Shared Libraries":
> 
>   https://www.youtube.com/watch?v=_jioQFm7wyU
> 
> The userspace side
> ==================
> 
> A fair point on v3 was that, on its own, the plugin is only half of an
> interface: useful only if the other half (the guest/host runtimes and the
> per-library thunks) is public and specified, rather than a private demo. That
> half is now available as a standalone, documented, CI-tested project, Lorelei:
> 
>   https://github.com/rover2024/lorelei
> 
> Lorelei provides the guest and host runtimes and a Thunk Library Compiler
> (TLC, built on Clang LibTooling) that reads a library's headers and generates
> the guest and host thunks automatically, including the awkward cases of
> function-pointer callbacks and variadic functions. It has CI for x86_64, arm64
> and riscv64 hosts, and the devkit is exercised end to end on Ubuntu, Debian,
> Fedora and Arch. Lorelei and its thunk libraries are MIT-licensed.
> 
> Adding a thunk is deliberately little work, and needs nothing but a release.
> Lorelei's releases ship a prebuilt toolchain (a "devkit"); after unpacking one,
> a single command reads a library and its headers and generates both the guest
> and host thunks, with no per-function code, no manifest and no build system to
> drive:
> 
>   devkit/bin/LoreMakeThunk.py --name z --lib libz.so.1 --header zlib.h -o thunks
> 
> Two runnable examples come with Lorelei, each with a Makefile that does exactly
> this and runs the example under the plugin in one step:
> 
>   * hello, a minimal one-function library:
>     https://github.com/rover2024/lorelei/tree/main/examples/hello
>   * demo, variadic functions and a callback that reenters the guest:
>     https://github.com/rover2024/lorelei/tree/main/examples/demo
> 
> If you do not have qemu or an x86_64 rootfs on hand, the project also ships a
> small Docker setup that builds qemu and runs the examples for you, so a single
> command reproduces the whole flow.
> 
> Because the plugin is not upstream yet, Lorelei currently builds and tests
> against the QEMU fork that carries it. Its releases ship prebuilt guest and
> host thunk trees for x86_64, aarch64 and riscv64 hosts, so trying it out does
> not require building from source:
> 
>   https://github.com/rover2024/lorelei/releases
> 
> The plugin stays deliberately minimal and prescribes nothing about how
> thunking is done. Lorelei is one reference implementation of the userspace
> side. Any toolchain, or another instrumentation framework, can implement the
> same dlcall interface.
> 
> A from-scratch walkthrough of the bare mechanism, with the minizip and
> OpenGL/X11 examples above, is also available here:
> 
>   https://github.com/rover2024/qemu-passthrough-test
> 
> It is fully opt-in (loaded with -plugin) and targets linux-user, where the
> guest and host already share a trust domain. The test cases use x86_64 guests
> and run on x86_64, arm64 and riscv64 Linux hosts.
> 
> Feedback on the plugin and on the pass-through approach is welcome.
> 
> Changes since v11:
> 
>   Documentation only, no change to the plugin. Following Pierrick Bouvier's
>   v11 review of the docs/about/emulation.rst walkthrough:
> 
>   * Both qemu command lines now pass -L /usr/x86_64-linux-gnu/, so the guest
>     program's loader and libc come from the host's own x86_64 runtime,
>     matching the default people will use rather than a bundled sysroot.
>   * Minor cleanups to the devkit download snippet: named the version
>     variable, dropped a glob from the tar, and noted the host arch can be
>     x86_64, aarch64 or riscv64.
> 
> Changes since v10:
> 
>   Documentation only, no change to the plugin. Updated the
>   docs/about/emulation.rst walkthrough to the current Lorelei userspace:
> 
>   * The example now runs the x86_64 guest on an aarch64 host, showing the
>     cross-architecture case rather than x86_64-on-x86_64.
>   * The thunk run no longer sets a LORELEI_THUNK_PATH variable: a guest thunk
>     now records where its host thunk is, so discovery needs only
>     LD_LIBRARY_PATH and the guest thunk directory is a flat thunks/<arch>.
>   * The devkit download resolves the release asset for the host arch, whose
>     name carries the version.
>   * The hello library prints a plain sentence rather than a terse debug line.
> 
> Changes since v9:
> 
>   Documentation only, no change to the plugin. Polished the
>   docs/about/emulation.rst walkthrough for clarity: tightened the
>   LD_LIBRARY_PATH explanation, named the directory-tree listing, and trimmed a
>   couple of redundant phrasings.
> 
> Changes since v8:
> 
>   Following Pierrick Bouvier's v8 request, the guest program in the
>   docs/about/emulation.rst example no longer links with an rpath. It carries
>   no rpath at all, so which libhello.so it loads is chosen entirely by
>   LD_LIBRARY_PATH at run time: the baseline run puts the guest build there,
>   and the thunk run puts the generated guest thunk there in its place. The
>   plugin code is unchanged.
> 
> Changes since v7:
> 
>   Reworked the docs/about/emulation.rst example into a complete, self-contained
>   walkthrough, following Pierrick Bouvier's v7 review:
> 
>   * Included the full source files and the exact compiler commands for the two
>     libraries and the guest program, runnable end to end.
>   * The example now shows the thunk as a drop-in: the same unmodified guest
>     program prints "from guest" with its own library, and "from host" once the
>     generated guest thunk is placed ahead of it on LD_LIBRARY_PATH.
>   The plugin code is unchanged.
> 
> Changes since v6:
> 
>   Addressing Pierrick Bouvier's v6 request that trying the userspace side need
>   only the release, with no second repository to clone:
> 
>   * The thunk generator now ships inside the devkit that Lorelei's releases
>     provide, as bin/LoreMakeThunk.py. After unpacking a devkit, a single
>     command reads a library and its headers and generates both the guest and
>     host thunks, producing all the boilerplate itself. It takes plain
>     command-line arguments, with no manifest or config file and no
>     cmake/make/git behind it, so the whole flow is: download a devkit, run one
>     command, run the guest under the plugin.
>   * docs/about/emulation.rst: rewrote the hello walkthrough to that flow
>     (download a devkit, one LoreMakeThunk command, run under the plugin) and
>     pointed the example links at the lorelei repository, where the examples now
>     live. The plugin code is unchanged.
> 
> Changes since v5:
> 
>   Following a discussion with Pierrick Bouvier on making the userspace side
>   easy to try, this version focuses on that.
> 
>   * docs/about/emulation.rst: expanded the example into a runnable hello
>     walkthrough (the wrapped one-function library and its thunk manifest) and
>     added links to the two example directories, hello and demo. Each example
>     comes with a Makefile that builds the thunk and runs it under the plugin in
>     one command, plus a small Docker setup for hosts without qemu or an x86_64
>     rootfs. Also reframed the section as a dynamic linking function call
>     interception mechanism (tracing/auditing as further uses, acceleration as
>     one use) and renamed it to "Dynamic Linking Call".
>   * The plugin header now names it "dlcall (Dynamic Linking Call)" and refers
>     to Lorelei as one end-to-end userspace implementation. The plugin code is
>     otherwise unchanged.
> 
> Changes since v4:
> 
>   * Added a documentation patch for docs/about/emulation.rst (Pierrick
>     Bouvier): what the plugin does, its trusted-guests and guest_base == 0
>     constraints, how to load it, and a minimal example, with a pointer to
>     Lorelei.
>   * The plugin's header comment now points to Lorelei as one userspace
>     implementation. The plugin code is otherwise unchanged.
> 
> Changes since v3:
> 
>   * Lorelei, the userspace toolchain that implements this interface, is now a
>     public, documented, CI-tested project, with a Thunk Library Compiler that
>     generates the guest/host thunks automatically. This addresses the v3
>     feedback that the interface needs a public implementation behind it. The
>     plugin code itself is unchanged.
> 
> Changes since v2:
> 
>   * Dropped the RFC tag. The approach was positively received on v2.
>   * Rebased on master and adjusted the syscall-filter callback to its updated
>     signature (int64_t sysret, added userdata, dropped the plugin id
>     argument).
> 
> Changes since v1:
> 
>   * Renamed the plugin from "passthrough" to "dlcall" (Pierrick Bouvier).
>     The old name was too generic. The name "dlcall" reflects what the plugin actually
>     does (dlopen/dlsym a host symbol and call it) and avoids confusion with
>     QEMU's existing plugin hostcall concept (QEMU_PLUGIN_*_HOSTCALL).
>   * Made the magic syscall number configurable at load time via the
>     "syscall_num=N" argument, defaulting to 4096 and rejecting values low
>     enough to clash with a real syscall (Pierrick Bouvier).
> 
> v1: https://lore.kernel.org/qemu-devel/20260617130742.769234-1-functioner@sjtu.edu.cn/
> v2: https://lore.kernel.org/qemu-devel/20260619045404.820960-1-functioner@sjtu.edu.cn/
> v3: https://lore.kernel.org/qemu-devel/20260622163438.130746-1-functioner@sjtu.edu.cn/
> v4: https://lore.kernel.org/qemu-devel/20260629160217.1637276-1-functioner@sjtu.edu.cn/
> v5: https://lore.kernel.org/qemu-devel/20260701155705.1737328-1-functioner@sjtu.edu.cn/
> v6: https://lore.kernel.org/qemu-devel/20260705133943.113202-1-functioner@sjtu.edu.cn/
> v7: https://lore.kernel.org/qemu-devel/20260708152043.251537-1-functioner@sjtu.edu.cn/
> v8: https://lore.kernel.org/qemu-devel/20260709011945.282457-1-functioner@sjtu.edu.cn/
> v9: https://lore.kernel.org/qemu-devel/20260709025528.300019-1-functioner@sjtu.edu.cn/
> v10: https://lore.kernel.org/qemu-devel/20260709170437.363560-1-functioner@sjtu.edu.cn/
> v11: https://lore.kernel.org/qemu-devel/20260710212601.583352-1-functioner@sjtu.edu.cn/
> 
> Thanks,
> Ziyang Zhang
> 
> Ziyang Zhang (2):
>   contrib/plugins: add a minimal dlcall plugin
>   docs/about/emulation: document the dlcall plugin
> 
>  contrib/plugins/dlcall.c    | 248 ++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |   5 +
>  docs/about/emulation.rst    | 158 +++++++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 

This was merged into master (c149f7b367fe85edd1c438ecfd876f0c80a6ab11).
Thank you for your contribution!

Regards,
Pierrick

