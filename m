Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C710D14B4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Cjt-0007td-Fc; Mon, 30 Mar 2026 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w7Cjh-0007ss-Hz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w7Cjc-0000xy-Np
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774877571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOxi7fKgKQHSlxeUZj0z7gZ+MKblkggFRCHoQ79uXTg=;
 b=V2SSI4jPVQx0Gb5o5qrGxkY7trOWqy+b4aAtXVAVx1b95M5exZ6JrZfxVJ0b+phsuoSGQA
 ciN9soO8E0FA8gCXhCjUR+eJGd78yVB2yPPl2jHluI024z97HlbtRZF7BaSVUpFNMIlx6w
 lzpLBQGu0gdCnJ8G33stlQGiQzrJNnc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-371b_ixWM3Ofm8NDDxuQ_w-1; Mon, 30 Mar 2026 09:32:48 -0400
X-MC-Unique: 371b_ixWM3Ofm8NDDxuQ_w-1
X-Mimecast-MFC-AGG-ID: 371b_ixWM3Ofm8NDDxuQ_w_1774877567
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354bc535546so4796421a91.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 06:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774877567; cv=none;
 d=google.com; s=arc-20240605;
 b=Vz5TiF9KIbmxZ3n7z1pRTtA8MaoD63IuUXRwVOBBJsoU4rWa2WZtEGYWLiE9yvcryq
 wsP12pBy+jeyIgz6M/A/si1YdSNmRu3kzf2CcokRsy1opgQxdVBt0vGxcHUUtLlAkD9a
 R3JMI2wHVIOtW4fGmyo/OutFDBpW0c9cOsHZqWyGxA5rnqBgzVytI31qiisM16+Bttz5
 THig9nJPFLtu//fNBPotvoRpOgiGR4chWWEQZrDLW6k6ClIDhRiJktAYOJ2zI2QT8ezR
 5MMV+Ogi3napZVoKuBzTfey0276+3OqV9llkLiSu56B/xp6J55Ke5ftYzdCpFeIMoqFj
 QVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oOxi7fKgKQHSlxeUZj0z7gZ+MKblkggFRCHoQ79uXTg=;
 fh=EWniKeIfszlfnDB26qAHaemGMaRBqF3O/t8w2qOqYiU=;
 b=F2vWqjVdOLotlxF6YdCKCEewb/TY1K0O05rz3FJBb+p8xhjxt57L7RKsjliJ63eoiW
 cfgxIB7y8qVawOaLeZF2lfhYfWZQr07gmVlKU7VzPXhh9maj8yu7jyWt5aiyGv6x9k8d
 fhLqkdphs2tYM/G7rufWEs2eyoASBeOvnZMNaoSfPDSsSuVZ05UY9kWsgwQn3+LTjN3V
 ZrmXOwgz7HKCrqoYtNDsrqpayCDSQsvkGvpMB3oF06/k4EZBuFTs2izaJ/ToGv6wfW64
 xrV55cW9dLac14J1FQnUUUhjIkh0tn39Y0dIrK0CtEXm52kx0HFx/CagTR+XH5+lLM0R
 pXmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774877567; x=1775482367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOxi7fKgKQHSlxeUZj0z7gZ+MKblkggFRCHoQ79uXTg=;
 b=JizUnyhaHSLrKWzIDeoMRnTODyQhE8h1qlTHZnK1ocsSt8JbD8sk3iqRDE1aSfiBFx
 wKwhyOj98qz6Vsu9yaPo24a5JQg+7K240YppVAxM3Z5GnsSSyHOF0SDl4SDynkG8XKDh
 QUwiyTJi0o/76GudJZo8SRSc2JI1WyVULAWmZFVP5jvtNRa/SaqXH3QcATQ+sJjHnr3m
 FylZrWzbNfSqO4KUubScGNKUSxu8ViIHGiCIGZ5V+hDK93AHMDI3HY1ZmqTFE8YZz34o
 kLsbhF5Z4A56Kf+0FRUs4dpuX5Vqb/GSAuKYKQgEOI0cWngK4dZNs8o4sherqTYRtHTm
 cx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877567; x=1775482367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oOxi7fKgKQHSlxeUZj0z7gZ+MKblkggFRCHoQ79uXTg=;
 b=ircgVdKmdlYOfH7ZzBeKNbjn2g+A828RThdy5M3Amz3Zipu59cVHbhruee7zZlH08U
 Ia3o6guA8AEiNm+wGxDFQYRddvpkepTGf46Ybc5CHFVnX1hxTAwVM3aPaWjIO7HrlYWl
 S9CPZJ4gYh7qYQlLdWO8oCYAs7opvNz2uS5MvoyToUdN7CukvHEAOqhkRblP2tHmO3BL
 DvDGnCUxahnTVytuVxn/vo4sxs0Bomg/xmFUGjusNy6XWpgxG6lZ0m297v/9Vct3wx1i
 KMcQh7kt23yemHKKRgS1jiGT8eUtU+91d6tl4I2Fvn8SaBCEf7MAlHYpHeUW3FxjSvvo
 p+Bg==
X-Gm-Message-State: AOJu0YyCrX4UhrEsMZi/13K0geukzRablDusSDYxFvGTTWyY7iEeczu8
 pzix/jPF74orWUQt9k1PTlLeWIjLSN4Zg2kzCZqlkFrepsdDef6HHCO2CbmxSK7mPmb7UdenuFn
 fKhEfJFVo8hl3nGQrEv2+QK/5qgDoUIwVf/FxcL2fGGTXgqAgSpWIE1pDtzWXkthH4w9VEybZJ8
 SKtBqMO+ziFvASQoECeMKZ9gUObMOq0Ls=
X-Gm-Gg: ATEYQzzkYDVIqg+0swqfMuLbmBaVXQL/PIN4RoBIFZUixqiOMh87xfecwef8C+TZ35T
 ZfEb3faBJSaRyFt5u7dBDBrakPcCeyxgFXvawa2r45G8QinZR503E7ARUygLFQhbprLpv9gdqg3
 VMwPVCdHQSYVyIPpzG7me7SLq+qpBw/pAOLQN/3Ofad2/R4BzkgHmLjJ8Ws9QmpYXu+no025cvP
 uG41qRyZN0CGWHi1xC6ZZLJYPBot48dYDLCKWMbURV/ZFaatPxcBHzvgIzg1oXQmWxwdqfD80ai
 71G/WjFT0WjVU54by38+fDU=
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id
 98e67ed59e1d1-35c2ffb6610mr11089236a91.4.1774877567033; 
 Mon, 30 Mar 2026 06:32:47 -0700 (PDT)
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id
 98e67ed59e1d1-35c2ffb6610mr11089211a91.4.1774877566605; Mon, 30 Mar 2026
 06:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
In-Reply-To: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2026 17:32:33 +0400
X-Gm-Features: AQROBzDPONr1VGz71Z8hvvuOnSyIgsgJn676wVGaYFK39huaCbV7aFLn8maTpMg
Message-ID: <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
Subject: Re: [PATCH] meson: add missing semicolon in pthread_condattr_setclock
 test
To: Stepan Popov <Stepan.Popov@kaspersky.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Mon, Mar 30, 2026 at 5:21=E2=80=AFPM Stepan Popov <Stepan.Popov@kaspersk=
y.com> wrote:
>
> The test code was missing a semicolon after the pthread_condattr_t
> variable declaration.
>
> Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>

Fixes: 657ac98b58 ("thread-posix: use monotonic clock for QemuCond and
QemuSemaphore")
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index d7c4095b39..5447504ea8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2882,7 +2882,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCL=
OCK', cc.links(osdep_prefix +
>
>    int main(void)
>    {
> -    pthread_condattr_t attr
> +    pthread_condattr_t attr;
>      pthread_condattr_init(&attr);
>      pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
>      return 0;
> --
> 2.34.1
>


