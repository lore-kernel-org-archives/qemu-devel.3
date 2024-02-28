Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E8FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSXF-0007sW-P3; Wed, 28 Feb 2024 17:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSX9-0007ok-3X
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:36:16 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSX6-00045B-NL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:36:13 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5675f2ca2so164930b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709159771; x=1709764571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlL8AekY0UevAqImcF5nff7B6rFV742Bvz0lBpHCmic=;
 b=nXv44+L1bmzRjcg2Bz555R6jCGsJ++MFzAGabmbVRawx6Gy2k5q6Df+0UVOZZd6D4U
 G6a1k744+PBffncf9U5m44uxvnah9jiU41h30tXSDB//dt3DoVq6gD2qHEJvKUSpiCIL
 Ngtrc08v4SaINhpTw5m+6pgHjy8dygifxbmUn7rR+fpl1RysbDQEMeChPjj6DUUt02ZG
 qKBxfjEGBo4n/xFgParL6eLkgpSLyOAmSPm+vRhU0xxvGxYsHYts4B4dxeoIYjuYx0un
 rvUdir3R/FIufXfuAmOSCOGYlqc/mkcOaomdb1GAeJf+oH+s7cHLIp6mrZd1lIoYq2zz
 50ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709159771; x=1709764571;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlL8AekY0UevAqImcF5nff7B6rFV742Bvz0lBpHCmic=;
 b=TVv69WX7onpbkzYg76MAwEBP7l/JdH9+JzpBYnjHHurAU4/xU1K7a/JhT+fcJ7nrlM
 0gppPoktznOGapz5FTj+OCYqCSzDo5P/IKioiR0ZZv5UAKtOMcOgYb8FfKQXtZPaqBH/
 nFkw997ypsjltGHBOkA/7w/3bGnF7Z1fYt63TgixnIROkaqYTf17GfI+pcmMzeD17TSQ
 UiF/jfKMvJoRVqjAeyavxfv6AOBJeS+9Ewq7VejwNTt6t7ipbSIA46vEH1l3YaG997BW
 txCzLTVIfYbR0dkXn6NzH0jR2aOGZ+k0RMyZx3vAAxawTsj+Dkft050vyTrNMhEWAGG2
 yQwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfM80aqRr/1j2nwTpf7aJWRFQgR0INqCG3XH0exrBHFlMXMINWfiYAZqwy86+pvC/sfixNWfPHugoQLf6BO9FXyf9cD8g=
X-Gm-Message-State: AOJu0YwrgzfARN+ik8ZOGyIfZOP9kJ7i6l9i53rXLAFbG4r0rcDH4otX
 KIM4vaW+vbansgORJ3qg2DKhtZtJKfJVXxZ85MtdfGm20sEl5bmj7h4st6Nl7JI=
X-Google-Smtp-Source: AGHT+IGvF/TJJuqYnew20KzcxaWWE9vQbNsmvkwVtOD3WwRexk5E4aG47ohXsizGhiAX/nsSEIhXHQ==
X-Received: by 2002:aa7:8507:0:b0:6e5:6120:287c with SMTP id
 v7-20020aa78507000000b006e56120287cmr502174pfn.26.1709159771036; 
 Wed, 28 Feb 2024 14:36:11 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 m5-20020a62f205000000b006e56a599acfsm194422pfh.194.2024.02.28.14.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 14:36:10 -0800 (PST)
Message-ID: <b3d6c328-feb4-4e76-aea8-df4c367b0921@linaro.org>
Date: Wed, 28 Feb 2024 12:36:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/i386: remove mask from CCPrepare
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228111151.287738-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/28/24 01:11, Paolo Bonzini wrote:
> With the introduction of TSTEQ and TSTNE the .mask field is always -1,
> so remove all the now-unnecessary code.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 81 +++++++++++++------------------------
>   1 file changed, 27 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

