Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWLB-0000cY-Sj; Mon, 26 Feb 2024 03:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWL8-0000cH-KD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:27:58 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWL5-0005Id-99
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:27:57 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so366320466b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708936072; x=1709540872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gY3lYluzmcA5xUSxPcjpl2vOkCBVubDX7gjDodBpd0M=;
 b=ZenYH9LdewQfmsHYcv7kL3tuJf9z42ykKmqNLhk6qzj41V6HzRDjqXfWeMG+TWcsdg
 GW+zZ1m+AfEVDqAauSPT2QuYdy2Po9pRdweXZ1OIaYPbtgS83/B1dA4+RIkXx5lD2ib7
 yo4K0gK32rkx0iEK5IJkcZNRYIJyaV6x5FT9O3GgFWi79w5ojIXdo81x/FgdMjBcgQKC
 ECuXeEoVEk7Mi6JaeijpGbRyLe8Wvxyu42yse/Oc0vgKOgE458KWkCHpE5qx5Q55TtL6
 cgwFkyjaDrMbI2BCBgsXJFLh65CF/pxn6p25CfDbb+RVXYIVl7WaEHmUauroVmOvqLI9
 0hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936072; x=1709540872;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gY3lYluzmcA5xUSxPcjpl2vOkCBVubDX7gjDodBpd0M=;
 b=LNZIoSLZP8J8soHt1DKTkH0Fi4tQbCfCAz2odE/smoTvLNDXnzKPI3SNN0Mna7g5oK
 QTzKfrk7aa5P8MhaD7hSPwLlyCduUwsnakg1Jqe5VDYhbPZd0z9OMLJvNDFwog/0yI5z
 KS49f08bAhlhY//ZTgdBwcK3nomfSViMZfx/12h2nV7IJwv3TVceb7ClvvXoLR5+cBom
 DdElK+nVqOMFB5XLRvb+OA8gc3397KZSA2S4r+V0jXFXEGQ+RYTAatXWt8WBokSprtLp
 Zfc6RXX+pA4KVx75sl+wTtAVEYSxjCNiILFG/c01yEjcTlOAk3eJBp3YKTGy3qlZzLa8
 A0VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR3lIkWa9U8qBP/+lHEa9xAKxkYRbxSzT36pQJMhOWtjruIqSobEbGKUKW4A4rdehj9iTBiKNU2dTr7rz+SHGPpn3K3Zg=
X-Gm-Message-State: AOJu0YwIy5DR3Ci8s1Wswvm/wCD0TgRBr4X+uh3vCfWo0SZ7Rf8Di58d
 QlkbsjgV+wLexEcEWzwFV1bWjaQpsGJVRtpbWRY43fjf38Dcvl3ZBdJISEmbHeX7ovL5DNUl77K
 a
X-Google-Smtp-Source: AGHT+IE9B7MlMSDnrHyCUAphnVS5+YBJDsop8L49TeByBy5WM4uNptChzQ3kX4w0h/22K+gN5r94NA==
X-Received: by 2002:a17:906:5955:b0:a43:734e:db47 with SMTP id
 g21-20020a170906595500b00a43734edb47mr434195ejr.20.1708936072728; 
 Mon, 26 Feb 2024 00:27:52 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a1709062bd900b00a3f63b267b0sm2184935ejg.101.2024.02.26.00.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:27:52 -0800 (PST)
Message-ID: <0d68ba0a-2549-4a22-bff1-cbdb12bfd0cf@linaro.org>
Date: Mon, 26 Feb 2024 09:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/i386/x86: Let ioapic_init_gsi() take parent as
 pointer
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224135851.100361-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/2/24 14:58, Bernhard Beschow wrote:
> Rather than taking a QOM name which has to be resolved, let's pass the parent
> directly as pointer. This simplifies the code.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/hw/i386/x86.h | 2 +-
>   hw/i386/microvm.c     | 2 +-
>   hw/i386/pc_piix.c     | 7 +++----
>   hw/i386/pc_q35.c      | 2 +-
>   hw/i386/x86.c         | 7 +++----
>   5 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


