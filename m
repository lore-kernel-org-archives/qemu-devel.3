Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567EDCD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKruV-00013Z-7k; Thu, 07 May 2026 02:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKruQ-0000zN-Uf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:08:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKruN-0004yK-8p
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:08:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso230521f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 23:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778134105; x=1778738905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a1EH6c8/6d5U9t1bXTH6utae0BZx1/5EUl0ntog8MkQ=;
 b=XEH9bVtrai1/VCVulJiCBTOy8g78I6PHntwg3clahWAPCjj//zLWAvEPee0UV2+JRB
 LjampA7yAfqPjb5izxAEcfbCp4CWlov3uS6/rfv2wxtccqRTLDsq051fJnDU4AzT2nEk
 3AirftJ3HYHFPUmdmhi8As2e7VVpqzrWKL/3B1JeLATPKHpLtkkAGc1Am759yUWhi7Z7
 6tXGKqeLTwz9u6K8YfCAA7P/h4ij5NJttAxf4DO18xp6CCWzZnZOkpNCljKJ6Rqt1Sko
 On6f2zFrry80UMZpzPG4vxibNuq9759DxDKfzpMdMm85Pzkdc9fwXcK9+vDcJM2nqMe/
 +wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134105; x=1778738905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1EH6c8/6d5U9t1bXTH6utae0BZx1/5EUl0ntog8MkQ=;
 b=dJ3phXa3taapeFNSDMcrpoIwJ7O/BUHyWlHhojfjZHAFO9wQXhWZo3c7je0nvanRZV
 vLf+TGs/4QCdx5SULtREdbq6wOjc1+9cvw5U9niJZbB7GISc8XyswyLw4R7phpvweAFC
 inIsmcPwbw53T1JSZuUm+p7ISgb6KW3IUuJsqTCLX7PcaWk55xsV3c8gWp7/Yp31Z5Zm
 HRu3jY3fhxhJbZFJC/Mp/22tEi5g7RB9ihLV9W8LrBju3HE6DjSkynM1a4i0ApdI/7ld
 1qgIP6Vqw2IEcPiViNznVkH7P1GduXSHhSoGpo5/5jyJEpF/e/PZvHPmbQk4PLJO5XIQ
 ILlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zzZgn+GjBN/UEv0YziGQoXlk3vpAdbZnVSXcAqvE4D8ktmQhKbWLDFwn0rBl0CicDDAck/anGpjDZ@nongnu.org
X-Gm-Message-State: AOJu0YzGb/11IkkOmYtR2rBA3e82Tlo3qEXqBp1M8GhDjnDcb16SoAWd
 NtAGlHiexEq5edrJqexL0na8fnheQn40sZ2tFaAI0byZM4PmKWJ4T05NsDdeDpo+Udw=
X-Gm-Gg: AeBDietqr5U8PXq0k9+EkWnIFYhlF+4WZNoI1sVMf5V1Sm/yceakELIbiswK+IQD97B
 PZ5we/aO5hYMXwQXDzQjUE5MyGnBdkLV0aulmMzR5Ja1KxAa2fjpgW32pR2sH56+3S7frSQlpqY
 +YewR4cE3xpHPendPTWdcc0/h1uLIZnDNXBKZCwmnyGHwZQ3TubYyzHrTAoaTKPqSp254W6Vxi2
 XltFXiHICUAF++TNl9ZgSCva9Q23Og/N1fJDHpbv5kLfHVnZIPeNJJtZ6m2/NCtey4vED7lWkEX
 p10e1SFPGCkMrcx1os1M5tpawRiu5z60aU4rfaLBad4qupcnd1XOmf7VgkCM62q1bxEyWwZBUm9
 OC6LJCzr66pwzeQzHxIJRgaUbe05Q4hY9A5lWg8P2D4zEqVRgTngvO/m+R+fcZi2lZop4TqLvZf
 5/XTU0d0ty5YP15wJCVZz4YGWesqUu8lyJk5APVJAOUsgDIrJjnIF117VLLoUT1I2EqGMPGtNiF
 mzg
X-Received: by 2002:a05:6000:2082:b0:43d:7e34:889c with SMTP id
 ffacd0b85a97d-4515da97e81mr10529326f8f.39.1778134105441; 
 Wed, 06 May 2026 23:08:25 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a488d8sm17437793f8f.12.2026.05.06.23.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 23:08:24 -0700 (PDT)
Message-ID: <08637f36-ae2b-4191-b668-93e59e283c92@linaro.org>
Date: Thu, 7 May 2026 08:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove the deprecated glusterfs block driver
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org, integration@gluster.org,
 Nir Soffer <nirsof@gmail.com>, Nir Soffer <nsoffer@redhat.com>
References: <20260507051639.2784590-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507051639.2784590-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/5/26 07:16, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Glusterfs has been marked as deprecated since QEMU v9.2, and as far
> as I know, nobody spoke up 'til today that it should be kept.
> The listed e-mail address integration@gluster.org in our MAINTAINERS
> file seems to be bouncing nowadays, and looking at their website
> https://www.gluster.org/ the most recent news are from 2020 / 2021 ...
> so it seems like there is really hardly any interest in Glusterfs
> anymore. Thus it's time to remove the code now from QEMU.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |    6 -
>   docs/about/deprecated.rst                     |    8 -
>   docs/about/removed-features.rst               |    7 +
>   docs/system/device-url-syntax.rst.inc         |   39 -
>   docs/system/qemu-block-drivers.rst.inc        |   84 -
>   meson.build                                   |   47 -
>   qapi/block-core.json                          |   52 -
>   block/gluster.c                               | 1644 -----------------
>   tests/qtest/modules-test.c                    |    3 -
>   block/meson.build                             |    1 -
>   meson_options.txt                             |    2 -
>   .../ci/setup/debian/debian-13-ppc64le.yaml    |    1 -
>   .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |    1 -
>   .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |    1 -
>   scripts/coverity-scan/coverity-scan.docker    |    1 -
>   scripts/coverity-scan/run-coverity-scan       |    2 +-
>   scripts/meson-buildoptions.sh                 |    3 -
>   .../dockerfiles/debian-amd64-cross.docker     |    1 -
>   .../dockerfiles/debian-arm64-cross.docker     |    1 -
>   .../dockerfiles/debian-mips64el-cross.docker  |    1 -
>   .../dockerfiles/debian-mipsel-cross.docker    |    1 -
>   .../dockerfiles/debian-ppc64el-cross.docker   |    1 -
>   .../dockerfiles/debian-riscv64-cross.docker   |    1 -
>   .../dockerfiles/debian-s390x-cross.docker     |    1 -
>   tests/docker/dockerfiles/debian.docker        |    1 -
>   .../dockerfiles/fedora-rust-nightly.docker    |    1 -
>   tests/docker/dockerfiles/fedora.docker        |    1 -
>   tests/docker/dockerfiles/opensuse-leap.docker |    1 -
>   tests/docker/dockerfiles/ubuntu2204.docker    |    1 -
>   tests/lcitool/projects/qemu.yml               |    1 -
>   30 files changed, 8 insertions(+), 1907 deletions(-)
>   delete mode 100644 block/gluster.c

Need a rebase on top of commit f168046842c ("cocci: Do not
initialize variable used by QLIST_FOREACH macro").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Apparently we could now revert commits a6b257a08e3 ("file-posix:
Handle undetectable alignment") and 3a20013fbb2 ("block: posix:
Always allocate the first block"). Not sure if that could be
useful for other backends or harmless. Cc'ing Nir.

Regards,

Phil.

