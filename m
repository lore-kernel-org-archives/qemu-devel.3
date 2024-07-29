Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382B9C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 11:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOy0-0005in-7P; Mon, 29 Jul 2024 07:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sYOxx-0005dv-Te
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sYOxw-0002gK-F1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722254098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4NZQE0a01E7gkys5wMB3DntjcYY2NgIlYja4WDLw5Q=;
 b=HBMRV1H7K8T14Um7t+AFXffwMWTK7jvIc4zS62pBWK8HpSv4w0okKEcxgbdPGUed3dGoJA
 9T0J5sPkpVbuCUVAFrE+T3kKts58H0lg0OTOn3vh2lPkMs01AyoMqp3A+dXSikLrdRaeNO
 eJpqPCFZlClCHeNZ59IljsWo/qYJcR4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-seEKqYj-NdeKdqEvf9z4-w-1; Mon, 29 Jul 2024 07:54:56 -0400
X-MC-Unique: seEKqYj-NdeKdqEvf9z4-w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6648363b329so34516747b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 04:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254095; x=1722858895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4NZQE0a01E7gkys5wMB3DntjcYY2NgIlYja4WDLw5Q=;
 b=oJZX2U7x5KLdmIOUg0tlV9UW59hRTu2cuJceDmJyUIT1uSjR6f1ULr31VhthxkQZxP
 cMJykTVphC+x2e0Dm/gMG96KxR/cNpt7QjBQpKk/qayEcuiammXd8Q3kk7cYS4TfkOcP
 RG6FsQMwBeYj7xWK8ove23KZJJUq67InPtElf6WUw/ubYXnAUtSyu1JrAXxzRNIEfQW5
 d6SgeP+8skdUZ4/hCvoXdHEmzRGINxSIn1uhh5o42CLk0FbW2hywG7RbZ/5vUrt8qDgv
 UhharmLh/gKAWmR4ko1NlVvs/MGtLoFvHJmt2DTKst6p3ee6UT9Y7MEzCOloUBZISzn3
 Lp0Q==
X-Gm-Message-State: AOJu0Yx8q/aaUus+dxhvpSF5qNCOwIFCqTOi6Xn9MBTMnJd51aO/5tyw
 hkvlZcv4WUfqDWxnQl+IS5ooP+UMziJa2KaVtQY1GW03g7l5pC7hNKS0SUanCRtq4dN3zbYgjHs
 LuREKhXLAoTKehXJkXsU+Mg+3hY7smVS41ZdiMVsws9R1UO8hPPYEXYXM+BUwm32CvE99R76Ggz
 c65t9Z8cYWfgPnF8fGf+/RsClBka4=
X-Received: by 2002:a0d:cd45:0:b0:66a:843c:4c38 with SMTP id
 00721157ae682-67a09b7279cmr66399287b3.37.1722254095617; 
 Mon, 29 Jul 2024 04:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErfrRTDiSJvI5t7sMOIhqCoRowoqwYj4meCPwD0Afc+x3c9S/BATACl3L0a2odQpmfXnY0yF5dkB0GXDcn7Fc=
X-Received: by 2002:a0d:cd45:0:b0:66a:843c:4c38 with SMTP id
 00721157ae682-67a09b7279cmr66399057b3.37.1722254095312; Mon, 29 Jul 2024
 04:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-6-crosa@redhat.com>
 <ZqdwJRRBjj5DsWh8@redhat.com>
In-Reply-To: <ZqdwJRRBjj5DsWh8@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Mon, 29 Jul 2024 07:54:40 -0400
Message-ID: <CA+bd_6Jj-DgpkouznuDC-ViOhi4zLu-SxnyrnyV6ceycHhEBiA@mail.gmail.com>
Subject: Re: [PATCH 05/13] tests/avocado: machine aarch64: standardize
 location and RO access
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 29, 2024 at 6:34=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jul 26, 2024 at 09:44:30AM -0400, Cleber Rosa wrote:
> > The tests under machine_aarch64_virt.py and machine_aarch64_sbsaref.py
> > should not be writing to the ISO files.  By adding "media=3Dcdrom" the
> > "ro" is autmatically set.
> >
> > While at it, let's use a single code style and hash for the ISO url.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/avocado/machine_aarch64_sbsaref.py |  6 +++++-
> >  tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/m=
achine_aarch64_sbsaref.py
> > index e920bbf08c..1275f24532 100644
> > --- a/tests/avocado/machine_aarch64_sbsaref.py
> > +++ b/tests/avocado/machine_aarch64_sbsaref.py
> > @@ -129,7 +129,11 @@ def boot_alpine_linux(self, cpu):
> >              "-cpu",
> >              cpu,
> >              "-drive",
> > -            f"file=3D{iso_path},format=3Draw",
> > +            f"file=3D{iso_path},media=3Dcdrom,format=3Draw",
> > +            "-device",
> > +            "virtio-rng-pci,rng=3Drng0",
> > +            "-object",
> > +            "rng-random,id=3Drng0,filename=3D/dev/urandom",
> >          )
>
> The commit message doesn't say anything about adding virtio-rng.
> If that's needed for some reason, do it as a separate commit
> with an explanation of the bug its fixing.
>

This is actually a rebase mistake.  virtio-rng was removed in 21f123f3c.

I'll fix it in a v2.

Thanks for spotting it,
- Cleber.


