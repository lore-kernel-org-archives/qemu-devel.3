Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A65FC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zoy-0008Ix-RH; Fri, 25 Sep 2026 02:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x9zou-0008Ib-CF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 02:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x9zon-0003i0-Qh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 02:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790319240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bc+F0zKUS92xjtrbF7t8opySfKDcC25C5aNev8y4j8Q=;
 b=fTN9Bx/zXwIzZQWLPj52hzHepmn6GrcpxHe8W4xsOZ9KdEuKe1P6B8JmT04qljo9utuDCc
 knezp5M48f9SaiJ0R8oE8a3YIKbVOGG47pTjHqU41kSL98Ea7ZdpvB/ILcle9LOIkfVgme
 1xeHoiVKx343qizJAi+slJ/7WYIGJGI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-0k201ikWNFqJqh63S5bvXw-1; Fri, 25 Sep 2026 02:53:58 -0400
X-MC-Unique: 0k201ikWNFqJqh63S5bvXw-1
X-Mimecast-MFC-AGG-ID: 0k201ikWNFqJqh63S5bvXw_1790319238
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-912054a1c29so5236516d6.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 23:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790319238; cv=none;
 d=google.com; s=arc-20260327;
 b=D7otHniCiImm9whPui6p3yWLLqkNEuDKPqFqIiTG6N9yI//qzN46zSxlUUnj8tmlqh
 NM6ZH8+iHKYHsVzb+K9b56jNvsIux2yyPvVzc9O2N1XV0xkLyRLBcvklodcligDLN9YB
 LyPlLQ64B+9ESoEKZ9EjtNWKXNw+nQlm3vc7IUvpKAnufhCSkyLy544Gbp2Sl8Jb/KoX
 5FNYTvJaJfeC6d/Rq7zOY3oChUwuQp1nfY/oDbpDdjzaz7bgkuSdFAJ2IPUv/KIiuRdg
 HJp5KopYSg12S0MMLWIvV+tA2QEvqQEZeIRxdlwAckw5fbZMFtw+QYwhZOrMMshm/fQK
 ayig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bc+F0zKUS92xjtrbF7t8opySfKDcC25C5aNev8y4j8Q=;
 fh=4aEyD2eUrW8ILc4bUaTgBFDGZKIkMvMEbO0hfRoJZ0I=;
 b=r77r/xG/Ay8fuUvG9HW8gDryQDDKuCDMzQEWgungrfLN/u4x7M/cI9fbwIRi1SrQsr
 7OrltB7nnjhwUwTyPXb3g3RXPjbjPDzOL1eF1TfPzyx0ZEwqsID8l+2tp24LWgwEa8eP
 yLdb9/+aOGEmaH0uqyo1j15GJP3QB9PLiDrODM6Z3s1Fw2PaIfjuffHGI1AUw9iLNB/N
 /e71xcO2cUuFDNsUVuvTdGmO70OLcJ5ZzvPQaKhXtuEtLFgEN4vI23Ji5IPCGWBNea5u
 ydwfbgGUK9DX+VAai5LIimVc0S34lJkjRs1q+IValrhlEeclcrkN1h7S4blDiE+8UeGQ
 FBNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790319238; x=1790924038; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bc+F0zKUS92xjtrbF7t8opySfKDcC25C5aNev8y4j8Q=;
 b=WdHHdMlxAmDx7xNjdpITpuCYHwvMIVMN4zSCHTLZjo0Tt6BbMRWMHRxf09T8PN7fKq
 MQcvnpnzjMwkP+WDvmFWGHpnjZGWHz+BVx3AS0An6HRkuh8burZepjUJapXAlJoqYiti
 4WQ6FS/ayVhUti8tICAbWZ+96GtJYE5Ior0Wxu6tCS0lz0w83EgPcP2L+EW26bgwL2Rk
 +5hkoAA4yY+So31BnVQjcYyE0CrC9S7wjH8z4JZEby1Zy1UfD2/mVrClA525WaQU7rkz
 RcuHZ2Y7VJyjAKbpLsNkBTU52ZjlHuyzekeIsL6EHIdxysDIXGitIj1c+i32BtLBRgrf
 Rklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790319238; x=1790924038;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bc+F0zKUS92xjtrbF7t8opySfKDcC25C5aNev8y4j8Q=;
 b=e2dZOdpggd7i2T1rtrd62rqOGVS9C8PEmdpilsj0zLH/Ahpw/YIph1gOlRWvSS778w
 83/xuYUEG5V4fAhpJljNQcnR7wzRrjFfkqdCMjkm1f7XyNfuXi55BUb/iY9rC23/YCxQ
 oO0Xpltyom7KyLVFPJQPoZIZFAjodpz8zoZSJwIE8Lnhh9tINNcl6dyIg7swtysJ+d9y
 d6qZBHOf6oIimqMDsbkdEptwdsMjiDPZrpegjelbm74CAxqmx/CgQ+nfq2vigsTIR9/j
 dpY8N//fQvcDoqqQoSCGz0i+OF9L1/KXSn1dB+V7C74wujV4dQzCtwzl0i62kTg0f0+z
 R4RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRQHTQWshDSmE61DGKiL0EJwDGzwSBr4wyVDhdL7wm4Mi3YZWXh1swSkmaOFXVi6L+AZu79JAM8ibG@nongnu.org
X-Gm-Message-State: AFuF++lxiVJQwooS3QYoX5hShXYtYFrfzBRpZsaEi4MImeTm65ergn7T
 84pvuKYG/coZ3zzI8roWymJUMyhFY9eZ2Hv5c0tLgtnJiOyQzDaSEU3VYkn1S3zCnF2hTnR01kX
 +ctO+68vtNK3R1Wo+NsmCeRvSFZAdzOVDHbST8R/Lr3MgS8m6og/jsVX/ymsO0mIpCQQJaDOlV9
 aw0gI5EkokjKQDLj0RVYKbmtfgpytzi/0=
X-Gm-Gg: AYBFou2JNb/PsiQl+wvqO51tOO6lSPL0Ql2O6e/Luoq5ajyEpm97mtFv+c5d4egxGNE
 zMvriAwstwg8pSOW4bWP3+xBGoqjZX7FWxkXGBWWMtB7CS20uItGIVrfe21ymG3sESmLPj72meZ
 Sqoxa/8PrlUOD76I40e1TRmHAjLWX5hOKm9Hauy3Vq1E9L1ccxdQ0QWIQs3GU=
X-Received: by 2002:a05:6214:2c0d:b0:912:5135:2a86 with SMTP id
 6a1803df08f44-9142f7523a0mr22289786d6.15.1790319237262; 
 Thu, 24 Sep 2026 23:53:57 -0700 (PDT)
X-Received: by 2002:a05:6214:2c0d:b0:912:5135:2a86 with SMTP id
 6a1803df08f44-9142f7523a0mr22289546d6.15.1790319236517; Thu, 24 Sep 2026
 23:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260924154424.3786199-1-eashurov@redhat.com>
 <179027887067.2199270.3360769883164272952.b4-review@b4>
In-Reply-To: <179027887067.2199270.3360769883164272952.b4-review@b4>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 25 Sep 2026 09:53:44 +0300
X-Gm-Features: AclHuK_TkDrT9KFqSHyz4GxYh5FeMtJIjZ-lcPOlH2MfkYNT_4Y7eq7zMu3yBHA
Message-ID: <CAPMcbCo0YzSVJtrYoOO80-vRB=qDmjT-sbbaEANbyED7phUVww@mail.gmail.com>
Subject: Re: [PATCH] qga: Add guest-get-drivers command for Windows
To: marcandre.lureau@redhat.com
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 dholler@redhat.com, 
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com
Content-Type: multipart/alternative; boundary="00000000000020ac32065c492eff"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000020ac32065c492eff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 10:41=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:

> > Add a new guest-get-drivers command that reports two independent lists
> > of Windows driver information:
> >
> >  - packages: out-of-box driver packages enumerated with the DISM API
> >    (DismGetDrivers). Each entry includes the published INF name,
> >    original INF name, version, and provider.
> >  - services: registered driver services enumerated with the Service
> >    Control Manager (EnumServicesStatusExW). Each entry includes the
> >    service name, configured binary path, current SCM status, and
> >    FileVersion and CompanyName metadata from the driver binary.
> >
> > Load DismApi.dll dynamically with LoadLibraryExW so that its absence
> > does not prevent qemu-ga from starting. Initialize DISM lazily once per
> > QGA process and open a separate online DISM session for each command
> > invocation, with process cleanup registered through ga_command_state_ad=
d.
> >
> > Normalize driver binary paths from the service database before reading
> > version resources, including SystemRoot, environment-variable, NT-prefi=
x,
> > and relative path forms.
> >
> > Link against version.dll (-lversion) for the GetFileVersionInfo and
> > VerQueryValue APIs.
> >
> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > Message-ID: <20260924154424.3786199-1-eashurov@redhat.com>
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 2bf5581aaa72..0dc94d808e35 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -28,6 +28,8 @@
> >  #include <wtsapi32.h>
> >  #include <wininet.h>
> >  #include <pdh.h>
> > +#include <dismapi.h>
> > +#include <winver.h>
> >
> >  #include "guest-agent-core.h"
> >  #include "vss-win32.h"
> > @@ -1981,12 +1983,15 @@ done:
> >      g_free(rawpasswddata);
> >  }
> >
> > +static void ga_cleanup_dism_api(void);
> > +
> >  /* register init/cleanup routines for stateful command groups */
> >  void ga_command_state_init(GAState *s, GACommandState *cs)
> >  {
> >      if (!vss_initialized()) {
> >          ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
> >      }
> > +    ga_command_state_add(cs, NULL, ga_cleanup_dism_api);
> >  }
> >
> >  /* MINGW is missing two fields: IncomingFrames & OutgoingFrames */
> > @@ -2455,6 +2460,684 @@ GuestDeviceInfoList *qmp_guest_get_devices(Erro=
r
> **errp)
> >      return head;
> >  }
> >
> > +static void error_setg_dism(Error **errp, HRESULT hr, const char *msg)
> > +{
> > +    if (HRESULT_FACILITY(hr) =3D=3D FACILITY_WIN32) {
> > +        error_setg_win32(errp, HRESULT_CODE(hr), "%s", msg);
> > +    } else {
> > +        error_setg(errp, "%s (HRESULT 0x%08" PRIx32 ")", msg,
> > +                   (uint32_t)hr);
> > +    }
> > +}
> > +
> > +static void ga_log_dism_error(HRESULT hr, const char *msg)
> > +{
> > +    Error *local_err =3D NULL;
> > +
> > +    error_setg_dism(&local_err, hr, msg);
> > +    slog("%s", error_get_pretty(local_err));
> > +    error_free(local_err);
> > +}
> > +
> > +typedef HRESULT WINAPI QGADismInitializeFunc(
> > +    DismLogLevel log_level, PCWSTR log_file_path, PCWSTR
> scratch_directory);
> > +typedef HRESULT WINAPI QGADismShutdownFunc(void);
> > +typedef HRESULT WINAPI QGADismOpenSessionFunc(
> > +    PCWSTR image_path, PCWSTR windows_directory, PCWSTR system_drive,
> > +    DismSession *session);
> > +typedef HRESULT WINAPI QGADismCloseSessionFunc(DismSession session);
> > +typedef HRESULT WINAPI QGADismGetDriversFunc(
> > +    DismSession session, WINBOOL all_drivers,
> > +    DismDriverPackage **driver_package, unsigned int *driver_count);
> > +typedef HRESULT WINAPI QGADismDeleteFunc(void *dism_structure);
> > +
> > +typedef struct QGADismApi {
> > +    HMODULE module;
> > +    QGADismInitializeFunc *initialize;
> > +    QGADismShutdownFunc *shutdown;
> > +    QGADismOpenSessionFunc *open_session;
> > +    QGADismCloseSessionFunc *close_session;
> > +    QGADismGetDriversFunc *get_drivers;
> > +    QGADismDeleteFunc *delete;
> > +} QGADismApi;
> > +
> > +static QGADismApi dism_api;
> > +static bool dism_initialized;
> > +
> > +static FARPROC ga_get_dism_function(HMODULE module, const char *name,
> > +                                    Error **errp)
> > +{
> > +    FARPROC function =3D GetProcAddress(module, name);
> > +
> > +    if (function =3D=3D NULL) {
> > +        error_setg_win32(errp, GetLastError(),
> > +                         "failed to resolve %s from DismApi.dll", name=
);
> > +    }
> > +    return function;
> > +}
> > +
> > +static void ga_unload_dism_api(QGADismApi *api)
> > +{
> > +    if (api->module !=3D NULL && !FreeLibrary(api->module)) {
> > +        slog("failed to unload DismApi.dll, error=3D%lu", GetLastError=
());
> > +    }
> > +    memset(api, 0, sizeof(*api));
> > +}
> > +
> > +/*
> > + * Load DISM from System32 and resolve its entry points at runtime, so=
 a
> > + * missing DismApi.dll prevents only this command rather than QGA
> startup.
> > + */
> > +static bool ga_load_dism_api(QGADismApi *api, Error **errp)
> > +{
> > +    api->module =3D LoadLibraryExW(L"DismApi.dll", NULL,
> > +                                 LOAD_LIBRARY_SEARCH_SYSTEM32);
> > +    if (api->module =3D=3D NULL) {
> > +        error_setg_win32(errp, GetLastError(),
> > +                         "failed to load DismApi.dll");
> > +        return false;
> > +    }
> > +
> > +    api->initialize =3D (QGADismInitializeFunc *)
> > +        ga_get_dism_function(api->module, "DismInitialize", errp);
> > +    if (api->initialize =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +    api->shutdown =3D (QGADismShutdownFunc *)
> > +        ga_get_dism_function(api->module, "DismShutdown", errp);
> > +    if (api->shutdown =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +    api->open_session =3D (QGADismOpenSessionFunc *)
> > +        ga_get_dism_function(api->module, "DismOpenSession", errp);
> > +    if (api->open_session =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +    api->close_session =3D (QGADismCloseSessionFunc *)
> > +        ga_get_dism_function(api->module, "DismCloseSession", errp);
> > +    if (api->close_session =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +    api->get_drivers =3D (QGADismGetDriversFunc *)
> > +        ga_get_dism_function(api->module, "DismGetDrivers", errp);
> > +    if (api->get_drivers =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +    api->delete =3D (QGADismDeleteFunc *)
> > +        ga_get_dism_function(api->module, "DismDelete", errp);
> > +    if (api->delete =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +
> > +    return true;
> > +
> > +fail:
> > +    ga_unload_dism_api(api);
> > +    return false;
> > +}
> > +
> > +static bool ga_ensure_dism_api(Error **errp)
> > +{
> > +    HRESULT hr;
> > +
> > +    if (dism_initialized) {
> > +        return true;
> > +    }
> > +
> > +    if (!ga_load_dism_api(&dism_api, errp)) {
> > +        return false;
> > +    }
> > +
> > +    hr =3D dism_api.initialize(DismLogErrors, NULL, NULL);
> > +    if (FAILED(hr)) {
> > +        error_setg_dism(errp, hr, "failed to initialize DISM");
> > +        ga_unload_dism_api(&dism_api);
> > +        return false;
> > +    }
> > +
> > +    dism_initialized =3D true;
> > +    return true;
> > +}
> > +
> > +static void ga_cleanup_dism_api(void)
> > +{
> > +    HRESULT hr;
> > +
> > +    if (dism_initialized) {
> > +        hr =3D dism_api.shutdown();
> > +        if (FAILED(hr)) {
> > +            ga_log_dism_error(hr, "failed to shut down DISM");
> > +        }
> > +        dism_initialized =3D false;
> > +    }
> > +
> > +    ga_unload_dism_api(&dism_api);
> > +}
> > +
> > +static char *ga_utf16_to_utf8_required(const WCHAR *str, const char
> *name,
> > +                                       Error **errp)
> > +{
> > +    g_autoptr(GError) gerr =3D NULL;
> > +    char *ret;
> > +
> > +    if (str =3D=3D NULL || str[0] =3D=3D L'\0') {
> > +        error_setg(errp, "driver %s is missing", name);
> > +        return NULL;
> > +    }
> > +
> > +    ret =3D g_utf16_to_utf8(str, -1, NULL, NULL, &gerr);
> > +    if (ret =3D=3D NULL) {
> > +        error_setg(errp, "failed to convert driver %s to UTF-8: %s",
> > +                   name, gerr->message);
> > +    }
> > +    return ret;
> > +}
> > +
> > +static const WCHAR *ga_windows_path_basename(const WCHAR *path)
> > +{
> > +    const WCHAR *name =3D path;
> > +
> > +    while (*path !=3D L'\0') {
> > +        if (*path =3D=3D L'\\' || *path =3D=3D L'/') {
> > +            name =3D path + 1;
> > +        }
> > +        path++;
> > +    }
> > +    return name;
> > +}
> > +
> > +static GuestDriverPackageList *ga_get_driver_packages(Error **errp)
> > +{
> > +    GuestDriverPackageList *head =3D NULL, **tail =3D &head;
> > +    DismSession session =3D DISM_SESSION_DEFAULT;
> > +    DismDriverPackage *drivers =3D NULL;
> > +    Error *local_err =3D NULL;
> > +    HRESULT hr;
> > +    UINT count =3D 0;
> > +    UINT i;
> > +
> > +    if (!ga_ensure_dism_api(&local_err)) {
> > +        goto out;
> > +    }
> > +
> > +    hr =3D dism_api.open_session(DISM_ONLINE_IMAGE, NULL, NULL, &sessi=
on);
> > +    if (FAILED(hr)) {
> > +        error_setg_dism(&local_err, hr,
> > +                        "failed to open online DISM session");
> > +        goto out;
> > +    }
> > +
> > +    /*
> > +     * FALSE retrieves only out-of-box drivers, meaning drivers that
> were
> > +     * not originally included in the Windows image. See:
> > +     *
> https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/di=
sm/dismgetdrivers-function
> > +     */
> > +    hr =3D dism_api.get_drivers(session, FALSE, &drivers, &count);
> > +    if (FAILED(hr)) {
> > +        error_setg_dism(&local_err, hr,
> > +                        "failed to enumerate driver packages");
> > +        goto out;
> > +    }
> > +
> > +    for (i =3D 0; i < count; i++) {
> > +        g_autoptr(GuestDriverPackage) package =3D NULL;
> > +
> > +        package =3D g_new0(GuestDriverPackage, 1);
> > +        package->name =3D
> ga_utf16_to_utf8_required(drivers[i].PublishedName,
> > +                                                  "package name",
> &local_err);
> > +        if (package->name =3D=3D NULL) {
> > +            goto out;
> > +        }
> > +
> > +        if (drivers[i].OriginalFileName !=3D NULL &&
> > +            drivers[i].OriginalFileName[0] !=3D L'\0') {
> > +            const WCHAR *original_name =3D ga_windows_path_basename(
> > +                drivers[i].OriginalFileName);
> > +
> > +            if (original_name[0] !=3D L'\0') {
> > +                package->original_name =3D g_utf16_to_utf8(
> > +                    original_name, -1, NULL, NULL, NULL);
> > +            }
> > +        }
> > +
> > +        package->version =3D g_strdup_printf("%u.%u.%u.%u",
> > +                                           drivers[i].MajorVersion,
> > +                                           drivers[i].MinorVersion,
> > +                                           drivers[i].Build,
> > +                                           drivers[i].Revision);
> > +
> > +        if (drivers[i].ProviderName !=3D NULL &&
> > +            drivers[i].ProviderName[0] !=3D L'\0') {
> > +            package->vendor =3D g_utf16_to_utf8(drivers[i].ProviderNam=
e,
> -1,
> > +                                              NULL, NULL, NULL);
> > +        }
> > +
> > +        QAPI_LIST_APPEND(tail, g_steal_pointer(&package));
> > +    }
> > +
> > +out:
> > +    if (drivers !=3D NULL) {
> > +        hr =3D dism_api.delete(drivers);
> > +        if (FAILED(hr)) {
> > +            if (local_err =3D=3D NULL) {
> > +                error_setg_dism(&local_err, hr,
> > +                                "failed to release driver package
> data");
> > +            } else {
> > +                ga_log_dism_error(hr,
> > +                                  "failed to release driver package
> data");
> > +            }
> > +        }
> > +    }
> > +    if (session !=3D DISM_SESSION_DEFAULT) {
> > +        hr =3D dism_api.close_session(session);
> > +        if (FAILED(hr)) {
> > +            if (local_err =3D=3D NULL) {
> > +                error_setg_dism(&local_err, hr,
> > +                                "failed to close online DISM session")=
;
> > +            } else {
> > +                ga_log_dism_error(hr,
> > +                                  "failed to close online DISM
> session");
> > +            }
> > +        }
> > +    }
> > +    if (local_err !=3D NULL) {
> > +        qapi_free_GuestDriverPackageList(head);
> > +        head =3D NULL;
> > +        error_propagate(errp, local_err);
> > +    }
> > +    return head;
> > +}
> > +
> > +static bool ga_driver_service_status(DWORD state,
> > +                                     GuestDriverServiceStatus *status)
> > +{
> > +    switch (state) {
> > +    case SERVICE_STOPPED:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_STOPPED;
> > +        return true;
> > +    case SERVICE_START_PENDING:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_START_PENDING;
> > +        return true;
> > +    case SERVICE_STOP_PENDING:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_STOP_PENDING;
> > +        return true;
> > +    case SERVICE_RUNNING:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_RUNNING;
> > +        return true;
> > +    case SERVICE_CONTINUE_PENDING:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_CONTINUE_PENDING;
> > +        return true;
> > +    case SERVICE_PAUSE_PENDING:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_PAUSE_PENDING;
> > +        return true;
> > +    case SERVICE_PAUSED:
> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_PAUSED;
> > +        return true;
> > +    default:
> > +        return false;
> > +    }
> > +}
> > +
> > +/* Convert an SCM driver path into a path usable by Win32 file APIs. *=
/
> > +static WCHAR *ga_resolve_driver_path(const WCHAR *path)
> > +{
> > +    WCHAR windows_dir[MAX_PATH + 1];
> > +    g_autofree WCHAR *trimmed =3D NULL;
> > +    g_autofree WCHAR *expanded =3D NULL;
> > +    const WCHAR *start =3D path;
> > +    const WCHAR *end;
> > +    const WCHAR *remainder =3D NULL;
> > +    size_t prefix_len;
> > +    size_t path_len;
> > +    size_t windows_len;
> > +    DWORD expanded_len;
> > +    UINT windows_dir_len;
> > +
> > +    while (*start !=3D L'\0' && iswspace(*start)) {
> > +        start++;
> > +    }
> > +    end =3D start + wcslen(start);
> > +    while (end > start && iswspace(end[-1])) {
> > +        end--;
> > +    }
> > +    if (end - start >=3D 2 && start[0] =3D=3D L'"' && end[-1] =3D=3D L=
'"') {
> > +        start++;
> > +        end--;
> > +    }
> > +    if (end =3D=3D start) {
> > +        return NULL;
> > +    }
> > +
> > +    path_len =3D end - start;
> > +    trimmed =3D g_new(WCHAR, path_len + 1);
> > +    memcpy(trimmed, start, path_len * sizeof(WCHAR));
> > +    trimmed[path_len] =3D L'\0';
> > +
> > +    expanded_len =3D ExpandEnvironmentStringsW(trimmed, NULL, 0);
> > +    if (expanded_len =3D=3D 0) {
> > +        return NULL;
> > +    }
> > +    expanded =3D g_new(WCHAR, expanded_len);
> > +    path_len =3D ExpandEnvironmentStringsW(trimmed, expanded,
> expanded_len);
> > +    if (path_len =3D=3D 0 || path_len > expanded_len) {
> > +        return NULL;
> > +    }
> > +
> > +    prefix_len =3D wcslen(L"\\SystemRoot");
> > +    if (_wcsnicmp(expanded, L"\\SystemRoot", prefix_len) =3D=3D 0 &&
> > +        (expanded[prefix_len] =3D=3D L'\0' ||
> > +         expanded[prefix_len] =3D=3D L'\\' ||
> > +         expanded[prefix_len] =3D=3D L'/')) {
> > +        remainder =3D expanded + prefix_len;
> > +    } else {
> > +        prefix_len =3D wcslen(L"SystemRoot");
> > +        if (_wcsnicmp(expanded, L"SystemRoot", prefix_len) =3D=3D 0 &&
> > +            (expanded[prefix_len] =3D=3D L'\0' ||
> > +             expanded[prefix_len] =3D=3D L'\\' ||
> > +             expanded[prefix_len] =3D=3D L'/')) {
> > +            remainder =3D expanded + prefix_len;
> > +        }
> > +    }
> > +
> > +    windows_dir_len =3D GetWindowsDirectoryW(windows_dir,
> > +                                            ARRAY_SIZE(windows_dir));
> > +    if (windows_dir_len =3D=3D 0 || windows_dir_len >=3D
> ARRAY_SIZE(windows_dir)) {
> > +        return NULL;
> > +    }
> > +    windows_len =3D windows_dir_len;
> > +
> > +    if (remainder !=3D NULL) {
> > +        WCHAR *ret =3D g_new(WCHAR, windows_len + wcslen(remainder) + =
1);
> > +
> > +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
> > +        wcscpy(ret + windows_len, remainder);
> > +        return ret;
> > +    }
> > +
> > +    if (wcsncmp(expanded, L"\\??\\", 4) =3D=3D 0) {
> > +        return g_memdup2(expanded + 4,
> > +                         (wcslen(expanded + 4) + 1) * sizeof(WCHAR));
> > +    }
> > +
> > +    if ((iswalpha(expanded[0]) && expanded[1] =3D=3D L':') ||
> > +        expanded[0] =3D=3D L'\\') {
> > +        return g_steal_pointer(&expanded);
> > +    }
> > +
> > +    path_len =3D wcslen(expanded);
> > +    start =3D expanded;
> > +    while (*start =3D=3D L'\\' || *start =3D=3D L'/') {
> > +        start++;
> > +        path_len--;
> > +    }
> > +    {
> > +        WCHAR *ret =3D g_new(WCHAR, windows_len + path_len + 2);
> > +
> > +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
> > +        ret[windows_len] =3D L'\\';
> > +        wcscpy(ret + windows_len + 1, start);
> > +        return ret;
> > +    }
> > +}
> > +
> > +typedef struct QGAVersionTranslation {
> > +    WORD language;
> > +    WORD code_page;
> > +} QGAVersionTranslation;
> > +
> > +/* Return CompanyName from a localized file-version string table. */
> > +static char *ga_get_file_vendor(const void *version_info)
> > +{
> > +    QGAVersionTranslation *translations =3D NULL;
> > +    static const QGAVersionTranslation fallback =3D { 0x0409, 0x04b0 }=
;
> > +    UINT translations_len =3D 0;
> > +    UINT count =3D 0;
> > +    UINT i;
> > +
> > +    if (VerQueryValueW(version_info, L"\\VarFileInfo\\Translation",
> > +                       (void **)&translations, &translations_len) &&
> > +        translations !=3D NULL) {
> > +        count =3D translations_len / sizeof(*translations);
> > +    }
> > +
> > +    for (i =3D 0; i <=3D count; i++) {
> > +        const QGAVersionTranslation *translation;
> > +        WCHAR query[64];
> > +        WCHAR *company =3D NULL;
> > +        UINT company_len =3D 0;
> > +        char *vendor;
> > +
> > +        translation =3D i < count ? &translations[i] : &fallback;
> > +        swprintf(query, ARRAY_SIZE(query),
> > +                 L"\\StringFileInfo\\%04x%04x\\CompanyName",
> > +                 translation->language, translation->code_page);
> > +        if (!VerQueryValueW(version_info, query, (void **)&company,
> > +                            &company_len) || company_len <=3D 1) {
> > +            continue;
> > +        }
> > +        vendor =3D g_utf16_to_utf8(company, -1, NULL, NULL, NULL);
> > +        if (vendor !=3D NULL && vendor[0] !=3D '\0') {
> > +            return vendor;
> > +        }
> > +        g_free(vendor);
> > +    }
> > +    return NULL;
> > +}
> > +
> > +/* Add optional FileVersion and CompanyName data from a driver binary.
> */
> > +static bool ga_get_driver_file_metadata(const WCHAR *path,
> > +                                        GuestDriverService *service,
> > +                                        Error **errp)
> > +{
> > +    g_autofree void *version_info =3D NULL;
> > +    VS_FIXEDFILEINFO *fixed_info =3D NULL;
> > +    PVOID old_redirection =3D NULL;
> > +    DWORD ignored;
> > +    DWORD version_size;
> > +    UINT fixed_info_len;
> > +    bool redirection_disabled;
> > +    bool version_loaded =3D false;
> > +
> > +    redirection_disabled =3D
> > +        Wow64DisableWow64FsRedirection(&old_redirection);
> > +
> > +    version_size =3D GetFileVersionInfoSizeW(path, &ignored);
> > +    if (version_size !=3D 0) {
> > +        version_info =3D g_malloc(version_size);
> > +        version_loaded =3D GetFileVersionInfoW(path, 0, version_size,
> > +                                             version_info);
> > +    }
> > +
> > +    if (redirection_disabled &&
> > +        !Wow64RevertWow64FsRedirection(old_redirection)) {
> > +        error_setg_win32(errp, GetLastError(),
> > +                         "failed to restore WOW64 filesystem
> redirection "
> > +                         "for driver service '%s'", service->name);
> > +        return false;
> > +    }
> > +
> > +    if (!version_loaded) {
> > +        return true;
> > +    }
> > +
> > +    if (VerQueryValueW(version_info, L"\\", (void **)&fixed_info,
> > +                       &fixed_info_len) &&
> > +        fixed_info_len >=3D sizeof(*fixed_info) &&
> > +        fixed_info->dwSignature =3D=3D VS_FFI_SIGNATURE) {
> > +        service->version =3D g_strdup_printf(
> > +            "%u.%u.%u.%u",
> > +            HIWORD(fixed_info->dwFileVersionMS),
> > +            LOWORD(fixed_info->dwFileVersionMS),
> > +            HIWORD(fixed_info->dwFileVersionLS),
> > +            LOWORD(fixed_info->dwFileVersionLS));
> > +    }
> > +
> > +    service->vendor =3D ga_get_file_vendor(version_info);
> > +    return true;
> > +}
> > +
> > +/*
> > + * Add optional configuration and binary metadata for one driver
> service.
> > + * Ordinary per-service lookup failures leave optional fields unset.
> > + */
> > +static bool ga_get_driver_service_config(SC_HANDLE manager,
> > +                                         const WCHAR *name,
> > +                                         GuestDriverService *service,
> > +                                         Error **errp)
> > +{
> > +    SC_HANDLE handle;
> > +    g_autofree QUERY_SERVICE_CONFIGW *config =3D NULL;
> > +    g_autofree WCHAR *resolved_path =3D NULL;
> > +    DWORD size =3D 0;
> > +    DWORD err;
> > +    bool success =3D true;
> > +
> > +    handle =3D OpenServiceW(manager, name, SERVICE_QUERY_CONFIG);
> > +    if (handle =3D=3D NULL) {
> > +        slog("failed to open configuration for driver service '%s', "
> > +             "error=3D%lu", service->name, GetLastError());
> > +        return true;
> > +    }
> > +
> > +    QueryServiceConfigW(handle, NULL, 0, &size);
> > +    err =3D GetLastError();
> > +    if (err !=3D ERROR_INSUFFICIENT_BUFFER) {
> > +        slog("failed to get configuration size for driver service '%s'=
,
> "
> > +             "error=3D%lu", service->name, err);
> > +        goto out;
> > +    }
> > +
> > +    config =3D g_malloc(size);
> > +    if (!QueryServiceConfigW(handle, config, size, &size)) {
> > +        slog("failed to get configuration for driver service '%s', "
> > +             "error=3D%lu", service->name, GetLastError());
> > +        goto out;
> > +    }
> > +
> > +    if (config->lpBinaryPathName =3D=3D NULL ||
> > +        config->lpBinaryPathName[0] =3D=3D L'\0') {
> > +        goto out;
> > +    }
> > +
> > +    service->driver_path =3D g_utf16_to_utf8(config->lpBinaryPathName,=
 -1,
> > +                                           NULL, NULL, NULL);
> > +
> > +    resolved_path =3D ga_resolve_driver_path(config->lpBinaryPathName)=
;
> > +    if (resolved_path !=3D NULL &&
> > +        !ga_get_driver_file_metadata(resolved_path, service, errp)) {
> > +        success =3D false;
> > +    }
> > +
> > +out:
> > +    CloseServiceHandle(handle);
> > +    return success;
> > +}
> > +
> > +static GuestDriverServiceList *ga_get_driver_services(Error **errp)
> > +{
> > +    GuestDriverServiceList *head =3D NULL, **tail =3D &head;
> > +    g_autofree BYTE *buffer =3D NULL;
> > +    SC_HANDLE manager =3D NULL;
> > +    DWORD buffer_size =3D 256 * 1024;
> > +    DWORD bytes_needed;
> > +    DWORD services_returned;
> > +    DWORD resume =3D 0;
> > +    DWORD err;
> > +    bool complete;
> > +    bool success =3D false;
> > +
> > +    manager =3D OpenSCManagerW(NULL, NULL, SC_MANAGER_ENUMERATE_SERVIC=
E);
> > +    if (manager =3D=3D NULL) {
> > +        error_setg_win32(errp, GetLastError(),
> > +                         "failed to open service control manager");
> > +        goto out;
> > +    }
> > +
> > +    buffer =3D g_malloc(buffer_size);
> > +    do {
> > +        ENUM_SERVICE_STATUS_PROCESSW *services;
> > +        DWORD i;
> > +
> > +        bytes_needed =3D 0;
> > +        services_returned =3D 0;
> > +        complete =3D EnumServicesStatusExW(manager, SC_ENUM_PROCESS_IN=
FO,
> > +                                         SERVICE_DRIVER,
> SERVICE_STATE_ALL,
> > +                                         buffer, buffer_size,
> &bytes_needed,
> > +                                         &services_returned, &resume,
> NULL);
> > +        if (!complete) {
> > +            err =3D GetLastError();
> > +            if (err !=3D ERROR_MORE_DATA) {
> > +                error_setg_win32(errp, err,
> > +                                 "failed to enumerate driver services"=
);
> > +                goto out;
> > +            }
> > +            if (services_returned =3D=3D 0) {
> > +                error_setg(errp, "driver service enumeration made no "
> > +                           "progress (buffer needs %lu bytes)",
> bytes_needed);
> > +                goto out;
> > +            }
> > +        }
> > +
> > +        services =3D (ENUM_SERVICE_STATUS_PROCESSW *)buffer;
> > +        for (i =3D 0; i < services_returned; i++) {
> > +            g_autoptr(GuestDriverService) service =3D NULL;
> > +
> > +            service =3D g_new0(GuestDriverService, 1);
> > +            service->name =3D ga_utf16_to_utf8_required(
> > +                services[i].lpServiceName, "service name", errp);
> > +            if (service->name =3D=3D NULL) {
> > +                goto out;
> > +            }
> > +            if (!ga_driver_service_status(
> > +                    services[i].ServiceStatusProcess.dwCurrentState,
> > +                    &service->status)) {
> > +                error_setg(errp, "driver service '%s' has unknown stat=
e
> %lu",
> > +                           service->name,
> > +
>  services[i].ServiceStatusProcess.dwCurrentState);
> > +                goto out;
> > +            }
>
> An unknown dwCurrentState aborts the entire service enumeration. The stat=
es
> listed in GuestDriverServiceStatus cover all documented SCM values today,
> but a
> future Windows version could add new states.
>
> Consider skipping the service with a slog warning instead, or adding an
> "unknown" enum value to GuestDriverServiceStatus.
>
> > +
> > +            if (!ga_get_driver_service_config(manager,
> > +                                              services[i].lpServiceNam=
e,
> > +                                              service, errp)) {
> > +                goto out;
> > +            }
> > +            QAPI_LIST_APPEND(tail, g_steal_pointer(&service));
> > +        }
> > +    } while (!complete);
> > +    success =3D true;
> > +
> > +out:
> > +    if (manager !=3D NULL) {
> > +        CloseServiceHandle(manager);
> > +    }
> > +    if (!success) {
> > +        qapi_free_GuestDriverServiceList(head);
> > +        head =3D NULL;
> > +    }
> > +    return head;
> > +}
> > +
> > +GuestDriverInfo *qmp_guest_get_drivers(Error **errp)
> > +{
> > +    g_autoptr(GuestDriverInfo) info =3D g_new0(GuestDriverInfo, 1);
> > +    Error *local_err =3D NULL;
> > +
> > +    info->packages =3D ga_get_driver_packages(&local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return NULL;
> > +    }
>
> If DismApi.dll is missing or DismInitialize fails, it returns an error,
> even if
> listing services could work. That's probably ok, but worth noting.
>

what if we add an "error" field to the package structure, then we can
return services and package with an error about DismInitialize


>
> > +
> > +    info->services =3D ga_get_driver_services(&local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return NULL;
> > +    }
> > +
> > +    return g_steal_pointer(&info);
> > +}
> > +
> >  char *qga_get_host_name(Error **errp)
> >  {
> >      wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
> > diff --git a/qga/meson.build b/qga/meson.build
> > index cfa2157efb23..15860d938d4b 100644
> > --- a/qga/meson.build
> > +++ b/qga/meson.build
> > @@ -94,8 +94,9 @@ qga_ss =3D qga_ss.apply({})
> >  gen_tlb =3D []
> >  qga_libs =3D []
> >  if host_os =3D=3D 'windows'
> > -  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
> '-lwininet', '-liphlpapi', '-lnetapi32',
> > -               '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
> > +  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
> > +               '-lwininet', '-liphlpapi', '-lnetapi32', '-lsetupapi',
> > +               '-lcfgmgr32', '-luserenv', '-lpdh', '-lversion' ]
> >    if have_qga_vss
> >      qga_libs +=3D ['-lole32', '-loleaut32', '-lshlwapi',
> '-Wl,--enable-stdcall-fixup']
> >      subdir('vss-win32')
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 8cd0ba048b8d..b20cf7135a4c 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1590,6 +1590,95 @@
> >    'returns': ['GuestDeviceInfo'],
> >    'if': 'CONFIG_WIN32' }
> >
> > +##
> > +# @GuestDriverServiceStatus:
> > +#
> > +# @stopped: the service is stopped
> > +#
> > +# @start-pending: the service is starting
> > +#
> > +# @stop-pending: the service is stopping
> > +#
> > +# @running: the service is running
> > +#
> > +# @continue-pending: the service is resuming
> > +#
> > +# @pause-pending: the service is pausing
> > +#
> > +# @paused: the service is paused
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'enum': 'GuestDriverServiceStatus',
> > +  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
> > +            'continue-pending', 'pause-pending', 'paused' ],
> > +  'if': 'CONFIG_WIN32' }
> > +
> > +##
> > +# @GuestDriverPackage:
> > +#
> > +# An out-of-box driver package installed in the guest.
> > +#
> > +# @name: published INF name
> > +#
> > +# @original-name: base name of the original INF file
> > +#
> > +# @version: four-part version from the package INF DriverVer entry
> > +#
> > +# @vendor: package provider from the INF metadata
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'struct': 'GuestDriverPackage',
> > +  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
> > +            '*vendor': 'str' },
> > +  'if': 'CONFIG_WIN32' }
> > +
> > +##
> > +# @GuestDriverService:
> > +#
> > +# @name: service name
> > +#
> > +# @driver-path: driver binary path configured in the service database
> > +#
> > +# @version: four-part FileVersion from the driver binary
> > +#
> > +# @vendor: CompanyName from the driver binary
> > +#
> > +# @status: current service status
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'struct': 'GuestDriverService',
> > +  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
> > +            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
> > +  'if': 'CONFIG_WIN32' }
> > +
> > +##
> > +# @GuestDriverInfo:
> > +#
> > +# @packages: out-of-box driver packages installed in the guest
> > +#
> > +# @services: registered driver services
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'struct': 'GuestDriverInfo',
> > +  'data': { 'packages': ['GuestDriverPackage'],
> > +            'services': ['GuestDriverService'] },
> > +  'if': 'CONFIG_WIN32' }
> > +
> > +##
> > +# @guest-get-drivers:
> > +#
> > +# Retrieve information about Windows driver packages and services.
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'command': 'guest-get-drivers',
> > +  'returns': 'GuestDriverInfo',
> > +  'if': 'CONFIG_WIN32' }
> > +
> >  ##
> >  # @GuestAuthorizedKeys:
> >  #
>
> otherwise, lgtm
>
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>

--00000000000020ac32065c492eff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><br></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Sep 24, 2026 at 10:41=E2=80=AFPM &lt;<a href=3D"mai=
lto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Add a new =
guest-get-drivers command that reports two independent lists<br>
&gt; of Windows driver information:<br>
&gt; <br>
&gt;=C2=A0 - packages: out-of-box driver packages enumerated with the DISM =
API<br>
&gt;=C2=A0 =C2=A0 (DismGetDrivers). Each entry includes the published INF n=
ame,<br>
&gt;=C2=A0 =C2=A0 original INF name, version, and provider.<br>
&gt;=C2=A0 - services: registered driver services enumerated with the Servi=
ce<br>
&gt;=C2=A0 =C2=A0 Control Manager (EnumServicesStatusExW). Each entry inclu=
des the<br>
&gt;=C2=A0 =C2=A0 service name, configured binary path, current SCM status,=
 and<br>
&gt;=C2=A0 =C2=A0 FileVersion and CompanyName metadata from the driver bina=
ry.<br>
&gt; <br>
&gt; Load DismApi.dll dynamically with LoadLibraryExW so that its absence<b=
r>
&gt; does not prevent qemu-ga from starting. Initialize DISM lazily once pe=
r<br>
&gt; QGA process and open a separate online DISM session for each command<b=
r>
&gt; invocation, with process cleanup registered through ga_command_state_a=
dd.<br>
&gt; <br>
&gt; Normalize driver binary paths from the service database before reading=
<br>
&gt; version resources, including SystemRoot, environment-variable, NT-pref=
ix,<br>
&gt; and relative path forms.<br>
&gt; <br>
&gt; Link against version.dll (-lversion) for the GetFileVersionInfo and<br=
>
&gt; VerQueryValue APIs.<br>
&gt; <br>
&gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; Message-ID: &lt;<a href=3D"mailto:20260924154424.3786199-1-eashurov@re=
dhat.com" target=3D"_blank">20260924154424.3786199-1-eashurov@redhat.com</a=
>&gt;<br>
&gt;<br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 2bf5581aaa72..0dc94d808e35 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -28,6 +28,8 @@<br>
&gt;=C2=A0 #include &lt;wtsapi32.h&gt;<br>
&gt;=C2=A0 #include &lt;wininet.h&gt;<br>
&gt;=C2=A0 #include &lt;pdh.h&gt;<br>
&gt; +#include &lt;dismapi.h&gt;<br>
&gt; +#include &lt;winver.h&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;guest-agent-core.h&quot;<br>
&gt;=C2=A0 #include &quot;vss-win32.h&quot;<br>
&gt; @@ -1981,12 +1983,15 @@ done:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(rawpasswddata);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void ga_cleanup_dism_api(void);<br>
&gt; +<br>
&gt;=C2=A0 /* register init/cleanup routines for stateful command groups */=
<br>
&gt;=C2=A0 void ga_command_state_init(GAState *s, GACommandState *cs)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!vss_initialized()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_command_state_add(cs, NULL, guest=
_fsfreeze_cleanup);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ga_command_state_add(cs, NULL, ga_cleanup_dism_api);<br=
>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* MINGW is missing two fields: IncomingFrames &amp; OutgoingFra=
mes */<br>
&gt; @@ -2455,6 +2460,684 @@ GuestDeviceInfoList *qmp_guest_get_devices(Err=
or **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return head;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void error_setg_dism(Error **errp, HRESULT hr, const char *msg=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (HRESULT_FACILITY(hr) =3D=3D FACILITY_WIN32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, HRESULT_CODE(hr), =
&quot;%s&quot;, msg);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s (HRESULT 0x%08&=
quot; PRIx32 &quot;)&quot;, msg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(uint32_t)hr);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ga_log_dism_error(HRESULT hr, const char *msg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 error_setg_dism(&amp;local_err, hr, msg);<br>
&gt; +=C2=A0 =C2=A0 slog(&quot;%s&quot;, error_get_pretty(local_err));<br>
&gt; +=C2=A0 =C2=A0 error_free(local_err);<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef HRESULT WINAPI QGADismInitializeFunc(<br>
&gt; +=C2=A0 =C2=A0 DismLogLevel log_level, PCWSTR log_file_path, PCWSTR sc=
ratch_directory);<br>
&gt; +typedef HRESULT WINAPI QGADismShutdownFunc(void);<br>
&gt; +typedef HRESULT WINAPI QGADismOpenSessionFunc(<br>
&gt; +=C2=A0 =C2=A0 PCWSTR image_path, PCWSTR windows_directory, PCWSTR sys=
tem_drive,<br>
&gt; +=C2=A0 =C2=A0 DismSession *session);<br>
&gt; +typedef HRESULT WINAPI QGADismCloseSessionFunc(DismSession session);<=
br>
&gt; +typedef HRESULT WINAPI QGADismGetDriversFunc(<br>
&gt; +=C2=A0 =C2=A0 DismSession session, WINBOOL all_drivers,<br>
&gt; +=C2=A0 =C2=A0 DismDriverPackage **driver_package, unsigned int *drive=
r_count);<br>
&gt; +typedef HRESULT WINAPI QGADismDeleteFunc(void *dism_structure);<br>
&gt; +<br>
&gt; +typedef struct QGADismApi {<br>
&gt; +=C2=A0 =C2=A0 HMODULE module;<br>
&gt; +=C2=A0 =C2=A0 QGADismInitializeFunc *initialize;<br>
&gt; +=C2=A0 =C2=A0 QGADismShutdownFunc *shutdown;<br>
&gt; +=C2=A0 =C2=A0 QGADismOpenSessionFunc *open_session;<br>
&gt; +=C2=A0 =C2=A0 QGADismCloseSessionFunc *close_session;<br>
&gt; +=C2=A0 =C2=A0 QGADismGetDriversFunc *get_drivers;<br>
&gt; +=C2=A0 =C2=A0 QGADismDeleteFunc *delete;<br>
&gt; +} QGADismApi;<br>
&gt; +<br>
&gt; +static QGADismApi dism_api;<br>
&gt; +static bool dism_initialized;<br>
&gt; +<br>
&gt; +static FARPROC ga_get_dism_function(HMODULE module, const char *name,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 FARPROC function =3D GetProcAddress(module, name);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (function =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;failed to resolve %s from DismApi.dll&quot;, nam=
e);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return function;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ga_unload_dism_api(QGADismApi *api)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;module !=3D NULL &amp;&amp; !FreeLibrary(ap=
i-&gt;module)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to unload DismApi.dll, =
error=3D%lu&quot;, GetLastError());<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 memset(api, 0, sizeof(*api));<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Load DISM from System32 and resolve its entry points at runtime, s=
o a<br>
&gt; + * missing DismApi.dll prevents only this command rather than QGA sta=
rtup.<br>
&gt; + */<br>
&gt; +static bool ga_load_dism_api(QGADismApi *api, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 api-&gt;module =3D LoadLibraryExW(L&quot;DismApi.dll&qu=
ot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOAD_LIBRARY_SEARCH_SYSTEM=
32);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;module =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;failed to load DismApi.dll&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 api-&gt;initialize =3D (QGADismInitializeFunc *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismInitialize&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;initialize =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 api-&gt;shutdown =3D (QGADismShutdownFunc *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismShutdown&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;shutdown =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 api-&gt;open_session =3D (QGADismOpenSessionFunc *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismOpenSession&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;open_session =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 api-&gt;close_session =3D (QGADismCloseSessionFunc *)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismCloseSession&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;close_session =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 api-&gt;get_drivers =3D (QGADismGetDriversFunc *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismGetDrivers&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;get_drivers =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 api-&gt;delete =3D (QGADismDeleteFunc *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_get_dism_function(api-&gt;module, &quo=
t;DismDelete&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 if (api-&gt;delete =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 ga_unload_dism_api(api);<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ga_ensure_dism_api(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dism_initialized) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ga_load_dism_api(&amp;dism_api, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hr =3D dism_api.initialize(DismLogErrors, NULL, NULL);<=
br>
&gt; +=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_dism(errp, hr, &quot;failed to=
 initialize DISM&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_unload_dism_api(&amp;dism_api);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dism_initialized =3D true;<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ga_cleanup_dism_api(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dism_initialized) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D dism_api.shutdown();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_log_dism_error(hr, &quot=
;failed to shut down DISM&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dism_initialized =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ga_unload_dism_api(&amp;dism_api);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static char *ga_utf16_to_utf8_required(const WCHAR *str, const char *=
name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error=
 **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GError) gerr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 char *ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (str =3D=3D NULL || str[0] =3D=3D L&#39;\0&#39;) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;driver %s is missi=
ng&quot;, name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D g_utf16_to_utf8(str, -1, NULL, NULL, &amp;gerr)=
;<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to convert =
driver %s to UTF-8: %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
name, gerr-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const WCHAR *ga_windows_path_basename(const WCHAR *path)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const WCHAR *name =3D path;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (*path !=3D L&#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*path =3D=3D L&#39;\\&#39; || *path =
=3D=3D L&#39;/&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D path + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 path++;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return name;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static GuestDriverPackageList *ga_get_driver_packages(Error **errp)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GuestDriverPackageList *head =3D NULL, **tail =3D &amp;=
head;<br>
&gt; +=C2=A0 =C2=A0 DismSession session =3D DISM_SESSION_DEFAULT;<br>
&gt; +=C2=A0 =C2=A0 DismDriverPackage *drivers =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr;<br>
&gt; +=C2=A0 =C2=A0 UINT count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 UINT i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ga_ensure_dism_api(&amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hr =3D dism_api.open_session(DISM_ONLINE_IMAGE, NULL, N=
ULL, &amp;session);<br>
&gt; +=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_dism(&amp;local_err, hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;failed to open online DISM session&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* FALSE retrieves only out-of-box drivers, meanin=
g drivers that were<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* not originally included in the Windows image. S=
ee:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* <a href=3D"https://learn.microsoft.com/en-us/wi=
ndows-hardware/manufacture/desktop/dism/dismgetdrivers-function" rel=3D"nor=
eferrer" target=3D"_blank">https://learn.microsoft.com/en-us/windows-hardwa=
re/manufacture/desktop/dism/dismgetdrivers-function</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 hr =3D dism_api.get_drivers(session, FALSE, &amp;driver=
s, &amp;count);<br>
&gt; +=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_dism(&amp;local_err, hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;failed to enumerate driver packages&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autoptr(GuestDriverPackage) package =3D=
 NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 package =3D g_new0(GuestDriverPackage, 1)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 package-&gt;name =3D ga_utf16_to_utf8_req=
uired(drivers[i].PublishedName,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;package name&quot;, &amp;local_err);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (package-&gt;name =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drivers[i].OriginalFileName !=3D NULL=
 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drivers[i].OriginalFileName=
[0] !=3D L&#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const WCHAR *original_name =
=3D ga_windows_path_basename(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drivers[i].Or=
iginalFileName);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (original_name[0] !=3D L=
&#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 package-&gt;o=
riginal_name =3D g_utf16_to_utf8(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 original_name, -1, NULL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 package-&gt;version =3D g_strdup_printf(&=
quot;%u.%u.%u.%u&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drivers[i].MajorVersion,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drivers[i].MinorVersion,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drivers[i].Build,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0drivers[i].Revision);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drivers[i].ProviderName !=3D NULL &am=
p;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drivers[i].ProviderName[0] =
!=3D L&#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 package-&gt;vendor =3D g_ut=
f16_to_utf8(drivers[i].ProviderName, -1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, g_steal_pointer(&a=
mp;package));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (drivers !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D dism_api.delete(drivers);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err =3D=3D NULL) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_di=
sm(&amp;local_err, hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to release driver p=
ackage data&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_log_dism_e=
rror(hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to release d=
river package data&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (session !=3D DISM_SESSION_DEFAULT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D dism_api.close_session(session);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err =3D=3D NULL) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_di=
sm(&amp;local_err, hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to close online DIS=
M session&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_log_dism_e=
rror(hr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to close onl=
ine DISM session&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDriverPackageList(head);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ga_driver_service_status(DWORD state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GuestDriverS=
erviceStatus *status)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (state) {<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_STOPPED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_S=
TOPPED;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_START_PENDING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_S=
TART_PENDING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_STOP_PENDING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_S=
TOP_PENDING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_RUNNING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_R=
UNNING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_CONTINUE_PENDING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_C=
ONTINUE_PENDING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_PAUSE_PENDING:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_P=
AUSE_PENDING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 case SERVICE_PAUSED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D GUEST_DRIVER_SERVICE_STATUS_P=
AUSED;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Convert an SCM driver path into a path usable by Win32 file APIs. =
*/<br>
&gt; +static WCHAR *ga_resolve_driver_path(const WCHAR *path)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 WCHAR windows_dir[MAX_PATH + 1];<br>
&gt; +=C2=A0 =C2=A0 g_autofree WCHAR *trimmed =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree WCHAR *expanded =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const WCHAR *start =3D path;<br>
&gt; +=C2=A0 =C2=A0 const WCHAR *end;<br>
&gt; +=C2=A0 =C2=A0 const WCHAR *remainder =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 size_t prefix_len;<br>
&gt; +=C2=A0 =C2=A0 size_t path_len;<br>
&gt; +=C2=A0 =C2=A0 size_t windows_len;<br>
&gt; +=C2=A0 =C2=A0 DWORD expanded_len;<br>
&gt; +=C2=A0 =C2=A0 UINT windows_dir_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (*start !=3D L&#39;\0&#39; &amp;&amp; iswspace(*s=
tart)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 start++;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 end =3D start + wcslen(start);<br>
&gt; +=C2=A0 =C2=A0 while (end &gt; start &amp;&amp; iswspace(end[-1])) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 end--;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (end - start &gt;=3D 2 &amp;&amp; start[0] =3D=3D L&=
#39;&quot;&#39; &amp;&amp; end[-1] =3D=3D L&#39;&quot;&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 start++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 end--;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (end =3D=3D start) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 path_len =3D end - start;<br>
&gt; +=C2=A0 =C2=A0 trimmed =3D g_new(WCHAR, path_len + 1);<br>
&gt; +=C2=A0 =C2=A0 memcpy(trimmed, start, path_len * sizeof(WCHAR));<br>
&gt; +=C2=A0 =C2=A0 trimmed[path_len] =3D L&#39;\0&#39;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 expanded_len =3D ExpandEnvironmentStringsW(trimmed, NUL=
L, 0);<br>
&gt; +=C2=A0 =C2=A0 if (expanded_len =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 expanded =3D g_new(WCHAR, expanded_len);<br>
&gt; +=C2=A0 =C2=A0 path_len =3D ExpandEnvironmentStringsW(trimmed, expande=
d, expanded_len);<br>
&gt; +=C2=A0 =C2=A0 if (path_len =3D=3D 0 || path_len &gt; expanded_len) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 prefix_len =3D wcslen(L&quot;\\SystemRoot&quot;);<br>
&gt; +=C2=A0 =C2=A0 if (_wcsnicmp(expanded, L&quot;\\SystemRoot&quot;, pref=
ix_len) =3D=3D 0 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (expanded[prefix_len] =3D=3D L&#39;\0&#39=
; ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expanded[prefix_len] =3D=3D L&#39;\=
\&#39; ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expanded[prefix_len] =3D=3D L&#39;/=
&#39;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 remainder =3D expanded + prefix_len;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix_len =3D wcslen(L&quot;SystemRoot&q=
uot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (_wcsnicmp(expanded, L&quot;SystemRoot=
&quot;, prefix_len) =3D=3D 0 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (expanded[prefix_len] =3D=
=3D L&#39;\0&#39; ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expanded[prefix_len] =
=3D=3D L&#39;\\&#39; ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expanded[prefix_len] =
=3D=3D L&#39;/&#39;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remainder =3D expanded + pr=
efix_len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 windows_dir_len =3D GetWindowsDirectoryW(windows_dir,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ARRAY_SIZE(windows_dir));<br>
&gt; +=C2=A0 =C2=A0 if (windows_dir_len =3D=3D 0 || windows_dir_len &gt;=3D=
 ARRAY_SIZE(windows_dir)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 windows_len =3D windows_dir_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (remainder !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR *ret =3D g_new(WCHAR, windows_len +=
 wcslen(remainder) + 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(ret, windows_dir, windows_len * si=
zeof(WCHAR));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcscpy(ret + windows_len, remainder);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (wcsncmp(expanded, L&quot;\\??\\&quot;, 4) =3D=3D 0)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_memdup2(expanded + 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(wcslen(expanded + 4) + 1) * sizeof(WCHAR));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((iswalpha(expanded[0]) &amp;&amp; expanded[1] =3D=
=3D L&#39;:&#39;) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 expanded[0] =3D=3D L&#39;\\&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;expanded);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 path_len =3D wcslen(expanded);<br>
&gt; +=C2=A0 =C2=A0 start =3D expanded;<br>
&gt; +=C2=A0 =C2=A0 while (*start =3D=3D L&#39;\\&#39; || *start =3D=3D L&#=
39;/&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 start++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 path_len--;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR *ret =3D g_new(WCHAR, windows_len +=
 path_len + 2);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(ret, windows_dir, windows_len * si=
zeof(WCHAR));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret[windows_len] =3D L&#39;\\&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcscpy(ret + windows_len + 1, start);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +typedef struct QGAVersionTranslation {<br>
&gt; +=C2=A0 =C2=A0 WORD language;<br>
&gt; +=C2=A0 =C2=A0 WORD code_page;<br>
&gt; +} QGAVersionTranslation;<br>
&gt; +<br>
&gt; +/* Return CompanyName from a localized file-version string table. */<=
br>
&gt; +static char *ga_get_file_vendor(const void *version_info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QGAVersionTranslation *translations =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 static const QGAVersionTranslation fallback =3D { 0x040=
9, 0x04b0 };<br>
&gt; +=C2=A0 =C2=A0 UINT translations_len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 UINT count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 UINT i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (VerQueryValueW(version_info, L&quot;\\VarFileInfo\\=
Translation&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(void **)&amp;translations, &amp;translations_len) &amp;&amp;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 translations !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D translations_len / sizeof(*tran=
slations);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt;=3D count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const QGAVersionTranslation *translation;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR query[64];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR *company =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 UINT company_len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *vendor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 translation =3D i &lt; count ? &amp;trans=
lations[i] : &amp;fallback;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(query, ARRAY_SIZE(query),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;=
\\StringFileInfo\\%04x%04x\\CompanyName&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0transla=
tion-&gt;language, translation-&gt;code_page);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!VerQueryValueW(version_info, query, =
(void **)&amp;company,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;company_len) || company_len &lt;=3D 1) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor =3D g_utf16_to_utf8(company, -1, N=
ULL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vendor !=3D NULL &amp;&amp; vendor[0]=
 !=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return vendor;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vendor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Add optional FileVersion and CompanyName data from a driver binary=
. */<br>
&gt; +static bool ga_get_driver_file_metadata(const WCHAR *path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Gues=
tDriverService *service,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Erro=
r **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autofree void *version_info =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 VS_FIXEDFILEINFO *fixed_info =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 PVOID old_redirection =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DWORD ignored;<br>
&gt; +=C2=A0 =C2=A0 DWORD version_size;<br>
&gt; +=C2=A0 =C2=A0 UINT fixed_info_len;<br>
&gt; +=C2=A0 =C2=A0 bool redirection_disabled;<br>
&gt; +=C2=A0 =C2=A0 bool version_loaded =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 redirection_disabled =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Wow64DisableWow64FsRedirection(&amp;old_r=
edirection);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 version_size =3D GetFileVersionInfoSizeW(path, &amp;ign=
ored);<br>
&gt; +=C2=A0 =C2=A0 if (version_size !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 version_info =3D g_malloc(version_size);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 version_loaded =3D GetFileVersionInfoW(pa=
th, 0, version_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0version_info);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (redirection_disabled &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !Wow64RevertWow64FsRedirection(old_redire=
ction)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;failed to restore WOW64 filesystem redirection &=
quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;for driver service &#39;%s&#39;&quot;, service-&=
gt;name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!version_loaded) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (VerQueryValueW(version_info, L&quot;\\&quot;, (void=
 **)&amp;fixed_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&amp;fixed_info_len) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fixed_info_len &gt;=3D sizeof(*fixed_info=
) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fixed_info-&gt;dwSignature =3D=3D VS_FFI_=
SIGNATURE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 service-&gt;version =3D g_strdup_printf(<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%u.%u.%u.%u&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HIWORD(fixed_info-&gt;dwFil=
eVersionMS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOWORD(fixed_info-&gt;dwFil=
eVersionMS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HIWORD(fixed_info-&gt;dwFil=
eVersionLS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOWORD(fixed_info-&gt;dwFil=
eVersionLS));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 service-&gt;vendor =3D ga_get_file_vendor(version_info)=
;<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Add optional configuration and binary metadata for one driver serv=
ice.<br>
&gt; + * Ordinary per-service lookup failures leave optional fields unset.<=
br>
&gt; + */<br>
&gt; +static bool ga_get_driver_service_config(SC_HANDLE manager,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const WCHAR *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GuestDriverService *service,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE handle;<br>
&gt; +=C2=A0 =C2=A0 g_autofree QUERY_SERVICE_CONFIGW *config =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree WCHAR *resolved_path =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DWORD size =3D 0;<br>
&gt; +=C2=A0 =C2=A0 DWORD err;<br>
&gt; +=C2=A0 =C2=A0 bool success =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 handle =3D OpenServiceW(manager, name, SERVICE_QUERY_CO=
NFIG);<br>
&gt; +=C2=A0 =C2=A0 if (handle =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to open configuration f=
or driver service &#39;%s&#39;, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;error=3D%lu&quo=
t;, service-&gt;name, GetLastError());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QueryServiceConfigW(handle, NULL, 0, &amp;size);<br>
&gt; +=C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D ERROR_INSUFFICIENT_BUFFER) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get configuration si=
ze for driver service &#39;%s&#39;, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;error=3D%lu&quo=
t;, service-&gt;name, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 config =3D g_malloc(size);<br>
&gt; +=C2=A0 =C2=A0 if (!QueryServiceConfigW(handle, config, size, &amp;siz=
e)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get configuration fo=
r driver service &#39;%s&#39;, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;error=3D%lu&quo=
t;, service-&gt;name, GetLastError());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (config-&gt;lpBinaryPathName =3D=3D NULL ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;lpBinaryPathName[0] =3D=3D L&#=
39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 service-&gt;driver_path =3D g_utf16_to_utf8(config-&gt;=
lpBinaryPathName, -1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 resolved_path =3D ga_resolve_driver_path(config-&gt;lpB=
inaryPathName);<br>
&gt; +=C2=A0 =C2=A0 if (resolved_path !=3D NULL &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !ga_get_driver_file_metadata(resolved_pat=
h, service, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 CloseServiceHandle(handle);<br>
&gt; +=C2=A0 =C2=A0 return success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static GuestDriverServiceList *ga_get_driver_services(Error **errp)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GuestDriverServiceList *head =3D NULL, **tail =3D &amp;=
head;<br>
&gt; +=C2=A0 =C2=A0 g_autofree BYTE *buffer =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 SC_HANDLE manager =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DWORD buffer_size =3D 256 * 1024;<br>
&gt; +=C2=A0 =C2=A0 DWORD bytes_needed;<br>
&gt; +=C2=A0 =C2=A0 DWORD services_returned;<br>
&gt; +=C2=A0 =C2=A0 DWORD resume =3D 0;<br>
&gt; +=C2=A0 =C2=A0 DWORD err;<br>
&gt; +=C2=A0 =C2=A0 bool complete;<br>
&gt; +=C2=A0 =C2=A0 bool success =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 manager =3D OpenSCManagerW(NULL, NULL, SC_MANAGER_ENUME=
RATE_SERVICE);<br>
&gt; +=C2=A0 =C2=A0 if (manager =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;failed to open service control manager&quot;);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 buffer =3D g_malloc(buffer_size);<br>
&gt; +=C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ENUM_SERVICE_STATUS_PROCESSW *services;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_needed =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 services_returned =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 complete =3D EnumServicesStatusExW(manage=
r, SC_ENUM_PROCESS_INFO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0SERVICE_DRIVER, SERVICE_STATE_ALL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0buffer, buffer_size, &amp;bytes_needed,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;services_returned, &amp;resume, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!complete) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D ERROR_MORE_DAT=
A) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_wi=
n32(errp, err,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to enumerate =
driver services&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (services_returned =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;driver service enumeration made no &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;progress (buffer needs %lu bytes)&quot;, =
bytes_needed);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 services =3D (ENUM_SERVICE_STATUS_PROCESS=
W *)buffer;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; services_returned; i=
++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autoptr(GuestDriverServic=
e) service =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 service =3D g_new0(GuestDri=
verService, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 service-&gt;name =3D ga_utf=
16_to_utf8_required(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 services[i].l=
pServiceName, &quot;service name&quot;, errp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (service-&gt;name =3D=3D=
 NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ga_driver_service_stat=
us(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 services[i].ServiceStatusProcess.dwCurrentState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &amp;service-&gt;status)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;driver service &#39;%s&#39; has unknown state %lu&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0service-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0services[i].ServiceStatusProcess.dwCurrentState=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
An unknown dwCurrentState aborts the entire service enumeration. The states=
<br>
listed in GuestDriverServiceStatus cover all documented SCM values today, b=
ut a<br>
future Windows version could add new states. <br>
<br>
Consider skipping the service with a slog warning instead, or adding an<br>
&quot;unknown&quot; enum value to GuestDriverServiceStatus.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ga_get_driver_service_=
config(manager,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 services[i].lpServiceName,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 service, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, g_st=
eal_pointer(&amp;service));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } while (!complete);<br>
&gt; +=C2=A0 =C2=A0 success =3D true;<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (manager !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(manager);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!success) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDriverServiceList(head);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
&gt; +<br>
&gt; +GuestDriverInfo *qmp_guest_get_drivers(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GuestDriverInfo) info =3D g_new0(GuestDriverI=
nfo, 1);<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 info-&gt;packages =3D ga_get_driver_packages(&amp;local=
_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
If DismApi.dll is missing or DismInitialize fails, it returns an error, eve=
n if<br>
listing services could work. That&#39;s probably ok, but worth noting.<br><=
/blockquote><div><br></div><div>what if we add an &quot;error&quot; field t=
o the package structure, then we can return services and=C2=A0package with =
an error about=C2=A0DismInitialize</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 info-&gt;services =3D ga_get_driver_services(&amp;local=
_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return g_steal_pointer(&amp;info);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 char *qga_get_host_name(Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];<br>
&gt; diff --git a/qga/meson.build b/qga/meson.build<br>
&gt; index cfa2157efb23..15860d938d4b 100644<br>
&gt; --- a/qga/meson.build<br>
&gt; +++ b/qga/meson.build<br>
&gt; @@ -94,8 +94,9 @@ qga_ss =3D qga_ss.apply({})<br>
&gt;=C2=A0 gen_tlb =3D []<br>
&gt;=C2=A0 qga_libs =3D []<br>
&gt;=C2=A0 if host_os =3D=3D &#39;windows&#39;<br>
&gt; -=C2=A0 qga_libs +=3D [&#39;-lws2_32&#39;, &#39;-lwinmm&#39;, &#39;-lp=
owrprof&#39;, &#39;-lwtsapi32&#39;, &#39;-lwininet&#39;, &#39;-liphlpapi&#3=
9;, &#39;-lnetapi32&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-lsetupap=
i&#39;, &#39;-lcfgmgr32&#39;, &#39;-luserenv&#39;, &#39;-lpdh&#39; ]<br>
&gt; +=C2=A0 qga_libs +=3D [&#39;-lws2_32&#39;, &#39;-lwinmm&#39;, &#39;-lp=
owrprof&#39;, &#39;-lwtsapi32&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-lwininet=
&#39;, &#39;-liphlpapi&#39;, &#39;-lnetapi32&#39;, &#39;-lsetupapi&#39;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-lcfgmgr3=
2&#39;, &#39;-luserenv&#39;, &#39;-lpdh&#39;, &#39;-lversion&#39; ]<br>
&gt;=C2=A0 =C2=A0 if have_qga_vss<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_libs +=3D [&#39;-lole32&#39;, &#39;-loleaut32&=
#39;, &#39;-lshlwapi&#39;, &#39;-Wl,--enable-stdcall-fixup&#39;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 subdir(&#39;vss-win32&#39;)<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index 8cd0ba048b8d..b20cf7135a4c 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1590,6 +1590,95 @@<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @GuestDriverServiceStatus:<br>
&gt; +#<br>
&gt; +# @stopped: the service is stopped<br>
&gt; +#<br>
&gt; +# @start-pending: the service is starting<br>
&gt; +#<br>
&gt; +# @stop-pending: the service is stopping<br>
&gt; +#<br>
&gt; +# @running: the service is running<br>
&gt; +#<br>
&gt; +# @continue-pending: the service is resuming<br>
&gt; +#<br>
&gt; +# @pause-pending: the service is pausing<br>
&gt; +#<br>
&gt; +# @paused: the service is paused<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;GuestDriverServiceStatus&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ &#39;stopped&#39;, &#39;start-pending&#39;, =
&#39;stop-pending&#39;, &#39;running&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;continue-pending&#39;,=
 &#39;pause-pending&#39;, &#39;paused&#39; ],<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDriverPackage:<br>
&gt; +#<br>
&gt; +# An out-of-box driver package installed in the guest.<br>
&gt; +#<br>
&gt; +# @name: published INF name<br>
&gt; +#<br>
&gt; +# @original-name: base name of the original INF file<br>
&gt; +#<br>
&gt; +# @version: four-part version from the package INF DriverVer entry<br=
>
&gt; +#<br>
&gt; +# @vendor: package provider from the INF metadata<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDriverPackage&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*origina=
l-name&#39;: &#39;str&#39;, &#39;version&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vendor&#39;: &#39;str=
&#39; },<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDriverService:<br>
&gt; +#<br>
&gt; +# @name: service name<br>
&gt; +#<br>
&gt; +# @driver-path: driver binary path configured in the service database=
<br>
&gt; +#<br>
&gt; +# @version: four-part FileVersion from the driver binary<br>
&gt; +#<br>
&gt; +# @vendor: CompanyName from the driver binary<br>
&gt; +#<br>
&gt; +# @status: current service status<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDriverService&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*driver-=
path&#39;: &#39;str&#39;, &#39;*version&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vendor&#39;: &#39;str=
&#39;, &#39;status&#39;: &#39;GuestDriverServiceStatus&#39; },<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDriverInfo:<br>
&gt; +#<br>
&gt; +# @packages: out-of-box driver packages installed in the guest<br>
&gt; +#<br>
&gt; +# @services: registered driver services<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDriverInfo&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;packages&#39;: [&#39;GuestDriverPackage=
&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;services&#39;: [&#39;G=
uestDriverService&#39;] },<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-get-drivers:<br>
&gt; +#<br>
&gt; +# Retrieve information about Windows driver packages and services.<br=
>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-get-drivers&#39;,<br>
&gt; +=C2=A0 &#39;returns&#39;: &#39;GuestDriverInfo&#39;,<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @GuestAuthorizedKeys:<br>
&gt;=C2=A0 #<br>
<br>
otherwise, lgtm<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" t=
arget=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000020ac32065c492eff--


