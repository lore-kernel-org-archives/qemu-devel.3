Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E6AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 00:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv4hL-0005id-Af; Thu, 11 Apr 2024 20:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rv4hJ-0005iE-Au
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 20:23:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rv4hH-0005Tc-PW
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 20:23:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so909567a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712881394; x=1713486194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yonxxLD33/2mwRqBfF52xYF9OYL+BxZtjX2YJskTSQ=;
 b=hVwTKGQws/k9nJ1PjRxv5JAiHrO8P7UGecvbauV0nyXPst/9K+tSzlYIGLOqIUCUW8
 AaTVtPcm+NclESbR/70Xh2vueedKFVbFCCvcT4z5Zi70j/jpDpmFkT3e5unQFcAALEoO
 S07pPksHc4vyt1db0lJLlOyvwyNExyFSlKrs6wGLFKP6Le9lT5731YjdBzaS4x8kzn74
 ZTXrXES6V/nY+m9HXwkmmQ5t2LDJTA93mlFUsMIpbwiZM0Jk8OkbKvmWDmJkIiQPzvIa
 rDOP3OGMv2h1DLxF6pWbEu1tzbPAtbdUMUqJyr7nhFFxMlhHNQv1TXqNrpkkbj1Dce/0
 OG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712881394; x=1713486194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yonxxLD33/2mwRqBfF52xYF9OYL+BxZtjX2YJskTSQ=;
 b=bjNP8NGnfuEdhjlC5z3CEJ5iaErPr1zyfkU/gXYm9L+niey25DrB6HGQfwfYakiDHB
 dmSZg+OWtKFeS8+A5Xc5bW+fqyDSxH+2wNRIAlLajf36pJ8Mi/hxHLDPVvIXGsvIiKqs
 VGc/NzcWh/ztlJgmtR+9ImBHrYtsDzEZD1z5rU54Qbiz2qBeLMSetPLF+QRQ4LZWZftq
 AvM37lOr2q5P8iTgRaQcyrXXBmuGF2bYWJmw+xFGMHyPZ7AJhLDFn0jMw12XxRgh/N7o
 qZzc7SAeJNDktcGkgLANvcm+Mm5pTXbGVId5hHWrjrs27r4JOlgMUbPkTqJVQCT4S9Kx
 jPPQ==
X-Gm-Message-State: AOJu0Yx+OYKZ5LnV3n4pD4ypOVko5wpwr9wkSiPidoyIDYGZ2FtqWRHh
 daZYyfWa/s9uzcJngX0RZnqvNb6C+TtJ5YKG8+A/0gxCCSMO+B1PX2tRyBdsoLhR3DfroiLNqpM
 PCFxHG4nXHHJHWf3YQ8xLEDi4GH4Yqg==
X-Google-Smtp-Source: AGHT+IE06Q0bELPC965EOUcUdGG0HnQ9fh1s6I0NMqF1lmoYoIWmdjBcxP8iDjcw3/oaFwoWsmoy3QdSRaYFM2giWDs=
X-Received: by 2002:a17:90a:4987:b0:2a2:b436:60c5 with SMTP id
 d7-20020a17090a498700b002a2b43660c5mr1516424pjh.22.1712881393528; Thu, 11 Apr
 2024 17:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <a60e71ec-93d5-40bc-83b9-99a635e8d1ab@app.fastmail.com>
In-Reply-To: <a60e71ec-93d5-40bc-83b9-99a635e8d1ab@app.fastmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Apr 2024 17:23:02 -0700
Message-ID: <CAMo8BfJCCOYj81LaO4fB=PJo3tY5005B8OxWizG5DX7QcbLTAA@mail.gmail.com>
Subject: Re: wiki.qemu.org account access request
To: Zack Buhman <zack@buhman.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 11, 2024 at 5:06=E2=80=AFPM Zack Buhman <zack@buhman.org> wrote=
:
>
> I noticed the recent SH4 patches are included in the 9.0.0-rc3 release.
>
> Is it appropriate that I request a wiki.qemu.org account so that I may do=
cument these changes in https://wiki.qemu.org/ChangeLog/9.0 in a manner tha=
t is consistent with how the changes to other CPUs have been documented so =
far?
>
> If so, I indeed desire such an account.

I've created an account ZackBuhman for you and sent the password off-list.

--=20
Thanks.
-- Max

