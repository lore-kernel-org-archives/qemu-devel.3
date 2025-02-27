Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5913C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncqX-0001Zm-OK; Thu, 27 Feb 2025 07:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tncqT-0001YR-CH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:18:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tncqL-0005Bp-GO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:18:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso5544865e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658699; x=1741263499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HkHhfzZGODfXhDhbZhS7ZCb/Btwu5fM/CX5IKhPPhs=;
 b=FDoLjcrJ3Y4yG6iJ6YuZ2uVrr1+nAu1Txcf8wY4LO5Zs1uZ61fLQ1VQOeu8YvUv1HS
 WxtGtbMlkz8rAYOaLBZ6NKeGv4T0Xvjz9oR6YmFXj7utIMsbpehEQYCXcwBeauDiMolH
 UcWbUNbEYsQ1FUzmPxd4R71npRpsL0W+J8U89OK0Xc4vC2MRTdVBAuN3+CHiRaX1oMUf
 6Bwp2A8xsJkMJl3vIwtGSMBNVRagU4TmktKkXiOff4wPe/A6vd039TGKMu9uUkKsk/EB
 /6+HOUuEQiIdzDzgy8bydVpQ7HXGKDM6zbCHCX2gXh8C+qMmVk/zi94ImMgmVAeFYTTS
 hXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658699; x=1741263499;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8HkHhfzZGODfXhDhbZhS7ZCb/Btwu5fM/CX5IKhPPhs=;
 b=q22vRn/iPzIC0Sqvd2TKTU2CIKYkYZE5JOHTFhVXvsX+86e+Ucxn89beCxdCx6Q5K0
 ndrj3C/rPJqb8y7BJLxNhnS4+agkJZwdhamtyAOr5BB8CACTM3P8SfIZKRsh2+Eqe48Y
 7uhOKhVgyllkKrIKszjVMzdoyxpWlQV+vty49r74wUH5RmJiMXH3/BaupEFvpmepGQm2
 G2rgF2XgR6OWP3Cm9zxGAeRknLF5yKSxBjJg3fLxrXhYv4khlWPbadkvmgUw4nn3EO7z
 B1W6XDd/WsTcnVjZqTcnfiXQS1/xmSKoQfPji4AlF+MsY6+PwIotIliw9wV62gfx8acm
 SI9g==
X-Gm-Message-State: AOJu0YwBKMF/ttPZ/qvWP4MH7lJKbMMYrFleLZ2XhPWG9Xr9x3nzvewr
 pTJaZAqfpt0hFPFK14agFklZlQ93aAglQIJlSQiUbugrYE4C5XRbHXxqnYvO3hE=
X-Gm-Gg: ASbGncsf/28+rgdd2a0RFqPoT3JPWXN3ly3XRxCUs0vbc1wTuu0yk5H8ziC8vrdpIIK
 dQtE38s5P0+KPUhFwcAhokK346cv67RAdxk2vge02Rwh4J2Q3tQbj2oDYYyruNxR4/qhggiqb0S
 lRl9bj5kucNzYgNzpTSEtE3XrZFQMuESAOogXoWXnIVcuvRC/MQKNHJihddOfbscNSg/fom3+T8
 TsnKnh6mWxH4BSMR0GyGIMR7Gu2GetjK0asbpUK61nZ+fVYHJlbPuWRLX6Q1z+GRaBEjY+19qUV
 Bq4rNFgfi/SYuJDIYFIMzyLjVzUw
X-Google-Smtp-Source: AGHT+IFXNxsTL7s3LWPQO3czRZuhjADqh5AGmSmU2vK1FbdebX3eippbnp81fYQpYVwdnjK062MlTQ==
X-Received: by 2002:a05:600c:3b83:b0:439:8346:505f with SMTP id
 5b1f17b1804b1-43ab90169f2mr56346935e9.20.1740658699095; 
 Thu, 27 Feb 2025 04:18:19 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba538b9fsm54971045e9.17.2025.02.27.04.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:18:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9DFAC5F8AB;
 Thu, 27 Feb 2025 12:18:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/avocado: Remove the boot_linux.py and
 replay_linux.py tests
In-Reply-To: <20250227110014.21048-1-thuth@redhat.com> (Thomas Huth's message
 of "Thu, 27 Feb 2025 12:00:14 +0100")
References: <20250227110014.21048-1-thuth@redhat.com>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Thu, 27 Feb 2025 12:18:17 +0000
Message-ID: <87mse7wph2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> These tests are based on the cloudinit functions from Avocado.
> The cloudinit is very, very slow compared to our other tests,
> so most of these Avocado tests have either been disabled by default
> with a decorator, or have been marked to only run with KVM.

I have no objection to dropping the boot_linux tests. However the
replay_linux tests could do with porting to use new images (the tuxrun
ones?) so we have coverage. Otherwise we only do a simple kernel boot
under replay and that covers a lot less.

Also don't forget to update MAINTAINERS.

>
> We won't include this sluggish cloudinit stuff in the functional
> framework, and we've already got plenty of other tests there that
> check pretty much the same things, so let's simply get rid of these
> old tests now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

