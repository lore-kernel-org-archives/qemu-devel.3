Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42DDC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrPd-0006oY-Lz; Mon, 08 Apr 2024 12:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrPa-0006n3-Qf
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:59:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrPZ-0002q7-8W
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:59:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-415515178ceso29746215e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712591995; x=1713196795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mb5KGkYM9AiB7AADi/yZomujyxTeo4Qgjul1DrPo22g=;
 b=R8pW2RwCfHCvfCGs/8Z3Th2+fnaU12gdM3InCefvu7WhTN11y6XFgyOb7x6eadbJym
 iRNvGL1kYgSONIHjuPC2LSYqSxxokqarXJ8d2c5afOl7cMZtR2v9FhWVVZrnXr17sHBc
 w1sPp8NG0RIq+DZn1Ej9QhjEcfnsOV8Hgm8kv+m8m9akGWBRBI/dopSLPE1oqJ3gX8X3
 3qmrcGGarZAaJa/hhWKhgJe89JqmjHYyrgi/0F8aMmSCShGgG0Iw01i1EhI9xqmweEcI
 7gnZXdOm5OS1oqztLU4K0wcK955+5qWEqSh3gzmaD+SKOjwcP9JIwf6ad6ao1rJxnSXR
 tULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591995; x=1713196795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mb5KGkYM9AiB7AADi/yZomujyxTeo4Qgjul1DrPo22g=;
 b=MfLrIFkooci4gZ1HxZSxaVkSz05A7qq18xVOFzALz8gjwexlCwXD1/BpTS7eHOGSx1
 C4o/CKdvB2FktvPN1ZyD4KsxcZMP3/fAwt0voGXAgkXfL0XqpxAQ5PQ7ykCNYdF6WlPK
 UlBIMPYmKt+u5znzh4ZdFnWO+Q0zsaIykKPaIziRK+y/kgC4H/c3EkwYyg389ovbvzV/
 1yx3/WE2aMXK37BhzNiczZkrx2EHNpkSGA/5bRIxsyGUqMIStfY2EMW+A6A85d09sBNU
 DDRdhotGqyBXV13E6ALh8GFryN5tbeQyektVuaLi9UC5RWF2JL2dP6Vbv5HJFRkLoULP
 rbTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjy8PEDo4vsF0qT8uH+Z5P5eVx0ypVd2QOUf0n8xxxzwXVTXl5z496Yye0xZg9foQjS2yfWDBSAyb+a1YBeVXiFrBi0Fg=
X-Gm-Message-State: AOJu0YxoFVqFFgrAlnWjUfLEeovvryGZp1217FwF9Oz8gqLa9FIGT4Jm
 VSwPR/WlbApXzuNJxNz45ygX6/8FhdQVPEe5AbTU8pInswnXybMsFXzJCBB6Izetrmx3iQ6EJRy
 6
X-Google-Smtp-Source: AGHT+IE0uLSpbNB5yhwJU1a5ybnMU13IhjaQXn9l04tz6SPuHwnBX5gMfdVZAhzobw8ijVlNEoeulg==
X-Received: by 2002:a05:600c:468e:b0:416:2e00:ceec with SMTP id
 p14-20020a05600c468e00b004162e00ceecmr6943265wmo.26.1712591995645; 
 Mon, 08 Apr 2024 08:59:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c444d00b00416306c17basm12625863wmn.14.2024.04.08.08.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 08:59:55 -0700 (PDT)
Message-ID: <64368c32-360a-4e2d-a2e6-50c8202e2439@linaro.org>
Date: Mon, 8 Apr 2024 17:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] ramfb: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-14-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408155330.522792-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/4/24 17:53, Paolo Bonzini wrote:
> Since the ramfb stubs are needed exactly when the Kconfig symbols are not
> needed, move them to hw/display/ and compile them when ramfb.c is absent.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   stubs/ramfb.c => hw/display/ramfb-stubs.c | 0
>   hw/display/meson.build                    | 2 +-
>   stubs/meson.build                         | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


