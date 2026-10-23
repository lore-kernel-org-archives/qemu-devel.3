Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF544606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dsc0/prW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEdv-0004zE-D5; Fri, 23 Oct 2026 08:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEdN-0004x5-9e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:44:40 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEdI-00069v-1P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:44:33 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8acda240937so7011097b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759465; cv=none;
 d=google.com; s=arc-20260327;
 b=nMZalbkiiXL4ss1vCBFyUuTcuu2O3N7weZ4kg6y4ZuA3BhtvJiktaly0hcFrBLbwKi
 BmQrblR9mpH4hYlTlOdCangOBN1R8G1ZxTfQuEQooarbfC27axrHOPxlO9OK93He39D+
 GjL7SGuzXwmxLij4GS2tftmvc4l0kn638VKPwbnDZ8tpCTlmHOdm4AVSoE8HUGw2IhCU
 VB2LtGeCEiJ6BKhc50gntuZ/ESRhpeJ8n9e/Os5WUfxwdl8HHCYCgvsRuQGCHZ1w6S02
 dbVxXuGCDguE1YQRMsk5bYfn6EIEU9dq5te7RS3bDRQd6Jm8a6HnoZmwkxxPjgOXfOF0
 qAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mtsZ7C3DG6BiPND3Ri3SgW/2otiuGkwMN132zL/8edw=;
 fh=OTA3DWl3IAsPag2DdrpUauL9DXQe+TgMKfQB0kLzHck=;
 b=nENofJfVSb62yAmorIplRZR9T5Kz+0FcbHeUMQWPw9XjqrgSMzNzheBi55NaXMgD2j
 WzJIUoyuhMIdUpdGRKXnlbnnE+fub7abpmaD5nqj1xUQSEpF3Bv7hoLHVErLGODPvnZZ
 fy9VyrKjl1F9C4hjZRN9oAjj9/0V2DS427YAJFwSAy075zEp/wYmMFsQcki8UfzyeikY
 UkRIvyVuMS+L/7NjBu4q57+Fg3A8U3XVR7m9lEHsfMohzOpXoUKfiN8w/HgOOyo1z40X
 y1ZQsIXDMzMzI5ynK75Uvo1RoWY+URUBlYje8oyariU2Vtw3O97a/CZIV4t/4FqEYs3/
 EGxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792759465; x=1793364265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mtsZ7C3DG6BiPND3Ri3SgW/2otiuGkwMN132zL/8edw=;
 b=dsc0/prWoMZan7si9cEsFCAmF8CwI3YotaalDI4YENUwcwErDiMi9cuu0Bj2eGldgt
 j29AUkEwRG3lVhOPyQHP+Kr2EucdeFw12eTX+MStJyh4f36LY6JG008m50duvWud1gxo
 JrD0SD0Q9CvIRbPVam/v1TEBVKRZ6thIojhtIDCn7qUnAgic3/tFIsajHUHG7ps/Czrr
 CaUDvAO7IRLYl739cbmim3kBhkDycbOziWYY/wDriKXESSe21zfrrR19PSLfgWx18aJB
 bTYnX/RAVT9jig+P/9dCSn8UYgw0pqsqeX8UufDwP8ecLhlhUtzf16EO+H/xcs3XUEhR
 WKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759465; x=1793364265;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mtsZ7C3DG6BiPND3Ri3SgW/2otiuGkwMN132zL/8edw=;
 b=OUIBYowk2+K57TZz15NQL78HwJKMioRGWS9TAwiVPnC0x9eOGceUUTAMTgbcYueLrD
 W7eI8FYI3uv8vPGbkZvcboR7ukheucckEd8aasUG1hhONOw0JDTK8ZG3vm+her4YrOyx
 JykFhOey4YLxL+d9QSqhp6kZQQB/nakNWiJbbkDAtTlvcR11JN6QXtjJ+DlYzBFaJ8ni
 91Vv32Fkto41khjq1duJtdIYItiwsmwo8/nteiwP5azMMJ6/NEQeT51gxeul0MD8/oYo
 j4GXGhehZa0FkrSjd67s7Ej2Wd8yxC71NmYwM6P3ED2v9Jr2ow7R9DPgMunPAFTgLkl+
 zIKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4F1rHHHmMzBdzXxE+8uudOUPkz0Osn7lctDPZ38SyFdDqUbP+NwQQEgcsczZhqPsRp/pDhv/8k8MZ@nongnu.org
X-Gm-Message-State: AFq9FYKSSfNdh+T1C6Zv16JyhBRvRodBZ8sXhatdFibw9qOxj6g60VQ2
 gheF/jTH3apS2Ma1y6LuyJMiAJPiolb9+Ks48udQ7jeZ7rKoxPPnKHIhxyO3jrVE6maw0NkCYiJ
 sc/SKG0mEAX0V1iEiaMr9hAIkyuU41E0AWlFfO3vRxg==
X-Gm-Gg: AYBFou2Lp6fjaXrB6O2GAXo0X50VuBfGhOVkPEhbVYImHf2ZzfRbvrL6n9MznUQ1He8
 hiAHYSd6QFuR/QlAaPC9kMf+c3rM5HlLYKVNHYpGM1TiUG42UO0dHLFkWb+LcF2O3tWdTyszfkT
 dbHwM6LQOp5at9w2hkWBZQ2Am3m63lxGaa/s7mD/gS9efhE/UkDtCWo6kuvwp1lQyxRbjIDO/TK
 LxgTxTB+nZcHUYtF70OObUmJdtrGzFvQ6m5GgynL4rIo3tgXFXuE93DF6YqKtPfjqvAfb7WBGA3
 x+gu0qQprQMKe0H0mg7lwbHeYZwiXFvspfOBM/918reiHm0P1oUVhIGG+TcOxW+v59zWdaOKG8R
 DZaVlNRZEw53hUhMeJQfIXsXza3dg68K3MkbeAdp01QcINQCDukHDUxzer8wvW/1Wt9K1uzsBvO
 LWEjnBguVRRN/E/isnpkh2
X-Received: by 2002:a05:690c:60c4:b0:8ab:43f7:f061 with SMTP id
 00721157ae682-8b157e18ca8mr15668457b3.34.1792759464772; Fri, 23 Oct 2026
 05:44:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com>
 <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
 <attU5UAI225QGa9J@redhat.com>
In-Reply-To: <attU5UAI225QGa9J@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:44:12 +0100
X-Gm-Features: AclHuK8O7HfUnt5375iQQgNYQ4ZQxX5T1zNPFuyD1ub1ELokqoWQcFuPFiE7-R8
Message-ID: <CAFEAcA_jrROiMr6y5UStu34a4xJpAnhr1YdFKrR+OYr8x7iHTQ@mail.gmail.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc,
 but not memory-backend-epc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 13:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 23, 2026 at 12:50:24PM +0100, Peter Maydell wrote:
> > On Fri, 23 Oct 2026 at 12:08, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > The memory backends are all implementing the UserCreatable
> > > interface, which provides a "complete" method where they
> > > could gracefully report lack of the feature via 'errp'.
> >
> > I didn't realize UserCreatable was a thing. It seems unfortunate
> > that we have accumulated three different kinds of object
> > creation/destruction life cycle:
> >
> > - instance_init / instance_finalize
>
> This is all stuff that is supposed to be basic self contanied
> initialization/cleanup with no side effects or dependencies,
> and impossible to fail, which is pretty clear semantics.
> During init, no external properties have been set yet, and
> during finalize it is already disconnected from the QOM tree.
> Essentially these should be basic memory allocs/free, mutex
> inits/destroys, setting default int values if non-zero, etc.
>
> > - instance_init / realize / unrealize / instance_finalize
> > - instance_init / complete / prepare_delete / instance_finalize
>
> These two have clear overlap in that they both take place after
> user specified properties have been set, and deal with types of
> initialization/setup/cleanup that can fail and have external
> depedencies.
>
> UserCreatable has another aspect in that it is the witness
> flag for whether a QOM type is permissible to create using
> -object / object_add.
>
> I've periodically wondered if we could make them the same, but
> the realize/unrealize phases have significantly more complexity
> and dependancies than the complete/prepare_delete and most
> notably, 'realize' has a 'bus' parameter.

No, it doesn't: the method signature is
typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
The qdev_realize() function takes a Bus pointer, but it doesn't
get passed to the device itself, only used to call
qdev_set_parent_bus(). (So arguably it would be better called
"qdev_realize_and_parent()" but that's a bit unwieldy.)

> I think that an approach to unification would end up with the
> 'Device' class implementing UserCreatable and providing a
> 'complete' method which in turn called the 'realize' method.
> IOW, nothing much would really change in terms of impls, as
> all Device subclasses would carry on using realize/unrealize.
> It would merely make Device tree available to -object/object_add.
> There are probably quite a few edge case problems hiding in
> there though if one were to actually try to do this, so the
> pragmatic option is really to ignore this all and accept the
> different APIs for Device vs non-Device QOM.

Probably. But I think the core reason we've ended up here
is that we didn't have the two-stage init in the core Object
type and so different subclasses have ended up implementing
very similar requirements differently. So if we did care
enough to tackle this I would favour pushing it up into Object.

-- PMM

