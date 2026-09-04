Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851E3C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RB8-0005sR-UJ; Fri, 04 Sep 2026 06:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RB5-0005rs-Q9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:29:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RB3-000220-Mk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:29:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AII2r3276181
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EVX2mDvI9q7ZP920a9wnP0wjUSZWUPcltClIyekEs6Y=; b=O+OWRf5Eq72pC+i+
 +iL7jIibLzOZTnvPoD26cBoP9qINzd+4Zy4rpE4koTy0Xckv9iotyMo+tyig2TG8
 /ikuDLfz+4fB97KkSdloofo1Ty48F9TsLlJ9wmJ4jiLrNXkVDk+TQlAHEyfwdF9B
 AtM4Hm5bwz7CRqs2VijR9L+asT0RVTeNhJnn/T86Afjq44M1IVP5RS2pR1jlOtGM
 dgjulrk2k7bUep6lLSdYX5rkrIRP62uJjJeQFc3Q2bQKvi8XphiuHQrLUrB5sHDk
 XPaEI4Wlf/OXNxKVvdApRtpxlco6xPNZ0Igdl1nAL8Gi21HYqZdIdZBDGknEPp7j
 0fH0cQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd1086-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:29:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93975d63ffcso105732985a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788517783; x=1789122583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EVX2mDvI9q7ZP920a9wnP0wjUSZWUPcltClIyekEs6Y=;
 b=QpqgRmXdXMKzQZ4uyG+uwwg3GzPJoz/8pTMH62U+i4f8xthPqOjue7JWaX6QDuagmg
 Zg+wgh8WcuDFa7UANoRymQuHlaCNyiD2EklwmRXW8L3/KflBnDf26uJ1ZDq65EXencSD
 8P0gWTa7tpPqRtAghXhNqFGGbhRvbJowsorRjBaGvyNsa0ikOM2ShngqYm6UW1Pr4ih+
 AS05HzbRMkyuvUjQ+9VNaKrlAoqWVhOjF2mZqAQiz/4GD3wOGOq+Jqvixqu5Wg4cOGN0
 wLuMoLIUbqbBLZun1oGTTN0DFD1a5gFYUnIp/kKEoiBsdOcZB+g1jr5vjKv8dqtnUbpN
 H4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517783; x=1789122583;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVX2mDvI9q7ZP920a9wnP0wjUSZWUPcltClIyekEs6Y=;
 b=h6MvuLg5v6MShXUHdBqBbIgEUaXIZRanTfBWtVvWClESRCR6yM0wmw4t/7l/kk9etx
 W48uZIX3qk3K8w2+1ck04rs5XpSm9Vq5kx3csVfagH49Ra5FLGfefzyYf7jTLmAGgrSv
 t54sIZPcQ7y3igXuC01qJDQyNK7yRPMyLLfU/3NxmuLfQL36a56BC9rPnIHXAcfNJNxS
 bMafua7oFTZVyuCRlPfOXMddQpknom6w0amrRIv8QTxpSbVMMuOodrTdbu9Jzi47Bc2z
 8mTQWaM+fZv3qVM//O1ipX7+NO6P9x7FIyxSV3vRPDq+nsPjJf3rx535umz+/CDp1SXN
 S90g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpnyxfCkCal3oefJXM44tWVXQq/u0kw8KwSJrlB5xxqExO8+Tf+xLvU2kHtLoFTJ+TiGnyDQVjxYFL@nongnu.org
X-Gm-Message-State: AFuF++nq9QJzKOrwm55KO3V2WxRFus/TkLzR6JEZiVuGhtiR0tFk6ZH6
 nUqAFFrOT+xV7wIl3X1xS2j6PzmDa7qLyxcD8HjUsunzrxELvZdqu8shKZYEkCPId12aSM8zukx
 7ICY4mfR1AlDOJC+99GyMQedzuca+tHBODG71mcFmrH4YWudem4ely0ZZow==
X-Gm-Gg: AYBFou2qSoSAKCEWjpGZroGYQ7joiAazl8gltjSBE1+1T2ltgdCE4uCnF3zO+7h3ldd
 6Md5V/gP7WbMfdYmU/OCY2zBgJhSJeROdYxGpEPhSfeEN0jm/qqwmLNkD6oTdW34CNGqylVO5X9
 1RN+iNjGGo22T7Z/MbgxQT/i9slqCudY08UOqUrytQevwtToJVQTXnLqbKDrdeUGNt+AVQEl5c3
 gqswHRy0BavmWE1bwTuDyGfsup+853/tKuetS4/RYveHgQkRC01BgvhFRxQCeqKehYBtobMzx4Q
 Zb8PZ7hswOtB/12Xph3pgq8jsWj46c0pm2Q5QAMz/oF3cRO5+NE3P5yng8ESIkUTP7EwwfBW1uv
 EEotSa7FwJSihMtr05wqhHd+DpVuTdFk/jA==
X-Received: by 2002:a05:620a:404c:b0:939:3cb9:553d with SMTP id
 af79cd13be357-9398048b9f8mr454623585a.38.1788517782824; 
 Fri, 04 Sep 2026 03:29:42 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:939:3cb9:553d with SMTP id
 af79cd13be357-9398048b9f8mr454620085a.38.1788517782323; 
 Fri, 04 Sep 2026 03:29:42 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm60756665e9.9.2026.09.04.03.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:29:40 -0700 (PDT)
Message-ID: <11a0a07a-cd51-437b-8083-661a9acbda3a@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] agents: Add a skill for finding your way around QEMU
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260904074314.896384-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904074314.896384-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3NI0F0n5Yl-t4oIri6vySXQ0pcXBld0p
X-Proofpoint-ORIG-GUID: 3NI0F0n5Yl-t4oIri6vySXQ0pcXBld0p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NCBTYWx0ZWRfXwSn+5r7d8vk+
 QZouyVWRflBsu5UNdNzWRHJKHbsPnnspxThNvvMSmh4aoeXq7dv8NNWZCBNcyrdvvl7xFU1lYuk
 yBVJBGglIhyWE2GU/0uzhbjqUo8Icvs=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9a9d97 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=YRc0ivGyvqEfQnem:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=-gB7T7fhCVeG0JvITWQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NCBTYWx0ZWRfX5q+alGWWRVtW
 itK5As6Mim+iuFlikdkSzZq/WNanynAfLu1dUSZbahpqmj0TUDlMw+/R3Vf7grUYD4SMpl7wNff
 UElqxh/67qhc90iv03JIO9YZr2aOjfaYYx6Z58rRFmEQLmlM1QO4CIprhv+UxIYi0735dQWicer
 6DRJ+ejA3AtvXBUqHoiC4dfIU7MTH03yg94fgKywa2qnmIfwYRe31HGW1sR7E6T9ywuIGsm+Dth
 7gSxx9kJaTrGifynBqjvEBO+/yygC82lOZaQ7E6y2wd5DsKULnGUAF5hWv1oqNaRMDUPN2sVGy5
 DDRJNG8Mwf3GdX9k0csBje8zpVHB7fIy81XfgYQymgnaaa5MpWzMeUO+xOISKc9YPXd6ErBjXMw
 4/5cqUIZFn3dkzKALv5A4IEkh1UW/wzy9vfQTf6dGRTxkEvThXYKpuNXDR7UzldJtMAXMD4wS55
 nmHfXo3YArAXo1ubpcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 4/9/26 09:43, Paolo Bonzini wrote:
> As a side effect, establish scaffolding for the .agents/.claude/.gemini
> directories, as a base for future patches to build on.
> 
> Some parts of this skill are based on
> https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.
> 
> Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: add .claude/.gitignore.  Suggest using get_maintainer.pl and ./run.
>          Fix thinko around build/source directory
> 
> 
>   .agents/skills/qemu-codebase/SKILL.md | 100 ++++++++++++++++++++++++++
>   .claude/.gitignore                    |   2 +
>   .claude/skills                        |   1 +
>   .gemini/skills                        |   1 +
>   4 files changed, 104 insertions(+)
>   create mode 100644 .agents/skills/qemu-codebase/SKILL.md
>   create mode 100644 .claude/.gitignore
>   create mode 120000 .claude/skills
>   create mode 120000 .gemini/skills


> +- **target/** holds CPU models and the TCG frontends
> +- **tcg/** holds the backends and the IR. See `docs/devel/tcg.rst`,
> +  `docs/devel/tcg-ops.rst`.
> +- **hw/** is devices and boards, categorized by type.
> +- **linux-user/** and **bsd-user/** are almost entirely separate,

common-user/ is where we are moving their common code.

> and only
> +  have parts of **hw/core/** and **accel/**'s CPU emulation infrastructure
> +  in common with system emulation
> +
> +Other directories include the back-end subsystems, for example **`block/`**
> +for the block layer.
> +
> +The `include/` tree mostly mirrors the top-level tree.
> +
> +## Build layout
> +
> +Build is always out-of-tree; the build directory is created by
> +`configure` and a checkout can have several. Determine it from context
> +(`ls */meson-info`) rather than assuming.
> +
> +The `run` script in the root of the build dir wraps `meson devenv` and
> +should be used to execute commands in the build directory.  It activates
> +the build tree's venv `pyvenv/`, adds various Python modules from
> +the source tree to `PYTHONPATH`, and defines a `MESON_BUILD_ROOT`
> +variable for general use.
> +
> +`make` at the top level forwards to `ninja` in the configured build
> +directory, and any `build.ninja` target can be invoked that way.
> +
> +## Build & Test
> +- **Build**: `ninja` or `make -jN` from build directory
> +- **Test All**: `make check`
> +- **Suites**: `make check-unit`, `make check-qtest`, `make check-functional`, `make check-rust`
> +- **Single Test**: `./run meson test <testname>` (e.g., `./run meson test qtest-x86_64/boot-serial-test`)
> +- **Debug**: Append `V=1` for verbose output or `DEBUG=1` for interactive test debugging.
> +
> +## Code Style

Ref to docs/devel/style.rst?

> +- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
> +- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
> +- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
> +- **C Comments**: Use `/* ... */` only. No `//` comments.
> +- **Naming**: `snake_case` for variables and functions; `CamelCase` for types and enums.
> +- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`) APIs. No `malloc`.
> +- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
> +- **Lints**: Run `./scripts/checkpatch.pl`.  On top, `make clippy` and `make rustfmt` for Rust.
> +
> +# Documentation pointers
> +
> +Developer docs live in `docs/devel`.  A `kernel-doc::` directive includes
> +documentation comments from source files when Sphinx builds the documentation.
> +These comments be consulted just as easily in the source tree without going
> +through e.g. `make html`.
> +
> +Here are some useful pointers.
> +
> +## Core abstractions
> +
> +- **QOM** (`qom/`, `include/qom/`) is the type/object system underneath
> +  everything.  It includes class and interface hierarchies, properties, and
> +  the object composition tree.  See `docs/devel/qom.rst`.
> +- **qdev** builds devices on top of QOM, adding for example buses, 

GPIOs / IRQs,

> the
> +  realize/unrealize lifecycle (including hot-plug/unplug), and reset.  See
> +  `docs/devel/qdev-api.rst` and `docs/devel/reset.rst`.
> +- **MemoryRegion** (`system/memory.c`, `include/system/memory.h`) is the
> +  guest address-space model: regions, aliases, address spaces, dirty tracking,
> +  load/store and map/unmap operations, etc.  See `docs/devel/memory.rst`.
> +
> +## Concurrency
> +
> +Getting the threading model wrong is a common source of subtle bugs here.
> +
> +- The **BQL** (big QEMU lock) protects most device emulation; vCPU threads
> +  hold it when exiting to emulation.  See `include/qemu/main-loop.h`.
> +  Memory regions can (carefully) opt out of the BQL.

(I'd move the RCU entry here)

> +- **AioContext**/iothreads: block devices and their virtio front-ends can run
> +  outside the BQL.  See `docs/devel/multiple-iothreads.rst`.
> +- The **block layer** is coroutine-based.  `co_` prefixes and `coroutine_fn`
> +  annotations are advisory but relevant for reviewers.  Coroutines have their
> +  own locking primitives.
> +- **RCU** is used for hot, rarely-modified structures such as memory maps.
> +  Because of the BQL, RCU is mostly used with `call_rcu()` rather than
> +  `synchronize_rcu()`.  See `docs/devel/rcu.rst` and `docs/devel/atomics.rst`.

(move earlier)


