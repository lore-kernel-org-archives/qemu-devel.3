Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31F0CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wacKl-0003G2-Qo; Fri, 19 Jun 2026 12:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacKj-0003Fd-LB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:44:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacKh-0003BA-DT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:44:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDCXRW593606
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9RMX4lnKKsdvca6N4HqyiuCk02ea6GmA0JmWMyck9Ic=; b=KqwtkzvWkDUE6NEz
 u6pKQeFK2qSRuWur53cDoykVuePwKGWz3y65zMDDwt+LBHmcecfgG20ZCIAdigfm
 brlP0zlx1gdkxs5HFTSK6VXsHUJX1LsIUIQSCFVx7LHI3FkMWvP5AKRLodDs7ul6
 7FqV0DM/KHH/lO2Oa/mkAYvWx6xUjWcjEHMWJK1doW3Rk5CXk/NX50CigvvS23RV
 Acf16Lb38OP9VjTnQePHLwZJP6fcaqZKza+KCrtjh2KpK1D34bUaF3TOHXzAKPWN
 8JnskLkhEZbNliCXr1d+j/ZpQaSlhGbox3TvF61ft6wO42fXE9Xgf9ZNiGYPJhCd
 eA+0pA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sc3y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:44:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso8105113c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781887480; x=1782492280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RMX4lnKKsdvca6N4HqyiuCk02ea6GmA0JmWMyck9Ic=;
 b=jdKXNYak4xXLECcG1wyo65Wl+ROz0Q+I/kEj6ImGKw0d6TBQE458q8dNCnRzMWCwqb
 7iQhu6QCw1NTd/4NgY3cP4em8TlKElZideN2s8M+e333k6r7o1sT/Qtrukqr1yqLjzww
 t/3pTC30O/bCm4ipU+yjQflZGZC0GD3aLAaPHEk7ROO8NhNo6cL9IWKltAqSw3sq9A0u
 xnhrPWO2ihui7fnDUmytJgEDIzrM+nd3MullFLdpSMLmaYug4HKXjWV+r0P0/HEwJcmC
 VfZVjsfZZHOAqv7zZDrsKISFfnUmb/dUzbP3w4cMsYUa2S1+s2H7mSPVxhjhG2ZHfUlp
 xxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781887480; x=1782492280;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9RMX4lnKKsdvca6N4HqyiuCk02ea6GmA0JmWMyck9Ic=;
 b=DxJHUrDrXCEhdUg4l+PZXaWv1Q8Ug0HOFQx7iy7bidoTN9pzv8UFqYJ2RKKt9miq0l
 fSvDZmW+qj2JD0zJVjcnKeDcaLY+tF1EyV3tjK1+kZDbgkCCO0lZXsxsBPxPrvrOjM6b
 hThmpcqjqY9K33k8wexh0zJ96ChlxbXs1lZiUu+Ewv++0KX11PeGkckXEUr8lNFPF+Hp
 xFjSDb3o0rkvVq74Tx6j/CVib0ORB7/fnvCQBWtx45p3QuHN22V5to0gxqZvrOPzKyEf
 +ShiFJxuB8fAkuWn4yxZ9l+gN6m5tZxVJPUbQopOh6Jp+7lEMnxTZ5P0QWDEtWfKE7OM
 0M5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xyQzV9WtXHMEyXb0dHZZooHF4cFbKZw8MN7K4JhDARJ8mfG0wnNfcWEMOJqYK4B5YS/QrtgKJLyIs@nongnu.org
X-Gm-Message-State: AOJu0YzrvLqobDSnWJf+WgVeHL8ziCYWpzpkZSWaa+symtYwacl+NYnk
 rPEbcYSzblATJ5bMy3yEEE2bCn0VWfqihPmZ5C1lWvQdKX0Bjz+jBFZ8Y7GFsNXWzJ2M2qdbXMv
 nIqJvMF5rCm4536MvMK5BUexMW0zgN9u8NVVAUpXzIbcaGH8EDVN9Y6Ygmw==
X-Gm-Gg: AfdE7ck5y930ICL3ldnz6osJNdduX7S4yNXcQR0S+O8Y2NTOJfxZlHwhFUBUMNhSZYZ
 SlZwJ0QJv0qzNo2ME83se5hSIhE/QlkNxUrdWZja6MmXnFDilYmQC0Ib+VYZD0bg+ENb9QQjq5E
 ELGURzOg2lS8cVsdOzC4qZAR9eWBKdmzTkHgQq0CJNXWOnbVnrwUvldL6ieDiEldIVXP3dNQZnZ
 /SG7z6LLE9sDVs1s9P7gwtFPmPRtaCNMSD5nrqDV2AWqmpmoE0tBF/WR/GwiSDfg/loI9k77ibJ
 rt6t4YEF6LUaeQmAs+uPrZwq6MZ0urUaHfT2X38PM+yFEEx3cvIqle1jGRLrU4p3a/niH6ZFPwJ
 ho1BmVUyqAOKEfrCWybMrqL2KuD0qeCac+/v0Bxrntb1meajUyDNexwq9+GaIFL85hwwZSTxD/4
 VbE5Y=
X-Received: by 2002:a05:7022:ef03:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-139a50611b3mr1403155c88.33.1781887480313; 
 Fri, 19 Jun 2026 09:44:40 -0700 (PDT)
X-Received: by 2002:a05:7022:ef03:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-139a50611b3mr1403137c88.33.1781887479672; 
 Fri, 19 Jun 2026 09:44:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a34ac0d8sm1891895c88.6.2026.06.19.09.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:44:39 -0700 (PDT)
Message-ID: <ef66ef33-22fc-495b-ab2b-dd4db88c3d8c@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] contrib/plugins: add a minimal dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
 <20260619045404.820960-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619045404.820960-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vADPs-V4u7DOQYx9BXRX-OajXGDkUXBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1OCBTYWx0ZWRfX1CsSDDa4Ec0p
 0lQaMhCI4uqLrrO0mDm3GH1KQDM2YfKONLBij+y4JNsvAXUc4enM2gKhivTskTdKOqcIpr2WkAZ
 4NgGZnvM6hsJIYxpazcZWwOxHCHmfwZyUBzEKQtKgEvENnxAGZnwToR/QNuAPEup5aHa3lEWzYL
 YhFiKKnKaLCvyje9v48pREs828SWGb9dBP96JmvSSGeVm2PGg9CUTJJZzGLyztSM6LlOsl3yL0+
 /sO8VOKIlhvhdi3xF697KwWkTtS79uAEv43iS2/GNErlg+jizJhaG4Vy9bKi6C7EavItroY5yyZ
 ahRYHjFhjoW4aQWAuvyYYObjsigVU3a8v50Pl1W7ClDf2bYhuGrdb26Y8DR3cH83wKLf8kcVOve
 LFIxJmLs1D5TO5my6vrFDpD2Q909easWtKJAX1SSi2pxFG61p2tIF/wWocw63RTOaYwwBR17twS
 mqxP6pIkMowMLsPD1Mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1OCBTYWx0ZWRfX/aksRA51YcwG
 xUKCpbqFAXgmmcZp+BFdpCOAH884F6Y60UcRXVHe+MTZPYpeed80j0ETm0WKDASUppLag7KXDyl
 f9WbZ9S0hDyFzpw0WmjZ7zQv843MIgQ=
X-Proofpoint-ORIG-GUID: vADPs-V4u7DOQYx9BXRX-OajXGDkUXBy
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a3571f9 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=vnREMb7VAAAA:8 a=kafxrp2RFV4iMQHY2bAA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190158
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

On 6/18/2026 9:54 PM, Ziyang Zhang wrote:
> Hi all,
> 
> This RFC adds a single plugin, contrib/plugins/dlcall.c (~230 lines,
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
> You can watch the demos build, run, and report timings in CI, without checking
> anything out:
> 
>   https://github.com/rover2024/qemu-passthrough-test/actions/runs/27671747420
> 
> How it works
> ============
> 
> The guest makes a system call with a reserved number (4096 by default) that no
> real Linux ABI uses. Its first argument selects a pass-through operation; the
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
>   === inside QEMU: THIS PATCH, ~230 lines ======================
>       dlcall plugin:  dlopen / dlsym / invoke a host fn
>   ==============================================================
>                  |
>                  v
>   --- userspace (out of tree) ----------------------------------
>       host: host runtime + thunk libs  ->  real libz / libGL ...
>   --------------------------------------------------------------
> 
> A complete reference implementation, with the minizip and OpenGL/X11 examples
> above, is here:
> 
>   https://github.com/rover2024/qemu-passthrough-test
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
> A note on automation
> ====================
> 
> The userspace thunks in that reference implementation are currently
> hand-written rather than generated by the LLVM-based toolchain from the talk.
> That is a deliberate choice for a demo: the automated toolchain pulls in a full
> LLVM installation, which adds substantial setup time, and the example projects
> are slow to build and cannot be reduced to a single Makefile. Hand-writing the
> thunks was the cheaper path to a self-contained, reproducible demo -- and it
> was already enough to get minizip working end to end.
> 
> For real, large-scale use I will rely on the automated toolchain. The key point
> is that hand-written vs. generated thunks is entirely decoupled from this plugin
> and from the magic-syscall interface it defines: the toolchain only emits
> out-of-tree userspace code and never touches the in-tree plugin. Automation
> becomes mandatory for complex, callback-heavy targets such as the OpenGL/Vulkan
> games, which is the direction this work is heading next.
>

Makes sense, thanks for your answer.

> It is fully opt-in (loaded with -plugin) and targets linux-user, where the
> guest and host already share a trust domain. The test cases use x86_64 guests
> and run on x86_64, arm64 and riscv64 Linux hosts.
> 
> This is an RFC: I would welcome feedback on the plugin itself and on the
> pass-through approach in general.
> 
> Changes since v1:
> 
>   * Renamed the plugin from "passthrough" to "dlcall" (Pierrick Bouvier).
>     The old name was too generic; "dlcall" reflects what the plugin actually
>     does (dlopen/dlsym a host symbol and call it) and avoids confusion with
>     QEMU's existing plugin hostcall concept (QEMU_PLUGIN_*_HOSTCALL).
>   * Made the magic syscall number configurable at load time via the
>     "syscall_num=N" argument, defaulting to 4096 and rejecting values low
>     enough to clash with a real syscall (Pierrick Bouvier).
> 
> v1: https://lore.kernel.org/qemu-devel/20260617130742.769234-1-functioner@sjtu.edu.cn/
> 
> Thanks,
> Ziyang
> 
> Ziyang Zhang (1):
>   contrib/plugins: add a minimal dlcall plugin
> 
>  contrib/plugins/dlcall.c    | 229 ++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |   1 +
>  2 files changed, 230 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 


