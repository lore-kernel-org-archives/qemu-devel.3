Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87860CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrvW-0001fp-Iw; Thu, 07 May 2026 02:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKrvR-0001ei-Q5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:09:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKrvP-0005E0-2S
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:09:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so2499225e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778134168; x=1778738968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vn+AK0AVyfzTOp9JzSn3ryukFU/S3HCDA1xqjsrTcBg=;
 b=dGrczHPQ1IZdhvfWif0kFhRMY6EIXQlsoZbMXkoCSD1IyHOERrD4O8ltMCSJTj7zr3
 rxFOnJhWvvX6SVtOXHKVIcIlz+yZH1zRSUHT6lMgydSY6e81PRaPupTsxu2jUZ97d+9D
 ccqRFj10YvaCvRnmJO6kFto5VBx1D+/RKnRDyrQWsj3/ynrK+/vasoXzDm97NGl5LO79
 3f587Vpb0oEaBToCK9qKmvdbpSOwcVWksWARw+CAzp9XI1erOyl46MVpbly5/EIk1nXn
 Ke6eRbx2yX1XeLZ91pu1JMX47sYVfI4kYT2T0GINueZUOabvBH/7frnd3X25Fog3gAK5
 vSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134168; x=1778738968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vn+AK0AVyfzTOp9JzSn3ryukFU/S3HCDA1xqjsrTcBg=;
 b=qkaKyCcoT0pEi/pFagxcnx8F+JidAdUdeGAiqkUgd3gJcMYsbT+T+9lJy0pstxI53Y
 dfUHfbh98sU2ymqEWGwIk/Fmi4Ilu4MvUBmdwI4AeUZv6o32Y4/QLR4qAQxkQ7BJZOxX
 0QYtRiNhMV4PDJwV4zH+hFvxQdgUoS8r+l4mitJXvmnWbLlRBCabqgMimdbPvhiKa37j
 KutVP/WTql/AwgAbw4sv5aMLSBAgSVliRmjRR7qS7eMPP1m8SZF98s9bhKyMaqzswVmO
 OvXpqQmaNiNKq5gUiOlKZLdT0umUMgwZy4QhxAAhtAngFh522FKer16GH/Jf0B7M3OZ/
 hItw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rIQ0culpVaaK49Zy7g3xxHyUaOxWXqSzwkeRLK86JtrvLLdls+SJYFLgqvaNia5PS2nZOJAzOLwDL@nongnu.org
X-Gm-Message-State: AOJu0YzmLdu38kXl93UzMSmGZ/Fcb/TGhd/0hvZhjteR2pd2Xr6zOj0Y
 O4GwY/RyIgRjkPvVRgJv9yhgttvpbFZIslhEz2A7+hpZjPmdVmstWonTy7LvTOvOjHc=
X-Gm-Gg: AeBDieuzageo4E0LpH/b6pQjXyUnIDUQlQZ8vaXY90AeXH1lb37+RPz2q5rgyfHA5wV
 Gpz4UBC9z3PnNQWlZxmaTZlm/3Wclhpb2EYsRD86DtfZLLSwyEG4xBtRMHBJ+a1GRP/vpIsiQV1
 09OPT/nupJgRaiPU6oYvfZMIRMMTQ5F1ckD1VhoSjSZHo7ch9tJihoDgwD0Dxbi9gl4GYVnGkyx
 tjXnGEVZ2e7jrvX6n2ISWPQR7LwVHe8FgEQhnV/Gvnpd0V7vVqcIt1NBs+U0xZ0ri6b6SEGBevP
 1vlxik0b+pRW4Z6riI5lRh7j+QRJDdRmLqB4VnNuFzVt2okm8HvhwpSOeiS76LxQbyTK7ljyYKr
 dngPKcqA3aFnyPyMmLQi5VAAxt6cDDhLDcJrqxPwRFdnncpQYaX1iQxxjRtvbQWL0irlJ0t47vu
 HJjlRp7ydwXn8oM6ThvOwq1jL+4eWy91BaL81Q7UhvdXcQKjKeO2Slc7bvpqmMy31F8QqJZp+0e
 lQL
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48e5dffabcamr21546805e9.9.1778134168375; 
 Wed, 06 May 2026 23:09:28 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312dbf8sm30897775e9.23.2026.05.06.23.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 23:09:27 -0700 (PDT)
Message-ID: <83c92d12-db0e-440b-adf3-afc5c86b33d4@linaro.org>
Date: Thu, 7 May 2026 08:09:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/riscv/atlantis: Provide a simple halting payload
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
References: <20260507043838.45652-1-npiggin@gmail.com>
 <20260507043838.45652-9-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507043838.45652-9-npiggin@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/5/26 06:38, Nicholas Piggin wrote:
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
> 
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
> 
> The Tenstorrent Atlantis machine address map has RAM starting at 0 and
> it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
> tripping the early check and hang.
> 
> Add a helper to set up a simple payload that gets OpenSBI messages to
> console, until OpenSBI can be fixed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

