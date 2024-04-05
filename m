Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FFDCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj35-0002ky-QG; Fri, 05 Apr 2024 08:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj2x-0002jv-0R
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:51:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj2v-0000Ux-Ft
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:51:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-343d88460cdso771524f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321512; x=1712926312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YtdvEey9oErmRObuSvYRhzIUbokEkyu8f7TaDb0AGw=;
 b=ccDi5OSWHJRM9Z7GfXLHka7EjsDjZZuCmuOj6l9dDufVXJZWeFIWZuiY8VwzustuPL
 bHRsA4Np6x2Fo4dk1RWRp15ewtYGx7wsM72+SGYla7b47jE9kx8sMM8brB9hMQoykQqo
 W2fkzqLZIOvoqw2B+aMUEKTRB3VGAnk/GnW1mzbY9ixWdGi2tqbdhJYreqBYlqPn4wE7
 +Sge7aQZXZSN5ki85ep6tkSJd1AtZZ8j6p8qNwfuiIUHPU+uHONlL1pcsymkhpbVIt7z
 G2UPHLz8QtjhMU7zeq770/FUz/tpTa/EJUPeZYz0iq2UGUXFcqQOcYMC8k0usOj0sDCm
 tetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321512; x=1712926312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9YtdvEey9oErmRObuSvYRhzIUbokEkyu8f7TaDb0AGw=;
 b=MneZxnSk6nrh/DxMybdpSLHfx5P7lzXcnTYqTqiDA2gcJJQVmnk1s8ofbeS0h6Lyjy
 Cf0XCxgg0rhT/gJwJUjbn+QeQrh9yqHakf3CzFmwbSHA5YMvIQ5t/Nkh1H9wBBVqYjwZ
 IzLMdR2uw/O9mOSaUCfXdV5NRZJ6icIZ0d7g1fAUW8wf9NaSm8IbyQ7UU2jvrY6bJQek
 IjgT7PMZjEm+w7kcxqz/1kbiUR2bDDowY6azxM8A/M0g1X+DwfNaYJ/BKlFjSQHKe2cz
 PKnu4ENw/FEGEZcrg7923iMXxcQIrcz+8zOqzPL6RvW1wbsKzAipoQj9NRdRcq8deoIC
 QUWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjlknfp+lF2aE6E2LvOZAUFwROvzwmaXCbE9qqyR2DgFzYtD6BYA2kMaYz5xXuIwOEw3lhKk7Vo2qbhJbiwxKDlgQl1D4=
X-Gm-Message-State: AOJu0YwXwYkf3mYE1MRCN4ETuojxrzYA6pU6UGMeWJcMhL0VpwuYm5rS
 PX2aeCoWpgnStWDFyK9IKmex0EflTgxYayhQK6dcJ324WsNfXhJo9Zu3DV8Mw+U=
X-Google-Smtp-Source: AGHT+IEypBR/bol8Do+8OyWGPC7wBxYmTViVaNZeYfwHyBcsgs63TFVOpcOH6NKT8SPW7FjKqxEC5A==
X-Received: by 2002:a5d:5708:0:b0:341:bff9:2e4f with SMTP id
 a8-20020a5d5708000000b00341bff92e4fmr1104004wrv.44.1712321511954; 
 Fri, 05 Apr 2024 05:51:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 n1-20020adff081000000b00341dc343e21sm1972577wro.65.2024.04.05.05.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:51:51 -0700 (PDT)
Message-ID: <918854a1-2948-4a10-aa7d-c93120a08f49@linaro.org>
Date: Fri, 5 Apr 2024 14:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/32] target/cris: Use cris_fetch in translate_v10.c.inc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-29-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/cris/translate.c         |  1 -
>   target/cris/translate_v10.c.inc | 30 +++++++++---------------------
>   2 files changed, 9 insertions(+), 22 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


