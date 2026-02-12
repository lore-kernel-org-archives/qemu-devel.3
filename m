Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5EEEEA86E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgPv-0006Mc-JO; Thu, 12 Feb 2026 18:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgPu-0006MP-IL
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:48:14 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgPs-0008Nn-K1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:48:14 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso264961b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770940091; x=1771544891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+F3NvcCCfCkxs/F678+r9OW/IUGA4KW1gpVM30C03pA=;
 b=Owy2zv0KFcqIyZQ+Hxog9TPTpY0FHiCs+sc4CNnv0Yk7oMRp78HRax5jyIs1mVyrM4
 caT1+L90i3mkeLuEFrMIkNA2U8wY5/8r0ke7L0V9fQ6mw1yXxaimaykRB8ggoNz6kKUV
 /CytPHZYwr3HzloJYAywmuZtUoncTi97/OUp70JZkvNNEOjkRUp1silsIG7vvfWGT4Oy
 En0piz+hq2pzXjGsQPklT/Rlesp+fJ2xxNLzLJvZtQ0cqBG8PsgcXTyjac6zv/YntQ8e
 GLyONT1RsRzQRc2w59K2AH6GWfnLWkat+Xk7Vpw72qBDpNheW8XswTTWarT5uotOF4v5
 blfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770940091; x=1771544891;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+F3NvcCCfCkxs/F678+r9OW/IUGA4KW1gpVM30C03pA=;
 b=AZNVP5T/it6ximxCwnsYLFWR3rg8dq8qmhSg8mE0TpS0vCl1FIzSlz84YArhNuvXkv
 2hAumilXIpjlcWs2uU7wsbOSC7WbsL7pNfe5122afkEuaXAagm88DFFzJrsKwf14X3FU
 2qOwGttd4tsUZAREj4FfIS3nMtw2GiQFEKugU0hA/HcFmLcqMUCwd6FCLXCGYxti3/CH
 WSBhvbPYLbIW7Wyi2E1QSfdC47Ngw6ytJPLHk60FW7gX/sqyvz1PSSKWpfPwiPyjnRQs
 q94LjoKFFu4Q+p3dpHZ7ZJ4bhw+cpNLrTtFoDu7C8zXJn5zLjTekodcixHuA0stVXMjl
 6jfw==
X-Gm-Message-State: AOJu0YyjcVj3Fu01uN84ZidxEhJc5M2itdoQYJyyOewQ6ROqbibqEuG5
 8M81MN6lY+o8BNzE9D2yxp/qVCAlSwhrfVDueEB46bccGZhP5I5ytDDSSHmcWdBQmrUAgmHvqxf
 v8dPT
X-Gm-Gg: AZuq6aKHw8cL+L40zizEBFXmv3vdcScyXIdV9WGutLRAk51k0UaV0rk/RSm4YgP1/85
 WvKwDajGCOm2v8mqZg+omkNrxUwR9c5R9fIOLmb9Q5KtI2MWlXMoaaM0/wtizgaEod/h1GgsOfO
 /lVI++pUwU+AsHW+RVkGslxpG/bai0oTfZ4fZPnONwX6VxfQ1snjkGxp3SP33HPzN/mDT9ZbU9a
 nyb8zhak9imEEhj8Bprl0F+flQVFjw3zridnbElX2zaVk9HBxX0eUAes/wgY5QrBb1+uvQKcUtr
 79GLAmpqSc9DpWoumpkfcoQ/VDDz2ejUzX1PcHebu2KpdoXL9giAesM4PaBKML0hZfzSLYfFDLO
 cb1YfY4C8r/h3Dpl2WOY58pLklY9sXHJtlVM7aJpedCoGVSGaMP9CYYseztLwq+7tEsk88DI3+y
 exA/6WHCEBthPwVeb3KpxBndSyF3o8wSNsb4GYYBJKD7O+k0Iifo1wkZo1I1O4eOFi8nrb
X-Received: by 2002:aa7:88ce:0:b0:81f:7db2:89cf with SMTP id
 d2e1a72fcca58-824c963f9e8mr96167b3a.39.1770940090889; 
 Thu, 12 Feb 2026 15:48:10 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b9a0c3sm356277b3a.51.2026.02.12.15.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 15:48:10 -0800 (PST)
Message-ID: <2a3ad34b-a227-4a48-b44f-cd139693bfb0@linaro.org>
Date: Thu, 12 Feb 2026 15:48:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] single-binary: hw/virtio
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/6/26 2:18 PM, Pierrick Bouvier wrote:
> This series eliminates target specifics in hw/virtio and replace them with
> runtime functions where needed.
> 
> Performance has been measured with this automated fio benchmark [1], with
> original instructions from Stefan [2].
> 
> Download artifacts and run benchmark with:
> $ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
> $ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
> $ ./run.sh /path/to/qemu-system-x86_64
> 
> [1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
> [2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> 
> Results are on 20 runs and expressed in kIOPS:
> reference: mean=239.2 std_dev=3.48
> with_series: mean=238.5 std_dev=3.46
> 
> Performance is on par, and within standard deviation.
> 
> v5
> --
> 
> - Fix missing vdev->access_is_big_endian when features are set
> - No difference in performance since hot path is not modified
> - Simplified virtio_access_is_big_endian
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
>    include/hw/virtio/virtio-access.h: remove target specifics define
>    include/hw/virtio/virtio-access.h: simplify
>      virtio_access_is_big_endian
>    include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
>    hw/virtio/vhost-user: make compilation unit common
>    hw/virtio/virtio-qmp: make compilation unit common
>    hw/virtio/: make all compilation units common
> 
>   include/hw/ppc/spapr.h            |  8 +---
>   include/hw/ppc/spapr_common.h     | 16 +++++++
>   include/hw/virtio/virtio-access.h | 43 +++++++++----------
>   include/hw/virtio/virtio.h        |  7 +++-
>   hw/virtio/vhost-user.c            | 11 ++---
>   hw/virtio/virtio-qmp.c            | 70 -------------------------------
>   hw/virtio/virtio.c                |  9 +++-
>   hw/virtio/meson.build             | 17 ++++----
>   8 files changed, 60 insertions(+), 121 deletions(-)
>   create mode 100644 include/hw/ppc/spapr_common.h
> 

Sent another series focusing on refactoring 
include/hw/virtio/virtio-access.h:
https://lore.kernel.org/qemu-devel/20260212234602.338131-1-pierrick.bouvier@linaro.org/T/#t

Comments are welcome, and hopefully will help us to move forward with this.

Regards,
Pierrick

