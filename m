Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03569C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 06:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsNw-0008GO-1f; Thu, 25 Jul 2024 02:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsNj-00088w-Fv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:55:19 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsNh-0008FG-0h
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:55:18 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef2cce8c08so6438951fa.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721890513; x=1722495313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iieLEtpk7YAafGJtNDUE6uuRJhpc8FI+839Sz9VFd8I=;
 b=v/IA4J39DiCMayGpThMJHQsBva1iDe7wbnzZDXY4ryXjmZ7wWdeFhmBKjG5R/Sq2WO
 vlUUedm566pI/cPnGPzdTNw7xC6RbQBjTx7UTWYEzeQ1F4kcW6RqeGOP/bndXsufmgxJ
 Sj/Ur5aCSdkG46Y6bg944VP29fxFfM18pKRrYSToEo9YN2Tr23frsD/h3evf7V4mT4hd
 IFPUFpkh2S27Zc/Bp3R1ti7xjGgKxBCSCerny+CO2ct2/PPWrV1rrih8DeRh5Ga7PkDi
 acjdSua9fQ7QOoeZesnbqde0vBwHh+vWJBEQqjFZu00G9R7lnPYlsUkmlQ/XPmaVd6sL
 Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721890513; x=1722495313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iieLEtpk7YAafGJtNDUE6uuRJhpc8FI+839Sz9VFd8I=;
 b=tgobgZTCzYMYPRacF5ma1km9RlT8NuVSlEfCZapQ3ugM5pm/z7+DjkoEb5bnItlO4c
 nu+O68BU8FiQ9F5FvyrmZAUczFBF6rWhkmh8i0EF9Ms+u5n+34t0v4Nrh9H7E+QhKxxR
 gVfN3ACE8FQmmiTnZ3ZxFpX8SlSSJYD03mrj76iKSDiFGLukJaygXXXHpGsaDSXU6UyD
 PFCmVFPDdmL7yyzlGmBUclqaACwqgurOo8XaAEwUzZr0w63dYsKEwzjUrpOlz47LWfVo
 22al13atm4G7UYiT8j6vZrXmdnN4AwXitARrX16l/tN87VKwWNqKl/YkDk3O4agwyxFz
 Pt/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhh7EJ/ISonx7khrv+dpfwezw91DxxIxB6AsJ9AtxinaE9cE2y5gAZ/vq1yFQwJr9pxmCwG4cuMpzP7mLtIQrxkrgNoYE=
X-Gm-Message-State: AOJu0YyDgcPcgUAPnHnc+CKYXXMNmdOtJo47COYENmaApe9gCbwqXg3L
 PKq4RrYrSCo8MSctYlBYM07EYz9L9yvOUudqyZ21003IE+/Vov97tSM2vqFHniQ=
X-Google-Smtp-Source: AGHT+IHwWDbTogcuR6AJr0c3QKWfNvM99uXGNIhZqzbi09DdPXW3fQCR1fA7hBZNUkLSssYnkL+LIA==
X-Received: by 2002:a2e:998d:0:b0:2ef:2b44:9977 with SMTP id
 38308e7fff4ca-2f03db7e00cmr6051571fa.18.1721890512542; 
 Wed, 24 Jul 2024 23:55:12 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9372a5asm61161575e9.15.2024.07.24.23.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 23:55:12 -0700 (PDT)
Message-ID: <d60683bf-724a-474a-ae97-6ec2eac775a9@linaro.org>
Date: Thu, 25 Jul 2024 08:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] tests/functional: Convert simple avocado tests
 into standalone python tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Hi Thomas,

On 24/7/24 19:52, Thomas Huth wrote:
> These test are rather simple and don't need any modifications apart
> from adjusting the "from avocado_qemu" line. To ease debugging, make
> the files executable and add a shebang line and Python '__main__'
> handling, too, so that these tests can now be run by executing them
> directly.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  5 ++
>   .../test_cpu_queries.py}                      |  7 ++-
>   .../test_empty_cpu_model.py}                  |  7 ++-
>   .../test_mem_addr_space.py}                   | 52 +++----------------
>   .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>   .../test_virtio_version.py}                   |  8 +--
>   6 files changed, 34 insertions(+), 56 deletions(-)
>   rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
>   mode change 100644 => 100755
>   rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
>   mode change 100644 => 100755
>   rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
>   mode change 100644 => 100755
>   rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
>   mode change 100644 => 100755
>   rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
>   mode change 100644 => 100755


> @@ -22,9 +24,6 @@ class MemAddrCheck(QemuSystemTest):
>       # for all 32-bit cases, pci64_hole_size is 0.
>       def test_phybits_low_pse36(self):
>           """
> -        :avocado: tags=machine:q35
> -        :avocado: tags=arch:x86_64

Could we keep the tags, but renaming as:

           qemu-test-tag=machine:q35
           qemu-test-tag=arch:x86_64

?

I'm OK to implement the equivalent feature in QEMU functional framework.

>           With pse36 feature ON, a processor has 36 bits of addressing. So it can
>           access up to a maximum of 64GiB of memory. Memory hotplug region begins
>           at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when


