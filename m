Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB5C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPXw-0002td-R8; Wed, 27 Mar 2024 05:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpPXt-0002sq-5G
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpPXq-00053B-8D
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711531565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kIUavbtQk7Cpdl9mS48XorlOtdYopB1oEVsjeFBlGfA=;
 b=Wj/Wcv24C+oBMWYevpQI2rCq5RgiZjcA1ugE6/qiL826Vapplav/vx5ftapBrz9HfVMJDe
 Hs7xK03j+G7/AP/NI1Iv16l3wYq43bytBilu3SrVLHDkUsxAIcBD7aWqbETw8G8SBePeRL
 R/qnByXhWcJqFVLkTMyhL5Cne9Bh7ss=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-tQ106v0sOlWxFyM0h5tmRw-1; Wed, 27 Mar 2024 05:26:03 -0400
X-MC-Unique: tQ106v0sOlWxFyM0h5tmRw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3fb52f121eso340967066b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531562; x=1712136362;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kIUavbtQk7Cpdl9mS48XorlOtdYopB1oEVsjeFBlGfA=;
 b=r60NanP0W1GLv2hd9QFA4p2IXCmCmysFA2JW7ahixnTNSXdD+URCtvPIb3L8exoSMA
 kdqTwHc/zz0SmT9XTgUKUX/s4VvvLmLbmpiSGFIc/Od8DeLml3aizoY2+8EXU9G5VYq3
 Zbb0Yllr8ndT8H9EYiK7sRztg2qRk9c9Ug30Kx8bC9j0q2cOtJPqiz4qnMTz5D4uisp8
 k4Cb8ST0AFDVHF35ZRGKbzz4HyX+ss+htVzWP8+ui9ipk/4Gj/M3OBLsMolrcLcp/Uqk
 D2o4V5CKEq/y4zsTT27sW8BMsZpu/OXoxtrothVo2Kp/mna5JgRRig8R+Nw/o1r4woxz
 MAxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeT8S88DgoAH5lfc9UHDiMv5Q6bZWQ0DRzY7tUiJgwFDiqCeWXrd23PZCIF8DMc3o8Df+/pcIpPxYEPRlZ5xqqDz7MWlo=
X-Gm-Message-State: AOJu0YzTqyI1ng0SNse5ThUCRL49AbIDwt7Y6uKrZHfSbPOHXdOyHm8R
 FcNw+Od+J6lvN5LCSlyRgXI5xuv38aGYBwP7cHFNng5g4/ol9vWELtDTR6W5oZuMNG8ZTuD6vnT
 3fwx5TpOd/Qv8Lv9022sFOmCIf69fDYZE7l1mJYhpm7gD88c4JcTO
X-Received: by 2002:a17:906:b84e:b0:a47:34d8:e052 with SMTP id
 ga14-20020a170906b84e00b00a4734d8e052mr3656450ejb.36.1711531562249; 
 Wed, 27 Mar 2024 02:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwrZGx9lbG0cwcB3EawQxcJDQoJiRB/9UY2j2uryqUNdvdxZr4NED4PRdhS/t8+NhA6YnL7A==
X-Received: by 2002:a17:906:b84e:b0:a47:34d8:e052 with SMTP id
 ga14-20020a170906b84e00b00a4734d8e052mr3656443ejb.36.1711531561935; 
 Wed, 27 Mar 2024 02:26:01 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 g17-20020a170906539100b00a4b27cd1c8esm2594433ejo.120.2024.03.27.02.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 02:26:01 -0700 (PDT)
Message-ID: <8cf13d4d-0b1a-487a-8a7c-1aea4cb107c5@redhat.com>
Date: Wed, 27 Mar 2024 10:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 4/4] meson: Enable -Wstatic-in-inline
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240326171009.26696-1-philmd@linaro.org>
 <20240326171009.26696-5-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240326171009.26696-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/26/24 18:10, Philippe Mathieu-Daudé wrote:
> Compilers are clever enough to inline code when necessary.
> 
> The only case we accept an inline function is static in
> header (we use C, not C++).
> 
> Add the -Wstatic-in-inline CPPFLAG to prevent public and
> inline function to be added in the code base.

No problem with the first three patches, but -Wstatic-in-inline is not
warning for non-static inline functions.  The warning is enabled by
default by GCC (which has no way to disable it even) and by clang
outside headers:

f.h:
static int y;

inline int f()
{
     return y;
}

f.c:
#include "f.h"

int main()
{
}

$ clang f.c
./f.h:5:12: warning: static variable 'y' is used in an inline function with external linkage [-Wstatic-in-inline]

$ gcc f.c
f.h:5:12: warning: ‘y’ is static but used in inline function ‘f’ which is not static

The actual effect of this patch is to enable the warning on clang *even
outside headers* (clang only enables the warning in headers by default
because, if a static variable belongs to the main source file, it has a
single definition anyway unlike if it's defined in an included file).

For now I'm queuing patches 1-3 only.

Paolo

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20240313184954.42513-5-philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index c9c3217ba4..f400f7d36c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -591,6 +591,7 @@ warn_flags = [
>     '-Wold-style-definition',
>     '-Wredundant-decls',
>     '-Wshadow=local',
> +  '-Wstatic-in-inline',
>     '-Wstrict-prototypes',
>     '-Wtype-limits',
>     '-Wundef',


