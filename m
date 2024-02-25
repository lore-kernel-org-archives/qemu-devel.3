Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE648C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 10:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reBW4-00043Z-1O; Sun, 25 Feb 2024 05:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1reBW3-00042l-3f
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 05:13:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1reBW1-0002nT-Kz
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 05:13:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412a38e2adaso1248435e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 02:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708856026; x=1709460826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBXZ9J0/Zlze/JPL2U+lOQRWTRdTl/DqXPhVpkiunvE=;
 b=KFRHH07SZux6dtN1VaXkpUL1s73LM1oFOfNEYo88XRBgXfJ7pBURdsD+rSYAPu6XN5
 Rglws9Dp6npQv9ZKgKV2j3McI9qmpSRC0ROY+VN4wif1q25uUYzSLJ0AjKvazAz/0h+A
 Kcom/B4BGxj/ItWeLi3U9zdmqZ7SAOtmz6RqUJ8HC1axP7XU0jwVNTdifKrZml6vWYXw
 be0eJvQbq/sDz8vW1Q0pnvnHvtOZ2SH8SgcW64Zj/8cRvGR1/Eodup61XRlv/qtsbvi3
 xo2BuqJfiDm2PFnY9/i14qQLSgSlp4Y22vMYROkikcLHnEDPC16WaQuOmg/l45xRzWgR
 gCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708856026; x=1709460826;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBXZ9J0/Zlze/JPL2U+lOQRWTRdTl/DqXPhVpkiunvE=;
 b=QH3IkrBoEa9LcxNcsUQm1yxzJl0o9/QWCm63y/5rMUyRTZ6/oZ3dLBe0RkzapHQ9jy
 3Ff/EFamiPJ9sNFhn17zjwLNdL3VDTbCXpiXdUVk/YJyOzjL0RFWdrxEIZuN2YpmccaJ
 8SV9snQC+ZWhL0Y34Jhd/auUS800r36etc7ptbYyyleSDPGJ13beARF5AeoledJfEzNk
 EWEoMxxmq0PluTrbwA8VJvV4PgJvg307sfnxkYSt682LSPExR2H/pDX+jSOytueJzmL/
 KcPiBJRsxmKysjO2y03WXP4+slG790515jVSg9ZTFpC97G6ugFJYrVXq74q2bZWXyQf4
 Hw/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFuPsGGXwvPx5MEnwmQP79/Tz8GTAHZuJnKTFtFKDBsJL2XJeWdHOsIFzN6xaS7f1rf/7ICOOIwAijyeSvQOBHneN+K+A=
X-Gm-Message-State: AOJu0YycESt3E2RtemJJqtTDjCJkROzPxN8TDkXlmYK6OZUhO2sZKLNZ
 OlXfwKHMwbgnWzC826ABk0m38vpVzxYgpicDCvbcu31JNSfuqsZr
X-Google-Smtp-Source: AGHT+IGo+BHQ8YNkO8xH5EpR0MFtcBysEVzUL5nQu4KqE7frF6AA3QbCsUsoKG6nWaoKDo9BneTq2A==
X-Received: by 2002:a05:600c:474d:b0:412:93e2:4f8e with SMTP id
 w13-20020a05600c474d00b0041293e24f8emr3989774wmo.12.1708856026322; 
 Sun, 25 Feb 2024 02:13:46 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-236-043.89.14.pool.telefonica.de.
 [89.14.236.43]) by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c4e8600b00412a0ce903dsm2246692wmq.46.2024.02.25.02.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 02:13:45 -0800 (PST)
Date: Sun, 25 Feb 2024 10:13:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_9/9=5D_hw/i386/pc=5F=7Bpiix=2C_q35=7D=3A_E?=
 =?US-ASCII?Q?liminate_local_pci=5Fbus/pci=5Fhost_variables?=
In-Reply-To: <002d9fca-56dd-4265-a79e-2850fbb1a822@linaro.org>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-10-shentey@gmail.com>
 <002d9fca-56dd-4265-a79e-2850fbb1a822@linaro.org>
Message-ID: <676FB307-D0DD-49CF-A9E3-17287BC751C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 21=2E Februar 2024 15:50:33 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 8/2/24 23:03, Bernhard Beschow wrote:
>> There is no advantage in having these local variables which 1/ needless=
ly have
>> different identifiers in both machines and 2/ which are redundant to pc=
ms->bus
>> which is almost as short=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/i386/pc_piix=2Ec | 14 ++++++--------
>>   hw/i386/pc_q35=2Ec  | 16 +++++++---------
>>   2 files changed, 13 insertions(+), 17 deletions(-)
>
>IMO it is a design mistake to have these fields in PCMachineState:
>
> 27 typedef struct PCMachineState {
>
> 36     /* Pointers to devices and objects: */
> 37     PCIBus *bus;
> 38     I2CBus *smbus;
> 39     PFlashCFI01 *flash[2];
> 40     ISADevice *pcspk;
> 41     DeviceState *iommu;
> 42     BusState *idebus[MAX_IDE_BUS];

Any ideas on how to resolve these? `flash` might be easy now=2E What about=
 the buses in particular?

Best regards,
Bernhard

>
>Anyhow, back to your patch, please rename 'bus' -> 'pcibus'=2E Maybe
>in a preliminary patch?

