Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6CBC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reezc-0001zR-4I; Mon, 26 Feb 2024 12:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeza-0001yn-VA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:42:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reezZ-0007pF-Bt
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:42:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso2266018f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969336; x=1709574136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0WK2cCajFLKqbMpU+k9GqCxnnD9zyxre3Frgtp8fEP0=;
 b=O8h1iBwgJvPtRm7K+CAqSl14G0X28Wl/3zHSLkjHYH11wMc+bFjkE2RjaCOlWgc5BP
 uRjPG59X0aOBuUoTfP1saq9uqYarKgf+SoVjJGbYWnaEreV0UswMQlFL60YMy7Y4m2nK
 O1ieF/qyc3dVwFaTYcmeZupkDcwZTRww6ctrFO8BjSVHy1JQUjQVHz5YeYCwtMkHnU58
 L5xikRP9p4NXKIt5yna2gFfeWaXq/kH7wo0Kd2YX9BY0/uPIwP1uEU062Lcli68/bfQj
 HchzUsMKyzvGSCIz9e973xzlzh31oJzRadfHD5hfPVvAYYSvkBSVfO4FV7jky7106DOl
 WLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969336; x=1709574136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0WK2cCajFLKqbMpU+k9GqCxnnD9zyxre3Frgtp8fEP0=;
 b=QQe3GQ3hZJV8fzjnPjcdDxqT2jb8vYIhtgjhHQ4DwdF8HnVsx8ipXPkXevgJQ8FPGp
 x5TF0n0JHWCMR55TMpsUOHHhrFSWTwsYIKzRxQ/pgimSTOb4sehyc9Ogowh1QXnbSWxX
 ApumigAD4ZSNbD0m9q3GVEtZf7QNu6jmVyve0rd55rWYTlDVNzo5z8P5KJP1vQ6euA2o
 8cOyCDyXI23DBNj3QQoSIsais+QB8m3q0uQfIKdmZbsHHZvY9i541UNI/pHz8ugsy4RJ
 RZ8K/0Q+3cWK05i2MoYqJ0bK/gx3zAdP5OFAKM+OfzT6BBYww7dhfDUCgkAoW4/9qYNO
 rTkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKY8+wRXATJXn6RnKQXzV6qrrRsP7RWHEYBpvhwy2b0drqA+jo/FuvfWDrTQDXP/N23l4vGh8Lf0BuGZyx2dIWoo4mJEA=
X-Gm-Message-State: AOJu0YyjRv8HtKbHEC/rjE2WueVWG3VYWMvvGmGrjjelAmbMvBaAU4xK
 QYw7Tjh05U4dndWJEzc77jO9O12LmYxoEdCtMpgJNKN1SMu3Ru26hGMQtQh2a68=
X-Google-Smtp-Source: AGHT+IHR8FE1rNhoq35pkyEFEYsoiY8vlDcQf3YrpS264xmLoIBxxTdve+Laj8Vc8S+4K/FwkTsApg==
X-Received: by 2002:a5d:58f3:0:b0:33d:f30:5689 with SMTP id
 f19-20020a5d58f3000000b0033d0f305689mr5586920wrd.30.1708969335864; 
 Mon, 26 Feb 2024 09:42:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a5d5702000000b0033ce5b3390esm8868723wrv.38.2024.02.26.09.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 09:42:15 -0800 (PST)
Message-ID: <36ecdc4a-b96a-4b63-b212-e1a9287aa73b@linaro.org>
Date: Mon, 26 Feb 2024 18:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Simplify initialization of PC machines
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
> The series aims to simplify the initialization process of all PC-based machines
> by streamlining redundant code.

> Bernhard Beschow (6):
>    hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>    hw/i386/pc: Rename "bus" attribute to "pcibus"
>    hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables
>    hw/i386/pc: Remove unneeded class attribute "kvmclock_enabled"
>    hw/i386/pc: Populate RTC attribute directly

Patches 1-5 queued, thanks!

