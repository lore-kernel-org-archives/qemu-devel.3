Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD5CF07C4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 08:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syofa-0006Eq-AJ; Thu, 10 Oct 2024 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syofR-0006DF-Pt
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:37:06 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syofO-00076g-JS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:37:04 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fac187eef2so6738901fa.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728549420; x=1729154220; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68oPv/5lbNaKJwpFDSbXIcpydRwcruQgV79enYFEGiA=;
 b=A8sXHpL6anIfhMdbvlnSKpcd5quENwfEe76YoFYkBP/E4Wx+eYUqrZR82hEbJ3BhG0
 gbyBc+wOaR1K+whiY0VYfLvhV+ffBCKpMewdiBlrxHkA1q6lefjz2QoOTbfwIg4NO56W
 /F7Ql3c7kTITNLwW2/yODP/JdEx84+VZYmuzHDFEchrLOLiI+lHn7NEL4ogbddh6Zg57
 jdhCyxb1Kn88HULoWmJtRHLcEYQ3W+pd7+rfdRjSi6huKerlha7aHvLkmeRR0jk2JrVS
 OT0gAioHxNY5hXoiaGn+oCDkAZuEZp4mr3xFJty3qEJkyPFwmRsPqZSrW0zZ/LuTZVzs
 7lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728549420; x=1729154220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68oPv/5lbNaKJwpFDSbXIcpydRwcruQgV79enYFEGiA=;
 b=JUf1VxiB1DVPa6BT4PyJpP3wloItiss2mznA56Tfn9tZgJTeBKy4arn2HD4oyd+CB0
 bIRku3nazL4jQCksOfa470IFiFJ/f0OlE5Edm6sesg4ghkz0vfjIBFinYOkltII36Oeb
 JCGfWhCVpJTWWrvncOTMdBaIXK/C3JslrlsYwX+mwvMuoITHkYLiWLwjhyBHLA1nF4Tg
 +N7tgLHg06UyDL1psXFbmeqV0aiIrRMS2XYJInai0vm7eWCp//sm8nra6rU9o5Qw1sFu
 E0er45w+SCtaOPhIg72BPkfrqbjrwzK3g63X2Kffvv3eeuiBt5JNIXW688Be4tlXH8PR
 5ecQ==
X-Gm-Message-State: AOJu0YytejZ5rNISRBfel8Y197SRLMtuHBI+kizDW0F8ogmVfWYwjt8f
 pCbyLakGKN2dPeBW+s9g8waoHw2TW2p/lkYaX9TgmjvBQ4UVL1hghIG0NP3EyRBBffvG2+KFMSs
 KwMOx3x9yUjkhj27bpmh3/GMM/To=
X-Google-Smtp-Source: AGHT+IHr0E41COjjJsHBUmeDXz2n6rocqhodGsgv+oCW2TUfWs+A0BP+Lf2lK2nirMrvURhvSqFpqI7YDcTiOR2l5kE=
X-Received: by 2002:a2e:bc1f:0:b0:2fa:cf5b:1e8e with SMTP id
 38308e7fff4ca-2fb1872ba6amr34044381fa.2.1728549419910; Thu, 10 Oct 2024
 01:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241009174517.286935-1-r.peniaev@gmail.com>
 <CAJ+F1C+JrO3zVEcFKSB2nm6xyY8HmLhAg_ZSXfwTzQcf3+rE+A@mail.gmail.com>
In-Reply-To: <CAJ+F1C+JrO3zVEcFKSB2nm6xyY8HmLhAg_ZSXfwTzQcf3+rE+A@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 10 Oct 2024 10:34:58 +0200
Message-ID: <CACZ9PQWb0J9buW_hpNf6HqnrLHcE5TBdxY6cqivRRB+CCNCQjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22a.google.com
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

Hi Marc-Andr=C3=A9,

On Wed, Oct 9, 2024 at 8:23=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:

[cut]

>
>
> Please rebase, it fails to apply cleanly on master.

Yep.

>
> Can you try to split MuxChardev in a base common class? You could have Mu=
xBase or simply Mux abstract, with MuxFe (for 'mux') & MuxBe (for 'mux-be')=
. This should clarify the code a bit and avoid sharing the same struct with=
 unused fields.

I can give it a try. Let's see how it goes.

--
Roman


>
> Thanks for the tests, that helps a lot!
>
>>
>>  chardev/char-fe.c          |  14 ++-
>>  chardev/char-mux.c         | 212 +++++++++++++++++++++++++++++++-----
>>  chardev/char.c             |  57 ++++++++--
>>  chardev/chardev-internal.h |  33 +++++-
>>  include/chardev/char.h     |   1 +
>>  qapi/char.json             |   9 +-
>>  qemu-options.hx            |  46 +++++++-
>>  tests/unit/test-char.c     | 217 ++++++++++++++++++++++++++++++++++++-
>>  8 files changed, 538 insertions(+), 51 deletions(-)
>>
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>>
>> --
>> 2.43.0
>>
>>
>
>
> --
> Marc-Andr=C3=A9 Lureau

