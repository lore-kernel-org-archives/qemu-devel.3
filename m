Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E67606A681
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7AwYxdM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQH5-00029r-Cq; Mon, 23 Nov 2026 04:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xVQH3-00028Q-AA
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:23:45 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xVQH1-0004Oz-PA
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:23:45 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c4d21051042so494445966b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795425821; x=1796030621; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U3h3aB3iPc4yOQ9kzDgmCyHPvpi9IbLxvcB+SYUpspI=;
 b=O7AwYxdM/7lpKeU8IlwSop41fEiLOy7xKEW+vQLnj/xLNmAxJb5NBGvcVduZ82TH6C
 uRjboiAYnoHb4IYzP6BKOmeLmhPZZ1R8Oa1ojl1OkdWM8N5z1Pjw2Rw8ZpCPlLUDdqdg
 eyiymycBwDsYNGggsxqPQZZaMzU5EtcJpdH5MAjwHHM3nOFPJJnjya4All5UF2vcnV6X
 yhz2dpLI/aO74nR2xwp314OR4FMPf65UMwSYUiA0y0KEpv+olqSbkmpZS2nFaEXjpiq8
 PUCTuOVP1g3fWieiHtz/S6YN0+dG83udidMSeLB5PcpKIStcQsqxwlwCgNiGMWvKhC8a
 grmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795425821; x=1796030621;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U3h3aB3iPc4yOQ9kzDgmCyHPvpi9IbLxvcB+SYUpspI=;
 b=zaB07oGrFsE2ZA3Wundh/henr6ejZjP8raYPrmpRbo/tgvW9LByMkgVYd7PwuQHD0T
 RciOBJZR+71EkFdZQcnESFOVVwiUDylOSAixIiua9PhUHMrHF3amB+llJz5uW4U3Lg+n
 bO4lxYEJZzIqq5rMTzqSvy73kXte4eKEgEJFcZvo2vFrA9Lb6oya8ykGsEzPm7ja4oLR
 NaDtVY0Ej9K3Y/eIyrCo+roxnGLFHAiF44EdoM7h6X+RIMwD/0pU4LLbCiMBTzYqETwz
 5hTthI8EWGtWC1gL42FC+3KJPDzKr0jfSqaCT4IE4baxtvI2ZgylMqInJv5Tkv5NWxvv
 BQPw==
X-Gm-Message-State: APuU4Z+gThrJslk7OA8ugGG91pdCzm1Rbwxegt1wE/jJIMUZohlF06Ld
 JcIasB68Zm7AMzsm/+b0vKURH3l2SSokt3aS+2u820fydf6IaHE9eLHm
X-Gm-Gg: AZFdTZc2GCuZdMf+C686sCVClfKHooDg6f1bxTNHUG4p8G40kg3ro03eS1SImCpvpVY
 ZKbYVGfeOZYOMQw7xHCPufbLL9d6qDDIdR4OdoEptwuvrdYueXZBMB2SyMrNhhgtcNN+qjAz7hf
 ceEmNwSZ1Bnr7m8GfeO0JkAZIP+g/MA+tGyN5kOJUrSLWlAaf1zltVIj5iFhRF5/ZuSoFKHTX4f
 VuNaC7DyEruEiirXzACkTyTMBD1ln4l+IarAw+8X+thuzFlzRgBNG8XP3O0d42gQb0nncJBETZQ
 veFhxZGEvPb1KHySRoi1Td9Y9oXjt60wIsOwOXgtacdXReEN6igmv4fIejFuBPspxKy7BlIR06M
 ll7A/tN+Ly5O/tDQ7R3H+401opbAdmR6Q0csgr0b6CH7vHg5D6U++Wgj734JzodWPxCORYcYbYw
 CWWga76er3TmTU8JMUgBirCultPcr4lwXKkdz8AevBoUIvj0gvpR60SuxHH90GChTyXYB/YTEXo
 YQBLRjk/8x40onosMuNM9clEL5b4VsaQvfbtHnsshL465hglVCrTYw+ggx9pc7GrSzygPtYEViE
 mj8NvltMcRzsnruJSUWZxhS87dmaJQMC0e8pcgadNdU7jit3JAHpZJu1s0huw7Ig/OV+vBHfcTw
 VlbuVr/pF1vPvjMGjQyBzdVTCuDHljYLKmcGb+I3Ijs07IQxuNjcfnxzXw52IHTQ=
X-Received: by 2002:a17:906:b34a:b0:c50:f08a:eed5 with SMTP id
 a640c23a62f3a-c513a9aa13cmr681932766b.34.1795425821132; 
 Mon, 23 Nov 2026 01:23:41 -0800 (PST)
Received: from smtpclient.apple (088156177242.warszawa.vectranet.pl.
 [88.156.177.242]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc5396sm377539266b.58.2026.11.23.01.23.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Nov 2026 01:23:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] docs/system/target-sparc64: mention sun4v-qemu-kit
From: Dmitry Pimenov <sun4qemu@gmail.com>
In-Reply-To: <CAAM0arP89Yr1fU5r5KPxLqAGnUt6QAy3uta7Ztoj_jm5CBZaPg@mail.gmail.com>
Date: Mon, 23 Nov 2026 10:23:29 +0100
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2788CCD-4F6C-4D7D-867D-02E654E0DB15@gmail.com>
References: <20261114162002.1995864-3-sun4qemu@gmail.com>
 <CAAM0arP89Yr1fU5r5KPxLqAGnUt6QAy3uta7Ztoj_jm5CBZaPg@mail.gmail.com>
To: Artyom Tarasenko <atar4qemu@gmail.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=sun4qemu@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick, Mark, a gentle ping,

Artyom: thx for your support, I hope the project will be useful for the =
QEMU community.

Regards,
Dmitry

> On 14 Nov 2026, at 17:31, Artyom Tarasenko <atar4qemu@gmail.com> =
wrote:
>=20
>=20
>=20
> =D1=81=D0=B1, 14 =D0=BD=D0=BE=D1=8F=D0=B1. 2026 =D0=B3., 17:21 Dmitry =
Pimenov <sun4qemu@gmail.com>:
> This patch adds the reference to sun4v-qemu-kit; it builds the set
> of firmware (hypervisor, OpenBoot and binary set of machine =
descriptions)
> for the Niagara machine based on the OpenSPARC source code archive
> with some changes and build tests. The kit can be used instead of
> S10image/ firmware.
>=20
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
>=20
> Great work, Dmitry! This is really important step towards making =
OpenBoot really open.
>=20
> Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
>=20
> ---
>=20
> Artyom, Mark, please look at this project.
>=20
>  docs/system/target-sparc64.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/docs/system/target-sparc64.rst =
b/docs/system/target-sparc64.rst
> index 97e334b930..24d5883cf5 100644
> --- a/docs/system/target-sparc64.rst
> +++ b/docs/system/target-sparc64.rst
> @@ -20,6 +20,10 @@ and is able to boot the disk.s10hw2 Solaris image.
>                         -nographic -m 256 \
>                         -drive =
if=3Dpflash,readonly=3Don,file=3D/S10image/disk.s10hw2
>=20
> +Alternatively, sun4v-qemu-kit =
https://github.com/unix0cc/sun4v-qemu-kit contains
> +a set of components (hypervisor, OpenBoot and machine descriptions) =
for building
> +the Niagara firmware based on the OpenSPARC code.
> +
>  QEMU emulates the following peripherals:
>=20
>  -  UltraSparc IIi APB PCI Bridge
> --=20
> 2.43.0
>=20


