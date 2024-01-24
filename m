Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DCAC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmGT-0001cS-E7; Wed, 24 Jan 2024 18:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmGS-0001cI-03
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:02:36 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmGQ-0006H5-Do
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:02:35 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2906773c7e9so2489514a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137352; x=1706742152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BhF5I7xuHjxfRr6v5MgSsTExbF8ktre094oj8HlyG4=;
 b=WMUdhKX744xSvFjgEKizUBDtFx8wOKSdk8G0XJvX0UZdKiBpZUk9m/UTXaQDk6IGKu
 fsQc60mylGEeXFU3Gx4qQ5uFwYeq1oAEL/Fj8XA8prCkvImxbxy3TQpvxyzLz8+j84iI
 DL4uADiLnu4t/bLx88SpNm2E2cG7dI/P3aJmIxcfhuchabCobCRBC+/5ucmE2XqN3Rpr
 p7Vq4WY3cwTlfZpwnjQP/c4KPRm050uXUGsvAX7BYIpPcfPhECHy50/FfioLzHG+z3Ci
 NSm7NAtsravZkLyK/YzrxnpJMHgpxwwFZ4/OcD3/gcbortQRZvCl75FEF2a261Yv/k2A
 m8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137352; x=1706742152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BhF5I7xuHjxfRr6v5MgSsTExbF8ktre094oj8HlyG4=;
 b=mYbRQlpNBOCl1LpFMdgJDlyPgqkIy/xWXsnyZJ3mjJR/dlX+Yp7qdhurkruyHmlDic
 mVCxFfa0dXWGGAlM6XhD/P8hdftthRO8A3j5pgtqs6zYgF6bnntuIZLTWf0jCL6Bz3Rh
 Xi7flOA0e2yT0WNtzQyoAnOa0kJEOLAqvu79NkTKoKFdB9T+vk1MHsPwa1x6hnIeXIF+
 MqqqHQOa+nIizFj9RMqZTcJw1SXqZXoNALR3Nh9H94u3kghW9+pLxDYn59/7NTORFVyk
 FSwBCC5HFf2OS2HjU38RlpBaPC5Sr1krV31a/jzIzz9TjBan471UbqUfrTTkTcx2WuXI
 3Zsg==
X-Gm-Message-State: AOJu0YyzkS8B48fWEG27NXDFdwL6eyOKDQ3nsIK3bhCt1vNbAVzrUOxu
 VpE5aHA0qAb2O8+a0qiX9hIVtfDogwWdF0cFnfPhD6YEJn65l9m7HMBwFzCqBDc=
X-Google-Smtp-Source: AGHT+IFT+qQks17SPNPYjiuiJga6Y2bqIQJmZ88jzfODiis67iJA1CfllwMPl3dHAghlc7VQZ8jRig==
X-Received: by 2002:a17:90a:7566:b0:290:e601:487b with SMTP id
 q93-20020a17090a756600b00290e601487bmr72568pjk.43.1706137352737; 
 Wed, 24 Jan 2024 15:02:32 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b00290cfffee0asm176910pju.1.2024.01.24.15.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:02:32 -0800 (PST)
Message-ID: <86006ee9-7481-478a-8081-ce06bdb21d2a@linaro.org>
Date: Thu, 25 Jan 2024 09:02:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] accel/tcg: Introduce TCGCPUOps::cpu_exec_halt()
 handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> In order to make accel/tcg/ target agnostic,
> introduce the cpu_exec_halt() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

