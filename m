Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF698C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP3c-0008J8-Mt; Fri, 09 Feb 2024 06:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP3Y-0008IU-GE
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:28:33 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP3X-0005YW-3K
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:28:32 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d0d100336cso10536951fa.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478108; x=1708082908; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVRNJ5p55LHs7bd+FTD4T8V4JGjiCxSFKRowjKQ6E1I=;
 b=DSV5iL/1TH5RIMAhWDCAVzw6MFRcS0E2Fmimsr8AmWyRu3zeTivY73RFPy9am0sBxe
 NQEfXoKy3m/6SAI/XL1okSWre03RXN4vz5Z+v6OzYWKdsBz11NAylIVkGOIh1ofZQyG3
 x1IjwsC7q4wnjJIXk3JUnbpbysuw7V0stn9wXo0OYs2/O9z9xRk/khSdYAtPMUA3VcD2
 tsAKLw4gKCyo7XE8l5FyzSraJcgftS2gCWkd51gNiVTCwJeL7umNeRfr+jFL1ketmNb6
 n4l9YUiytWtYVqf5Iy0+7eO4luy6HK/rIkeh0PUabJUVdm/K/jVYzPEKUvqUjWg7+g5x
 3pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478108; x=1708082908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVRNJ5p55LHs7bd+FTD4T8V4JGjiCxSFKRowjKQ6E1I=;
 b=FKAYPMiREdvPWKFKuvGU3kTN/O/ZQ7auE7h9+zoPnUydM5unKiqx3rM7Ufp0Qlc5NH
 BLzZe2PscdGTJ2ltNn7H3UOP2yz5hDOkoC7xbG76qPO6V5OG7HBIgj84yICV2UicmDrK
 BxdLE41+Kaxg/4iFR/C1Z9gc7Jd6xvcfIkcwXNddIMgDAaJthkNuOtuHNQD7fD3sc95e
 T5p23Y12c2oWv7Kk7Lz22A1hYLFLk+gCPQw69cMNZ3BSrZq06YykrmJ/qR2aPt1Nwfeh
 RH/TmR7R0onxXTsvNzs5/6Vu0kO/gfnY7bTB9MtBZWZO0sqOlBVyJjCHbPtwsIsellIB
 zI6g==
X-Gm-Message-State: AOJu0YwiRvHgGlyNPlf04MjEB+l6hl6HvY1OhjjzSDrng5g2uDRZzRYy
 NWDNWvvnqR6TiiZhKOhPP3t9/uMaiSny7mZI7tfOmLWlZh/JBCt/RGmrQtS4n+IJFzv/D9ryBSU
 4P9mjT5QGa09lhU55sgYuyeZRMO4kyypsfvlZrw==
X-Google-Smtp-Source: AGHT+IEuE+2yhnNdRTAZ0ICxTlV+zk5WtbRLDbKi+O0jMmB52rP+Af+m0udSXBoJzZBRI3IJFhzIz1DrPOA9W0sgjL0=
X-Received: by 2002:a2e:8899:0:b0:2d0:d42f:30b0 with SMTP id
 k25-20020a2e8899000000b002d0d42f30b0mr794190lji.33.1707478107887; Fri, 09 Feb
 2024 03:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-2-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:28:17 +0000
Message-ID: <CAFEAcA-xKtoU-df4+-5fABHAdnbeNUtszCmqtidcv232abB6CA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] hw/ide/ich9: Use AHCIPCIState typedef
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 8 Feb 2024 at 18:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> QEMU coding style recommend using structure typedefs:
> https://www.qemu.org/docs/master/devel/style.html#typedefs
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

