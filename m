Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D791CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCHp-0000wf-2Y; Fri, 12 Jul 2024 05:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSCHb-00009n-O7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:09:40 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSCHZ-0000d8-JR
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:09:39 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ea79e6979so2026360e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720775376; x=1721380176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIBS/VJ0LjtdqhsAPrYUBYzao12idiA4BRFqobTr4lg=;
 b=dYDYJJnvAMb+ERE80XlJcaBZv1K7ga7/0Wn7Z+4UGPPm6tS2/NSSk9AhN9TPKIUN6Q
 9z7bXjcLi3PAY1oPzAJiV+7uXza/ARhu08nfvcioE8We6XitnKsTc+i4yBaWt5s3TALP
 NbgH7wBANmFYExBlF7IxZrBB9ksnASg+V5mCaAtuuxVm/hgDJNaGk5FuMN1o9X4C9FeR
 c7HJCXkomIjkP0i1hE+H59GVfn3MfzpbtKGCS1LhcUN507XkHCNrrD9WZThTs3YDbRDF
 DSJ/X/OkJCHnFbah6C6bJlRg63N4YRryS6lLlmbs9Xo+havDtKZIbOfi0aA84LWDYTtE
 66vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775376; x=1721380176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIBS/VJ0LjtdqhsAPrYUBYzao12idiA4BRFqobTr4lg=;
 b=bYsMjZGP7z648aAI/yB19zuBGGEMM6KfOWnzqs3cfX+TL63pAkx94H+MoKomqqEyLX
 hKQcyCmE0ZSPnXfdxqiZZbtVU4EfoI4oVKAYX3sFsphYkdtoot+H6bnQoqrSaYEmIV1h
 gIMAJjOswFzEGmVeQZL8V4J+w9VWpRPklvQCV/0HhHDxvu1HcOyRn78o/Whg7HGB0zfQ
 TA+WHsZ1uAE8LsJPCYpfYIyMkSttbPcMShXSLZhno1/8ilNjJRufLs1tsdz756NJ2V2T
 HNHOXzpUVEHQWzP8cimHqLHsCVWeGJxhEp6WUG/Kb+2dDy5t2MhdLIOU58M4JEbgdrNe
 WLJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsMXIeGcIE2wrPUBADUW+vBCK4ny4MgpbRu/aBwHO6rRpgej4uULWNpphdcJytt6JikdnR5JMJcj+KPDJgjF/ln9z6sck=
X-Gm-Message-State: AOJu0YxZqtPWE0JYAMwvpFUsYR7XES0unlQ6HBcaX+7esv8dtlXrZ2NZ
 0YlZ5I+2Gj8weAgUPDZ007AaIpD3zLwSBvW3DV85Tdp7//v2Q/8T0WBePzVu9y4=
X-Google-Smtp-Source: AGHT+IHk5DWAQN+jcRbbvd7FaenKwydlcmjWGOkMqvsMkWgKXf9ujvDY2YwDrH+Ryf3ODS6TvkKz9g==
X-Received: by 2002:a19:9154:0:b0:52c:a7c8:ec43 with SMTP id
 2adb3069b0e04-52eb975eae8mr6577365e87.0.1720775375522; 
 Fri, 12 Jul 2024 02:09:35 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f28872fsm15902535e9.25.2024.07.12.02.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 02:09:35 -0700 (PDT)
Message-ID: <5bbf7f5f-d2f1-4d6e-996b-24e8955cd942@linaro.org>
Date: Fri, 12 Jul 2024 11:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] build deps: update lcitool to include rust bits
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240710154335.2510260-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240710154335.2510260-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/24 17:43, Alex Bennée wrote:
> For rust development we need cargo, rustc and bindgen in our various
> development environments. Update the libvirt-ci project to (!495) and
> regenerate the containers and other dependency lists.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> NB:
>    - this is currently waiting on the upstream MR, but if you manually
>    add the remote
>    https://gitlab.com/stsquad/libvirt-ci/-/tree/more-rust-mappings the
>    submodule update will work.

Branch not existing, I suppose because !495 got merged.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
>   .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
>   .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
>   scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 3 +++
>   scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 3 +++
>   tests/docker/dockerfiles/alpine.docker                | 3 +++
>   tests/docker/dockerfiles/centos9.docker               | 3 +++
>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++++
>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++++
>   tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ++++
>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++++
>   tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++++
>   tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++++
>   tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++++
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++++
>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++++
>   tests/docker/dockerfiles/debian.docker                | 3 +++
>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 +++
>   tests/docker/dockerfiles/fedora.docker                | 3 +++
>   tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
>   tests/docker/dockerfiles/ubuntu2204.docker            | 3 +++
>   tests/lcitool/libvirt-ci                              | 2 +-
>   tests/lcitool/projects/qemu.yml                       | 3 +++
>   tests/vm/generated/freebsd.json                       | 2 ++
>   24 files changed, 71 insertions(+), 4 deletions(-)


