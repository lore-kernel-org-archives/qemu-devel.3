Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B228C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 16:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHQm-0001wg-EY; Sun, 25 Feb 2024 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHQh-0001w2-UG
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:32:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHQa-0001zG-Lw
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:32:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33dcad9e3a2so208928f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708878754; x=1709483554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/GNyCnLz3fyBBwt0ByN+hEzkJQVnK647j3aEW72zZ0=;
 b=w2cm1yp7pD1ImjIWPHlQZrThj9tNl6PmEHgem3WADCDOqGyuUswz6ToGO9fccC22gF
 rD/FaxNWIOl8artIW6KDFAOngHVr/ZPwDN9Ukfp9JIaDD/fzr1yezVAAYn7LRCWRKQfh
 QM4K3ngcEbjn/pXaF4UBvsHsKFYIEunLZ7K7stT4mz5FTVyoe/8HyK95cM5H3Wpxy1mG
 2ADTQpCNvvy2JlW4EryoUvN7zI3KhLYwrOEl72H05GGpmEAVAgWKnGuUAhIL/DO+DdH9
 B2CuXpvwkeoV+xRMfOSRJTs7Z+Vz+41Jw7EIJhtxfu2SoFoa+RQNsibjzsK9lUwD0uUS
 tLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708878754; x=1709483554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/GNyCnLz3fyBBwt0ByN+hEzkJQVnK647j3aEW72zZ0=;
 b=P4MnYt+3PbZpTTnhlbEu8JVrvKyoMofW2YL8Fj3FQlP8OeV3DyYS035sgmF9+i45Iw
 6bO2/nkXRGBQ1JnWh1FqsgFrIE0tOzK5tFbCP25GBMO/r06U4K87xXPI9GnuuTR+RSHZ
 82TKxEJ6DF+wHmE5I/jluZQyVYsj3zAZprG5MlnHaA5sbGPvfJzBOvju9wpAmMtUX4pt
 msMplKzeJ1tjl7j++TBjXaEYlPIQNjMQKVICefqmmTTM/NVMSJZTkBOQ9IsxxAeFWO/i
 GZAgx5iZ67nHsdjlgAAryPR15h/QwFis6kP8DK31sct97f4r6MhnSuF6NXgzOujDQPyd
 t/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsT3x4p7hErIJPLA8u8/cyxWAOt53BacZQamGjevxJtnvWzpsjNuU+wbJcVdmigbXHheYZOXdJYoGqIiiQrtfYDLSBgHk=
X-Gm-Message-State: AOJu0YxNQ3A5DEUKtlVn5dXMLSy+Npr87lWQgnh+P2jmnasp53+zc31e
 Q1b4Lh8IwUQN8wTpW6Gp5gAuKBInaBU5EoHwiqQ713Jp6FpNRHd1foBvRy2eSrM=
X-Google-Smtp-Source: AGHT+IE0bQkNKHXWgH31pVKuWDoVOjS4d6pgrEDjWeiJvH6NYZ66v2YIOoQnXg5qMWIq/o83PEiShA==
X-Received: by 2002:adf:e34d:0:b0:33d:a943:48f3 with SMTP id
 n13-20020adfe34d000000b0033da94348f3mr780353wrj.66.1708878754512; 
 Sun, 25 Feb 2024 08:32:34 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 cl7-20020a5d5f07000000b0033dc931eb06sm2615117wrb.0.2024.02.25.08.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 08:32:33 -0800 (PST)
Message-ID: <31d9a060-dcaf-46b1-b3b3-ba12d21a09ab@linaro.org>
Date: Sun, 25 Feb 2024 17:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/i386/pc: Remove unneeded class attribute
 "kvmclock_enabled"
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224135851.100361-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> PCMachineClass introduces the attribute into the class hierarchy and sets it to
> true. There is no sub class overriding the attribute. Commit 30d2a17b46e9
> "hw/i386: Remove the deprecated machines 0.12 up to 0.15" removed the last
> overrides of this attribute. The attribute is now unneeded and can be removed.
> 
> Fixes: 30d2a17b46e9 "hw/i386: Remove the deprecated machines 0.12 up to 0.15"
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h | 1 -
>   hw/i386/pc.c         | 1 -
>   hw/i386/pc_piix.c    | 2 +-
>   3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


