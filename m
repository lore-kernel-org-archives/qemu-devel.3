Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DCC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 22:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZe7q-0002Up-QB; Thu, 01 Aug 2024 18:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZe7o-0002UJ-Vq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 18:18:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZe7m-0003t7-EZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 18:18:20 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso5768433a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722550696; x=1723155496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YYHyrXWepqo8U6UmJuQoFjxTQY2pPVkiK+pQavR3nNY=;
 b=e0qQIuLkklru+D45EQ4DT5430ov3jVjOVKR0efGwuTwkbWetdPIIVWLts3sNX02+Kt
 7thnASamWauf1RY8Jjk1xYCKz4XkS6ASQvd6pUAEOTd8YPiXRSFRS6+24QbeRq+2O4KC
 3ClNC3rqwvMkFgH73nYpjc0GkEwuSgaDLHnFoLKap1k1AIlRnr22LIEI+yK/R6HSqAYf
 5RmwF5gnvDG3rX+pY1hpuOhNX+FeaDGGWuJXhcewEvJUCtxqh0MDK96L3yNdAndXJQOw
 vtdvzVRgpOyiTuwgj8AtCUhFc7d4L4wZPZwo49gTP8gXvTCoSMX0w1Z5Ybu4mlMTpJyP
 DlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722550696; x=1723155496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYHyrXWepqo8U6UmJuQoFjxTQY2pPVkiK+pQavR3nNY=;
 b=Qt/qa/JzirAMzvLxKRXupPWmIFRz27hzmpC++xtZ/rq9/VpA6v1cUE+tpbGcNNR7kf
 1t2z0S/0AZIbP+QEfffIYwYcIvr1gg+A0O+nbT37NSDgK6iJo4y1n/0k6AVCPY8v4EGb
 e1zOvLq8Kr1OKMVtuL2WsGcexedUG7NcS+tplgqcH4ZXHShaRXU8Lb1jQ62MbmQegSQY
 4A+DsMSHfNl/NpDu6/5ZCltitTRLBrikAKjkFpfoKm+7LhPBOpxZxMuylipywB9JbdIQ
 6y71KPaJftnxyzCbOPeHDDUYvA/QNhrBn4LQwccf+iDNg+IfpF4fHStiySi1T8h2UL/Q
 L39w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWku+cUdKV4jcekWxPcVvdgqRO5FRl2QkXH7fodkjhMVokGp6CeQVi95mnU/jFx/KiRqADxT6FfR6YgHfkJ/i3ZOX67nP8=
X-Gm-Message-State: AOJu0YzgkUHVPdSNp0okd6VkQnCZqOQ8gYrHg7dQKojipLhbQHo/RyEa
 41N6JZHoVoJPGWSEvw0n7jNJCtuan4LPFHrcNXD4LdckN9V/PAAO4AKAofuO5Go=
X-Google-Smtp-Source: AGHT+IFJdH8r9rPLWwe6/J9g3YUYPd3Zl64oYZakoHggi/W6OdgBHsRmKTETotB6PkhHrTGvnOrY7Q==
X-Received: by 2002:a17:90b:4b92:b0:2c9:9a8b:8d6a with SMTP id
 98e67ed59e1d1-2cff9582988mr1897411a91.41.1722550696234; 
 Thu, 01 Aug 2024 15:18:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc406481sm3944462a91.2.2024.08.01.15.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 15:18:14 -0700 (PDT)
Message-ID: <8c4dc915-af9d-4cfa-ac26-9853a7785f0d@linaro.org>
Date: Fri, 2 Aug 2024 08:18:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] virtio,pci,pc: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1722508478.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 8/1/24 20:35, Michael S. Tsirkin wrote:
> The following changes since commit e9d2db818ff934afb366aea566d0b33acf7bced1:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2024-08-01 07:31:49 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 515457757ff8540c524ff39ea1d9564b251c6532:
> 
>    intel_iommu: Fix for IQA reg read dropped DW field (2024-08-01 04:32:00 -0400)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: fixes
> 
> revert virtio pci/SR-IOV emulation at author's request
> a couple of fixes in virtio,vtd
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

