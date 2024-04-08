Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DBC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsAC-0000gm-Ab; Mon, 08 Apr 2024 12:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsAA-0000gS-21
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:48:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsA0-0002RQ-Fq
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:48:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso11651595ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594874; x=1713199674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kpCM6sYvz4ysQDK0svStEG+x0X9mfvrFn/2CwHvalag=;
 b=O0Vi/FpUE2EkH5u5g+562e5pQvVjGUZOu0u68XnzXzDv6Lvo6T6br3DU/17/Em2swJ
 B6wBwxgpB6mCAg3sXwMqp9aIpBty+9jJyHD9HTzeQA79wT/rbfYAlCMTEHYXr1ff/9Gh
 /kkUW9pBDrpvCqC4BcfJsNCpR7DxHg926TqGyiC9TPCcfwRu6UggydPTwvjiqEvtvLM8
 MldIQXOP63Y6CNUPWhBeCsI8L4Wm+Vb79FoBg6c9FtTcaXBWTuSQoffxQ7m1aPHOtkC1
 AwM4XlzEhA+JZ1+1FmBf0q5KnWnOaDaxdImq1YUOg/RWXAcInRg0uvaU3h4u5VNUB9wT
 jlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594874; x=1713199674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpCM6sYvz4ysQDK0svStEG+x0X9mfvrFn/2CwHvalag=;
 b=HIan622XTPiOX6a9xPyFtGj5BVvZufW3C651fLvAgFS2ymxjcfYThfy8t/w9zZP+h5
 pLbbUi5vRGN/48diS8mXMD0ltF6G7179XSpyR/tCYkSeF+tZeW72l+UrZUb+nA/YXnEr
 VFhtQ8kL0ns8mpAbwtBfH0vAm9HYPExUjWMTwRyfZ1D3e+gMF8m8KEgvNLocGqhYN2KZ
 xWZuY/ngZ4gammyMP0ZuJuZAk0w+eDm7PSbIq5ciwmMOrEdCescbqhu7eAotZfE4dbr7
 e8xZ9VdQZk6WhkrHkn0ikM3FZlM8B/kZoJheczCSrvf1/hZX/1dGQaEKox060rBw0ocC
 78zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/WJs6+G6dERCvJPCUgYbq61pZiMoYfoYM0hrD+4liygGG84dQ85Wg166b0KCiEZa0s2ocUSQMO/muvVMW4Kc4+KHZMhw=
X-Gm-Message-State: AOJu0YyJOa2aVkZcSV4fL/dm9PnvYFem6cwzbx2mSBwYxXxGDqbkSDvb
 FQYgtaFBGryW8CZv6638ulBsG4pCrh+iuSyhI4VEJIy4LTtUyKNg4Y/eAw+vgpk=
X-Google-Smtp-Source: AGHT+IEjoRwBNTayQAzfauReBysDQB6OqwMWV4IvbmtDSp7XitJnstVAtgKgsR4MoFO+GakWDi9S4A==
X-Received: by 2002:a17:903:3004:b0:1e0:e85b:b9ca with SMTP id
 o4-20020a170903300400b001e0e85bb9camr5954884pla.21.1712594873962; 
 Mon, 08 Apr 2024 09:47:53 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902a38500b001e3c93ae560sm6658928pla.220.2024.04.08.09.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:47:53 -0700 (PDT)
Message-ID: <9a73ddd5-f94e-4ed0-98f3-a7bc4df48fb1@linaro.org>
Date: Mon, 8 Apr 2024 06:47:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] hw/virtio: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Since the virtio memory device stubs are needed exactly when the
> Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
> conditionalized on CONFIG_VIRTIO_MD.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c | 0
>   hw/virtio/meson.build                                | 3 ++-
>   stubs/meson.build                                    | 1 -
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

