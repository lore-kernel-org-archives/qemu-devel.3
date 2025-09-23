Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7CFCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zBT-0000io-FA; Tue, 23 Sep 2025 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zBS-0000iU-4M
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:19:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zBO-0001rP-Ir
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:19:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee155e0c08so3340445f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758619172; x=1759223972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5LiBwddV5rgHDg0rXDL+LIfHgY7yaGBNd7if/UA6464=;
 b=gZoKOdtppx+/SLc1VoVThBcoOVPra5JLdZJISdkVs+tZ4KNKVaBHUdOxlpWh0vp7eU
 aVa4MbNrfQdlKX40SeOQFYSZGHueR4NJVG0VhENAn9E8L7R7WamaKRoWWiGzQl1I9YVq
 VgBJHqH+D2kvIfmWV8iowpWIpkbsxInNVGXFk5OCR2AvxfCzI1aSf1Hy3SjFCOlwy0o7
 nMVTveI1R2jW6g4BfnoLnh8wvl26zGyK7O15nY5SyTrMJ6l+/mXzXDFKHvgeoowN5epj
 ApJgDTLeoBBrUHARS5dJYGKDIwlObp1bZ/KwuCqODaCPuQ5GsTFWYxklM4S5qinVPxSZ
 mgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619172; x=1759223972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LiBwddV5rgHDg0rXDL+LIfHgY7yaGBNd7if/UA6464=;
 b=AddR7SsoQRsNfrbJtv35NMQNbJarlMIx860xXGtfLDGSFQZGSNrufj0JAIK/yvkSjv
 0uqAmm33TKo5NB1yUWxzoxWgMr7beKXzaLLCIYBhLM0tJqfvW9v4bYmAYfnB/cjOlU8d
 X0tuTF3lUBcB5veAntPc9ewv0EJr0QKbBcYXud3Sk2W4DaCQcDcWofA+i+I+zWFlUkgY
 5U88cDku0MRMSnJSH59GAo8RIBUde0f7pY1ydYe8N1QfGCyUaOgg9X2j3k6vG1jprvLE
 ieIPdRUfdI8V/2UPb9fzQzYNH+cXMqAr/Lt+VA22AR7xemoem0ekEpUpKnXDZIokyDNa
 Fj6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLTxzkU2JG2lzrg+Evp3gWR3NBHxNE/9ahYaFaZEU80QMa4pJQq4ZVOyRf4rfzSXuJNV1wmRBKbX5E@nongnu.org
X-Gm-Message-State: AOJu0YxYTh5vnITm6CcShNcsLGIJC/gZstln3KXP39/76ntQaYX8PSSZ
 b90/GOxWHWZv/BHgODWheYAS9dO3UNyKsSqhHHhGJ8Nps2y8aPamT5/4tYSz/H1eYaM=
X-Gm-Gg: ASbGncvDbMEB0JysSqBuDH2Tnxnf22D+KpPKG6ud5h3gI7zuksnFdpBk/bQhkCkpus7
 LAKDT+L1DNipCB2DvmCE7th284Cf5sy3DNainfjYeWdn4erpYHJCKkSXNtDEE6Ig3/TbnGkdw12
 QHfBQE6SOAUYJhsl244zBGHwFkiDS/OlDOrEwQ2vHWFI308XWe8cSX5bcdaG8JUi0OwMSoQwIkV
 Gv/HHUvQk5z1sUjEqH+0GmronEyGLY0Lh7h0watsqVPg2cxtxzsN014BMg9EefqvMP/YquI2X8V
 yhES2bA6rpIn+AYQoI9UgfjReM1NLNWTkaKz/2hSbuqVNrOLE3vx9Cc3/HXb3kjGf3iZZhFcXg5
 gR5DBNRy9Pu66oDhAkev0knJMe0D8nTuJGPRshTgav3psRIzy502oEdNzakh/SXo8Hw==
X-Google-Smtp-Source: AGHT+IFou2fEC0PCUdmCwZi8SSfGeQKi4KS5Drq6X+0Bg1ZD3BHFdJAYW86AnPHtAvzu1l6xc14b+A==
X-Received: by 2002:a05:6000:200b:b0:3ea:bed8:7040 with SMTP id
 ffacd0b85a97d-405c5ccd01cmr1528056f8f.25.1758619171537; 
 Tue, 23 Sep 2025 02:19:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee1227cc37sm21619858f8f.7.2025.09.23.02.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:19:30 -0700 (PDT)
Message-ID: <fce010fa-c42b-4d18-91d4-bd2e4d178444@linaro.org>
Date: Tue, 23 Sep 2025 11:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] util/oslib-win32: Do not treat null @errp as
 &error_warn
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-9-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923091000.3180122-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 23/9/25 11:09, Markus Armbruster wrote:
> qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
> null @errp as &error_warn.  This is wildly inappropriate.  A caller
> passing null @errp specifies that errors are to be ignored.  If
> warnings are wanted, the caller must pass &error_warn.
> 
> Change callers to do that, and drop the inappropriate treatment of
> null @errp.
> 
> This assumes that warnings are wanted.  I'm not familiar with the
> calling code, so I can't say whether it will work when the socket is
> invalid, or WSAEventSelect() fails.  If it doesn't, then this should
> be an error instead of a warning.  Invalid socket might even be a
> programming error.
> 
> These warnings were introduced in commit f5fd677ae7cf (win32/socket:
> introduce qemu_socket_select() helper).  I considered reverting to
> silence, but Daniel Berrangé asked for the warnings to be preserved.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   io/channel-socket.c | 4 ++--
>   io/channel-watch.c  | 2 +-
>   util/aio-win32.c    | 2 +-
>   util/oslib-win32.c  | 6 +-----
>   4 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


