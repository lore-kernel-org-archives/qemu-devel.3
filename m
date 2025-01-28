Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CB9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcr1v-0006di-LL; Tue, 28 Jan 2025 14:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr1s-0006dK-M9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:13:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr1q-0002Yy-PC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:13:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-219f8263ae0so111542355ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091621; x=1738696421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wI1kq8JEmxzrmxCDpmGm6BSOAUdS4vySKxJZUvTkwd4=;
 b=YajLTjByTmemSd87SV5Uf2P8YzzcXhyuhK3ar6vAGOotj3VVHzicJvXI48ZjMnH63F
 qBxBRFSj1IBHk5ky3bJVYvALanV9ZXmx4R6hjg/vzJOMRv8cOAP0g1szOav465gSf3Rw
 Ex0McBn2la8mXUdjD/vQOmug8EdKxjpTUYYI9ZbA9Cke47XWOQjrrFBVacogg/nlNLS3
 dB4b0a8mRenVwe4lQHYHGAfipgPymW+9TBCW7VXnPYj6gy44xj6GvgmFz+bPideLbv1h
 4mZeImrNrWQKi8sqB0tAvvBtMnAObrvf1LkoPEv/5k3FDqsdb7x11E3HcaiO9PQNqm+I
 6Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091621; x=1738696421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wI1kq8JEmxzrmxCDpmGm6BSOAUdS4vySKxJZUvTkwd4=;
 b=PxN59bGPNETD5Q8odNA35ShAGlrREPNzekeAKBHt7qxzI2bp1pcSFXfFqS9GtgUQ9A
 iUScnr2/cBA5qIY4wr7SH+ums8QMg6YYiolGrG4L5+BFE02pUMGZi43lt5c09e0Ezi72
 38FaR5PTeUBdMaD5GEaocmGtarQrqFyUVgHigExrV3nYDQa38h+v4UJVV/q6g4iqcksz
 SMPUWY2FzvEEo5k6+KGVd37JEmLxu6vL2J8HXQ6uxuJA02qv6/oXSY+xMYqDvNGM4Dnf
 1WyrhweZtFrAh2+b4jEcUK/cVGZuGoDwh1l3SQr0QNe5YehMpT7g6yRPg9Gi4KaaZ3Ij
 UYzQ==
X-Gm-Message-State: AOJu0Yw0Rh5XL+99eMVkPIir0br3lfG+mQAwS28LNIPhAt/oV/Y52SNx
 JYRw3oE9G37lgmi0aGYvL4Z4Z/BRXy4/6dC7pIGXqt2CG+p7H5+pYYtPIaEQR35R/yXKSyaU8NA
 Z
X-Gm-Gg: ASbGncugfItoLbIaZZyqXT4QWjmbQarvKUuezn1zJZwUIh61PSSDpy8w4w2jQhkdNTo
 4zDPGwib6PwmWw9/NBDrNhCkRTeCChtEq7s9mdsnjk88ZW9Vr9/7/iR7qBNFRZfqU2SIxFPFMIW
 NuQLAjRb4bdASrXAiAIF71jvxxiUqjxH8qUBj0IxV9wblJVsUqbfPD5/0DjC0TOMFDG/DY+NRLD
 wGa4zIT8rxsbDoAQ2H94RrzIJsHCI4fnbLGZQQoyXv9rMStHWzXfxp7KD4efmKwPnx+7+mQwh45
 iseCgvoeUGtQo5uWNWQ+FmrBB8JdB2OnyYDHKSQAozq7hIpyPp33Nw4eag==
X-Google-Smtp-Source: AGHT+IFuZkkvLhvbifH0gMAGjzLHhErPcD6Qdlu4ZL+mDbQqJ2kBjkcLrWJYxPyAYfHuG7M0tSy1Tg==
X-Received: by 2002:a17:902:e552:b0:216:2bd7:1c2e with SMTP id
 d9443c01a7336-21dd7c664damr3177825ad.18.1738091619369; 
 Tue, 28 Jan 2025 11:13:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48e6642b0sm8761592a12.13.2025.01.28.11.13.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:13:38 -0800 (PST)
Message-ID: <7b8555af-e7e6-440d-9699-192889bd9470@linaro.org>
Date: Tue, 28 Jan 2025 11:13:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] hw/sd: Remove unused SDState::enable
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/28/25 02:45, Peter Maydell wrote:
> Now that sd_enable() has been removed,SD::enable is set to true in
> sd_instance_init() and then never changed. So we can remove it.
> 
> Note that the VMSTATE_UNUSED() size argument should be '1', not
> 'sizeof(bool)', as noted in the CAUTION comment in vmstate.h.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/sd/sd.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

