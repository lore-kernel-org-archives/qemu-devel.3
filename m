Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0307C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eUd-000576-7X; Wed, 08 May 2024 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eUX-00052W-5d
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:25:42 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eUJ-0001RM-9O
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:25:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-572baf393ddso1152949a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163925; x=1715768725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KHP5dZHLTlMD54OFLJb+OOtWtf+YD8/0FHwOK39AkYg=;
 b=vy+9FNY42n57Rf53siolLZGwfHvYmAE+DWu5r7kyX0181kJCCAED093r3l/QN+SnO2
 0OrKK7WxFxtdLoVApXYyts/NnP9sRN9iiVZZUmYifhK2tHf7KdytNUuYGuf7S/3L7ZdT
 GnQPlaplmBItToteGqIg6LWcT+UbbI4g7y4aqJLL2ql79X9gcMujhglSgUrEuLEZMIak
 nxB2cjTjIF43RQj5SFjw0LQdJj6E4XLydwSv89r7j+S49ylOsosW2wsS1NujKOB/kuSS
 VyCdymO10m3G4uc6+q7lmpwAAg/fLiLWY2vGrlp2QMf2N8qOSt14yEWJl0uUjk0S+Svx
 +uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163925; x=1715768725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KHP5dZHLTlMD54OFLJb+OOtWtf+YD8/0FHwOK39AkYg=;
 b=wTNL6GvYiKe6z3iLU1+2CqKq0j8NfFsVEO6zQwFQKeamqEYPX6ogp6JqJr/03T678S
 OhEZ0HoknNGiku8NsPzQ40i2zGn/NzLeFFkRfMRTg9MAE0o8g/MnP2X4u/w/XqnOYZqJ
 N0Sy7CHSwqmF1oVvCqtibEFxGmaCy9Q5SMT2a8kLcFG0m3IzRGUh+Wos7gvv6N/ILeIW
 p6JVO6Lup8USm19A0rxo+b7p2KUv+kg+otV/7jRIqPRnOkRRS9ai6FB0XO6TQ8Q1jUK7
 HkIfTojxiTZxzphsPylqNjxCkao4BXRpVlNVZP7eN5Z+S+O3KTh8pknxO9+/hvJDh2cQ
 HS0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVPFisc9kMkKk5pOESZNRCSF0XblB8Ik4EF3XB3rLwjJYIepgWmhKoQMmT4yyBphjFqUT/l8040I1/ggw+mNNDuXjFi0E=
X-Gm-Message-State: AOJu0Yx/6C6nLH7+89/J1MYpsrDdynuUQJqEI16ej90UD4dfkIq3LKpa
 fGSL+0ovauQysayllBslHRlr7qShOqpjAvZV7ku4LgTVPB9uuEP28oLBnOYf77Y=
X-Google-Smtp-Source: AGHT+IEGy0JTm1d+g8GxvN++EdpMFKqhgh4oTrI3sLJx81KSloXHc7RD1G+kmMYsa9gaU1S1WbzWYA==
X-Received: by 2002:a17:906:22cd:b0:a59:b17c:c9d2 with SMTP id
 a640c23a62f3a-a59e4cea47fmr371588966b.12.1715163925253; 
 Wed, 08 May 2024 03:25:25 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 b3-20020a170906d10300b00a59edf10304sm1803473ejz.76.2024.05.08.03.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:25:24 -0700 (PDT)
Message-ID: <068c432a-d54b-454f-bed8-2c5dd9fe2284@linaro.org>
Date: Wed, 8 May 2024 12:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] contrib/vhost-user-blk: fix bind() using the
 right size of the address
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-6-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> On macOS passing `-s /tmp/vhost.socket` parameter to the vhost-user-blk
> application, the bind was done on `/tmp/vhost.socke` pathname,
> missing the last character.
> 
> This sounds like one of the portability problems described in the
> unix(7) manpage:
> 
>     Pathname sockets
>         When  binding  a socket to a pathname, a few rules should
>         be observed for maximum portability and ease of coding:
> 
>         •  The pathname in sun_path should be null-terminated.
> 
>         •  The length of the pathname, including the  terminating
>            null byte, should not exceed the size of sun_path.
> 
>         •  The  addrlen  argument  that  describes  the enclosing
>            sockaddr_un structure should have a value of at least:
> 
>                offsetof(struct sockaddr_un, sun_path) +
>                strlen(addr.sun_path)+1
> 
>            or,  more  simply,  addrlen  can   be   specified   as
>            sizeof(struct sockaddr_un).
> 
> So let's follow the last advice and simplify the code as well.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   contrib/vhost-user-blk/vhost-user-blk.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



