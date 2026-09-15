Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B05C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QwJ-0000Wm-Vz; Tue, 15 Sep 2026 07:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Qvl-00008Z-TZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Qvh-0005DN-1Y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e/8PRRcqPJE84ysRjWwT5pFwljCiNJGzQeqCiKrYpTw=;
 b=dqS17S+fcl4OYrXLkpbTKkeJxhq8oPD7ioLDu9XjOi/8jFqJ0EiJKvqCZFl+ldkbSe2FML
 SmfmB/1s8+HVVQWYM1397rFBvigtfiQ0aroUtNHrFscB0qB6UPPz5gxp9c/AC5s/+PmiSj
 kQ4ELl6yIltwng6xjBIrTjep2bg3YEI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-t5TrHkupMv6CLCllLPrzJg-1; Tue, 15 Sep 2026 07:02:21 -0400
X-MC-Unique: t5TrHkupMv6CLCllLPrzJg-1
X-Mimecast-MFC-AGG-ID: t5TrHkupMv6CLCllLPrzJg_1789470141
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-79630cb8723so524977137.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470141; cv=none;
 d=google.com; s=arc-20260327;
 b=gaIHVyov2ij2v2FLFaAXTpfTZf27AmkHVYexI/o8fxr7wPIi2u9oey8l3bv3YJsgra
 xG3GOVW0YPV4MPrTPIE93jylYbEH6Ng2LbIPF4x0BdNchbuI+GVTy2xNCiYqO074wekz
 LEOv4660OmWWL+8OU7QT8m8m+PRRni0Ob0VlDJvIXvKytJRf2hU2goVNFrRr9TkJXQ9U
 SWFjd/vKh6LcOYcAJgRKK/LJMo2KaMNl0th4LOLTpgAXTCgPjrH4OhYDelu3C7iKwTIX
 e0sFONf8SKGKTRftzaK6Tc8VB1gTXG2DkzeLn973mKsnO8xYyKmJEb+DD+34EJXsbAVk
 CGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e/8PRRcqPJE84ysRjWwT5pFwljCiNJGzQeqCiKrYpTw=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=YnqE96OkSBMPQfnsFdJ3N9sTMI939uxjSQqLh8v+bTgiagovU7qsSswzXSETtFySnh
 IVDO42p6D7PMPY/OKUpx0FjEiIgof/88j7jZrvuBcfbtEaxj26dhRE4E9Lj2dDBXgKkn
 xTmcoNsmS7YdWt7X/OZnDhpiwDRH+Ljvrp2ubhkoXtJRQ8ST8VsC9KyTz/ZOjrXHhyPU
 gUrISQXmIFs8Och7n74sojGQt8LA2Blf4C31ruO0xBOjSAq3N+2e2s6jvmxC57dxspYD
 cxjjPV/NdrUL6dpAcEVl1Vg+4r26aSZzfisOZsIxx6yv705O+ABbr1GtMeH13hrv0HIc
 HAeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470141; x=1790074941; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e/8PRRcqPJE84ysRjWwT5pFwljCiNJGzQeqCiKrYpTw=;
 b=B+tLvb6FFOlKCcMWpZZ4Yyma3/CUvA2fxYjnIvvjuwXmIWoKIeA3DumxjegdTf8VuA
 +Fs8XuuWVjVM/NYwKTVM8Zot+PoLMl2tE/nXhXArrB9LL/rHWKeLou73HECqyz3PddgR
 7g1TOQOvSuA1d21wFjXnLfsMv4KwuMMNiNMt0+qXF0/C64HrvdLfUZZaCpaVak7OIZtL
 nlo7rqJ33zpsYmLc7YaP/dnWeIRWVtvaX0iRA/iTQZcKP59MTJxJf01XbOGMuy13smI9
 wdDs21O0qZo+tdpE7Aq7yKuIq77eCBUa8fmGTyoeiBqEoQlysMsoQm0i/itwhb35G3jV
 pRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470141; x=1790074941;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e/8PRRcqPJE84ysRjWwT5pFwljCiNJGzQeqCiKrYpTw=;
 b=LySf+z5/g7fS6NNBv4b3GCE40imYvLOw1c6ADAnA/kelxB36O5hUhXqHXa2eC1EqBg
 k9VZ/gCqLuun5TpflInhCHYskI+tc1Kdak6JVja7TAuGZAjnqCwsGobPCdacmIm7CvEu
 bKiYxGgMpH54vax7xQ8EElqFTLyhiTrIFDQWONZF/3HsHpg5f0TjzyRDeeWKf5OAXd32
 Jywr3yUCQWD5dO/+NdJgPh1gv0z+ArNDWeKtSm6RRqNUi5QU6fk+SCFIuQa0b0btggzR
 LdEccZ9PyJ2mGr21s8wb77LBRjx8kEE5B0uvrsIAm1bP5QdWvjM+DoTN/U618/gTi2Lh
 YIsw==
X-Gm-Message-State: AFuF++lO+wMwJgRQeZYdcKpBk33Co4Z3K+x6zV7o+NlxSFGO9O93DsIv
 yoBol/bf4f6SsR3T0TZIcaI3iR2go/EUBDvXjYJ5YjyQX3gmGYT3OqntkkNF33XZudj79eJ0uDd
 AeBAB76Rv1T6vMeoduaIprgrmayuGYqK48zJRXFnH0vXg5C2eZGbKVwS5rxguiZzG/I6RpHtMGh
 ocmixncQMA0AWPg5O2KixvUcXnJVwDB3akPuQSXRYMxg==
X-Gm-Gg: AYBFou0ZunqzOs0dtMj17bm/4E7JpIYpjJt8sJoG3TRbOAkudnQ4wqTYuSh4vxHHoEz
 eg47NctPJ3d3ULbcHKMQDlXmtR9frniVtKHWP7LjNrSS11RhOSWjHNMe5Qzx9YDoBVa86Rb4cKi
 XD59otDP+GbXT9dUyrCs9H1kO7qS7AR8+NA6QfoLWehx+eWqTIl7qIEUf8JSs=
X-Received: by 2002:a05:6102:a184:20b0:79c:cf1:723d with SMTP id
 ada2fe7eead31-79c0cf17cf0mr5243860137.6.1789470128261; 
 Tue, 15 Sep 2026 04:02:08 -0700 (PDT)
X-Received: by 2002:a05:6102:a184:20b0:79c:cf1:723d with SMTP id
 ada2fe7eead31-79c0cf17cf0mr5239529137.6.1789470110397; Tue, 15 Sep 2026
 04:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-16-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-16-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:01:38 +0300
X-Gm-Features: AcwNN1VS4V1c6KaDzQwioASKfbwv1nh4lQBc9xDu02tBgxSGtoaXlKZPylaaxbY
Message-ID: <CAPMcbCqbn9mGQcJHMOYe0ZWARsReaAUDmSy1Rt7qL4sPq-sUNA@mail.gmail.com>
Subject: Re: [PATCH 16/17] qga/vss-win32: restrict access to freeze/thaw
 synchronisation events
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000446beb065b837abd"
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

--000000000000446beb065b837abd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The freeze, thaw and timeout events were created with a NULL DACL,
> granting unrestricted access. Any local process could open and signal
> them, allowing an unprivileged guest process to trigger a filesystem
> freeze or premature thaw.
>
> Replace the NULL DACL with an explicit ACL that grants EVENT_ALL_ACCESS
> only to SYSTEM and the built-in Administrators group, which are the
> accounts under which the VSS service and qemu-ga operate.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 52
> ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index d36a90c17d1d..1b0155c691ef 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -17,6 +17,7 @@
>  #include "install.h"
>  #include <vswriter.h>
>  #include <vsbackup.h>
> +#include <aclapi.h>
>
>  /* Max wait time for frozen event (VSS can only hold writes for 10
> seconds) */
>  #define VSS_TIMEOUT_FREEZE_MSEC 60000
> @@ -298,10 +299,14 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      HRESULT hr;
>      LONG ctx;
>      GUID guidSnapshotSet =3D GUID_NULL;
> +    SID_IDENTIFIER_AUTHORITY sia_nt =3D SECURITY_NT_AUTHORITY;
> +    PSID pSidSystem =3D NULL, pSidAdmins =3D NULL;
>      SECURITY_DESCRIPTOR sd;
>      SECURITY_ATTRIBUTES sa;
> +    EXPLICIT_ACCESS ea[2];
> +    PACL pAcl =3D NULL;
>      WCHAR short_volume_name[64], *display_name =3D short_volume_name;
> -    DWORD wait_status;
> +    DWORD wait_status, aclResult;
>      int num_fixed_drives =3D 0, i;
>      int num_mount_points =3D 0;
>      VSS_BACKUP_TYPE vss_bt =3D get_vss_backup_type();
> @@ -313,9 +318,48 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>          return;
>      }
>
> -    /* Allow unrestricted access to events */
> +    /* Grant access to SYSTEM and Administrators only */
> +    if (!AllocateAndInitializeSid(&sia_nt, 1,
> +            SECURITY_LOCAL_SYSTEM_RID, 0, 0, 0, 0, 0, 0, 0,
> +            &pSidSystem)) {
> +        err_set(errset, GetLastError(), "failed to create SYSTEM SID");
> +        goto out;
> +    }
> +    if (!AllocateAndInitializeSid(&sia_nt, 2,
> +            SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
> +            0, 0, 0, 0, 0, 0, &pSidAdmins)) {
> +        DWORD err =3D GetLastError();
> +        FreeSid(pSidSystem);
> +        err_set(errset, err, "failed to create Administrators SID");
> +        goto out;
> +    }
> +
> +    ZeroMemory(&ea, sizeof(ea));
> +    ea[0].grfAccessPermissions =3D EVENT_ALL_ACCESS;
> +    ea[0].grfAccessMode =3D SET_ACCESS;
> +    ea[0].grfInheritance =3D NO_INHERITANCE;
> +    ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_WELL_KNOWN_GROUP;
> +    ea[0].Trustee.ptstrName =3D (LPTSTR)pSidSystem;
> +    ea[1].grfAccessPermissions =3D EVENT_ALL_ACCESS;
> +    ea[1].grfAccessMode =3D SET_ACCESS;
> +    ea[1].grfInheritance =3D NO_INHERITANCE;
> +    ea[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    ea[1].Trustee.TrusteeType =3D TRUSTEE_IS_WELL_KNOWN_GROUP;
> +    ea[1].Trustee.ptstrName =3D (LPTSTR)pSidAdmins;
> +
> +    aclResult =3D SetEntriesInAcl(2, ea, NULL, &pAcl);
> +    if (aclResult !=3D ERROR_SUCCESS) {
> +        FreeSid(pSidSystem);
> +        FreeSid(pSidAdmins);
> +        err_set(errset, aclResult, "failed to create ACL for events");
> +        goto out;
> +    }
> +    FreeSid(pSidSystem);
> +    FreeSid(pSidAdmins);
> +
>      InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
> -    SetSecurityDescriptorDacl(&sd, TRUE, NULL, FALSE);
> +    SetSecurityDescriptorDacl(&sd, TRUE, pAcl, FALSE);
>      sa.nLength =3D sizeof(sa);
>      sa.lpSecurityDescriptor =3D &sd;
>      sa.bInheritHandle =3D FALSE;
> @@ -551,6 +595,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      }
>
>      qga_debug("end successful");
> +    LocalFree(pAcl);
>      return;
>
>  out:
> @@ -559,6 +604,7 @@ out:
>      }
>
>  out1:
> +    LocalFree(pAcl);
>      requester_cleanup();
>
>      qga_debug_end;
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000446beb065b837abd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he freeze, thaw and timeout events were created with a NULL DACL,<br>
granting unrestricted access. Any local process could open and signal<br>
them, allowing an unprivileged guest process to trigger a filesystem<br>
freeze or premature thaw.<br>
<br>
Replace the NULL DACL with an explicit ACL that grants EVENT_ALL_ACCESS<br>
only to SYSTEM and the built-in Administrators group, which are the<br>
accounts under which the VSS service and qemu-ga operate.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 52 ++++++++++++++++++++++++++++++++++++=
++++++---<br>
=C2=A01 file changed, 49 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index d36a90c17d1d..1b0155c691ef 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -17,6 +17,7 @@<br>
=C2=A0#include &quot;install.h&quot;<br>
=C2=A0#include &lt;vswriter.h&gt;<br>
=C2=A0#include &lt;vsbackup.h&gt;<br>
+#include &lt;aclapi.h&gt;<br>
<br>
=C2=A0/* Max wait time for frozen event (VSS can only hold writes for 10 se=
conds) */<br>
=C2=A0#define VSS_TIMEOUT_FREEZE_MSEC 60000<br>
@@ -298,10 +299,14 @@ void requester_freeze(int *num_vols, void *mountpoint=
s, ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
=C2=A0 =C2=A0 =C2=A0LONG ctx;<br>
=C2=A0 =C2=A0 =C2=A0GUID guidSnapshotSet =3D GUID_NULL;<br>
+=C2=A0 =C2=A0 SID_IDENTIFIER_AUTHORITY sia_nt =3D SECURITY_NT_AUTHORITY;<b=
r>
+=C2=A0 =C2=A0 PSID pSidSystem =3D NULL, pSidAdmins =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0SECURITY_DESCRIPTOR sd;<br>
=C2=A0 =C2=A0 =C2=A0SECURITY_ATTRIBUTES sa;<br>
+=C2=A0 =C2=A0 EXPLICIT_ACCESS ea[2];<br>
+=C2=A0 =C2=A0 PACL pAcl =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0WCHAR short_volume_name[64], *display_name =3D short_vo=
lume_name;<br>
-=C2=A0 =C2=A0 DWORD wait_status;<br>
+=C2=A0 =C2=A0 DWORD wait_status, aclResult;<br>
=C2=A0 =C2=A0 =C2=A0int num_fixed_drives =3D 0, i;<br>
=C2=A0 =C2=A0 =C2=A0int num_mount_points =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0VSS_BACKUP_TYPE vss_bt =3D get_vss_backup_type();<br>
@@ -313,9 +318,48 @@ void requester_freeze(int *num_vols, void *mountpoints=
, ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Allow unrestricted access to events */<br>
+=C2=A0 =C2=A0 /* Grant access to SYSTEM and Administrators only */<br>
+=C2=A0 =C2=A0 if (!AllocateAndInitializeSid(&amp;sia_nt, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SECURITY_LOCAL_SYSTEM_RID, 0, 0,=
 0, 0, 0, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;pSidSystem)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, GetLastError(), &quot;failed t=
o create SYSTEM SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!AllocateAndInitializeSid(&amp;sia_nt, 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SECURITY_BUILTIN_DOMAIN_RID, DOM=
AIN_ALIAS_RID_ADMINS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0, 0, 0, 0, 0, &amp;pSidAdmin=
s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FreeSid(pSidSystem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, err, &quot;failed to create Ad=
ministrators SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ZeroMemory(&amp;ea, sizeof(ea));<br>
+=C2=A0 =C2=A0 ea[0].grfAccessPermissions =3D EVENT_ALL_ACCESS;<br>
+=C2=A0 =C2=A0 ea[0].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 ea[0].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<br>
+=C2=A0 =C2=A0 ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_WELL_KNOWN_GROUP;<b=
r>
+=C2=A0 =C2=A0 ea[0].Trustee.ptstrName =3D (LPTSTR)pSidSystem;<br>
+=C2=A0 =C2=A0 ea[1].grfAccessPermissions =3D EVENT_ALL_ACCESS;<br>
+=C2=A0 =C2=A0 ea[1].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 ea[1].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 ea[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<br>
+=C2=A0 =C2=A0 ea[1].Trustee.TrusteeType =3D TRUSTEE_IS_WELL_KNOWN_GROUP;<b=
r>
+=C2=A0 =C2=A0 ea[1].Trustee.ptstrName =3D (LPTSTR)pSidAdmins;<br>
+<br>
+=C2=A0 =C2=A0 aclResult =3D SetEntriesInAcl(2, ea, NULL, &amp;pAcl);<br>
+=C2=A0 =C2=A0 if (aclResult !=3D ERROR_SUCCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FreeSid(pSidSystem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FreeSid(pSidAdmins);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, aclResult, &quot;failed to cre=
ate ACL for events&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 FreeSid(pSidSystem);<br>
+=C2=A0 =C2=A0 FreeSid(pSidAdmins);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0InitializeSecurityDescriptor(&amp;sd, SECURITY_DESCRIPT=
OR_REVISION);<br>
-=C2=A0 =C2=A0 SetSecurityDescriptorDacl(&amp;sd, TRUE, NULL, FALSE);<br>
+=C2=A0 =C2=A0 SetSecurityDescriptorDacl(&amp;sd, TRUE, pAcl, FALSE);<br>
=C2=A0 =C2=A0 =C2=A0sa.nLength =3D sizeof(sa);<br>
=C2=A0 =C2=A0 =C2=A0sa.lpSecurityDescriptor =3D &amp;sd;<br>
=C2=A0 =C2=A0 =C2=A0sa.bInheritHandle =3D FALSE;<br>
@@ -551,6 +595,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug(&quot;end successful&quot;);<br>
+=C2=A0 =C2=A0 LocalFree(pAcl);<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0out:<br>
@@ -559,6 +604,7 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0out1:<br>
+=C2=A0 =C2=A0 LocalFree(pAcl);<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000446beb065b837abd--


