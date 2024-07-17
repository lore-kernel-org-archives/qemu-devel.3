Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA2C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1pH-0003NK-8t; Wed, 17 Jul 2024 06:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1pF-0003Ml-Ud
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:23:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1pB-0004tN-V7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:23:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4279ca8af51so42159655e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721211830; x=1721816630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7HHjEkVHf78GxADFwvVfTjWzBvylURMS5/PMTUBjaU=;
 b=v9foCCsErPPWGUY+CXxKnUKPf8AIC7mVQi3VnqEOoWubTVUE3jZN/HpHfU4Pw2n2oH
 L7DpOBPHFP1i3B8ciHE87aGn8QHR/qVhAs9Tyyks24gTegwdpludxmequ/CFG5luqTpT
 9tCjRLPpEx6vRd47cAw3D04ndvvZ+ucyFRHldO3/6e1xE+D4TUNCYw/e8roE80dkWtRh
 NXSDnjxxUw8AVRJy4SUIL60tPF9RxRzklpneLytYOMr0gGs0bEalq55vC9g5xzxuZBIr
 BpTa9ATXIF8Fl59uLKdPDGHQcJsUi1OWfReNIow9Z80ktICB6pkF5YEBfj1/eXW45cyU
 nAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721211830; x=1721816630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7HHjEkVHf78GxADFwvVfTjWzBvylURMS5/PMTUBjaU=;
 b=K9cd02QwW4MDfsNSTCFvbUxMGteeDqNpLOsb3xXuv+4IkgUOlaIlCjsmuKSPNbs6xb
 l/ZylUYJh2HQQtoEOY+guqBIZDmoOUrhEl/kOgD89xJYGTx42R+AB7zu0WvbZZ77BpzR
 y9y+OjAJ3IIT9aamiOSNqguRJpR1rZEtOFKzrL+R6Go3C0m0LdLaYz7QgHWUhkFEaqm5
 +EgfFqoYhESdGaWCKif/BKArvYTYW7LJtKmKgolpKQ3jw1B9TDA+EwM4nCDNTyxRf5JY
 /5yntR9S+gfvfN8ULeGOOdAj/H/M+dA/f5rHFH6LqoNsBPAMYOeNOi0Zo83x2PjcLxjT
 ddOA==
X-Gm-Message-State: AOJu0YwNGeo8j1xUzYBoq+b0JwJ6+HuAGMAXgTyYI0T+AlkGl6FyNPSm
 p0BDHoJxDLWw6ZEdaB0KlSoTmfAjNlCsuWS7KxzUkxL51TDKnkfFylNgAD7l49/bBlVYghrtOxJ
 sj2Zs7Q==
X-Google-Smtp-Source: AGHT+IE5GqUI+KgCe6IDqDBpJ5ueDzrNN9jI6XXnsYecdjjI6+guCkxuojg+o9CkWThuQ/RQcgHXmg==
X-Received: by 2002:a05:600c:1989:b0:427:9dad:17df with SMTP id
 5b1f17b1804b1-427c2cd3772mr9237115e9.12.1721211830266; 
 Wed, 17 Jul 2024 03:23:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb525sm163833955e9.34.2024.07.17.03.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:23:49 -0700 (PDT)
Message-ID: <92c05d82-c49d-4d09-acba-9e570407057f@linaro.org>
Date: Wed, 17 Jul 2024 12:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] system: Enable the device aliases for or1k, too
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240705124528.97471-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240705124528.97471-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


> Philippe Mathieu-Daudé (1):
>    system: Sort QEMU_ARCH_VIRTIO_PCI definition
> 
> Thomas Huth (1):
>    system: Enable the device aliases for or1k, too

Thanks, series queued.


