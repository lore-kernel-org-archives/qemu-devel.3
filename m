Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E26FCD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtRZ-00074g-Ud; Thu, 07 May 2026 03:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKtRY-00074D-G1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:46:48 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKtRW-00008D-LA
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:46:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so10627515e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778140005; x=1778744805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QHgs1eyozQiR95r+VSjvkiFeFZro/U9FmIRetgp4N7s=;
 b=O6wKzw3VYUuKklDFoLFDufTIn5pRRPgvBlAxtDouMFSS4SQH45GfaTZNNszzYDJcR8
 dnb5GPU+PtFGnlXfS/MrgGCuDQW7jxRv5eMGeHe4nLMwG70Amt/SLuxHpXvDaW/sRYsk
 ygGuYAoLQ89mYgEIO2BUYDHY5SOh+ihk5Bd1g8DZHw0+oCtuKcAtMrSZeNyoiJP+JGcu
 q2hmWODycDFjWckMPm9lxzwKRSJdQqQam4wA84DtR7BJLXwjbDGrOwVX2aNM8GI1yGR3
 gFCD0bhfYqdGuap0Y6eZS2j9+FGKxaZuOlAFF4kR62gy7+DWcwaJz0P8N9dB7PacEB6f
 +iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140005; x=1778744805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHgs1eyozQiR95r+VSjvkiFeFZro/U9FmIRetgp4N7s=;
 b=syoXkyBtm24K8hSSn463v7AKa9WYLCgy359qJdmWrCpci5OZW0xqeGfhD4wftpnn+p
 bUacN6pmN1EwdfuBYZbquaCmc93jTyxerTxJGKYvtP6OQC9sITo8L85bnynG7cbtDD9g
 mJKR30p0QU0RRV6+tsf3aKMNP3M48TkBIrOXOcXCT1hhzmIKnAXaMAF5xz5vSNcMk9k5
 hermiVuE0vmt4IfbBBpbeQjDe42+OI67r+/e6llmyAdLV+Mb3rxHcEVSNS30W9f7SDVZ
 Ec+kMSMujsjhmW7SkTHiPa/Du3bnPZt7DrZMw7kSIHIJK2NFT+QQq+PLXHHcjToL+mP4
 YjjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9815ph6a5vIl++gzXeJ45rCwbNudJabBVXy6sjActBQtlI9cd7OfMTRn6hT5nIqKcRwzCAa7bfgA7f@nongnu.org
X-Gm-Message-State: AOJu0Yw1OY+Bcq9qho0rw/F4eGTqt8OZJ7Nx1Ibnx/8S9gwHyPw62EX7
 VkFdVvu4lxId7rz4r9lf5OaB/sbvQhlmLTazmqCNzMrjxDlogDSxOTgN+4R94SMH+ww=
X-Gm-Gg: AeBDietWqKYqhrofXz5kktqihP8+Y9/RI1MQw/kSSpkDQ9mey022+74+MNgA1om43Os
 0pvF1OlRO4i31oVUlVZMLJBW4azlfSNq+HTA6sWx0k6VTnY3p07mrNUv+JXsf1ZM8JaDZnSyC2u
 lw6mc9Yi6JAEYAeAg5ZpHdm4+DMcNVejkPgZIGrzq1DZ6ZfHgUfj8rXZU/HummI/9luDvsuHVrh
 Ch22/N8Gxf7kiPoctmgRe708u47VsespaUe8Q80GAG/jXBwrk+3Qbx7kp20lRjbujLMdv9ZZ5tc
 ggLH18N2tVQbzpIEp3joXZNXPlJV1VyvO7zTjHJYb1hYoqrBccPtp+o35PNaFDQbE+Hax30dO4F
 GTIF9KUYcsNJIVJ89u0HkZjoumV5C2W9hcszu8NLOX15UObd19iUR62u8GZcuKXFy4LmyfcT8Ln
 PSBklwQ1JXWKp6F+hCqSM0x4CRAhs1RwF3QYQ9UI+tb7Om9suOErEC7MxmALhRuEYsptnI6sUfb
 Lz8
X-Received: by 2002:a05:600c:4e56:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e5dfd6508mr26389385e9.5.1778140005019; 
 Thu, 07 May 2026 00:46:45 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fad5fsm113828185e9.10.2026.05.07.00.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:46:44 -0700 (PDT)
Message-ID: <210d440f-a83e-48ef-b313-47b8fc536801@linaro.org>
Date: Thu, 7 May 2026 09:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove the deprecated glusterfs block driver
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 devel@lists.libvirt.org, integration@gluster.org,
 Nir Soffer <nirsof@gmail.com>, Nir Soffer <nsoffer@redhat.com>
References: <20260507051639.2784590-1-thuth@redhat.com>
 <08637f36-ae2b-4191-b668-93e59e283c92@linaro.org>
 <afxCh6JcPEefhF5o@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afxCh6JcPEefhF5o@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/5/26 09:43, Kevin Wolf wrote:
> Am 07.05.2026 um 08:08 hat Philippe Mathieu-Daudé geschrieben:
>> On 7/5/26 07:16, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Glusterfs has been marked as deprecated since QEMU v9.2, and as far
>>> as I know, nobody spoke up 'til today that it should be kept.
>>> The listed e-mail address integration@gluster.org in our MAINTAINERS
>>> file seems to be bouncing nowadays, and looking at their website
>>> https://www.gluster.org/ the most recent news are from 2020 / 2021 ...
>>> so it seems like there is really hardly any interest in Glusterfs
>>> anymore. Thus it's time to remove the code now from QEMU.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    MAINTAINERS                                   |    6 -
>>>    docs/about/deprecated.rst                     |    8 -
>>>    docs/about/removed-features.rst               |    7 +
>>>    docs/system/device-url-syntax.rst.inc         |   39 -
>>>    docs/system/qemu-block-drivers.rst.inc        |   84 -
>>>    meson.build                                   |   47 -
>>>    qapi/block-core.json                          |   52 -
>>>    block/gluster.c                               | 1644 -----------------
>>>    tests/qtest/modules-test.c                    |    3 -
>>>    block/meson.build                             |    1 -
>>>    meson_options.txt                             |    2 -
>>>    .../ci/setup/debian/debian-13-ppc64le.yaml    |    1 -
>>>    .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |    1 -
>>>    .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |    1 -
>>>    scripts/coverity-scan/coverity-scan.docker    |    1 -
>>>    scripts/coverity-scan/run-coverity-scan       |    2 +-
>>>    scripts/meson-buildoptions.sh                 |    3 -
>>>    .../dockerfiles/debian-amd64-cross.docker     |    1 -
>>>    .../dockerfiles/debian-arm64-cross.docker     |    1 -
>>>    .../dockerfiles/debian-mips64el-cross.docker  |    1 -
>>>    .../dockerfiles/debian-mipsel-cross.docker    |    1 -
>>>    .../dockerfiles/debian-ppc64el-cross.docker   |    1 -
>>>    .../dockerfiles/debian-riscv64-cross.docker   |    1 -
>>>    .../dockerfiles/debian-s390x-cross.docker     |    1 -
>>>    tests/docker/dockerfiles/debian.docker        |    1 -
>>>    .../dockerfiles/fedora-rust-nightly.docker    |    1 -
>>>    tests/docker/dockerfiles/fedora.docker        |    1 -
>>>    tests/docker/dockerfiles/opensuse-leap.docker |    1 -
>>>    tests/docker/dockerfiles/ubuntu2204.docker    |    1 -
>>>    tests/lcitool/projects/qemu.yml               |    1 -
>>>    30 files changed, 8 insertions(+), 1907 deletions(-)
>>>    delete mode 100644 block/gluster.c
>>
>> Need a rebase on top of commit f168046842c ("cocci: Do not
>> initialize variable used by QLIST_FOREACH macro").
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Apparently we could now revert commits a6b257a08e3 ("file-posix:
>> Handle undetectable alignment") and 3a20013fbb2 ("block: posix:
>> Always allocate the first block"). Not sure if that could be
>> useful for other backends or harmless. Cc'ing Nir.
> 
> I haven't looked at the specific code changes, but if it's file-posix,
> it's unrelated to the builtin gluster block driver in QEMU, but a file
> on a glusterfs mount on the host. We still need to behave correctly for
> that. (And if it can happen with glusterfs, it probably can happen with
> other filesystems, too.)

OK it makes sense, thanks!

> 
> Kevin
> 


