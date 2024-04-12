Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5B8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 13:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvH7J-00066J-IK; Fri, 12 Apr 2024 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rvH7F-00065x-W4
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:38:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rvH7A-0001pv-NJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:38:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so786131a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712929126; x=1713533926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8EcT/6Qbql/Srv3fLG5/PNPCsJNC5GqrZpF6YgbmGY=;
 b=aDSc6KI1fFT2ZmX9c5w3IlsNpS4umWRPa3Ww9iiH6k8eLGpBhiv1LCMhkMCq+cJ+Cv
 4XKXaSblcnVVhEvo6Svw1doCyu1ndP37FbGSlkAIf51sNV+IVYqwP0/LWCn7xysLv8IC
 sHipF6STTOgv9Jf+Eeb+dgvfkUAYWTC6yvynQDCd/pJfzA4x8hffyGtxkqFcXjfwMp18
 WDjR/wwkR0/ueJa5mRkdtAPQItvz5zqZ2gUZjP2qALQWa3yE/UgCSX3Ack3ECG/u5UvN
 yEQEOB0KQC2zXgWRmOo1VSF788QJNwHK5ZPVUvxDWWIcrObIEAKqjfriq3vPB3B6XDiG
 gfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712929126; x=1713533926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8EcT/6Qbql/Srv3fLG5/PNPCsJNC5GqrZpF6YgbmGY=;
 b=gTGrlyk5u400L1JSkI+hWaFkek8iib0cj9iivYwyEvJx0uPa0+Oimi5DhjHBt3RxSF
 9JArp2QV3CMI+p37GwzLJjGZo4ldAWZPSnsyRHQ7ONOtZpJ/eF5E0SkgHE6mBPnAoCTY
 kd1agnDijS5pZ1CCRCFTatj7QKu2hbx+cmnh0s0RnnszoKvE/jIJUIejb/peuk3M0U+C
 Tun2vrPm9DhEWgDQ4IHySSF5m76MMQhIAyINLiK06q3ytyQUa9TcnLtEK70Nnr2XexUu
 eB+ZAJZHCuXzc8/ojEo8+l7xBw+6x97Nb8OSO2Why6mqyvJyfdYyLsf6XRougSzO16LC
 JXSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPH7gyyYRYhPFFCalZ+Y8OWXcC5J0vENe1XP0XWmRivaxyiDtS1uPF+OOD0vU6RmFblcr8Qpdp/aCc2BQpwUjwX8YhsSo=
X-Gm-Message-State: AOJu0YxW9nSpswuJ1Iic1hWXfSOzGOv89nB5ev0JfNhz+JfmX/hDt6KM
 ETIaLyNur/Gkn4V5ZGZCmTuyCQt+aL690Sm812fs1bD/K7iadfDAOYmNQcWy7Lg4dUg+s6HTREH
 JST4cQJqtMA/c2Y3Ly/vEIefDMOk=
X-Google-Smtp-Source: AGHT+IFG9USiicsTH4o+FzJy7m91cQT6LV2mNerlXBchmaRVVzza/jm2y7amO2y2mWzZj53OoXyaDn3IBYu+HyEJchE=
X-Received: by 2002:a50:d79c:0:b0:56c:3b74:ea4 with SMTP id
 w28-20020a50d79c000000b0056c3b740ea4mr1937840edi.21.1712929125984; Fri, 12
 Apr 2024 06:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
 <6b384586-c7ad-4b6c-a1f1-8a8d8b0ad526@linaro.org>
 <CAFEAcA9+LXUg_u2QFuYMbhxeqofD3iC4CGHo5WXL77QMCOYy8Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9+LXUg_u2QFuYMbhxeqofD3iC4CGHo5WXL77QMCOYy8Q@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 12 Apr 2024 15:38:34 +0200
Message-ID: <CAJy5ezqkz9RLytkysd8RKvVGP6oSc-xd-mjdv9K0E=7W7xMBxA@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@dahe.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 12, 2024 at 3:05=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 11 Apr 2024 at 18:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > On 11/4/24 15:43, Peter Maydell wrote:
> > > On Wed, 21 Aug 2019 at 17:34, Damien Hedde <damien.hedde@greensocs.co=
m> wrote:
> > >>
> > >> This commit defines an interface allowing multi-phase reset. This ai=
ms
> > >> to solve a problem of the actual single-phase reset (built in
> > >> DeviceClass and BusClass): reset behavior is dependent on the order
> > >> in which reset handlers are called. In particular doing external
> > >> side-effect (like setting an qemu_irq) is problematic because receiv=
ing
> > >> object may not be reset yet.
> > >
> > > So, I wanted to drag up this ancient patch to ask a couple
> > > of Resettable questions, because I'm working on adding a
> > > new ResetType (the equivalent of SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
> > >
> > >> +/**
> > >> + * ResetType:
> > >> + * Types of reset.
> > >> + *
> > >> + * + Cold: reset resulting from a power cycle of the object.
> > >> + *
> > >> + * TODO: Support has to be added to handle more types. In particula=
r,
> > >> + * ResetState structure needs to be expanded.
> > >> + */
> > >
> > > Does anybody remember what this TODO comment is about? What
> > > in particular would need to be in the ResetState struct
> > > to allow another type to be added?
> >
> > IIRC this comes from this discussion:
> > https://lore.kernel.org/qemu-devel/7c193b33-8188-2cda-cbf2-fb545254458b=
@greensocs.com/
> > Updated in this patch (see after '---' description):
> > https://lore.kernel.org/qemu-devel/20191018150630.31099-9-damien.hedde@=
greensocs.com/
>
> Hmm, I can't see anything in there that mentions this
> TODO or what we'd need more ResetState fields to handle.
> I guess I'll go ahead with adding my new ResetType and ignore
> this TODO, because I can't see any reason why we need to
> do anything in particular for a new ResetType...
>
> > >
> > >> +typedef enum ResetType {
> > >> +    RESET_TYPE_COLD,
> > >> +} ResetType;
> > >
> > >> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
> > >> +typedef void (*ResettableHoldPhase)(Object *obj);
> > >> +typedef void (*ResettableExitPhase)(Object *obj);
> > >
> > > Was there a reason why we only pass the ResetType to the init
> > > phase method, and not also to the hold and exit phases ?
> > > Given that many devices don't need to implement init, it
> > > seems awkward to require them to do so just to stash the
> > > ResetType somewhere so they can look at it in the hold
> > > or exit phase, so I was thinking about adding the argument
> > > to the other two phase methods.
> >
> > You are right, the type should be propagated to to all phase
> > handlers.
>
> I have some patches which do this; I'll probably send them out
> in a series next week once I've figured out whether they fit
> better in with other patches that give the motivation.
>

Hi,

I don't remember the details on your first questions but I also agree
with adding the type to the other callbacks!

Cheers,
Edgar

