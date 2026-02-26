Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD14FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjUA-0005x9-VP; Thu, 26 Feb 2026 17:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjU9-0005rl-AF
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:05:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjU5-00025m-1S
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:05:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so14913995e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143521; x=1772748321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VzaWCpzRlVE/OrEoxw5143dEU5W40DSa2s+L4q8jwZU=;
 b=udAwcZLPRhXHyDUgq9QDXqJD88OfxjU8nA6XDV7bzPqQfRdDfTdPfSfw/DqbVWpcz3
 eUw6K7jewvBTX6Kr0Yp3QbvDrMcrYDvwt8D3tGQFDp9iI7gKpuGSSEgA4WO+0lCX0wqF
 Vg7w1AaWi9AVDr0iLFQ8IPuz4dKlv6Wz7FRxwge7zFRJc+zVP4tNf+weJ8QNU8bOLHxh
 QCq+DDa8QVBCB3ZrfreTkuWwRYigodYaQyQJHpReGqd2Ca2QzdHDcNmDM7jVntutf1W2
 EOyTgU18W6g+8QyFtdjHrVuUDjsXluNg9C7PPfXdFVNwLCalMjc9F89mcVsOpds6bzZx
 q/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143521; x=1772748321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzaWCpzRlVE/OrEoxw5143dEU5W40DSa2s+L4q8jwZU=;
 b=wFR/SkYTgUMdzp8ao2M9tV6go1I9gLl4slZjdJfysslVy+FQNQwdkNooXe994cUQ0Q
 D61uPFqBW2ToBVKjhhyt9TFe2siwVCjvFkQQub1UcbRtawKnn0aOi+5Tx/ziGgiREYqc
 AjkMExRPqIJVukqcnGH5PfrmrW18amybDG9xGd8a+Pnh0khvoaFC/Vc8iUAhGP9PWIB8
 8H/+Wo/lfzO62upo42dEUXHy+Ki2BzerkFgEblV+i4vuYrq3tziG9AA2ZASKMiTW6MW8
 OTczKhD0ACcLHPQ2Iv+cektIEByVW+CRSAw8qfBiueUNtFyr6bv1HMmtjVPPM5ReBPEU
 oVtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSYolOCQxAqduO4G2jD4oEk8gk3kbfhNJfFoIDUcH3TpgxtuXKYjxMBT3e1hsx1S4jG0TTl7FljrRr@nongnu.org
X-Gm-Message-State: AOJu0YyahDNtKX05G9Nb0cDTz8OP5R27KkjucC5f2Ak2C/gZx9BbKOaX
 WreJyQIuCJaHGfdTyCREb2tn8oVfERKb+hvH2W7090ED0n/Af/DQ8i6AfCStXLCGVuE=
X-Gm-Gg: ATEYQzy3px5eg3+YsaHcfEwReq56xqZySl5UlIW/noTZeyiJamWWNLU25vXeAKvVeLu
 WT0l1WQVKs7VD2xbDLIxoJ1JnnYTjJSKDFCJKaXuopVvSB0Iv4a8ZbMYCiQ0+V1mHqvzRufSRty
 YumDeBaS2t4H44Tn4Sc99udMfBx7RsXRm5gICm4DzlIVzdmlnqw8OqcdP2xKCDBNz4bPzuBvACH
 sZH++lBgGKVGPiZOJnShYnWg6FIag5am9Aof3b7m6Uatqsyd4h8j4jUvOyS8k6B/O4Ovr4H3hbL
 zwDKRbQnQN3W/rDXNwN0VeYzWZSgLnRSmDRvBnUiPMG8PfM3osQ7UZeOvUSjTNm0JRjJYdR4XZ4
 iDniRh8dT8zf8C8oBOqnnpWTXf/faVYuR3baOoDVvTs8qLRYymykLonFJRQJ3rUrVDVOzGykqAV
 yaOE0D455MmHDgJd28wzobCyjibL5b/tgwIm4YXMI3fBXQM2+gB+NaD6jWCLKF3OTst0d6exB0S
 OEC
X-Received: by 2002:a05:600c:3e12:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483c9bb1e09mr6631205e9.8.1772143521595; 
 Thu, 26 Feb 2026 14:05:21 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf5fbsm43120435e9.18.2026.02.26.14.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:05:20 -0800 (PST)
Message-ID: <0dbaee6f-6ee8-40e7-a37e-82036c2ee8d6@linaro.org>
Date: Thu, 26 Feb 2026 23:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Remove deprecated qemu-system-microblazeel from
 the build
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260226084608.11251-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260226084608.11251-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 26/2/26 09:46, Thomas Huth wrote:
> The qemu-system-microblazeel binary has been marked as deprecated since
> two releases, and there were no complaints (as far as I know), so it
> should be fine to remove this now. Users can use the qemu-system-microblaze
> binary (without the -el suffix) instead that can handle both endiannesses.
> 
> v2: Drop the change to tests/tcg/plugins/syscall.c since it's linux-user
> 
> Thomas Huth (4):
>    tests/functional: Remove the microblazeel test
>    tests/qtest: Remove the microblazeel target from the qtests
>    gitlab-ci: Remove the microblazeel target from the CI jobs
>    Remove the qemu-system-microblazeel target from the build
> 
>   MAINTAINERS                                   |  4 +--
>   docs/about/deprecated.rst                     | 13 ----------
>   docs/about/removed-features.rst               | 14 ++++++++++
>   .../devices/microblazeel-softmmu/default.mak  |  6 -----
>   configs/targets/microblazeel-softmmu.mak      |  6 -----
>   qapi/machine.json                             |  2 +-
>   tests/qtest/boot-serial-test.c                |  2 +-
>   tests/qtest/machine-none-test.c               |  1 -
>   .gitlab-ci.d/buildtest.yml                    |  6 ++---
>   .gitlab-ci.d/cirrus.yml                       |  4 +--
>   .gitlab-ci.d/crossbuilds.yml                  |  2 +-
>   tests/functional/meson.build                  |  1 -
>   .../functional/microblaze/test_s3adsp1800.py  | 23 +++-------------
>   tests/functional/microblazeel/meson.build     |  5 ----
>   .../microblazeel/test_s3adsp1800.py           | 26 -------------------
>   tests/qtest/meson.build                       |  2 --
>   16 files changed, 27 insertions(+), 90 deletions(-)
>   delete mode 100644 configs/devices/microblazeel-softmmu/default.mak
>   delete mode 100644 configs/targets/microblazeel-softmmu.mak
>   delete mode 100644 tests/functional/microblazeel/meson.build
>   delete mode 100755 tests/functional/microblazeel/test_s3adsp1800.py
> 


