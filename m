Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E55D46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUH8-0006kr-UW; Thu, 15 Jan 2026 15:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUH7-0006jI-4J
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:49:01 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUH5-0002uo-2M
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:49:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f478e5283so1190989b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768510137; x=1769114937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0k2MhlKsygvagAp9BXw+O9ZjKE0uE6K+kYwBqSsimTM=;
 b=oO2VV2iKtmhMfCigHauf8iZYFs8ntYR64794HC8ZohEggiW/b3HFh3LvrvzcH1ozZ3
 +SJCNMKf/KIU/rR6N+hX3iBb08/Gmbq3zjwOujJ1TjBYma1I1EN970zm1LRpHrl/dj+k
 BaKLnINJWLnNVML8qBX9IxfCutBCWtYHKnpp4lwx6cieuJ+cYuGflCxnP38IM+iPCMX1
 lUKyAlIHRULcirfLfAb9Zcw+t+Y7BO7xoheaaZBOaPuWkuwF/7hUmwPcGATOLnqklBdi
 sc8c6NGzgNEX7Hajxq/CKYY6uwdJ3u2+BBLjw/X3rjr4MZreQnup/8Mk7aVNx8TR4th3
 JkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510137; x=1769114937;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0k2MhlKsygvagAp9BXw+O9ZjKE0uE6K+kYwBqSsimTM=;
 b=RIqA/YeFJ+Q0BNIBzK07IdnJ6yk5TLHv8048QIaGaKWA5JHkotq1evVXGSi5p37O5U
 xPWLtmtiJR5uttkMmHkuk3XRz6wG/dVCc1yJcOhXGoodnIn3jMVPx+spJiApmCl40y0E
 MLkbxDe5n/OWqldZ+BWW+HfsK9RyKSQBI9065lgHU/SqFE4cWqAoWMHqgMv965Xdzffg
 AtCnFL2H+aajLf9/x1IDuD5t0ZO0T2Qxc0rAM+7GvU83CqWu66xpXM7ahXTxXHA+Ri/n
 24R1nPheUopnrR4DRJPDXFn3qxLcXSbI17YPLRiuQz0HgBPFIXp3XnwTndLLhJTV4EIJ
 JBLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCm75/Or7IK499CNtru0JMp1OYnerIDJTV7hMUSjvbeiyn0WvGKuNYsisfnil/mv8bg02zzuHXFKWK@nongnu.org
X-Gm-Message-State: AOJu0Yzprl1rEeFUmn3wBAvRujH0c82G9aXMAaX6ehayOSnbfPPr//Sb
 lpMQ8lEXn7fiYTEqgRxi9YCuATPvlFZZ/I2OqL61PdACfSGHLIW+ZH/Sz0WlLJpapTg=
X-Gm-Gg: AY/fxX48/plKLGcxzXPDCG3xOmi7qILPyzQvhOt5arIkx2OZGQIaDaGj7R4mZ3Ropma
 08AwB52PYtqePT5LvsMM9Sq3OLBiLhVESl+mGcmbkbD7I5ef7jnbRxVLwRVi0o6zb0wmNTgVME4
 1oaGwBwOUxnlFDv4n+5fzdEsJ5FtrCt4o5eFZGwy7oRxVf/sSiZgJqvl1DhKgimz7ktzvVCGYT9
 S6H5UE1MvrDoW/IIvjpGFZGnkW6CkQRAGLg62UVfXf2RPpT7LoClW7tJLGJ6ByFGZJZY48lR+bB
 FW2SR7pBc94aNiw3Cuvccij3u7C3snvIV2eKlQiuLMG7FEmm+hrPbwhPF+ZHhuJIsCtftALyYeY
 ujZFauGRMphtNQI5le5h2kzSNDk8x+fp2OGf/Dl4MOKN5H8hXcnLtobgooXmaFlQpqLlDYXtChP
 MlO0fc2p1xBlVWv88Y7yVcp7orv2TL7390Xip9xswOpC2JNA1F/SNxje+8
X-Received: by 2002:a05:6a20:3c8f:b0:366:14ac:e1f5 with SMTP id
 adf61e73a8af0-38dfe94521bmr910541637.71.1768510137240; 
 Thu, 15 Jan 2026 12:48:57 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf32d2a2sm268082a12.20.2026.01.15.12.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 12:48:56 -0800 (PST)
Message-ID: <05bc2cec-874f-48c9-8ba8-9f14f41e9dab@linaro.org>
Date: Thu, 15 Jan 2026 12:48:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260115180123.848640-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260115180123.848640-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/15/26 10:01 AM, Daniel P. Berrangé wrote:
> Informally we have approximately three groups of platforms
> 
>   * Tier 1: fully built and fully tested by CI. Must always be
>             kept working & regressions fixed immediately
> 
>   * Tier 2: fully built and partially tested by CI. Should
>             always be kept working & regressions fixed quickly
> 
>   * Tier 3: code exists but is not built or tested by CI.
>             Should not be intentionally broken but not
> 	   guaranteed to work at any time. Downstream must
> 	   manually test, report & fix bugs.
> 
> Anything else is "unclassified" and any historical code
> remnants may be removed.
> 
> It is somewhat tricky to define unambiguous rules for each tier,
> but this doc takes a stab at it. We don't need to cover every
> eventuality. If we get the core points of view across, then it
> at least sets the direction for maintainers/contributors/users.
> Other aspects can be inferred with greater accuracy than today.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This came out of the discussion about recent unnoticed breakage
> in NetBSD builds and what maintainers are expected todo about
> it (if anything)
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html
> 
>   docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
>   1 file changed, 152 insertions(+)
> 
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index e95784cdb5..950e164c02 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -171,3 +171,155 @@ Only 64-bit Windows is supported.
>   .. _MacPorts: https://www.macports.org/
>   .. _MSYS2: https://www.msys2.org/
>   .. _Repology: https://repology.org/
> +
> +OS Support Tiers
> +----------------
> +
> +While the QEMU code targets a number of different OS platforms, they don't
> +all get the same level of support from the project. This applies to
> +contributor & maintainer expectations, CI automation and requirements
> +for merge gating.
> +
> +Tier 1
> +~~~~~~
> +
> +These platforms attain the highest level of quality offered by
> +the QEMU project.
> +
> + * Builds and all tests pass at all times in both git HEAD and releases
> +
> + * Builds for multiple build configuration are integrated in CI
> +
> + * Runs all available tests frameworks (unit, qtest, iotests, functional)
> +   in CI
> +
> + * Merging code is gated on successful CI jobs
> +
> +This covers
> +
> + * Linux (x86_64, aarch64, s390x)
> +
> +Responsibilities:
> +
> + * Contributors MUST test submitted patches on one of Tier 1 platforms.
> +
> + * Contributors SHOULD test submitted patches on Tier 1 platforms
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST request contributors to fix problems with Tier 1
> +   platforms.
> +
> + * Maintainers MUST test pull requests on Tier 1 platforms
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST co-ordinate fixing regressions identified
> +   post-merge immediately.
> +
> +
> +Tier 2
> +~~~~~~
> +
> +These platforms are considered to be near Tier 1 level, but are
> +lacking sufficient automated CI testing cover to guarantee this.
> +
> + * Builds and all tests pass at all times in both git HEAD and releases
> +
> + * Builds for multiple build configuration are integrated in CI
> +
> + * Runs some test frameworks in CI
> +
> +This covers
> +
> + * Linux (mips64el, ppc64el, riscv64)
> +
> + * FreeBSD (x86_64)
> +
> + * macOS (aarch64)
> +
> + * Windows (x86_64)
> +
> +Responsibilities:
> +
> + * Contributors MAY test patches on Tier 2 platforms
> +   by running a GitLab CI pipeline in their fork
> +
> + * Maintainers SHOULD request contributors to fix problems with Tier 2
> +   platforms.
> +
> + * Maintainers MUST test pull requests on all Tier 2 platforms,
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST co-ordinate fixing regressions identified
> +   post-merge quickly.
> +
> +
> +Tier 3
> +~~~~~~
> +
> +These platforms have theoretical support in the code, but have
> +little, or no, automated build and test coverage. Downstream
> +consumers (users or distributors) who care about these platforms
> +are requested to perform manual testing, report bugs and provide
> +patches.
> +
> + * Builds and tests may be broken at any time in Git HEAD and
> +   releases
> +
> + * Builds are not integrated into CI
> +
> + * Tests are not integrated into CI
> +
> + * Merging code is not gated
> +
> +This covers:
> +
> + * NetBSD
> + * OpenBSD
> + * macOS (except aarch64)
> + * FreeBSD (except x86_64)
> + * Windows (except x86_64)
> + * Solaris
> +
> +Responsibilities:
> +
> + * Contributors MAY test patches on Tier 3 platforms manually
> +
> + * Maintainers MAY request contributors to fix problems
> +   on Tier 3 platforms
> +
> + * Maintainers MAY test patches on Tier 3 platforms manually
> +
> + * Maintainers SHOULD NOT accept patches that remove code
> +   targetting Tier 3 platforms even if currently broken
> +
> + * Downstream vendors SHOULD test RC releases on Tier 3 platforms
> +   and provide bug reports and patches to address problems
> +
> +Note: if a Tier 3 platform is found to be significantly broken,
> +no patches are contributed for a prolonged period, and there is
> +no sign of downstream usage, it is liable to be moved to
> +"Unclassified" and thus be subject to removal.
> +
> +
> +Unclassified
> +~~~~~~~~~~~~
> +
> +These platforms are not intended to be supported in the code
> +and outside the scope of any support tiers.
> +
> +  * Code supporting these platforms can removed at any time
> +  * Bugs reports related to these platforms will generally
> +    be ignored
> +
> +This covers:
> +
> + * All 32-bit architectures on any OS
> + * Any OS not listed above
> +
> +Responsibilities:
> +
> + * Maintainers MAY decline patches that add code targetting
> +   unclassified platforms
> +
> + * Maintainers MAY accept patches that remove code targetting
> +   unclassified platforms

That's a good summary, but it should differentiate testing/runtime 
issues from building issues.

In general, maintainers should ensure code build on all 
platforms/configs. Of course, it's a best effort considering not all of 
them are built in CI, but in case a build issue is caught on time, it 
should be fixed before hitting master.

It may be worth to mention that all platforms can be accessed for free 
using: https://github.com/second-reality/github-runners.
If you're open to it, we could move this project under 
https://github.com/qemu and preinstall all dependencies on each runner, 
so people can easily jump on a shell and start debugging things without 
wasting time.

With this at hand, there is no reason to let a build failure be merged.

Thanks,
Pierrick

