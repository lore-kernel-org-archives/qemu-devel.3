Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C861C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwA9-0003sD-9E; Tue, 25 Feb 2025 09:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmwA0-0003rk-WD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:43:50 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmw9y-0001Aw-Ni
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:43:48 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fb7d64908fso48341277b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740494625; x=1741099425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBNy19b/C2sAJP/mSokGEuCO6HlNPkFcNqQI5DINW4c=;
 b=yu0x1eAMAg3xp5hEcwOzvArQY+6o4gLOeuOYwSTY3at7adAGk5iTcbvuvnBIHy54GV
 IaNCFCWCF2puWrdlZYmTaRjEEqmJahg+b2UWWxfMpTf9H+YVidvXhD66kFIi67g7pkV2
 MDan1N5BJE+1Aqu/x97jf5gWQuZpHrzZwsturEaOz//v/QQSW1MXXQ0rSaWTT6cozJqa
 WV7GHt7rwAMvsdDSYeIKu7StDAd0fmJue0W55aGUfmoYPRw+BnpL/ZPPE/mCqJsIPc8S
 I06iTA91+KenNYyWUnXJ91m6kkT9RYWuYPZlwGjK96X2VxkD5aWSZR6/C3rVNyeh7HhA
 NSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494625; x=1741099425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBNy19b/C2sAJP/mSokGEuCO6HlNPkFcNqQI5DINW4c=;
 b=vfgRGSbFbiGg19trQ3G9M93B3KCkd/5/Xi2Tc30BTZzyxMevazWihYQB5rBO5wD9F0
 cyJwBEUOD0OEDn7JoaRPTWcy5tSI33N4y7KbK66BPVBfyCggZP/HuGw7eQ8JiktZgfRw
 kuajj+4fKwzuyLfSxHtCZs3jxWyYqSXwVDrJJBU+9Sxyu5fTN1H94ill3eF7tA3tT5Tf
 uxsi09I6ISKTmGKzZNcIIAK+8/MF7MIrS2sdxWqqv2M7y+W0qXt7tGX4pYy1odrUXn2j
 QWFDfGqmfUyOZMvXtt68FXl8B0i6+R8xTdksI3BQdMgTZ8pTCKPC0TdSW3PcGctlrzdS
 WgRA==
X-Gm-Message-State: AOJu0YwWwIoH0OttPGx3RSdD1ZZ0Q3DzKYxpHxUiU6RDKJFora/4Clij
 WWzO6FbELiBNXUMIre5NIVHZHFBe5Ntt3wP1p7e52Ezm2QiDbTXw4/CPVgw1OgBwMHlhA8tacr3
 xj32Zz7K8meITcZgX1y4gRFjmIG8sO62zvOL1Eg==
X-Gm-Gg: ASbGncth54nbLHg/GXWGeO/Yk2wRqSwH3r/TZ3JooXxo4cUZzgtSQ5hCqgUuJ9ztFEr
 893wY2+kwpCSSa7Kst5nJ1Lq117egWRhaJJdx6dA/C5Ovmsp6yjHmXpHc9Hf0g/NBIg0klCTzD4
 Bs+6N4honQ
X-Google-Smtp-Source: AGHT+IGGZcEP/LhT7rHzMnO/aRrOHp1SUL3p6e94zMNLS5VytA6r9xOuyVvFImBTpUPn90TaTY0W/RhIOicnzcABG0o=
X-Received: by 2002:a05:690c:6c04:b0:6ef:4fba:8153 with SMTP id
 00721157ae682-6fbcc23498dmr149955887b3.10.1740494625275; Tue, 25 Feb 2025
 06:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:43:32 +0000
X-Gm-Features: AWEUYZmhBOOPqyuhlExC7SyMb1-fy4JbTYnKLYVcxsVePox3tnXcSJaCGp_CyHo
Message-ID: <CAFEAcA-2KXeCVKrx0VQ1axA+nbTKV2fpy--Mti1Q+yFL5XC5KA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add i.MX 8M Plus EVK machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series adds a new aarch64 machine to QEMU: i.MX 8M Plus EVK [1]. It =
allows
> for running Linux distributions such as Buildroot
> (freescale_imx8mpevk_defconfig) and Arch Linux [2] via direct kernel boot=
.
> U-Boot does not work yet. I plan to use this machine in CI and I also wan=
t to
> make it available to a bigger audience, so I propose to add it to QEMU. M=
y goal
> would be to have it added for 10.0. For this, a Changelog entry could be =
added
> under https://wiki.qemu.org/ChangeLog/10.0 such as:
>   * New board model "imx8mp-evk": i.MX 8M Plus Evaluation Kit
>
> The series is structured as follows: The first three patches fix some iss=
ues in
> device models reused by the new machine. Patches 4-17 add the machine ste=
p by
> step which includes documentation. The last patch adds an I=C2=B2C RTC wh=
ich I'd like
> to use along with the new machine.
>
> I've based some code on existing one (see "Based on" in file headers) and=
 I'm
> unsure how to handle the licensing and attribution correctly -- advice we=
lcome.

Hi; I've applied most of this series to target-arm.next:
patches 1 to 15 and 17. I've left a comment about what
I think we should do about patch 16 (the bootrom).
Patch 18 (the RTC i2c device) I don't have any objection to,
I just didn't have time to review it now and didn't want to delay
getting the new board model in until I did find that time.
Since the board code doesn't instantiate the i2c device,
the RTC is kind of a separate thing from the board series
anyway.

thanks
-- PMM

