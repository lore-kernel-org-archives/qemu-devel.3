Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA9D16260
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Kd3-0005qC-66; Mon, 14 Oct 2024 08:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Kd1-0005pN-F6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:56:51 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Kd0-000604-3B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:56:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99ea294480so218999366b.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728910608; x=1729515408; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SGyVz90YTp/X/at9ySIxm4A5Xp03kJO0dRy2Kjf8MPU=;
 b=VfAoOEhSkh4l/BXwB2aAFqZDElUJoPdx3/YciFp/kch7fkWpsvk/mR8oKcrRnvJrDA
 bArcL8Px91YH3MP+lKDE+JL2RsrP9+MfgQX3ttS0fJBl4XF55SElj7pol3i9jETkBjbV
 WmXTDUUSvWCW/3DuuwRZ3OdnCO/q8YSj6NGkZEwIy/wthGYfxafDHMKmysPw/U7w7JJn
 GUZ7tkd0C+imuaW1afQW5kJmp1fIGDyrLfYtVz8pIVUNUKEN2/kUpPv3bd4T+ZQVDF91
 F5APNTLmVJbQDqPhocKJPxxxhykLwyQ6y+GUBrX4AGSUh7J452eCr7xJYBVBNaunP32z
 i2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728910608; x=1729515408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGyVz90YTp/X/at9ySIxm4A5Xp03kJO0dRy2Kjf8MPU=;
 b=tdyfmo9GsOZp/7X/Y1QDvh6sU5bVRQanzK14fBV0/Gv/tghASu+rnLZ36OEuajdyEL
 is5s2e6LokU9FnTOoEWHFeV015APSDEgyVfttEcrw4HQ70nfoNnkQiXXcYCXtshF8wKq
 Ii/Lno6YhlnO9TBplm9K2L5mBYBTTpCYDoapIjjBjxUhpmsR0R+XXT/RAA2EeRb8kuoK
 +T9yVLeadecz8bPNIZh5iXf7l+OCf2T1dLNknq8ypBfKhAg42JHF5cVqxUfKsl3gDMQi
 an9c7IFPUHWT4+c9vKdcokG5Nkd6ynp60WiLQbec3KVKwF0tSJUGer7ILzcBMu6oCstp
 FQTA==
X-Gm-Message-State: AOJu0YzGt0K6fiHz5V1Mebo8BK0rXISETiiKCK944iNPfZXchf4dYYTe
 uf7LPhZI9DhoiQvxKLED6lVQZKBagmNZWJ5gxfC0dQhUh1X0jQTnVC++FENIYZK7AR3Hr88jiKn
 QaeIjZRw7D54Zt8qDJCKQWXD6cP8cTdak6cYd2A==
X-Google-Smtp-Source: AGHT+IEQcxoD1Ar/yJyviFpJRS856AznNym1xrBEj/9Hrcy3S7Nlhyyty/rVIQ/KZZxzhdr72pd3PKGCkE1rCoYxcrc=
X-Received: by 2002:a05:6402:c41:b0:5c5:b7fd:170a with SMTP id
 4fb4d7f45d1cf-5c95ac50794mr12520175a12.28.1728910608234; Mon, 14 Oct 2024
 05:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-4-shentey@gmail.com>
In-Reply-To: <20241005205748.29203-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 13:56:37 +0100
Message-ID: <CAFEAcA_w=USBp-hbV+DxuzF_zfvCFUoPFoAZorD55R6VN92kvg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/net/lan9118_phy: Reuse MII constants
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Sat, 5 Oct 2024 at 21:58, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Prefer named constants over magic values for better readability.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

