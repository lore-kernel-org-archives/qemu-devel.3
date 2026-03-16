Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640BF53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CpM-0007EL-K8; Mon, 16 Mar 2026 14:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2CpJ-0007E5-Le
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:38:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2CpG-0002fS-LP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:38:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso5167281f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773686279; x=1774291079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RXHxMs/SQsDXk+/8NCO2b9D8flVjifuoDuI5upUjPOU=;
 b=shpjwVi6YnF2hTqGC38qMND3YxHcJUmj4HaQm68pbAqCl8RTYb+Rsdf4Vj2uqImmkw
 9CGiCmYTYpbAqJgbgSjJKtlPaQM7JLiJOKHqI+KxyPg7u6F6sch6z1ChN65f3uLHf1kY
 fQtyUNWFofSBEpSDtvu91vqW3OtdTD/KiZ9T7LeQ45040z6b61Z8Otp72uB39U5/JvCT
 25+wjW09qmpU9Od1GoG0dPMWTbqzEwQqnJWJ0DsoLXz4obaEoVaZtAADjxCrTisoBPyW
 F0YF5gmp5xPQnuINQbdvfqsFqdw61P1ACr5IBpUYz5pgPnFSpFSFLsvALUQYxNw3WfUj
 KHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686279; x=1774291079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXHxMs/SQsDXk+/8NCO2b9D8flVjifuoDuI5upUjPOU=;
 b=MEUJv8szuLpRadDD5CkEJn8/819Fx9uvNvyNUCDEdXCNC8VDXfI4jEelEcPkCb3380
 5fz7zxWU9jDL5dXxbonJLlKZ5wGFMfhF+4umAJbKluRRiI1Qvu/jqcCft+jK4P3Ykm81
 xQ3ij/NGvG3Pi4p87RX/UcrdrP3NnCVvkTKcE0EQ34p+SZ+IpeMQHAKdCgQGD3CtHgJ1
 BuQXkFXCmiWZO0IgR8mBl3ZZEz1Kne1j3kqn744QS+IZDv66AGMMQ0krProL2FqlOyPP
 DY7i1F34f4Re4rSVvgkAZz2q/6ycv+JjKtY1p8ULJ7gYy4W9v0Z0MBaRk+AelL1Exmm2
 vgow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV25dpZMtmbwG0xb8usCVIh8vvC0l0r1DuU5flfHBXUo3fGEgzTcpOETBe338Wwqz3pivnOzJ8VyT1s@nongnu.org
X-Gm-Message-State: AOJu0YwtIKnW1JHzqxS1x/mrob44x65QawR0mXQK4too3dIl0tiJ7CTt
 hZCfMKia0veV4AaGp9TE8u7W6Wf82sbYMN3ScVfGIVYp+IorsEdojpYEBQjYsp3UTkQ=
X-Gm-Gg: ATEYQzwLUYDmMcyphPeK/p9anN+alE3Iy3u3YBJF2T+ztRUjG36jx5l8RhGsZI1TTxM
 189Tn6PNB7Tc1BoHdrHAYvSQmACI8uH3kgVsDf53gD83xWRu+HZdV7jGEEtk4nSmzsKrLwbF52K
 lTrpiqE710mg5DyynxAveG3hp1rin0IMvrckBP/90ERgYzKfiXHwux9M1RR4egwmCcfWKw/tkl8
 MkElvNXYnOJNop4a4sKY9Re1Zc8/oRHiuYhDVW6dF5EYFXJOjB3gxs9JrT7HFoBAV2OQqoOCinp
 1M5g3NU5oO5/AIIrnKMpgafprJu5PzJCt4h0l9dqjDgYZvTRJKDsBLK7Joy9vKhfke3OG0tOdCp
 6PLm5VlH/L33xFaj+vuXPp0pVk8Uy/mFYUQMp1Cnf5ULRjv1q1uxUenoIErbG83elreSiMOKCwg
 oKl11r6jBpMxRr9wlT+vCyA4CdAkCp93czegQ=
X-Received: by 2002:a05:6000:1863:b0:439:bce5:6519 with SMTP id
 ffacd0b85a97d-43a04dc0849mr25734710f8f.39.1773686278691; 
 Mon, 16 Mar 2026 11:37:58 -0700 (PDT)
Received: from [192.168.69.206] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b41065f8csm17572226f8f.30.2026.03.16.11.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 11:37:58 -0700 (PDT)
Message-ID: <20fb8c5b-c673-40af-b7c5-a9e5f175df8d@linaro.org>
Date: Mon, 16 Mar 2026 19:37:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Replace ncat with socat in migration test and drop
 ncat from containers
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260316183016.239526-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260316183016.239526-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 16/3/26 19:30, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> nmap / ncat has a somewhat problematic license (e.g. saying claiming
> that derived work is also considered for software that "is designed
> specifically to execute Covered Software and parse the results", e.g.
> by executing ncat from your own program, you might already fall into
> this category) - so for example in openSUSE 16, you can only find it
> in the "non-OSS" repository.
> 
> We are currently only using it in the migration functional test, and
> that likely does not fall into this "derived work" category yet (since
> it is also doing some other stuff), but still, to be safe, we should
> move away from using it now.
> 
> Unfortunately, switching to one of the other flavors of netcat is
> also not a real option (see commit f700abbbeb6ab68a3446d1fb168a934d),
> but socat should be a solid replacement here instead.
> 
> To avoid that someone else easily uses ncat again, let's also remove
> it from our container files now.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   scripts/ci/setup/debian/debian-13-ppc64le.yaml        | 1 -
>   scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml      | 1 -
>   scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml        | 1 -
>   tests/docker/dockerfiles/alpine.docker                | 1 -
>   tests/docker/dockerfiles/centos9.docker               | 1 -
>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 -
>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 -
>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 -
>   tests/docker/dockerfiles/debian-i686-cross.docker     | 1 -
>   tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 -
>   tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 -
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 -
>   tests/docker/dockerfiles/debian-riscv64-cross.docker  | 1 -
>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 -
>   tests/docker/dockerfiles/debian.docker                | 1 -
>   tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 -
>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 -
>   tests/docker/dockerfiles/fedora.docker                | 1 -
>   tests/docker/dockerfiles/opensuse-leap.docker         | 1 -
>   tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
>   tests/functional/migration.py                         | 4 ++--
>   tests/lcitool/projects/qemu.yml                       | 1 -
>   22 files changed, 2 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

