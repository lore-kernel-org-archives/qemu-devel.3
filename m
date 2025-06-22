Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FBDC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTALV-0007br-HO; Sat, 21 Jun 2025 22:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTALU-0007bY-4o
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:22:12 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTALS-0003Av-9J
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:22:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so2512194a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558929; x=1751163729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ai9BsdwETi6+ehW6rBJNG7toHrbuCk78kyq6snD53E=;
 b=oeEt7QmffGG+qTEa6NbDsjUe6CpUJtqEkexKmpot019KN3ssHy97Bunvj6CHxqGHbD
 TLwzKqwaeAsEgL8H9CPaGL/1rPpVhK667bzO6XwPWNQF0mW5epDoMUMNSaauX+dCRP2W
 Lcv1M5641VuhNfqh2xp7Lsflj2YQ/vnraGYoluiDWz3qtGOK2tGjRUEAS8LkzrUnWigx
 0quPHqMdLzDxWMiyV0an/miZmCnLsmMI2C5lpycf+8lOR0phLb64Ev2m3i+gYEsNCp5k
 koZALus6g4gA44YIUz9IFRCeXsnNnkDfwfS9OLue+Tt/TIlN2NQrh4GQXSiZgPNFs/Sa
 EUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558929; x=1751163729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ai9BsdwETi6+ehW6rBJNG7toHrbuCk78kyq6snD53E=;
 b=avjUUsj5o4QJLWZPRVxXkyvGnzrCV0xrdMlcvA9xXuxMXSKNtr/Cx3p6YkBU+rewZn
 U2K+nDKHPxIN/XLHKg4xVevXpPmE8bTb6sFJO4L45AQsKteO3xXiim2+mFiT71CuoKBb
 ZsDywJaJ7JkpiXn4CneRJJkrmwsDNgGIHnf7QAM1y/CsgGCJ5i/WjalnFZe8uQwyDPxt
 dNhIxzjaTL+IiVaNw9wBqhVUs2ai3MlbO7OV5kcdI2o2dGkH88vxv7BlJ1POk3cSeU+q
 bHnSNIC6ERljXFp5ORz6zQjKa1Q/hP0Ou8+7LRh3/buPycxGu7+UaGEsrBHa2X+sphNA
 +hSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMuCcj9ohmrm3JLs9bmB7mQUu7eCIlfoBlpAp6rsjK6wR0DUz/1oVo4QLTP7ROSyeB0q6QbrseEEvg@nongnu.org
X-Gm-Message-State: AOJu0Yy3oCJyvbKEmZfUg7fifJUeJdRyRbR6vS+fm4MISmF6IVeZWAKP
 rKqobpJXPN/WcO6qXUbDFT0WRaj7qoiQaS5amaVT0jhqbT0F1z9ICC24bHSXyD4mX+g=
X-Gm-Gg: ASbGncuDA2T0USch5xbIVknVI9ZvVDqbHj5KF1LZVIcf4FKt19+ErMZfu3mvwip28zq
 TaK4hkx27VmPkUPofmIWWvd153lPIu5nluahMUUQgUZlqnM2+u0ArgXtrZkRy5m1y204pgWmtYT
 p9g7iKfMIHq0SgaMZsueRbmjyJPPeSmTKE3gCP3WbQ/GxycwmNorrK2PaPMCdzUitTQAJpi2vp7
 MHQAJPTpCV+3kpOrZ1H2ulZzRq2zVWtLbhD9nLm+Undak/Zc/bXC/YQHSxxWT1iz63q0NtgLHz9
 J3pjfhBWgTBVrx5IghGm9GuMfocA3UToJQ0urONr1pu+jpHHb8BxyyWU6WVrPDgjwmd88gCFMJy
 LBpQDMcaALm05UVocZN6Zv2cW2vkL
X-Google-Smtp-Source: AGHT+IG5AkLBgqZNjipRA4v2tOPcZlJjtzlvT0mQBeOHBXCB8NVtt1SA9N9qr26hU46b2zOHmmZADw==
X-Received: by 2002:a17:902:e88f:b0:234:bca7:292e with SMTP id
 d9443c01a7336-237d973b345mr107720555ad.14.1750558928728; 
 Sat, 21 Jun 2025 19:22:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867c0d9sm49511775ad.177.2025.06.21.19.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:22:08 -0700 (PDT)
Message-ID: <6b127dab-1d94-4b6a-8506-91a1fef448b5@linaro.org>
Date: Sat, 21 Jun 2025 19:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 04/42] accel/split: Implement
 accel_init_machine()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Force to TCG + HVF for now.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/split/split-accel.h |  3 +++
>   accel/split/split-all.c   | 30 +++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

