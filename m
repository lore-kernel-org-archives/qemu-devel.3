Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bi+cq4ep;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hSK6H4eR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2JF-0004y7-68; Wed, 28 Oct 2026 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2J6-0004ul-2g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2J1-0006Ir-EJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qh+pjzCUj3SlcLkX1BKcuEachUZocl/r1Co7dnRf9bg=;
 b=bi+cq4epQiV/unFg6B4r0J7VIQEhzEr1ojLgUHS7iGd/91tzW9wLI43UE1z0fC4mxBkqIw
 WQTbTlEu1nBELAoso2fepyl2T9KZd2ttbjQDpJ2SpqDHMyvISHvkCb9hxMvq3MohhYhz8E
 jNgTB9J8S4SD7wqDm0/Rg9JpYIm4Q1g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-_jCcOm1qMK6Ogw16RlF4Ow-1; Wed, 28 Oct 2026 07:58:56 -0400
X-MC-Unique: _jCcOm1qMK6Ogw16RlF4Ow-1
X-Mimecast-MFC-AGG-ID: _jCcOm1qMK6Ogw16RlF4Ow_1793188736
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53664bfb2baso17915181cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188736; cv=none;
 d=google.com; s=arc-20260327;
 b=h8MPkd93+/Qbtl3e2zYb6oVoAXFzKjIOV+H2mZ3znFe5y1oW9T9vIvVMLKMRkDBq06
 v23Xpf+IxAduOlwBRaMGoO7LLDLiefrJGhUp3hae+6CsEiudDMr+nUJG3/ViIRFHTPQD
 adY6WpIyCm018VUoVFZeQRvkhclERQYVc+KzcBdv4xTPofQBax4lQ+dXZecHdSquWlg5
 ss15E8kSIoAYgR+LmD1WYvQzzsPYaoz/EHZAEc9DaDf2rPU3z84tFYvMDdeQNmzz86wK
 ENk2sGentKzSRogYwg+fxM66Iu+vM1hzesKMmpjK8DwhFsp8Gt0ZcQuDwMKSN85bMnUx
 pjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qh+pjzCUj3SlcLkX1BKcuEachUZocl/r1Co7dnRf9bg=;
 fh=7+TMJ2Yg423AStOeItkvWjwS2P6hzHITMCZ8X7RwWFE=;
 b=JYSLhV8L5xXOh2tqeGbBtIPv1/p2kQd5x6CrC+VTqilDUX8OBsne8QNXeXKi4OndDG
 nhMU2fPmiJgtqzXRUSGfVD5tApOq6X5Jg04Ykc0YEIBM3uV7fKX1edjmaP+q8iI4Up6h
 afZqVSbnEWHMWEvUJmdX1QE4Lo6SM+b4Hf2y6LL8EGn9pGsDS7zMShDHt6dMEonzjRBh
 C0CnyEGIyLAlOjmwe7bfkkwGckJOVE57KdrvztDL1LSlTb4CF0L6UYN7bUENOVfdaAHv
 kMYOJvNXH7NjV+p34bFu9t5wlZfoWT27Oy0I069wZjtCF9y3FO9oW7PYTrxyGgSG1wP8
 p8VA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188736; x=1793793536; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qh+pjzCUj3SlcLkX1BKcuEachUZocl/r1Co7dnRf9bg=;
 b=hSK6H4eRpghq3UiwOO85SQtaeiV/C/hzVDI1DNuHNgZsUr907tpe9FaiQQc8INxQqA
 Efy2lgaZgO0P7v5ly3WZ7c1htKSBqXhG2+FR1fnxerVLTItNG75zkoWFoqj99bTkVykc
 pf17YpDw2zadbCvC0FhFWEHwAj3b0b8HAE0GxIGQ/4+xo2/H/tAwkj6flU88zRTyBo9W
 +kdfmLd2zpRVOL2nZKWDfp88GI65M//sUDRO28LVEtOQvVovhRfeW5kTg8O9o1yn/voc
 s5gph71DpS47Du9jYm1OhKujvgYIo9hu5j7MJU8KAUNsTFRmOWW6zldhtFOxDKToiRai
 2cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188736; x=1793793536;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qh+pjzCUj3SlcLkX1BKcuEachUZocl/r1Co7dnRf9bg=;
 b=twR3xLAN0+bUB71d7klzOmRr+ex3C8TvefeZ/3lZGNgPj3JGp5DinGY1tab/jdWuNP
 jyMWKIWPC4RxZaSC2VFD78SMkq6lh8jzTvFOZxCGetMJc4lLutVDHzrYph3XIJm0GTF+
 ftzrsYuuo8w3lDxFm+ThbHQTpTdiyR7rKZmdu35vhLMfb3tyMwQc63+79Y5WcRbq21Iz
 viqZb6/GTd2QFh+HsXwLGRGLBvBDza6b/pPj6rBHFQ9Dtf4X7jIjeaXs3ioY1uPjpL49
 lUsHFfrzxBMboKvvq6BVUIg22+19wn3W9NWD0Sb6hLOxq52C2dSxj1PVd8rSIX4GQdi1
 uEfQ==
X-Gm-Message-State: AFq9FYI/E8bjOz9SKzhitQUdsKGy0Ptxamafss0X8UzLZjPGqrwAJw1o
 NXhmDDd46AUCtDu/fV2X8D2xxxN+4fCPSu/hkieRYWVw7fnh6ZO3EP5BUYg8upXRCv3/MM2/hLq
 p4S5Pi2QTK35oENiPI1uAdvY+ZM3RnGgqXCZ9B6TSlV4IDI/tpG2SgH727HF5/CWJ55C1O4+7Ye
 blgUxgGNyQmCG/PNI4rO1DhqtA30cX2AI=
X-Gm-Gg: AYBFou39RXOMvzr3Igab3Ie+RXMKnLDGNwJlDrL1CCG57vsO9JxmLpSnRC42EOr6b6d
 ETHg40CxBd1vvUREUWSTAXCowJsuibAnDCbRsgvUQZmCQpV2q+wn4n2BX9RC9ZdlTRDuCl3bz/q
 /wDcL37d1PoDuPTaoBqD9rTKwL1sVn1jBSDvrFI596IQwQUq9nHNu8+cS19P0x8BBx1AOjRzyHI
 M4HWr2uPwZyltUCJ2Lw6VJSeey/dSEMvlz8kohMz1Xn32mXmkHAZYbT2YlR8/ofmbtIcVr516zu
X-Received: by 2002:a05:622a:389:b0:533:2366:7ceb with SMTP id
 d75a77b69052e-53e3f24f76emr93669811cf.15.1793188736012; 
 Wed, 28 Oct 2026 04:58:56 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:533:2366:7ceb with SMTP id
 d75a77b69052e-53e3f24f76emr93669671cf.15.1793188735436; Wed, 28 Oct 2026
 04:58:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027160606.2668607-2-marcandre.lureau@redhat.com>
 <CAPMcbCpY1Re_edBo-S1TqguOU3HpjpT1TVhX1-stw0yPTvh=pg@mail.gmail.com>
 <CAJ+F1CJ5AYSvPAkeiYnu8J7c7G-cP5ka4xK+XzPKyCRaz_+znA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ5AYSvPAkeiYnu8J7c7G-cP5ka4xK+XzPKyCRaz_+znA@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 13:58:44 +0200
X-Gm-Features: AclHuK9nsoCGDg5J36KXPf-58xk1v8ihoAAV9XDN7-6nv-ckhAr0CQYoCPtfp_4
Message-ID: <CAPMcbCqowKiKHLG6EZarbmMU75b5n7hmm2UP_rgh4211mW6QYg@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss: fix provider handling of snapshots
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000975ac2065ee54957"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000975ac2065ee54957
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Tested with reproducer from
https://gitlab.com/qemu-project/qemu/-/work_items/4584
Behavious is expected

On Wed, Oct 28, 2026 at 12:21=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Wed, Oct 28, 2026 at 12:08=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@red=
hat.com>
> wrote:
> >
> >
> >
> >
> >
> > On Tue, Oct 27, 2026 at 6:06=E2=80=AFPM <marcandre.lureau@redhat.com> w=
rote:
> >>
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Since commit 374f4676788c, the provider's GetSnapshotProperties()
> >> returns S_OK for any snapshot ID without filling in the properties.  V=
SS
> >> consults every registered provider when a requester looks up a snapsho=
t,
> >> so lookups of snapshots owned by other providers now succeed with an
> >> all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.
> >> Veeam: "Original volume name is not specified for the shadow (shadow
> >> volume id: '{00000000-0000-0000-0000-000000000000}')".
> >>
> >> Simply reverting is not an option: 374f4676788c switched to S_OK becau=
se
> >> returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's own
> >> snapshot sets. The provider must answer for its own snapshots only. It
> >> does not create real shadow copies, but it does take part in the
> >> snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot IDs
> >> received in BeginPrepareSnapshot(), return their required properties,
> >> and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every requir=
ed
> >> VSS_SNAPSHOT_PROP member except the exposed name and path, which are
> >> optional. The snapshot device object is an empty string because the
> >> host-side snapshot has no guest-visible device.
> >>
> >> Entries are dropped when VSS deletes the snapshots or the set, or when
> >> the set is aborted (AbortSnapshots()).
> >>
> >> COM+ may hand out several CQGAVssProvider instances (and serve several
> >> client processes), so this registry is module-global. It is per-proces=
s
> >> by design and safe because the COM+ application is hosted by a single =
NT
> >> service (see CreateServiceForApplication() in install.cpp): COM+ forbi=
ds
> >> pooling and recycling for service-hosted applications, so exactly one
> >> surrogate process ever hosts the provider.
> >>
> >> On the requester side, the snapshot set is created in the persistent
> >> VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
> >> cycle and may keep querying providers about it. The provider registry
> >> does not outlive the cycle (requester_thaw() stops the hosting service=
,
> >> and the provider process with it), so later queries would get "not
> >> found" for a set VSS still believes exists. Make requester_thaw() dele=
te
> >> the snapshot set explicitly at the end of the cycle, whatever its
> >> outcome (including BackupComplete() failure and aborted snapshot sets)=
.
> >> A failure to delete is only logged, since the guest filesystems have
> >> already been thawed.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
> >> Buglink: https://redhat.atlassian.net/browse/RHEL-250662
> >> Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties
> return value")
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >> v2:
> >>  - fill the required VSS_SNAPSHOT_PROP fields
> >> ---
> >>  qga/vss-win32/install.cpp   |   1 +
> >>  qga/vss-win32/provider.cpp  | 200 +++++++++++++++++++++++++++++++++++=
-
> >>  qga/vss-win32/requester.cpp |  26 +++++
> >>  3 files changed, 226 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> >> index 09d94edd4f53..3b58dc840520 100644
> >> --- a/qga/vss-win32/install.cpp
> >> +++ b/qga/vss-win32/install.cpp
> >> @@ -331,6 +331,7 @@ STDAPI COMRegister(void)
> >>      chk(put_Value(pObj, L"Authentication",                 short(6)))=
;
> >>      chk(put_Value(pObj, L"AuthenticationCapability",       short(2)))=
;
> >>      chk(put_Value(pObj, L"ImpersonationLevel",             short(2)))=
;
> >> +    /* NT-service-hosted apps have ConcurrentApps=3D1 enforced */
> >>      chk(pApps->SaveChanges(&n));
> >>
> >>      /* The app should be deleted if something fails after SaveChanges
> */
> >> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> >> index 1c8eb236e57f..bbc30dd57d85 100644
> >> --- a/qga/vss-win32/provider.cpp
> >> +++ b/qga/vss-win32/provider.cpp
> >> @@ -11,6 +11,11 @@
> >>   */
> >>
> >>  #include "qemu/osdep.h"
> >> +
> >> +#include <vector>
> >> +#include <algorithm>
> >> +#include <string>
> >> +
> >>  #include "vss-common.h"
> >>  #include "vss-debug.h"
> >>  #ifdef HAVE_VSS_SDK
> >> @@ -138,6 +143,170 @@ STDMETHODIMP
> CQGAVSSEnumObject::Clone(IVssEnumObject **ppenum)
> >>      return E_NOTIMPL;
> >>  }
> >>
> >> +static VSS_PWSZ qga_vss_strdup(const WCHAR *value)
> >> +{
> >> +    size_t len =3D (wcslen(value) + 1) * sizeof(WCHAR);
> >> +    VSS_PWSZ str =3D (VSS_PWSZ)CoTaskMemAlloc(len);
> >> +
> >> +    if (str) {
> >> +        memcpy(str, value, len);
> >> +    }
> >> +    return str;
> >> +}
> >> +
> >> +static VSS_PWSZ qga_vss_strdup(const std::wstring &value)
> >> +{
> >> +    return qga_vss_strdup(value.c_str());
> >> +}
> >> +
> >> +static VSS_TIMESTAMP qga_vss_timestamp(void)
> >> +{
> >> +    FILETIME ft;
> >> +    ULARGE_INTEGER value;
> >> +
> >> +    GetSystemTimeAsFileTime(&ft);
> >> +    value.LowPart =3D ft.dwLowDateTime;
> >> +    value.HighPart =3D ft.dwHighDateTime;
> >> +    return value.QuadPart;
> >> +}
> >> +
> >> +/* Registry of the snapshot IDs for this provider */
> >> +class QGAVssSnapshotRegistry
> >> +{
> >> +public:
> >> +    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
> >> +               VSS_PWSZ volume_name, LONG context);
> >> +    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP *prop=
)
> const;
> >> +    LONG RemoveSet(VSS_ID set_id); /* returns how many were removed *=
/
> >> +    bool Remove(VSS_ID snapshot_id);
> >> +
> >> +private:
> >> +    struct Entry {
> >> +        VSS_ID set_id;
> >> +        VSS_ID snapshot_id;
> >> +        std::wstring volume_name;
> >> +        LONG context;
> >> +        VSS_TIMESTAMP timestamp;
> >> +    };
> >> +
> >> +    std::vector<Entry> m_entries;
> >> +    mutable SRWLOCK m_lock =3D SRWLOCK_INIT;
> >> +};
> >> +
> >> +static QGAVssSnapshotRegistry qga_vss_registry;
> >> +
> >> +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id,
> >> +                                   VSS_PWSZ volume_name, LONG context=
)
> >> +{
> >> +    bool ok;
> >> +
> >> +    AcquireSRWLockExclusive(&m_lock);
> >> +    try {
> >> +        m_entries.push_back(Entry { set_id, snapshot_id, volume_name,
> >> +                                    context, qga_vss_timestamp() });
> >> +        ok =3D true;
> >> +    } catch (...) {
> >> +        ok =3D false;
> >> +    }
> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> +    return ok;
> >> +}
> >> +
> >> +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
> >> +                                              VSS_SNAPSHOT_PROP *prop=
)
> const
> >> +{
> >> +    HRESULT hr =3D S_OK;
> >> +    VSS_PWSZ device =3D NULL, original =3D NULL;
> >> +    VSS_PWSZ originating =3D NULL, service =3D NULL;
> >> +
> >> +    AcquireSRWLockShared(&m_lock);
> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> >> +        [&](const Entry &e) {
> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> >> +        });
> >> +    if (it =3D=3D m_entries.end()) {
> >> +        hr =3D VSS_E_OBJECT_NOT_FOUND;
> >> +        goto out;
> >> +    }
> >> +
> >> +    {
> >> +        const Entry &e =3D *it;
> >> +        WCHAR machine[256] =3D L"";
> >> +        DWORD machine_size =3D ARRAYSIZE(machine);
> >> +
> >> +        if (!GetComputerNameExW(ComputerNameDnsFullyQualified, machin=
e,
> >> +                               &machine_size)) {
> >> +            *machine =3D L'\0';
> >> +        }
> >> +
> >> +        device =3D qga_vss_strdup(L"");
> >> +        original =3D qga_vss_strdup(e.volume_name);
> >> +        originating =3D qga_vss_strdup(machine);
> >> +        service =3D qga_vss_strdup(machine);
> >> +        if (!device || !original || !originating || !service) {
> >> +            hr =3D E_OUTOFMEMORY;
> >> +            goto out;
> >> +        }
> >> +
> >> +        memset(prop, 0, sizeof(*prop));
> >> +        prop->m_SnapshotId =3D e.snapshot_id;
> >> +        prop->m_SnapshotSetId =3D e.set_id;
> >> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
> >> +            m_entries.end(), [&](const Entry &o) {
> >> +                return IsEqualGUID(o.set_id, e.set_id);
> >> +            });
> >> +        prop->m_pwszSnapshotDeviceObject =3D device;
> >> +        prop->m_pwszOriginalVolumeName =3D original;
> >> +        prop->m_pwszOriginatingMachine =3D originating;
> >> +        prop->m_pwszServiceMachine =3D service;
> >> +        prop->m_ProviderId =3D g_gProviderId;
> >> +        prop->m_lSnapshotAttributes =3D e.context;
> >> +        prop->m_tsCreationTimestamp =3D e.timestamp;
> >> +        prop->m_eStatus =3D VSS_SS_CREATED;
> >> +
> >> +        device =3D original =3D originating =3D service =3D NULL;
> >> +    }
> >> +
> >> +out:
> >> +    CoTaskMemFree(device);
> >> +    CoTaskMemFree(original);
> >> +    CoTaskMemFree(originating);
> >> +    CoTaskMemFree(service);
> >> +    ReleaseSRWLockShared(&m_lock);
> >> +    return hr;
> >> +}
> >> +
> >> +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
> >> +{
> >> +    LONG removed;
> >> +
> >> +    AcquireSRWLockExclusive(&m_lock);
> >> +    auto it =3D std::remove_if(m_entries.begin(), m_entries.end(),
> >> +        [&](const Entry &e) {
> >> +            return IsEqualGUID(e.set_id, set_id);
> >> +        });
> >> +    removed =3D m_entries.end() - it;
> >> +    m_entries.erase(it, m_entries.end());
> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> +    return removed;
> >> +}
> >> +
> >> +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
> >> +{
> >> +    bool found;
> >> +
> >> +    AcquireSRWLockExclusive(&m_lock);
> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> >> +        [&](const Entry &e) {
> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> >> +        });
> >> +    found =3D it !=3D m_entries.end();
> >> +    if (found) {
> >> +        m_entries.erase(it);
> >> +    }
> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> +    return found;
> >> +}
> >>
> >>  /* QGAVssProvider */
> >>
> >> @@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG
> lContext)
> >>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
> >>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
> >>  {
> >> -    return S_OK;
> >> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
> >>  }
> >>
> >>  STDMETHODIMP CQGAVssProvider::Query(
> >> @@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
> >>      VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
> >>      BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID
> *pNondeletedSnapshotID)
> >>  {
> >> +    LONG deleted =3D 0;
> >> +
> >> +    switch (eSourceObjectType) {
> >> +    case VSS_OBJECT_SNAPSHOT:
> >> +        if (qga_vss_registry.Remove(SourceObjectId)) {
> >> +            deleted =3D 1;
> >> +        }
> >> +        break;
> >> +    case VSS_OBJECT_SNAPSHOT_SET:
> >> +        deleted =3D qga_vss_registry.RemoveSet(SourceObjectId);
> >> +        break;
> >> +    default:
> >> +        break;
> >> +    }
> >> +
> >> +    if (deleted > 0) {
> >> +        *plDeletedSnapshots =3D deleted;
> >> +        *pNondeletedSnapshotID =3D GUID_NULL;
> >> +        return S_OK;
> >> +    }
> >> +
> >>      *plDeletedSnapshots =3D 0;
> >>      *pNondeletedSnapshotID =3D SourceObjectId;
> >>      return S_OK;
> >
> >
> > return VSS_E_OBJECT_NOT_FOUND in this case looks more correct
>
> Possibly, but I didn't want to change the existing behaviour here
> without good reasons (it was fixed in 2014 by commit
> d9e1f574cb6eac0a3a2f97b67d2e7a3ad9c1dc95).
>
> >
> >>
> >> @@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapsho=
t(
> >>      VSS_ID SnapshotSetId, VSS_ID SnapshotId,
> >>      VSS_PWSZ pwszVolumeName, LONG lNewContext)
> >>  {
> >> +    if (!pwszVolumeName) {
> >> +        return E_INVALIDARG;
> >> +    }
> >> +    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
> >> +                                pwszVolumeName, lNewContext)) {
> >> +        return E_OUTOFMEMORY;
> >> +    }
> >>      return S_OK;
> >>  }
> >>
> >> @@ -411,6 +608,7 @@ STDMETHODIMP
> CQGAVssProvider::PostFinalCommitSnapshots(VSS_ID SnapshotSetId)
> >>
> >>  STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
> >>  {
> >> +    qga_vss_registry.RemoveSet(SnapshotSetId);
> >>      return S_OK;
> >>  }
> >>
> >> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> >> index 1b0155c691ef..565eefcfb283 100644
> >> --- a/qga/vss-win32/requester.cpp
> >> +++ b/qga/vss-win32/requester.cpp
> >> @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties
> pVssFreeSnapshotProperties;
> >>  static struct QGAVSSContext {
> >>      IVssBackupComponents *pVssbc;  /* VSS requester interface */
> >>      IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot
> operation */
> >> +    VSS_ID idSnapshotSet;          /* snapshot set created for this
> cycle */
> >>      HANDLE hEventFrozen;           /* notify fs/writer freeze from
> provider */
> >>      HANDLE hEventThaw;             /* request provider to thaw */
> >>      HANDLE hEventTimeout;          /* notify timeout in provider */
> >> @@ -116,6 +117,7 @@ static void requester_cleanup(void)
> >>          vss_ctx.pVssbc->Release();
> >>          vss_ctx.pVssbc =3D NULL;
> >>      }
> >> +    vss_ctx.idSnapshotSet =3D GUID_NULL;
> >>      vss_ctx.cFrozenVols =3D 0;
> >>      qga_debug_end;
> >>  }
> >> @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
> >>          err_set(errset, hr, "failed to start snapshot set");
> >>          goto out;
> >>      }
> >> +    vss_ctx.idSnapshotSet =3D guidSnapshotSet;
> >>
> >>      if (mountpoints) {
> >>          PWCHAR volume_name_wchar;
> >> @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void
> *mountpints, ErrorSet *errset)
> >>          err_set(errset, hr, "failed to do snapshot set");
> >>      }
> >>
> >> +    /*
> >> +     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context, s=
o
> >> +     * it is persistent: if it was committed, VSS keeps it (and keeps
> >> +     * querying providers about it) until it is explicitly deleted. T=
he
> >> +     * freeze/thaw cycle is over whatever the outcome above, so delet=
e
> >> +     * it now. Failure is not fatal here, only log it.
> >> +     */
> >> +    {
> >> +        LONG lDeletedSnapshots =3D 0;
> >> +        VSS_ID idNonDeletedSnapshot;
> >> +        HRESULT hrDelete;
> >> +
> >> +        hrDelete =3D
> vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnapshotSet,
> >> +
>  VSS_OBJECT_SNAPSHOT_SET,
> >> +                                                   TRUE,
> >> +                                                   &lDeletedSnapshots=
,
> >> +
>  &idNonDeletedSnapshot);
> >> +        if (FAILED(hrDelete)) {
> >> +            qga_debug("failed to delete snapshot set after thaw,"
> >> +                      " hr=3D0x%08lx", hrDelete);
> >> +        }
> >> +    }
> >> +
> >>      if (err_is_set(errset)) {
> >>          vss_ctx.pVssbc->AbortBackup();
> >>      }
> >> --
> >> 2.56.0.116.g6de20f6092dc
> >>
>
>

--000000000000975ac2065ee54957
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"m=
ailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;<br><br></div>Tested =
with reproducer from=C2=A0<a href=3D"https://gitlab.com/qemu-project/qemu/-=
/work_items/4584" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/q=
emu-project/qemu/-/work_items/4584<br></a></div>Behavious is expected=C2=A0=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Oct 28, 2026 at 12:21=E2=80=AFPM Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi<br>
<br>
On Wed, Oct 28, 2026 at 12:08=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"=
mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 27, 2026 at 6:06=E2=80=AFPM &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Since commit 374f4676788c, the provider&#39;s GetSnapshotPropertie=
s()<br>
&gt;&gt; returns S_OK for any snapshot ID without filling in the properties=
.=C2=A0 VSS<br>
&gt;&gt; consults every registered provider when a requester looks up a sna=
pshot,<br>
&gt;&gt; so lookups of snapshots owned by other providers now succeed with =
an<br>
&gt;&gt; all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e=
.g.<br>
&gt;&gt; Veeam: &quot;Original volume name is not specified for the shadow =
(shadow<br>
&gt;&gt; volume id: &#39;{00000000-0000-0000-0000-000000000000}&#39;)&quot;=
.<br>
&gt;&gt;<br>
&gt;&gt; Simply reverting is not an option: 374f4676788c switched to S_OK b=
ecause<br>
&gt;&gt; returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga&#39=
;s own<br>
&gt;&gt; snapshot sets. The provider must answer for its own snapshots only=
. It<br>
&gt;&gt; does not create real shadow copies, but it does take part in the<b=
r>
&gt;&gt; snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot=
 IDs<br>
&gt;&gt; received in BeginPrepareSnapshot(), return their required properti=
es,<br>
&gt;&gt; and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every re=
quired<br>
&gt;&gt; VSS_SNAPSHOT_PROP member except the exposed name and path, which a=
re<br>
&gt;&gt; optional. The snapshot device object is an empty string because th=
e<br>
&gt;&gt; host-side snapshot has no guest-visible device.<br>
&gt;&gt;<br>
&gt;&gt; Entries are dropped when VSS deletes the snapshots or the set, or =
when<br>
&gt;&gt; the set is aborted (AbortSnapshots()).<br>
&gt;&gt;<br>
&gt;&gt; COM+ may hand out several CQGAVssProvider instances (and serve sev=
eral<br>
&gt;&gt; client processes), so this registry is module-global. It is per-pr=
ocess<br>
&gt;&gt; by design and safe because the COM+ application is hosted by a sin=
gle NT<br>
&gt;&gt; service (see CreateServiceForApplication() in install.cpp): COM+ f=
orbids<br>
&gt;&gt; pooling and recycling for service-hosted applications, so exactly =
one<br>
&gt;&gt; surrogate process ever hosts the provider.<br>
&gt;&gt;<br>
&gt;&gt; On the requester side, the snapshot set is created in the persiste=
nt<br>
&gt;&gt; VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/tha=
w<br>
&gt;&gt; cycle and may keep querying providers about it. The provider regis=
try<br>
&gt;&gt; does not outlive the cycle (requester_thaw() stops the hosting ser=
vice,<br>
&gt;&gt; and the provider process with it), so later queries would get &quo=
t;not<br>
&gt;&gt; found&quot; for a set VSS still believes exists. Make requester_th=
aw() delete<br>
&gt;&gt; the snapshot set explicitly at the end of the cycle, whatever its<=
br>
&gt;&gt; outcome (including BackupComplete() failure and aborted snapshot s=
ets).<br>
&gt;&gt; A failure to delete is only logged, since the guest filesystems ha=
ve<br>
&gt;&gt; already been thawed.<br>
&gt;&gt;<br>
&gt;&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qe=
mu-stable@nongnu.org</a><br>
&gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_i=
tems/4584" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/work_items/4584</a><br>
&gt;&gt; Buglink: <a href=3D"https://redhat.atlassian.net/browse/RHEL-25066=
2" rel=3D"noreferrer" target=3D"_blank">https://redhat.atlassian.net/browse=
/RHEL-250662</a><br>
&gt;&gt; Fixes: 374f4676788c (&quot;qga: Fix VSS provider GetSnapshotProper=
ties return value&quot;)<br>
&gt;&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;<br>
&gt;&gt; ---<br>
&gt;&gt; v2:<br>
&gt;&gt;=C2=A0 - fill the required VSS_SNAPSHOT_PROP fields<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 qga/vss-win32/install.cpp=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 qga/vss-win32/provider.cpp=C2=A0 | 200 +++++++++++++++++++++=
++++++++++++++-<br>
&gt;&gt;=C2=A0 qga/vss-win32/requester.cpp |=C2=A0 26 +++++<br>
&gt;&gt;=C2=A0 3 files changed, 226 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp=
<br>
&gt;&gt; index 09d94edd4f53..3b58dc840520 100644<br>
&gt;&gt; --- a/qga/vss-win32/install.cpp<br>
&gt;&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt;&gt; @@ -331,6 +331,7 @@ STDAPI COMRegister(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;Authentication&quot=
;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short(6)));=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;AuthenticationCapab=
ility&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;ImpersonationLevel&=
quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<br>
&gt;&gt; +=C2=A0 =C2=A0 /* NT-service-hosted apps have ConcurrentApps=3D1 e=
nforced */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(pApps-&gt;SaveChanges(&amp;n));<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* The app should be deleted if something fail=
s after SaveChanges */<br>
&gt;&gt; diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.c=
pp<br>
&gt;&gt; index 1c8eb236e57f..bbc30dd57d85 100644<br>
&gt;&gt; --- a/qga/vss-win32/provider.cpp<br>
&gt;&gt; +++ b/qga/vss-win32/provider.cpp<br>
&gt;&gt; @@ -11,6 +11,11 @@<br>
&gt;&gt;=C2=A0 =C2=A0*/<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +#include &lt;vector&gt;<br>
&gt;&gt; +#include &lt;algorithm&gt;<br>
&gt;&gt; +#include &lt;string&gt;<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 #include &quot;vss-common.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;vss-debug.h&quot;<br>
&gt;&gt;=C2=A0 #ifdef HAVE_VSS_SDK<br>
&gt;&gt; @@ -138,6 +143,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEn=
umObject **ppenum)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return E_NOTIMPL;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +static VSS_PWSZ qga_vss_strdup(const WCHAR *value)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 size_t len =3D (wcslen(value) + 1) * sizeof(WCHAR);=
<br>
&gt;&gt; +=C2=A0 =C2=A0 VSS_PWSZ str =3D (VSS_PWSZ)CoTaskMemAlloc(len);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (str) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(str, value, len);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 return str;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static VSS_PWSZ qga_vss_strdup(const std::wstring &amp;value)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return qga_vss_strdup(value.c_str());<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static VSS_TIMESTAMP qga_vss_timestamp(void)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 FILETIME ft;<br>
&gt;&gt; +=C2=A0 =C2=A0 ULARGE_INTEGER value;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 GetSystemTimeAsFileTime(&amp;ft);<br>
&gt;&gt; +=C2=A0 =C2=A0 value.LowPart =3D ft.dwLowDateTime;<br>
&gt;&gt; +=C2=A0 =C2=A0 value.HighPart =3D ft.dwHighDateTime;<br>
&gt;&gt; +=C2=A0 =C2=A0 return value.QuadPart;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +/* Registry of the snapshot IDs for this provider */<br>
&gt;&gt; +class QGAVssSnapshotRegistry<br>
&gt;&gt; +{<br>
&gt;&gt; +public:<br>
&gt;&gt; +=C2=A0 =C2=A0 bool Track(VSS_ID set_id, VSS_ID snapshot_id,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_PWSZ v=
olume_name, LONG context);<br>
&gt;&gt; +=C2=A0 =C2=A0 HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPS=
HOT_PROP *prop) const;<br>
&gt;&gt; +=C2=A0 =C2=A0 LONG RemoveSet(VSS_ID set_id); /* returns how many =
were removed */<br>
&gt;&gt; +=C2=A0 =C2=A0 bool Remove(VSS_ID snapshot_id);<br>
&gt;&gt; +<br>
&gt;&gt; +private:<br>
&gt;&gt; +=C2=A0 =C2=A0 struct Entry {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID set_id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID snapshot_id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 std::wstring volume_name;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG context;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_TIMESTAMP timestamp;<br>
&gt;&gt; +=C2=A0 =C2=A0 };<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 std::vector&lt;Entry&gt; m_entries;<br>
&gt;&gt; +=C2=A0 =C2=A0 mutable SRWLOCK m_lock =3D SRWLOCK_INIT;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static QGAVssSnapshotRegistry qga_vss_registry;<br>
&gt;&gt; +<br>
&gt;&gt; +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot=
_id,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_PWSZ volu=
me_name, LONG context)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 bool ok;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 try {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.push_back(Entry { set_id, s=
napshot_id, volume_name,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context, qga=
_vss_timestamp() });<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D true;<br>
&gt;&gt; +=C2=A0 =C2=A0 } catch (...) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D false;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 return ok;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 VSS_SNAPSHOT_PROP *prop) const<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 HRESULT hr =3D S_OK;<br>
&gt;&gt; +=C2=A0 =C2=A0 VSS_PWSZ device =3D NULL, original =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 VSS_PWSZ originating =3D NULL, service =3D NULL;<br=
>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockShared(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin(), m_entri=
es.end(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.sn=
apshot_id, snapshot_id);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; +=C2=A0 =C2=A0 if (it =3D=3D m_entries.end()) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D VSS_E_OBJECT_NOT_FOUND;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const Entry &amp;e =3D *it;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR machine[256] =3D L&quot;&quot;;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD machine_size =3D ARRAYSIZE(mach=
ine);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!GetComputerNameExW(ComputerNameD=
nsFullyQualified, machine,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;machine_size)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *machine =3D L&#39;\0&#=
39;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device =3D qga_vss_strdup(L&quot;&quo=
t;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 original =3D qga_vss_strdup(e.volume_=
name);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 originating =3D qga_vss_strdup(machin=
e);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 service =3D qga_vss_strdup(machine);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!device || !original || !originat=
ing || !service) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_OUTOFMEMORY;<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(prop, 0, sizeof(*prop));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotId =3D e.snapshot_=
id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotSetId =3D e.set_id=
;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotsCount =3D std::c=
ount_if(m_entries.begin(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.end(), [&amp;=
](const Entry &amp;o) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return Is=
EqualGUID(o.set_id, e.set_id);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszSnapshotDeviceObject =
=3D device;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginalVolumeName =3D=
 original;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginatingMachine =3D=
 originating;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszServiceMachine =3D ser=
vice;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_ProviderId =3D g_gProvider=
Id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotAttributes =3D e.=
context;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_tsCreationTimestamp =3D e.=
timestamp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_eStatus =3D VSS_SS_CREATED=
;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device =3D original =3D originating =
=3D service =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +out:<br>
&gt;&gt; +=C2=A0 =C2=A0 CoTaskMemFree(device);<br>
&gt;&gt; +=C2=A0 =C2=A0 CoTaskMemFree(original);<br>
&gt;&gt; +=C2=A0 =C2=A0 CoTaskMemFree(originating);<br>
&gt;&gt; +=C2=A0 =C2=A0 CoTaskMemFree(service);<br>
&gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockShared(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 return hr;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 LONG removed;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::remove_if(m_entries.begin(), m_ent=
ries.end(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.se=
t_id, set_id);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; +=C2=A0 =C2=A0 removed =3D m_entries.end() - it;<br>
&gt;&gt; +=C2=A0 =C2=A0 m_entries.erase(it, m_entries.end());<br>
&gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 return removed;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 bool found;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin(), m_entri=
es.end(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.sn=
apshot_id, snapshot_id);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; +=C2=A0 =C2=A0 found =3D it !=3D m_entries.end();<br>
&gt;&gt; +=C2=A0 =C2=A0 if (found) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.erase(it);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; +=C2=A0 =C2=A0 return found;<br>
&gt;&gt; +}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 /* QGAVssProvider */<br>
&gt;&gt;<br>
&gt;&gt; @@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG =
lContext)<br>
&gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)<b=
r>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; -=C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; +=C2=A0 =C2=A0 return qga_vss_registry.GetProperties(SnapshotId, p=
Prop);<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::Query(<br>
&gt;&gt; @@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots=
(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSource=
ObjectType,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 BOOL bForceDelete, LONG *plDeletedSnapshots, V=
SS_ID *pNondeletedSnapshotID)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 LONG deleted =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 switch (eSourceObjectType) {<br>
&gt;&gt; +=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qga_vss_registry.Remove(SourceObj=
ectId)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D 1;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; +=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT_SET:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D qga_vss_registry.RemoveSe=
t(SourceObjectId);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (deleted &gt; 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *plDeletedSnapshots =3D deleted;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pNondeletedSnapshotID =3D GUID_NULL;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 *plDeletedSnapshots =3D 0;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 *pNondeletedSnapshotID =3D SourceObjectId;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;<br>
&gt;<br>
&gt; return VSS_E_OBJECT_NOT_FOUND in this case looks more correct<br>
<br>
Possibly, but I didn&#39;t want to change the existing behaviour here<br>
without good reasons (it was fixed in 2014 by commit<br>
d9e1f574cb6eac0a3a2f97b67d2e7a3ad9c1dc95).<br>
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; @@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSna=
pshot(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SnapshotSetId, VSS_ID SnapshotId,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_PWSZ pwszVolumeName, LONG lNewContext)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!pwszVolumeName) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_INVALIDARG;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!qga_vss_registry.Track(SnapshotSetId, Snapshot=
Id,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwszVolumeName, lNewContex=
t)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_OUTOFMEMORY;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; @@ -411,6 +608,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitS=
napshots(VSS_ID SnapshotSetId)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID Snapshot=
SetId)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 qga_vss_registry.RemoveSet(SnapshotSetId);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester=
.cpp<br>
&gt;&gt; index 1b0155c691ef..565eefcfb283 100644<br>
&gt;&gt; --- a/qga/vss-win32/requester.cpp<br>
&gt;&gt; +++ b/qga/vss-win32/requester.cpp<br>
&gt;&gt; @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnaps=
hotProperties;<br>
&gt;&gt;=C2=A0 static struct QGAVSSContext {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 IVssBackupComponents *pVssbc;=C2=A0 /* VSS req=
uester interface */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 IVssAsync *pAsyncSnapshot;=C2=A0 =C2=A0 =C2=A0=
/* async info of VSS snapshot operation */<br>
&gt;&gt; +=C2=A0 =C2=A0 VSS_ID idSnapshotSet;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* snapshot set created for this cycle */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventFrozen;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* notify fs/writer freeze from provider */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventThaw;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* request provider to thaw */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventTimeout;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* notify timeout in provider */<br>
&gt;&gt; @@ -116,6 +117,7 @@ static void requester_cleanup(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc-&gt;Release();<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc =3D NULL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D GUID_NULL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 vss_ctx.cFrozenVols =3D 0;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt; @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void *mou=
ntpoints, ErrorSet *errset)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &quot;failed=
 to start snapshot set&quot;);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D guidSnapshotSet;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (mountpoints) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PWCHAR volume_name_wchar;<br>
&gt;&gt; @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *moun=
tpints, ErrorSet *errset)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &quot;failed=
 to do snapshot set&quot;);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 /*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* The snapshot set is created in VSS_CTX_APP_=
ROLLBACK context, so<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* it is persistent: if it was committed, VSS =
keeps it (and keeps<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* querying providers about it) until it is ex=
plicitly deleted. The<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* freeze/thaw cycle is over whatever the outc=
ome above, so delete<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* it now. Failure is not fatal here, only log=
 it.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG lDeletedSnapshots =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID idNonDeletedSnapshot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 HRESULT hrDelete;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hrDelete =3D vss_ctx.pVssbc-&gt;Delet=
eSnapshots(vss_ctx.idSnapshotSet,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_OBJECT_SNAPSHOT_SET,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRUE,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;lDeletedSnapshots,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;idNonDeletedSnapshot);<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hrDelete)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;failed =
to delete snapshot set after thaw,&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot; hr=3D0x%08lx&quot;, hrDelete);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (err_is_set(errset)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc-&gt;AbortBackup()=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; --<br>
&gt;&gt; 2.56.0.116.g6de20f6092dc<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--000000000000975ac2065ee54957--


