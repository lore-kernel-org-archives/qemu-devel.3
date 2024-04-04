Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F845CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNaK-0001jK-4o; Thu, 04 Apr 2024 09:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNaH-0001iS-BD
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:56:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNaF-0004Xh-1R
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:56:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41551500a7eso8062415e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712239009; x=1712843809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIKiJiErRYmhdLTk+WIc5nhrc6G0Y47lKQNvk6QjyyY=;
 b=fQiNrMRgfMuUXYiop/qQRhtYyhSossN1Mszs+Qfe4s6tlctm0PlcMPrRjyx8pfSWIE
 W7Wmnv1/SGNiFo5xbYZEV9r11kRP3aMilybeLFCqSEpNZ8VeBNnNTm4VpiQlUFveWsZX
 3smv4mgW5s3g/fZBzqsEmP0ZOLBDiRM1HBqXBifRB+oNWebtHQHeDpG1IxtEP50xukJP
 pPJQ+20mL/NVcGX9ojkz6q5CqruXp8Ber40WfvS69lanryZR64mpycq239+Ly6oiVWcC
 HFAFGiiKUoxlzYsgrw/I4fpovuIONnzMzlXdrHYNYaco8KxPg+F2IidJ7egdYcyoEGNx
 cWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712239009; x=1712843809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIKiJiErRYmhdLTk+WIc5nhrc6G0Y47lKQNvk6QjyyY=;
 b=p4sdjfLwsK6UShBKht57ElP3P19OGMnJCUJGxGGxx1/XPElL/yRjC7m7z3b2NHR9tO
 UIstPDoUPRsg1JGnffgF2K/OYoqrvzJBMwBjuMqQv5C1WgG5npXQvx/YhApEEGBIlf6+
 9X/3NISILL6/7tRcX0rWeUsb/UoZVyzdszSYSd98WW1Zhx/7aO6q9cSRMA7byMuSfDav
 HucCUqLpAedLCTF/p+QepSgPGbG8GySY47wdfk6RGFBASJUGheBjmK2wnEt3ZUX3n+Zf
 vIq4kQIIQlfcMk5JidC46rZhV4uMzHRZIMA1oi5JOwY4/7FMYIFd+JYBihmNo4uFeZTu
 RaEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgnkM5Zkn+3iP8wY7KjYW05AbB0+PACNUbbI/j4OR880IV+kh65XSJcQY3RYxOQdu6/nr0i6tVcHKRugI/e28Z3eSfmh0=
X-Gm-Message-State: AOJu0Yw68z9OP2Trs8f/evu63kdbIBviz3wF0vCbLM2eS6L/Rosy6l/r
 e0ZYR918/j1HRxDRW//EqfjkOkL5S/E+0jBBLfrLg49RLuZzi65fMSDlpQV2QC8=
X-Google-Smtp-Source: AGHT+IEKF+AIQX2fDQpY2/wC4kZ4Bi0nZEMDplqYcoJIZ3ZGES1b2BVKLBenNVLvD1TX9c1XRnURKg==
X-Received: by 2002:a05:600c:1784:b0:414:9676:4573 with SMTP id
 x4-20020a05600c178400b0041496764573mr2051890wmo.36.1712239009547; 
 Thu, 04 Apr 2024 06:56:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 m32-20020a05600c3b2000b004154e48bcdesm2796870wms.14.2024.04.04.06.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 06:56:48 -0700 (PDT)
Message-ID: <884c1adc-f3fe-4b4f-a377-c0c4267e2d12@linaro.org>
Date: Thu, 4 Apr 2024 15:56:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 05/11] contrib/vhost-user-blk: fix bind() using
 the right size of the address
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, slp@redhat.com, Eduardo Habkost
 <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-6-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240404122330.92710-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/4/24 14:23, Stefano Garzarella wrote:
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
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   contrib/vhost-user-blk/vhost-user-blk.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


