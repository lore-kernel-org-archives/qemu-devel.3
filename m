Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E060C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2mE-0001PL-EK; Thu, 23 May 2024 03:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2mD-0001Ng-0O
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:22:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2mB-0007aM-Cu
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:22:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so53066125e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716448929; x=1717053729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0zoeMruNEyV4z+2JD/+uFsGHvuTKmDFYEIiF60s4LVU=;
 b=B3ioQDDW6TKXDapB4B0YybFgFavwW7XHe/Ob0BYesy7O1rdlgYoBAOn2wuo3eDhiUk
 AYPnD86HJUNCqF4D17OoHVKjnObvmvTiHdLRApjPKgV2gRt66luslyA/Ac15Ykq+WdKq
 Fwc5HwnxnUgJIW4JxuAlL6wpyOqsiFhklxQ4BLr+GdMS5uCqE6gutBA82mbgnVC5vxSj
 MTbtdCjiPODyt67e6gN4lJaMeaGEtuCjFY0R+vTgQtS7677S0F6mXaDYB5OJFAC8tWe8
 Bjb6x6dAJZsgcYY7OuQY7Ysiv9O5feJavNhbhONNimMfuCAUPCLULDYG9r+vlozU+vYo
 IeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716448929; x=1717053729;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0zoeMruNEyV4z+2JD/+uFsGHvuTKmDFYEIiF60s4LVU=;
 b=QsqsTX2cnq9hyiZfgZQg6C1q38BsJHjra6stVl7Xejfz8MaMmMA4CfHRUT7GhKZA1o
 ZjkNRWDSOXG5idmecMhP+L4w0MSAEmGw88DRIdyQ6fTGMsmGxcGYwLfkxlp9Budp4OG7
 gDioXMZlxSEt8doxiJTjxyKyIkxWpDo/ihhhP9uLMu27RA7vS6aesPEOdvrnrpfl0fW5
 bMFOSXUPfDDcHOZLkp4myBnlIB3KAxevv7HD3mj0EsOE3W/ecfm2BOR4LNCbzxfvhFZZ
 CW338FS0lhMDrQZNixiH2myrI4ELljM6FdE/iNbKLWq4fyMzT9J71YLOyi+OuL31XnmL
 ipvQ==
X-Gm-Message-State: AOJu0Ywcko8gcUtS6XCv73Lo+G3bqqIOTLvXxP3edi/1NMF8exp0yHhC
 1Z+S63w++jnA2+3VL5nlxciK4cl68hYtS6y5ExMT0rv2YmDDjHuFWs3u6sa4QhhYCabUBhoq2Yx
 9
X-Google-Smtp-Source: AGHT+IF+5jXYEyeWSKDzdNCU8ZG0dAxCZXQryGXZQmihy7sq5ZlxKltxybiLqlWDsQ+EYjW81DxWZw==
X-Received: by 2002:a05:600c:6b18:b0:41c:11fe:4de3 with SMTP id
 5b1f17b1804b1-420fd326dc3mr32142695e9.24.1716448929579; 
 Thu, 23 May 2024 00:22:09 -0700 (PDT)
Received: from meli-email.org (adsl-73.37.6.3.tellas.gr. [37.6.3.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fab1d3sm16500255e9.37.2024.05.23.00.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:22:09 -0700 (PDT)
Date: Thu, 23 May 2024 10:21:53 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: drop spice+ui maintainership
User-Agent: meli 0.8.5
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-5-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-5-kraxel@redhat.com>
Message-ID: <dxggv.germubctqoia@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

On Thu, 16 May 2024 15:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>Remove myself from spice and ui entries.
>Flip status to "Orphan" for entries which have nobody else listed.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> MAINTAINERS | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 4d9f4fd09823..d5b6a1c76abb 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -3042,8 +3042,7 @@ F: stubs/memory_device.c
> F: docs/nvdimm.txt
> 
> SPICE
>-M: Gerd Hoffmann <kraxel@redhat.com>
>-S: Odd Fixes
>+S: Orphan
> F: include/ui/qemu-spice.h
> F: include/ui/spice-display.h
> F: ui/spice-*.c
>@@ -3053,7 +3052,6 @@ F: qapi/ui.json
> F: docs/spice-port-fqdn.txt
> 
> Graphics
>-M: Gerd Hoffmann <kraxel@redhat.com>
> M: Marc-André Lureau <marcandre.lureau@redhat.com>
> S: Odd Fixes
> F: ui/
>-- 
>2.45.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

