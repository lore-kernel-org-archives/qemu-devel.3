Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03555C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ej2-0005Pl-QH; Tue, 29 Apr 2025 02:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9eiZ-0005FQ-2U
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:45:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9eiX-0000rj-DI
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:45:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso63593755e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745909119; x=1746513919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJ/uM7icz1OjmSlvU0WeR/SCYKuY9Gvhp7NhFQ6udcE=;
 b=aGPvRb3xaVikqn4oMDwMJdjxD/EyTA8pnEcvJPLZ/3ygO/LpCok2qVMwW202/k9g0m
 Q55bXuPeCR5wisQBDnQEoF4edomRuDBBGy0ZUL4jISiJ58iLBlFESGVpd6chE8muPaFv
 Sj1bhTfd9qz2c2ZBlmNgEismNBaj/E9moN6cvCfVuv5y255Vzs+2KDAKZwtk83jaOoyx
 U4D0vEWG4fw2KXMFKI7d/Ngjclh2loU2ZTmtfHArZb80v55butPIOTmHmQWKSVEyvPIZ
 H/xGB9wRg4aIEpAlUW9Sbp0wY9iIB1GgQLQl1wKtXmwf4CodbPPTPW3AUZWDOiuyLFX8
 YY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745909119; x=1746513919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJ/uM7icz1OjmSlvU0WeR/SCYKuY9Gvhp7NhFQ6udcE=;
 b=S2hVlo3TeQeoDATU4ZQJoF5Rn5MR28DA6N3wHudlEEz0jawrOg2B30TGsZp4zzLcka
 LBkj8+wm+cQLSPMAnVmpbfEY/JqCr5ggsRLq2WFj4ZjXyuFh6jFLInXE6yukV3Q0jfKk
 G2jMGxfwUQk3izT9rS1/WcWv7Ay5nEpaRGsUUQoCBkttBkJjsyK/rv+esNI+Kxd/Hyj6
 rjH0pt4fBM9J5ynxb6rZmfpGWLVN5Afc+QNSoK4LOz3mFXlGHp91swjkSRpWD+zE7nks
 rCCwlQoLxVCQ7u3qgekk/O1THaS5c8SZpQv3GgTWIkBmYSPq12Dg2L6JVh+vA/LnOPqY
 w5Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi/nORRPQAAeKHcm78mP7F/sJqkfACN4Xo3keNGOxmEBTUTlMNxKyq0aCmoo+x4OP/yhGe2llc59eS@nongnu.org
X-Gm-Message-State: AOJu0Yy5pqPB2aDhFZl9iOHPX6Foupin3R0Gc8A9SUbYBMk1148Qksv1
 o/N1KlMcS539zz1E5EpgW6tq4mNxH5SrfWU9I2nvsTlAG2Q4dUFNd0hp+nsQEGZ/POR5vHDZLfK
 d
X-Gm-Gg: ASbGncu9z4ktRjRbC2coQ+I/A4izrs53+UsH5V2eh2JYntsCyAF5GOQkm9xwc/GFTVA
 ZCc0vGjPXi+mhAoyWXD0YuvKkh+aPchahm2RLSvCePh/3FA48VncTyz3FpDymOsRi+7FOrRTHfL
 OEIBSsRMn5EGXwImj1kmJ45Vaq0Me+dz5pDcVSq6QXUjD2n+402UbfEulXxe4T5eGct43p+XWFu
 BU9UdwN2QUdn35UNqA0vWlpm/hZmAzFGYdYUE46myyNmRigqzN8rBm3P2T0Eoxh9z7tfRfhAIWr
 Go3wp6Aie6ZXtWGjeDL9ohrwDyfEiGb9axGvZQt9yeBavnrrCfiwfkGo3gdSYpVl7b5v30kPol+
 TYUFbX7Rg
X-Google-Smtp-Source: AGHT+IH4Vg91aVAMOaJ9GLuGrfzixVcabEFWJO9gAabYDSH+N++aNJbK+2YF4tvKARaTdknI6CrH7g==
X-Received: by 2002:a05:600c:1e1e:b0:43d:738:4a9 with SMTP id
 5b1f17b1804b1-441ac890b10mr14413695e9.27.1745909119569; 
 Mon, 28 Apr 2025 23:45:19 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5394bfasm147110185e9.40.2025.04.28.23.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:45:19 -0700 (PDT)
Message-ID: <e9f0303f-90e0-407a-940c-0b44000fecba@linaro.org>
Date: Tue, 29 Apr 2025 08:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] accel/tcg: Generalize fake_user_interrupt test
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250428201028.1699157-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 28/4/25 22:10, Richard Henderson wrote:
> Test for the hook being present instead of ifdef TARGET_I386.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


