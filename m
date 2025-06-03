Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA44FC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPZU-0005DS-Lp; Tue, 03 Jun 2025 07:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPZT-0005DI-Fa
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:12:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPZR-00042S-TY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:12:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36e090102so3147302f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949159; x=1749553959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4tmmwWfacUcyM+hSbuy+1JhqfaP2nJVt10wYFCXcJw=;
 b=ETYHZ6BNUotssJ0GVWsX99hN986aSUH3OIJWZ/t6UaXhifOhnqoLoVZsQEqTMDdS6S
 xX2PqYH33XBNRTqc6TJCqz8k8JaUNId4yNuLixZ3QYeGdxQA9yomx0+e6q4e9UfBr0Kb
 gfCrq6Y02kk4ZGrtXi2He8Ts0hnNYsHWtVh6QOMK/YpQbVL3qpNTdfDQqpQhE/c4dsoS
 O3CIMorn4U7y9VH3kixuA9qi2wOGC1w64L2953X0XPO06zjipBPdk7+ATpXLPviOUrhb
 uutXt9M5BQKp7oc6Kw47EET47S1FGjMScuG18IG/k50y0I1o09RydChNIv0dOqAxbQd8
 6Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949159; x=1749553959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4tmmwWfacUcyM+hSbuy+1JhqfaP2nJVt10wYFCXcJw=;
 b=P0uYD4doP6dw221uNl/umFPOrdnLuexGgYy+rygPZ2azpWv6+Ym2cll6+e+pHmGqOE
 Hw9GbvwFeIU/wY1gDoHSYyioTikqP1zDCFcY2W4VHK0tcaqw5pZ/MlJAyVqbP4qUrbLN
 r66z66/gAUCcomJmSXOAfwWrx25qlniiOB5knOTmKkh3Fd4CyEydNekg+RJPuVVKU+4L
 hfKUn+WYnbrTb1vKohR3KDbkBfzIdupVLiUaA/EfREmzWmQ+e9SzRMM77KmAkT8x98uP
 Sj5C4dWXsvFkd4xGKzXCpXn3UahCQZHl6B27D28Hk7ZAjjshAFi4AV+aH/DbioauxAN6
 QlEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmBKDZ8SXDJfGm1QjdtpkWDq7Iq/G0ryvjLnempKNwS5NrD9ByegFeEOcFQoBbyAqDTs+NpXakJYP0@nongnu.org
X-Gm-Message-State: AOJu0YzTI6ph3W8VLtk1RhSXklZTR+KOxQJ77yjQirkP+yHDs4Ol9j5Q
 eUbxvIonMPJP8iCB4OB9f9dCdZIt9uUHs3Lw0rp+M760MiAiZ+CgnU0SJZZVRnda+mminbqfjG1
 qpMX9ylM=
X-Gm-Gg: ASbGncvvEn50zIXG9wlCiRymEI7ld12Sq1mLxz9wI+FmMOXgPCjCupbPJ1zLzUhmm1w
 pdJKMrDr3ya1OPVge0v/7vZ22HUOPX9aWHGTVo7N37DrvPTjd1M4ewkoqvq/090fZG/yp93kVNV
 h6pBUqKoJ/V6aAD5xkANL8gaLD4pTCOqjaX6xpBo6qZzkE8jJzOTdT38Sn6OLLTVhdCwhfA10Ce
 Oo0NT4K5X4nZVmtXZEu5KUHuHmm5Wx6rT4K+TWtnHpZSbgDolu0AXp5qpjRmLpbSDkRDd5GX5xp
 gQWz+gKhqjvg1dR7pjaRjyXvust9j+CRS0ln/y5XOcJMjJ39I+z90WQzRQqfXBdlsirl31N2ySU
 8uDT92bREYHvdfC5Ln/N7PUoKNPZfGdP+ph8=
X-Google-Smtp-Source: AGHT+IEdrIsOzl+hF3cG0SD8WZE4XDKJDfsfL6RDJJwfkATz3YBEsBj9Wkz5rQEzmESiIq5f1GeJgQ==
X-Received: by 2002:a05:6000:b4e:b0:3a4:fc3f:8d5b with SMTP id
 ffacd0b85a97d-3a4fc3f8d96mr7985347f8f.47.1748949159126; 
 Tue, 03 Jun 2025 04:12:39 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a0a96sm18136065f8f.96.2025.06.03.04.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:12:38 -0700 (PDT)
Message-ID: <347ecead-c511-4674-98ed-2ee356b9ebd9@linaro.org>
Date: Tue, 3 Jun 2025 13:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ui/vnc: Do not copy z_stream
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@daynix.com
References: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
 <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/6/25 11:18, Akihiko Odaki wrote:
> vnc_worker_thread_loop() copies z_stream stored in its local VncState to
> the persistent VncState, and the copied one is freed with deflateEnd()
> later. However, deflateEnd() refuses to operate with a copied z_stream
> and returns Z_STREAM_ERROR, leaking the allocated memory.
> 
> Avoid copying the zlib state to fix the memory leak.
> 
> Fixes: bd023f953e5e ("vnc: threaded VNC server")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   ui/vnc.h          |  2 +-
>   ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
>   ui/vnc.c          | 13 ++++++++++---
>   3 files changed, 26 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


