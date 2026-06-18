Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960B5CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waMO7-0007Kg-RZ; Thu, 18 Jun 2026 19:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMO6-0007Jm-H7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:43:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMO0-0007aY-OI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:43:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ILsX6j2820397
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnD+URf1M8cTC/Inmi6rQ98ZPRy0Qj5+0XjcHBLsVh8=; b=J3P12f+r9HusQ+RN
 D9zhdYnKfkMHNvB19YOL7GE+h+aM6trgoj39/BCMdZBoqjtAZY+dbZUtRFbtFgvb
 Occ/N1/DUKq9B+RNwXbOW8BqlXHilMkdrULGADs3wni/3LiQblOV6dYuvSz85Uxk
 QwiL8FDjnBcNr390Bptl8aZAzvcX3PtqLJIIvGGx9pc2qMutd/LgZREGm3JduyH+
 ABfAk///blYDID3PinlYiJ+0KPHmS3Zu5SbIIsa7wbQri2XgwZRW12PV1cXXLagA
 zmzBctvZIc1aobbjZvbckQ6KYiTSe/3wII7dBOHRWPZrjeOde0wCg1n4VBOTtqRj
 maF5Pg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s95gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:43:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c03c1dda3so2642546eec.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781826182; x=1782430982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KnD+URf1M8cTC/Inmi6rQ98ZPRy0Qj5+0XjcHBLsVh8=;
 b=JPJF5NE+9OHAJ8tl3R3cPzdqQHGSRox33z36r1Wi+aBqLiV8gWikBEPo90DuO7EQzW
 jXqRqL48GQEfon3txVlxh3a3LRVOo24Sej7oMq6R6XbF/34jbZtC3YcgG1mgDyppHI0f
 KQKG/BjA69S95db8HIjBVbcAuBwDUmCVlleOFPFvjJD1xxzIzLVkW/pEsgD//kA3CIcT
 utuJFH+cv8VmViblnepgBFtzQaZl/XyVqtSOCL/KaWww5XZVI1DtWNAEEs8Zp9PYt7Wu
 X+VOQV6vsKX0oX1DN8FNSQbyTb3F+K/rxd6MrwM63CzBmCXAKsc+iZMeqe5+OzMqrC+E
 CUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781826182; x=1782430982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnD+URf1M8cTC/Inmi6rQ98ZPRy0Qj5+0XjcHBLsVh8=;
 b=m0EI8YWZ9VyjLV+0arS3NwS2wIAtrF2n3pH55mBHm0mb9uNxHx4WWpAj6SCL2jGlVu
 GrDpwFBjq8sBajS6EYmUmyU2JbLmXojk9++p1M73tCbwsbIIgRgw1nGFuRKc5AlLVnki
 EyMgdxWeD2wprBft1ElJfW0WvKj1hESlqhcwLu79GvLnZlDnNUcr11ZsC6bSx6ratKeH
 Lwhn5h1VZxfG963+rZwuN9yTVjFqURoSuUc6jXbRt5VirFrGb+FrvZHXQPejfrC9ALBE
 LfDGSxwX1HADIE6P7rw1/slgzp7vyYgklRnXviuQHmaSiv7ZQPfVaGsN388YmdQToXMf
 M6HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ieQ7VtYQNvSI59Cspu0sSf89eHLDkU8UK4XG5Mw6UO6F1L1hdgAjyPSt/xpp7kf0QXX59ZXOC44hH@nongnu.org
X-Gm-Message-State: AOJu0YwP43izkO11PJVyBz0eQvh8dpU2c2WKvE4freCfqfgGQKNroNGc
 Sfu6QRsUg3w/Jzka6gpjfy/CokTGAJ+T11jPozbFl/eaM/fOXFANYKfRvia5Hicv8Qbo6o6DOjd
 UPzmtJxaNxph8F4ygIzAaEZE/5FUen28biRIE9Do7EFO0a5W3SL+QiDtbhA==
X-Gm-Gg: AfdE7ckilVmJtF1j2hcE6JQ3/mPCbfFJkHrBsqUefhaGotMT05TFfGSEdMtkVTE4RLG
 ENdqwCXUX4bHVY+on0v3KC+28/SHKhQ1VUMSqL1WDCXvmJugndtaYI5S0O+LO8ZZkI9dDApdzUQ
 +D1h6rBvtPMXpxBdsfsdvxt/l7jY1o8mZiQ/0aErdeaDsMYkjWXRloNNjkbfVBVdX8PmjuBb5eG
 cEunqBQ1TVaK64QiTVm67BzL6IQAb6Fnfi9w5v5PiObhsnduK0QbXht5/V85qjZ/vLaw5SmTGWL
 uJIXYyAos22X4glGBSMe5bSFVXA10QjVphEBJmTO1OsthlKK2YWRXRQUS7Y3RNlILGASVuPrf+k
 XeDqYJ1O+1/01DRIRRU/YWaUAIHUv1gnzhXPT1j8iyQfuJnIgfJyfGabu9HEmt5R47bW70wwxA8
 i16/Q=
X-Received: by 2002:a05:7300:c89:b0:2db:2089:460f with SMTP id
 5a478bee46e88-30c071dfbe8mr1024479eec.19.1781826181619; 
 Thu, 18 Jun 2026 16:43:01 -0700 (PDT)
X-Received: by 2002:a05:7300:c89:b0:2db:2089:460f with SMTP id
 5a478bee46e88-30c071dfbe8mr1024459eec.19.1781826181013; 
 Thu, 18 Jun 2026 16:43:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c05ff4b4csm1005820eec.0.2026.06.18.16.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 16:43:00 -0700 (PDT)
Message-ID: <214bfeef-3f71-402c-8d08-56a5a10e1e62@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] contrib/plugins: add a minimal passthrough plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617130742.769234-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: odiENkVqLqtooij2GK0mKqOGevvELuI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX2k/kj/dYsNXZ
 sMsEHjx/CUpSaGscCJWmvUcok1lu57i+ui7Ad8hejTwhiXN/SuY1+/0GvEHIwaS0W97qi2gElyh
 pmNcUJcAcDwNRTWpL3EM2WgWFHnNWN47DLKznJnEN0JInng48ANdzFiv4ojAroOf2s3hTOqJXJG
 VmvULJTlxLsHegpY+PyvjfFf5fbAnN4pSwM2CcNtcpjYa+J29aHbpREJD1sOOT+9nfqMY0XCA9O
 vgVU+fgm7LW6pOq8Brb/U2Y2dW7FzVrNfDZmQf0OxFbkxL4aclnLxLIt31oLQtGgoax9cGYXdd/
 bM0gDVZDRcdedka35iy9Tv7fBpDZ3NAoySgxK7JGXShG6pi2lOKO/l0ct7AFQQ83LI+NPP8IY4C
 LkyRyz+4EpHJGQTzmT8GRi8RI2BOVZmTPxHqG3sSXIGWqmuZpo6by69Ci+zO9aXg8fDrcSgmDvQ
 rbkrhOP1flwSDfnbZqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX4lRNmES8tx9f
 axZZCuwnV+R0uAqqIX0snItmRU0n3teAH2BalrEtAjBgglWsYtFKeovnfsFrvGPjVeAEzIM6xRo
 lzeB3eKJFwCz57H15ZDBon5D7E5Jhnw=
X-Proofpoint-ORIG-GUID: odiENkVqLqtooij2GK0mKqOGevvELuI6
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a348286 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=vnREMb7VAAAA:8 a=2FIa338lGi1r8r8f4fwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180216
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

Hi Ziyang,

On 6/17/2026 6:07 AM, Ziyang Zhang wrote:
> Hi,
> 
> This RFC adds a single plugin, contrib/plugins/passthrough.c (under 200 lines,
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

Thanks for doing this reproduction effort, that's nice to be able to see
the result without having to compile that ourselves.

> How it works
> ============
> 
> The guest makes a system call with a reserved number (4096) that no real Linux
> ABI uses. Its first argument selects a pass-through operation; the rest carry
> operands:
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

That is a nice and clear interface, great!
I think it's something you can easily port to any other instrumentation
framework, once you access to any kind of "special" calls.

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
>   === inside QEMU: THIS PATCH, < 200 lines =====================
>       passthrough plugin:  dlopen / dlsym / invoke a host fn
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
> It is fully opt-in (loaded with -plugin) and targets linux-user, where the
> guest and host already share a trust domain. The test cases use x86_64 guests
> and run on x86_64, arm64 and riscv64 Linux hosts.
> 
> This is an RFC: I would welcome feedback on the plugin itself and on the
> pass-through approach in general.
>

What will be your next steps from this?
From what I understand, the current passthrough example has entirely
been written by hand, and does not use any specific toolchain like the
approach you mention before. Do you plan to use that again?

Once this API is stable is fixed and document, you'll be able to add
that to different instrumentation frameworks. You'll need a nice name
also, or at least something less generic than "passthrough" :).

> Thanks,
> Ziyang Zhang
> 
> Ziyang Zhang (1):
>   contrib/plugins: add a minimal passthrough plugin
> 
>  contrib/plugins/meson.build   |   1 +
>  contrib/plugins/passthrough.c | 187 ++++++++++++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 contrib/plugins/passthrough.c
> 

Regards,
Pierrick

