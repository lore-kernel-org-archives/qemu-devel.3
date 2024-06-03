Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61936C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Br-0003zm-8i; Mon, 03 Jun 2024 07:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE6Bo-0003vb-EP
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:49:24 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE6Bm-0004tR-JS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:49:24 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52965199234so4776961e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717415360; x=1718020160; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8jPNW0Tozh+QZZXxP04g+BQ4E04r6JuB9PMkEbOJjA=;
 b=l0IF10u2Mp5vFFXe0zeBNcJqaXDZ851K707zY+5H+b23wV9OPQh6KmcJvCjHNv5t6Y
 2ljbyimhGq9yIa/6/Irt442y48pLEiivdrH1YAdK51gUAuy18mKyTRVxEnvlNwBBEhHu
 nr7x/clXxd9O75M3Xj8Vtj6GsXZQIcBtvJbOJfsQGa2QibUB/rLlsAN+yGKqAniQQGKs
 vk8b3gdaf0uyKJbl66esBBCUqPasQGgEIbqFOJsppcM+4lqsIxmNb8jaCamyucc9i8bG
 ZM0JiK2xNWXZ96uj/htuPBsSS9qqbq7UgA2mFpkThK2GmhR2pCvYjhnKFMpLtCndVUTn
 kHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717415360; x=1718020160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8jPNW0Tozh+QZZXxP04g+BQ4E04r6JuB9PMkEbOJjA=;
 b=Oq2yzEHaUcce0qi36Vl3kW2jLAlIv8kIdaU2+en6rucPAcQGwjLLGY3X4UhLn0E0g0
 mqS8KRy4MlatlNg3tkCohnOAYh6CbcrRPQ3tb5d2T2hAZYg2bT3lJTAs0L0LnoBXxADJ
 nmUp4oyIuqWzPVYt3DXlwsurRu/utrbISxn4wFu+kG4j8evNrImYQvBTqjrYVs2/3rNZ
 AsE/pSnqEAgzt2mnq3Ya5QTW0Z8Yqigiq4hMDUfcYrHLx8OBw1pB4Q+8ykPRBUA+Wrpx
 oS7KPoEZruW1ppq+JFwWLIzBWbgjUsJnrvXLrDuoHwAQZYfoRidQrP7Z9wqVZW7nj5aX
 vB0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWErmHKcls0kx81rAy0fBiohk9IO4AwUX+MDA1krkf9qY+65K4kbBPL1JoF2HQJEOxf20t/hO/rn/y4pPaghzLnp5HQ7us=
X-Gm-Message-State: AOJu0Ywbe1gfvNpFfF0IyJMgXjQwl3GR/M6apRcI+N4ujPDpWI4v9yIK
 awc0Lx2Iz8UE9Gm/zTjmgk8qXDOObu2gVukWK2fK3HEIbmdrS2bZ53LWIIoUbrGPN8ls2xjYGqe
 B2Gf997YcbVr0t8pDBKmjm5yttR81+1w3k5h6hw==
X-Google-Smtp-Source: AGHT+IH2fIDr3CK0aJzJsIsyrVaR4pnrxTJAEhhZpjvyys6vDW5Zh+Vqa9h1o/H40COeZwgJoOBXH+VrFVrSCa5eRU8=
X-Received: by 2002:a05:6512:5d0:b0:523:8c7a:5f6 with SMTP id
 2adb3069b0e04-52b896bfb9amr5551379e87.51.1717415360196; Mon, 03 Jun 2024
 04:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
 <Zl2rxIYdohROHXbg@redhat.com>
In-Reply-To: <Zl2rxIYdohROHXbg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 12:49:09 +0100
Message-ID: <CAFEAcA-NW8GJ5RZf1kq+_nGBMX1wShw6Gxnezw69gRRrga44PQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Mon, 3 Jun 2024 at 12:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> I think there's different answers here for upstream vs downstream.
>
> Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
> may have existed at any point in time. Emulating Cirrus is very much
> in scope upstream, and even if there are other better VGA devices, that
> doesn't make emulation of Cirrus redundant.
>
> Downstream is a different matter - if a downstream vendor wants to be
> opinionated and limit the scope of devices they ship to customers, it
> is totally valid to cull Cirrus.
>
> IOW, I think device deprecation *framework* is relevant to include
> upstream, but most actual usage of it will be downstream.

Right; for upstream we should expect that we use deprecation
mostly as part of the "deprecate and then drop in a few releases"
cycle. Deprecating something we don't want to drop doesn't
seem to me to make much sense in an upstream context.

thanks
-- PMM

