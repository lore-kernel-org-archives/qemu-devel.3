Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB9606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CwqgVUjK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TksdNJhF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLj07-0006e8-A3; Tue, 27 Oct 2026 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLj03-0006dn-V2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLj00-00021d-FM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793114523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kevmq0/xY751NfDKZ7eV/LG3X2rtlRAaENKccFoSxOQ=;
 b=CwqgVUjKO/szAw6A61uxbD7OaE8yH/a2VOynfxRlbv8NeZQGAU5FeoxzrzdLjyDqsgO0Dj
 8SFrVsTwSXGlVbYC4f3RQ6jwmCFk1WNLjcQ8MA2VVEcX3O1bS9mJhNQnFQtCcBweTDabXD
 l2Qy8xHfjbyGW39BIjfMRYi9XZcu9jU=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-v2IIyl4_M5a9a8m4p6kCqA-1; Tue, 27 Oct 2026 11:22:01 -0400
X-MC-Unique: v2IIyl4_M5a9a8m4p6kCqA-1
X-Mimecast-MFC-AGG-ID: v2IIyl4_M5a9a8m4p6kCqA_1793114521
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso3034111eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114521; cv=none;
 d=google.com; s=arc-20260327;
 b=cBKnYpYRMuxy0a0INtfwCjO21bxGqrcA8GOX8VGR0VnupHesknfbr7U1DIGBDq7i0A
 9+W3ujIl2NBPM9IbtAV5SbOVFuyJt/5GzS9CpvEsFVCOLr/owXEOOsCwDxLInsBwZ30M
 GPeG9UYXYLsXzKkLIPAmN5NTfAkbC4R6w8pLfbmk/4y+gPyEYytV+xvyZAljxxN+ZTJA
 uypisJ3oYtwEn88EaahBnbuZQ0PWBoE/1/we/ikRDt1AEcn9Ba0s1BjYgjkUUHxc9tcD
 raXmWTWiDzK1dBpXzC4/9f7hwXYCMSWYqii7p3pw6hVjsC9Gl3ec465adZUVbzeqS3r2
 YqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kevmq0/xY751NfDKZ7eV/LG3X2rtlRAaENKccFoSxOQ=;
 fh=/0Wb58sJwXLecFJv96KTWthDCBNd+wSY38/+/9JPL1M=;
 b=RMDQQm7aH/0B3ZcPWKrUKKFkqG74ZS4P48LwA1HMWXIugRzUo3R3qPyTv3iWbMMKdZ
 4oS1/ouJ9huu9kgXnKVkf/jTV8tyQYnQRfZ9Bf6P1BIOAWBzS+rNtOk1A3UtG3NRY4pf
 sxQXOxeDxXTg/jOkr9prgqzHVWguuMe8HkVbZkdbaGBS4VKman24ifQBILfY5qYK0Xt4
 yTnJH2F1EqMw2aJPHaYrPw2ZrrduyJj7NAB1jKxl6fB2a9CXueo8O35s+5SupMRucMKW
 XNcsTJ58W4j/0ffjlIgXCbFiGpg1+1qWtwjZbCX22h9vUaI9wQlfcLUa1YkeVgS9l8pl
 ZYMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793114521; x=1793719321; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kevmq0/xY751NfDKZ7eV/LG3X2rtlRAaENKccFoSxOQ=;
 b=TksdNJhFjZNydo3ok9dW3/EVjRIw23RP2Un1oA0i/LSuBlb739+jLrJWpVIyf7OMGa
 idVHPW4kosytRmm4sWPb5vNCB4eFcLZIyihWWeyitjb33vhA4T8FzAtaH1Ym3fIaqn1b
 rLoI5xAOxO7PmctCKfmM1NSdVt3ECQbKY6Be2CDuuDvyVSMNypu0KMrGK5SyxGXZF05k
 JotwG4Y4Sx6NDvAb0FYrm2CdEBKedzd8q/emKGWmUYmP0Q/IZk9TDoPn0AjGphykO03n
 NbnZu2n3G9ylmfaN3dmbNgMZyG5vxk3SvU+yk0LjCZe2dR2/ufwNLyU3hvJOfuO7yeQt
 VYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114521; x=1793719321;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kevmq0/xY751NfDKZ7eV/LG3X2rtlRAaENKccFoSxOQ=;
 b=eydm49sjFHH6sRWKiOe23mqWokCSUfsAIz0Ku1e63Pd1nKw2tqe2q+W4XWAhiXz5ko
 Jc0eFY/IqxyoiUo+QCu8Cpj5VfrEQFHLYOhzo2RthAf7o9yil9HqWi23ndGMqAA/3YsS
 m1aUoTAZgHcGIg0wKRFZhXgLsjkh7R78ijFo+gtAFDmKKE01j2yUOVRnXAH4BzgWLrB9
 LI+bwQBtIGKr3dkcXiTOIpZWJXRTQCGJ2f4D0OPKKsvhZJrURag60jeU6Ha1bVeJoPRK
 Mm+WuOM44WzPeSEB7egvpTCFxW4qBd9cXoOwKdfUoGpSWTiIMdDPNMQUmMXeT0QbLEKm
 W6LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzs9xxGL6xKkO4i/UHI6bxllaaV8pSCrhi5Dr2EW9Rsc8HSxAwzBs8xLgK6egonZ5xNu8xvbPE7bz3@nongnu.org
X-Gm-Message-State: AFq9FYLHNno5jsAmwJhU9yLHm986RD16t4cRAY9cLQi/5e8zCvhSYyzH
 sfaZTWX83/qbg3WIUl7ENgAEpF0nU8BZ/NeLVKqD65oAWrJdBfzp3ZeHV2B/LVbdp2bNoEtzF8v
 GONZYnjwcaOFfgB5ZSHmeTitjFYbNmLrgJJmSKXLWLkk2SGBERf1rvH87gJy3kZFXltWqpHRfzb
 dWbqZY8u7f4mvyHtrX9+BYh6EqHWVkKhE=
X-Gm-Gg: AYBFou1rOlt6l6Hv3haI2nfd4dMo7qpw2pGBPmRHLTpLj2VSdSZW6MuJXaB7awAUMps
 C3SpzDq5GWGr30MUmRHsw5annrenjL5JuhRWKAxDNe6tuJOogBK8ZfOrO+zX8fPBuAmm11QTQMq
 t35nM3+Rox0zI5b7zWey/b0BWEGL3r4Wje+tqrZLVju6Rj3dMCPYX4zhGjNjXH5iiFMR/uEF+zw
 BX20yc5ZXzG/S3zLQ==
X-Received: by 2002:a05:7300:c735:b0:36a:1427:3933 with SMTP id
 5a478bee46e88-36a142742c6mr2717875eec.16.1793114520375; 
 Tue, 27 Oct 2026 08:22:00 -0700 (PDT)
X-Received: by 2002:a05:7300:c735:b0:36a:1427:3933 with SMTP id
 5a478bee46e88-36a142742c6mr2717848eec.16.1793114519728; Tue, 27 Oct 2026
 08:21:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260917154901.321702-1-aagbaria@redhat.com>
 <CAJ+F1C+dJ-UM1+u1kn+oZJ1rh=6BTP8dZVbembGyTR636teZ5Q@mail.gmail.com>
In-Reply-To: <CAJ+F1C+dJ-UM1+u1kn+oZJ1rh=6BTP8dZVbembGyTR636teZ5Q@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 27 Oct 2026 17:21:46 +0200
X-Gm-Features: AclHuK9pY9piqxlYnLgRGVhs_GtnbOvvy7Uha88QQbZDT2S-oIqHqFl6qYuvLwk
Message-ID: <CAPMcbCocjKcR=XyQyCXiLTzG6xCtn7SRLwuEcvLSNDfKOp7deg@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss-win32: remove orphaned VSS provider service
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Abed Agbaria <aagbaria@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000fd94ec065ed4010f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000fd94ec065ed4010f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Fri, Sep 18, 2026 at 9:57=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Sep 17, 2026 at 7:49=E2=80=AFPM Abed Agbaria <aagbaria@redhat.com=
> wrote:
> >
> > COMRegister() probes the COM+ catalog to decide whether to unregister
> > first, but it is the SCM that blocks installation when a service of the
> > same name is left over.  If the COM+ application is gone and the servic=
e
> > survives, install fails with 0x80070431 and never recovers.
> >
> >  - Check the SCM as well as the COM+ catalog in COMRegister().
> >  - Delete the provider service in COMUnregister() and at the
> >    DllUnregisterServer() call sites in DllRegisterServer().
> >
> > Opening the SCM, opening the provider service and closing both handles
> > is boilerplate that StopService() already contains, so move it into
> > QGAProviderOpenService(), which returns a single service handle and
> > reports the win32 error through an out parameter, and convert
> > StopService() to it.  The service handle stays valid after the SCM
> > handle is closed, so the helper closes it and each caller is left with
> > one handle to release.
> >
> > While at it, fix two pre-existing problems in StopService():
> >
> >  - It logged errmsg(E_FAIL, ...) and returned E_FAIL for every failure,
> >    discarding the GetLastError() value.  It now passes the win32 error
> >    code to errmsg() and returns HRESULT_FROM_WIN32().
> >  - It opened the SCM with SC_MANAGER_ALL_ACCESS, which implies
> >    SC_MANAGER_CREATE_SERVICE and is therefore refused to
> >    non-administrators, and passed that same SCM mask to OpenService()
> >    as a service access mask.  Each operation now requests only what it
> >    needs: SC_MANAGER_CONNECT on the SCM, and SERVICE_QUERY_CONFIG,
> >    DELETE or SERVICE_STOP on the service.
> >
> > StopService()'s return value changes from E_FAIL to a specific
> > HRESULT_FROM_WIN32(); its only caller, in requester.cpp, ignores it.
> >
> > Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> (you could have easily made a small series, I'll let other decide if
> it is necessary)
>
> thanks
>
> > ---
> >  qga/vss-win32/install.cpp | 122 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 105 insertions(+), 17 deletions(-)
> >
> > v1:
> https://lore.kernel.org/qemu-devel/20260915145320.215663-1-aagbaria@redha=
t.com/
> >
> > v2:
> >  - Pass win32 error codes to errmsg() consistently instead of mixing
> >    error codes and HRESULTs (Marc-Andr=C3=A9)
> >  - Factor the SCM/OpenService boilerplate into QGAProviderOpenService()
> >    and convert the existing StopService() to it (Marc-Andr=C3=A9)
> >  - Restrict StopService() to the access rights it actually needs
> >
> > Tested on a Windows guest by replacing the installed build with this
> > one and running a full install/uninstall cycle, including installation
> > over a leftover provider service.
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index 5b7a8e9bc5..cfafc2d95e 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -241,6 +241,96 @@ out:
> >      return hr;
> >  }
> >
> > +/*
> > + * Open the QGA VSS provider service with the requested access rights.
> > + *
> > + * On success, return a service handle which the caller must release
> with
> > + * CloseServiceHandle().  On failure, return NULL and store the win32
> error
> > + * code in *err.  ERROR_SERVICE_DOES_NOT_EXIST just means the service
> is not
> > + * installed, which is a normal condition for all callers, so it is no=
t
> > + * reported here; the caller decides what it means.
> > + */
> > +static SC_HANDLE QGAProviderOpenService(DWORD access, DWORD *err)
> > +{
> > +    qga_debug_begin;
> > +
> > +    SC_HANDLE service =3D NULL;
> > +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT=
);
> > +
> > +    *err =3D ERROR_SUCCESS;
> > +
> > +    if (!manager) {
> > +        *err =3D GetLastError();
> > +        errmsg(*err, "Failed to open service manager");
> > +        goto out;
> > +    }
> > +
> > +    service =3D OpenService(manager, QGA_PROVIDER_NAME, access);
> > +    if (!service) {
> > +        *err =3D GetLastError();
> > +        if (*err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> > +            errmsg(*err, "Failed to open service");
> > +        }
> > +    }
> > +
> > +out:
> > +    if (manager) {
> > +        CloseServiceHandle(manager);
> > +    }
> > +    qga_debug_end;
> > +    return service;
> > +}
> > +
> > +/* Check whether the QGA VSS provider service is registered with the
> SCM */
> > +static bool QGAProviderServiceExists(void)
> > +{
> > +    qga_debug_begin;
> > +
> > +    DWORD err;
> > +    SC_HANDLE service =3D QGAProviderOpenService(SERVICE_QUERY_CONFIG,
> &err);
> > +
> > +    if (service) {
> > +        CloseServiceHandle(service);
> > +    }
> > +
> > +    qga_debug_end;
> > +    return service !=3D NULL;
> > +}
> > +
> > +/* Delete a QGA VSS provider service that COM+ no longer owns */
> > +static HRESULT QGAProviderRemoveService(void)
> > +{
> > +    qga_debug_begin;
> > +
> > +    HRESULT hr =3D S_OK;
> > +    DWORD err;
> > +    SC_HANDLE service =3D QGAProviderOpenService(DELETE, &err);
> > +
> > +    if (!service) {
> > +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> > +            hr =3D HRESULT_FROM_WIN32(err);
> > +        }
> > +        goto out;
> > +    }
> > +
> > +    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
> > +
> > +    if (!DeleteService(service)) {
> > +        err =3D GetLastError();
> > +        if (err !=3D ERROR_SERVICE_MARKED_FOR_DELETE) {
> > +            hr =3D HRESULT_FROM_WIN32(err);
> > +            errmsg(err, "Failed to delete service");
> > +        }
> > +    }
> > +
> > +out:
> > +    if (service) {
> > +        CloseServiceHandle(service);
> > +    }
> > +    qga_debug_end;
> > +    return hr;
> > +}
> > +
> >  /* Unregister this module from COM+ Applications Catalog */
> >  STDAPI COMUnregister(void);
> >  STDAPI COMUnregister(void)
> > @@ -251,6 +341,7 @@ STDAPI COMUnregister(void)
> >
> >      DllUnregisterServer();
> >      chk(QGAProviderFind(QGAProviderRemove, NULL));
> > +    chk(QGAProviderRemoveService());
> >  out:
> >      qga_debug_end;
> >      return hr;
> > @@ -286,7 +377,7 @@ STDAPI COMRegister(void)
> >      }
> >
> >      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> > -    if (count) {
> > +    if (count || QGAProviderServiceExists()) {
> >          qga_debug("QGA VSS Provider is already installed. Attempting t=
o
> unregister first.");
> >          hr =3D COMUnregister();
> >          if (FAILED(hr)) {
> > @@ -499,6 +590,7 @@ STDAPI DllRegisterServer(void)
> >                                       g_gProviderVersion);
> >      if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
> >          DllUnregisterServer();
> > +        QGAProviderRemoveService();
> >          hr =3D pVssAdmin->RegisterProvider(g_gProviderId,
> CLSID_QGAVSSProvider,
> >                                           const_cast<WCHAR * >
> >                                           (QGA_PROVIDER_LNAME),
> > @@ -515,6 +607,7 @@ STDAPI DllRegisterServer(void)
> >  out:
> >      if (FAILED(hr)) {
> >          DllUnregisterServer();
> > +        QGAProviderRemoveService();
> >      }
> >
> >      qga_debug_end;
> > @@ -575,29 +668,24 @@ STDAPI StopService(void)
> >      qga_debug_begin;
> >
> >      HRESULT hr =3D S_OK;
> > -    SC_HANDLE manager =3D OpenSCManager(NULL, NULL,
> SC_MANAGER_ALL_ACCESS);
> > -    SC_HANDLE service =3D NULL;
> > -
> > -    if (!manager) {
> > -        errmsg(E_FAIL, "Failed to open service manager");
> > -        hr =3D E_FAIL;
> > -        goto out;
> > -    }
> > -    service =3D OpenService(manager, QGA_PROVIDER_NAME,
> SC_MANAGER_ALL_ACCESS);
> > +    DWORD err;
> > +    SC_HANDLE service =3D QGAProviderOpenService(SERVICE_STOP, &err);
> >
> >      if (!service) {
> > -        errmsg(E_FAIL, "Failed to open service");
> > -        hr =3D  E_FAIL;
> > +        hr =3D HRESULT_FROM_WIN32(err);
> >          goto out;
> >      }
> > -    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
> > -        errmsg(E_FAIL, "Failed to stop service");
> > -        hr =3D E_FAIL;
> > +
> > +    if (!ControlService(service, SERVICE_CONTROL_STOP, NULL)) {
> > +        err =3D GetLastError();
> > +        hr =3D HRESULT_FROM_WIN32(err);
> > +        errmsg(err, "Failed to stop service");
> >      }
> >
> >  out:
> > -    CloseServiceHandle(service);
> > -    CloseServiceHandle(manager);
> > +    if (service) {
> > +        CloseServiceHandle(service);
> > +    }
> >      qga_debug_end;
> >      return hr;
> >  }
> > --
> > 2.55.0
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
>

--000000000000fd94ec065ed4010f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><br><div><br clear=3D"all"></=
div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.c=
om">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 18, 2026 a=
t 9:57=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
On Thu, Sep 17, 2026 at 7:49=E2=80=AFPM Abed Agbaria &lt;<a href=3D"mailto:=
aagbaria@redhat.com" target=3D"_blank">aagbaria@redhat.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; COMRegister() probes the COM+ catalog to decide whether to unregister<=
br>
&gt; first, but it is the SCM that blocks installation when a service of th=
e<br>
&gt; same name is left over.=C2=A0 If the COM+ application is gone and the =
service<br>
&gt; survives, install fails with 0x80070431 and never recovers.<br>
&gt;<br>
&gt;=C2=A0 - Check the SCM as well as the COM+ catalog in COMRegister().<br=
>
&gt;=C2=A0 - Delete the provider service in COMUnregister() and at the<br>
&gt;=C2=A0 =C2=A0 DllUnregisterServer() call sites in DllRegisterServer().<=
br>
&gt;<br>
&gt; Opening the SCM, opening the provider service and closing both handles=
<br>
&gt; is boilerplate that StopService() already contains, so move it into<br=
>
&gt; QGAProviderOpenService(), which returns a single service handle and<br=
>
&gt; reports the win32 error through an out parameter, and convert<br>
&gt; StopService() to it.=C2=A0 The service handle stays valid after the SC=
M<br>
&gt; handle is closed, so the helper closes it and each caller is left with=
<br>
&gt; one handle to release.<br>
&gt;<br>
&gt; While at it, fix two pre-existing problems in StopService():<br>
&gt;<br>
&gt;=C2=A0 - It logged errmsg(E_FAIL, ...) and returned E_FAIL for every fa=
ilure,<br>
&gt;=C2=A0 =C2=A0 discarding the GetLastError() value.=C2=A0 It now passes =
the win32 error<br>
&gt;=C2=A0 =C2=A0 code to errmsg() and returns HRESULT_FROM_WIN32().<br>
&gt;=C2=A0 - It opened the SCM with SC_MANAGER_ALL_ACCESS, which implies<br=
>
&gt;=C2=A0 =C2=A0 SC_MANAGER_CREATE_SERVICE and is therefore refused to<br>
&gt;=C2=A0 =C2=A0 non-administrators, and passed that same SCM mask to Open=
Service()<br>
&gt;=C2=A0 =C2=A0 as a service access mask.=C2=A0 Each operation now reques=
ts only what it<br>
&gt;=C2=A0 =C2=A0 needs: SC_MANAGER_CONNECT on the SCM, and SERVICE_QUERY_C=
ONFIG,<br>
&gt;=C2=A0 =C2=A0 DELETE or SERVICE_STOP on the service.<br>
&gt;<br>
&gt; StopService()&#39;s return value changes from E_FAIL to a specific<br>
&gt; HRESULT_FROM_WIN32(); its only caller, in requester.cpp, ignores it.<b=
r>
&gt;<br>
&gt; Signed-off-by: Abed Agbaria &lt;<a href=3D"mailto:aagbaria@redhat.com"=
 target=3D"_blank">aagbaria@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
(you could have easily made a small series, I&#39;ll let other decide if<br=
>
it is necessary)<br>
<br>
thanks<br>
<br>
&gt; ---<br>
&gt;=C2=A0 qga/vss-win32/install.cpp | 122 ++++++++++++++++++++++++++++++++=
------<br>
&gt;=C2=A0 1 file changed, 105 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260915145320.21566=
3-1-aagbaria@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/20260915145320.215663-1-aagbaria@redhat.com/</a><br>
&gt;<br>
&gt; v2:<br>
&gt;=C2=A0 - Pass win32 error codes to errmsg() consistently instead of mix=
ing<br>
&gt;=C2=A0 =C2=A0 error codes and HRESULTs (Marc-Andr=C3=A9)<br>
&gt;=C2=A0 - Factor the SCM/OpenService boilerplate into QGAProviderOpenSer=
vice()<br>
&gt;=C2=A0 =C2=A0 and convert the existing StopService() to it (Marc-Andr=
=C3=A9)<br>
&gt;=C2=A0 - Restrict StopService() to the access rights it actually needs<=
br>
&gt;<br>
&gt; Tested on a Windows guest by replacing the installed build with this<b=
r>
&gt; one and running a full install/uninstall cycle, including installation=
<br>
&gt; over a leftover provider service.<br>
&gt;<br>
&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
&gt; index 5b7a8e9bc5..cfafc2d95e 100644<br>
&gt; --- a/qga/vss-win32/install.cpp<br>
&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt; @@ -241,6 +241,96 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return hr;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/*<br>
&gt; + * Open the QGA VSS provider service with the requested access rights=
.<br>
&gt; + *<br>
&gt; + * On success, return a service handle which the caller must release =
with<br>
&gt; + * CloseServiceHandle().=C2=A0 On failure, return NULL and store the =
win32 error<br>
&gt; + * code in *err.=C2=A0 ERROR_SERVICE_DOES_NOT_EXIST just means the se=
rvice is not<br>
&gt; + * installed, which is a normal condition for all callers, so it is n=
ot<br>
&gt; + * reported here; the caller decides what it means.<br>
&gt; + */<br>
&gt; +static SC_HANDLE QGAProviderOpenService(DWORD access, DWORD *err)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qga_debug_begin;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE service =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANA=
GER_CONNECT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *err =3D ERROR_SUCCESS;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!manager) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(*err, &quot;Failed to open service=
 manager&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 service =3D OpenService(manager, QGA_PROVIDER_NAME, acc=
ess);<br>
&gt; +=C2=A0 =C2=A0 if (!service) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*err !=3D ERROR_SERVICE_DOES_NOT_EXIS=
T) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(*err, &quot;Failed t=
o open service&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (manager) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(manager);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qga_debug_end;<br>
&gt; +=C2=A0 =C2=A0 return service;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Check whether the QGA VSS provider service is registered with the =
SCM */<br>
&gt; +static bool QGAProviderServiceExists(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qga_debug_begin;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 DWORD err;<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE service =3D QGAProviderOpenService(SERVICE_QU=
ERY_CONFIG, &amp;err);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (service) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(service);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qga_debug_end;<br>
&gt; +=C2=A0 =C2=A0 return service !=3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Delete a QGA VSS provider service that COM+ no longer owns */<br>
&gt; +static HRESULT QGAProviderRemoveService(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qga_debug_begin;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr =3D S_OK;<br>
&gt; +=C2=A0 =C2=A0 DWORD err;<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE service =3D QGAProviderOpenService(DELETE, &a=
mp;err);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!service) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D HRESULT_FROM_WIN32(e=
rr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qga_debug(&quot;Removing service: %s&quot;, QGA_PROVIDE=
R_NAME);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!DeleteService(service)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D ERROR_SERVICE_MARKED_FOR_DEL=
ETE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D HRESULT_FROM_WIN32(e=
rr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(err, &quot;Failed to=
 delete service&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (service) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(service);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qga_debug_end;<br>
&gt; +=C2=A0 =C2=A0 return hr;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /* Unregister this module from COM+ Applications Catalog */<br>
&gt;=C2=A0 STDAPI COMUnregister(void);<br>
&gt;=C2=A0 STDAPI COMUnregister(void)<br>
&gt; @@ -251,6 +341,7 @@ STDAPI COMUnregister(void)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DllUnregisterServer();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 chk(QGAProviderFind(QGAProviderRemove, NULL));<br>
&gt; +=C2=A0 =C2=A0 chk(QGAProviderRemoveService());<br>
&gt;=C2=A0 out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return hr;<br>
&gt; @@ -286,7 +377,7 @@ STDAPI COMRegister(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 chk(QGAProviderFind(QGAProviderCount, (void *)&amp=
;count));<br>
&gt; -=C2=A0 =C2=A0 if (count) {<br>
&gt; +=C2=A0 =C2=A0 if (count || QGAProviderServiceExists()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;QGA VSS Provider is =
already installed. Attempting to unregister first.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D COMUnregister();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; @@ -499,6 +590,7 @@ STDAPI DllRegisterServer(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_gPro=
viderVersion);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_RE=
GISTERED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DllUnregisterServer();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QGAProviderRemoveService();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D pVssAdmin-&gt;RegisterProvide=
r(g_gProviderId, CLSID_QGAVSSProvider,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const_cast&lt;WCHAR * &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(QGA_PROVIDER_LNAME),<br>
&gt; @@ -515,6 +607,7 @@ STDAPI DllRegisterServer(void)<br>
&gt;=C2=A0 out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DllUnregisterServer();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QGAProviderRemoveService();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
&gt; @@ -575,29 +668,24 @@ STDAPI StopService(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_begin;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 HRESULT hr =3D S_OK;<br>
&gt; -=C2=A0 =C2=A0 SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANA=
GER_ALL_ACCESS);<br>
&gt; -=C2=A0 =C2=A0 SC_HANDLE service =3D NULL;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (!manager) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(E_FAIL, &quot;Failed to open servi=
ce manager&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_FAIL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 service =3D OpenService(manager, QGA_PROVIDER_NAME, SC_=
MANAGER_ALL_ACCESS);<br>
&gt; +=C2=A0 =C2=A0 DWORD err;<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE service =3D QGAProviderOpenService(SERVICE_ST=
OP, &amp;err);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!service) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(E_FAIL, &quot;Failed to open servi=
ce&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D=C2=A0 E_FAIL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D HRESULT_FROM_WIN32(err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (!(ControlService(service, SERVICE_CONTROL_STOP, NUL=
L))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(E_FAIL, &quot;Failed to stop servi=
ce&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_FAIL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ControlService(service, SERVICE_CONTROL_STOP, NULL=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D HRESULT_FROM_WIN32(err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(err, &quot;Failed to stop service&=
quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 out:<br>
&gt; -=C2=A0 =C2=A0 CloseServiceHandle(service);<br>
&gt; -=C2=A0 =C2=A0 CloseServiceHandle(manager);<br>
&gt; +=C2=A0 =C2=A0 if (service) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(service);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return hr;<br>
&gt;=C2=A0 }<br>
&gt; --<br>
&gt; 2.55.0<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div>

--000000000000fd94ec065ed4010f--


