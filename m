Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D770C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrsJ-00052S-EC; Mon, 22 Jul 2024 08:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrs9-0004Qe-SL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:10:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrs6-0000Cu-FF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:10:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso1937366f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721650228; x=1722255028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tz581xDFIk4q86u68NQF1HpkISUVEMrMRDEihy4lBIE=;
 b=T5CJY7mj4RZuqkJ7dGY3fmlnE4jTNEhdXfIuXBCHUhW1/06I/9geigyiMgZdCDXCCD
 sI/gNhyaKDf495fojfHe8yU1X0z7VpMAXVq99CoQ6IRNuc7jywXOz06qA8ew4JKQ4uD4
 WAZtjl/knqB+3+/AHeZmIiUpFO62+K6kaPQx0Hmq37uXGxnEs1WdhAGTR4IvzSmDcGEx
 HoAbz0sMCUcHM33+vLKYctcxE/uNrJBVSra0VuxNVUqaqE9632u5KEmtbVp1B/1fMolQ
 K2PgvsJMBzq3cR990jknnOzrmpgnWlKrqFi4DvPrf6pFzkgo9+dUqR+lzzY0YVioZqtJ
 y2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721650228; x=1722255028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tz581xDFIk4q86u68NQF1HpkISUVEMrMRDEihy4lBIE=;
 b=kb7yXEHaBHW3rFkpdcTM7yZYU8AqPceNJ/kVxRUI3GNhqzJP7btdR/FJTcbtGeHB8R
 K/CWzzIRAi8ddPsUZmKpRx7JAzLzllhPXhK2lKO4fM3RHrXt3Q5E6LUrJQct7L2q5IoL
 Cq0f0KGUIErg8rv8JgNtCHoV2lfX3+7gVqHdZfBq+s/0u+1sxgjm3WeJzCB+ESdu7Qhw
 A1v06pkLhph3OlEiNbg2I8fUaAmuXuZKyhNhszslaLiKh3vp6MJ1uEEdsZyi8+tjmw2Y
 q/5xkQaDWsXpBF1u4QuxsYxyT4KESTECe3S1aGafy/XeuL7eHVeFMRSbuD9tWHKzF0Gj
 rzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ9Ae7QpTaOwmO3ydWmvXxbMwN6QnVETIao4lppro9tFplSH73J62tjjDnL41rTw+WsMQYCUmbkWvIasydnjACJ0YscFc=
X-Gm-Message-State: AOJu0Yzfw9EFM8K1/Fudpp1x6+gCxctjlT6XH6sHu6mrOa97iP++++kW
 CKqHyM7pECQqVKkEGbusGdMtl+GzDhhOhTWDZbWo2lW78GvGNstcF1f9BzZCkO5FjFo+n9YZu+1
 m
X-Google-Smtp-Source: AGHT+IHDH6Ac1i++qSh8Peolkhg9U7/9nMhYtZYil/xI1eoFXwbMOwtHGdBdiL9BMY2N/Yp2e0vySw==
X-Received: by 2002:a05:6000:dc1:b0:367:99d8:70 with SMTP id
 ffacd0b85a97d-369bb2e3a03mr4340129f8f.61.1721650228466; 
 Mon, 22 Jul 2024 05:10:28 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a95099sm150594525e9.48.2024.07.22.05.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 05:10:27 -0700 (PDT)
Message-ID: <63254db0-bb11-4cc2-acce-6f206247a403@linaro.org>
Date: Mon, 22 Jul 2024 14:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mips/loongson3_virt: remove useless type cast
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
 <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/7/24 11:17, Yao Xingtao wrote:
> The type of kernel_entry, kernel_low and kernel_high is uint64_t, cast
> the pointer of this type to uint64_t* is useless.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   hw/mips/loongson3_virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!


