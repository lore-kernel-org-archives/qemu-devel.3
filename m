Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C33D38FE6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3fi-00083j-JL; Wed, 14 Jan 2026 11:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3fg-0007zA-PY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:24:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3ff-0004oD-6b
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:24:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so64885e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768407873; x=1769012673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xj2EZV7b7Vjm1TY4eOPLGc8OJSYr+bA/U9nRD8P/2jI=;
 b=ofSkaLNJv6ILRiWMqWvSKsa2MICm6jmmRMnzrH0u5/RiqwY5N0zPP9670rvuoZ1Zeu
 l3F0JGX6o291kmd6bIU63q0+M+50tDHmFDzDJJz4Rd9CywLqaPkmokYMatRZWIuF13bq
 YAexgcPe/STUfgzCMxEzumczFqK30XPNfOMFs+181LtzrcSipoS6wMz9aw0boEvLKKxS
 KXLtwx8x0SEq1erRs9B/lPLGkhU0do292+GDj93LxXhbKka5h1eLygyEmodIXrNMLaoF
 te1VoPV5hTpNVUea3/3oaSR7MXcWThkQG311Fs9V1Cb0cMIh6WIDQQ993EsQc2+2SEL7
 xdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768407873; x=1769012673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xj2EZV7b7Vjm1TY4eOPLGc8OJSYr+bA/U9nRD8P/2jI=;
 b=VxshHdd2GCv0vwLUcve/zwnau0MIkx41Y9dm3MOZb/8QtgE2qnO30RTH9vhcaTnfzq
 k4Tito+GhWJuz3i1EYbViT0vmoDZ+32yfJwJfYj2dxgRfFVSuuozSGpyhlLasEr6oUdA
 ou4KMDYXr2xQfhArInHHLp+1qAbRAvWBzPsFfnRgLyIkXvN0kSrv+XUxFdmKxsPFMKwJ
 ROGfTUdMspzAz0tnBn6MN2hnKeg1OFvqyibxnsS5QfWniZoqrJIEWZbNws9hx+JqZwXg
 IvUXoyeMtgRkhKXH2I2RxwzO2hS0sk9qassKIvn0rDCAkiUcZDaFXXPiPEt5sPfrF7ID
 CNyg==
X-Gm-Message-State: AOJu0YyMjdTfFEbUwEtELXpo47t9YaYjwveCh7d+smcNDiS+ESPWhkR9
 CeVX58EENUOGY/emJHdFQmFPTNmLfGH2joRo4RD1EXFuW3J+BpyjIJ2bOBbgk8GBtzA=
X-Gm-Gg: AY/fxX5MK7nbisqyxR63YlQwlZ8pqWZMing6cH0D2GS/71D3lT16uJbJxj25zNIaTX0
 iHAkUG8DmmetPEuCHXfY2MgAhY1KcNw4t7Il0+VEmqHkXRMdFHUnoeJgqkijXIIk865sYaOUcmE
 iJO0usRULNMpf4PGuoJpm9eNDE3y/FhPPeAbRhO4jYfqHw6Y64Fs1qTArs/R2+HvPLK97P9qUEW
 08DVY1+H0I7Ca6H7L1VfnvGc7Z83fye/yHUdtBWHBUL3DltcuoqrM8Sx/bsvsVyT97zgP1F7D4u
 rwnhvzAT8lo5IlqszM2Et66UInyBm1Mnu2h5g27hOW6qblrGAmvZaodgJ7GH1KrmFUZpMoTLMmJ
 8hHGHqv4xvvyiqn32CEbGgj2cnoE4cwjZ8n9lELfpmaz17QgtSj/PhuAhfbESMMytBcixo269TP
 r5m/6DuR7b6tbHS519fLCwOhhANbJ1ZL1BZ6ixVh0k0OAW8RysTZfPH/y7V8u3fGo7
X-Received: by 2002:a05:600c:4fd6:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47ee33970f5mr41612265e9.24.1768407873450; 
 Wed, 14 Jan 2026 08:24:33 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6e1b7bsm137074f8f.34.2026.01.14.08.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 08:24:32 -0800 (PST)
Message-ID: <bf015934-2fc7-45dc-bf84-b0d013e45066@linaro.org>
Date: Wed, 14 Jan 2026 17:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251124114754.79831-1-philmd@linaro.org>
 <3d5a30fd-fb49-42a1-ba1e-e2c4bfc58f83@linaro.org>
 <20251223165236-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251223165236-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/12/25 22:52, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 02:52:20PM +0100, Philippe Mathieu-Daudé wrote:
>> ping?
> 
> 
> picked it up.

Thank you :)

> 
>> On 24/11/25 12:47, Philippe Mathieu-Daudé wrote:
>>> Before commit 3716d5902d7 ("pci: introduce a bus master container")
>>> device view of the bus address space was correctly sized to the
>>> bus aperture, but then it always used a 64-bit aperture. Restore
>>> the previous behavior, so devices on 32-bit PCI only see 32-bit
>>> address space.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/pci/pci.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)


