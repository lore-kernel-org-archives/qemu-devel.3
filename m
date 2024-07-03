Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9FCC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 18:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP4tX-00018R-UA; Wed, 03 Jul 2024 14:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP4tW-00010A-5M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:39:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP4tU-0004pI-JV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:39:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb1c69e936so5885105ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720031991; x=1720636791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VYbAReiqzHTKFj8yQuKvBVBE+1tfSrrDkD9uZs+csM=;
 b=g3ARCZgtMQylD4Plwev1lC2vGcyWMiqS6Q6KRkLRofyd8GCbYpA4Q0A3tjl1kd/Bd+
 k8gFPostq/Gc2CyQKJYf3pZntK0yh3XH0wX/imqN5KPO7eLvZuy/JwtFJ+upv4L+v9P/
 kXwdqWpK9M/i1s2J4Md6hDGbaQy9iZJEigBJfTT5xEn+9oPBrp/wUPS6+jLPm2ZLozGj
 kZcP4QdcrGKu2sKix2JjE+TtYUfltaCXfsvMjZlw8jzrQgstnWvdoUPXltPW8kPI3vnF
 gfTWpKfaVLOVNj/v7W3B2aTwkO6a0Ai22326BUyORXFcWA4gBNojJIzjduckYzArzHVC
 b8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720031991; x=1720636791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VYbAReiqzHTKFj8yQuKvBVBE+1tfSrrDkD9uZs+csM=;
 b=PnKTGaMWDQAcqwuIG2r8EXCj2vrs4Qpo8dlBVvxgO7d2KhmNyhfNf6nGVAfAx42Ybd
 3Zc8pQyAGd1PWREh91Jb+J5pMH3eGVerR4dagtKoSOamkZcGuF61WJOFWmh9uAkgDohg
 5Oo3SuRue2az0Tw6D+uU27h/+U6btswRHY/x92vYSjU7cmUIsQTghVC1NZXcz8VHNJUW
 Zs+jUUpsgndQyP2f97GBW44x21GEpijEHMhdG8GrF7w1dwOIy84UjhZ2nQ+NCNZwYTHA
 chlS77qSGnaXcjn2I2P8jg4ypH9oiKMVgaDOQuu5ge8/E9BP50qxkEIf+81Kmm/dFaJh
 6+3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU13skS4lHP6pxKQpBNpsjYDj7iDK9aCw67XcZF/4X6MCrtfcT1/pVeHbZMZpVKnQutCaq3F8e4cHFgMMZ+QflCMA1hiso=
X-Gm-Message-State: AOJu0YzNWYMzbsoGCvFywtWZq9KmnJZQriLZQf4Kbr/Y6ghdNrLs0sao
 GAE+/QFVT74UgwY/oRgIFc/vRYMdQXhnyjOVpJB0S9Rm6BrhLZfFtOZYZR+PkMU=
X-Google-Smtp-Source: AGHT+IG/dPL4XVjFqCuM7T/L0bxeoJ82S2vqf0yUnxBVmEwVNAu808poel6bR9O3S8kG/aRbAnuqDw==
X-Received: by 2002:a17:902:d2ce:b0:1f9:d2ba:46f5 with SMTP id
 d9443c01a7336-1fadbce6563mr83534215ad.54.1720031990860; 
 Wed, 03 Jul 2024 11:39:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15966a6sm106651755ad.257.2024.07.03.11.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 11:39:50 -0700 (PDT)
Message-ID: <19f7a972-049f-4796-9154-0fa410e05b48@linaro.org>
Date: Wed, 3 Jul 2024 11:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] plugins: fix mem callback array size
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702184448.551705-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/2/24 11:44, Pierrick Bouvier wrote:
> data was correctly copied, but size of array was not set
> (g_array_sized_new only reserves memory, but does not set size).
> 
> As a result, callbacks were not called for code path relying on
> plugin_register_vcpu_mem_cb().
> 
> Found when trying to trigger mem access callbacks for atomic
> instructions.
> 
> Reviewed-by: Xingtao Yao<yaoxt.fnst@fujitsu.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

