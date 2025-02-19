Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF78C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 09:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkg38-0007R2-Da; Wed, 19 Feb 2025 04:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tkg36-0007QS-Tv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:07:20 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tkg35-0008VQ-BK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:07:20 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30a29f4bd43so34017161fa.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 01:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739956037; x=1740560837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3tdTfryVPdtwZgDV/erzap7TmMSVaJaeES8kYodL6M=;
 b=Rt7n2y4deUQDvTDgGj/gEmbHxQGHvSa0hchvd1j3R0x+ZnI2o0oYU5ueEudJHqeeXY
 H2Oec96MF+WooUjG2qhHsslYXQ5knj++Z13nmIeZPOuj7RlUt25gmAxoH2OiCo1///5S
 +hPJdztS9x9lzJV+Ejh+/g5DixjXiywcuEhfK+8ujs4C3Bi3c1ytjfDi9n4OS5VscHmG
 arwVVmDta7nhOPJqm+AEDeq2WjHfbbYR69iBqzlsk/7lTZK5S7Yp0AI7M5Onii8mb1R6
 XiT+GNOoi6wznzCaQVx6gIes9gJMf/1dIiDN+W92rn9p8QhyrpGP3UH/0jlNCn7Fi5ql
 nevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739956037; x=1740560837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3tdTfryVPdtwZgDV/erzap7TmMSVaJaeES8kYodL6M=;
 b=hJ42gshodWtVOe5S/K8z40RY8yf/mBsVq2zMu/15h+nvVsuf480hssjTKHleMRryK6
 Z0cGpvT3W6d/QgqyHiwXpeqhsYUi+4QfTv74znafEHZsdQQOEIq3mNp2264Jrtc3LxjR
 GrJWktr8bpac9HRuYbule5p8/C8Nuw3Jg32NOgiaosuBj81pkfqqaDQo8pyox5Z3OcXE
 mH3m/6EZBi4K4q9nncbyII7T5hId57XyJjiDp+R4aWW4IwIqhAQhL4mlWAtVTQXGv/Ro
 mz73zUHQVHzcw3k+WM0Y3iaZD6Cdx2R4/SWgarBRpv2fw0iIFHFSeOm54+j+psQ4dqYz
 pI3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT5xEdJ+AIRojlHqnj4GeJN3TiRkzEgcm0cdst0MgRSWavW5MFEDdm1DT54d7DN9NGTZkZJ1q/SlQV@nongnu.org
X-Gm-Message-State: AOJu0YzGvo2Y9a1kMoydBMwdLBZfeuWi9HJbjcsAc2w1jOX+AHokkxbT
 T8E/2ArZJLZaVLXeiZHpVreazcZSr6r5HDwASr46cWh1gs+WiLc4qdrCiZYdHbbKAFtt8QQhGoq
 2uKuxyUJUOxDEePuC673bqqE2V4Hh0g==
X-Gm-Gg: ASbGncsbuCJCyx+lB5DlkxBCo0PgiJQi/9+osrGaXsClLY4zbK4vfZQaZewJngY9la1
 +lWmkUCP4ABODaMPDbs9uPCxNE4EGf36k7NdwpEgQ8TLu80ljnXzNycv0ZiTBDjk3Y/g/T5LIzp
 PuvgRmdiuMx1zNYySKLnIVRXoUzxo37g==
X-Google-Smtp-Source: AGHT+IHDp99tKxteCzUxdlFjIViqG9p3wZcuhIe0djFVghqkSZv/gz9HdUD0qpfczyU65d7mxe8CDyMcL2ZyoKnJ/I8=
X-Received: by 2002:a2e:8650:0:b0:308:f479:5696 with SMTP id
 38308e7fff4ca-30a44dc4ff1mr7723721fa.15.1739956036991; Wed, 19 Feb 2025
 01:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20250123085327.965501-1-r.peniaev@gmail.com>
 <20250123085327.965501-3-r.peniaev@gmail.com>
 <87eczvhelv.fsf@pond.sub.org> <8734gbhehi.fsf@pond.sub.org>
In-Reply-To: <8734gbhehi.fsf@pond.sub.org>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 19 Feb 2025 10:07:06 +0100
X-Gm-Features: AWEUYZldpHzBukBfWDXz5k3LuEGAHSYYj8AirJ-Pb75q1Kxrxw1x9ucyqV40tf4
Message-ID: <CACZ9PQXS2bKZFfsz3DgtAGgW8K60-gJhujQXn7PQ89OXPhL=2g@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] chardev/char-hub: implement backend chardev
 aggregator
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x235.google.com
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

On Tue, Feb 18, 2025 at 8:57=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Just realized this has been committed already.  I'm not complaining, I
> was late.  Address my doc nits in a followup patch?

Sent. Please take a look.

--
Roman

