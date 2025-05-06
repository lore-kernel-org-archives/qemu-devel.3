Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95038C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHyC-00069j-Vl; Tue, 06 May 2025 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCHxd-00060a-U4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:03:54 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCHxb-0004WI-EF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:03:49 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e730ea57804so5824252276.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536625; x=1747141425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/bcdDUY+C/t2hToe+Kzm5dxVjMfO/849eno7rwZanU=;
 b=eGxw7viM1QZBzxdzFSqnxoMNh97qpwxEiue6Xb6RBozTzQ88SzM4Nt0KZEpCgZCI0V
 hBgMbFdZ2zrQpn9M25Qm391Iu2c0SWetHW6teOMcPiH1p1aUaQTkMldPurMNz03yXQ1C
 v2LBDr3XraOxC8xZxX4IsvmfAoG/cnyioFe0pY6jua/uoql1k8jLNK81bWEejVM0u1T0
 y1OV3dkfjd3VkN+lS2EalDL7KvPx22Vt9j7II30FnVwAegxSz5JenHm10uEs2DQn9SK/
 uDpYD0NnjbtG+V15BZN7kHq4WCDsxnN08Itv6OecS+QpPztnAP4DKwFjbyAUeKkzzhm3
 my2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536625; x=1747141425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/bcdDUY+C/t2hToe+Kzm5dxVjMfO/849eno7rwZanU=;
 b=kRUiQLjuDxS1+Z3RNKBfp5fT9vfk3Y2uZ4XMXJM+zUgrlj3DS9JHs2Jpu49GPKyNTC
 BkdhAI/DySKbvhWkeOQacd7RPyFYPsxaPEEWbRgH8ofe51nuh1kSCm1dsEp59OOAO2Jh
 zYKZg4n5TCWfYIwq68mbuJJ4b/3XqoAI+CLn/8Y3SwxFMuVmy934ximUuGMAdfEOT9l0
 +wI2n+MXFKKwOcNqhioBjFqcIggWSEgsECc7HnIWQNL877nNeD6kXtvMCcqSX6R2sGj6
 +GBbtuwxmNjZ2JYrefTpDg0XyDCTbHbIKigSLeRRrD3bG+wnuPGu7cLSMGWvGzgq0xpS
 Hanw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG9WduxV2LhDgZIaVrOyK8HFU80qlH58B98PcfVIEVJEvHADLapyDtS1+TZvfP7419lMArVFvLQ1pE@nongnu.org
X-Gm-Message-State: AOJu0YwztmOx3dZiPx4DBXuOIBdJ8La+u9UqvP/+hOFYMB6NsE2+O9Bd
 iaZ6fSRbqtXOcWnegOgO57wm2RIpmsOXBOrrLw7YENgn8oMywhTho1GHTULZeuU9odQMKpuLMDA
 pgdqt/wUF50zkNwnvbt4QqzJtL8aSOa181ACvgQ==
X-Gm-Gg: ASbGnctdKFWGw9Njkv7aUwbO6+70fqEwttiM1KikHC5ynZeXRFKMH38dY2xLg0JcB0J
 BmbIQ6hEmvUVBxfcefenm8NQg7wV3539txV50TW/kgRa7jIZZGmxa6xZr1wdkGDTwkXaspykORp
 zAfalnNYMeCBcIPu5HngXy+bD85zYX5b+1HQ==
X-Google-Smtp-Source: AGHT+IFF0L+0f7KS3WIagjGX3+R3LwGNLmKErThLNK3QyF2WET510Lg/ZwxX9Z5/NTBsVbbragzs+pMyjHLZedbcw+E=
X-Received: by 2002:a05:6902:160c:b0:e6d:ad5c:9962 with SMTP id
 3f1490d57ef6-e75bf0f7f88mr5038581276.18.1746536625309; Tue, 06 May 2025
 06:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-2-shentey@gmail.com>
 <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
In-Reply-To: <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:03:33 +0100
X-Gm-Features: ATxdqUH-AfM-Df-NLOPUcNbneAyvDgmNiQWlUCUUOoruLeLydKlo165fr-PrySQ
Message-ID: <CAFEAcA-8A_r9TooHUcrt26hvP0w5cH+mbjo5wiP+=8VX0chDVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/pci-host/designware: Remove unused include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Thu, 1 May 2025 at 20:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 1/5/25 20:34, Bernhard Beschow wrote:
> > The DEFINE_TYPES() macro doesn't need the qemu/module.h include.
> >
> > Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types usi=
ng
> > DEFINE_TYPES() macro")
>
> The 'Fixes:' tag is for bug being fixed.

No, Fixes: is for indicating the commit being fixed, so this
commit message is fine. We use Resolves: for gitlab bug URLs (though
gitlab itself will parse a URL out of a Fixes: tag too).

We mention this in

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-mean=
ingful-commit-message

with an example of use.

thanks
-- PMM

