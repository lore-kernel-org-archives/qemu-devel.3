Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6792C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAY7-0002Tz-I0; Thu, 20 Mar 2025 03:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAY4-0002Sz-Iw
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:42:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAY2-0007rU-Fo
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:42:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so2329065e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742456557; x=1743061357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+b2Qw+4lRPiTxf1ZtAFqF529wv9cX65d5/a2O1oFhk=;
 b=vh0KVRyF251EWZfyQZOA1q03hyKWFIeWKMgki0WSHPIW6979qCkBDgUY1fkJ0qzNE/
 O5DhZ2TVicXWNIyM1Rx/ZDMxm/LuS6teLZVY4lTp450AxXSZeHVpHsJwcGJAJ2QOreK+
 ly9rqvE8aQq3jvGT//szBRqtyiqeLuEqAa0nSD/zt9fJeMnux4dduuKsQJ/0tuJ98XsF
 s5JXUROYeNW/oWFrN2EX4TBrtPICPzJyWD59Kst3VBEnvZlVEGLJfscy27GR7FK2h5Fd
 tT3hrObWK0oZuhtUfCv7nINmivrIH+pI4AyDBJ1WZMclWM4zDFHBdQwXrCNhrwj8kWIN
 5/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742456557; x=1743061357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+b2Qw+4lRPiTxf1ZtAFqF529wv9cX65d5/a2O1oFhk=;
 b=AJZJ/FZ89QvF7ytabXpk60So2k+AKK4wGgNYc6ekz/IAQJwEbCpW0QPqTiGgvHxZ6U
 L+l4FAv3maf4Zpm0gbniFMgdBqlyliAQQkOyAHGgvg7u/iwL0sSNQGLNpjTibUujgSum
 mvTYKy4UGiM9PEt20cKLIBcz6eqOpqyK6le9+1I2veMKBxjpQ6yWuE8fI6aux4UtFxJO
 lv9vtu5UtNF/9jPke2dwnC8D7+jGyQHUrsvqtox8pTU1Y77SmolqhzGxVH1NdghQ6p/Q
 d4PLK//zARcV1IW47F2RizHi44d2Xf2L24P56M3UNATFa8oo2lijQGKV3exfVbJVeL21
 ubGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI7j5Amqj2uoD/acxn/XUQD3dMCqXlaJCEPLpMIHfN+plJO8Xd/QB93HMvVUNy13Q+uP6TYOfw3+sO@nongnu.org
X-Gm-Message-State: AOJu0YwL97ceCFep5BxKzLH1s9AJwAXdppUG9mjXfOHubt5PuUSr1+Ch
 pELgyO1Wbs++lvEpmv8vwg+0iwaYfrfSnHPfk92TBcObNcJlABvXli39WOM2vsY=
X-Gm-Gg: ASbGncttPEnEWSJp1rHEkpq266ROtAaB8QbdbytPUur8HtfeEYBwl8rbvGoDAhfiSSm
 ClGHUHx9/o1XbRPdy/euwRVBPBmUKKu3xvAUayUO4Q4HviNibGHnTJ6R/ugZY6mi3F/3OWtb+ll
 Bdk5FF7dpP+EiJN3cOqCCZEqdDpz3F9rHsCgHm9kiXlWmMrSXaAiWPZHjyPl3fyHnc/iEngsucL
 jorja62in9nFGZN1ZSvdxDnZTce7xaWkd1a2YiyduX09ub1o0YiaohNmW3OSiJqViN1WNIW8wNA
 8cMPX/RgJRqdCQIZ6GSmF6/mnWsEjx03fqFO9OwGbWqBTkbwb/H4mtHAFlg4HWQr4xQjKguCq+3
 humY3pZWK3gUHD0Er+zBC+IA=
X-Google-Smtp-Source: AGHT+IHxyRBGPPPVjTCKU+7fTwYg2SB2sEUbhyXEcB+LZIa3EUHTZL6Rfr9CQxzOO7T15MK7i/lJNg==
X-Received: by 2002:a05:600c:3b04:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-43d4916674emr17183375e9.2.1742456556306; 
 Thu, 20 Mar 2025 00:42:36 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdab7asm40301195e9.29.2025.03.20.00.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:42:35 -0700 (PDT)
Message-ID: <c9820156-501d-4312-abe7-ee976c6cc11d@linaro.org>
Date: Thu, 20 Mar 2025 08:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/24] hw/uefi: add MAINTAINERS entry
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-24-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225163031.1409078-24-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 25/2/25 17:30, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1911949526ce..451fc33306dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2807,6 +2807,12 @@ F: hw/misc/ivshmem-flat.c
>   F: include/hw/misc/ivshmem-flat.h
>   F: docs/system/devices/ivshmem-flat.rst
>   
> +UEFI variable service
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +S: Maintained
> +F: hw/uefi/
> +F: include/hw/uefi/

Ah, maybe add as last patch including docs/devel/uefi-vars.rst

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


