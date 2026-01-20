Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7088DD2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4eI-0002qS-3l; Tue, 20 Jan 2026 00:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi4eD-0002mt-59
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 00:51:25 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi4eB-0001bS-Fu
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 00:51:24 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43591b55727so96836f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 21:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768888281; x=1769493081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RuAx6vQ4eYYTY2XSLXuy3bV53HSA5ndUJ3Iigery4v0=;
 b=SODBLxH3w/2yMv8kJfzEvEu2x7C9bSgrYnRTyBQ8y9Fzv6krZ7BiqXQoZVlLBQznAq
 UOQYMr3pLCSYRwNND8NE/zMDVT+tdFgjLwHu9s26Bhf/1r6il+lAhtIU0WcKvdv469gu
 /+U5vNJDIRkg/ZVYMg65cezx/8ldlxKvDwWZzq+nbw/txbK0ZBlQtUsp6gL94boVWlOP
 Ys1ANPf6qOvKktXPSCXTEv4QPGQsfOw2BSvghlFkmo6D9r+j1fc606PnM0mXiGdJLRz7
 w6AA4tgahVLKnczZX/ijMB77E9R7uMmvX3BsXa/GDx4s4iL+YpCuRG5/G/D0K9VgCyWG
 DmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768888281; x=1769493081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RuAx6vQ4eYYTY2XSLXuy3bV53HSA5ndUJ3Iigery4v0=;
 b=qQFfR/hwUZwfDO/tPigL8pUjSBK4dle21N8Mt9Tj2+EHov2Hi1lKPkVaIbTGnYYesM
 v9AYAIrSdfPKF3vfxhL4SMkFze9BFPJ9+gMoC8Ln0zozBo/tgggYja/OtcHrVck4t5TS
 MLvgX8684fPfHgY3YJ2WYLnD97prxKaVPBeEGRXXSVnUGTkjXw5TlkCahAh8QWUXLof6
 Y/ET9I78x+Lb1L2LT3CzJBx9zUWFGCT5PZyRpwYKBOWP5n+GnM440HU7qkw2DtkfaxkL
 mus0cshyJ84SPPChCTZ2ulFBDjLi7+g+TDfc0VQ1sVF/l1J/yPzFqW3Xe6cfTP6gOwxF
 sX4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/AdTRGfp1lWXt9rcFhSkb1r6xSAYyIsyvu5Il5Ljf4v1nsu6XrhNkBBYg7X9smwkLOnjYVln2alzn@nongnu.org
X-Gm-Message-State: AOJu0YyjoqZUyczwfzx0mhWcN1Gn+xq20J6v28N6X8LEx9VuuEN/ldtn
 XEstAEOdsYaOrnfImqZ0I4Qd4A3vqyR4jNQEJVWNpa4xD4fI+CNOeHKA1bahH1QuT0U=
X-Gm-Gg: AZuq6aKqSqLU6XOy3urJd60M+wQAC5ahYqiLPwcdvTI7rZaY0C4DxgvWhTttH4LYDPd
 rcjPVuEBBtdQH5fQVYgdfCmAngq3mo82BjxfaBWTYs4F1yJ3MkHE5aN2UTdQp6I+AJTmDR0iyiz
 7nQULF+ZB1I8z5quAcnYiepMTI7bP1NABND1gSTYD5XftodfMXWpe7Sw0rALVzuHAKvFaqRquqW
 t1VlsJzZKxWoLPARJbbgW/cCJupqSTpry+XnL/DdUcN4DZpekwUsSvNHf6NghAdV+jbsjTNCcpy
 BKpciWEmT69VWMUcpZ//ViHOuIAYGQmBPfSVCqg45pn2jyEcVXpCwSOJGOeAnWeLFR4vilKgdkD
 au/TJJMNQvTefVqpPbDjrIhpcl8PPqGgrYNSxhkekGRfMeSJ5en5l7K25ZPKUi75Y5c78LD44hZ
 eQh9C2aQiz4qR4VGsGtD9j+q+5RAGbCbvtIyRIcRIv5C6nW+9wrWxbNw==
X-Received: by 2002:a05:6000:2001:b0:432:aad5:320b with SMTP id
 ffacd0b85a97d-4356a039a7fmr19656782f8f.23.1768888280998; 
 Mon, 19 Jan 2026 21:51:20 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm299398f8f.12.2026.01.19.21.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 21:51:20 -0800 (PST)
Message-ID: <f8b56912-7f64-49fd-a14c-948ca090bf26@linaro.org>
Date: Tue, 20 Jan 2026 06:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] gdbstub: Export helper to use GDB errno values
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116014612.226183-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 16/1/26 02:46, Yodel Eldar wrote:

> Yodel Eldar (3):
>    include/gdbstub/syscalls: Add EIO and ENOSYS GDB File-I/O errno values
>    gdbstub: Export host_to_gdb_errno File-I/O helper function
>    gdbstub/user-target: Convert host errno to GDB File-I/O errno

Series fully reviewed.

