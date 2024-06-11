Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF93C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 06:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGvSk-0002a4-GB; Tue, 11 Jun 2024 02:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGvSj-0002ZU-7v
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 02:58:33 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGvSh-0002mc-Ey
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 02:58:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so881611a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718089109; x=1718693909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoCxk8AHZFyOyb4xLAvrTvADVC+mMY0zdmcNIFMmLH0=;
 b=pi1aVHNCsNllP7wGR95QW6C0BGXj8jZSvIv5ZooyZOR+qdPzk8Z/UqeDPoJYT0BS5k
 BA2gLCQUc78eOSIBwBt+U1JQP1MR3VJlK4lxWeoGn2Zkhbm0puZjNeb5wv9HWu0rZ0Th
 g9ZXJZhJQgopL1vhc/tHwizlAqhxbowa0Kq621+TB0BQMHxsu7kQKHuVnLaudNmN6wkN
 PgSbqDe/OR71Sz3au9v0aNJqTJAcctnIlPf7uQITptx1tY64/ZlWxKte60xb6a/mpMge
 QbpU6MLFDsijc2fLa3CZh7Nbd5sjd+4J0UX9X2QS91CB+EiNMawZMzliwHfHXz8/O14g
 wYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718089109; x=1718693909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IoCxk8AHZFyOyb4xLAvrTvADVC+mMY0zdmcNIFMmLH0=;
 b=TkBKAGv2M729KkxXhTprLT/eWwJvQK64nlHPtlgr/qt3uV2LteD3Ys3+3vZt3Je+mH
 Kuv68ZvqAzLrsxoEZNy17pOhuDnNyyydvF+Mt8BYmyWEhnnKL/EyiWPatE3ajhelS22M
 Q/rw3hmCOcTGzOmdT+OJWpLRS+4u410w5jnoYzanWdMCemu6XXBEBeOfNDoNn4bJ+9KF
 q/1hkTZ1UsyYmGE0tpZQqXDcMKa1igW215tb/E/BPcy6UMmEZBJafzghs3F4gHcBbC5Q
 q8X7jw8hvZf6k6J7zTLi+Qe3DlFZ3+21/4hQBpFXFBA+ZMq2G8AeYVxkHKHPkw65fYBG
 6VWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPK5hAFsSl//CCvmdZHGtwPno2ZaFn1o9qSnnDW91niMt/WIUfm+TBpFDBizdMVrkHVRGhtRW2UbeE+9epbd0pmR9KI/o=
X-Gm-Message-State: AOJu0YyT7Yuwj41BZpfoCVw8sgccdPrQh6omWQJk52TD2NdUf33+Xy+3
 QFanKnQG2qbPeAenK2uuL/bLU49Fibgym1UqIJraEXhujzn9Ki8IASl8+uHhTK0a2EUeOGoN+V2
 KdjIMpxTIUHJgVFknni+WV97SjYDH0HMBu8WYtQ==
X-Google-Smtp-Source: AGHT+IESjMI+oIlI8k9sm1ZUTc0CjnxNqXl/Q9v2Q3kpKBEO4EzmtEsI57LNPbs+FnhLdKdJN2PTaNuLAVafCVJlxWg=
X-Received: by 2002:a50:bb03:0:b0:57a:72fc:c515 with SMTP id
 4fb4d7f45d1cf-57c50972f4emr9623199a12.29.1718089108932; Mon, 10 Jun 2024
 23:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org>
 <e0d03597-a9d1-4386-83b4-519aae23f679@ilande.co.uk>
In-Reply-To: <e0d03597-a9d1-4386-83b4-519aae23f679@ilande.co.uk>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 11 Jun 2024 09:58:12 +0300
Message-ID: <CAAjaMXad7b7SvAkAmvt+4RuLqZoTGCpELN0YMoVu7xGazwPRug@mail.gmail.com>
Subject: Re: Examining device state via monitor for debugging
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 11 Jun 2024 at 09:11, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 11/06/2024 06:49, Markus Armbruster wrote:
>
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
> >
> >> Officialise the QMP command, use the existing
> >> hmp_info_human_readable_text() helper.
> >
> > I'm not sure "officialise" is a word :)
> >
> > Taking a step back...  "info via" and its new QMP counterpart
> > x-query-mos6522-devices dump device state.  I understand why examining
> > device state via monitor can be useful for debugging.  However, we have
> > more than 2000 devices in the tree.  Clearly, we don't want 2000 device
> > state queries.  Not even 100.  Could we have more generic means instead=
?
> >
> > We could use QOM (read-only) properties to expose device state.
> >
> > If we use one QOM property per "thing", examining device state becomes
> > quite tedious.  Also, you'd have to stop the guest to get a consistent
> > view, and adding lots of QOM properties bloats the code.
> >
> > If we use a single, object-valued property for the entire state, we get
> > to define the objects in QAPI.  Differently tedious, and bloats the
> > generated code.
> >
> > We could use a single string-valued property.  Too much of an abuse of
> > QOM?
> >
> > We could add an optional "dump state for debugging" method to QOM, and
> > have a single query command that calls it if present.
> >
> > Thoughts?
>
> I agree that there should be a better way of doing things here. The aim o=
f the
> original "info via" series was to allow the command to be contained compl=
etely within
> mos6522.c, but unfortunately due to the way that qemu-options.hx works th=
en you end
> up with #ifdef-fery or stubs to make all configuration combinations work.
>
> As you point out ideally there should be a way for a QOM object to dynami=
cally
> register its own monitor commands, which I think should help with this.
>
> IIRC in the original thread Daniel or David proposed a new "debug" monito=
r command
> such that a device could register its own debug <foo> commands either via=
 DeviceClass
> or a function called during realize that would return a HumanReadableText=
 via QMP.

This is starting to sound like OOP: A Monitor interface defines
monitor commands, and QOM type classes can implement/define their own.
A Debug interface would do this.

