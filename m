Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B378C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whBz5-0003Fe-5u; Tue, 07 Jul 2026 16:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whBz4-0003FJ-5v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:01:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whBz1-00032f-Lq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:01:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5fwi491163
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 20:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BEFF1c+CAOmB/0s13wZ2llzP5PYbYjAS7o34do5klAs=; b=RCr5/rc9dkvw8OH9
 FQYXqEQrE+lhlZFNP63wm58hWEEMGAXQpRc2GlerrF7qnAK0eVeIqm6Lv2dg0TeD
 qqS1KwosZpGupOWbuK9+bvRfHcgClttOklL6bSKqje5Bie/M4x1ZczSY1xJ2whul
 KyXwNlc0ar/r+ZWZvfxwdaxQNNHI3aswCC/JS49JL8EWr6Q7aAmeINvdPJux3X+i
 zsXojSvDod8GPRQmrmm8kuvT3gT3FTmUuyE2Ba0XHCSrN0k3WjX9r9R6mW/FIa4d
 3Qgs1DbA8DXIGKFl0dFzNp6V72qTSp/qYQ0YOfsGYa86stfdZXld9egC3EOIYEY+
 /RVprw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9abftf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 20:01:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso11691eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783454488; x=1784059288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BEFF1c+CAOmB/0s13wZ2llzP5PYbYjAS7o34do5klAs=;
 b=IaQ4DhopqwnA2DxcvqIBQEaDPEYARM2tH+7CrqL666/Oj4/pMZAG3TTCygLwlJgGKG
 0poAnPLrHIG7BuUuyg6IEIXq66h4O3t9HM4TKiNEmkLnKBho8Hzw1h5dCe84NgyDCYFa
 2o0oIv2T/HpVxnlk7z657bbuRkU3Q9/rIQJI3ckQlScaD/3oTYBkvOXX1y6efyH4L5Qu
 Cu5G/qP39tgMR86XbK0XEU7DC8wVXQittW0J9dCCagg5AEGTDc4lzQsGauDY/UyCH9t7
 MagaygbJnZDXvXVwu1quP6Iyh1/khhwjBCByaptvfSNSeQsnKeLS+iBvhD1FtDj4reQ2
 LPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783454488; x=1784059288;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEFF1c+CAOmB/0s13wZ2llzP5PYbYjAS7o34do5klAs=;
 b=ZNzulZz/5H11IcOiLxUWkcUVqHnPv67ctJNKiYO+++WmkWqnpxApni2qiopH9WgB8V
 olbXntC00YJEXk6IaikaZVtYysGV04GpeM9UOS01tPZfBmvM9U9R5Ffe9AGEfIPoNERA
 v10yjBBMSZcH4TWNSO6DBE5Imxue0XsGdH4Zu9cOJHbwAs5wjJQ+rNjwFauERaE0HgXK
 lxHqK5ZnJ+1rtmkM6LcqRQjWFeCUwqhBSDfizaq0EOz4rkRBLr3Fd/m+67ane8SdaKv8
 Um0ZGAyrO/+WqEaHZljUUTRCVh3MCCcl8C7gT1sd5QiuWsGJojDPDaq/XLOkoLHvZP7r
 Z+yw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro55f9LVxcZ+ZCMSmW6MADxoJz6K2MSTNqAQDHlniNc236NPL0ly0L5NzvNdYjCtOhUp4oY+vwCkcti@nongnu.org
X-Gm-Message-State: AOJu0YyCbvtF3rRYy/RKZPsApAK21jSlBCN6EBzq5WuylwvEx+FgXssv
 cG42O0rwJ8ZNuLDZtbZY1gorje6h6yiG/fDnmLODbW541yOc8fo56sdNNH86hauYHA6sQA7m1iq
 2drSxEISEjfPa2FfQ70yRZEi7pkN9T3klnpwiEUgiIs4x2UCTEkdbyHbZxA==
X-Gm-Gg: AfdE7cn/BnOghxmXH75iWT7k306uRjFuSmeDv01GbWNG6oBYDRF+Os7uxp+3Liz5z38
 7A58KBv4XetIlMWwOGnhh6AE5dXGVMSxNmiRJMh9pi14iEGSAMNh41hiWJCcEp52NaQlUn6MWcj
 TWx8shftJp2Ok0Ko5uV1RFSTj7a3Eq8I2hPkMocEajc+wjGEiJoTUbNFpK8tse47gn6OimUqLxp
 S7qFWnzX7aUy1L1H+J0jKV9wHtwYwROU/f3fi4kx8db4KDpukrvqDm3CuYfxxyR3g08eBddCP2M
 1bYaw1XFoS5Di0KDKPXVtjMsOuZFIOl0e3CXRDs8YQXLlaP/ng7VCf4ZxLx2pAgtREFFLQT7GZG
 Ufv/kzQyawoaRcc0RyQ3Q4TzMQJwa4oMwOG635GOHS0Zs2kkCuWQvVxWHvS86sE1ORVANSkkNoN
 ANtWU=
X-Received: by 2002:a05:7300:a40e:b0:311:4c6e:6fb0 with SMTP id
 5a478bee46e88-3116b98817bmr19956eec.13.1783454487919; 
 Tue, 07 Jul 2026 13:01:27 -0700 (PDT)
X-Received: by 2002:a05:7300:a40e:b0:311:4c6e:6fb0 with SMTP id
 5a478bee46e88-3116b98817bmr19917eec.13.1783454487189; 
 Tue, 07 Jul 2026 13:01:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a92eccsm10774758eec.23.2026.07.07.13.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 13:01:26 -0700 (PDT)
Message-ID: <0d34b473-a79d-476d-aec9-6036bd74abb3@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 13:01:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] contrib/plugins: add dlcall to call host functions
 from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260705133943.113202-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260705133943.113202-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nyiv2JIDHeFue2NgXSoWVEKjoc33C-YH
X-Proofpoint-ORIG-GUID: nyiv2JIDHeFue2NgXSoWVEKjoc33C-YH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5NiBTYWx0ZWRfX1HCnsT8R09eM
 N/NHaAO1nvqOjfz0V3NYD5XpF3onxhj2vsmL8B8f2tOfTWbiPuKwHubkcl06Lhl7IauywL5P7NE
 M8w2UhU2x5pFkgTkv8UkZl3BXcXm3vk=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4d5b19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=vnREMb7VAAAA:8 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20
 a=Hhi1HU0B5IQT4d31z8IA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5NiBTYWx0ZWRfXxWuUE/TBDw4G
 YhOOyl3MPMkRt2E0Y4QxVSYfV3gNIvlKK/ZHoz+L/0Fsihx4IcU/trc1tOi22q+rqDzx1vPGJKz
 TEyIJaYfNhhplYznzSvgBCJEKF+p1ruboAwtCk+9KNP4KgYOmnkimj7KB0k8SsWQvxu6ts/g+Yq
 ImZCn0eKdBn9H0JQ5dkdzr6FXFmO+EzVyb5lbyBiO1xZYqqNd9KuKuDhQGATRZ+e5ZTpJHQNwN8
 c7iabdZVWGA5k4wghyIf6gQeCpZOdLZNCF/IV9WAD4v7N9Cfba2fnnysA2camFVaIj0/FpXeYT0
 HRqYSKffKi+LoT0EfM6cFpfrFVkmY/4j4TYrcb5W46Ngpey9LRhoB7R6y/QTZEnOSDX+4qhUw5f
 Nt4CYgC24z8QW9XeLU3qaIdQmHDnvxPOy9/fFWcxRFlQwDPn4U5oC3OvtLzasBbKt3cZt/vyrhL
 fhivHTGI1qIJAWgD4qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070196
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

On 7/5/2026 6:39 AM, Ziyang Zhang wrote:
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
> and riscv64 hosts. Lorelei and its thunk libraries are MIT-licensed.
> 
> Adding a thunk is deliberately little work: you write a short TOML manifest
> naming the library and its headers, and a single command then generates both
> the guest and host thunks from those headers and builds them, with no
> per-function code to write. Two runnable examples come with the thunk
> libraries, each with a Makefile that does exactly this and runs the example
> under the plugin in one step:
> 
>   * hello, a minimal one-function library:
>     https://github.com/rover2024/lorelei-thunks/tree/main/examples/hello
>   * demo, variadic functions and a callback that reenters the guest:
>     https://github.com/rover2024/lorelei-thunks/tree/main/examples/demo
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
>  docs/about/emulation.rst    |  86 +++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 
> --
> 2.34.1

Thanks for the update.

It's getting closer, but it does not yet cover what was explained on v5.
Would that be possible to make MakeThunks.py part of the lorelei
release, and not require user to clone lorelei-thunk repo?
MakeThunks.py should generate any boilerplate needed. If it helps, you
can embed this boilerplate in the release.

For v7, the documentation should make it clear it's enough to do:
- wget release
- write manifest
- toolchain/bin/makethunks.py --config manifest.toml

Regards,
Pierrick

