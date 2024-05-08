Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2061AC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eSr-0003H4-6f; Wed, 08 May 2024 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eSp-0003Ae-EZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:23:55 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eSS-00013Y-Gg
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:23:55 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43b06b803c4so26609251cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163811; x=1715768611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dgpJWKGulNCwHJsSoI9LuApdcXPs8sIh9zE/vcpZ2bs=;
 b=zJkTZq1PWYfRigOQ0YIwLZOlvKk4bIVq/3KY3RqedPSAF55UK27D3EfzfgGaiZ88ZU
 Ej5iGgppf0cJ6ryl197gQ7gQebn3PZskILgMSN7Bhf+xyxsSDppNmoiNJAcREVGO6eoY
 egye0rGvR/PWYnH4yHlIE0BbtFQA9K9KNUNJaLRYu1kZOESUI+ZoqMWJWbjZtQp+ADnK
 XYOPj3XmqrwQy9QER+ThxK1ET//+SKq+/SON+xVZaLkoEJaZho///QZu50kA0jnV56vf
 jgOEPZ+d2L9qF77Oi7Fp6JyRu3aa5CfgD///kO7WHOY42AQ+2URDeum/RQTr/1/Q65Sr
 jxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163811; x=1715768611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dgpJWKGulNCwHJsSoI9LuApdcXPs8sIh9zE/vcpZ2bs=;
 b=Xwsf0EogH5dPgqUlNSZqKWiDdhGJgp3FktRpmy7CarwiBYew4xFTASlQZd3TU5/bJ2
 lVJnjhemEHdz+OJcD7sN1EQk1IhG6mn2HJxAiklvFe/GLpzBKr3oqxNgfvk8FFDyG5yP
 wESyi1AZaPIBERJZul/AEVRH375rLzRPq0JKAkUO03sfKekwsmJylewxaO61BuKahG/m
 lIuDs0LCtVJTJZgEclv7Z9Nh71lK0NceZRfYaxtj2Dgx8eBsuCjh8xcOBU0ReiBv8+OK
 DBdxvEFWQgFX/lCK/Tuw5wUsjCyk/9UzDZUds+VG6Vmz1M6MiN6t9V7uEXdgvSf4TKb/
 cUwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwAzp3x+62kMCpJ8HKyrs+LlKG8Z06NM86N+gSuJ/yEsVlQfIJi5ExzPeay+oMwcLsLPzblGYSuOZaiRv0Nnbj8iCKY20=
X-Gm-Message-State: AOJu0Yyjy4NC4YE/gpjLYwGLx6i0Ltg2AmTlKzJGEGL+GZQQAXxxfdBn
 xRwbwICf7gFCjatHexAiGJVT/AUN0deD+Wx33J5GarfJUf2DyFYD06P/TcUHRR0=
X-Google-Smtp-Source: AGHT+IE622agX+Wi2SFgHvDQWTM4tsCGfGFuU0YpXtBQB/7KgrXnFlgyBqxcFUmcyyXVHd8m1OuZiw==
X-Received: by 2002:ac8:5a05:0:b0:43a:8525:a622 with SMTP id
 d75a77b69052e-43dbf85416bmr21478881cf.54.1715163810962; 
 Wed, 08 May 2024 03:23:30 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ec25-20020a05622a5b9900b0043c728156fcsm3073026qtb.93.2024.05.08.03.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:23:30 -0700 (PDT)
Message-ID: <3c180645-57e7-49b3-b0d8-3981f7dba2c6@linaro.org>
Date: Wed, 8 May 2024 12:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] libvhost-user: fail vu_message_write() if
 sendmsg() is failing
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
 <20240508074457.12367-3-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> In vu_message_write() we use sendmsg() to send the message header,
> then a write() to send the payload.
> 
> If sendmsg() fails we should avoid sending the payload, since we
> were unable to send the header.
> 
> Discovered before fixing the issue with the previous patch, where
> sendmsg() failed on macOS due to wrong parameters, but the frontend
> still sent the payload which the backend incorrectly interpreted
> as a wrong header.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   subprojects/libvhost-user/libvhost-user.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


