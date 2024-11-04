Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC91AD132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z7A-0003bM-Lg; Mon, 04 Nov 2024 10:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z78-0003aW-2Y; Mon, 04 Nov 2024 10:35:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z76-0003hU-GT; Mon, 04 Nov 2024 10:35:33 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso3459912b3a.3; 
 Mon, 04 Nov 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730734529; x=1731339329; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=3XguMVXGbfzkZGKGoqgqbNVlfw/hHevHdV2cu/d9T/8=;
 b=MLB/NJsYVYeNNdAkmLtHPrHQG0HhPbeOPR7NPUPx4/Lg51vt+AL0+dt+9J7ObpKMbg
 P5R/59/Pjv7YVYPjT9ZUkJXe9Msmfw2q6qu7609HnzyrMeq1R8B0APx9R3FQbxYAkllz
 ncD2ZYp9chjSE/VHnTXBMGVsUDMVCx/VOnveMyBm1UPk4JCkvrwO0r5A417AcWzj1Er6
 Sdd5m4cSEa1dqT3/fbKtaUjf4OhiK4pMKM510V2+NwjEfgONrGrRrWp4MMcaixBQzHPF
 byc6IDo7MjxyyuTUxSz4pIGZouDVhMQqzztBvfAfy8oP4kTKu2/IFDXnpQlapawLmYp+
 /ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730734529; x=1731339329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XguMVXGbfzkZGKGoqgqbNVlfw/hHevHdV2cu/d9T/8=;
 b=LkOgrTIq0sR72PwhrSaXq3MxeLd80XtXLYDVh8JV4OWAXo81j3G4tzL8uGXUZRviLb
 mGYGY4Gp0rNNy+MyxDP63xXUiWGOSkBlysw81gc+rY9N1zzMFQebDX1XxVhH10q4VTSQ
 bHJSKaYyQyC7z9wiq8SOk9rB2Lqn+f8P01cHBQN2mwHeSkw67uk/9eQeOziOuNtQ9sYO
 d6QQpynKcAoII9qd8hGa8Uce25D5+rX/BppFrz7jopPP0KwQ8JXvkr9YgY7lQVuHn+yo
 QMAvVb00mATYss0zPf8kicpbPq0BnVXKjFsx/Vwm3QRZhoRKloHbLe+u3o7wujeznd1X
 9f4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5bG06OmHKFtAh5gSoecXfRHLyayl2jpQVbH+dsZBQ51tzxXZ+/L8/5HbzmAYXDsJAoMktAb6F4w==@nongnu.org
X-Gm-Message-State: AOJu0Yz7D4pi3bV3N1ugCCUDqG8SB8sSF07sO1TWGqx6D5aU6IMab8Zl
 zqFnvHT+EnnBMWfDQ9UtqsPUNy+huxYEM/Dlzz/7uZEiAZIzhkBv
X-Google-Smtp-Source: AGHT+IGilpd5FyopIT6LPOiMQTeE+V6mfmZUdW6NdwC1cYQ4jYfbUm8imgWs4IAg9QMQzJsZTtoeUA==
X-Received: by 2002:a05:6a00:8c9:b0:71e:410:4764 with SMTP id
 d2e1a72fcca58-720c98a3d19mr20625826b3a.8.1730734528765; 
 Mon, 04 Nov 2024 07:35:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2c47fcsm7536097b3a.126.2024.11.04.07.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 07:35:28 -0800 (PST)
Date: Mon, 4 Nov 2024 07:35:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/5] hw/net/lan9118: Extract lan9118_phy
Message-ID: <ab8b424e-848d-4e1f-9216-2fdfb6516bec@roeck-us.net>
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-2-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102125724.532843-2-shentey@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x432.google.com
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

On Sat, Nov 02, 2024 at 01:57:20PM +0100, Bernhard Beschow wrote:
> A very similar implementation of the same device exists in imx_fec. Prepare for
> a common implementation by extracting a device model into its own files.
> 
> Some migration state has been moved into the new device model which breaks
> migration compatibility for the following machines:
> * smdkc210
> * realview-*
> * vexpress-*
> * kzm
> * mps2-*
> 
> While breaking migration ABI, fix the size of the MII registers to be 16 bit,
> as defined by IEEE 802.3u.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

