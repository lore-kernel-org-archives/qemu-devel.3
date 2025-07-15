Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB82C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublg3-00067F-TR; Tue, 15 Jul 2025 15:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublJF-0007mf-DW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:27:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublJD-0007Vu-Jr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:27:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so20512055e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607641; x=1753212441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWyg+Ehk1e5V5aTN2Vl3fSDH4/If/KaffC0DMsVW1cs=;
 b=ZKg274sBeEr7AMjqEvLhs7P7VEsGQ3kH2uBmat7sJjyPts5eyHTdDjpgDMcW+h0gWb
 6afs23mm6unipwWiZtUcnbGNkQJkIRb09C2CZIVccro6E1R8Mh90lIBYVSI6Yli7qp0c
 g5sPcNXwS0UzZ/emvLqnpZoYo7CPtM9289hznZ8XilFzi7Hk7iZnqNGBHDpWJTqIUB5I
 Vz/xkPYLxQvFzVh98nFKgBqozjy9w7HMJZ3gPEPbGYnPbkR4z0rkLRFCxPq/qCF+yrW4
 4sKQn9n+3xwPAhL6BGIMjp54c7pYtSsY0xtu67UhUlNQAfApLQs5Yrz4gJUs1/v6nYkY
 R84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607641; x=1753212441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWyg+Ehk1e5V5aTN2Vl3fSDH4/If/KaffC0DMsVW1cs=;
 b=HjfBjKKlvFIEe6c7M812XzSC9sLKamcGm2DoXZU85ZuG+juBikTtGD2CVVw4eUYe7H
 ApqZXO9OQAKK/0kH6/TqlF8ZtOt0Y51Hp8CBndGt2fPsrUHPy/WSTeeJ3p+w+PQ/y47w
 FPbBjWpkTKgXZiwJ232p+LGCRsPVxNImTCar6azYvmHwEN7N5FAcyl1oQ4EipHUZSBNs
 h/UnxM905iC44BrjkGucQ7xbqQReKuFP0MuteKoMBG0JkDD69/PbFcybXFgNuW7CKfgx
 fv7Lrkgknlgp2uR8a6UZ2GTcAv4f5lzU5PRkFX4SeMzh7CoJe4pXPD8uRBslfXyVmD9C
 DUew==
X-Gm-Message-State: AOJu0YwZog6QfFHZa+sg1CZDYGmETFlJdcmiMKc55WYe7ZDIK7pqAEZi
 uCYK7pWq6sldWzUXF4mzAN8u8qN+a42CFaINof7Lu27PguwaztE1jZZrWKRaEa5yrUBIM0S0+hT
 VMhRR
X-Gm-Gg: ASbGncswxdY1t4AlX8O5b5QWT1gf+7wS9dKgKyn9LVwgFj4cd6/sNdqZvQaPYB2HHXN
 mlgkBKos/7EGphLvmdHtES0tkvnYgKDMK035m/9TKm48vImvqtI5GdrXmx9dW8tsClR48dHEcZM
 srBXk4MdiJwKYJ3FsjKRYPB5P2yLu97Rcw2gdS6n3bI89rO0XcrUiEwAPIri9GuepJCtglDosOy
 dAo3VghGipnJ8vz6vLjr73oq+XStdsh5pSCXx9kajNPrBPAveakMgfgmOakpb5nrbvf0RJW+0EO
 8td77m3ftuhO5LkrhisDIu9g6sY/YBziGNDvTaVWwij8DozuBG04sIlno/6yC1obJKWsr08Lcav
 jBUDUZ5G6DTurZCiTjfXgrhyfeChrlpQZNOwt9PIpAOmfg1sDknNYX3twzQpsDWct+jOI5jc=
X-Google-Smtp-Source: AGHT+IFFBtd2gFF/9ipMPzQIo0ql554yrHrdptr7Ga3Ynm3/I3umoV+LE8A76bn+N7h3UVNQHRazew==
X-Received: by 2002:a05:600c:1c81:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-4562dfe78dfmr1584495e9.11.1752607641406; 
 Tue, 15 Jul 2025 12:27:21 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560ddf5e0esm104155455e9.18.2025.07.15.12.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:27:20 -0700 (PDT)
Message-ID: <40504aaa-7772-46d7-872f-eacb6d17f121@linaro.org>
Date: Tue, 15 Jul 2025 21:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Do not dump NaN statistics
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20250710111303.8917-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710111303.8917-1-philmd@linaro.org>
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

On 10/7/25 13:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/monitor.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)

Queued, thanks.

