Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B75D132DE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z7x-0004QY-1c; Mon, 04 Nov 2024 10:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7u-0004MN-71; Mon, 04 Nov 2024 10:36:22 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7s-0003nP-Lg; Mon, 04 Nov 2024 10:36:21 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3729622b3a.0; 
 Mon, 04 Nov 2024 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730734578; x=1731339378; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=lZCB79wUMAh1+L5FCAE1eEffbYdzYk+IIW8wRSmWRQk=;
 b=dhJGKvMxKNga5IclxrGBy1RdhflDVXOOrov7mPGHJsekDZwnUZf4ePWH8qHQ54SHzA
 sud0eOUKJawCbd2d9JvWPuvJUJlG6ERV2p+L+J74pHnS0FG9IF/OAkLzpXgCt9uqHsMA
 Qjbe1cv+B5N+q8CMb9QySYQZQa9DZb1B+p7seW+xJ6uxEt29514nIBtX3hGzFP+3BjVT
 JGUyLxF8fHUu6wcunjQzi1JuPLcfOE72i1chGYEGct2NlJKwJ7v+Y0isxlfDqrLFjPaX
 ZE4wZlfd08MNauN8r7hbGS4mNOk3FLkvInxug2qu2vNvp63r0nqzh1KnEx5hhS/5ZlPn
 W0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730734578; x=1731339378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZCB79wUMAh1+L5FCAE1eEffbYdzYk+IIW8wRSmWRQk=;
 b=UcP/05lnbCuwXvX7cv7IMCxPV5SVzNMybF5aThSCjujD30i0H88cGqhD2WR6sNK8mk
 glFe7P4SpxMmZc8xadPtTcEdvTaVp2X4y3ES3Qv+8/N/64ivU9NMIA4Ut3GTWu01k9m1
 Te6YYLm5Qfx7rioGJ0o8NacPgq+PEeG6P59AreT7MZa5C6/nR2MW93GpT97WxQx48flg
 H1gaiIySF7tjqwCuvAr3HVslx4QUGmJV3HAgPjcJrA3C53LZWTzAzProkQ2RfSiHCODq
 ofEwSJkywiuqHa+7gmFdkU8gDxcMWU7X8NL/l9yhCyxWRTRzT/k6M8lVlmVYg7zRbN58
 fSNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxktVUemPoXf4aT/8goSPRu4tLZ+XZ43FBhvJmWDzWspOHF4rVMvfwbJ6QEFCWMbUJj+LIBjXlMA==@nongnu.org
X-Gm-Message-State: AOJu0Yw6Vw+v15jgfBveEPpDFZtpaltv6Y6VlvlBVkZRakUC5f1Txcex
 zNmWjPiQzwm5eZQ3G3tYatZpxC0nQDjeNQ5aocPtF2/RvVaZ5yPO
X-Google-Smtp-Source: AGHT+IGY6RrZQg8kozUXJ0SOx81eZo8xtPHSlnUuvGFx01PFpu058OXCq0fOxzTPdFih5Q/1FNa4XQ==
X-Received: by 2002:a05:6a00:b86:b0:71e:7c92:a192 with SMTP id
 d2e1a72fcca58-72063093594mr42570440b3a.24.1730734578395; 
 Mon, 04 Nov 2024 07:36:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee452a9922sm7304426a12.32.2024.11.04.07.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 07:36:17 -0800 (PST)
Date: Mon, 4 Nov 2024 07:36:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 5/5] hw/net/lan9118_phy: Add missing 100 mbps full
 duplex advertisement
Message-ID: <e6762f9c-1af9-4b84-908b-dc3eda98535c@roeck-us.net>
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-6-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102125724.532843-6-shentey@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Nov 02, 2024 at 01:57:24PM +0100, Bernhard Beschow wrote:
> The real device advertises this mode and the device model already advertises
> 100 mbps half duplex and 10 mbps full+half duplex. So advertise this mode to
> make the model more realistic.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

