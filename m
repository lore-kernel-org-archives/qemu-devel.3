Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DFAC52D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOAu-00009N-DR; Mon, 12 Aug 2024 02:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAt-000058-8S
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAr-00023Z-NG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so26950515e9.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442696; x=1724047496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mjNI0yWKo+o5MJ6/m0CUt/LMCK9rawb97GerjSIFlOI=;
 b=F5fhlOO7vtnvA2J5lwW7qlfso0USJpETyvBdmZObMccRay8xC220Zgs3NTbNEWn12c
 f1MmuARCc+ZRetVMdl1T7ZHoSQ7buIUSSI05QZbc4SdaliR5V/oL1HRUEe6QxD6wArWy
 kbkzoP+8YDl7RM+PYe5k6IbSiGnnuK6aXJhWBhgAO97FOerPioKhhuEkFYDeTbJXQTkZ
 GsuN9dsDrt97dgHaFrJR+TqK/F+SWwgNPiwwqnLiPKDpCerU8UMg8lRkvm8V6JMcriOJ
 FeMN0qQ6YmI2FxSOxXkykeSOkpT8rTggwWbWrkiM8yxdO1/n/ygIXz4iC7IIGfLAKRI4
 /1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442696; x=1724047496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjNI0yWKo+o5MJ6/m0CUt/LMCK9rawb97GerjSIFlOI=;
 b=j7ZVj8D8BK1KFqhH7jouAgfWGMJkUfcozspKtIPGNSbUN5E0vHAKuNK0ZBsxXyI+2H
 GhJrYfy5FhDSZj1vutSvS58a//O2pbDSe7vGkS0ixxnLiOx5p1nskAybfmfGu3UM/nMA
 4OOeT36yhcEAMYyDqHqmUI8pe/p/w1zozaSXjTjuh4antF/yj3YqeLp7Grid/B99fxv9
 w8HUHEZhAFZid0aS0unAND1XFSGv7uZKzJ9OW4DOnuulBQjE7Kd7ycIP70QLZBZrtQge
 PbPlw6nU+FtK0O4fVhBU0TUvPxNBBzKhju2rQk6KQWwe1voTWPBOwRl/DZtsL2/GdEj3
 zY4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvtopFp0EhwbweDlsuvjz8ZNDjDnjBLQpRRhJPSTnxCvSdTR8Z7dCobuy+Algg8C2fMrvOo+sHrITZxA2sl9IOFvtO3vI=
X-Gm-Message-State: AOJu0YyRyBmr89zFvMpyi/tF2GIWBWofaY6NMFQ5RW+25kxogTh6iSn8
 4WvnILoCSCnrGmdjUFUdnSqGgLaxcTzLiNymAXqFw4OQoh450cLKYmCNKUU1AuE=
X-Google-Smtp-Source: AGHT+IHCscUB3ceQZVchpVaw9+7xEk4XOM/DFwkMLNOfrlXCh9v/0EPPBSK9c+/Jhg9IjI31gw/dMg==
X-Received: by 2002:a05:600c:450b:b0:428:10e3:a000 with SMTP id
 5b1f17b1804b1-429c3a5a146mr56178565e9.37.1723442696033; 
 Sun, 11 Aug 2024 23:04:56 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:04:55 -0700 (PDT)
Message-ID: <60503baf-d3cc-41c3-983c-f7868fc4f89f@linaro.org>
Date: Mon, 12 Aug 2024 07:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Use unit not type in decode_modrm
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240812025844.58956-1-richard.henderson@linaro.org>
 <20240812025844.58956-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812025844.58956-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/8/24 04:58, Richard Henderson wrote:
> Rather that enumerating the types that can produce
> MMX operands, examine the unit.  No functional change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/decode-new.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


