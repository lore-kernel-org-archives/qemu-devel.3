Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8464AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 18:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seemQ-0005wh-GA; Thu, 15 Aug 2024 14:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seemO-0005uR-HJ; Thu, 15 Aug 2024 14:00:56 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seemM-000572-PM; Thu, 15 Aug 2024 14:00:56 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so145119866b.3; 
 Thu, 15 Aug 2024 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723744852; x=1724349652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOQc+5zO7CSq/GtXLID48S0mhlJ2bEPY+p0uacqItBQ=;
 b=aqKPW/tPoJ8UsllFmtjlpC/uFj02/tP1qhp9imelK6Y2lWvHWTehbuvF76RnsYdLkM
 NRemKGtYf8Y6RMeWT7kYHTSa9JbrTbyc+lu0M7lIpYrjqyCIaQcJRkMH6wJ/ACn37ram
 W6MhUyZghxtMiRGzLnSewwfXzEweZzveArU/mVeRa1M8IL02jtOv+xByaGwMJkWQmmpG
 Qu4JaJlpjKeW/h+ERo7oU2JsXLrdt6RGI37U6sRrtTB4KK5hv9HMS7/113IiLDIGESGC
 G2IQ8V3xuuFisKwcEOPuepaHKFYVZj5LN1X8wVGLPfgFWCIoDTF4jIKHCRCd8uaWDNOX
 6DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723744852; x=1724349652;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOQc+5zO7CSq/GtXLID48S0mhlJ2bEPY+p0uacqItBQ=;
 b=U4k6XPTy/MKF/tGzZBjkHCUITjhiiWmqJJhORJK4l9OXPqFHCvHf78mE6AkZ3Q/ypO
 SpCdwgCkXKPsN1CEfY/9p8PdoP8WS4szTF8egrLpl/Q+MB3Mqi/P14m07ksGku/qqlbu
 NvGD356qqAsUJHXZk+SKVyA/vPYfozQVQwXYyVDeNuzXw2d3nhE/BS6bS1Lj35cbSPWn
 +02+hLSs5hoVKzFQUeRnur5LrJQ0ycz5pJwkbdM2u1OxpFv3Q3HFZKtPM5hOkH2W7w4z
 hlZJoxROtF4TwIq8t91GBGntevp7JlPeQM+bCzF9W/bjE4Ufo2KRvd1G7tpnSrFjqmVt
 weLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvTr8tB5+5ifuigLH1ffkRtV1h5ngN9VPRapgwC+GIH3+aFD04fYLumcepZFR+Jb5+UJFa9xfJ36HuPS4rrgr/uuc/aR2whvpZawJ+M2mK4CoTA9kzyKBy5Bcg9qpZtdQXs6ZAtWIEVGZJOKnlf0s=
X-Gm-Message-State: AOJu0Yx+XxqzlX2mEJHyMECuFskND53BJJitWhRYJ9OmY9RYoWee6rmM
 ++e+O2DyudqW5g6pBlER85eEpDC3+vJWVB2gBNqgYImkacy3PigU
X-Google-Smtp-Source: AGHT+IGRxu2jk6UyhfB3zEJOB3mlBAbEn0uq8BpMCp4DgXW8pPOcNFPTqaJqqkF76SZjfoWA3pMOVg==
X-Received: by 2002:a17:907:f7a4:b0:a7a:8e98:890d with SMTP id
 a640c23a62f3a-a83929300d4mr30503966b.16.1723744851636; 
 Thu, 15 Aug 2024 11:00:51 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-188-051-121.77.188.pool.telefonica.de.
 [77.188.51.121]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6639sm132090266b.7.2024.08.15.11.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 11:00:51 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:00:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Jia Liu <proljc@gmail.com>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH 2/5] hw/char/serial: Remove unused funtion
In-Reply-To: <d8ffe38c-756d-4187-875e-e6697631b7fa@linaro.org>
References: <20240814181534.218964-1-shentey@gmail.com>
 <20240814181534.218964-3-shentey@gmail.com>
 <22fa9014-2923-b501-e38d-f5dd1e53d15a@eik.bme.hu>
 <11aeac5f-1985-494e-941a-5115d5e679bc@ilande.co.uk>
 <d8ffe38c-756d-4187-875e-e6697631b7fa@linaro.org>
Message-ID: <907C7F7F-924E-4051-895D-7D61B2485CC0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 15=2E August 2024 09:26:38 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 15/8/24 10:24, Mark Cave-Ayland wrote:
>> On 14/08/2024 22:38, BALATON Zoltan wrote:
>>=20
>>> On Wed, 14 Aug 2024, Bernhard Beschow wrote:
>>>> The serial port's frequency is set via the "baudbase" property nowada=
ys=2E
>>>=20
>>> Please keep it as some devices might have registers that set this freq=
 and this function will be needed for emulating that even if it's not emula=
ted currently=2E
>>=20
>> Why not remove the function if it isn't being used? In general having u=
nused code lying around is bad as it tends to bitrot=2E
>>=20
>> If someone did want to re-add this functionality then you would likely =
want to do it with clock API rather than using a separate function=2E
>
>I also ended using it in a branch including this old series:
>https://lore=2Ekernel=2Eorg/qemu-devel/20200806130340=2E17316-1-f4bug@ams=
at=2Eorg/
>
>Not my priority anymore, so I don't mind re-adding it=2E
>

This removal seems debatable=2E I'd err on the safe side and drop the patc=
h in v2=2E

Any further comments?

