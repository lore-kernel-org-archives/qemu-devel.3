Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D66C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2WFv-0001pl-Si; Wed, 09 Apr 2025 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u2WFu-0001pb-LJ
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:18:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u2WFs-0001xT-UE
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:18:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e61da95244so11196834a12.2
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744208294; x=1744813094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYA2JtDhdRBmRh8LdWqQ/ViaZ75fKalCivOLfAwjFY8=;
 b=mJ/8Nfk7FoIRIMJktDb8pki3lsKC5DchXKi8OF8qTtYzYbfyG7MBNvpiOLoIIjAl1H
 KcVhv58u6ea/eTwnBEMOsFQUitg8oi1Yiuvm/CcX+8U5tU1k9vgOeYGC0aZ83ozo8QlQ
 Wbx6OquP6PH0gOwF/vnFJtX/4Orrxif2A91qWU1vhZEKwwo5Xdc6n/VZXVPoZ0MEzBBS
 YB7uYFFnbd1fYs6HUhqb9pguG7ijhIcfXS1y1HomWr/zqj86/rwfTovkFyRu2zv3hDa+
 UXlIoXtZ3zPIP9dc7OaCesbCyAzPpJgzUtmDdVbrHyZVGKpJzSYoAurKXxHke3wbwg5e
 GbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744208294; x=1744813094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYA2JtDhdRBmRh8LdWqQ/ViaZ75fKalCivOLfAwjFY8=;
 b=ERnp8Pv1Tg9cs4YmYQTkD6rBVHSxS1g67A2Gs27eK9NGp27vLTVQEUgp6F+5Dbe0jX
 AIFZqttiAJKOj7Z198kieHhXxW3YQbQH57uPKWC6RuuJUck0wEdH9xXBYnIc9miZd8Di
 PQmTmk0JNlqvkHFrK76IQueJAELR688crXV9FXb8jCbcNlWHX3W9jZy4qxslBAQcs93A
 m4U3AYvyVuuu5dy7QbRTQotvk/CTWuOkrEP6YJrBgSF5pqLhOZ/cdvh16x2povVVJUUt
 u5FicDOjriVxxSJDgo1IQWpOBfCfnahtWB7kdVrjecY3CQo7S5ZvpwmKPsFrln4gD+mk
 0WBQ==
X-Gm-Message-State: AOJu0Yzu9Nm/MTpk/vN3obAPuZlcFX5Yearfs5A8p94WvxDwI/jHpYGf
 ka6DUDSxWgrZ00zzKOWJsYNZoqPN/crqtCxWYek+XTTGeakxjTWac0mANmtFU74HmI8BJujKYNy
 6WsWngEXs8ePGdaELTrhSqEkb6LE=
X-Gm-Gg: ASbGncviRUDwNJ6n6/ckUWWAQ7OmDKkYSayZbXOLid1fb4L6rpNq9B5WSG9yTBUWTcB
 Ew3eDbpA3JkczewZ/xzcrGf6qgZGrONqhSkRDlHawSQjUkMqHwrbDANzDTj/KLWSWieLCSSOXZM
 jzAdd98P5VDftHB2t6Aq5yEaWWFb+gCw0=
X-Google-Smtp-Source: AGHT+IHZJMFRnGzBQKHiKRH4vwM5JUl6tXpp9brIqEVTqpCZr6jqAJcXzMw4gkuM7V59yYQp2iUDXB5SqV0uVyuiKDg=
X-Received: by 2002:a05:6402:2353:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-5f2f86d7fc9mr1868852a12.29.1744208293635; Wed, 09 Apr 2025
 07:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <87h62x8n6b.fsf@pond.sub.org>
In-Reply-To: <87h62x8n6b.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Apr 2025 10:18:01 -0400
X-Gm-Features: ATxdqUF4_UFYU3WcMC54HiAnbCaGFdvcV6UbqJwdyrLsxhwdOBrK6zEKLbssNZw
Message-ID: <CAJSP0QUyZfV8UQmhR5ADgC5Cr9zVrJ53fcWLvY0GUUSKfj8iyw@mail.gmail.com>
Subject: Re: Note improvements to QAPI-generated manuals in ChangeLog/10.0?
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Apr 9, 2025 at 9:44=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John improved looks and usabilibity of the QAPI-generated manuals quite
> a bit.  These are
>
>     QEMU QMP Reference Manual
>     QEMU Storage Daemon QMP Reference Manual
>     QEMU Guest Agent Protocol Reference
>
> Where should it go?  https://wiki.qemu.org/ChangeLog/10.0 has no section
> dedicated to the manuals.  We could mention it under System Emulation /
> Monitor / QMP, and again under Guest Agent.  Thoughts?

I would add a separate Documentation section for changes like this.
That's also where major docs infrastructure items like changes to
formats (rST), tooling (Sphinx), etc could be announced.

Stefan

