Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2WtkqaM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=l/x+i//M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLibU-0007lo-0c; Tue, 27 Oct 2026 10:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLib6-0007iV-Ao
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLib0-00080w-4n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793112973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IP7dk3zor71D5uwggZeFlC6vVjb2midJ0siR3QL35ec=;
 b=e2WtkqaM+x7AyvtYOmZVzjZWVxIyXk5PIgChOrKBGHIaKRR5EnjJYaKpYWUEbwFvbpMyNE
 a/Dj5YLEeoYWcf12ITWh9iibYrk6N5zORzbvijGi8GlPOVYDBfLPRsVCoZALxblg8yFhXD
 +nobgOIBHqFp09EWrTOFUGISia4InME=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-6EkslBgcN3minsVPvrz6YA-1; Tue, 27 Oct 2026 10:56:05 -0400
X-MC-Unique: 6EkslBgcN3minsVPvrz6YA-1
X-Mimecast-MFC-AGG-ID: 6EkslBgcN3minsVPvrz6YA_1793112964
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so2673844eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112964; cv=none;
 d=google.com; s=arc-20260327;
 b=EJyrYcJw65MT01ROQQ6g6GWE7390jvbNCOV0WvjY1u1CWQC5V0CmVcaQrVNQbul9VB
 wmGMIZfQ0zXuWtzLA1ZdXhF8WG+YY6nlYn5Ckuqa2+K0EhEWDvHHT2z6wP+MEnq1Log5
 ziKLgVdQqmRZFd0VvA4FMRIthEpJbFtcQ+lsz+iKgHf/ebtEA8/omSjGF1YdzT+vYl4L
 wmsmmz+saT65P5OnBff9C7RHPGRCZbfAIev1VvuraVrXzzivE+e4GdIAaE9mIcsus6QG
 R+YYOdNQwpZtnefji2aZ26GljUMolyvdgtBpvi6/bGa4AXDxsDVHvWjXAaKxQ0lgOAt1
 RXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IP7dk3zor71D5uwggZeFlC6vVjb2midJ0siR3QL35ec=;
 fh=7+TMJ2Yg423AStOeItkvWjwS2P6hzHITMCZ8X7RwWFE=;
 b=nwCi9bOyrFZknbpa3WYiogsA6TUTpkEBM1TopzAQhpo+HABiOkoG7/FsvIBHuPCLsT
 k2XOMGktMJM7qNiyY/RJktN4l7WaH7p4n2OBzduEgCa5UIDMXiTdZW/Gm0I9H+slB6Qi
 CQ6D7P5gpzPel1nLqd6l7ozSttDyG11MPxfcFFhXshuv+rcka+YV7IgopU6byStIPhC5
 9WTCWI/rc579yXm3mNyX1EEN+kOhxOah1qh/O5zu0VnVMvLpEDs+poNXPoYAgmacQd8p
 XMpHzEBRftgptuUsl0Kml2wvdmMF/p4dSkyFuGanZ03SuFU5VlWxG0XvEfQW1eWdsfM9
 kmiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793112964; x=1793717764; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IP7dk3zor71D5uwggZeFlC6vVjb2midJ0siR3QL35ec=;
 b=l/x+i//M/1sT0nmzat05uTk8T/AQrvpNZ3kiKvFWWbwAeAqXPQyD0zYMw46hF4QqsS
 HlqYTRDQAFntn1OtqTkoqGz2nCi1BH1L92BAEss69p0oFgBGZ5So/SmWbsw/yWuydsIj
 YIuqt9EpPD2QqAW5f3LKnh9JUSvApJbEEHtdENfxboy9B4PV8PYTAZBFm1WE9wfO+o5D
 uubmde+fb1ORtfcW3Z1rJsnIAoOmecZAx8AwHvxfD5iTJ/9WUCcBF0Ccf1hS0n2fppHi
 nHM79D8O3TUIq8IZYlXAIFl42Scc3SN3mAsKQFkF3xEVtoBKwd1AH/KBaTpQwA1jUHvg
 ihbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112964; x=1793717764;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IP7dk3zor71D5uwggZeFlC6vVjb2midJ0siR3QL35ec=;
 b=ychGeZGomUb4DLKxfQTtK73+hULsBstcNJjFcadUIMKYdIjUmIh9uKWIgIESV+x57s
 qkfilXkWq9gfkM6a2wpzmh2uP/JleunfxhrDfReuKa/a7kjThO2xYllnbotcGPU3CG2M
 gOG4Ks9CMgENMTq/zGkNqO+nbU15VUUS8GltSHp6nJyW2xrp8xYhHbvQ1gqjgs3oPWZF
 R2RcRfYw58y0yzOrl3On05C1XBt2lOo+YTASbgcft7n8w+8xCesCUvHwEEw1iyzGdc8g
 LaD/iuHEubxgDt7s7OCBfPBGBFTAKKwU8cSmbpQSJmQD+jqZ5DDRVnzmo+sEDPX9tT52
 O3QQ==
X-Gm-Message-State: AFq9FYI25TgXigg+J7AZVpUqX0chAdTq74vV5cAdvj+K7vIkjC3vOmev
 +Rc0wDgASdH6GH8VVFpi9dX9KzabgGrpT2q3j9y15vj1dr7xohML/w25aI1MUHqRiQgn8Q9S5PZ
 gFSSMKLIxQxc/knguwSoFTYkQOfnC0c4+pU2Iay8vNnZGcLWZ3K2jDqmeDAL70IVV3ieYP2kHXI
 1Lhb3strMuDRApTvY1+vVNHxgbI1cySNg=
X-Gm-Gg: AYBFou0hSJeQJmHDNP61Vo9pXHBs9kxLr4NYFVF7Ovllm0wOPfwTU5sWJNDINoEpykt
 09O6K6crXNxZTBem4AvBJZ3HhwFTziYD2iUnuxkrre3YgpuxY36Bn6rNGl7G7J0UnArMAqakjUX
 Vb/SBiuGnCxsiL4KagP01fzRfECwLxS9xG+i7bz/c8p3V2xax+C8lmVU8Fp4WAA47733ZRUIb7s
 /34TD9BkxbO7pChIQ==
X-Received: by 2002:a05:693c:42dc:b0:351:4866:255c with SMTP id
 5a478bee46e88-369e84cd06bmr15009842eec.32.1793112964054; 
 Tue, 27 Oct 2026 07:56:04 -0700 (PDT)
X-Received: by 2002:a05:693c:42dc:b0:351:4866:255c with SMTP id
 5a478bee46e88-369e84cd06bmr15009800eec.32.1793112963201; Tue, 27 Oct 2026
 07:56:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133049.2522944-2-marcandre.lureau@redhat.com>
 <CAPMcbCr=gsBr9Wnw1rK+4HEcTwdCxOinKqeC=0yE1ZUa-hwHWw@mail.gmail.com>
 <CAJ+F1CLHzMuGW_m9kkU2r3YW-Vv1eQAYQ3YkJSfKm_QsoZbQWQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLHzMuGW_m9kkU2r3YW-Vv1eQAYQ3YkJSfKm_QsoZbQWQ@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 27 Oct 2026 16:55:51 +0200
X-Gm-Features: AclHuK8sY08mT9WMd9OWeNq7IrVJ1Pa3x7ogMp58NQ_zymBSAT-P3UMkPbjTyRU
Message-ID: <CAPMcbCqG9sEHaeEeiPV7TnN4fVbKdKsUCXTXvejdArPjXEkzRg@mail.gmail.com>
Subject: Re: [PATCH] qga/vss: fix provider handling of snapshots
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000036d28a065ed3a543"
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
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000036d28a065ed3a543
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redh=
at.com>
> wrote:
> >
> >
> >
> > On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM <marcandre.lureau@redhat.com> w=
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
> >> received in BeginPrepareSnapshot(), return their
> >> (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND for anything
> >> else.
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
> >>  qga/vss-win32/install.cpp   |   1 +
> >>  qga/vss-win32/provider.cpp  | 153 +++++++++++++++++++++++++++++++++++=
-
> >>  qga/vss-win32/requester.cpp |  26 ++++++
> >>  3 files changed, 179 insertions(+), 1 deletion(-)
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
> >> index 1c8eb236e57f..ad2f3ee763e6 100644
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
> >> @@ -138,6 +143,123 @@ STDMETHODIMP
> CQGAVSSEnumObject::Clone(IVssEnumObject **ppenum)
> >>      return E_NOTIMPL;
> >>  }
> >>
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
> >> +                                    context });
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
> >> +        size_t len =3D (e.volume_name.size() + 1) * sizeof(WCHAR);
> >> +        VSS_PWSZ volume =3D (VSS_PWSZ)CoTaskMemAlloc(len);
> >
> >
> > I'm afraid of this part. We allocate memory but don't call CoTaskMemFre=
e.
> > This function is called from IVssBackupComponents::GetSnapshotPropertie=
s
> > From
> https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-=
ivssbackupcomponents-getsnapshotproperties
> > "When the structure is no longer needed, the software provider is
> responsible for freeing these strings by calling the
> VssFreeSnapshotProperties function."
> >
> > So we allocate memory but don't free it with VssFreeSnapshotProperties
> or CoTaskMemFree.
>
> I also wondered, but this is apparently what is expected:
>
>
> https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/content/vs=
s/ns-vss-vss_object_prop.md
>
>
> A requester obtains VSS_OBJECT_PROP structures by using
> IVssEnumObject::Next to iterate over the list of objects returned by a
> call to IVssBackupComponents::Query.
>
> Yes, but there is nothing about cleaning memory



> As its members are filled by a COM interface, prior to deleting the
> property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the
> memory they contain must be released by calling CoTaskMemFree for
> every string and byte array value contained in each structure.
>
> In the case of VSS_SNAPSHOT_PROP, this can be done manually, or the
> utility function VssFreeSnapshotProperties can be used.
>
> but we don't store the pointers


>
> >
> >> +
> >> +        if (!volume) {
> >> +            hr =3D E_OUTOFMEMORY;
> >> +            goto out;
> >> +        }
> >> +        memcpy(volume, e.volume_name.c_str(), len);
> >> +
> >> +        /* not a real snapshot: no device object, exposure or
> timestamp */
> >> +        memset(prop, 0, sizeof(*prop));
> >> +        prop->m_SnapshotId =3D e.snapshot_id;
> >> +        prop->m_SnapshotSetId =3D e.set_id;
> >> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
> >> +            m_entries.end(), [&](const Entry &o) {
> >> +                return IsEqualGUID(o.set_id, e.set_id);
> >> +            });
> >> +        prop->m_pwszOriginalVolumeName =3D volume;
> >> +        prop->m_ProviderId =3D g_gProviderId;
> >> +        prop->m_lSnapshotAttributes =3D e.context;
> >> +        prop->m_eStatus =3D VSS_SS_CREATED;
> >> +    }
> >> +
> >> +out:
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
> >> @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG
> lContext)
> >>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
> >>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
> >>  {
> >> -    return S_OK;
> >> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
> >>  }
> >>
> >>  STDMETHODIMP CQGAVssProvider::Query(
> >> @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
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
> >> @@ -295,6 +438,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapsho=
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
> >> @@ -411,6 +561,7 @@ STDMETHODIMP
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

--00000000000036d28a065ed3a543
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><br></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Marc-Andr=C3=A9 Lur=
eau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi<br>
<br>
On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"m=
ailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM &lt;<a href=3D"mailto:marcandr=
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
&gt;&gt; received in BeginPrepareSnapshot(), return their<br>
&gt;&gt; (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND for anythi=
ng<br>
&gt;&gt; else.<br>
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
&gt;&gt;=C2=A0 qga/vss-win32/install.cpp=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 qga/vss-win32/provider.cpp=C2=A0 | 153 +++++++++++++++++++++=
++++++++++++++-<br>
&gt;&gt;=C2=A0 qga/vss-win32/requester.cpp |=C2=A0 26 ++++++<br>
&gt;&gt;=C2=A0 3 files changed, 179 insertions(+), 1 deletion(-)<br>
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
&gt;&gt; index 1c8eb236e57f..ad2f3ee763e6 100644<br>
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
&gt;&gt; @@ -138,6 +143,123 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEn=
umObject **ppenum)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return E_NOTIMPL;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context });<=
br>
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
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len =3D (e.volume_name.size() =
+ 1) * sizeof(WCHAR);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_PWSZ volume =3D (VSS_PWSZ)CoTaskM=
emAlloc(len);<br>
&gt;<br>
&gt;<br>
&gt; I&#39;m afraid of this part. We allocate memory but don&#39;t call CoT=
askMemFree.<br>
&gt; This function is called from IVssBackupComponents::GetSnapshotProperti=
es<br>
&gt; From <a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/vs=
backup/nf-vsbackup-ivssbackupcomponents-getsnapshotproperties" rel=3D"noref=
errer" target=3D"_blank">https://learn.microsoft.com/en-us/windows/win32/ap=
i/vsbackup/nf-vsbackup-ivssbackupcomponents-getsnapshotproperties</a><br>
&gt; &quot;When the structure is no longer needed, the software provider is=
 responsible for freeing these strings by calling the VssFreeSnapshotProper=
ties function.&quot;<br>
&gt;<br>
&gt; So we allocate memory but don&#39;t free it with VssFreeSnapshotProper=
ties or CoTaskMemFree.<br>
<br>
I also wondered, but this is apparently what is expected:<br>
<br>
<a href=3D"https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/c=
ontent/vss/ns-vss-vss_object_prop.md" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/content/vss/=
ns-vss-vss_object_prop.md</a><br>
<br>
<br>
A requester obtains VSS_OBJECT_PROP structures by using<br>
IVssEnumObject::Next to iterate over the list of objects returned by a<br>
call to IVssBackupComponents::Query.<br>
<br></blockquote><div>Yes, but there is nothing about cleaning memory</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
As its members are filled by a COM interface, prior to deleting the<br>
property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the<br>
memory they contain must be released by calling CoTaskMemFree for<br>
every string and byte array value contained in each structure.<br>
<br>
In the case of VSS_SNAPSHOT_PROP, this can be done manually, or the<br>
utility function VssFreeSnapshotProperties can be used.<br>
<br></blockquote><div>but we don&#39;t store the pointers=C2=A0</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!volume) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_OUTOFMEMORY;<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(volume, e.volume_name.c_str(),=
 len);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* not a real snapshot: no device obj=
ect, exposure or timestamp */<br>
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
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginalVolumeName =3D=
 volume;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_ProviderId =3D g_gProvider=
Id;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotAttributes =3D e.=
context;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_eStatus =3D VSS_SS_CREATED=
;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +out:<br>
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
&gt;&gt; @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG =
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
&gt;&gt; @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots=
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
&gt;&gt; @@ -295,6 +438,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSna=
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
&gt;&gt; @@ -411,6 +561,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitS=
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
</blockquote></div></div>

--00000000000036d28a065ed3a543--


