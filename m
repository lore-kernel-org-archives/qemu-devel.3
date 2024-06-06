Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24CBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFEQw-0003Ek-F2; Thu, 06 Jun 2024 10:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFEQt-0003EG-Fu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:49:40 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFEQr-0004Aq-IZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:49:39 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e72224c395so9908861fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717685373; x=1718290173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1QOATnZHBqvODzvJxcICfyMfpuf+qtW7TKjV2aYNlbE=;
 b=iMPX7nonLpyVtz9TXfREmidP8jCPTFypGY6QMfkF/lGrCtX5K5o1jkbPRB2OEucYpa
 PrUsj2AGfIlbOXiIjgICj23tFEwsL54ymyZEOqXCfZCWQyPbj0Y1onNuQm4v5pLi5vFM
 JQFosZ6ooDyHTpyJ7yWZMk6gG3cw8EmV6zGceqS0GmsFPRxEbVerSp2MAXPTUGBJMSuu
 g9N0i5PIlq6GQ5znwVudC2LUGy9KAkHon2VWUE2DKTm+r8QQLfDE9Ch5hWyunqKfuj6y
 xViOwdyJqKEtrhgAmwZQZD1ilquQQG7NGVG3dh7/iVi3ixXkKtvPuJqeQIOqYFVYi3qC
 4GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717685373; x=1718290173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QOATnZHBqvODzvJxcICfyMfpuf+qtW7TKjV2aYNlbE=;
 b=xCQl6diPFl1kxTG/PVY2h4zttPyDzmyZ4DspUTMVU0Hc7Y5p7mAcqW8LAoXrRuvQgY
 CMa8is7ymjt450193sTQg9rwIdrlMKrNRoi3enK1b/PaAzM/w6gb7sAk/T/fNHwG8/oG
 jpAcf72HcyudAELT/oXwR7+m9m29KN9yghsHw/iPmNrRbE4aXbOI/wN6ENc6XKw+F1zw
 0TOqBqLHcXqqwqZaBunmOkBoBgGgBq5+xD52g8nZqdAsIXIYiaL+mfpb2bCF2gre1qX8
 karLKdM+97Hurqj2a3hrQLHLLZ0fvUhUlTm3QiRTuDLltbZT2LMKYPDix7uJjhrHLkDo
 KOEw==
X-Gm-Message-State: AOJu0Yzf9HVpvn3n+hsb670Yk4M4HGRmt3gIJ6bvYe8bYkXZjCHDLDDU
 1cnU+Ywf4DUB6ix8qid9IjQLZEfu2ZosPjN3yQd+SeknSUSpLJ/sATPPkKHYYF8nnvZThjjYe+y
 9e+fB34Crx0Vb/hHDSotbiDYh3IXnSLtcm1HmFg==
X-Google-Smtp-Source: AGHT+IHh0h9XSXX12krYMp3H+e0jw2/iizCtU8AjE8ykuDfWPJtIT1crzJGM60Bqsc3vPklKngZRAejNTUeSaO9fG1c=
X-Received: by 2002:a05:651c:30f:b0:2ea:7e50:6c94 with SMTP id
 38308e7fff4ca-2eac79c1bbdmr28905451fa.16.1717685373174; Thu, 06 Jun 2024
 07:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-5-kraxel@redhat.com>
In-Reply-To: <20240606143010.1318226-5-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2024 15:49:21 +0100
Message-ID: <CAFEAcA9azQRXHab8R2i9Op3zif=KnJmkJ6FDAzZ1H7pHmxdg-g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] qdev: add device policy [RfC]
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Thu, 6 Jun 2024 at 15:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Add policies for devices which are deprecated or not secure.
> There are three options: allow, warn and deny.
>
> It's implemented for devices only.  Devices will probably be the main
> user of this.  Also object_new() can't fail as of today so it's a bit
> hard to implement policy checking at object level, especially the 'deny'
> part of it.
>
> TODO: add a command line option to actually set these policies.
>
> Comments are welcome.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

> @@ -162,14 +208,26 @@ DeviceState *qdev_new(const char *name)
>          error_report("unknown type '%s'", name);
>          abort();
>      }
> +
> +    if (!qdev_class_check(name, oc)) {
> +        exit(1);
> +    }
> +
>      return DEVICE(object_new(name));
>  }
>
>  DeviceState *qdev_try_new(const char *name)
>  {
> -    if (!module_object_class_by_name(name)) {
> +    ObjectClass *oc = module_object_class_by_name(name);
> +
> +    if (!oc) {
>          return NULL;
>      }
> +
> +    if (!qdev_class_check(name, oc)) {
> +        return NULL;
> +    }
> +
>      return DEVICE(object_new(name));
>  }

It's valid to create a qdev device via object_new(), so
this doesn't work as a place to put the check. My suggestion
would be to restrict the deprecation handling to qdev only,
not to objects in general. Then you can do it in the
qdev device base class realize method, and fail realize
if it's not supported.

(qdev_try_new() is one of those "we use this in just 4
places" APIs that always tempts me to wonder if we should
really have it...)

thanks
-- PMM

