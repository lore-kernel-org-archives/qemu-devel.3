Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133D6D46607
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRa2-0005yB-Nm; Thu, 15 Jan 2026 12:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgRa1-0005vv-5c
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:56:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgRZz-0000Yt-OO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:56:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so5927125e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768499777; x=1769104577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m7hruSUKZ2svoEEKkUk+5QsCp6j76zWqWEGrLV3BpwM=;
 b=sBXGQ4ncCWOXGzwfe3sbBxG6KfPXBmpf3T1kgg8hsCXmt7pPbcxcnK4H3AZfZW8kTN
 d7SOIXLcSHbR0egSdfljdPscWu/qdzDpntXE+Ymvhqpow9awzGfKFgFLnkOqbWZQxowY
 5+3YDRB0hdW9aXoB2F0Zn4OX7OqAm4guFAT3hWzgFKmc3XEeshttm4vcS5xunx01pWpd
 pYQjq+qpo8Q5nxvWTsfNJ2ibL5Qgt53cKwysKhnEw12PxlmWmOzAb6dzeqqg23xOgdP6
 MQBodZlOR1oOeng7HoBK/DVXYe62Mg4Z7nVZ1atIiDVNPGg4I/tUfm4bPl03QBBwUY0N
 40lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768499777; x=1769104577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7hruSUKZ2svoEEKkUk+5QsCp6j76zWqWEGrLV3BpwM=;
 b=YcxXyRJDt9RSkLIYBkvB5OXHc9xY8UFGmGf1NLQC/5PM94B9Npi8tjioEZIl8+SgNP
 Ga6lNOCbIOiUNkQ11vDiOG6W7Qv9CoBwuOTclE7gIXcgde1m4JlGY61qykFINrbjYVYz
 4ffTtWc446tOKoT3F/ZTptuoOv83WJ1dkvEu467ha8avpjFvARb1lRxepKDGhWK1cmi/
 qBz6j921hHsHrQrht9aCTZUF+E2R6Zy03lIqUmh6RVs5V5DiaVCPTnglQ8Xrz4Ik5e+U
 jKjtcpGEJ+KR+U7u/sJmRnsrVjcuaZKzbGpzXKst/bjtag2baTMDjZ/fKt2XQym8KlUt
 IJBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOatMkCaaIV1c500idXsVyc2/srSYDZeMeHM1CQqJ3zAzo+Vt+vs7b1t9XY1kWuq6eN2vtZidGIIHe@nongnu.org
X-Gm-Message-State: AOJu0YwkDf/ilwqpsBa87dgzdtZCXkJVZNNsuFX/ZvK6o0Frkz2pICnR
 +ijLZ7X7e7QDlKEjbxieaCjWDGXybRPygS5GbTXafkfyjzj4HIk/7bmSiTck5ks4S5A=
X-Gm-Gg: AY/fxX4rW+/N9KxvYqd3E1CUgqqENjNCBKVtKihngKdQ350rGlCf2X4VnUSNlo9TM57
 0Ntq7LRcGqu8fCxfTeNN9BVhomkgWMuu3mVOeGIActywtbzIMcO//J+AvNgShiigQJSqGiioC9R
 ClycAXjSVxbieA2TIPwCOYRD3tvVIq5Kd0Eb3Vq9dC+rNIF8amU6isZAVguMgB0x0ZZhXpxAkqu
 WNqgAMyIjkM004PzIZpoTyIyyVKtJKc6WHFnmFaniQsd3+PtjQ19dg5jJ7A04YLPYh9pqnHh2gf
 KDBxp500KRk+I3J6OLTVAGD+cWv9e2Fsyhx/x/Z7tslckqPz5+rPx9+rry9Ur2o8MZdaq6P4XZo
 HUYONeo5gIrN37xySKp4V6shlN3l+PidjYZdJtEedtUoM4lJdsKPXnxLdKDPH6fq5pY2CtLWmQE
 lEyP98fulHov48ynh/fL5HC+5gXWmOSh6zHpG1G4QmwQjfzikw4WrtMw==
X-Received: by 2002:a05:600c:528c:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-4801e2fdd1fmr6199435e9.3.1768499777242; 
 Thu, 15 Jan 2026 09:56:17 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428b954esm58566825e9.7.2026.01.15.09.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:56:16 -0800 (PST)
Message-ID: <7f065213-cc5a-43cd-999d-5824d6f29aaf@linaro.org>
Date: Thu, 15 Jan 2026 18:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "alistair23@gmail.com" <alistair23@gmail.com>
References: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
 <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/1/26 14:01, Djordje Todorovic wrote:
> Ensure 64-bit arithmetic is used when computing cm_base,
> avoiding potential integer overflow.
> 
> Resolves: Coverity CID 1644076
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   include/hw/riscv/cps.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


