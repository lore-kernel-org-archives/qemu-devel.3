Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D805AC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pWf-0005Gc-5T; Tue, 30 Apr 2024 11:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pWb-0005FS-Aa
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:36:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pWY-00069d-ME
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:36:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34d7a32bdd3so583161f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491365; x=1715096165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MVfgG4w0J2VEeYTe+v0ETDoSX+XOiQtFa7QqT+A8Iao=;
 b=VjWba1JspIwzDv1X5Zed/Addmo6eS4aWnCBpzBWgHqRZmJ7fKKVxrGHsliEQuHElx5
 0E46pr96i4CZ8ArjKQ8fBBt3TcY5NnwqlgxQsQtsU0iyOoPGMDSWetLBC5mg5sPu2WLZ
 QZxiSZQocy+QpuUdFxbNEhjT+nMNCkDFU1Dkv5YspjWi8VNz9t4fk+IItOVfpzQdNtAG
 yGWMSoRPnF/GpizvcxLEbazLnM6tBJjXKvqln2+VDq82xqWe/YlFhJxNXb9PT3rYwa9M
 EPHkqodgneyGVnXH3ysXBGE3mU+4AvcbPBZJjztYmr3kLGmvvqXSu6vzjbq4Sylghf/E
 ZP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491365; x=1715096165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MVfgG4w0J2VEeYTe+v0ETDoSX+XOiQtFa7QqT+A8Iao=;
 b=X9NKdo4T0yUQk/buDOiWft+fTju/W4jB/fM7FBZpU9KpTcp4gFS2p9dwWEp6YjJD9K
 3ZvbcE26fx5nfVnFTn5e83Y5SucD66k0nVuajGmEYndlA/key4PSkZSt2wz9i9DqFeRL
 +Mjhe87+EBbUfKgsp5e4GNI5hlFrsAuw49baBfOdGW27xpYIB5MHGaqp/3Gqz4Q40bDy
 a8acDNJ7kT29kEhaQ8MORhiYUM6UczIlmfss0uN6K6m8FXSqG9jwOdg4zPPaLN9qlM/w
 DaVypVwUDXEyzW90YtRLEOJvpkVNAynn2KuSaNPGm7HyRUsxDdmsB7gBqubRaA7efkp6
 Waug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+IM2LFjb2idMM7AjyJmwtgPf57tAE6xWzJcEzGbIwt2hXJsMFvjiyCCA/d5gMRK/pQd6mMAJwePlI0FKhANEiFEUvNa4=
X-Gm-Message-State: AOJu0YxsnfLFx5FIS1ldq46hBcoOtfROvNnJ86AWAw/NzY3yYyU6WvVD
 hwoIXBJ/GxncJFvlONM1ZOLmCu1KEcyOY07zVV4nhoAEDLeEwzTE6vYkdi5pkHk=
X-Google-Smtp-Source: AGHT+IG+BuP1jr5EBu+SSQBgCq+sUntJWIc24kJu62iajVcrM/pDc6IesLIXy3BATzTPyfxmlvX2EQ==
X-Received: by 2002:a5d:570b:0:b0:34a:2852:f119 with SMTP id
 a11-20020a5d570b000000b0034a2852f119mr47873wrv.36.1714491364797; 
 Tue, 30 Apr 2024 08:36:04 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 d4-20020a5d6dc4000000b00341ce80ea66sm32206114wrz.82.2024.04.30.08.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:36:04 -0700 (PDT)
Message-ID: <d7e69e3e-4991-4629-9d76-f7adcc7398ba@linaro.org>
Date: Tue, 30 Apr 2024 17:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/i386: Have x86_bios_rom_init() take
 X86MachineState rather than MachineState
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/4/24 17:06, Bernhard Beschow wrote:
> The function creates and leaks two MemoryRegion objects regarding the BIOS which
> will be moved into X86MachineState in the next steps to avoid the leakage.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h | 2 +-
>   hw/i386/microvm.c     | 2 +-
>   hw/i386/pc_sysfw.c    | 4 ++--
>   hw/i386/x86.c         | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


