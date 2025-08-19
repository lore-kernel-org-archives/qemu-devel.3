Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F351CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSVi-0004N9-Ap; Tue, 19 Aug 2025 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSVg-0004MK-3k
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSVe-0003TC-4F
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFd3aWVwcM/rDlUsUh8JiGdxZkagq4FNwJdyt4cerRA=;
 b=RL/JSRegG1ajpbgPzPebW7Bq4D+NcOyZAvm9rfiy2GwZmrYtKfdfpMrt2HgqgjPvnLOG2E
 pFPtTfNomS29WKFGpCXjU0NtOPIWUsPM6K4aHwvmEQ18c9AyoUeYkUiRCePvnwhw8Z9+dM
 myvH+92LLl20XM+aTaAkqV/ZBVnxZR8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-7huPk9siNiGaqtZPU5uhTg-1; Tue, 19 Aug 2025 16:00:38 -0400
X-MC-Unique: 7huPk9siNiGaqtZPU5uhTg-1
X-Mimecast-MFC-AGG-ID: 7huPk9siNiGaqtZPU5uhTg_1755633638
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2445806eab4so59708255ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 13:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633638; x=1756238438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFd3aWVwcM/rDlUsUh8JiGdxZkagq4FNwJdyt4cerRA=;
 b=h4cvOUvPspqxA3aOXojHhlCkHpbMjGaTW7ikHwqudLz33FRonWwiCvzNmCrIgxkGBz
 k5j13kV9Az2Omqqq5V7DD9wq2zLFJ6oMveoqusXnWqvvI8+O4bEvi+RGp7TsrajmbWUu
 f6XO4b4N1UqJ5gfC1cdEkhfD4hXqsyebHsR0ejPhnUfl4dxaRAFA67Kmv2U9wZHoeubj
 ISF8OD2PHkALxTHh9n/EvQn8xb2r5bGcP7CmPh97MO1mlYnRq/cUoq/m11iZbRRtXY7y
 urlZFHm0F/AIZ3+f3f+B+Ngz7pxVDW9OxI0wsuggp0zshQ/xu/vwtBMLLF5riCtFxKCb
 6Szw==
X-Gm-Message-State: AOJu0Yz0sFcbogJEbMFKM5JPGKx3UIkOPkB41caRsBMRjwzq8+1FMGT/
 fa59NGiTh2RI7vlTnz8nEExE8RJRqd40Qoe7pvVpxBiZ+e7tvlzD2Z51spsvOdguurl34uK93KZ
 islY8NR7u6b+DJ1TgO+RkLgfwOuMZH7ATPCB2GuIRXVvqhUBxAUbx9N3/utxuRoekc6lXOgCUtn
 YxBIgYhcMBeLHiAY4BMbZkQPkoKEXNNqc=
X-Gm-Gg: ASbGnctjRFhoYnyPNjWNl6wu6ypVpltQixSh5xz0LB32XX6MuJzBYb89kL/KCUXY+gV
 wUFQBedFOxRPKH/F5RUiezoFc2f/jdQf8c1JByRA58rRIZXm7fbgMaVdoRckUdwONAy3lMH6vG9
 6W4nMOxCjkTk1aZcpNI3HSib+BVcGfaRXH/lrLxxu0bXuqv8G0B9wY
X-Received: by 2002:a17:903:1b07:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-245ef225a57mr2321345ad.28.1755633637614; 
 Tue, 19 Aug 2025 13:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi43KE3jBPXjnEmVZscHnfruj46CzaZj+vfG6iCW6pDmjjdPO4XWHxLfvevmiO1CN202a+tlAbpHE+GUzUkc4=
X-Received: by 2002:a17:903:1b07:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-245ef225a57mr2320975ad.28.1755633637136; Tue, 19 Aug 2025
 13:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-2-berrange@redhat.com>
 <CAFn=p-bVmn_N4hWBnYtNhhdHHYEh4j0zVBHnXFtJVQK5GDRaJw@mail.gmail.com>
 <aKTVpwZjz_GQuteM@redhat.com>
In-Reply-To: <aKTVpwZjz_GQuteM@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 16:00:23 -0400
X-Gm-Features: Ac12FXy3Qwm2EfdV89ArlYsmClzfQFqomN0GyMO7w2f3Jbw5ZJXN7KNHTfOl_kw
Message-ID: <CAFn=p-aXcUMmFsw1zwWSO67VYDuKU7i6JRLuCqBUUm9xRwgsfw@mail.gmail.com>
Subject: Re: [PATCH 01/14] python: Replace asyncio.get_event_loop for Python
 3.14
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 3:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Aug 19, 2025 at 03:47:50PM -0400, John Snow wrote:
> > On Tue, Jul 15, 2025 at 10:30=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > From: Richard W.M. Jones <rjones@redhat.com>
> > >
> > > In Python 3.14, no asyncio event loop gets generated automatically.
> > > Instead create one when we need it.  This should work with Python 3.1=
3
> > > as well.  This change was suggested here:
> > >
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2375004#c4
> > >
> > > See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> > > Thanks: Miro Hron=C4=8Dok, Daniel P. Berrang=C3=A9
> > > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> >
> > Reviewed-by: John Snow <jsnow@redhat.com>
> >
> > We fixed this in the standalone tree, but I hadn't synchronized the
> > changes over yet. Shall we take your patches first, and then I'll
> > worry about synchronizing later?
>
> This really needs to be in 10.1.0, because tests crash and
> burn under python 3.14 without this - we're applying this
> in Fedora builds locally to deal with the brokeness.

Urk. I didn't realize we were waiting on this; please include it with
my blessings and apologies.

>
> > (I desperately need to drop this code from the qemu.git tree, urgh.)
>
> IMHO qemu.git should be considered authoritative right now because
> that's what we're actually shipping & thus take priority for merge.

Yup, you're right. I just mean I need to stop the duplication, because
stuff like this happens.

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


