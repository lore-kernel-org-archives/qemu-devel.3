Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9AD2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jnh-000605-UW; Fri, 18 Oct 2024 06:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1jnc-0005uB-GY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:01:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1jnZ-0003ij-IU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:01:36 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c99be0a4bbso2567071a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729245691; x=1729850491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EceJMD5TFFW28sEBYAnTnnk355nDba/Ev8Vf3NXQHxQ=;
 b=bxoB28wMp99mJ3xdNiD1smbu3C6RV3s8THKyANCI4hbIwyyld61C3mvZV8t8m7okyx
 ohQEPfdbpdkIQpic1Wg2E/loMynNGFvrgyc5z/1mABqo3ATcy30+ha0Vpdfckumxy/4h
 OwG0GPyjVapd9DHVq907q95/UM3C5Jim068GigS1iRoQ+uvLT3NDR6mCEQZNGW8V/Hop
 azPIWaqO/7L95t+sY0fk73n5rI69TDDlONpSGe2XYIAyQVS/Z002DBLhCCSOV3mGVJ4z
 f/+hQwa+hQfsm2LFaWFWuV3fgJMBlJtXX/7F+0TcMFhEqacEmCPBVJLkpteTxth+hghr
 2XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729245691; x=1729850491;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EceJMD5TFFW28sEBYAnTnnk355nDba/Ev8Vf3NXQHxQ=;
 b=q//nASvIXLoQglVX459zwD/XQyvkKPuKOcWboB7bq8V15BFqiq/+y0rEeViCFXKkWX
 qHTk8iaFiImtNLEc47JkAolsL+FZIsb3aYPvIpToUZJ4JxE+D8Cn/3BuUK9CbDA8v/UN
 xGDXncFwFyGPrHFMNcUu330JJr5XR/f9e2c6mZRXi1dVchWOO0KZvkE1UCPD6Hbda0Rw
 yMJXxkfEWkUoUwJmSKFB0m0d8uUoOsMLJ+vSk9Xbe5Vxx9IVmvtphxiBG/xd9yK3G+t2
 7oN2y+4D2uQij9g2X+c07gjovdy5sUtSX7GxCXugD0075o+6hrlz3bYgCUpxTMJqSp04
 3d4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnSKOW+v2sOhBQI3NM4NMJxBpDVY3AXzxYVb01I22Ln151++9+Aq4jyXHdExzHgZf0Gr5cqPrq+nvt@nongnu.org
X-Gm-Message-State: AOJu0Ywom19QtR9XhSVwtS4cUabXKRuSSz2WSsnbZWoymSg4+z8lGpkT
 jHIDMDtB86OBcbQVGE7nw8pvRCyDoqtcAaWpQ5LXdJe2H+PsOyz+QIHQ6ZEZNos=
X-Google-Smtp-Source: AGHT+IEDSxbCrlx25fjyK8bHdzmrM1cAxNXPz/tyNwGjzf/ZGH+OdLM0Jm8+kkTlgW5Frk6BCtFLAw==
X-Received: by 2002:a17:907:7da1:b0:a9a:2d04:b577 with SMTP id
 a640c23a62f3a-a9a69ba71d2mr175520566b.32.1729245691269; 
 Fri, 18 Oct 2024 03:01:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68a8d9e4sm73106566b.9.2024.10.18.03.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 03:01:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 413755F863;
 Fri, 18 Oct 2024 11:01:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,  Linux ARM
 <linux-arm-kernel@lists.infradead.org>,  lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,  qemu-devel@nongnu.org,
 Arnd Bergmann <arnd@arndb.de>,  Mark Brown <broonie@kernel.org>,  Catalin
 Marinas <catalin.marinas@arm.com>,  Aishwarya TCV <Aishwarya.TCV@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
In-Reply-To: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 (Naresh Kamboju's message of "Fri, 18 Oct 2024 12:35:13 +0530")
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:01:29 +0100
Message-ID: <87v7xp91c6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm devices TI beaglebone x15 boot pass.
>
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
>
> qemu-armv7:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> -------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=3D1=
0c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction =
cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
> limit (0x00000000)
> [    0.000000] cma: Failed to reserve 64 MiB on node -1

Is this a highmem related thing. Passing -m 2G allows it to get further
and 4G is obviously at the limit of 32 bit?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

