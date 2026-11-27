Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98707606A338
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ovq1T8UV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzdW-00012E-VM; Fri, 27 Nov 2026 12:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWzdU-0000zV-W9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:21:25 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWzdS-0006bf-J5
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:21:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so71820115e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795800081; x=1796404881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DmB8Ngrm60cArqmJc2FvpzPwFdkZqNBDPG+fqVqHD4c=;
 b=ovq1T8UVqo7KyV/YQDG0ID9+7EFaRI4qlNDSlS6XisBMeO0OXU7n5eqiyQH4pdjSjr
 syKNvEkDIOwD7Exg04JUo+7weae1fv7Pf6Z23eUFugeLMgQnSuaAUoIyYxs1/x+PfY6F
 ROzWCMcyq0jR330vH3Pt337+tUVzrCfbYJF3S7KoTbfbpc8lJbotM5AooZPhM3F/4viG
 puWzQy8XJT2XGggYzwXx7o8+f4CPg+Wpk6ByEpUSO9Lqlf4/GpbhducQI4XfCAdorQui
 sTyGMupFwtUOjjsvNTa+GKgtK88rmTMGsWv/zEAFd33v5Qp0JNl/1yGcWUocUcdRGmyt
 OYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800081; x=1796404881;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DmB8Ngrm60cArqmJc2FvpzPwFdkZqNBDPG+fqVqHD4c=;
 b=g1Gu8cMoHb1cGp9BMBZeZ2tREOAhqIUP9c6qVo25Ivm94nGFTcMYJyP0Ulrc58zy7P
 syoAOamZVpXwO7uAFGUxwqzw4LdXQ6otfwCbORX/ZX0vyx7KBq5Ssqgrc3tt8rJhKZdR
 OCzm0x6jz09HIhn6lIs/tedhac1z1rwIp0TB/tMNJHRpdLjgW96wszZc68M4UEiFWVNS
 JgceIugLrB+oxxd8to48joq1djxgXUWWCVkGwvWXqzJxHhu7fah+4XDPZYcSHbpfuhYY
 5H4fxi4kPKgL2dC+7f97LQOYhyihUDEKTGJLl231YjF8I2Omh9aBrHinaRycbMCbSSD7
 VK1Q==
X-Gm-Message-State: APuU4Z+YyhbFcViOknJgh0eZDtyZqGlGCO7J13vf1KZF3XkRmw5IRo28
 J6Sc3uL1MXVZQyYqD+RKdQuNi7gD7TQ8NamPF3AlveIKdxHa+cpRzF6cWk1m3ZmiwtE=
X-Gm-Gg: AZFdTZc+kA1Rb+4b/BLMBWQQRg8Xva9mu87fb+H5PQ6xVYaqtNAyei2soF5upoaPl56
 aR6fYRZKXrY39rCi8bMOeILzAzog4Yx7Lba55792r/A1Oy1fQYEmw3u9jSWlWIVUuISN/wrbkoH
 QfpdLMdg38Xjv+EqrMImV3NXRmg53HLmb6ra7wUd9rlXhgmjtaKIi8/6K3f7Fg4xIUd3mUfFZlo
 OTZE+1z5K3uyVOWLHw+5hWIxoGziwXqE2MGC9MvsUBgJt9y96t1YSLjq9vRtDe8cM/9VXJyeUx6
 Qk5CmMBx0ffUBmB9XnjkO4oGVf7pM4qH0OKjc68JePE1ut72gQlBdlWywvJXZIw4Wlkc9uG6xd9
 B4VHds7snV7tZ5gdQ1mBKVLDEVtuqUtNb2rYjsZ7IVQZcU+Nr1ynqwIv1ZvWsYlpD43j0szOZS6
 +HUvEnE3pcVnPt/FtkcgAILRNk+A0a8jyquiYWp4hhjrav+OSyDeuqfQnBE2pfAiaa9r6uQdBZ0
 HOJ8g6TcrzcuoCWITuGQsX1rme1UHLIy8R3UbyBankt3oiaYpWy6XgzJsU5R+fxpaWuGC0zxtDw
 CRQR3mW7L4Efpt01vcEEQrfVlfeT6szT/W7me5yjrKgRdiINPg==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4bb888120famr517529795e9.16.1795800080792; 
 Fri, 27 Nov 2026 09:21:20 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm735619755e9.3.2026.11.27.09.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:21:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B766F5F8CD;
 Fri, 27 Nov 2026 17:21:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Maximilian Zimmermann <maxz@spacecubics.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 3/3] tests/functional/arm: Add SC-OBC Module A1 test
In-Reply-To: <20261127-add-scobc-a1-board-v1-3-b572280dcde1@spacecubics.com>
 (Maximilian Zimmermann's message of "Fri, 27 Nov 2026 11:13:36 +0900")
References: <20261127-add-scobc-a1-board-v1-0-b572280dcde1@spacecubics.com>
 <20261127-add-scobc-a1-board-v1-3-b572280dcde1@spacecubics.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Fri, 27 Nov 2026 17:21:18 +0000
Message-ID: <87a4mutckx.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maximilian Zimmermann <maxz@spacecubics.com> writes:

> Add a functional test for the scobc-a1 machine, so that regressions in
> the board or its console UART are caught.
>
> The test boots the Zephyr v4.5.0 hello_world sample built for the
> scobc_a1 board directly into HRMEM and waits for the boot banner and the
> greeting on the console UART.
>
> Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
> ---
>  MAINTAINERS                           |  1 +
>  tests/functional/arm/meson.build      |  1 +
>  tests/functional/arm/test_scobc_a1.py | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc02f6e1be..3bea382cf4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1104,6 +1104,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/scobc_a1.c
>  F: docs/system/arm/scobc-a1.rst
> +F: tests/functional/arm/test_scobc_a1.py
>=20=20
>  Stellaris
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meso=
n.build
> index 72c7afc84a..88e567e90e 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -70,6 +70,7 @@ tests_arm_system_thorough =3D [
>    'realview',
>    'replay',
>    'sabrelite',
> +  'scobc_a1',
>    'smdkc210',
>    'stellaris',
>    'sx1',
> diff --git a/tests/functional/arm/test_scobc_a1.py b/tests/functional/arm=
/test_scobc_a1.py
> new file mode 100755
> index 0000000000..41d18cfef0
> --- /dev/null
> +++ b/tests/functional/arm/test_scobc_a1.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots Zephyr on the Space Cubics SC-OBC Module A1
> +#
> +# Copyright (c) 2026 Space Cubics Inc.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> +
> +
> +class ScobcA1Machine(QemuSystemTest):
> +
> +    ASSET_HELLO_WORLD =3D Asset(
> +        'https://downloads.spacecubics.com/development/scobc-a1/qemu/'
> +        'zephyr-v4.5.0-hello_world.elf',
> +        '1578aebe742e4b3fc10af22994de4cd7feda3b54be19486a2efe42c099734c6=
0')

It would be useful to include a manifest/config in the directory and the
reference hash of the zephyr checkout in case people want to
re-create/expand the binary.

But otherwise thanks for providing an image for the board model :-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +    def test_scobc_a1_hello_world(self):
> +        self.set_machine('scobc-a1')
> +        kernel_path =3D self.ASSET_HELLO_WORLD.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.launch()
> +        wait_for_console_pattern(self, '*** Booting Zephyr OS build v4.5=
.0 ***')
> +        wait_for_console_pattern(self, 'Hello World! scobc_a1')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

