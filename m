Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FC7C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAra-0006pv-Ib; Mon, 01 Jul 2024 02:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sOArW-0006pI-Ia
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:50:09 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sOArG-0000Km-FX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:50:05 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a72459d8d6aso243645666b.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719816588; x=1720421388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aLFY5bTO8hv207XcrxqvpaVU3KIVeCAECo1Unqifq+s=;
 b=M5h528g9k0dV0aoW2r3907h05b1iEF73QzzTnm4R9zZIyeGJTZW6PnKLZ9nI2M4/fQ
 krAMypE9PzYFCEP2JGJ2a37n/iXelQ5b6vBdGWUeeppKdgXi2HE1i/8EFe+UY+6PX65X
 0n3CaQScTl8ZWK5layMlRXTBILpRGynkEJPoCTVw/1myOErLwYvklmlDV7yev72Bg0K8
 VbdV3c+otvOO217CIats9cXfuMraHTeYgSJfSS8zvqO76J203KZoO0SBSoso4ytQc/f+
 +eQV0lL/PVNolh0werBKnybTDPpe30XVix4ZuN4nyLHxdXwGAVWi4OgFzJLcqTtFPwRV
 D+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719816588; x=1720421388;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLFY5bTO8hv207XcrxqvpaVU3KIVeCAECo1Unqifq+s=;
 b=om6mFKhsrRqItAC2nPHrnkL0DYC1zpsnD8NxZmc0e1a0Q02CSBeNGJT9uaVcjuRF0i
 08klYBd4P6CfHk6al+gixMcGBzHo/t43q2Ns1BDY0Yjx4Q9TFUEhn27L5UW9dG4soGjb
 8d/BUXbe+y2xNOuQUMG4WL2UJNmfGQWy6XnkNSkcGJXhUvk7AM9vkyW7S+GwQPZDMPAp
 UMAAYd21nNXdNpmVg0ihu1DdPAr3B63k13p0Vsy36AYqGxjwCvhSbipwKJrOKBTK+Vv4
 3nnLDPA3l72yme6wcqL9LwNOwcOr00KMg/oHEBlamPLA967X4ulcR6R9jTiaxkPfRJeZ
 9PfA==
X-Gm-Message-State: AOJu0YxS5U34dpdrEYbqrgj98Dz7UNdtxdKRIBnInbG9fCmCQ1WHNzMN
 ePcVqZSSGP6csnLJeadtT/Dzgi2ZNtZ05y8XUP921AXw4I8v4qyJUpdWc9HhhA4=
X-Google-Smtp-Source: AGHT+IFhhPMaV5vdiDzICpOE9oOD7878IZ7dpyu29bSzUax/VjmdRl7UuNJmlT5w0dsAudm4iWM4VQ==
X-Received: by 2002:a17:906:db0b:b0:a6f:e819:da9c with SMTP id
 a640c23a62f3a-a751444dab8mr380195766b.43.1719816587964; 
 Sun, 30 Jun 2024 23:49:47 -0700 (PDT)
Received: from [192.168.200.106] (83.8.74.165.ipv4.supernova.orange.pl.
 [83.8.74.165]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb3c2esm304873366b.91.2024.06.30.23.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 23:49:47 -0700 (PDT)
Message-ID: <ca463afe-486f-4590-acb5-a61265cbbd37@linaro.org>
Date: Mon, 1 Jul 2024 08:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/avocado: update firmware for sbsa-ref
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ard Biesheuvel <ardb+tianocore@kernel.org>,
 Rebecca Cran <rebecca@bsdio.com>
References: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
 <20240620-b4-new-firmware-v3-1-29a3a2f1be1e@linaro.org>
 <CAMj1kXGb9xVQ5E3oK_QX+3hKkMfCoA9jF5jkEeG6Eq9+zbHPHA@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAMj1kXGb9xVQ5E3oK_QX+3hKkMfCoA9jF5jkEeG6Eq9+zbHPHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

W dniu 30.06.2024 o 16:37, Ard Biesheuvel pisze:
> On Thu, 20 Jun 2024 at 12:20, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> Update firmware to have graphics card memory fix from EDK2 commit
>> c1d1910be6e04a8b1a73090cf2881fb698947a6e:
>>
>>      OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C
>>
>>      Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
>>      tolerate misaligned accesses to normal memory, and raise alignment
>>      faults on such accesses to device memory, which is the default for PCIe
>>      MMIO BARs.
>>
>>      When emulating a PCIe graphics controller, the framebuffer is typically
>>      exposed via a MMIO BAR, while the disposition of the region is closer to
>>      memory (no side effects on reads or writes, except for the changing
>>      picture on the screen; direct random access to any pixel in the image).
>>
>>      In order to permit the use of such controllers on platforms that only
>>      tolerate these types of accesses for normal memory, it is necessary to
>>      remap the memory. Use the DXE services to set the desired capabilities
>>      and attributes.
>>
>>      Hide this behavior under a feature PCD so only platforms that really
>>      need it can enable it. (OVMF on x86 has no need for this)
>>
>> With this fix enabled we can boot sbsa-ref with more than one cpu core.
>>
> 
> This requires an explanation: what does the number of CPU cores have
> to do with the memory attributes used for the framebuffer?

I have no idea. Older firmware was hanging on several systems but was 
passing in QEMU tests. After closer looking I noticed that Avocado tests 
run with "-smp 1" and pass.

Checked failing system with "-smp 1" and it worked. In meantime you have 
fixed problem in EDK2.

So yes, updating firmware may look like hiding a bug. Which I do not 
know how to track (I can build and test QEMU, but going into its 
internals is something I never done).


