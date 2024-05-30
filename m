Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3CC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCYsg-0002uZ-Eq; Thu, 30 May 2024 02:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCYse-0002sc-R6
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCYsd-0000tm-A3
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717048994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1cDL2J2SrawhmoKWEkDoQSCddOndDc6IOl3ob92qrg=;
 b=OueitRm258unCf7q/HxwtT4LTZo8Xg0gxfGOYfzPvsioKp9tqu+27DFmUcnLxoKzByFKU0
 i66SF9AnBRtDBYz9SpLMYjcxjmMv7kXEIrM6mYtbuP2w6gv1u+nelYTU9xiiLO6CgNhQKw
 OgBYlmMThRixJzolJVX/FAKgLZUhv/k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-lR0yK89YPPSjNmmEjWZs5w-1; Thu, 30 May 2024 02:03:11 -0400
X-MC-Unique: lR0yK89YPPSjNmmEjWZs5w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ea7dbdae13so3198201fa.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 23:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717048990; x=1717653790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1cDL2J2SrawhmoKWEkDoQSCddOndDc6IOl3ob92qrg=;
 b=RQpBtQ+1vYm579hu1sPsCHydyXIgOYWf/YE4cX6GJ7j7TyKri0DtPl/gZQmSBc85g+
 A3Frjryrf0AXjD82oq8IeIjTk5BUf/aCk6ex4SLbqq6Z7joYPSurzg4ID2k1Q/j9Pqiz
 IKrdlEBx0IsZi9mV3MsxKsjrQ7XvJwHSEck2fXP03vw6v/c1BvkWs8wi++lYtKaqCfcb
 rJQ2t5AgZb2cmbjpQtRHNttp2HPLiiSe6PCvqVfLMy+c0mJlDj5CB2lWmPJphUP6IKY2
 O6zbcR436UddzvS5sH3b44Ttt5+/VtuLkO9Co3BlYH1k+WXq9RnUrFLrdCVUZWbLnkio
 4Dwg==
X-Gm-Message-State: AOJu0YxqoL4Y33tShLOTwZ2X6IHVkBjWe/iNjLqjSt/tHdSwPPUZHRUC
 s3Lozc5iFjaFdqFMmV3+/TT+cbdZzYlz03p23FnEbzaclj8l6sgPv0Q+aejRuKRr+ynT8bcgK5H
 eChs4jwfTE44gfUCQXn9o+2ESjexaaUMHnWU7Jv6/zjsOtUnoJk3dEXwhn3IPxrKj5/xd4LidVA
 E8lYFIaztRM9OavJy/LNemTwyUTAE=
X-Received: by 2002:a2e:2c0f:0:b0:2ea:7f2e:cee9 with SMTP id
 38308e7fff4ca-2ea8481b173mr5676711fa.26.1717048990391; 
 Wed, 29 May 2024 23:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHVC7HmdhwLTY2COeN12RSlPbwXbQfRi5Tyae6HoU6SqRLrzRbKVkLRF5ZkgpnDzysoCBrLN9KlGZVKp8q/8c=
X-Received: by 2002:a2e:2c0f:0:b0:2ea:7f2e:cee9 with SMTP id
 38308e7fff4ca-2ea8481b173mr5676501fa.26.1717048989859; Wed, 29 May 2024
 23:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
In-Reply-To: <20240529155548.5878-4-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 May 2024 08:02:57 +0200
Message-ID: <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 29, 2024 at 5:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> It is pointless to build semihosting when TCG is not available.

Why? I would have naively assumed that a suitable semihosting API
could be implemented by KVM. The justification (and thus the commit
message) needs to be different for each architecture if it's a matter
of instruction set or insufficient KVM userspace API.

Paolo

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  semihosting/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/semihosting/Kconfig b/semihosting/Kconfig
> index eaf3a20ef5..fbe6ac87f9 100644
> --- a/semihosting/Kconfig
> +++ b/semihosting/Kconfig
> @@ -1,6 +1,7 @@
>
>  config SEMIHOSTING
>         bool
> +       depends on TCG
>
>  config ARM_COMPATIBLE_SEMIHOSTING
>         bool
> --
> 2.41.0
>


