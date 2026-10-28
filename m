Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jRGzrQRb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0mJ-0000nu-AI; Wed, 28 Oct 2026 06:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xM0mD-0000nY-GM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:21:03 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xM0mA-0004Sb-QP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:21:01 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-353804b591eso1279978eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793182857; cv=none;
 d=google.com; s=arc-20260327;
 b=mNyZXUyPqfpmD3pd1mQ1ga+VdM4BCbjSmKkHYoFdI9MhajBHIan4FoOgSVDTGZpNsL
 KSrDMPpoH4enohxg7DyThkWtDAxDtyYjtZmfk6+6AM5RYtdI1oWnMTBqU5az1mYWGSCU
 sTkCVoqzGiWYeB1U525HPAuFBx572XA/BgCeA4jM+7e0koO3md/BYsDqz1Qgkdvb2aZ1
 5WvukgcSvNVGU774qaEUhVyMsJ6Ye7n/gFAnLU0FKZFLxx/CiDqZBSn2ukQMfZhF4UEq
 PDU8LJN3eUuTTPb+iV1zuMSzEP7cwbCKzGN1uWg/IDNqxd/SZ8NV5bJWU72tAsQgHF3T
 ijCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3hFItoGQkWMlVEOHJ39Yc+S1PKkMiGJywJoBZYi7Gpg=;
 fh=lv1jp0rZoXFpgS5FCXRaUShFSVzzdgfMsu2eaYmK1a4=;
 b=LtTr+BUINROc4Wu0pED/ahOdNJGLCYS5EtLru/kvJFJEPFxhk2axrCosf9Dhi/W3HL
 bRKKscXd4yTy/eryM23PqZb12OsQOf/NGSsX6F5NjaKlGpYARTfusQr0XihclqkfCEU6
 V/51bzIl6LLbwXcktqaCecB/OJYgV8AvpMGtUX5AFxKGuipFaF3npMKX8CtFBkP0k5tr
 tP4au6jgATuGvs+8elA1PbPPswm/MD0a48QgXz1GvPcxHzJvv8ws2/0QNAGql5CVZNND
 YU2/VZ9oakSXXRjdA0ooLVVfWl9T1ZILRXNa9JCzA2RTanw5AJjtIi60Nhephyg3eme6
 lOcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793182857; x=1793787657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3hFItoGQkWMlVEOHJ39Yc+S1PKkMiGJywJoBZYi7Gpg=;
 b=jRGzrQRb2J9xo1blR0HeSRX4u/i37HOfGmVRXYO69bm4e0HoQzq6CH59NMS+CqIIo0
 tMEPW5W0GMnDfmYPvsPdULNdZ+YTBLKmZDZL0V76GXVfIekiYm8H1Kp07llO5SQmXtnW
 rB2Js5vw9cVMbIyTc4ZM2HbfTMdYR39ZppM0HzSXjz1f2elZ5893Rt88/iPEljEvH7X6
 9nh6n9c42vflQa9s0PpnmGDmrx5EqRnP+gS6//ro4+zGMdFnmbmiwHIESR2P3RYF2908
 W8PT1GCl+DNcMa0VjxqWbk1Z02EtzqgDmFQvmfgSMSJe67IicPWymKkHhNp9X8AqVk2x
 iX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793182857; x=1793787657;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hFItoGQkWMlVEOHJ39Yc+S1PKkMiGJywJoBZYi7Gpg=;
 b=2ms7ioXvOgYkX1867Fspgj2uB4S6jN6RpEw/S1e3Ds2VVRH1ipyDBQ8KryXICTgUZk
 vtKDUkRKVVFOdB1QSu87jO+UrHSuE7iYFgXNtg3p83Aut4widqYFBbz2oUgnzfVYsI+v
 XiVTveWFBlBXvb4giz9zCDDch8WJPQOzgdZZmofLEsvSkGdGUK2J09lBX27XPZ574BQ8
 fUB7T6zQ/K0gAObu2Erxt5y+BxFJdLbhZ8itrkdhkcmTmcekBArDYIm9aEGRQsdITL+I
 LleDXfJYlXsO5iZJrTFbspwVVOu0qiVW5nI2MJSAHwGwcZmwg7jv1Fo5avRmIWHrdcsW
 pBuA==
X-Gm-Message-State: AFq9FYK8rlI+PQoXRDrK5fWIzWfkKBFRzQh/47InNWSVcjGfIZEh13T8
 8hEcWc7AUP7zA1NQMpnIZJMCCDri6ZBNOUm7/P8OH8BMWXraMo3Eb54iu9/R6WBo4YJtGlhlEBI
 MpFE7CqQdpxsNxNYDtHdWkHQWydcNDCg=
X-Gm-Gg: AYBFou3GXbvY6Vb5BHBzaUOO0SSzubBWkODaaO4sooTn4/0/HSl3qHwQNfbo/uOIHZl
 /MdzPBhOxuB2NoJqyIgFBcQ6D/4zUovEc3I6M3lr0B6GPaeaAkBtODBETc9UcVJ2MnIrW/POe7y
 vQtAiN7KFFRqE1rSL2m5FK36vcx09Op+5b0c8dVjoiquOK4qoiKNskKx/M0nHLW0+qPCfDS3Y/N
 dhIBpRHLnfQSQDwre3xn2mgcaWnV1OeOK3ObWIRUtWd4hFTfmP4Doi13SsJsmmEtwPQyz7plrpD
 ziHOPzjzLbGGp3e/hLXhnrzb2IfdcFRNt02RUUk1Grh9j6+wMz28b9+EU/x29YcBg5KZFeP0DXh
 zizXM+A9SXCmhdhav0dqnasa5RihC3uwV9mT++kEP+6owHdKDpVGQjwo6nGas5mEQXYEt
X-Received: by 2002:a05:693c:42d3:b0:36a:2383:eb51 with SMTP id
 5a478bee46e88-36a2383ec49mr1807410eec.26.1793182856421; Wed, 28 Oct 2026
 03:20:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027160606.2668607-2-marcandre.lureau@redhat.com>
 <CAPMcbCpY1Re_edBo-S1TqguOU3HpjpT1TVhX1-stw0yPTvh=pg@mail.gmail.com>
In-Reply-To: <CAPMcbCpY1Re_edBo-S1TqguOU3HpjpT1TVhX1-stw0yPTvh=pg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Oct 2026 14:20:44 +0400
X-Gm-Features: AclHuK_4xEKBtF7gGsMsa7-rtiBCyQW5Al76UCTVTUki7d2uYQLbaP1ez6A6M64
Message-ID: <CAJ+F1CJ5AYSvPAkeiYnu8J7c7G-cP5ka4xK+XzPKyCRaz_+znA@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss: fix provider handling of snapshots
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Wed, Oct 28, 2026 at 12:08=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redha=
t.com> wrote:
>
>
>
>
>
> On Tue, Oct 27, 2026 at 6:06=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Since commit 374f4676788c, the provider's GetSnapshotProperties()
>> returns S_OK for any snapshot ID without filling in the properties.  VSS
>> consults every registered provider when a requester looks up a snapshot,
>> so lookups of snapshots owned by other providers now succeed with an
>> all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.
>> Veeam: "Original volume name is not specified for the shadow (shadow
>> volume id: '{00000000-0000-0000-0000-000000000000}')".
>>
>> Simply reverting is not an option: 374f4676788c switched to S_OK because
>> returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's own
>> snapshot sets. The provider must answer for its own snapshots only. It
>> does not create real shadow copies, but it does take part in the
>> snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot IDs
>> received in BeginPrepareSnapshot(), return their required properties,
>> and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every required
>> VSS_SNAPSHOT_PROP member except the exposed name and path, which are
>> optional. The snapshot device object is an empty string because the
>> host-side snapshot has no guest-visible device.
>>
>> Entries are dropped when VSS deletes the snapshots or the set, or when
>> the set is aborted (AbortSnapshots()).
>>
>> COM+ may hand out several CQGAVssProvider instances (and serve several
>> client processes), so this registry is module-global. It is per-process
>> by design and safe because the COM+ application is hosted by a single NT
>> service (see CreateServiceForApplication() in install.cpp): COM+ forbids
>> pooling and recycling for service-hosted applications, so exactly one
>> surrogate process ever hosts the provider.
>>
>> On the requester side, the snapshot set is created in the persistent
>> VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
>> cycle and may keep querying providers about it. The provider registry
>> does not outlive the cycle (requester_thaw() stops the hosting service,
>> and the provider process with it), so later queries would get "not
>> found" for a set VSS still believes exists. Make requester_thaw() delete
>> the snapshot set explicitly at the end of the cycle, whatever its
>> outcome (including BackupComplete() failure and aborted snapshot sets).
>> A failure to delete is only logged, since the guest filesystems have
>> already been thawed.
>>
>> Cc: qemu-stable@nongnu.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
>> Buglink: https://redhat.atlassian.net/browse/RHEL-250662
>> Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties return=
 value")
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> v2:
>>  - fill the required VSS_SNAPSHOT_PROP fields
>> ---
>>  qga/vss-win32/install.cpp   |   1 +
>>  qga/vss-win32/provider.cpp  | 200 +++++++++++++++++++++++++++++++++++-
>>  qga/vss-win32/requester.cpp |  26 +++++
>>  3 files changed, 226 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>> index 09d94edd4f53..3b58dc840520 100644
>> --- a/qga/vss-win32/install.cpp
>> +++ b/qga/vss-win32/install.cpp
>> @@ -331,6 +331,7 @@ STDAPI COMRegister(void)
>>      chk(put_Value(pObj, L"Authentication",                 short(6)));
>>      chk(put_Value(pObj, L"AuthenticationCapability",       short(2)));
>>      chk(put_Value(pObj, L"ImpersonationLevel",             short(2)));
>> +    /* NT-service-hosted apps have ConcurrentApps=3D1 enforced */
>>      chk(pApps->SaveChanges(&n));
>>
>>      /* The app should be deleted if something fails after SaveChanges *=
/
>> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
>> index 1c8eb236e57f..bbc30dd57d85 100644
>> --- a/qga/vss-win32/provider.cpp
>> +++ b/qga/vss-win32/provider.cpp
>> @@ -11,6 +11,11 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +
>> +#include <vector>
>> +#include <algorithm>
>> +#include <string>
>> +
>>  #include "vss-common.h"
>>  #include "vss-debug.h"
>>  #ifdef HAVE_VSS_SDK
>> @@ -138,6 +143,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObje=
ct **ppenum)
>>      return E_NOTIMPL;
>>  }
>>
>> +static VSS_PWSZ qga_vss_strdup(const WCHAR *value)
>> +{
>> +    size_t len =3D (wcslen(value) + 1) * sizeof(WCHAR);
>> +    VSS_PWSZ str =3D (VSS_PWSZ)CoTaskMemAlloc(len);
>> +
>> +    if (str) {
>> +        memcpy(str, value, len);
>> +    }
>> +    return str;
>> +}
>> +
>> +static VSS_PWSZ qga_vss_strdup(const std::wstring &value)
>> +{
>> +    return qga_vss_strdup(value.c_str());
>> +}
>> +
>> +static VSS_TIMESTAMP qga_vss_timestamp(void)
>> +{
>> +    FILETIME ft;
>> +    ULARGE_INTEGER value;
>> +
>> +    GetSystemTimeAsFileTime(&ft);
>> +    value.LowPart =3D ft.dwLowDateTime;
>> +    value.HighPart =3D ft.dwHighDateTime;
>> +    return value.QuadPart;
>> +}
>> +
>> +/* Registry of the snapshot IDs for this provider */
>> +class QGAVssSnapshotRegistry
>> +{
>> +public:
>> +    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
>> +               VSS_PWSZ volume_name, LONG context);
>> +    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP *prop) =
const;
>> +    LONG RemoveSet(VSS_ID set_id); /* returns how many were removed */
>> +    bool Remove(VSS_ID snapshot_id);
>> +
>> +private:
>> +    struct Entry {
>> +        VSS_ID set_id;
>> +        VSS_ID snapshot_id;
>> +        std::wstring volume_name;
>> +        LONG context;
>> +        VSS_TIMESTAMP timestamp;
>> +    };
>> +
>> +    std::vector<Entry> m_entries;
>> +    mutable SRWLOCK m_lock =3D SRWLOCK_INIT;
>> +};
>> +
>> +static QGAVssSnapshotRegistry qga_vss_registry;
>> +
>> +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id,
>> +                                   VSS_PWSZ volume_name, LONG context)
>> +{
>> +    bool ok;
>> +
>> +    AcquireSRWLockExclusive(&m_lock);
>> +    try {
>> +        m_entries.push_back(Entry { set_id, snapshot_id, volume_name,
>> +                                    context, qga_vss_timestamp() });
>> +        ok =3D true;
>> +    } catch (...) {
>> +        ok =3D false;
>> +    }
>> +    ReleaseSRWLockExclusive(&m_lock);
>> +    return ok;
>> +}
>> +
>> +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
>> +                                              VSS_SNAPSHOT_PROP *prop) =
const
>> +{
>> +    HRESULT hr =3D S_OK;
>> +    VSS_PWSZ device =3D NULL, original =3D NULL;
>> +    VSS_PWSZ originating =3D NULL, service =3D NULL;
>> +
>> +    AcquireSRWLockShared(&m_lock);
>> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
>> +        [&](const Entry &e) {
>> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
>> +        });
>> +    if (it =3D=3D m_entries.end()) {
>> +        hr =3D VSS_E_OBJECT_NOT_FOUND;
>> +        goto out;
>> +    }
>> +
>> +    {
>> +        const Entry &e =3D *it;
>> +        WCHAR machine[256] =3D L"";
>> +        DWORD machine_size =3D ARRAYSIZE(machine);
>> +
>> +        if (!GetComputerNameExW(ComputerNameDnsFullyQualified, machine,
>> +                               &machine_size)) {
>> +            *machine =3D L'\0';
>> +        }
>> +
>> +        device =3D qga_vss_strdup(L"");
>> +        original =3D qga_vss_strdup(e.volume_name);
>> +        originating =3D qga_vss_strdup(machine);
>> +        service =3D qga_vss_strdup(machine);
>> +        if (!device || !original || !originating || !service) {
>> +            hr =3D E_OUTOFMEMORY;
>> +            goto out;
>> +        }
>> +
>> +        memset(prop, 0, sizeof(*prop));
>> +        prop->m_SnapshotId =3D e.snapshot_id;
>> +        prop->m_SnapshotSetId =3D e.set_id;
>> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
>> +            m_entries.end(), [&](const Entry &o) {
>> +                return IsEqualGUID(o.set_id, e.set_id);
>> +            });
>> +        prop->m_pwszSnapshotDeviceObject =3D device;
>> +        prop->m_pwszOriginalVolumeName =3D original;
>> +        prop->m_pwszOriginatingMachine =3D originating;
>> +        prop->m_pwszServiceMachine =3D service;
>> +        prop->m_ProviderId =3D g_gProviderId;
>> +        prop->m_lSnapshotAttributes =3D e.context;
>> +        prop->m_tsCreationTimestamp =3D e.timestamp;
>> +        prop->m_eStatus =3D VSS_SS_CREATED;
>> +
>> +        device =3D original =3D originating =3D service =3D NULL;
>> +    }
>> +
>> +out:
>> +    CoTaskMemFree(device);
>> +    CoTaskMemFree(original);
>> +    CoTaskMemFree(originating);
>> +    CoTaskMemFree(service);
>> +    ReleaseSRWLockShared(&m_lock);
>> +    return hr;
>> +}
>> +
>> +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
>> +{
>> +    LONG removed;
>> +
>> +    AcquireSRWLockExclusive(&m_lock);
>> +    auto it =3D std::remove_if(m_entries.begin(), m_entries.end(),
>> +        [&](const Entry &e) {
>> +            return IsEqualGUID(e.set_id, set_id);
>> +        });
>> +    removed =3D m_entries.end() - it;
>> +    m_entries.erase(it, m_entries.end());
>> +    ReleaseSRWLockExclusive(&m_lock);
>> +    return removed;
>> +}
>> +
>> +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
>> +{
>> +    bool found;
>> +
>> +    AcquireSRWLockExclusive(&m_lock);
>> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
>> +        [&](const Entry &e) {
>> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
>> +        });
>> +    found =3D it !=3D m_entries.end();
>> +    if (found) {
>> +        m_entries.erase(it);
>> +    }
>> +    ReleaseSRWLockExclusive(&m_lock);
>> +    return found;
>> +}
>>
>>  /* QGAVssProvider */
>>
>> @@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lConte=
xt)
>>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
>>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
>>  {
>> -    return S_OK;
>> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
>>  }
>>
>>  STDMETHODIMP CQGAVssProvider::Query(
>> @@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
>>      VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
>>      BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID *pNondeletedSna=
pshotID)
>>  {
>> +    LONG deleted =3D 0;
>> +
>> +    switch (eSourceObjectType) {
>> +    case VSS_OBJECT_SNAPSHOT:
>> +        if (qga_vss_registry.Remove(SourceObjectId)) {
>> +            deleted =3D 1;
>> +        }
>> +        break;
>> +    case VSS_OBJECT_SNAPSHOT_SET:
>> +        deleted =3D qga_vss_registry.RemoveSet(SourceObjectId);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    if (deleted > 0) {
>> +        *plDeletedSnapshots =3D deleted;
>> +        *pNondeletedSnapshotID =3D GUID_NULL;
>> +        return S_OK;
>> +    }
>> +
>>      *plDeletedSnapshots =3D 0;
>>      *pNondeletedSnapshotID =3D SourceObjectId;
>>      return S_OK;
>
>
> return VSS_E_OBJECT_NOT_FOUND in this case looks more correct

Possibly, but I didn't want to change the existing behaviour here
without good reasons (it was fixed in 2014 by commit
d9e1f574cb6eac0a3a2f97b67d2e7a3ad9c1dc95).

>
>>
>> @@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(
>>      VSS_ID SnapshotSetId, VSS_ID SnapshotId,
>>      VSS_PWSZ pwszVolumeName, LONG lNewContext)
>>  {
>> +    if (!pwszVolumeName) {
>> +        return E_INVALIDARG;
>> +    }
>> +    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
>> +                                pwszVolumeName, lNewContext)) {
>> +        return E_OUTOFMEMORY;
>> +    }
>>      return S_OK;
>>  }
>>
>> @@ -411,6 +608,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnapsho=
ts(VSS_ID SnapshotSetId)
>>
>>  STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
>>  {
>> +    qga_vss_registry.RemoveSet(SnapshotSetId);
>>      return S_OK;
>>  }
>>
>> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
>> index 1b0155c691ef..565eefcfb283 100644
>> --- a/qga/vss-win32/requester.cpp
>> +++ b/qga/vss-win32/requester.cpp
>> @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnapshotPro=
perties;
>>  static struct QGAVSSContext {
>>      IVssBackupComponents *pVssbc;  /* VSS requester interface */
>>      IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot operat=
ion */
>> +    VSS_ID idSnapshotSet;          /* snapshot set created for this cyc=
le */
>>      HANDLE hEventFrozen;           /* notify fs/writer freeze from prov=
ider */
>>      HANDLE hEventThaw;             /* request provider to thaw */
>>      HANDLE hEventTimeout;          /* notify timeout in provider */
>> @@ -116,6 +117,7 @@ static void requester_cleanup(void)
>>          vss_ctx.pVssbc->Release();
>>          vss_ctx.pVssbc =3D NULL;
>>      }
>> +    vss_ctx.idSnapshotSet =3D GUID_NULL;
>>      vss_ctx.cFrozenVols =3D 0;
>>      qga_debug_end;
>>  }
>> @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void *mountpoin=
ts, ErrorSet *errset)
>>          err_set(errset, hr, "failed to start snapshot set");
>>          goto out;
>>      }
>> +    vss_ctx.idSnapshotSet =3D guidSnapshotSet;
>>
>>      if (mountpoints) {
>>          PWCHAR volume_name_wchar;
>> @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *mountpints=
, ErrorSet *errset)
>>          err_set(errset, hr, "failed to do snapshot set");
>>      }
>>
>> +    /*
>> +     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context, so
>> +     * it is persistent: if it was committed, VSS keeps it (and keeps
>> +     * querying providers about it) until it is explicitly deleted. The
>> +     * freeze/thaw cycle is over whatever the outcome above, so delete
>> +     * it now. Failure is not fatal here, only log it.
>> +     */
>> +    {
>> +        LONG lDeletedSnapshots =3D 0;
>> +        VSS_ID idNonDeletedSnapshot;
>> +        HRESULT hrDelete;
>> +
>> +        hrDelete =3D vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnapshot=
Set,
>> +                                                   VSS_OBJECT_SNAPSHOT_=
SET,
>> +                                                   TRUE,
>> +                                                   &lDeletedSnapshots,
>> +                                                   &idNonDeletedSnapsho=
t);
>> +        if (FAILED(hrDelete)) {
>> +            qga_debug("failed to delete snapshot set after thaw,"
>> +                      " hr=3D0x%08lx", hrDelete);
>> +        }
>> +    }
>> +
>>      if (err_is_set(errset)) {
>>          vss_ctx.pVssbc->AbortBackup();
>>      }
>> --
>> 2.56.0.116.g6de20f6092dc
>>

