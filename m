Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700A8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByB5-0006B4-D7; Tue, 28 May 2024 10:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByAz-00065s-Ax
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:51:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByAw-0005tp-Ui
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:51:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57869599ed5so1133443a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716907894; x=1717512694; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjSXoMmsHLX28IQaClSUKuM1H9Pzj0WilNUutKhfhFU=;
 b=gpYyUx7J1siUC/cPXuQliam5hyYzUmKYAkmolYTetIOxm137yWOm3rmnhYL4a4yWlz
 foMOFssuexTCjKMCVpxKPRXLP2PXLsOv3KSYlz1SQv7ul4muf1M2WciXw9A2AirYwmfI
 YpLoj2ESL8QH4BDgg4y/pt/2+JVdFzPXV+87e4DLX7lKU5ysnQoYWMKqzQiq2uisxoBH
 PqOiP8w4nhImCclCBXKfDAzdsKXIEQaR4mxsH6mUjimS0QsHkisIzPL5TXq+3jS2STGA
 79V6lVTHoo5jhzYNwCtvAhonPQpXd0Q7uOIO05ii+CqlObOPMkWrImcLl+5NGcqgjFr1
 60mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907894; x=1717512694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjSXoMmsHLX28IQaClSUKuM1H9Pzj0WilNUutKhfhFU=;
 b=OfAAgtgaZREPzhm2G1C6c3ucsjwdoeCaR+hfqdcvSRtn78dAvjo1/0uZwQwR9HUUBc
 QGMGH4BZhhQ54uzlN51k6h7D1+5ypEXL9hx2XsDsIFSxUbCA32OOnnnPCshG7ycRj99f
 ny+7GC2BznmcziaiRDpvACE6zYTjZ+1wAjkcAkst4qA+JP0NWstluoBRXGa1/Em8aeCI
 wn4QHNW1srLIT9QqUcCx57uQzokT49qlAug5UTXdaLGXQjJs87Qvt4KnMKY/PJeH/+Sx
 Un92mJZJOtGEgL88fHuHqtPkt1XhbhwqMuOB3RFhMnvEACCm6edsHbW3DOISZiQ4MJw6
 iHUg==
X-Gm-Message-State: AOJu0YyKnACyVSEgucjqM6xT/mxxuYV8HGRmfgKQ2SZd2g32fURzOTrl
 yywljkUHZOQT2oxv7narI5PkyK89JsW4LFI3bamky7Oqhl6jjgiY6lMDgEhUcaF4aedi7XXs97S
 rbQ5F2vYp599nsG+VeARl2V35ZWvH87YEGuP9sA==
X-Google-Smtp-Source: AGHT+IHk6LgnIMngh0tpeUyRGoN8nQEVjtIhUY3xhBYyIHgt/jzUpoBbTnp9P8FUrtV6BCqPJ67vNb0L5bmG5E/PbR4=
X-Received: by 2002:a50:9554:0:b0:574:ebf4:f78c with SMTP id
 4fb4d7f45d1cf-5785192a71cmr8587923a12.7.1716907894615; Tue, 28 May 2024
 07:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:51:23 +0100
Message-ID: <CAFEAcA-zpnS08qTcuoAPGVLVa6U+ZewGWT97_eE6ZZ9W-TnYmA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hw/clock: Expose 'qtest-clock-period' QOM property
 for QTests
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 23 May 2024 at 20:44, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> Expose the clock period via the QOM 'qtest-clock-period' property so it
> can be used in QTests. This property is only accessible in QTests (not
> via HMP).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  docs/devel/clocks.rst |  3 +++
>  hw/core/clock.c       | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> index 177ee1c90d..19e67601ec 100644
> --- a/docs/devel/clocks.rst
> +++ b/docs/devel/clocks.rst
> @@ -358,6 +358,9 @@ humans (for instance in debugging), use ``clock_displ=
ay_freq()``,
>  which returns a prettified string-representation, e.g. "33.3 MHz".
>  The caller must free the string with g_free() after use.
>
> +It's also possible to retrieve the clock period from a QTest by
> +accessing QOM property ``qtest-clock-period`` using a QMP command.

We should add:

  This property is only present when the device is being run under
  the ``qtest`` accelerator; it is not available when QEMU is
  being run normally.

thanks
-- PMM

