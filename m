Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70E9E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MXQ-0003nQ-1F; Thu, 31 Oct 2024 00:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MXJ-0003mo-A8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:11:53 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MXH-0005cm-Fo
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:11:52 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb4ec17f5cso3617931fa.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347909; x=1730952709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUwY95oUc548uEZ+b9sWEnJz9KpDia36DnB6rJhef9s=;
 b=AtWAWRwWecciyeoTNNkkjIBkwzBEtZTw8Rc6UcP96TlKeKOSPmp4SS2lYCR4fvbRZ4
 taG/aL2sCnNaUIZenrDQsMpBIX1NlmM/s/uaK6+WWQvVi/wZrn6T3AAN6w5p5KkQOZlL
 j5WjDWgZqUYc0XAlhqOPt6wR3xyCZomHcTTXU1xZ+zmN6gXy8hGSTgjpvmh7RzHk1tM+
 ly2uM7LuguUMGMhGg0bSXWh45EbO753I+D7pciAEj/8BeXcmsl9IPlESWJy+Y/eQLkhW
 nettLcB0b6td7gaBjrP9qgxDxSUsJ/Q2zVelSeCLHUTHlp06zsUMXP1I08iQvZJPhyA1
 0+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347909; x=1730952709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUwY95oUc548uEZ+b9sWEnJz9KpDia36DnB6rJhef9s=;
 b=aBSbosCAaUQrZnXlEVEuBAx7MF/OR3O5e6ayPBYJrURuSpZdAst1g34/aalvbCx1L1
 KUHxdk2JtOYCCqltJGFWtb/ZAsMBZsNiBxE46JC1gKtFnflkB1L9I63n4wmnlQoBb6HQ
 fmoMoPEq1Zi87gzzm339+HNMiCFsbv1KRFwsr3CF3BLmRd+GEteyEYChBGkwXe8tackQ
 y4q0IendEKzi6QW7inlcppSrer+zQ9jQArpy6FGqaOnceMCNcxfFfhsm9ia1H/Lk2f7T
 JGF8W7T9eMx+IMMm22EpglJykf32fFliatyr667Sl15Z/NFQAuG3n4+E8uHDEcHbLIWt
 s4fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDmGk2ehK69gpRfNTrllM1+J7m2dVVAP+xj0SEWv9QzzSRMkg/fL8J0jVjuRbk4KK/KQtmQCndMlEX@nongnu.org
X-Gm-Message-State: AOJu0Yz2Hjs484Vbp0ISMFO/SrvlhI7HHqrVfUZlFMexz12SK80pbhvZ
 3R2lxPwAE1X2TPwaG4sWXOphTkO/uZLxP8hXfuev6TiAabAUvImfkWlHy+wnHks=
X-Google-Smtp-Source: AGHT+IE7Yme7AanAaUYSzsFJaLtpZdLnQlxXCVhTCYCTL/6PGjEyGgGgrXLUDczcjtlhQkWlBqEUoQ==
X-Received: by 2002:a05:6512:1149:b0:539:edc9:e81b with SMTP id
 2adb3069b0e04-53b7ecf2341mr2952005e87.28.1730347909328; 
 Wed, 30 Oct 2024 21:11:49 -0700 (PDT)
Received: from [192.168.21.226] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bcce69esm74074e87.157.2024.10.30.21.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 21:11:48 -0700 (PDT)
Message-ID: <d784e3cf-18d4-4c67-9977-88aa2018d77c@linaro.org>
Date: Thu, 31 Oct 2024 01:11:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] qga: fix missing static and prototypes windows
 warnings
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241031040426.772604-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 31/10/24 01:04, Pierrick Bouvier wrote:
> Reported by clang++, but not by g++.
> 
> ../qga/vss-win32/provider.cpp:48:6: error: no previous prototype for function 'LockModule' [-Werror,-Wmissing-prototypes]
>     48 | void LockModule(BOOL lock)
>        |      ^
> ../qga/vss-win32/provider.cpp:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     48 | void LockModule(BOOL lock)
>        | ^
>        | static
> ../qga/vss-win32/provider.cpp:531:13: error: no previous prototype for function 'DllMain' [-Werror,-Wmissing-prototypes]
>    531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
>        |             ^
> ../qga/vss-win32/provider.cpp:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
>        | ^
>        | static
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qga/vss-win32/install.cpp   | 6 +++++-
>   qga/vss-win32/provider.cpp  | 5 ++++-
>   qga/vss-win32/requester.cpp | 8 ++++----
>   3 files changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


