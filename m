Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ADED3515E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rju-0005Nk-EG; Wed, 01 Apr 2026 05:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rjs-0005NZ-Gl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:19:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rjr-0004c4-0T
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:19:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so79150825e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035189; x=1775639989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v9u+xQ3gscea30VYyMGdUPpT7D2HC38BGGL++BJoteA=;
 b=QXXnjpgdu8TcLU/UTzNb/+91RUEkRDQ0m4uMgDlIpMzP9bbrGNGT3BGwgo4xfLVqp2
 q7sG+38fvUnkRdtNnbjzmtHA1A9RJFj4JUOuX5zp2m/yakcc1JD6iyBJHALGFRGoTF1E
 ZodBBpXO6W7SEmfg6OGBS2dnPA/3HzS5DaqxIwZMtMUKfcDi0MTIDfFHRVu3zpkzSVZt
 0LhDjW9I3D0ksZqzfqHBk09Mhq5VRj8o+ILmnL0TouQkeRvLkRz93WmwNS+U5IuC5CjM
 WoYQqlqeqk3I226vsBN7FHwagp4saw53yWJKrsSM4KVgR5HIe21Bc0v/M7plzhK8My4a
 GJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035189; x=1775639989;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9u+xQ3gscea30VYyMGdUPpT7D2HC38BGGL++BJoteA=;
 b=kRI72aVApd/YwZ9m2yv5xgeMf3MqnalfJt8o4tBTL7yr/YUavr/+b18TYA86hwxVBc
 4Xz2XZ3DZR5a0ZWt0FoGKAkzLVMfOPLd76YC1hzcvUAXbTmKI/d1IxsQYrFS5hnbhw8M
 dfmAIRko3zHFcMcsILDEWJOHG9TyxpEX91tISU84kNy+fP5mKs4JxA2lJS97rLVEZ+tn
 rVGamSckvio+TD0V01Z8Ha0z306am9nPc4YuYds1yyX2zDNOg7KO1kOMc1ijA9Kr6fkF
 6MPpoJrqA4u7wqxF5Iu1SR6YQE66KA8h0pPHYVmN2T0gC79brME6s5/0wpzUftLXktMJ
 Euew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjeoIdr7KmcK3iFkrhn5jz3cTpl9+lErZwFw3T5zqHcEAOuWZYHI6tHcL8lZFP/0GO1HKP3BPlnUsv@nongnu.org
X-Gm-Message-State: AOJu0Yz2pE1Jz8IUbHTFM5KGs1scv96rrlptxrtoL0rYDAcYE6kEZ8hr
 mORf3YZSo4E4R1Tg1S1MXg7c+0t2N8BAojsQciJACR9vBqn2I1dvr4w47VcfcalvsKQ=
X-Gm-Gg: ATEYQzwz/4R/o/BlNgVfX23mQ5edAWsa+tE0lzDDPzEieA2ZmfZ1IHKG51yCOETF7Wt
 JDWBYGE0QpQusGvJHXo3L8tLD6kKl7G+I+dc916EaM6uV/D1EebufoxjaiaLJvnxGo2XbcsPBfF
 nUeMT4AkiOXLhWQ/CD7aDTVVN04V20hGojY3DFqcNRz+pw8C8wtFuZiKrfAj3pGt3Lk1gkajBvM
 5YYW/o4R2vOFvTXrTPPl3Kmr1Rdk9z0BytIs5fBZhyafDt2LfNZRUavJvZUr+/AgBFKHrBJ0fpx
 jh9BQm1XuCwFY8t06eESsRgXKKmc29+U0UJPVtiy0Rdg2a4bHels8hrvkrOqQ9aDfYIS0BX1fyh
 Jv51HH7mazyU0KQ/wqgoZM2nGTohLDQC0Qu0+1e3NDi+WgrQCqkKlDzsgjsq8sJNUzj2Bgb84lb
 BR4NdIIU02n6ej/cCvMuw0TjPFb8hvOk+bMzquHuH7Wx1OtvRDKqTLGOdH919aKrMjWw==
X-Received: by 2002:a05:600c:5304:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-4888358b6bemr47087785e9.17.1775035188857; 
 Wed, 01 Apr 2026 02:19:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e72da6csm202607995e9.0.2026.04.01.02.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:19:36 -0700 (PDT)
Message-ID: <c1bd66b6-0bf1-4dfe-abb7-9e9d7bed5707@linaro.org>
Date: Wed, 1 Apr 2026 11:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/60] ui/console-vc: console_scroll() -> vt100_scroll()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-23-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-23-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> This decouples glyph rendering from the console object, continuing the
> QemuVT100 abstraction introduced in the previous commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

