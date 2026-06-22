Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C62CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbiGH-0001aU-Lk; Mon, 22 Jun 2026 13:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbiGE-0001Zy-50
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:16:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbiGB-00085m-P8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:16:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVn6g2691749
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 17:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /znPFFrrIfogKvVfRezdIMEIEPV3TtZEeJ3S3zkBPaM=; b=S73MzxOPo8gkj/2L
 dfA9Vt4pLEt6BfQkf1L63m3eUdNQcKzq00sdSyGOBzugEITCOeHpW+/+iuCSxSfn
 UmRnVu/GxPKByT4u8UPLN/siPGktJG7V2SrFlt2s72Bfx39GsGMrJBD4RUnTkKzA
 uS4/j85v7IDBD7hSLRknJ8NQ6Y7B58o11ArAGGUt/Mm+rKDY1gG8ZTSGTK/fKrz1
 yGrcCp8IK5lZazqkGICP83cGsdqL6QC3rxCzLUJkRxUJMleTYlHStpS9fjZBH4XJ
 Ae5/CMSy4cWn1gHKJ2ST3lJi42TebLaJ7ha/BK9xAhXPq+HZLuTdDDku0OWYTTU/
 Z1ObZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn0x03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 17:16:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bccca5620so6341069eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782148593; x=1782753393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/znPFFrrIfogKvVfRezdIMEIEPV3TtZEeJ3S3zkBPaM=;
 b=BB8IeUG1d9KPvHo7GEafEkXm94jVdtAYjyq7znbw3+9UGWhPkIarYwIQ9yoU47sFWK
 hNT2ReC/NFgwWfa/ntipbH3bQVRGleEAWXaImts3neYf2zkE9+CMoVFf+IdEFLPDtpO2
 7U1zJM6OQsq5gkoauDGlgrvhEv+lqrmN/lp7iMQm4Rb9d0cugBnjTc59Mc6HTAWZOAG3
 /4HuY6ai9xy8MPJz0DCXwArGnOXCHBbuclkTc6G8BFq2CscbyOnG2rQOXYyfmbG+h1v2
 0toj9NZrlMnvLI2azWFBn4ETuZVZdjRtH3GNeh2hjdKcZsnPnxDfS1CDTFVHE84qCRNs
 LLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782148593; x=1782753393;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/znPFFrrIfogKvVfRezdIMEIEPV3TtZEeJ3S3zkBPaM=;
 b=iGoPDAqqvSFF2uoIR0TbcPG9eX4uWX51xwIpEpq/QQ3PwYaUydgdafdV1TIjSiWBtl
 d2/G/PQESYx+vb3SNt+7uO9nF5FHIlVdqtVTTv8DNEU6vqv0ZoMUo9c+UTc4YhrUUfkK
 ESo/HpoSiq2WEnPSGSVjt6GcTwRjZzGXWe1Wvt+sigTOoZFoBpeQNTmx0O+4aTnyQAhi
 38D+ggadWYxikN6cC1CvgH2E4ZNJxYn266Bet6ylB+CDIFHqvkTcDsGF+ugeSed+HySR
 fyY0QqxRCekpDOkOsZomRTNAWOAah+4IT4t5dzDwEtvNnFgv7kyIIlsMsjzi20jKgXxU
 PSFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOmhJllgiyIKxi6LOorzYzTbST0o//tLsMOsfYAQcpcpV4oSY4ORvEZpHCE65r+jykTBP37kuFr0f8@nongnu.org
X-Gm-Message-State: AOJu0YybVss9KGYg1VY5oF1BQEaa++f3q7Q+rP+67SBSEmURBakr2V1X
 tSeoNGpUOg5fIFKNtR5Bnwj0f6Z5cyaIqylKFMKkBCoE7PzITfRccoA+pzqWx3jSA4DrI5aiA52
 osP4t2ZFNhdXbEaqkSJaScijqspgrnopaq0peBav6w2wD3aahyif9U9fCaIfQsfbDDw==
X-Gm-Gg: AfdE7cnJZ0Z8vAXxlrlZUWYF+6JGurRvHjvDMZL1CIQnyFAyNmEHsVtwRU/679e+icQ
 F8MtVIwcu0w0aZQq/il/MZAyxp0nObHgPDIQexQjpAKOqUJuJiwvoIaE8HXXhPZsQwujIRoXGCM
 sJzHf8763z/0JRALPnlI4WIYidjVNeU8X2XZTA6+1jlLm2P56SXcm9nfnByuhle9mGHymLuOtyV
 Re6mf/VVIuZjLYr1aNAOvLiYVwyX544VDfuz49/tYKRrRRQThaq9UqAAwYQh7eRPsOohe3vUVWT
 opSIoq7XwB7A6lcnbfc06Gxm8WADF3jLP9pfXWkeDZGoHsw6lWgPfWCg/WjCbwmLWHJNRI2d2DY
 /pI+nRIZiNoXnLDI1oCYIXHsTy3h/kJd3q+Rv6AsGVbucNAT6mJ7mNwot2Flm0mSgNIVIgT0NfG
 AdLLE=
X-Received: by 2002:a05:7300:3c14:b0:304:d75b:f5df with SMTP id
 5a478bee46e88-30c070018bemr10612522eec.19.1782148592626; 
 Mon, 22 Jun 2026 10:16:32 -0700 (PDT)
X-Received: by 2002:a05:7300:3c14:b0:304:d75b:f5df with SMTP id
 5a478bee46e88-30c070018bemr10612460eec.19.1782148591774; 
 Mon, 22 Jun 2026 10:16:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1be4967fsm10278671eec.26.2026.06.22.10.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 10:16:31 -0700 (PDT)
Message-ID: <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:16:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622163438.130746-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t1OxJVPBAcM1c-ImT-tAdR6iDpO4gkqu
X-Proofpoint-ORIG-GUID: t1OxJVPBAcM1c-ImT-tAdR6iDpO4gkqu
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a396df1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=vnREMb7VAAAA:8 a=aekswQGV7fPmxfUWnFEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2OCBTYWx0ZWRfX2bMtEgBY33Z/
 W32Ydrd/B1eoELlztMtQSigd5X3OUvnUf/17Yq+vZbnRlUAGqh21Zpim3cGy/t3neQDbSLyizq4
 wgJF2qTqtKQKmy2qzRrgwfpGWAK2hkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2OCBTYWx0ZWRfX4voV/BDKaGEJ
 wTtXaXFl14RmPM6ajFfYihTIjc7ZtMimiix2t/CgT50vbErT4dU/3+LieMw96tV7ZI8c4cKIsxU
 zHrc1ng8mGWC+M/U6YOcwbYciuBLfK6yohaY+2Q6Xrt0klhVDKDF+aMT6f2iq3EsmejrLy/JWXV
 H30auTMsUf0aINAr2mCEQjUz3/GC9pJIVz8PZwDaXoa90vk0w+f+RNOB4uGbkd+LIwShr+IOqMK
 XKfSEefv0H3zAY1Xo+W2SEig749dY4XxC5G6O01ll1U9rMsWHWlLfoJTWU48JbyvZKttRJH2eRT
 cCamFAE2MSt73cim+6SPRiG2kvqM0Sw0WwV+R0cpDzRhcRYVF9R712J0daZ9rzXGwwmY9f5ULvI
 VQoOxxg/ItseHXCHViFAeH1uZQo/YWMzz3kCKExLmY3dDca+F0JuBURqT8IBw7OvHinwEBr271T
 f9gXtN9Wd6hhfKJxUgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220168
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

On 6/22/2026 9:34 AM, Ziyang Zhang wrote:
> Hi,
> 
> This patch adds a single plugin, contrib/plugins/dlcall.c (~240 lines,
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
>   === inside QEMU: THIS PATCH, ~240 lines ======================
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
> thunks was the cheaper path to a self-contained, reproducible demo, and it was
> already enough to get minizip working end to end.
> 
> For real, large-scale use I will rely on the automated toolchain. The key point
> is that hand-written vs. generated thunks is entirely decoupled from this plugin
> and from the magic-syscall interface it defines: the toolchain only emits
> out-of-tree userspace code and never touches the in-tree plugin. Automation
> becomes mandatory for complex, callback-heavy targets such as the OpenGL/Vulkan
> games, which is the direction this work is heading next.
> 
> It is fully opt-in (loaded with -plugin) and targets linux-user, where the
> guest and host already share a trust domain. The test cases use x86_64 guests
> and run on x86_64, arm64 and riscv64 Linux hosts.
> 
> The changes to the documentation (docs/about/emulation.rst) will be sent as a
> separate patch.
> 
> Feedback on the plugin and on the pass-through approach is welcome.
> 
> Changes since v2:
> 
>   * Dropped the RFC tag; the approach was positively received on v2.
>   * Rebased on master and adjusted the syscall-filter callback to its updated
>     signature (int64_t sysret, added userdata, dropped the plugin id
>     argument).
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
> v2: https://lore.kernel.org/qemu-devel/20260619045404.820960-1-functioner@sjtu.edu.cn/
> 
> Thanks,
> Ziyang Zhang
> 
> Ziyang Zhang (1):
>   contrib/plugins: add a minimal dlcall plugin
> 
>  contrib/plugins/dlcall.c    | 238 ++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |   5 +
>  2 files changed, 243 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 

Thanks for the update.

At this stage, even though the plugin in itself looks good, it's not
something we can really merge in, as it's relying on external behavior
that is not specified or being a standalone tool.

For instance, if we have a public Lorelei toolchain that implements this
for libraries, it would definitely have it's place upstream IMHO.

Also, the same kind of contribution can be done for other
instrumentation frameworks, so we can end up having a single interface
(and set of libraries) shared among all of them.

What do you think?

Regards,
Pierrick

