Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4117EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxRN-00047Q-Gf; Wed, 20 Mar 2024 11:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxR7-0003zP-74
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:01:08 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxR2-0005mo-0j
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:01:00 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso3897227a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946854; x=1711551654; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhzxbwILTMti/FWWdIIRqMSUBdFZ0ilKHFETrT4oeXU=;
 b=rJcwRZ64Ltqp5qci258aa8XK5jnG9Q1lXmEDpEXm6Ij0qk6rRTi1lMsJbVR6ga8ihi
 H2suodbVCNYgQlouy0i2JH+hu1sOThg2oiFDmKiPw8NAOrDzNIPDWRqCD1U3meX6gnsn
 6d7xg3H1RFVuuiaDF6fZ9YcyhOjxk7XeUMSvbrRGCsNcY6l1GIawVaKP4TDCyTS1r0A1
 Z2JhJ7yS+a1qgl89cqeYiG+MZb+eJca0Ud24Knveek6MKgCqA8RI+UQ6QBea4n1JDLez
 Bz2HUVmV4kUtTw7yk1mlGzb9hs1LVIWBHb0Gnodsdw1lJNxWaOP4BtPS2g03V2w26u0i
 DXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946854; x=1711551654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhzxbwILTMti/FWWdIIRqMSUBdFZ0ilKHFETrT4oeXU=;
 b=REt8UgQcjMoFzpbib5V19znWNRbLkH3zbNuQ/dDMHlxqXVUsk+FxBXCuKh+eyQjBz5
 9XIPFELu5W0/oKd13Nvvu9GjPf44YCrFUeRdW9CSyCl0SxOhz9uQzTbn+WOWS80yDzVC
 rgF/vptHAy91FMSBFOA4LxRyGwlQoUI9lEXmI4/httklUydZHp00PZYnuOsytQVLIblN
 Pv9uZ0o89KPIq9GepRC2sSnx2ac8NPP+BxEmKWQw+SHZL4Fk2mN/vygkSHXYtzn3s3/O
 IyHsqIGesZNIezH4W+fG1TSS9MqKfqzY9O7MumRmdniXJfNgl9oxEqc0eyERH4jPcBWZ
 TGZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYYpZXc9nEt5m2+V+bqhoZcK3UfFtS8Tbk6Kpg8WFCz0aXl3L8tLqCbiTsyFw5/mrT6aV/QXpfK85R8jpox8ko+ocwzK4=
X-Gm-Message-State: AOJu0YzP/UXxjmx/5iLjAsrvFhV/AeXJvAE+eXoHse0vj3HDxkH6kPBv
 TYv3Qpng70a7jUfWFETS/aE9zGA2nCiM/u+YOa8ShBIv/Wsnbg4VNLs3TqiG6GxTI/ogUsp/0C0
 O6VNngp6uclo8bxb5vIQ5Q+AiVBAtO3KcRZd4Vw==
X-Google-Smtp-Source: AGHT+IHwwIZUD6Y4ya5BHqQD9zUue4l2ZwweGBjpPAcXGGQPE/BsDOqlbLmJHYiCn0700zyvJJO6SXHMg1pLSBUVzpc=
X-Received: by 2002:a05:6402:5d1:b0:568:c26d:8718 with SMTP id
 n17-20020a05640205d100b00568c26d8718mr1640288edx.6.1710946853816; Wed, 20 Mar
 2024 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
 <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
 <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
In-Reply-To: <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 15:00:42 +0000
Message-ID: <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 14:10, Mark Burton <mburton@qti.qualcomm.com> wrote:
> I=E2=80=99d broaden this to all =E2=80=99signals=E2=80=99 (IRQ, Reset etc=
) - and I guess
> similar statements apply, with the =E2=80=9Cbridge=E2=80=9D between the f=
unction
> and the GPIO mechanism moved closer or further from the originator(s)
> of the activity.
>
> The issue isn=E2=80=99t my =E2=80=9Cmachine=E2=80=9D model, rather the co=
mpose-ability of
> (any) such machine.  A-priori, a model writer doesn=E2=80=99t know if the=
y
> should respond directly to an NMI or not - Hence they dont know if
> they should implement the TYPE_NMI or not. That=E2=80=99s a decision only
> the machine composer knows.
> My suggestion would be to use a GPIO interface to models, which can
> then be appropriately wired. (And, hence, to have a single place
> that implements the TYPE_NMI interface and provides the GPIO wire
> ready for wiring to appropriate devices).

I feel like that's a long way in the future, but my back-of-the-envelope
design sketch of that is that the TYPE_MACHINE class that's implementing
the "I am just a container for all the devices that the user has
specified and wired together" machine would itself implement TYPE_NMI and
when an NMI came in it would assert a GPIO line that the user could
wire up, or not wire up, as they chose.

Right now we can't do that though, because, among other reasons,
TYPE_MACHINE isn't a TYPE_DEVICE. (I do want to fix that, though:
I'm hoping it won't be too difficult.)

thanks
-- PMM

