Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9715AD277D0
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRv9-0001hw-DE; Sat, 10 Jan 2026 00:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRv7-0001hL-WE
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:53:54 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1veRv6-0004YU-F0
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:53:53 -0500
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so50512366b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768024427; x=1768629227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mT5azy9eTop/x7ps35SVvRiOgyNftOAc/6RiwumWPCE=;
 b=Lp/A/kp9lvH38Clyaij501vDAugMvVA7+OYemo/zjSuu3o/fPUArrUj1jM9VvYFusw
 FCgCHOkjZn7gJN6U6pMSaId5UgG8z2+JTQfGdAaeKHP5ryDE+wlDQ+lesUDqlD2IdSye
 icSfg2Fj/rNSADce71wXKFDtoyaVJiAEcdoINTuEoLADRjn2TQfPoteIRIenpXUrfvPm
 VKtn0/Y0p88pUfxv+F5EegST7RD8E+heVm6x16jiC+Q8RAX1ZfQd0/pmw5As1Wx7RiMn
 A0D51T3I9gmfRtpcld8yu7Srw1De3pIIOALoL0P/ekH8SmA3d0d5B3OkHJ86+fyyI+86
 WKIw==
X-Gm-Message-State: AOJu0Yz+qW7jwoLYwPCFtAFz+4pglgdgKcI7Fe0Mmp3hQGKXpspmr5nv
 KS3Vnx0IT5mP5T2l4zDNc+DYAw/84MKMoC/LmkR6iUKiADrKNWYYC/0h
X-Gm-Gg: AY/fxX7hWcxcfqX5BX4erDQU81AdTEqbpwXPzbzjbvmWCUptqBxGCj/ApVVqwnLiQye
 8pHa4p8v3GS+pQd5X4Wgqth119p+jdqCPtmwPr/86rJQqHZj7yZdf0d2aXCCTALMlHLQY69OtPS
 LnXCtLFuify+Wz4DCEMUMmhJ7Sl4XTVrBKr5amA5zoDeHz4THTY4YhrNTzAv8c3LERPA66+Icd3
 V0qJ6ln8/s/NKfyfKdqmLXme8jbpE7ffNJVBNY0DdXDFFcyFYuMj5keTkYl21Lnqxqkx0MliKOV
 IrAc5MjYRal6K05Vw+LXQiWCmrKJYkdh0F0hbG+I3b1tvIZWyZKCHkzu3B+uE0ZwWj5ePXMOTuy
 bmoOH5kEUABZHi7I4mz82kshe+lIIlh6eJ3Wiwkpn79v/wHBGhCGSahf7q2oTkzNsazbg2oyLq/
 YFiumrIol5Sw==
X-Google-Smtp-Source: AGHT+IFNSU24NwRSUvhOOLY242Wlu8YeoO8mPHa37E/9wpqhULSpbwfskqGtXXXW59JnEjJTKRRaIA==
X-Received: by 2002:a17:907:2da6:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b8445232b14mr1158177266b.14.1768024426785; 
 Fri, 09 Jan 2026 21:53:46 -0800 (PST)
Received: from tpx1 ([47.64.114.194]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f61d2774sm72212966b.41.2026.01.09.21.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 21:53:46 -0800 (PST)
Date: Sat, 10 Jan 2026 06:53:44 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Bastian Koppelmann
 <kbastian@rumtueddeln.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, qemu-arm@nongnu.org, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Yanan Wang <wangyanan55@huawei.com>, Aleksandar
 Rikalo <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH 07/12] target/m68k: drop cpu_reset on realizefn
Message-ID: <20260110065344.783237f3@tpx1>
In-Reply-To: <20260108143423.1378674-8-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-8-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.42; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f42.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Thu,  8 Jan 2026 14:34:18 +0000
schrieb Alex Benn=C3=A9e <alex.bennee@linaro.org>:

> Now all the m68k machines have cpu reset handlers we can drop this
> extra case here.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/m68k/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f1b673119d6..a540a754969 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -392,7 +392,6 @@ static void m68k_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
> =20
>      m68k_cpu_init_gdb(cpu);
> =20
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> =20
>      mcc->parent_realize(dev, errp);

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

