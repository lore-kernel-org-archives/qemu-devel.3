Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F407606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XWLkHfay;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zse9xKw8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyhu-0004I0-Lt; Wed, 28 Oct 2026 04:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLyho-0004HX-4H
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLyhj-0006Eu-Sh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793174894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCveW2K+4yGZNw3KPDEgaIKDNImDAB6tkBOa8VGUqUk=;
 b=XWLkHfayyUdqWU3C9XWigWLgkjQGvXQZdVJUvsudydh8iwtlGHqu+TfUz2pCkRDbK+bPyd
 T93BX5G5SHsz/aQx1XMggwDhD0lHolnzfmPkEQd90/LYQjzscHAbUk7Ch/f4b7a47+7uta
 MAWxbEbPYhGXLP4BZpT11qRk7C91VA8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-qfcJTujWOxeKy80PuoSXrA-1; Wed, 28 Oct 2026 04:08:12 -0400
X-MC-Unique: qfcJTujWOxeKy80PuoSXrA-1
X-Mimecast-MFC-AGG-ID: qfcJTujWOxeKy80PuoSXrA_1793174892
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c7a26f892so15635046d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793174892; cv=none;
 d=google.com; s=arc-20260327;
 b=fPqlmaT+jrDSA4Bxecbzhc3DCgLO6ierhNhO75vyaP1Gmq4ZUBTuF3W4q2tgK1xoVd
 L5CeBYFJ7h0CQh4KWhjKn6g1tqNpyus9E5ruomBHnoWcr8g3BYiuMGtbjUQucBk3K6LA
 VorODBXpUw77WtUySbw4Y+Q3wlb5rsUEh/VYHjtI915oNuAp0r8Q7iQFr9rad93g0mXm
 eUbr7eCU21RXqn1IWq4rYSKPhztH8xFmUj1bBV+kKSVDKMi2eoke54kyBtV5qqtyFiyl
 +Adq8Lu+qmg5lG2GWRdZvJWO36ER6YpjriSBDbMdiHjYsT/gLiDMdv72Ug9JxGhQBKFt
 QT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GCveW2K+4yGZNw3KPDEgaIKDNImDAB6tkBOa8VGUqUk=;
 fh=x6waOvhzfyYGfXicPW1eKcT7M4QC9why3DAgFGWVqWU=;
 b=hkR16m0OPyQ8ZpT8YnHKC7XdbH5gwevPkAz2qFyK/utOxUUJIEUusB9n3IlRMU6/hE
 +ejvJD8MoEtVx0I2yc8N3jEVX+bVrBPZhAOMPieF4ZmtBbmQve4Agr7LBKzZnmaqi3p5
 0/MpeiElkhdACuNP3laBKUtplqK7P0pnlieb0ZkAB1YFSGSYzX2l0eI0xHHyqqWGEwZL
 j/y50l9A/YFC15WpvhUXpJ6/uiKtHXt7G+EpwUybl4/ft893GYQdP2Zy3/bAAy7QdtrS
 LFNeKyysZm3uxdTjRmHYDuGP5yR9/dtED3rRrlOX3Lp24CZP4XhkaSczdNAmFBZYJJXa
 fSJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793174892; x=1793779692; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GCveW2K+4yGZNw3KPDEgaIKDNImDAB6tkBOa8VGUqUk=;
 b=Zse9xKw86QRGE+nmIweDgcAKd4HBZtf4ShN/h/tb+lRiYkby47jsp8tNYZQ1afkAsY
 AhjFAUVhJ8BZzVu/DZlBg3KHy7kWNceYH9OxeDkdFSqt3c91vL8zQ5mDv5k+o2ohj6bZ
 /sLuzy/K+AiRk+nr/xZu+F+Nm/mTd1xJku0L7uVn+Agw2YM+GG4vTcLML6IO5K3+MLX8
 qtrIbjLnEIERt8CplTjlKn2J3Vtw0uB45H7lTkW7GVqEKgTfIdC2+FQ+Ldg93IXJTkJH
 cUj9ARZq3uWRAJubmmyVA/HWlF0DQU7G8aPB0zgo01tQigGNjiwaQS5LHrtYlBh9cBQG
 jYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793174892; x=1793779692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GCveW2K+4yGZNw3KPDEgaIKDNImDAB6tkBOa8VGUqUk=;
 b=QCKt1Grm+UQegtdHjBhSlzSZ9FrpDQo5aiR5IsqDKxAFJczbO6202Eh+PQIOF2hgIe
 aNkW3suOVNDs/9xidRRx7ETWpBO6vOYLe//faKqvML0H38xxNuU+a5bHlTQbVVQryRvj
 6TdmSN0+rWdys1c5OtSYcN6kLibYyguxrsNhR6kl+seA2U/8a8p56CuGYtMPB3FquWRU
 IVZr+e38BIHKV5HKsngRiUYUfVrQsmcgtDCIxZ+TeI7BoxdlH6Z+/FFa0EDC5KM06kPZ
 QXJ/lw7xoDjGK+u91wAPWmchBz+dwaETcxaCu7qBo8JFYZWuz+ysCB9rXo6jZB7DIUgG
 XJJw==
X-Gm-Message-State: AFq9FYLU0leUAOFKZMr6hFLIHj/8l4K4fc+YTtITkioADWShOC5LHn8U
 hn+8jouWXwB+HFIGVmGU5zeup2KadkaKcyukHs00YRecEyw13Vhocu5CIryYiX9DSl7H2zxTAED
 ALctESwE9AaLrhJ1ZWfUdpqnNHad2O7Kd0h3Ualvq0CRJzGa0T1W5T7/7jpEWMK7/domnBXHfFm
 pmJ/MKrQkxD3X0cO1H+icySBAPiTU4pr4x/5T2oUD2xg==
X-Gm-Gg: AYBFou0Rx0H+6yXog1oku+Bt74C5v97/SE6MDXMs9YXkCyPwnFyrw8rRBghLxzRqEQ6
 KhRrydY3ov7EpQU0q7AEBfSX2c0gzKPxIEdTVeCgBRxqFWRjrCp8t7M902grbayk0/+LO0yMBy/
 b1ALz8OVlKallkGibvrHMVuGYGa3auJVd3t4YxciEz6n8YSowWbjwMs40o2u23CoMjBP0cAwAau
 /ZGbLEZ3AwjJrfhOoQ=
X-Received: by 2002:a05:6214:301a:b0:91b:c9d8:3ede with SMTP id
 6a1803df08f44-91c7ce73f91mr22513276d6.3.1793174891555; 
 Wed, 28 Oct 2026 01:08:11 -0700 (PDT)
X-Received: by 2002:a05:6214:301a:b0:91b:c9d8:3ede with SMTP id
 6a1803df08f44-91c7ce73f91mr22513016d6.3.1793174890882; Wed, 28 Oct 2026
 01:08:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027160606.2668607-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261027160606.2668607-2-marcandre.lureau@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 10:07:59 +0200
X-Gm-Features: AclHuK-lr1ythwJ1AoT5QWQ-AE9Gb72TZkkl85vKG_OwmmAn_9qOnoM8HTDLrzM
Message-ID: <CAPMcbCpY1Re_edBo-S1TqguOU3HpjpT1TVhX1-stw0yPTvh=pg@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss: fix provider handling of snapshots
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000064576a065ee210b8"
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

--00000000000064576a065ee210b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 6:06=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Since commit 374f4676788c, the provider's GetSnapshotProperties()
> returns S_OK for any snapshot ID without filling in the properties.  VSS
> consults every registered provider when a requester looks up a snapshot,
> so lookups of snapshots owned by other providers now succeed with an
> all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.
> Veeam: "Original volume name is not specified for the shadow (shadow
> volume id: '{00000000-0000-0000-0000-000000000000}')".
>
> Simply reverting is not an option: 374f4676788c switched to S_OK because
> returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's own
> snapshot sets. The provider must answer for its own snapshots only. It
> does not create real shadow copies, but it does take part in the
> snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot IDs
> received in BeginPrepareSnapshot(), return their required properties,
> and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every required
> VSS_SNAPSHOT_PROP member except the exposed name and path, which are
> optional. The snapshot device object is an empty string because the
> host-side snapshot has no guest-visible device.
>
> Entries are dropped when VSS deletes the snapshots or the set, or when
> the set is aborted (AbortSnapshots()).
>
> COM+ may hand out several CQGAVssProvider instances (and serve several
> client processes), so this registry is module-global. It is per-process
> by design and safe because the COM+ application is hosted by a single NT
> service (see CreateServiceForApplication() in install.cpp): COM+ forbids
> pooling and recycling for service-hosted applications, so exactly one
> surrogate process ever hosts the provider.
>
> On the requester side, the snapshot set is created in the persistent
> VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
> cycle and may keep querying providers about it. The provider registry
> does not outlive the cycle (requester_thaw() stops the hosting service,
> and the provider process with it), so later queries would get "not
> found" for a set VSS still believes exists. Make requester_thaw() delete
> the snapshot set explicitly at the end of the cycle, whatever its
> outcome (including BackupComplete() failure and aborted snapshot sets).
> A failure to delete is only logged, since the guest filesystems have
> already been thawed.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
> Buglink: https://redhat.atlassian.net/browse/RHEL-250662
> Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties return
> value")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>  - fill the required VSS_SNAPSHOT_PROP fields
> ---
>  qga/vss-win32/install.cpp   |   1 +
>  qga/vss-win32/provider.cpp  | 200 +++++++++++++++++++++++++++++++++++-
>  qga/vss-win32/requester.cpp |  26 +++++
>  3 files changed, 226 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 09d94edd4f53..3b58dc840520 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -331,6 +331,7 @@ STDAPI COMRegister(void)
>      chk(put_Value(pObj, L"Authentication",                 short(6)));
>      chk(put_Value(pObj, L"AuthenticationCapability",       short(2)));
>      chk(put_Value(pObj, L"ImpersonationLevel",             short(2)));
> +    /* NT-service-hosted apps have ConcurrentApps=3D1 enforced */
>      chk(pApps->SaveChanges(&n));
>
>      /* The app should be deleted if something fails after SaveChanges */
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 1c8eb236e57f..bbc30dd57d85 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -11,6 +11,11 @@
>   */
>
>  #include "qemu/osdep.h"
> +
> +#include <vector>
> +#include <algorithm>
> +#include <string>
> +
>  #include "vss-common.h"
>  #include "vss-debug.h"
>  #ifdef HAVE_VSS_SDK
> @@ -138,6 +143,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObjec=
t
> **ppenum)
>      return E_NOTIMPL;
>  }
>
> +static VSS_PWSZ qga_vss_strdup(const WCHAR *value)
> +{
> +    size_t len =3D (wcslen(value) + 1) * sizeof(WCHAR);
> +    VSS_PWSZ str =3D (VSS_PWSZ)CoTaskMemAlloc(len);
> +
> +    if (str) {
> +        memcpy(str, value, len);
> +    }
> +    return str;
> +}
> +
> +static VSS_PWSZ qga_vss_strdup(const std::wstring &value)
> +{
> +    return qga_vss_strdup(value.c_str());
> +}
> +
> +static VSS_TIMESTAMP qga_vss_timestamp(void)
> +{
> +    FILETIME ft;
> +    ULARGE_INTEGER value;
> +
> +    GetSystemTimeAsFileTime(&ft);
> +    value.LowPart =3D ft.dwLowDateTime;
> +    value.HighPart =3D ft.dwHighDateTime;
> +    return value.QuadPart;
> +}
> +
> +/* Registry of the snapshot IDs for this provider */
> +class QGAVssSnapshotRegistry
> +{
> +public:
> +    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
> +               VSS_PWSZ volume_name, LONG context);
> +    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP *prop)
> const;
> +    LONG RemoveSet(VSS_ID set_id); /* returns how many were removed */
> +    bool Remove(VSS_ID snapshot_id);
> +
> +private:
> +    struct Entry {
> +        VSS_ID set_id;
> +        VSS_ID snapshot_id;
> +        std::wstring volume_name;
> +        LONG context;
> +        VSS_TIMESTAMP timestamp;
> +    };
> +
> +    std::vector<Entry> m_entries;
> +    mutable SRWLOCK m_lock =3D SRWLOCK_INIT;
> +};
> +
> +static QGAVssSnapshotRegistry qga_vss_registry;
> +
> +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id,
> +                                   VSS_PWSZ volume_name, LONG context)
> +{
> +    bool ok;
> +
> +    AcquireSRWLockExclusive(&m_lock);
> +    try {
> +        m_entries.push_back(Entry { set_id, snapshot_id, volume_name,
> +                                    context, qga_vss_timestamp() });
> +        ok =3D true;
> +    } catch (...) {
> +        ok =3D false;
> +    }
> +    ReleaseSRWLockExclusive(&m_lock);
> +    return ok;
> +}
> +
> +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
> +                                              VSS_SNAPSHOT_PROP *prop)
> const
> +{
> +    HRESULT hr =3D S_OK;
> +    VSS_PWSZ device =3D NULL, original =3D NULL;
> +    VSS_PWSZ originating =3D NULL, service =3D NULL;
> +
> +    AcquireSRWLockShared(&m_lock);
> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> +        [&](const Entry &e) {
> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> +        });
> +    if (it =3D=3D m_entries.end()) {
> +        hr =3D VSS_E_OBJECT_NOT_FOUND;
> +        goto out;
> +    }
> +
> +    {
> +        const Entry &e =3D *it;
> +        WCHAR machine[256] =3D L"";
> +        DWORD machine_size =3D ARRAYSIZE(machine);
> +
> +        if (!GetComputerNameExW(ComputerNameDnsFullyQualified, machine,
> +                               &machine_size)) {
> +            *machine =3D L'\0';
> +        }
> +
> +        device =3D qga_vss_strdup(L"");
> +        original =3D qga_vss_strdup(e.volume_name);
> +        originating =3D qga_vss_strdup(machine);
> +        service =3D qga_vss_strdup(machine);
> +        if (!device || !original || !originating || !service) {
> +            hr =3D E_OUTOFMEMORY;
> +            goto out;
> +        }
> +
> +        memset(prop, 0, sizeof(*prop));
> +        prop->m_SnapshotId =3D e.snapshot_id;
> +        prop->m_SnapshotSetId =3D e.set_id;
> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
> +            m_entries.end(), [&](const Entry &o) {
> +                return IsEqualGUID(o.set_id, e.set_id);
> +            });
> +        prop->m_pwszSnapshotDeviceObject =3D device;
> +        prop->m_pwszOriginalVolumeName =3D original;
> +        prop->m_pwszOriginatingMachine =3D originating;
> +        prop->m_pwszServiceMachine =3D service;
> +        prop->m_ProviderId =3D g_gProviderId;
> +        prop->m_lSnapshotAttributes =3D e.context;
> +        prop->m_tsCreationTimestamp =3D e.timestamp;
> +        prop->m_eStatus =3D VSS_SS_CREATED;
> +
> +        device =3D original =3D originating =3D service =3D NULL;
> +    }
> +
> +out:
> +    CoTaskMemFree(device);
> +    CoTaskMemFree(original);
> +    CoTaskMemFree(originating);
> +    CoTaskMemFree(service);
> +    ReleaseSRWLockShared(&m_lock);
> +    return hr;
> +}
> +
> +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
> +{
> +    LONG removed;
> +
> +    AcquireSRWLockExclusive(&m_lock);
> +    auto it =3D std::remove_if(m_entries.begin(), m_entries.end(),
> +        [&](const Entry &e) {
> +            return IsEqualGUID(e.set_id, set_id);
> +        });
> +    removed =3D m_entries.end() - it;
> +    m_entries.erase(it, m_entries.end());
> +    ReleaseSRWLockExclusive(&m_lock);
> +    return removed;
> +}
> +
> +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
> +{
> +    bool found;
> +
> +    AcquireSRWLockExclusive(&m_lock);
> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> +        [&](const Entry &e) {
> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> +        });
> +    found =3D it !=3D m_entries.end();
> +    if (found) {
> +        m_entries.erase(it);
> +    }
> +    ReleaseSRWLockExclusive(&m_lock);
> +    return found;
> +}
>
>  /* QGAVssProvider */
>
> @@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContex=
t)
>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
>  {
> -    return S_OK;
> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
>  }
>
>  STDMETHODIMP CQGAVssProvider::Query(
> @@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
>      VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
>      BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID
> *pNondeletedSnapshotID)
>  {
> +    LONG deleted =3D 0;
> +
> +    switch (eSourceObjectType) {
> +    case VSS_OBJECT_SNAPSHOT:
> +        if (qga_vss_registry.Remove(SourceObjectId)) {
> +            deleted =3D 1;
> +        }
> +        break;
> +    case VSS_OBJECT_SNAPSHOT_SET:
> +        deleted =3D qga_vss_registry.RemoveSet(SourceObjectId);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (deleted > 0) {
> +        *plDeletedSnapshots =3D deleted;
> +        *pNondeletedSnapshotID =3D GUID_NULL;
> +        return S_OK;
> +    }
> +
>      *plDeletedSnapshots =3D 0;
>      *pNondeletedSnapshotID =3D SourceObjectId;
>      return S_OK;
>

return VSS_E_OBJECT_NOT_FOUND in this case looks more correct


> @@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(
>      VSS_ID SnapshotSetId, VSS_ID SnapshotId,
>      VSS_PWSZ pwszVolumeName, LONG lNewContext)
>  {
> +    if (!pwszVolumeName) {
> +        return E_INVALIDARG;
> +    }
> +    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
> +                                pwszVolumeName, lNewContext)) {
> +        return E_OUTOFMEMORY;
> +    }
>      return S_OK;
>  }
>
> @@ -411,6 +608,7 @@ STDMETHODIMP
> CQGAVssProvider::PostFinalCommitSnapshots(VSS_ID SnapshotSetId)
>
>  STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
>  {
> +    qga_vss_registry.RemoveSet(SnapshotSetId);
>      return S_OK;
>  }
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 1b0155c691ef..565eefcfb283 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties
> pVssFreeSnapshotProperties;
>  static struct QGAVSSContext {
>      IVssBackupComponents *pVssbc;  /* VSS requester interface */
>      IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot
> operation */
> +    VSS_ID idSnapshotSet;          /* snapshot set created for this cycl=
e
> */
>      HANDLE hEventFrozen;           /* notify fs/writer freeze from
> provider */
>      HANDLE hEventThaw;             /* request provider to thaw */
>      HANDLE hEventTimeout;          /* notify timeout in provider */
> @@ -116,6 +117,7 @@ static void requester_cleanup(void)
>          vss_ctx.pVssbc->Release();
>          vss_ctx.pVssbc =3D NULL;
>      }
> +    vss_ctx.idSnapshotSet =3D GUID_NULL;
>      vss_ctx.cFrozenVols =3D 0;
>      qga_debug_end;
>  }
> @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>          err_set(errset, hr, "failed to start snapshot set");
>          goto out;
>      }
> +    vss_ctx.idSnapshotSet =3D guidSnapshotSet;
>
>      if (mountpoints) {
>          PWCHAR volume_name_wchar;
> @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>          err_set(errset, hr, "failed to do snapshot set");
>      }
>
> +    /*
> +     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context, so
> +     * it is persistent: if it was committed, VSS keeps it (and keeps
> +     * querying providers about it) until it is explicitly deleted. The
> +     * freeze/thaw cycle is over whatever the outcome above, so delete
> +     * it now. Failure is not fatal here, only log it.
> +     */
> +    {
> +        LONG lDeletedSnapshots =3D 0;
> +        VSS_ID idNonDeletedSnapshot;
> +        HRESULT hrDelete;
> +
> +        hrDelete =3D vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnapshotS=
et,
> +
>  VSS_OBJECT_SNAPSHOT_SET,
> +                                                   TRUE,
> +                                                   &lDeletedSnapshots,
> +                                                   &idNonDeletedSnapshot=
);
> +        if (FAILED(hrDelete)) {
> +            qga_debug("failed to delete snapshot set after thaw,"
> +                      " hr=3D0x%08lx", hrDelete);
> +        }
> +    }
> +
>      if (err_is_set(errset)) {
>          vss_ctx.pVssbc->AbortBackup();
>      }
> --
> 2.56.0.116.g6de20f6092dc
>
>

--00000000000064576a065ee210b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue, Oct 27, 2026 at 6:06=E2=80=AFPM &lt;<a hr=
ef=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" t=
arget=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Since commit 374f4676788c, the provider&#39;s GetSnapshotProperties()<br>
returns S_OK for any snapshot ID without filling in the properties.=C2=A0 V=
SS<br>
consults every registered provider when a requester looks up a snapshot,<br=
>
so lookups of snapshots owned by other providers now succeed with an<br>
all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.<br>
Veeam: &quot;Original volume name is not specified for the shadow (shadow<b=
r>
volume id: &#39;{00000000-0000-0000-0000-000000000000}&#39;)&quot;.<br>
<br>
Simply reverting is not an option: 374f4676788c switched to S_OK because<br=
>
returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga&#39;s own<br=
>
snapshot sets. The provider must answer for its own snapshots only. It<br>
does not create real shadow copies, but it does take part in the<br>
snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot IDs<br>
received in BeginPrepareSnapshot(), return their required properties,<br>
and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every required<br=
>
VSS_SNAPSHOT_PROP member except the exposed name and path, which are<br>
optional. The snapshot device object is an empty string because the<br>
host-side snapshot has no guest-visible device.<br>
<br>
Entries are dropped when VSS deletes the snapshots or the set, or when<br>
the set is aborted (AbortSnapshots()).<br>
<br>
COM+ may hand out several CQGAVssProvider instances (and serve several<br>
client processes), so this registry is module-global. It is per-process<br>
by design and safe because the COM+ application is hosted by a single NT<br=
>
service (see CreateServiceForApplication() in install.cpp): COM+ forbids<br=
>
pooling and recycling for service-hosted applications, so exactly one<br>
surrogate process ever hosts the provider.<br>
<br>
On the requester side, the snapshot set is created in the persistent<br>
VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw<br>
cycle and may keep querying providers about it. The provider registry<br>
does not outlive the cycle (requester_thaw() stops the hosting service,<br>
and the provider process with it), so later queries would get &quot;not<br>
found&quot; for a set VSS still believes exists. Make requester_thaw() dele=
te<br>
the snapshot set explicitly at the end of the cycle, whatever its<br>
outcome (including BackupComplete() failure and aborted snapshot sets).<br>
A failure to delete is only logged, since the guest filesystems have<br>
already been thawed.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/4584=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/4584</a><br>
Buglink: <a href=3D"https://redhat.atlassian.net/browse/RHEL-250662" rel=3D=
"noreferrer" target=3D"_blank">https://redhat.atlassian.net/browse/RHEL-250=
662</a><br>
Fixes: 374f4676788c (&quot;qga: Fix VSS provider GetSnapshotProperties retu=
rn value&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
v2:<br>
=C2=A0- fill the required VSS_SNAPSHOT_PROP fields<br>
---<br>
=C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0qga/vss-win32/provider.cpp=C2=A0 | 200 ++++++++++++++++++++++++++++++=
+++++-<br>
=C2=A0qga/vss-win32/requester.cpp |=C2=A0 26 +++++<br>
=C2=A03 files changed, 226 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 09d94edd4f53..3b58dc840520 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -331,6 +331,7 @@ STDAPI COMRegister(void)<br>
=C2=A0 =C2=A0 =C2=A0chk(put_Value(pObj, L&quot;Authentication&quot;,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short(6)));<br>
=C2=A0 =C2=A0 =C2=A0chk(put_Value(pObj, L&quot;AuthenticationCapability&quo=
t;,=C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<br>
=C2=A0 =C2=A0 =C2=A0chk(put_Value(pObj, L&quot;ImpersonationLevel&quot;,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<br>
+=C2=A0 =C2=A0 /* NT-service-hosted apps have ConcurrentApps=3D1 enforced *=
/<br>
=C2=A0 =C2=A0 =C2=A0chk(pApps-&gt;SaveChanges(&amp;n));<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The app should be deleted if something fails after S=
aveChanges */<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 1c8eb236e57f..bbc30dd57d85 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -11,6 +11,11 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+<br>
+#include &lt;vector&gt;<br>
+#include &lt;algorithm&gt;<br>
+#include &lt;string&gt;<br>
+<br>
=C2=A0#include &quot;vss-common.h&quot;<br>
=C2=A0#include &quot;vss-debug.h&quot;<br>
=C2=A0#ifdef HAVE_VSS_SDK<br>
@@ -138,6 +143,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObject =
**ppenum)<br>
=C2=A0 =C2=A0 =C2=A0return E_NOTIMPL;<br>
=C2=A0}<br>
<br>
+static VSS_PWSZ qga_vss_strdup(const WCHAR *value)<br>
+{<br>
+=C2=A0 =C2=A0 size_t len =3D (wcslen(value) + 1) * sizeof(WCHAR);<br>
+=C2=A0 =C2=A0 VSS_PWSZ str =3D (VSS_PWSZ)CoTaskMemAlloc(len);<br>
+<br>
+=C2=A0 =C2=A0 if (str) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(str, value, len);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return str;<br>
+}<br>
+<br>
+static VSS_PWSZ qga_vss_strdup(const std::wstring &amp;value)<br>
+{<br>
+=C2=A0 =C2=A0 return qga_vss_strdup(value.c_str());<br>
+}<br>
+<br>
+static VSS_TIMESTAMP qga_vss_timestamp(void)<br>
+{<br>
+=C2=A0 =C2=A0 FILETIME ft;<br>
+=C2=A0 =C2=A0 ULARGE_INTEGER value;<br>
+<br>
+=C2=A0 =C2=A0 GetSystemTimeAsFileTime(&amp;ft);<br>
+=C2=A0 =C2=A0 value.LowPart =3D ft.dwLowDateTime;<br>
+=C2=A0 =C2=A0 value.HighPart =3D ft.dwHighDateTime;<br>
+=C2=A0 =C2=A0 return value.QuadPart;<br>
+}<br>
+<br>
+/* Registry of the snapshot IDs for this provider */<br>
+class QGAVssSnapshotRegistry<br>
+{<br>
+public:<br>
+=C2=A0 =C2=A0 bool Track(VSS_ID set_id, VSS_ID snapshot_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_PWSZ volume_nam=
e, LONG context);<br>
+=C2=A0 =C2=A0 HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP =
*prop) const;<br>
+=C2=A0 =C2=A0 LONG RemoveSet(VSS_ID set_id); /* returns how many were remo=
ved */<br>
+=C2=A0 =C2=A0 bool Remove(VSS_ID snapshot_id);<br>
+<br>
+private:<br>
+=C2=A0 =C2=A0 struct Entry {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID set_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID snapshot_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 std::wstring volume_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG context;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_TIMESTAMP timestamp;<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 std::vector&lt;Entry&gt; m_entries;<br>
+=C2=A0 =C2=A0 mutable SRWLOCK m_lock =3D SRWLOCK_INIT;<br>
+};<br>
+<br>
+static QGAVssSnapshotRegistry qga_vss_registry;<br>
+<br>
+bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_PWSZ volume_name, L=
ONG context)<br>
+{<br>
+=C2=A0 =C2=A0 bool ok;<br>
+<br>
+=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 try {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.push_back(Entry { set_id, snapshot_i=
d, volume_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context, qga_vss_times=
tamp() });<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D true;<br>
+=C2=A0 =C2=A0 } catch (...) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 return ok;<br>
+}<br>
+<br>
+HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VSS_SNAPSHOT_PROP *prop) const<br>
+{<br>
+=C2=A0 =C2=A0 HRESULT hr =3D S_OK;<br>
+=C2=A0 =C2=A0 VSS_PWSZ device =3D NULL, original =3D NULL;<br>
+=C2=A0 =C2=A0 VSS_PWSZ originating =3D NULL, service =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 AcquireSRWLockShared(&amp;m_lock);<br>
+=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin(), m_entries.end(),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.snapshot_id=
, snapshot_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
+=C2=A0 =C2=A0 if (it =3D=3D m_entries.end()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D VSS_E_OBJECT_NOT_FOUND;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const Entry &amp;e =3D *it;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR machine[256] =3D L&quot;&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD machine_size =3D ARRAYSIZE(machine);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!GetComputerNameExW(ComputerNameDnsFullyQu=
alified, machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;machine_size)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *machine =3D L&#39;\0&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device =3D qga_vss_strdup(L&quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 original =3D qga_vss_strdup(e.volume_name);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 originating =3D qga_vss_strdup(machine);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 service =3D qga_vss_strdup(machine);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!device || !original || !originating || !s=
ervice) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_OUTOFMEMORY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(prop, 0, sizeof(*prop));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotId =3D e.snapshot_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotSetId =3D e.set_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotsCount =3D std::count_if(m=
_entries.begin(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.end(), [&amp;](const E=
ntry &amp;o) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID=
(o.set_id, e.set_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszSnapshotDeviceObject =3D device=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginalVolumeName =3D original=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginatingMachine =3D originat=
ing;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszServiceMachine =3D service;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_ProviderId =3D g_gProviderId;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotAttributes =3D e.context;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_tsCreationTimestamp =3D e.timestamp=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_eStatus =3D VSS_SS_CREATED;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device =3D original =3D originating =3D servic=
e =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 CoTaskMemFree(device);<br>
+=C2=A0 =C2=A0 CoTaskMemFree(original);<br>
+=C2=A0 =C2=A0 CoTaskMemFree(originating);<br>
+=C2=A0 =C2=A0 CoTaskMemFree(service);<br>
+=C2=A0 =C2=A0 ReleaseSRWLockShared(&amp;m_lock);<br>
+=C2=A0 =C2=A0 return hr;<br>
+}<br>
+<br>
+LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)<br>
+{<br>
+=C2=A0 =C2=A0 LONG removed;<br>
+<br>
+=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 auto it =3D std::remove_if(m_entries.begin(), m_entries.end(=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.set_id, set=
_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
+=C2=A0 =C2=A0 removed =3D m_entries.end() - it;<br>
+=C2=A0 =C2=A0 m_entries.erase(it, m_entries.end());<br>
+=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 return removed;<br>
+}<br>
+<br>
+bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)<br>
+{<br>
+=C2=A0 =C2=A0 bool found;<br>
+<br>
+=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin(), m_entries.end(),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqualGUID(e.snapshot_id=
, snapshot_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
+=C2=A0 =C2=A0 found =3D it !=3D m_entries.end();<br>
+=C2=A0 =C2=A0 if (found) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.erase(it);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
+=C2=A0 =C2=A0 return found;<br>
+}<br>
<br>
=C2=A0/* QGAVssProvider */<br>
<br>
@@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)=
<br>
=C2=A0STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(<br>
=C2=A0 =C2=A0 =C2=A0VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return S_OK;<br>
+=C2=A0 =C2=A0 return qga_vss_registry.GetProperties(SnapshotId, pProp);<br=
>
=C2=A0}<br>
<br>
=C2=A0STDMETHODIMP CQGAVssProvider::Query(<br>
@@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(<br>
=C2=A0 =C2=A0 =C2=A0VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectTyp=
e,<br>
=C2=A0 =C2=A0 =C2=A0BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID *pN=
ondeletedSnapshotID)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 LONG deleted =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 switch (eSourceObjectType) {<br>
+=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qga_vss_registry.Remove(SourceObjectId)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT_SET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D qga_vss_registry.RemoveSet(SourceO=
bjectId);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (deleted &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *plDeletedSnapshots =3D deleted;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pNondeletedSnapshotID =3D GUID_NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0*plDeletedSnapshots =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0*pNondeletedSnapshotID =3D SourceObjectId;<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br></blockquote><div><br></div><div>return=
=C2=A0VSS_E_OBJECT_NOT_FOUND in this case looks more correct</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
@@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(<br=
>
=C2=A0 =C2=A0 =C2=A0VSS_ID SnapshotSetId, VSS_ID SnapshotId,<br>
=C2=A0 =C2=A0 =C2=A0VSS_PWSZ pwszVolumeName, LONG lNewContext)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 if (!pwszVolumeName) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_INVALIDARG;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwszVolumeName, lNewContext)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_OUTOFMEMORY;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0}<br>
<br>
@@ -411,6 +608,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnapshots(=
VSS_ID SnapshotSetId)<br>
<br>
=C2=A0STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)<br=
>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_vss_registry.RemoveSet(SnapshotSetId);<br>
=C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0}<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 1b0155c691ef..565eefcfb283 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnapshotProper=
ties;<br>
=C2=A0static struct QGAVSSContext {<br>
=C2=A0 =C2=A0 =C2=A0IVssBackupComponents *pVssbc;=C2=A0 /* VSS requester in=
terface */<br>
=C2=A0 =C2=A0 =C2=A0IVssAsync *pAsyncSnapshot;=C2=A0 =C2=A0 =C2=A0/* async =
info of VSS snapshot operation */<br>
+=C2=A0 =C2=A0 VSS_ID idSnapshotSet;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* s=
napshot set created for this cycle */<br>
=C2=A0 =C2=A0 =C2=A0HANDLE hEventFrozen;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* notify fs/writer freeze from provider */<br>
=C2=A0 =C2=A0 =C2=A0HANDLE hEventThaw;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* request provider to thaw */<br>
=C2=A0 =C2=A0 =C2=A0HANDLE hEventTimeout;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* notify timeout in provider */<br>
@@ -116,6 +117,7 @@ static void requester_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vss_ctx.pVssbc-&gt;Release();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vss_ctx.pVssbc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D GUID_NULL;<br>
=C2=A0 =C2=A0 =C2=A0vss_ctx.cFrozenVols =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
=C2=A0}<br>
@@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, hr, &quot;failed to start=
 snapshot set&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D guidSnapshotSet;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (mountpoints) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PWCHAR volume_name_wchar;<br>
@@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *mountpints, E=
rrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, hr, &quot;failed to do sn=
apshot set&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The snapshot set is created in VSS_CTX_APP_ROLLBACK =
context, so<br>
+=C2=A0 =C2=A0 =C2=A0* it is persistent: if it was committed, VSS keeps it =
(and keeps<br>
+=C2=A0 =C2=A0 =C2=A0* querying providers about it) until it is explicitly =
deleted. The<br>
+=C2=A0 =C2=A0 =C2=A0* freeze/thaw cycle is over whatever the outcome above=
, so delete<br>
+=C2=A0 =C2=A0 =C2=A0* it now. Failure is not fatal here, only log it.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG lDeletedSnapshots =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID idNonDeletedSnapshot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HRESULT hrDelete;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hrDelete =3D vss_ctx.pVssbc-&gt;DeleteSnapshot=
s(vss_ctx.idSnapshotSet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_OBJECT_SNAPSHOT_SET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRUE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;lDeletedSnapshots,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;idNonDeletedSnapshot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hrDelete)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;failed to delete=
 snapshot set after thaw,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; hr=3D0x%08lx&quot;, hrDelete);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (err_is_set(errset)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vss_ctx.pVssbc-&gt;AbortBackup();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.56.0.116.g6de20f6092dc<br>
<br>
</blockquote></div></div>

--00000000000064576a065ee210b8--


