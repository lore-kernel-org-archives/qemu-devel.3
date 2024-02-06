Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37740C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOTB-0008OX-8V; Tue, 06 Feb 2024 11:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOT9-0008O6-6h
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:38:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOT7-0003ez-M2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:38:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40f02b8d176so50882175e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707237524; x=1707842324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDbs2+l1RW6CL7rkOe1toFI/Q2v0nq7PGA06Let+8xU=;
 b=W/OjjWNYHM+TQCguyhbY9/twyhzGtX4qy+bCEnzMVCuEPB+vU6vRNbiaCHNYxk79s+
 C9g28nkiw9KS16b+39X2pD5epfu0W6kMOojDANq8JdsGH4U4Uzo1cYhjKiwqeTvxIENz
 twhK5TgYIN9e+8laDo8L0s4LGf/eKoaekfrG2wnJQ7NtTuOmpkqPLuw8bjkEBdbHgdzN
 UccsuNRt07Q65XdToo2hVJTeEGw8Klqtff7d6PJKSSAc4CS5GcJdoC+Kwa5xLKUzfM62
 030FWa1kOMSDcS6skA3RBTEWXcy+hW3TyMQLBQKznlrKSjIIoMSlM9b9S2rCV1+j2/gD
 7iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237524; x=1707842324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDbs2+l1RW6CL7rkOe1toFI/Q2v0nq7PGA06Let+8xU=;
 b=hHdCke39KlNULLOU3is1l5QrOnUiVr2uOfVLal1ecftLRl4fLxbwR/Zrc8VaaxjT1g
 A+1okazUZKOOqK8W+V5tY/S+H4P1ZWXtMi7D2w3HZauB76uXWcDJdknxX+yhb02cH57I
 BYc8rUYFlK6b8l1FyIA3aigcH2jErgf7d9sSehFhs/E/YuJgGiMR/LmOWZmEAl7q++Id
 3BMQOvIjdNjgkFDq5yk6hTl3r+HeZYL9GWmfChpJT3reihcernIxeKT7lKV5a6iwtmZ1
 M9ewCLl3mvEGWQqFhv+F8rS/F2K5neNd4QO1PxvHYUazqN9GzSF5uFGbMwjO3bVGCTxy
 QH2w==
X-Gm-Message-State: AOJu0YwsxKYF4QIsZ9D1vQwLfea3Vvy+M/+dcmcNyLBNCvWnQLm9jmPB
 GdXFEwtDWG9amUPa6Iw2yNzIh/GEXj57+Ipip57+sZKYwqmPJlZllNaKbyQzor8=
X-Google-Smtp-Source: AGHT+IHTnUoJrIwY5Ozyn0SJnsAlLxFs5oLg3V53Dyuy7RVWNVQEfx5nl7C1aS0Hf2ZLmAFFPbsJuA==
X-Received: by 2002:a05:600c:45d1:b0:40f:c1f9:c884 with SMTP id
 s17-20020a05600c45d100b0040fc1f9c884mr2468524wmo.39.1707237524097; 
 Tue, 06 Feb 2024 08:38:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXIhhk69ORs6IUZ3nQ8GB18Dke6f1NzYH6WFQH51BKuO5GnQEmjJJ+zZv+VVzjsJM6kKLu7OrTnXD9suUD6jvmXUH8ZUtyKv0y4bCbfVxmBIYiPBbs34KyP4E3xsbpA93ILTtdYIQ230zha7aM=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 a16-20020a05600c349000b0040ffc838cadsm167828wmq.15.2024.02.06.08.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:38:43 -0800 (PST)
Message-ID: <f16762ac-23bd-445e-8116-d62bd242ca6b@linaro.org>
Date: Tue, 6 Feb 2024 17:38:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/meson.build: Don't include qtests_npcm7xx in
 qtests_aarch64
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nabih Estefan Diaz <nabihestefan@google.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240206163043.315535-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206163043.315535-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/2/24 17:30, Peter Maydell wrote:
> We deliberately don't include qtests_npcm7xx in qtests_aarch64,
> because we already get the coverage of those tests via qtests_arm,
> and we don't want to use extra CI minutes testing them twice.
> 
> In commit 327b680877b79c4b we added it to qtests_aarch64; revert
> that change.
> 
> Fixes: 327b680877b79c4b ("tests/qtest: Creating qtest for GMAC Module")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/meson.build | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


