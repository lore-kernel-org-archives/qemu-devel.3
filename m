Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D206FE51FD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDTz-0008KA-5a; Fri, 24 Apr 2026 06:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGDTu-0008I7-QF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:09:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wGDTq-00078G-OT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:09:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso48277735e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777025388; x=1777630188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+DFBUat3K1iOQiAi3RopbLBsBNhzx1THy7hOvCTeHA=;
 b=D/YiYQTZfjjxsDp+Ld9KijXOVFuUl/oYfUmULpPC2I26Ag5u1kruE3BcXShI4KC7UO
 EWpAvx38pdph1gmZuwcYJaqr5u3wcAqXi7RoOgvBZFGVlljIBJZj4ZX8kCXHsUi/fw3u
 +oEaea5NkGbIraviW2gShtj2iaZdl4o4ks1jEv3FhAC2pS4Bn/GwLT7igMBpy4IQKwqK
 sX0hLijnjmjcp/TCLHivYNuD9gqQiBCrZzq/Hb/e9RqGsT94Gla40UiJw2wyA2X4zts7
 fhKT+8o38zJyTfEb3u0aaV2ZPIiYU2dRGOUdIMx0/T52ob2eqPthUp+x7tZKLhq/MSJC
 HLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777025388; x=1777630188;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+DFBUat3K1iOQiAi3RopbLBsBNhzx1THy7hOvCTeHA=;
 b=fL18CkXX89IAbfTCWIjV9jGgiNPwUpPOHRZisYehAIxOCbyUWkM2ENJfM9X3zH2Ut9
 B9Vq0vp4PbOtadcuOoFdCi2DF63PMFxYS1J4Etqiv4YLmfPh21oVLd7axn8Fzv3rYlIB
 5Ot38FbXNluOO/wW8WR5axKs07uewr3gzqSKIK6UF17OEtGDdMTZL9P0R+8wpilron86
 hvq/OIRy/NBx6Ezi92fSdFEuxLTtKsyDDlPqeY41cM8HtRqoCVjT+xkWHZX1+ax3V4O4
 KRK9JXylsn8xzY2YdUc0wNkE4cxmZQOw4E6bFlbcMsJ7wY6nEmBdsiyi6qJl53C1Vh7d
 ekkw==
X-Gm-Message-State: AOJu0Yz/p5lgajzig3Jjolfe1YE9H/SNTifT4PsJLPp8pvCmlZ+Vqh0b
 d57GvCXJeRT8AjI9GvJo3NpXQ28DbtMUlz+40msXxjse1i5V9pgaHWvqyJ91pLY1TpA=
X-Gm-Gg: AeBDies7EdtMEhkDVlsNoOhuyxG5dAXOS1danX1dx/F+YHj+i+8cUfn3e8PZV/TaCyx
 KHSmm49E1/GLOKSsokZokZdq6XvcW6tdbLBUkNIxsiNPjqOeg07x+qd54/Iz/XFT+FbJg5xqoDA
 Ve3n2k96+y/Q7IvqCQjsPBkeFy1AYX+GLxtcxyxsWLVePzprwdm55KJjIcSLf43s169Qz9EGX8j
 BPpMl84TWnGaFwFfK5KKklhgpUoUD78lHjGeKg69hhGtlAq+ziM7n2u3X0EdDAZyhBMqe7q6wA7
 T53m718rg0Qgx4EFTV08+UJ0apQKGx12hsJjl+/e5i5eiMvVZ5y/QRuWQXMQmOkIs2/F2rxoLDx
 UaAPQzK9ig8PG5G+XvbDWXPulXKXdAQVDnMkpQTz6c9/ij3K+hoN4VOhgF4OELBEUJuTapHJ4O8
 NriATMTRDpKCtOzRyovRhWCVtte405AhgK0g==
X-Received: by 2002:a05:600c:19c8:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48a554dba51mr244328085e9.6.1777025387919; 
 Fri, 24 Apr 2026 03:09:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm614591855e9.2.2026.04.24.03.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:09:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27C8C5F943;
 Fri, 24 Apr 2026 11:09:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org,
 agraf@csgraf.de,  mohamed@unpredictable.fr
Subject: Re: [PATCH v4 1/3] virtio-gpu: validate host page alignment for
 MAP_FIXED blobs
In-Reply-To: <20260423234415.7753-1-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Thu, 23 Apr 2026 20:44:15 -0300")
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260317175744.32469-2-lucaaamaral@gmail.com>
 <87mrytwo8h.fsf@draig.linaro.org>
 <20260423234415.7753-1-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 24 Apr 2026 11:09:46 +0100
Message-ID: <875x5gwtxx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Hi Alex,
>
> Thanks for looking at this.
>
>> What was your test case? Is it possible to publish some images for a
>> functional test?
>
> The test case is running a Linux VM with virtio-gpu Venus (Vulkan
> passthrough) on an Apple Silicon Mac:
>
>   - Host: macOS ARM64 with 16KB pages
>   - Guest: Linux ARM64 with 4KB pages

Well we at least images for the Linux side which we can use. See
tests/functional/aarch64/test_virt_gpu.py


>   - GPU: virtio-gpu-gl with Venus/virglrenderer + MoltenVK
>
> When the guest allocates a blob resource with a 4KB-aligned size,
> mmap(MAP_FIXED) fails with EINVAL because the size isn't aligned to
> the host's 16KB page boundary. Without this patch the blob resource
> is silently unusable =E2=80=94 the guest sees no GPU output.

I wonder if TCG guests will also fail?

>
> Reproducing it requires the full macOS Venus stack, which includes
> patches across multiple projects:
>
>   QEMU (this series + two others on the list):
>   - Stack A: ISV=3D0 data abort emulation (v6, R-b by Mohamed)
>     https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/
>   - Stack B: this series (hvf map granule + MAP_FIXED alignment)
>   - Stack C: Venus without OpenGL (v5)
>     https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/

A lot of moving parts, do you have a rolled up branch I can test against?

>   virglrenderer (GitLab MRs):
>   - MR !1600: macOS build support (merged)
>   - MR !1601: posix_spawn worker for macOS (merged)
>   - MR !1602: Metal shared memory (R-b by Yiwei Zhang, under review)
>     https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
602
>   - MR !1603: SOCK_CLOEXEC/MSG_CMSG_CLOEXEC optional (merged)
>   - MR !1607: server preparations for macOS process model (merged)
>   - MR !1608: Metal vulkan header roll (merged)

Any rolled up branch for this set as well?

>
> I don't think a functional test is practical for CI since it requires
> macOS + HVF + MoltenVK + a guest image, but I'm open to suggestions.

This is a bit of a challenge - we will be loosing CirrusCI soon which
has our only real MacOS build test. Either we get someone willing to
host a custom runner or we need to find another CI runner that we can
plug MacOS tests into.

>
> Thanks,
> Lucas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

