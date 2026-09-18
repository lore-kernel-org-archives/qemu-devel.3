Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509D0C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SWs-0008VY-Nf; Fri, 18 Sep 2026 02:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x7SWq-0008VL-T2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:57:00 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x7SWo-00039k-7P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:57:00 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cc50b9e8a45so178722a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 23:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789714614; cv=none;
 d=google.com; s=arc-20260327;
 b=Orj+dTC0PWwGs0onqi+opp0rv+SXRkHF6k6+l5ADYPrVeme6R+O9pdxm0zBwXER8h+
 /Kny8aZKO2Q3dMvC2WvUZChwTZLfYEBeKs6e5zjydSMktAnbwFmRqK7KW2zLxKy4VuCd
 GUstma2pU/i0C/JuLd4ixyG43mVAaHwkVQp5UrfLyDXUUJK72MupASgUR31pLERA5lAo
 4PYM1c7cxtRFr0jR8CAOFkSo2w9dO+TahLsNX+gGgXrOh0t3E8NhG2NSogyvZ+2gN5lD
 Y2Z06VJic6yBv8dfgLPfiSMLwEpG2FlwZ1s0g/gBe5vuRFVCh2MjClkhaHn1DFzY/obK
 rG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LUG6yg0h0Xu/TAqzerQ2+8E/81pAwIAelieuzrP+kkA=;
 fh=5k2b0/n15VPsmIXH49PxIvFxtutXfoPYJqVHOWDgVXs=;
 b=B5WLJujGcNhzZnzEvtu+VKBdH4f81SBqSx8+Pnvu5P3YIHOcH8sGOSw8ZIzFfxAQ7J
 T65pOO4/Xy6T2ZC6Z4BsFs6UcSnzRKbOT8tv8HjhkC88tMfFZeWOPqLnInsdEHGSeGqJ
 ItL8zSxPRBVwopGtlWygO95pMk3GwXtX3mtvSXuwTgaMv4mG9SUEQroA/zVIRSNTGFF2
 GKMYhgC9V3yZ+5lc71rPIwDB6dc8Ph3WZfoYOp4UjA5ih9UCWNZASAogr3od7ZJ9sZPI
 kiRHiS49R/oDrtaTpyw3qFgFs1p0KXe6Xi6uafROfLAf+VJkVeLwp2ge7C90eAwS+gbR
 s7mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789714614; x=1790319414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LUG6yg0h0Xu/TAqzerQ2+8E/81pAwIAelieuzrP+kkA=;
 b=GJxXdgNUNlKfz+k57duyHjtH9YxDMfh0dU3t2NUnub/UMMCTRivgJR77FjhbuNshjI
 G6nzF26aY+dRhSIbOhKS8lMkVfQeYEyyrhO1boX6MMjj0EJWn7wFsB5h32DXEJivvglD
 ry/zD5XVIJdcMe6I+Am9IB0MU4A/s7QXO8U3pJzfB8fUc2tbPMuU7LTYYeZkLIlREMPh
 Q8iZGrrnsu/cQpLlYy+UIxfBJZy4E2CE5MdiuvDBdr9B75WO5Fp/kEm5s1o2Ai5di2X5
 KiYAO44ujbqhNmbZp0EAQLnQITUe4U7ERngZWa2CxH7W0Io9WNYxiP4tLL3k1pNryXX6
 f+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789714614; x=1790319414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LUG6yg0h0Xu/TAqzerQ2+8E/81pAwIAelieuzrP+kkA=;
 b=0LYlA544vfiLkpB/edi3DK1dzWjdnQsPfWoBf8VfpOyFUfVw+T+3gvDhVD4v0kFheS
 MUVU1+KcL46aYL7anFpsT9K3qUHDZCgRH+YNHgzr64DfXn1UQ3akcyi0eAy1oZgawoYf
 irPC6mgqO4WG/FeCez8jDegzYBrswU9OpACem+AUGwYXLJTx1lLz5LQ3nQBi/XhkL6MW
 0yzaLvJz+mX/eA6+5DPkU8R+9TzUcEFS78WaieXnTNG8ytaQbp0emo89eeoNWDAfTDa2
 SOLBhtSMiUjsjVCRZt8mo3pDTi3f6J+NgdM6dEj2qLJ9VbvwFxNpqyyaWFiPIREe/Ie1
 fmpQ==
X-Gm-Message-State: AFuF++ku1ftvViCRakEZK4Kz4TwN5Cg97620R3br0nQnPv7XoszUXpqw
 q01K86FOaXR209YjFtV1Gam9+rzOqgTjU1hVthedc0shpOCaiTtyzN4XF12SRY5VJehOvYj1svp
 qFuMvCmvti+RkeIyh3aJ4ohMtm0KEkvL/vx4v
X-Gm-Gg: AYBFou3VqZ6ROKLuVP08GAF/voPWBhUxf8z896fTjC1KNg976sSKvV7YhAVtPO+9AtK
 NcSOFMpoDct16OijXEwXv1NHnuX6v17/NFV6uYQYNVSv7SdGQZnQf7ToWi1/QZsyViXIg2/jn8E
 yGdkpmV2oy4Hf/6pA5eYD84A+rKmSyw4MtlKmgoWO+eDDKV7PP14LZLEjTmHEbR7xNcvI09nxP1
 DyqCqNNSfJGjuhOIRwDzyXgKvx/vvKRXdg0xFEAJkAGOVFvTFuf9ejAQwq7XgmCG2zxWnSUwGar
 WXP4pRy0m6++2FHQ1Lo1RwWysTzLaOtQByKqVc6Kt4X8OuGGmz/82e8dDWkE6PjMjQrPFj5tfNS
 MiZJTj3FaJcg=
X-Received: by 2002:a05:6a20:2d0b:b0:3dd:85a8:cad5 with SMTP id
 adf61e73a8af0-3dd8c4d4cbfmr2932784637.44.1789714614456; Thu, 17 Sep 2026
 23:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260917154901.321702-1-aagbaria@redhat.com>
In-Reply-To: <20260917154901.321702-1-aagbaria@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Sep 2026 10:56:42 +0400
X-Gm-Features: AcwNN1WAgPd3QngreVNtVRJNfmWJuZ4CSJfXbGFBvdd81dXu94ozeLljjvybO_I
Message-ID: <CAJ+F1C+dJ-UM1+u1kn+oZJ1rh=6BTP8dZVbembGyTR636teZ5Q@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss-win32: remove orphaned VSS provider service
To: Abed Agbaria <aagbaria@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Sep 17, 2026 at 7:49=E2=80=AFPM Abed Agbaria <aagbaria@redhat.com> =
wrote:
>
> COMRegister() probes the COM+ catalog to decide whether to unregister
> first, but it is the SCM that blocks installation when a service of the
> same name is left over.  If the COM+ application is gone and the service
> survives, install fails with 0x80070431 and never recovers.
>
>  - Check the SCM as well as the COM+ catalog in COMRegister().
>  - Delete the provider service in COMUnregister() and at the
>    DllUnregisterServer() call sites in DllRegisterServer().
>
> Opening the SCM, opening the provider service and closing both handles
> is boilerplate that StopService() already contains, so move it into
> QGAProviderOpenService(), which returns a single service handle and
> reports the win32 error through an out parameter, and convert
> StopService() to it.  The service handle stays valid after the SCM
> handle is closed, so the helper closes it and each caller is left with
> one handle to release.
>
> While at it, fix two pre-existing problems in StopService():
>
>  - It logged errmsg(E_FAIL, ...) and returned E_FAIL for every failure,
>    discarding the GetLastError() value.  It now passes the win32 error
>    code to errmsg() and returns HRESULT_FROM_WIN32().
>  - It opened the SCM with SC_MANAGER_ALL_ACCESS, which implies
>    SC_MANAGER_CREATE_SERVICE and is therefore refused to
>    non-administrators, and passed that same SCM mask to OpenService()
>    as a service access mask.  Each operation now requests only what it
>    needs: SC_MANAGER_CONNECT on the SCM, and SERVICE_QUERY_CONFIG,
>    DELETE or SERVICE_STOP on the service.
>
> StopService()'s return value changes from E_FAIL to a specific
> HRESULT_FROM_WIN32(); its only caller, in requester.cpp, ignores it.
>
> Signed-off-by: Abed Agbaria <aagbaria@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(you could have easily made a small series, I'll let other decide if
it is necessary)

thanks

> ---
>  qga/vss-win32/install.cpp | 122 ++++++++++++++++++++++++++++++++------
>  1 file changed, 105 insertions(+), 17 deletions(-)
>
> v1: https://lore.kernel.org/qemu-devel/20260915145320.215663-1-aagbaria@r=
edhat.com/
>
> v2:
>  - Pass win32 error codes to errmsg() consistently instead of mixing
>    error codes and HRESULTs (Marc-Andr=C3=A9)
>  - Factor the SCM/OpenService boilerplate into QGAProviderOpenService()
>    and convert the existing StopService() to it (Marc-Andr=C3=A9)
>  - Restrict StopService() to the access rights it actually needs
>
> Tested on a Windows guest by replacing the installed build with this
> one and running a full install/uninstall cycle, including installation
> over a leftover provider service.
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5b7a8e9bc5..cfafc2d95e 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -241,6 +241,96 @@ out:
>      return hr;
>  }
>
> +/*
> + * Open the QGA VSS provider service with the requested access rights.
> + *
> + * On success, return a service handle which the caller must release wit=
h
> + * CloseServiceHandle().  On failure, return NULL and store the win32 er=
ror
> + * code in *err.  ERROR_SERVICE_DOES_NOT_EXIST just means the service is=
 not
> + * installed, which is a normal condition for all callers, so it is not
> + * reported here; the caller decides what it means.
> + */
> +static SC_HANDLE QGAProviderOpenService(DWORD access, DWORD *err)
> +{
> +    qga_debug_begin;
> +
> +    SC_HANDLE service =3D NULL;
> +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
> +
> +    *err =3D ERROR_SUCCESS;
> +
> +    if (!manager) {
> +        *err =3D GetLastError();
> +        errmsg(*err, "Failed to open service manager");
> +        goto out;
> +    }
> +
> +    service =3D OpenService(manager, QGA_PROVIDER_NAME, access);
> +    if (!service) {
> +        *err =3D GetLastError();
> +        if (*err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> +            errmsg(*err, "Failed to open service");
> +        }
> +    }
> +
> +out:
> +    if (manager) {
> +        CloseServiceHandle(manager);
> +    }
> +    qga_debug_end;
> +    return service;
> +}
> +
> +/* Check whether the QGA VSS provider service is registered with the SCM=
 */
> +static bool QGAProviderServiceExists(void)
> +{
> +    qga_debug_begin;
> +
> +    DWORD err;
> +    SC_HANDLE service =3D QGAProviderOpenService(SERVICE_QUERY_CONFIG, &=
err);
> +
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
> +
> +    qga_debug_end;
> +    return service !=3D NULL;
> +}
> +
> +/* Delete a QGA VSS provider service that COM+ no longer owns */
> +static HRESULT QGAProviderRemoveService(void)
> +{
> +    qga_debug_begin;
> +
> +    HRESULT hr =3D S_OK;
> +    DWORD err;
> +    SC_HANDLE service =3D QGAProviderOpenService(DELETE, &err);
> +
> +    if (!service) {
> +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> +            hr =3D HRESULT_FROM_WIN32(err);
> +        }
> +        goto out;
> +    }
> +
> +    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
> +
> +    if (!DeleteService(service)) {
> +        err =3D GetLastError();
> +        if (err !=3D ERROR_SERVICE_MARKED_FOR_DELETE) {
> +            hr =3D HRESULT_FROM_WIN32(err);
> +            errmsg(err, "Failed to delete service");
> +        }
> +    }
> +
> +out:
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
> +    qga_debug_end;
> +    return hr;
> +}
> +
>  /* Unregister this module from COM+ Applications Catalog */
>  STDAPI COMUnregister(void);
>  STDAPI COMUnregister(void)
> @@ -251,6 +341,7 @@ STDAPI COMUnregister(void)
>
>      DllUnregisterServer();
>      chk(QGAProviderFind(QGAProviderRemove, NULL));
> +    chk(QGAProviderRemoveService());
>  out:
>      qga_debug_end;
>      return hr;
> @@ -286,7 +377,7 @@ STDAPI COMRegister(void)
>      }
>
>      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> -    if (count) {
> +    if (count || QGAProviderServiceExists()) {
>          qga_debug("QGA VSS Provider is already installed. Attempting to =
unregister first.");
>          hr =3D COMUnregister();
>          if (FAILED(hr)) {
> @@ -499,6 +590,7 @@ STDAPI DllRegisterServer(void)
>                                       g_gProviderVersion);
>      if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
>          DllUnregisterServer();
> +        QGAProviderRemoveService();
>          hr =3D pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSPr=
ovider,
>                                           const_cast<WCHAR * >
>                                           (QGA_PROVIDER_LNAME),
> @@ -515,6 +607,7 @@ STDAPI DllRegisterServer(void)
>  out:
>      if (FAILED(hr)) {
>          DllUnregisterServer();
> +        QGAProviderRemoveService();
>      }
>
>      qga_debug_end;
> @@ -575,29 +668,24 @@ STDAPI StopService(void)
>      qga_debug_begin;
>
>      HRESULT hr =3D S_OK;
> -    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCES=
S);
> -    SC_HANDLE service =3D NULL;
> -
> -    if (!manager) {
> -        errmsg(E_FAIL, "Failed to open service manager");
> -        hr =3D E_FAIL;
> -        goto out;
> -    }
> -    service =3D OpenService(manager, QGA_PROVIDER_NAME, SC_MANAGER_ALL_A=
CCESS);
> +    DWORD err;
> +    SC_HANDLE service =3D QGAProviderOpenService(SERVICE_STOP, &err);
>
>      if (!service) {
> -        errmsg(E_FAIL, "Failed to open service");
> -        hr =3D  E_FAIL;
> +        hr =3D HRESULT_FROM_WIN32(err);
>          goto out;
>      }
> -    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
> -        errmsg(E_FAIL, "Failed to stop service");
> -        hr =3D E_FAIL;
> +
> +    if (!ControlService(service, SERVICE_CONTROL_STOP, NULL)) {
> +        err =3D GetLastError();
> +        hr =3D HRESULT_FROM_WIN32(err);
> +        errmsg(err, "Failed to stop service");
>      }
>
>  out:
> -    CloseServiceHandle(service);
> -    CloseServiceHandle(manager);
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
>      qga_debug_end;
>      return hr;
>  }
> --
> 2.55.0
>


--=20
Marc-Andr=C3=A9 Lureau

