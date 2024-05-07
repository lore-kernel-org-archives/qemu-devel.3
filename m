Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB5C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NVG-0008Lb-92; Tue, 07 May 2024 12:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4NUt-0007yx-8L
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:16:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4NUo-0008Dc-6J
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:16:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so26661965ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715098608; x=1715703408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPrlm9diuhPkoGOG7Wer92IB6sXYn1GaYL0f6X5MsUU=;
 b=QBlY17ZQ/I7PtaxogR4+rTfjOk2Xv9LNR3dcfb3t2YoXdA8UctmhG1nNukYljGtTZK
 T65U9jPjJTRYTCqH87GaUrdgQi9xQXPi3BrH8FoPCUDJecdY7IaoxXJZHR6kuxOEV8zE
 fQ82/4LEzUeHbj+lLxnlDtTI5d3oVNiPdyYoJfj8It3jomvTJWsEt6LdeZY5ZosAoBdN
 Z5uQOy5WmBuKy5GKjufecziyKeTU+aRREvpWeLI4E0mkk77uUYbnpJP7rXQBXf9oUrGm
 zfu35IzI1qNiF25AgxrzK2phjGFdYRa+VT3X5Po2xvJsjdsYD3rfoHM0d0bdA++qiQ8z
 bQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715098608; x=1715703408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPrlm9diuhPkoGOG7Wer92IB6sXYn1GaYL0f6X5MsUU=;
 b=fm/BiryJHmgpjmpQAwD12XUySJ6b3iLI2gaiPcgeJJw6avUTB+rFoDSfoUnfrNnVBS
 r8UHZy+Sodw2FavSV/WOhhA1ifat2RblpKSJfYtHyNd6rK+Dw8J63maCBZwKJFl0Sgo2
 hStHAyHrb4OE4WeXxDq4jkYDh20p54IIMFRCT5NtvX3YSV8XYIUz9Co+WNvyOr3rjIcr
 BihBmjA7vjpi6yEFJ+qGdFstaCcIqf4WhgmafBhmDBAJ1LQm+tsad7DzHE+Ybted0h6l
 Rzk8oS23tsmXPL/Y40U8zy0CNy6rxM0v/3XzPFoird9gBLTVLEfXCrJBPFa80vJ2Fn5/
 IXXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnUofdY70Gb3cQYf2QE8i3If7Fhpcj3tw8ZQwPOXQNMAK5pj9LbEFg7+Sg1mxzHt1cVYbNqjGgE7Ga33UIVXnexXDV6E4=
X-Gm-Message-State: AOJu0Yxf5eNR6l2JZBFEe0WNKBI6GBkTruM2BOgY6hdMOJ6tnRHANgzE
 XK9Z4wddE3m2XCMvRNvw+9FbZk8QFCYgkrgb8FCdko+x4SDZR7lqmSPiOCP/WN4=
X-Google-Smtp-Source: AGHT+IFUyq9sBoy1WwhC7RZxFJHStQHCSY9Lz3/gURKNYCpUcADfUooJg4moy5ZYlBbpQZEiBMa8QA==
X-Received: by 2002:a17:902:d2cf:b0:1eb:7334:1228 with SMTP id
 d9443c01a7336-1eeaff8bd51mr1368875ad.3.1715098608334; 
 Tue, 07 May 2024 09:16:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a170902d48c00b001e434923462sm10266346plg.50.2024.05.07.09.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:16:47 -0700 (PDT)
Message-ID: <74c2db17-3f47-478f-8379-6006ff94dcb5@linaro.org>
Date: Tue, 7 May 2024 09:16:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: Use QEMU header path relative to include/ directory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240507142737.95735-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240507142737.95735-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/7/24 07:27, Philippe Mathieu-Daudé wrote:
> QEMU headers are relative to the include/ directory,
> not to the project root directory. Remove "include/".
> 
> See also:
> https://www.qemu.org/docs/master/devel/style.html#include-directives
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/audio/virtio-snd.c   | 2 +-
>   hw/rtc/ls7a_rtc.c       | 2 +-
>   target/i386/gdbstub.c   | 2 +-
>   tests/qtest/nvme-test.c | 2 +-
>   tests/qtest/ufs-test.c  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


