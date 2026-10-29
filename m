Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5F606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QFiNUllm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMROV-0004FX-PJ; Thu, 29 Oct 2026 10:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMROH-0004ES-UA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:46:06 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMROG-0008UD-6R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:46:05 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-53656465d1dso878586b6e.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793285163; x=1793889963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yy+lr5FMHeqWm/1N1Q2lqk1zOObtpinbZ9358NIzjxA=;
 b=QFiNUllmjXet8rkk8KR/2i1UP1WTY2/G7lve4uEu/ma0yj16m4ruHZbuR7AZIpYuWP
 I7Z8YSdravLJvfFxroM+ljdRRJfbWFmxBMlZiNxSwyYTSpac3RpFKHWMNCS74fmk7ZrR
 B9/5b8k25ERt2FO/DZwhmEjGWaZD0RXNh+UiCOkZrnPVPc+4ZETc+vI259SSGPBWNqOs
 ZF/nMSEeu62D37qlIjbWYp4yg/562Rr/GSQx1dUdb6vnpuxNfF8IhjAYE1ImGWyMlI1Z
 /NSaoM72OwTArnoS2ZnFSMYQ/NS9rNc3NnK4bwzKFCJjDgSWMN+PbDD7/boOCRLyWfWj
 xkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793285163; x=1793889963;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yy+lr5FMHeqWm/1N1Q2lqk1zOObtpinbZ9358NIzjxA=;
 b=Yi7qYVrBMQltZE4KICitfUgPN+Y58H6AQk/ySXxDqBV1SPjoQQxGsUNtzaBBx74wFz
 Qs36EvN7V5NM99gVDhXUFNA9Zx4b+EsdNqr2/0MNda5t4CsDUx4r/w9tsXs4YBKY4Usz
 kJIuTvXCy070dL9pLHltCT0MHc/PfMoBvbDYA76ioz1mCz5Q3CYJ4l1xmEhG0w3HyWlK
 XzOMmzOVdqT/Mzy4eOvdVdaJuHgLKpdwhu3JvVoulqb/3x7H979oKgkhaxfZmb762MM8
 gX3f9haIeb39J/eTPQrqgtjjTfu/7JpoXhOgxP7u8dgkiz5xvVVfPRPI2M/dTikPd356
 dw7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHsOHuiu53fb/qfDE11xA0g0eEPcoxf3sPuBP46tkCZTvtLINqH6+ragS3mEtYMO5472FR2k/o68o+@nongnu.org
X-Gm-Message-State: AFq9FYIc0WqbyztrApx3kZ+0s/LxVw1nFe1RQMC7wqMmgJvX4O18uTAK
 /Raq64JE25pBzmBv/gguEsESwyAyZv4pNqxq7Ztrlv3f3eluAPkj6tMvLRQasiC1atQ=
X-Gm-Gg: AYBFou0u6T4IgdRM+rVLqtAeOV0XmEfaMvWZdQ2NUKyG+h6j385Rq2LhJ9hAaUOQCIj
 1uxtbktInYtFyYL0oovMcxWge6FCd3LsA6BcbtqrFQsvTWODuEdJWc6GV3k0Wc7vQjJlxl5EJ1L
 SlaCazD6TxQsdVQgBhheh7mVYIj5MQV6KRXS1mkW/xr7tR/ifploQ5yw9+gZj3rExGy0n5n7WOD
 ZNV+/NFQKSDrrX96EfAzom+djaaQH/mfemVeV8yRs01uaosYAGYNQhM3E6kP8u/h/M4k1BRNwsl
 OZm5KIKLcVrS6sO+E1wh45EZMYgRnLp7ZdCnFfYw+Rc4sDXqqzQKnQUzPuF7epYikeTJNDbpIuu
 3lZUJPBX5XD/2vY1+jzyWYyfdn+3aOVpLIXlo30LiPrxHhQT0HYBgL7HScOz2yGWPMHUInyhcNt
 aroi63iYOVf7veR0ZxRJkstHqVazHp8SW6owLZIRjIcGTAp88DmrCpMJI0Y2QMKSX5+y9sjFQN1
 l0jZX2kL+V6262Ukv1LlJSqo0ZPd8xVF+Y5D7cxc2HziRYKTZJvEYs236FQkYplNjli/31fglFb
 a9tV3FREdOA0Jm1ttiNAWRkzH5DxgYaznjpSsXZ/xVtn
X-Received: by 2002:a05:6808:318b:b0:4c4:28a5:1885 with SMTP id
 5614622812f47-5637ffe1390mr3519195b6e.9.1793285161710; 
 Thu, 29 Oct 2026 07:46:01 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c603f72csm3902543b6e.10.2026.10.29.07.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 07:46:00 -0700 (PDT)
Message-ID: <16d3c4db-6548-4c68-acd3-2eddb59cab5b@linaro.org>
Date: Thu, 29 Oct 2026 09:45:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/78] pci, vhost, virtio, iommu, acpi: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1793207602.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 12:13, Michael S. Tsirkin wrote:
> The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to c155e7e9e025b60ce17e26a7c382d86f3f9c9fee:
> 
>    virtio-net: add mtu-from-tap property for automatic MTU detection (2026-10-28 13:11:16 -0400)
> 
> ----------------------------------------------------------------
> pci, vhost, virtio, iommu, acpi: features, fixes
> 
> multiboot can again load 64 bit images
> vdpa-dev now implements guest_notifier_mask/pending
> pci bridge can now configure the negotiated bandwidth
> tap can now auto-detect host mtu and expose to guest
> amd iommu can now attach on non system bus
> vhost-user spec now has its own mailing list
> 
> Fixes, cleanups all over the place.

New failures:

https://gitlab.com/qemu-project/qemu/-/jobs/17577211343#L867
https://gitlab.com/qemu-project/qemu/-/jobs/17576922092#L185

Use of sudo in containers where it is not installed 
(functional-system-centos, functional-system-opensuse).


r~

