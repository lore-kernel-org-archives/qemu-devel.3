Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F03C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngOz-0003QS-4f; Fri, 22 Mar 2024 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rngOv-0003Q0-Nz
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:01:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rngOt-0007Y2-Pr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:01:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso1266189f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711119701; x=1711724501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V6b+ejAGAOE5/dAtCKvwYsyIRYzDFgfqlgX0jMwzj8M=;
 b=liDdevaD5AmS5Vskdcqj+oV9huS7OducCW5j2UFeMPRV/1op51Am964n1ni2EbZ9v8
 ybCnUIlpsu9TrSs+QvD7AXbpNj55HwcImw5onQZXwUjQbZYupZpGdd8qsMrDex6IiV5d
 2GYbl0Nx8banwy70+eJ1iUqQf1gxFDSv0Vh0DCgslxEvAltfX2M1RmEW7A07n2IOdkDx
 XEO4DSAlB4YOyln24iMaoyI5ea+gC3DIbTMeMkKtQh1/JSvGe/lhOoeX3/BLpEwL5wO2
 2Hrgg03zGYBuFOEh6/vdf+MYbZ28BG0iaFYh7HRRNyzF43z2Y9ysAhUQb9foOwv2Kre9
 BZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711119701; x=1711724501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V6b+ejAGAOE5/dAtCKvwYsyIRYzDFgfqlgX0jMwzj8M=;
 b=WkEHKdLvALO3R/fuoN0WqEt+croMedED5qD2rcSBeUNqmm9ol+4r2LyJ+oTCm0KDB5
 fqXSA0Q0DX5qY9/l5SQtTnlPWhj932QrQ0+EahzVazSHI1RnoGb07zalPmvuy2TBJE1S
 PwGn5AXMGIGjlbr2dMl+mz9fmo+nOH1q1w7ttvpPsI1670m5uFQ2QtaSRDUYEnL4sZ0p
 ljFtlvNbHxTfgiDyyZKSRjchzJBYHdi2aajsghe5AznuTPHSeBneo+aUI+epKmhO1IDT
 AhqDofo/PaV/tGtxewxvBL3V1oV/iCC5rQYifDFg9iqTavmoz2jc/95p+/1ao36DoC/w
 nalw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSkRNW+9EgK7Ogx4zojq1V8/BCzTw9fGxTZcGmawAjSrFcEq56ucFFVxnVpKFGuHhVOeluLTtiC5iA1l0j2OeW4vHxsB0=
X-Gm-Message-State: AOJu0YyGP/MpNIWI1UiP/qFyu224FSiGYBuEHgciJTQ/A9Y0D+T44ovf
 9YYliV1N5PvkWX5HYPpt+wM2fnYP4XHaZTIycuQiReKVIMuBzptFLi9qM9whiB8=
X-Google-Smtp-Source: AGHT+IGrMdMljSWdmBKnfotmBiqrI8DrbPlT5+ZYG28JQBxyDU3y5+jWNQMhLaKdusBQh1TrfD6mtg==
X-Received: by 2002:a5d:5441:0:b0:33e:d2f3:cbff with SMTP id
 w1-20020a5d5441000000b0033ed2f3cbffmr2164040wrv.23.1711119700957; 
 Fri, 22 Mar 2024 08:01:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 x3-20020adfcc03000000b0033e41e1ad93sm2230173wrh.57.2024.03.22.08.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 08:01:40 -0700 (PDT)
Message-ID: <4ffb9edb-f4c3-4775-b05e-00d233ca2e65@linaro.org>
Date: Fri, 22 Mar 2024 16:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v2] vhost-vdpa: check vhost_vdpa_set_vring_ready()
 return value
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, lulu@redhat.com, eperezma@redhat.com,
 Jason Wang <jasowang@redhat.com>
References: <20240322092315.31885-1-sgarzare@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322092315.31885-1-sgarzare@redhat.com>
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

On 22/3/24 10:23, Stefano Garzarella wrote:
> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
> patch [1] will be merged, it may fail with more chance if
> userspace does not activate virtqueues before DRIVER_OK when
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
> 
> So better check its return value anyway.
> 
> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Based-on: 20240315155949.86066-1-kwolf@redhat.com
> 
> v1: https://patchew.org/QEMU/20240207092702.25242-1-sgarzare@redhat.com/
> v2:
>   - added acks
>   - rebased on top of https://patchew.org/QEMU/20240315155949.86066-1-kwolf@redhat.com/
> ---
>   net/vhost-vdpa.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


