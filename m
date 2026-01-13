Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A21BCF45C6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfT6R-0006Uu-LB; Mon, 12 Jan 2026 20:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT6B-00060P-Mj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:21:33 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT67-00023q-N0
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:21:29 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so799216b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 17:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768267286; x=1768872086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wgro1hR3cprhNDxL4FMXoZkAQhWmMLATGzSncgFQWVc=;
 b=ByVsQu2aiMlPfCc3/TNUm94GFrGh/pQ6ZTpOqs5xBKJVM+nLfCDpxBkSYdVyB0T/7q
 RzLYZCKn6KMGnzE5T+KeUcuba0YjQVpQffjIG+2IFfzCouCEhJAd5fQirOMTHbztSM2k
 8AY3u9lp/r9r1AyL8ZQ6G4SWvdU4i+40mdO+9ySUQJF79lr/lqJElDuApvJUv/Vp8LPj
 Clj9kVsBpVoZnkuVrKnTxFe2RTOPQtzQe1aNO/GG+v6CpRkkdwelOOUdLgG0iQ4GGl5t
 ZdXN4cxnUgp4Rlve8QNm9ys9tBUHaz7MvL+FU/8YCnrUJfCt/7XcEjJwic2GeViqnesO
 6cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267286; x=1768872086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wgro1hR3cprhNDxL4FMXoZkAQhWmMLATGzSncgFQWVc=;
 b=kUasigByvLAPjH5+enOspivLdZXpR7QmdCMK4tmroWPVBZq8rKcnEHLmQYPxTw/Zex
 y2fsdlrZk9ido0Ds3KxcingRhojNkMxX3DRTei7dqN4rIS7aGlR/tPj4FjKHZ8mI4lvF
 2E17TOeLaLp6tpdiOMHbA+7F3pN9pcEhWgUzMD+sPRCEjn/8RRLsLhHVgBg/v9ZpGz59
 gk5gJakkDpm6bqHXqyVsOVX81nL5tbG9vSuWto3i3Wi9UA7hva8TWTBrmpwZCUHkn0c3
 kJU8ChkbJyBy81doqDSTaHsPN9xAyItXdokbEZMI2uorv0xO09X2feY4U2mUPcuDv0l5
 PJfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz4GuSeXTekC8/V+duMaoE1Eirc17HytYqS2VsBmaI+hcZ7F2ZtRWF/C267D9QdMiVusF5w6OAhSJ+@nongnu.org
X-Gm-Message-State: AOJu0Yyo9VUeJTCRtu5rrJOU8P6OltFpRU5cRLfiXbPKW1N7+tXfNBrY
 UQ7JOWxI7aFIlr6W8hFImh4976fWRXz571cFsKUDiy17ClX343ki2Tu9784PUPDHiS4=
X-Gm-Gg: AY/fxX5y5xO8C36Ui/cMPyayV/ooOuIH27DN7HsOdy06WsOQuf/CZSLcsMVonWjxQjT
 t+7nvqXcI66fVjWW2FM2BUSvQnts6+vdfxkFvd6T/ZCXaXMSnlfiE/Aaxwwxduf4YI6WZAoMOtz
 /zB7fIeXfUs09lUD23Co4ptIcnVOklnUgEodShFlpeecy9FpF/Jnpp3i8emPOBnUNbFnfjqOQBt
 MHzKrAtvjZ8roW7q+Ypgm9/iMWWQAS03qKVT3Wqr9rkllvP2Z4vKeez2GRt8i8SlnAHTSgU3ZpX
 IfmHsW/EE1uHORFn7UwWjO2d6zjG5kpZ47CNDbxVH9YDh9gdsjKfT+urkdOZQnsj3O+FsqB+m7L
 bt0//l04TpmadH0wWMzMmJtmD2jfqJGvHUcQRP37bPRIUM724Wwc7zeOdaCiwby2ZPUAwMVqv4B
 yUyg0deInv0NNiURAeUttAjxqedOQ=
X-Google-Smtp-Source: AGHT+IHDg+dMh4mWZOKZ2urkwjrP4qE04zjq0TblbV2UPeMr8YnREH2ipYJ1fJkNk5yedPswu8Xjcg==
X-Received: by 2002:a05:6a00:f88:b0:81f:17b:c70f with SMTP id
 d2e1a72fcca58-81f017bd35emr9200873b3a.29.1768267286177; 
 Mon, 12 Jan 2026 17:21:26 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52f88casm18702037b3a.34.2026.01.12.17.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 17:21:25 -0800 (PST)
Message-ID: <d497d932-3430-4608-a909-a25c5487236c@linaro.org>
Date: Tue, 13 Jan 2026 12:21:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/12] hw/m68k: register a mcf5208evb_cpu_reset handler
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/9/26 01:34, Alex Bennée wrote:
> It looks like allowing a -kernel to override any firmware setting is
> intentional.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/m68k/mcf5208.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

