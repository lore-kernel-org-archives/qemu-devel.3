Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8462DCF2566
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 14:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szclV-0003qm-Tr; Sat, 12 Oct 2024 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szclP-0003qN-8B; Sat, 12 Oct 2024 10:06:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szclK-0006tO-F1; Sat, 12 Oct 2024 10:06:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43111cff9d3so21122725e9.1; 
 Sat, 12 Oct 2024 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728741988; x=1729346788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNDAr0y6ERcyEBg9QJJv0SNUjqAg/Vhk9oSPvoNOt1M=;
 b=RJmGwlh2185LZePQQt1IfO4E9VtuloXQH9TbHn2L3irGTK9rrnrWWrLI7gv37On/S2
 gNV2bMLhAaGBl3ReAYaKEEj7/04e/7lJKREQHcQIkPz5dONN4MGrBgxEdP0NJB+oauVQ
 kCY6eFZwNR5LSlLdC0iyp1n+PQmiEoECS6xLTk7Gsxp7GzLyKHYb+uuSpSbkL3c1nAmQ
 E0VnUkagzsqHLvn0FcVbLGgxPKfsPil4HlNhh5BTCLvrpqyqBfAVR/RHqDiI/UgOYdS7
 Tu6rb5NogSUM3sGwH1VYTsNpgUdCyEZvOH2gOyfvmZJhpt7C6eQxDp7YSIqaxqmP62O0
 riJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741988; x=1729346788;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNDAr0y6ERcyEBg9QJJv0SNUjqAg/Vhk9oSPvoNOt1M=;
 b=GZhu4N1sf6KsSDsB+iUFtKWfqm4c250gY3mva5SBQKagBIzL8nIQee91P8ya4v6f8T
 R4VxvgDE/QMflPcIxaEafS42c/p1jnrh34mxht1WecXw2Yn/478ggr//WrsWJCliAuRI
 xOgT4MIg0sHqLP0rLCzaZc206prDBorTyV8SbQPzSX3iuzgh5IN0T1eUDJJS7nyN76Xr
 PDA3L+Hjk5NPSrXQNBnHUDJhwvRbP3s21QHWwh34/DOwb0ekriOK6HBnEfm0ZqzXYAbd
 AmVlVd/xthXyoV4fqtZS2k613oBJb+z4azdDAz9dA6L4N2WaxahtZOLSJsvKD2k3XUUn
 +qwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBeRJGoxKxksIC/PbP0Aq5kA0jrG4DX9aSWzt+ETgcEorMcoou9adYrgVu6Uc7csGMHES2ZaslcKQ=@nongnu.org,
 AJvYcCXUrIXTfYvj5kRvmBASBK+oOh5t8GnZu5+RU+wNpPx7/guoI+TeMG0pZxL3X/5bxbC99rxggZlRfhQm@nongnu.org
X-Gm-Message-State: AOJu0YyHWvzGxQLNwaCjlY4aOt2bfvqv35OgeXc2ymh9nlXah/vnI9U0
 bsww2m3M7sQmIQX7c6O1zcflHQXyRWc/tt9Csm/lbegAE+jpRrWg
X-Google-Smtp-Source: AGHT+IHtFzxuu/TqIuM58VeXC+YzFNfxxZQW9a+z1YKVZ5hEbY4rUIrup1zBXPb/UgRU5sCEIE0dBg==
X-Received: by 2002:adf:a111:0:b0:37d:4a80:c395 with SMTP id
 ffacd0b85a97d-37d551b965dmr4039199f8f.21.1728741987920; 
 Sat, 12 Oct 2024 07:06:27 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-117-250.77.11.pool.telefonica.de.
 [77.11.117.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6cfa8fsm6408759f8f.49.2024.10.12.07.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 07:06:27 -0700 (PDT)
Date: Sat, 12 Oct 2024 14:06:25 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
CC: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_07/11=5D_hw/sh4/r2d=3A_Real?=
 =?US-ASCII?Q?ize_IDE_controller_before_accessing_it?=
In-Reply-To: <08586e5f-6a5e-445c-b74b-e2c12560020f@redhat.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
 <3434b32e-036a-485c-b3c2-3dd111e6152d@roeck-us.net>
 <7735d722-1047-49b2-ae2b-c95ead698a54@redhat.com>
 <61c38817-3b6e-4bc1-a65a-d2208869c53d@linaro.org>
 <08586e5f-6a5e-445c-b74b-e2c12560020f@redhat.com>
Message-ID: <7CE8EB57-0A75-4AF1-B941-4BC88F9C042D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 12=2E Oktober 2024 09:40:27 UTC schrieb Thomas Huth <thuth@redhat=2Ecom=
>:
>On 12/10/2024 00=2E48, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 11/10/24 05:23, Thomas Huth wrote:
>>> On 03/05/2024 23=2E34, Guenter Roeck wrote:
>>>> Hi,
>>>>=20
>>>> On Thu, Feb 08, 2024 at 07:12:40PM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> We should not wire IRQs on unrealized device=2E
>>>>>=20
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>> Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>>>>> Reviewed-by: Yoshinori Sato <ysato@users=2Esourceforge=2Ejp>
>>>>=20
>>>> qemu 9=2E0 fails to boot Linux from ide/ata drives with the sh4
>>>> and sh4eb emulations=2E Error log is as follows=2E
>>>>=20
>>>> ata1=2E00: ATA-7: QEMU HARDDISK, 2=2E5+, max UDMA/100
>>>> ata1=2E00: 16384 sectors, multi 16: LBA48
>>>> ata1=2E00: configured for PIO
>>>> scsi 0:0:0:0: Direct-Access=C2=A0=C2=A0=C2=A0=C2=A0 ATA=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 QEMU HARDDISK=C2=A0=C2=A0=C2=A0 2=2E5+ PQ: 0 ANSI: 5
>>>> sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8=2E39 MB/8=2E00 Mi=
B)
>>>> sd 0:0:0:0: [sda] Write Protect is off
>>>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
>>>> ata1: lost interrupt (Status 0x58)
>>>>=20
>>>> [ and more similar errors ]
>>>>=20
>>>> qemu command line:
>>>>=20
>>>> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-snapshot -drive file=3Drootfs=2Eext2,format=
=3Draw,if=3Dide \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-append "root=3D/dev/sda console=3DttySC1,115=
200 noiotrap" \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0-serial null -serial stdio -monitor null -nog=
raphic -no-reboot
>>>>=20
>>>> Bisect points to this patch (see below)=2E Reverting it fixes the pro=
blem=2E
>>=20
>> Sorry Guenter for missing your email :(
>>=20
>>>=20
>>> =C2=A0=C2=A0Hi Philippe!
>>>=20
>>> Today I noticed that our sh4 test from tests/avocado/tuxrun_baselines=
=2Epy is failing (which is not run by default, that's why nobody noticed), =
and bisection took me to the same result that Guenter already reported=2E
>>=20
>> "not run by default" because flaky=2E
>>=20
>> Having a quick look, the problem seems hw/ide/core=2Ec uses non-QOM
>> shortcuts=2E In particular ide_bus_init_output_irq() expects a preset
>> IRQ=2E Not something trivial to fix=2E
>
>I wonder whether the other spots that use ide_bus_init_output_irq() or si=
milar constructs are broken now, too=2E Bernhard apparently already fixed (=
reverted) one in commit 143f3fd3d8b51d6526c8ea80e8a2a085f6f01cdf=2E
>
>But what about fc432ba0f58343c8912b80e9056315bb9bd8df92 ?

There is an indirection going on in pmac_ide_irq() which triggers real_*_i=
rq=2E These get wired via sysbus API after realize() while ide_bus_init_out=
put_irq() wires to pmac_ide_irq()=2E So fc432ba0f58343c8912b80e9056315bb9bd=
8df92 seems safe to me (haven't tested it though)=2E

Best regards,
Bernhard

>
> Thomas
>

