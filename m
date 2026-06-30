Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D737C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 19:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weeEn-00056s-Qv; Tue, 30 Jun 2026 15:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weeEh-00056X-Ql
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:35:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weeEc-0005sc-HB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:35:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDcun2873527
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 19:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /zR/gsmH4RBOML9kFWUObCN/Jwe53Sev0HqZwoUk+ds=; b=UwuEY3bn2XJXxNzg
 BDyBOug5mCvCWr6gj8HcwOyWdSis22q3UkKLX42yet1+pKZOIGF4vIkfz5QDg/OM
 IU5obreskdYZabP5U2G9S7LW4iKJKDLoqYKG5d4Iw6cRPWEKIfiUfrpf2M+tHwCd
 NEV9xTrf5ZLM/dre1aSqpFWZtNG1H4PwbH6/joI2J3deJeGy8AbS0A9kg5FAfC7M
 1/nhBT4gCLH0T2Kt31lOARm/ASPy+SG+p6xpHoBaYBfRzGxJYBKSLPTB7sf9U0Gr
 n7qtFIWJORUH8mg9jJo4xnHOhE/LfV5/o09U+KJj7YJPDLQ2tWI6RR2cr7hQ+A3H
 2WVMxQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sg99d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 19:35:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c62861b3bso15097681eec.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782848103; x=1783452903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/zR/gsmH4RBOML9kFWUObCN/Jwe53Sev0HqZwoUk+ds=;
 b=ctwz/+9U6OoqPIMIefOoHY6LO5BNpsP/n5NdjcmWIhVLHsQBKQVgKbizvTt8cQIUOX
 NFxwyPeWatIlOaio6E/Mnrz1AupPiLHvD7CfDuGANUcwirSlQt1oG2qvtq6z5aFfNw9l
 pN4HqnUH8DYuX4qqvY6uqRNQWw0iZEFNIu6ZNSvsHZDsxjGXSZnBlq7oZU2+mMEHWlm3
 sdksbeJvMVZhyaP8mKwsi5G0qHvAsyrfGWRydSQxTXVcMNs6GBXqpT+iYu/ugyUPGjRL
 8CBrM5yY5tbgIIOcDPWoSeLjrpc7TyLQHcvHdmBbbPOrQIzO0cfyHA0DvCRjicj2mHJ5
 i/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782848103; x=1783452903;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zR/gsmH4RBOML9kFWUObCN/Jwe53Sev0HqZwoUk+ds=;
 b=VYgAxqYvVgFnSPgqQ6IpjkUiqGi6+2c/F3YV3LgvIiaJDu2nT0a3oGHsmcAI0xxea2
 aAYehE0/Dyi1UVeqfbdBBH7mZKMT/mrcKCK+pPVE+WDzkCmj5ctP7ppgMNi/CgrXWWtN
 YnWMB6Bfxp/itDBODeE+fSNY3vPDzEp22polpAspMoxVhxLcAUfvT2o4KR20s2JNV7MW
 apuoFb8keKTNCdDTLKWBv3YX32buIWnvkB7NA0sWwI5GabFqHKZFoD4IPwocWKViJ26q
 Rp9eVU3KLcw4lpHHihqSFcBoQ+Tqtq38nFwc7+mVX0Jp2C03XCjAHIaJ8/TPBViCfEgs
 Wckg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnDkkDb/ISk+vUH9Z4KBbuIuKf/YyN0GMq3/mK+KRv1u7VS/9d1wGUwz+E22puMpH+HmFCDMXxqeVB@nongnu.org
X-Gm-Message-State: AOJu0YydM6XK+ctbGKdOKoaueBASrCUPY2hSpoaFriLY2sqX94iclPDh
 ZtLwpIJwKWMwP7wgfFPTSvxtBe9KN684Klu3wlauG7I1SN6yiAVxB3se71UErwDNxrRPw0MsumM
 +7HKNFkNEgXGERlxbJQO2ME6ajCC7nDtlBEbtzrSU7cVmnm0jvEmU4w3hgQ==
X-Gm-Gg: AfdE7ckEMA/EUfV7esoC+6og4xTQBxUF33bVvPLZxhty+5kCfcywdyeCzlRv3qbQ+1L
 AYiSullYs3YNExz9wRqD9Mt76d6D+ndqbTz0q8OOnMT/AumkhOHD6iyJ52aMaUjt+/iQPuq48UK
 GBzyW/f7KGBdY0QnFYItsDz4ZCM0t68ZoW4CgScqoSfV+Cciu1+K8L7Ceu+bLv7bm0SBYSdN51C
 rrewKwBKH4N5p/MLQ5pGOHTe1UgnnxBgnH+zA1GqimBaXE+djWFwcmFczPE0bwUB/VFQisSo0xv
 MQs3BJJisD+TEJBtP+fz/PmtGi01tsyOlvjZAHO+4uo7oKe7A9SRqOlCZXumYaFE7vwHJ3WfjeP
 ua/5Y2q0eRV9qF3hnkslbRhMzSWnnWZL4r7fnuuUFoRwQ5/3WhT4WsB8Hk4mZovwglt7HTbj15X
 NToPo=
X-Received: by 2002:a05:7300:2141:b0:30c:1865:d9e0 with SMTP id
 5a478bee46e88-30ee12287a4mr4103403eec.16.1782848102611; 
 Tue, 30 Jun 2026 12:35:02 -0700 (PDT)
X-Received: by 2002:a05:7300:2141:b0:30c:1865:d9e0 with SMTP id
 5a478bee46e88-30ee12287a4mr4103335eec.16.1782848101856; 
 Tue, 30 Jun 2026 12:35:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2f5c4c3sm11065701eec.2.2026.06.30.12.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 12:35:01 -0700 (PDT)
Message-ID: <42297965-3d92-4d9d-ad6f-4861841d4806@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 12:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] contrib/plugins: add dlcall to call host functions
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
 <20260629160217.1637276-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629160217.1637276-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o07AFz4wZ3oMHDUftWpHP1g3HmrK9xTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4OCBTYWx0ZWRfX/wCxUHI+nz/h
 Cf14Tk7X+oR2n/qhmnrhWDyquGOa+Lo+rnCFSUb6v1DRGUqz6uwGFxuK4u53XvL+Pq4KnSZXiPK
 vcnmJ0nKUoL/LU0ZFB+iTpSilDDR1V/VbcOQc3yTUB+oulhGeuUMevjYuqRn7qPvIBq4Mm1GbYk
 eZRbXNnxGnyZqL7zCPhSo9Un6N3bhnHtk0JnFHvhh2qCVnIMjNkQ12Ckk6iYfZ8b54LGum65UKy
 P8yvUsdqo7wWF3GjyxTVrw1zd9woyefqGr7ippQ/tInk0EaiTz06f+RzxYOkIPlTHqCWj7G61g+
 BVTTKC4q6DBdC0UooT41Vx4kIxWor3v8+Ow4eUlLnB+Dww0LrlVx9HIAiFHr1w15171Q3DbKeOG
 mzwlRbYZlapUw5m5h0Pdc1Qj4cQGWRV+rJln/OEl0CPot7RqogDWX292ESh3w8NQKk1eypjQD2X
 7pEXHxRf1DH3Nh5yH7w==
X-Proofpoint-ORIG-GUID: o07AFz4wZ3oMHDUftWpHP1g3HmrK9xTV
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a441a67 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=vnREMb7VAAAA:8 a=NEAV23lmAAAA:8 a=zZ184FFN9tnaCs_wFtwA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4OCBTYWx0ZWRfX5h9q5MocBrfx
 MhNT4fUW4t47Kla3JMnA06gFthdJUgSnyGLDYeoRS81+YSDEfhurKiNv8+NFkfhzt8i78Wc7Kaw
 2kt6eZvI2kpMviHAlvuu2SIy135IOpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300188
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

On 6/29/2026 9:02 AM, Ziyang Zhang wrote:
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
>   === inside QEMU: THIS PATCH, ~240 lines ======================
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
> and riscv64 hosts. Lorelei and its thunk libraries are MIT-licensed.
>

Thanks for publishing it.

A few ideas to make Lorelei even more easy to use:

Would that be possible to add binary artifacts to the existing 1.0.0
Lorelei release?
Ideally, it should provide a toolchain (for x64 hosts) with support for
x64, arm64 and riscv64 guest thunks.

Also, would that possible to provide a script to generate boilerplate
for thunks, and extract list of symbols from a given library?

My ultimate goal would be to have something as simple as:
$ wget toolchain.hostx64.tar.gz

# automatically generate boilerplate + compile guest/host thunks
$ toolchain.hostx64/bin/generate-thunks \
  --arch arm64 --library /usr/lib/libfoo.so \
  --header /usr/include/foo.h --out thunks_arm64

$ aarch64-linux-gnu-gcc main.c -lfoo
$ env LD_LIBRARY_PATH=./thunks_arm64 \
  qemu-arm64 ./a.out -plugin contrib/plugins/liblorelei.so

I understand it asks for more, but we really need to make lorelei as
simple to use as possible, without pushing the internal details to users.

What do you think about this?

> Because the plugin is not upstream yet, Lorelei currently builds and tests
> against the QEMU fork that carries it.
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
> I have deliberately kept Lorelei out of the patch itself: neither the code
> nor its comments mention it, since I am not sure whether referencing an
> external project from the tree is welcome. I would appreciate guidance on
> where a pointer to the toolchain belongs, if anywhere. For example, would it
> be appropriate to mention it from the documentation patch?
> 
> Feedback on the plugin and on the pass-through approach is welcome.
> 
> Changes since v3:
> 
>   * Lorelei, the userspace toolchain that implements this interface, is now a
>     public, documented, CI-tested project, with a Thunk Library Compiler that
>     generates the guest/host thunks automatically. This addresses the v3
>     feedback that the interface needs a public implementation behind it. The
>     plugin code itself is unchanged.
>   * The documentation patch is held back for now.
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

Thanks,
Pierrick

