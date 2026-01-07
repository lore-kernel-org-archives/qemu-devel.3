Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C34CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKRZ-0004C6-78; Tue, 06 Jan 2026 22:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRX-0004An-8V
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:42:43 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRV-0006ki-RA
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:42:43 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b98983bae80so1034859a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767757360; x=1768362160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2WZdMqkGofu2rx/HfpGlnBU6z9ZV0dNCkdv1WcXEaxc=;
 b=rXCsgV7m8k+vhMh5Q0XuhiYNrAj/c/Eh4CUx4Eus/gCBH4PsWbHr9w7ehqkOEJHgk2
 ov5ZGrVJqUVMdf6B10JNRCkFC35Rqc7uFH5ZCWOy6SqmMxaqLpe+4QffZZmxo8Y9DK0P
 6mgsxkDvr4v4L7YC9hXCeReGb+pZkizrnenu96vUj85Z370IFiztcFhBJzX15rSlJNE6
 TGElLBXq1waB7/3oQQXODsXkA41Ca9BbiZ5pHgl9zUhOw0QF52ZubA7OElWF2ehL36/z
 dHE84J7IJMXOUXE+czx+9aqcTlGKNg3xE2qPjgZ+91Kv47CBBKt+SFWhwk5RMJmYqqRC
 OcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767757360; x=1768362160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2WZdMqkGofu2rx/HfpGlnBU6z9ZV0dNCkdv1WcXEaxc=;
 b=APaPvIc7YeLNMTh0rJ/quZcnNoocSwbRWNlUAOze7UG/5lDSYnSEuqm7qTuQbaWYZ6
 unk1x7se7T8PVRIN5Sgj6lI4SDmfC+dZUGOUiyb4nB7HBg+1nPDwiChaW3YSfOCVTGbl
 XBV9HYlSTu2atErGpoUeYKgTDi03PfyD97uTk9rNT8/05dwwHROvjk7NaKS2axzo2vXO
 u3sc8lNQDdejQEmPiU5nQBJvJzx2I6tbaQ3Tdfs9N8DHobAT1+1ZkBRoD6MGMeyQpd0a
 DAC7yJIpA2yuGjwHjuG+sZ7R+aKPYUGFiY3vhsxiZ3+NgtL9ijf5K4/We7/x9SL8FTZY
 zorQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLmu/0kJl9Ci2oQer+9w2ohMBfaOpOY47jHEFBWDqwKYQeUhzK6EM0kU9WWShgPqbphK4NLhOvmseT@nongnu.org
X-Gm-Message-State: AOJu0YwzI/un5pnG/6yKQ3QwADyIrGnXMSV96sVGYxOy/YxShjnWBmKb
 mO2mQclFoPDM7bPH+GhL3V+fmSqh+b/Wx8VyPAFtFZklK7eYwbJaYTGt1QY6+uZf6gQ=
X-Gm-Gg: AY/fxX44pY50Q8hNTNTVh/pi2U/+B0OYFQturPEUAakJbigpkjPs2n/BeboN8XeKrkD
 VrvoczZaR8jPz9x5KJYAiWXKfEDVUCiOlX1SDQocMM1E0/IToH2Lkj9vwZz239pQHusLySx3dCO
 gCqyCoj72/4U9+SqfFdGSkxmgd/Ndcd+PRUrpOAJ3ml+NsIqdtYbRm7vrhOnne2wyixkaQgzdcs
 ooL3D8uBqS003JOWbs1dVlP4XEZCD5jF00KoOA64HaW6mwoQMcLbLCofcqUWMxJ/AQQ52yEBMbM
 GqtKDbWAnBgO06mvwURQlUkD/SPWRIunpikqca8t4WRJ4SSc3Obt3xmafwx1LHLYBmC2PwQMR6l
 mmmgKCFtN3jXnvsEzh8YXO5HwbUHh3h/QBBwbsTg9tTmq+twv8/9R9ZT2lPZp2Lq1+xZMxaku0q
 93YSRGU5uYxXVTlwzloYR/3rwm4i13kkHTgM0jwAmIY/G4OS2PBzsckA55
X-Google-Smtp-Source: AGHT+IHVIkXrCd2v/yIj36Gx3PQsQKoEJ6bYa7w+u4Y+XlM4AUgDGeDX2HeW1We8K9tADyZQSeUS+g==
X-Received: by 2002:a05:6a20:244b:b0:345:e30f:d6da with SMTP id
 adf61e73a8af0-3898f987cb4mr1129746637.37.1767757360086; 
 Tue, 06 Jan 2026 19:42:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa78f71sm3405736a91.1.2026.01.06.19.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 19:42:39 -0800 (PST)
Message-ID: <5c86a8d1-40f7-4334-810c-2deb9b63f59d@linaro.org>
Date: Tue, 6 Jan 2026 19:42:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/microblaze: Build system files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106235333.22752-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> Previous commit removed the last target-specific use in
> system units, we can now build them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

