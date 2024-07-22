Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062CBC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0ed-0001ik-C3; Mon, 22 Jul 2024 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW0eZ-0001Xj-V4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:33:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW0eV-0002H6-JU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:33:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo7005ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721683982; x=1722288782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wVZMA4KPmaSXH6G/Y9VnDzIKRcEXxTiiObVOhZKCO1s=;
 b=SexTfleFJb+JRSrwrJGgVb/kLGBLFFByRNsN8vF34rIyMjW8nyoyZ3LDqEzWxNsAC8
 MUq/jkeXjrtwFfWPhcfr/hPjOCxeYbrR+YBd7T9Lvp5ois+QFgBSYpgiCC+W910QaQhT
 nBcLs8KeQPv7IZmkzdHOeChSBu/MAhB8jIjpnfXOv4y/jurZRZGSKAcnLHFgHelr3p9N
 Oto0tOh5u6yn0f/maAojIPJIXJVEu+xAmxSxbZjjOvLT+xaOEEXUkvGKviTi9OBjbM7U
 OM/8WUJqndddlE4YgbtX5jvKZWZbE3TlVAYo6oYdZeqLOh+ZCpqFBIt87xVukVVDbIQi
 qdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721683982; x=1722288782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVZMA4KPmaSXH6G/Y9VnDzIKRcEXxTiiObVOhZKCO1s=;
 b=sHRprHbXlb/8Ea/NioIB0+8pI2GSTdAOcdqWyydRPU79cawzWsrPe6vosDGEcUjwKC
 NaGiVJ0iuykovr3u23/gpfVER4toNvNX1VsxLfrVxWP8z1CMEnI85cIPV7yAEGnQ67lj
 +a2Or4rPBO7LqU19S9zzb3lnrlTr5krTI0gMajjvnU5LLsWz4uhqls5AeifkQnrywnyu
 Awbzyvo0/ChkFQfu2Xw5DLBpE9/1RO+iYFnTxPri9SCiWfijVYliFJrA9fz9qlRjiQzr
 EWurcHkNMwqVv/s9+Qffb0+xInnJS1cDf9kP3Acni21Zohyl4TMAcpQOoHGiKNFT6cYx
 EOnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4QheJkKji3N/wScf1/SIPEVDj6InLTyOyHmTLYm3dZdQUcdHfvQjlpqw/Zgdb18R1W5/nEagPKLwmpb5Mb/89qKwN9q8=
X-Gm-Message-State: AOJu0Yz3Jk7hz20DYmVg6JpgZUdIbPrUv1QlOnFp7a+oUEtx7be+poxA
 IRsYxiAm4AWqI8WC+0dAxC/h7j7KLXPE2FWBhdxhQjFcSMHJFEAVibkv7uaiWxk=
X-Google-Smtp-Source: AGHT+IHFOf4BkD5QZqBH0eaBaj1ZTD0GQ4TOy3kkRiUxIVdcZmhUDYH3qGIjE1BEJQZK4oNn/vewdA==
X-Received: by 2002:a17:902:d2ca:b0:1fb:973f:87f with SMTP id
 d9443c01a7336-1fd745e5427mr55117885ad.45.1721683981773; 
 Mon, 22 Jul 2024 14:33:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f28cf4bsm59679115ad.85.2024.07.22.14.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:33:01 -0700 (PDT)
Message-ID: <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
Date: Tue, 23 Jul 2024 07:32:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721607331.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/22/24 10:16, Michael S. Tsirkin wrote:
> A couple of fixes are outstanding, will merge later.
> 
> 
> The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:
> 
>    Merge tag 'pull-loongarch-20240719' ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:
> 
>    virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: features,fixes
> 
> pci: Initial support for SPDM Responders
> cxl: Add support for scan media, feature commands, device patrol scrub
>      control, DDR5 ECS control, firmware updates
> virtio: in-order support
> virtio-net: support for SR-IOV emulation (note: known issues on s390,
>                                            might get reverted if not fixed)
> smbios: memory device size is now configurable per Machine
> cpu: architecture agnostic code to support vCPU Hotplug
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Fails ubsan testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7397450714

../publish/hw/net/virtio-net.c:3895:18: runtime error: member access within null pointer 
of type 'struct vhost_net'


r~

