Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB25FC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWX8w-0007Uw-Lr; Wed, 24 Jul 2024 04:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWX8v-0007US-5l
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:14:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWX8t-00084b-F7
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:14:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso6118925ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721808873; x=1722413673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UsTpXPpgIKdJCnV8lo8PICPbiG2sKOIMBFXMHRk+4QA=;
 b=Kbup6+8l2C5c9L91Y3ENDDchSzGnQCjNIU25MfSAP7SN2DAgGj7eLaMMPcsRjynA1n
 K7jy2vHOWTdh0Sh0ROTbp4C3BecrKEpxiP22hEfltYmI0GgJjghXbMLNuHPh9RmzH1TI
 N+6uq8J9xIvVvXlmWYGm+6EcugdjR2b2dWhtJJUaM0xM9P6iZbijU4c3ssupjvVKjRuD
 KAiH0GtKKKqTkDKQ7kL/Oe6t/gxdDs0oGrp2qtYuuXcDZ9b+qup9QUCDxJOQ/7gHSr5g
 4B8eZzPLdItC6RSFbA26YlUDrMzuY5L1j8tga67yXSV++r39Fnnua/O0wUAGkQP/G8RB
 /2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721808873; x=1722413673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UsTpXPpgIKdJCnV8lo8PICPbiG2sKOIMBFXMHRk+4QA=;
 b=uLK0Bp8kiSuguyz7G5aVQuNMeugnjLBLhLcw+1oz69/5A0shdkPfpMPJk3KdW8LSX2
 DI5BvotrvBP1GVBKOiJmdWgVKyzpqR7OmpyMy6o5p4zZJya4VQgaYANfrvtHM831yVVC
 +/DZRUUThfxSjH+b1rCScr+Oy1xzpNNiwqZuZPc26Y6P9/fOpVKc9FyaZwx7lIZnw3Ww
 noSoQW5Wcw67m+ftp6k9d6xEfZ6lc2edLphcxlA5snIHD9eMxf7HvkjKXY6wPCzqTYNh
 Es7a3MmRZf7IS2HBswHbLwW12BQocSoP5AEy2835SXvbF+v33SLA1A0fyWYfmhI9c7gC
 sV5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEXE+dKiY5g8hvV5XrxVpnBlCyAGG6TUidMP3t4OQDVUPVWpmzICHp0B1/Bjub68mx+T2463Y8y5wPly6rrqB1NXjPwh8=
X-Gm-Message-State: AOJu0Yy+E/wDKT3o3x8f0DSt4IfqwiHuqf+XHV+JBeYUFbrUTKB7+It4
 Z/rY4g0E/7cZ8Lh2pOHsfgaaDrt0X0xtnplv39PeIvtayrxhmRjon8Zwstjl/9c=
X-Google-Smtp-Source: AGHT+IGVWdwRZ+cfovZbBM7iBtjaMrZAkC4X1Vrd70DAPDI431cDvJYllgsz2iwrNGFKEAR+UBVMOg==
X-Received: by 2002:a17:902:f543:b0:1fd:9cb1:5dc6 with SMTP id
 d9443c01a7336-1fd9cb16a2emr71099215ad.57.1721808873190; 
 Wed, 24 Jul 2024 01:14:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ab34dsm88152695ad.110.2024.07.24.01.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 01:14:32 -0700 (PDT)
Message-ID: <1c1bf7b7-9a9c-4aa8-8f94-59d47eab0f03@linaro.org>
Date: Wed, 24 Jul 2024 18:14:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Misc HW+ patches for 2024-07-23
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240723203855.65033-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/24/24 06:38, Philippe Mathieu-Daudé wrote:
> The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:
> 
>    Merge tag 'ui-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240723
> 
> for you to fetch changes up to e4a44f94db11fcf873399c60ebb1d93a9ad1cd6e:
> 
>    MAINTAINERS: Add myself as a reviewer of machine core (2024-07-23 22:34:54 +0200)
> 
> Ignored unrelated error:
> 
>      TEST    signals on ppc64
>    signals:allocatestack.c:223: allocate_stack: Assertion `powerof2 (pagesize_m1 + 1)' failed.
>    qemu: uncaught target signal 6 (Aborted) - core dumped
>    timeout: the monitored command dumped core
>    Aborted
>    make[1]: *** [Makefile:175: run-signals] Error 134
>    make: *** [/builds/philmd/qemu/tests/Makefile.include:56: run-tcg-tests-ppc64-linux-user] Error 2
> 
> ----------------------------------------------------------------
> Misc HW patch queue
> 
> - Restrict probe_access*() functions to TCG (Phil)
> - Extract do_invalidate_device_tlb from vtd_process_device_iotlb_desc (Clément)
> - Fixes in Loongson IPI model (Bibo & Phil)
> - Make docs/interop/firmware.json compatible with qapi-gen.py script (Thomas)
> - Correct MPC I2C MMIO region size (Zoltan)
> - Remove useless cast in Loongson3 Virt machine (Yao)
> - Various uses of range overlap API (Yao)
> - Use ERRP_GUARD macro in nubus_virtio_mmio_realize (Zhao)
> - Use DMA memory API in Goldfish UART model (Phil)
> - Expose fifo8_pop_buf and introduce fifo8_drop (Phil)
> - MAINTAINERS updates (Zhao, Phil)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

