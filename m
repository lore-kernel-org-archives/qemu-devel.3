Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4649C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9T0L-0001PQ-N1; Mon, 28 Apr 2025 14:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9T0K-0001OE-9c
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:14:56 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9T0F-0003tX-0r
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:14:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso10762079a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745864089; x=1746468889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjKNiikJyBmirsKy6pyuiW7Mn9TwxcAn5BT4pMvqRA8=;
 b=hfM63/KKPtNkNOUiO1KY5u10jxZB/AerTwRS583fTZLsMVX6VULx8KkRN1KQLhyPJY
 Wi+UYX2fQdErwqlbeNwTjdTmiV2XeFNU61j7KMcp974exCk89Pom0NAVTUV97AUjGgTA
 BjR3wueg/O2SOoYx+3Knxd8uyAOQ8mudQMuEz9N4pwlnp//9m99m0gpzKlt9gcElbKm1
 /ihQWzQfVDZqNwxy6hR+CzM0YLcc1Z5k4GEDzMnVsZi0ty03DxtZkYAv1IiL/RhWM2MI
 icWc3IM0ql4MLQD1NThYrZVKnv3dW3Tf+OuPrLx1HehGNCKLzhrDZHuU9crungJcaBTJ
 FJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745864089; x=1746468889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjKNiikJyBmirsKy6pyuiW7Mn9TwxcAn5BT4pMvqRA8=;
 b=gRmz/Ep4rndUA+7PhTOPIAZJWXBF77s/v5EObOqiw8TqL1uH3WlDy4MsEHSlPfMmOr
 +pwJ1TRRIEbirc/RiujudduSqY7lqEZtArpXJhwDoYKPFeXv6Eu7d7T2z7u7hobgAmPX
 Oix0KyVGLq5CBAFWO8bEh2NtPTqaabTrLLkGMHvXy33ffYYt+uPyoRT0Sy+SDuyINMUY
 fGKRS/HuAXWWMSkzYx+kZs3rTtSqtICnnvVvS5SvL1ZcMAI90ybfiYmz9Em/HsZ1clVO
 GjK+2ezVGViPMEIm+qAH5NsSP+b8o0Rw33SM7nQlQSRKpCnZIOsT5YzlX+mthiFItJ1l
 lYiQ==
X-Gm-Message-State: AOJu0YxrGZQE0VEipyMKfJrXmUt/2aixAVOPxNNjzzlNJRVdhKnXne9u
 9dLvJTHx5gBBicytXSXUpsKTxBd6hz43XAZXb/7S2sfpQ7cLeST9U9lnMUK8BPEuv9keCeqfuhE
 as7RhWpkwi+NHKTedD8q+vI/E+ME=
X-Gm-Gg: ASbGnctJkSutInoqjETo0f/78MOGW4oNEikbWXKpq+gsewD/gOoEFNQz7RlEcymAuAV
 HrlYLDomyEqb4181SfNlNu36XgmFiR104DrIKsSRxO+0QN8MxczaP0G0impSlM1F9mrhNkFLDZe
 LMAbKrXQSgQmHiI/aRz+W1/ismNRHk6q0=
X-Google-Smtp-Source: AGHT+IGLveNjqXkNXWtKi1nj3N6hQkoajrBtS6IGYKS12jwcgzD+uVXjeUIU+KrSdd0koiXMP9h7iliHXfaBYRoK27k=
X-Received: by 2002:a05:6402:354a:b0:5f7:f4ff:6267 with SMTP id
 4fb4d7f45d1cf-5f83930aeaamr162935a12.17.1745864088520; Mon, 28 Apr 2025
 11:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 Apr 2025 14:14:34 -0400
X-Gm-Features: ATxdqUFrgRvrp6WWbL6mBi8UrJj2kn1Q1TRwqOvUqEiJMVrZ6MCcsNHsVqe7IXY
Message-ID: <CAJSP0QUXuAUxMLOz5Zw1zwk0zwBRwuFM=qCufwf0TLr+w1YXvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, 
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com, 
 philmd@linaro.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Thu, Apr 24, 2025 at 2:35=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> Feedback
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The goal of this series is to be spark a conversation around following to=
pics:
>
> - Would you be open to such an approach? (expose all code, and restrict c=
ommands
>   registered at runtime only for specific targets)
>
> - Are there unexpected consequences for libvirt or other consumers to exp=
ose
>   more definitions than what we have now?
>
> - Would you recommend another approach instead? I experimented with havin=
g per
>   target generated files, but we still need to expose quite a lot in head=
ers, so
>   my opinion is that it's much more complicated for zero benefit. As well=
, the
>   code size impact is more than negligible, so the simpler, the better.

Do you anticipate that Linux distributions will change how they
package QEMU? For example, should they ship a single qemu-all package
in addition to or as a replacement for the typical model today where
qemu-system-aarch64, qemu-system-x86_64, etc are shipped as separate
packages?

It would be nice to hear from packager maintainers in this discussion
so that there is a consensus between developers and package
maintainers.

Stefan

