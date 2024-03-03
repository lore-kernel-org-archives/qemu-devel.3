Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E624C54798
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbbP-0007Kj-Qz; Sat, 02 Mar 2024 21:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbbO-0007KV-C9
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:29:22 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbbM-0006JI-VJ
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:29:22 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so3143952a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432959; x=1710037759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5iNwwu+6qERU4ouf23SWkEZYQ65ITY6Hv/0w7ULcI8Y=;
 b=pV76Ey/iGSDr4t+HDAWqiKoapIaH/OJj7VaBNQ8oYgidGhrL0FwIhj0C0T3G1baVg3
 mIRPLObX4VHkxQddulYmEwto3oGkCtNHxOIZ6z3CW2xjJ5r0yhYigRILgP+EILGB2pMa
 3O+ETy6rQIRdjiXdEIQiw21nPJT09DWskznqr4km/UY5ACCJr254VlNzGlYrR28E5iR/
 RYr7pCMq/qhqfRiV3oOtsiQL9Y7x5UAbJ3N9Q2y2aSXAVse+b0gnCZ8HL+A0H4ltAvxq
 OBu7gIVetK1KG6520ydPIw8Y6Wy4w4OjdPajKwBFEisTyCvE4lLmvRQOke9JaBI2rcyb
 TwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432959; x=1710037759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5iNwwu+6qERU4ouf23SWkEZYQ65ITY6Hv/0w7ULcI8Y=;
 b=hVYOSSsxEIX3rt4T5in/dxoXJ9ZgjOUe7f/GPPwFIAAYhCUiOdjh6oKG/Hw6Mie5Bf
 M99rV/6S7uEtRoLcf9Fh1e+cgjH85OAJLumTDqKhzLQ71BOnWvi98VfsRu+EZ8MQ+UCD
 qTD8EmqhESHhR/6wc5FzBmnymsKEZMfy1RCabRPqYgXC3+N5dbqZc84sYCRItbE//kkd
 4e7Zjl1K6Ky+K1DOhQRKvm/ybzgNqhFhZRTaKGYPFr81hfiYTx7PV7K/s5BB5Jk4AUWO
 EGSdawQYYTzhr4ZjVXY2fntFzDw7A6nTakUgmBq+vsl+6udtKTx1Gsk233uWTrpOt2NU
 oSeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjEPb0ehHzeSsyD94uIMIxsx9Usr7wxKSbkAOpinkEDK/8z7aY2mz3FA4uEqwasuBkEznmztQkVi7J7uQslDXx/gU0ZgU=
X-Gm-Message-State: AOJu0YxJhJQRRu2n5ZzPJICWX0GPC+RZdgZn7U4+x2yOU82PUYOMZJ8v
 43ULvgvut+d5c9qkLIELJUTG3LDxiI37daNe3Zu7VizXGZ4qGXUe05UGP1wvsgg=
X-Google-Smtp-Source: AGHT+IEReXUIEoHvRGuYurS+vvbZUYEvyGq4q0pS48EMdlVud9nRCEn+MIzVjKL5+UpF57awqtgiMQ==
X-Received: by 2002:a17:902:dac6:b0:1dc:81a4:4c73 with SMTP id
 q6-20020a170902dac600b001dc81a44c73mr7836679plx.0.1709432959669; 
 Sat, 02 Mar 2024 18:29:19 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p6-20020a170902b08600b001dc30f13e6asm5827636plr.137.2024.03.02.18.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 18:29:19 -0800 (PST)
Message-ID: <88e1c5e0-0334-42c8-84a1-6c4809d256bb@linaro.org>
Date: Sat, 2 Mar 2024 16:29:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pc-bios/meson: Add hppa-firmware64.img blob
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302223524.24421-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 3/2/24 12:35, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Add the missing 64-bit hppa firmware blob so that it gets installed.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Fixes: 7c0dfcf9395e ("target/hppa: Update SeaBIOS-hppa to version 16")
> ---
>   pc-bios/meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

