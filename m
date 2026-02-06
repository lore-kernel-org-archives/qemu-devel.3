Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F039EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUD9-0001gR-O5; Fri, 06 Feb 2026 17:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUCc-0001ZU-DE
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:21:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUCa-00089I-JH
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:21:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so7624555ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416483; x=1771021283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fQmH6R+uNvWYHBSHwdfISIUCMbJeAV1THVHuENCAVYI=;
 b=HZb1IxBIIdM18u8Q2o0HuaDMO2iss0u4vVF4ZxT5oiGuJvXcucXmltdPhW6eK364cN
 5fJay2tpo1cwCa3QtdKVZj3IFXRFfQ47u6X5XHPNuKCiKDTbGKGXV93/EoFeOhCcy6mc
 4uk4kFRN3BmXC5ZiebQU9P7ryb1PCJrjSSF3zo9+DqmGqWyyYMlr7sPQRHHXNJQ5PAn+
 lBlmek+q4FmReT+2mq8/QOK53X9V+qMdThP9BYaF1jlm/AbT0SqSY006Y7BhyiMiD1NL
 HGk6PjjrKnantUL0MiUBn+cAf5Ak6Cry695tyorGuXY5kO9hIaVa0HXJnh5S5C7A8NCV
 bMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416483; x=1771021283;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQmH6R+uNvWYHBSHwdfISIUCMbJeAV1THVHuENCAVYI=;
 b=ekj35Ma/tKRxTevwastXS/x291dp7m+ZdeMG+poaxGya0nXRdYhA5T9AqiRmzXst07
 WbuLfNN5x3q5FzeBBU945b3+PdyZvPNTAWoHjiHWO+/0laOL842rXI1/oeqAlybafewv
 SlSSFil8FEfouDa2XwpXwsA0UD9GFTp5cVC5j1KdNiqA9Od5UoyFtagxuyL1FzDdObC5
 A/qlq3Coe3bTuNNH98cBKuA2e3oSkasZtY0jxqj6q23U5z+0mO9hRv+0G0HeC8TyIy2T
 +q8cOxXhyL7xCDlHw6/89DX/YVoJWFFFhOI3JKWqOaUQAGkSYKRlUo7ZcRoEsWWWw+90
 QqOw==
X-Gm-Message-State: AOJu0YzUwT6stUo3bqr8DUdWKYvOFABx8vVdOayv0SKMKkxDdZ7RhLVe
 7POUlD5bsQ/PHPAu7Iujswc/U9fTV0q7WceI7epcwL0COAK47bWb5qLznXvrHcJtUIRBvJ0gvbh
 mYB1i
X-Gm-Gg: AZuq6aKkjWOEPp4NiFq3KZ2eSKdfLu4dqTLW7Muk+zEiDwq7UFiHw3+p1KAjqsfzd9i
 8pa0kmaxtk5uwJPk8vmovYJmfnvMPe+v8Di1E0vkaaB0dpH7uDcQNSaIS2vCem2+W2W+xtR/kTa
 xb7Pk2Wugwmx09YyCxg21wP4Pfbmzo633MJCtHKSAdzgMKhcihrp0KdA62IW0dc+hGONpkxiept
 CGEy+LwcEYAQB8j+9VwLzE33zhzhsza4r/SuGvE2SN3XfHOLD6QEJghiJLSFSNGcAyFkKUdK4UY
 nmRR4PTikVmUViivTznIM1lLH3l8dukUasLZjX5MlQWE/FPpr5NLOrqyKkL2KHI+MTPmDg6FwmQ
 cAKr/zqRIKuH6J2kTQwPoR3NQw+564iTDtwTYemiF5ipPeVjiOjtjgYYNTH1WnTqLx6t5VHNU/b
 fBCX0SYQlGJO3z0LmnO8/cInJ9Ap1X2jgpppuzxxcpQyQL5nGctCtVv3Rp
X-Received: by 2002:a17:903:198b:b0:2a2:f465:1271 with SMTP id
 d9443c01a7336-2a951819773mr37455225ad.44.1770416482486; 
 Fri, 06 Feb 2026 14:21:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c7a047sm32507595ad.27.2026.02.06.14.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 14:21:22 -0800 (PST)
Message-ID: <66a20c3b-eaab-4042-84f9-4cbd8021d9ce@linaro.org>
Date: Fri, 6 Feb 2026 14:21:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] single-binary: hw/virtio
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
> This series eliminates target specifics in hw/virtio and replace them with
> runtime functions where needed.
> 
> Performance has been measured with this automated fio benchmark, with
> original instructions from Stefan [1].
> 
> $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_64_io_benchmark
> $ cd qemu-linux-stack
> $ ./build.sh
> $ ./run.sh /path/to/qemu-system-x86_64
> 
> [1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> 
> Results are on 20 runs and expressed in kIOPS:
> reference: mean=239.2 std_dev=3.48
> with_series: mean=238.5 std_dev=3.46
> 
> Performance is on par, and within standard deviation.
> 
> v4
> --
> 
> - Include Philippe patches computing once device endianness to skip runtime
>    checks on every access.
> 
> Philippe Mathieu-Daudé (3):
>    hw/virtio: Constify virtio_is_big_endian() argument
>    hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
>    hw/virtio: Use VirtIODevice::access_is_big_endian field
> 
> Pierrick Bouvier (6):
>    target-info: add target_base_ppc, target_ppc and target_ppc64
>    include/hw/virtio/virtio-access.h: remove target specifics define
>    include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
>    hw/virtio/vhost-user: make compilation unit common
>    hw/virtio/virtio-qmp: make compilation unit common
>    hw/virtio/: make all compilation units common
> 
>   include/hw/ppc/spapr.h            |  8 +---
>   include/hw/ppc/spapr_common.h     | 16 +++++++
>   include/hw/virtio/virtio-access.h | 50 +++++++++++-----------
>   include/hw/virtio/virtio.h        |  7 +++-
>   include/qemu/target-info.h        | 21 ++++++++++
>   hw/virtio/vhost-user.c            | 11 ++---
>   hw/virtio/virtio-qmp.c            | 70 -------------------------------
>   hw/virtio/virtio.c                |  5 ++-
>   target-info.c                     | 21 ++++++++++
>   hw/virtio/meson.build             | 17 ++++----
>   10 files changed, 104 insertions(+), 122 deletions(-)
>   create mode 100644 include/hw/ppc/spapr_common.h
> 

Sent v5 fixing the issue found:
https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

