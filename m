Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D7EC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQJc-0005bo-7l; Mon, 11 Aug 2025 07:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ulQJZ-0005ar-PI; Mon, 11 Aug 2025 07:03:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ulQJW-0008E7-3T; Mon, 11 Aug 2025 07:03:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so3249892f8f.2; 
 Mon, 11 Aug 2025 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754910211; x=1755515011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lqViJu6EMUf99JpKXyeEW3Tdx48VGPHnUo/zeHK1gE=;
 b=dFQ8o+ryVs80mU9KxeBU652LfYjsqZx15fo2uSO8n3c9hPiySOwIWqirH7tDakHVE2
 VV/M+EDftIrnD7bE3NcWn4KT0+MbeZBeko6Hv9ZZufc/7+xfunkpU6I1z8rZOWD2u272
 YY/x0oVSa7rQWlW05URoijPJzEsib5CBIirZsX9tjVpAwaqLESjDr6vibddArQEkSCXv
 SNjUKWGsv2Uion2rAzwOYX1PIavcf2eNM9feHORjFYV3ba5dvHWwho2Tne/QdB9zn1JC
 9yb6SiUrN+cjIDqud6a0JGdIJOZ5LWm+FLsY8Lb6TFuck+g/wj16UbveLjWWrsueiFWw
 mBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754910211; x=1755515011;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lqViJu6EMUf99JpKXyeEW3Tdx48VGPHnUo/zeHK1gE=;
 b=neUuJ2O5Hhl/MJocE4wc+LtLlq/yX2cKSJ491Ep6vWwQHme2jdGc1yVVq6l7TBlxne
 4zUlhalraRnhhQzcBC/5Flc66DhSNgdXXfQmIYkO0faE3TGtybcjfJkSMb37zezFprem
 aewFhyRqB0idouFLqYaw2uOZNURwp/keOopyBBvIfbUXkpcGGJxWhn+1Y8KqPSwsbj1K
 5mFvhkA6wx+xX2EspD6D5tGMle7/4UEzFHbMji4hpbjB/+rXPHLWBDVvt2Py/IfuozbL
 IxquPy5vt2poVZjbgfuBba0j4Wdd6sgiTKrVtXUKNe+IMFHZE/EgKsf6vCKDK10JjXe3
 4eYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGkDbGldPBcEMKlqvs/ARwfVDDH5DPnmLYodPJiznCmevgtu+Q7MP0jSCCofqxHDwr7SO1/IZJw==@nongnu.org
X-Gm-Message-State: AOJu0YxDwKoXH0RuLOivzLpZfWO5Cq6v6YaT/K4lo2OYmA9RoUH9Hi+c
 z5jVWZLemH1zt0sIFrvUFZKvZGVTlXaPyyum/T74aXoN8L/PNdMBNjqj
X-Gm-Gg: ASbGncurlTBTV6BBQj8D7PLQK7LJN7+TBIvfctMbFuEsaR/+XExi8DETCaS8VWFnR10
 fpOSlqLwGN8DupQou+e7FiMsiX8TxYy95LdvjikNH+/hGwBzhMKA8JjdGPudMvThlVWGJHxK2Sf
 CszJj7c93cncKO+XrLtQbrGA9cr3HtmlWc6D5litJOe2/WshjtTo3r/ZCbuyRmlPJk8+xxIOkJ/
 MTOlf71Tup5FjJZj3EUE0hxvvQRrzuRkRxqO+P/9eM1/AvZ3S1bHMuMB2l+vata7O1yYPkQ278c
 tE3XVJIXM2mFAwnjJ02rCEZvGI3U4fIj6fgFJYJKZT3o9vxQpRr47cDgBLZgJKDML6HunDr2zrg
 XasaEW5fZJKW2vrnoO4PNGF7tq33N
X-Google-Smtp-Source: AGHT+IGnUhIDJmQGL6BLVd3OiAcFi/Q5nJRBQKtAIRNOD3tpieIpPVyWi5WyGHEMC/1fvjOhaqUbeg==
X-Received: by 2002:a05:6000:310a:b0:3b7:9dc1:74bf with SMTP id
 ffacd0b85a97d-3b900b74bf5mr10816207f8f.35.1754910210934; 
 Mon, 11 Aug 2025 04:03:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ded356b9sm328436685e9.12.2025.08.11.04.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 04:03:30 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:01:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <3DA254A8-76AC-4214-8C65-D3B3FFF55FF9@gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
 <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
 <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
 <3DA254A8-76AC-4214-8C65-D3B3FFF55FF9@gmail.com>
Message-ID: <57BBA45B-76EB-4922-8611-9596C9B37CCE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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



Am 8=2E Juli 2025 16:36:03 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 30=2E Juni 2025 21:03:06 UTC schrieb Peter Maydell <peter=2Emaydell@li=
naro=2Eorg>:
>>On Mon, 30 Jun 2025 at 21:22, Bernhard Beschow <shentey@gmail=2Ecom> wro=
te:
>>>
>>>
>>>
>>> Am 30=2E Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>>> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail=2Ecom> =
wrote:
>>> >>
>>> >> Allows the imx8mp-evk machine to be run with KVM acceleration as a =
guest=2E
>>> >>
>>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> >> ---
>>> >>  docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>>> >>  hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++++=
-----
>>> >>  hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>>> >>  hw/arm/Kconfig                 |  3 ++-
>>> >>  hw/arm/meson=2Ebuild             |  2 +-
>>> >>  5 files changed, 49 insertions(+), 7 deletions(-)
>>> >
>>> >This puts a lot of IMX device models onto our security boundary,
>>> >which makes me a bit nervous -- that's a lot of code which
>>> >wasn't really written or reviewed carefully to ensure it
>>> >can't be exploited by a malicious guest=2E
>>>
>>> Hi Peter,
>>>
>>> Does KVM increase the attack surface compared to TCG?
>>
>>Yes, because our security policy says that TCG is not considered
>>a security boundary, whereas KVM is:
>>
>>https://qemu-project=2Egitlab=2Eio/qemu/system/security=2Ehtml
>>
>>(It would move from "non-virtualization use case" to
>>"virtualization use case"=2E)
>
>Thanks, that document nails my question=2E
>
>If KVM requires the imx devices to be inside the security boundary, what =
needs to be done to lift them there?

Ping

>
>Best regards,
>Bernhard
>
>>
>>thanks
>>-- PMM

