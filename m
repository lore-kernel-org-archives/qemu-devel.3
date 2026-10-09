Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AED9CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFC3E-0005N8-Hb; Fri, 09 Oct 2026 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xFC31-0005Mx-TB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:58:12 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xFC30-0004dv-Ap
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:58:11 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677aec6ddfcso4140506d50.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557887; cv=none;
 d=google.com; s=arc-20260327;
 b=Zkzz4zNYR1AcEUYhTmx5PuAyybHozCrAK/0zM3A8scmZS9eI2RwEjSO/3O3nAQ7DLD
 xLKbK3C8KjwxNWodVEdmiga88upxmtvokWDuPEGTgDTjfk1H/GIozuuabeSc4QVRXbgd
 5pxiuA1Fr1V9YeudgTG8qVLs4x+978nUY1L+zGQsO6oLW23v+PO1TnfbwWMCL71Isg6e
 lIIUx733NtzxDQBn7F6NB9hFPMpuqa6tGHQ4vZQxaZZWs6EweSN4hSs6jwGI3INw49sx
 bYVQtmqVtBr148V4wx1NwzvZJrI3ijDGfdJwzErTN4e9dQlBicx+opA5YbkH72opAcSy
 GhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hxWlM3FRg6l6JvGnQKpB+iYnErWGfjGugnZ8MuA8dHA=;
 fh=lW8xzSdEwaBIy9TNvG7wkGxSxV7QyaPtYtghnU5h7Fs=;
 b=oxRpBIEoqlvagu9G+w38WsAeo9C3JOr3mrEIuoclcpPM5sOD4h8NPdXDOmlU+ETmfo
 7xPqnY0AoSReVc7boW4w/0Fo0aHrpq3eMMr3nJqL/MxO++4L6DRtpgEfeaxG6lGfnEVo
 b+OLH+ew4DzpcA5iG9dMX6tNfsKr7UVyRdmoMeVQwtoPYpCH1UUAKC+VyeCEpnHuLYR9
 gPuqlNb35DIRTynPUwiq0nAKpxx/bMPOJ7loh95vsEkUvRxlPDeVbyfC/T2Sm/gglst4
 xEUKlB9aLLBzLZUi+0hTpWUBjlI4w5+BfSIgTVCTcH3v2eWSkmqZjLplprPn1AMeLkVJ
 l42Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791557887; x=1792162687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hxWlM3FRg6l6JvGnQKpB+iYnErWGfjGugnZ8MuA8dHA=;
 b=hJdM41ddVDe7DSvS5ZaI882sp33CWyKMZIWtMCe4EOZgL1R2O3PicDEc4eqj8+fgu7
 ggHONfkliaHuWjH8/pS/mmmLLo2AkRkHfjeocTweqU1tiG9KupRiXl1UxGeyClrrp97C
 X/ZSJn+Niy9k5t1J+pIcZbItbSsXJ8vvFRwgiJMH9rU7s7sLr9fZz1IzcHdeecsWDziJ
 Oa1iz/ujf04vEXuEL0FlDdT0ij0PfcB0Fz91nA4e44opgU7OWThBte4DcDtFC4lRCYCt
 bPG4NbQhY80s/GYQAwALZHQcZiR5rOf+B0yiY8A5Hbh1fLiK1WUlRTqJ4liHU3QqFxpp
 eWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557887; x=1792162687;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hxWlM3FRg6l6JvGnQKpB+iYnErWGfjGugnZ8MuA8dHA=;
 b=MFRyihgf2Xumk4Rb8TqqSb86436raglaBmbdJ/RQQ6CYJRuuPZGoUBv72pkWBBmIbI
 WNiSn1lqaKy+STBRDPF2UK2drUoau0kNwufxyKYtg4xC59FqxAnJV0wvdORnBG14Ss71
 fy3I79YKtinp/wZN7R1gsnM2VBJvNxB+x2ACwsIV4UEGrRi/FoOMaieyuwWz+J4dmMhv
 c8y2SGQ6GcCw0KQ2LafLFisJENpSDpR9j446EkcFPZ6LHvd0QojjdD3c0gUxDOHf1C6R
 N4gwadjGaReoz4tcl2+Wex++ImRAoicXNoDmAIpO/hf5LdQRMN8IOMUHfEpLSnwLREs/
 qx4g==
X-Gm-Message-State: AFq9FYKRwGmdir8oIAo/RHJO2xRukzwpkSju6ih/g3rVyyJJdR75cg2q
 D+s7C0fLaZFXgLg9C3MLrq335REt0AUo9Ot/bpMw1pyk+tQxq0hM4jULvVuUqoHlA/H575WUY2o
 o8x2RjU7/jQ+1AqqM2DOdeSiOfGvzlaM=
X-Gm-Gg: AYBFou2pi5cM7fEUFyuMWh85VLs9VaDVcLbRP7Onf6S9fsKhG80kXhyeHWkQQaAYRyj
 quoXc+VWH/GkamxMDT6lb10yLMQKNCWm87nOP4FaXukoCg6XKe0ITW5Gc5k+s8hXmjbv8MXxMte
 CuDvz9hcsTxyIo4v/4KEPLgEkYiAAe2s9q9GSBnh3oLOAS1E2enCoeL2l8muArpe/X/B4PNmuMo
 JLCTjFXpXqOOJmWndpZO3vAb5XEcWQWRoPmAPrrj1WyqtGG+mYah1W4U2bRDutQfRR+aN+gsTiu
 ZM8wUbEQ6TKFo/Hje/RyAUVjwTEH2eNzFvvs48L2OWmapTdw0QbkYNxQb3ULg6wjRcjIdIt65AZ
 xYluVWJpWucM=
X-Received: by 2002:a05:690e:bc5:b0:677:d79c:f6b7 with SMTP id
 956f58d0204a3-67935f17bf1mr646174d50.6.1791557887008; Fri, 09 Oct 2026
 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261009140431.3175479-1-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 9 Oct 2026 18:57:54 +0400
X-Gm-Features: AclHuK-mubu29gieO6qaig_SsfXe1MwMH3nbUQeQs3F4S2sjVN-pXGSjbyjvDlg
Message-ID: <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] qapi: Preliminary work for better QOM
 introspection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Markus

On Fri, Oct 9, 2026 at 6:05=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau has patches to improve QOM introspection.  Latest
> version is
>
>     Subject: [PATCH v5 00/62] qom/qdev: associate properties with QAPI sc=
hema types
>     Date: Fri, 11 Sep 2026 20:34:34 +0400
>     Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
>     https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a55b776=
0@redhat.com/
>
> The first few patches make the QAPI code generator emit type
> information for use by QOM introspection commands.  They refactor code
> to gain access to masked type names, and to make query-qmp-schema not
> elide types QOM introspection might want to refer to.
>
> My series does this in a different way I find simpler.  It is RFC
> because merging it only makes sense if Marc-Andr=C3=A9 finds it useful.
> Marc-Andr=C3=A9, please have a look.

This is essentially doing the same introspection changes but at a
different level. If you ask me, since it's essentially code cleanup at
this point, I would rather merge my changes first and iterate on top.
But you are the gate keeper, so I wouldn't hold it, we need to move
on... I can rebase on top of your refactoring if you prefer.


> Markus Armbruster (6):
>   qapi/schema: Rename .lookup_entity() and tighten return type
>   qapi: Ease access to introspection names
>   qapi/introspect: Simplify masked name comment emission slighly
>   qapi/introspect: Don't elide types
>   qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
>   qapi/introspect: Tweak integer type masking
>
>  docs/sphinx/qapidoc.py     |  2 +-
>  scripts/qapi/introspect.py | 74 ++++++++++----------------------------
>  scripts/qapi/schema.py     | 57 +++++++++++++++++++++++------
>  3 files changed, 67 insertions(+), 66 deletions(-)
>
> --
> 2.55.0
>
>

