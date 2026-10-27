Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kmv4BkO/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhl9-0008C6-Mn; Tue, 27 Oct 2026 10:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xLhku-00087X-9M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:02:29 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xLhkq-0002HA-Du
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:02:22 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-3514b90bb89so9304443eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109736; cv=none;
 d=google.com; s=arc-20260327;
 b=GdPszWjxl13nJj5mkY7JqRvqkMh4ACbg8Zz3MmX2sXoElGShAdC3erT3/39Y1nLxgu
 3fEcdxTpKX3b76uXLi7Aefm7vkH2Ck1sXbokFNGveMO6L0X1+Lnrhot//mwPusQyWCXn
 oB6qJn5HDAUEcfNDjU8PHtmJ2Z+QGimiH6/eNWt5yce5yEbvcM7FwB4EkbJeaBQeW9sU
 NpwjRZbMUyeD4TitTNtEHpV/krCVI4UcH8XmGkDGYLM4ZmEUNrGL08DTCuPE6xatair9
 l05bI1Txb+ZIbJUxkkRkmvjs5lotSa+CQBC5wzTw56dV2MDovNsrffLNSjsNviT+dEWO
 fzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sKExVAwwOle1vnQ1jNNQvjYR6X1/ZGkBmfo6L/xon2k=;
 fh=lv1jp0rZoXFpgS5FCXRaUShFSVzzdgfMsu2eaYmK1a4=;
 b=R1N9wVY8A758obtKZIEHMbOaYPHrTESGdgxHZbMsOgt4lhWTxuPjO3K0QWWnQY7T59
 EuPTWA4AHH44fn0InSUwr0bUbYz74UDqzvrP8I4cqghpYaP85IAwJ5P4pMI55RrXqJw0
 yjhVQnj65xCsiwfr5cRDlCHvmfxWIEcZR2oGPm5gz+7FePggH8CkyZr0+lxbBcyDIcq5
 b8WIMbBypqwc37G8sHM4fN+gC5PrtIHOsTv1nNqNPCEC7sK5a5U6EKB1Flwa5ZNtVgwz
 0FVP5cmQbLQQwTMWK8NDiyi47x3lcJMihwR7GbmhFBe5Pj8W4DXNOr9XoSJLlm86YZJ+
 mcUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793109736; x=1793714536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sKExVAwwOle1vnQ1jNNQvjYR6X1/ZGkBmfo6L/xon2k=;
 b=Kmv4BkO/Dv7aiPYx0j8BTZYwF3uehG2trK5TXLOr1DREL26mo0JExtraj1SJ9RLI43
 dhPGZUmzUUc9lDJYodgl3rF+6uBBD1CtryZdVQvcszUjBFcuED9ixXJNSTlznI491AtH
 2OfSn6x1wcGYVZo3hcn090rQLWI83kIgT3UR1wEycsVA5+DRU+azuD6T7Bk2cxRbbosH
 5oB+nzIKypeotkuM+dS+0g4Rr4rgvyUAmnk/9xlkeQqyH59u0we7q5mFrpBhqcwRdArA
 OZIiuoY30yzJ/XCc9NxPcANUJCxaNlAVjq73CX38IO4jLCeC6jSCKUvt4QRgWgZbMf4z
 bCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109736; x=1793714536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sKExVAwwOle1vnQ1jNNQvjYR6X1/ZGkBmfo6L/xon2k=;
 b=pbnu40Ke9+D7ct77ShTpzvamyQiC+8rZ9YmZXJHSierAqlbLuepe1kro7c3yDtY3xK
 AlY27PFZ2MOvqULd11WsRbhomLhFve05qei54KbtDk3zSPzihqLsyzWQeNLgTCxA0F5r
 DaSynhuKQp2tY7yUPEZjTID8fdip5mAndsXkvlbKSx3iD0Nma73ouQX1aZIvGgTaFu4B
 QIxJT0XB6I6JPH/khY8OaFjuvgEJ1QU5BvB6/Ai0GdRg9Ko/+ZMj8sseDPSwWh6lx6LI
 GBKnMyX2stLzgw5WN7xiCAAJznAy98TyhvxljdphPuiMcB8dgUraQzw8H4tT9f/9dLO6
 PyrA==
X-Gm-Message-State: AFq9FYK7BxOvXJ9Zndowyvm8048urVw3Q0d0oEcShYAqoNGwGrivcXZB
 /7DB/mxSg67ufj7pZMwncsHLa40dyXKaQbCBcW0o27Wp/95A56YVy1o0vqb57FJBUS2HZjVmf3+
 lU+jS7njQk6kMNWbTQLWkRZmSO7gcLZQ=
X-Gm-Gg: AYBFou0HPnx1N4PxBVo3ErvQo8BESdMOCipN9RZjRTty9mOkvlfy+IDcXDoHDZkPz/u
 Wxf27VU4wWW2wmVIPpeYPA9DhBbYYzndNoVqc6gMkmCDsas0EQWfWwzbfT7VU/hQd6+FDZckUy/
 7vGkS7U2H0ggmRj+p3T/eCCOJtpZrGFS8emF4855VhrV/tEwz5VKi1oXpNK7nH4pEhwGqoMfyLw
 zN5KxMd2qdX/loJNt9qEmE+Jta4PfE2agYp7ecYTks8hmGwsS9bk07VekxTvTWAlmOARVEFUnzJ
 UwJ8n6nMql1EdWOr9Qwx9aZ2wzk93MVQfnxkl5JotkvsB9j7RofV2w+2skHs0QUkAWcsZ5AhmBh
 iWs2o5OqjsZPyp+q2DQBY2lD77Rx68qMB/95JWIH54ru9cnDQmVUT2mKPitpG0Gu94dSM
X-Received: by 2002:a05:693c:42d0:b0:361:167c:2364 with SMTP id
 5a478bee46e88-369e845a30emr14492656eec.8.1793109735430; Tue, 27 Oct 2026
 07:02:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133049.2522944-2-marcandre.lureau@redhat.com>
 <CAPMcbCr=gsBr9Wnw1rK+4HEcTwdCxOinKqeC=0yE1ZUa-hwHWw@mail.gmail.com>
In-Reply-To: <CAPMcbCr=gsBr9Wnw1rK+4HEcTwdCxOinKqeC=0yE1ZUa-hwHWw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Oct 2026 18:02:02 +0400
X-Gm-Features: AclHuK8V6NKkLSTai15W1gebyZr0ETsd6ge_j6eHr4L-FlhkiaqG1pfJtQ36rGE
Message-ID: <CAJ+F1CLHzMuGW_m9kkU2r3YW-Vv1eQAYQ3YkJSfKm_QsoZbQWQ@mail.gmail.com>
Subject: Re: [PATCH] qga/vss: fix provider handling of snapshots
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
>
>
> On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
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
>> received in BeginPrepareSnapshot(), return their
>> (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND for anything
>> else.
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
>>  qga/vss-win32/install.cpp   |   1 +
>>  qga/vss-win32/provider.cpp  | 153 +++++++++++++++++++++++++++++++++++-
>>  qga/vss-win32/requester.cpp |  26 ++++++
>>  3 files changed, 179 insertions(+), 1 deletion(-)
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
>> index 1c8eb236e57f..ad2f3ee763e6 100644
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
>> @@ -138,6 +143,123 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObje=
ct **ppenum)
>>      return E_NOTIMPL;
>>  }
>>
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
>> +                                    context });
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
>> +        size_t len =3D (e.volume_name.size() + 1) * sizeof(WCHAR);
>> +        VSS_PWSZ volume =3D (VSS_PWSZ)CoTaskMemAlloc(len);
>
>
> I'm afraid of this part. We allocate memory but don't call CoTaskMemFree.
> This function is called from IVssBackupComponents::GetSnapshotProperties
> From https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsba=
ckup-ivssbackupcomponents-getsnapshotproperties
> "When the structure is no longer needed, the software provider is respons=
ible for freeing these strings by calling the VssFreeSnapshotProperties fun=
ction."
>
> So we allocate memory but don't free it with VssFreeSnapshotProperties or=
 CoTaskMemFree.

I also wondered, but this is apparently what is expected:

https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/content/vss/=
ns-vss-vss_object_prop.md


A requester obtains VSS_OBJECT_PROP structures by using
IVssEnumObject::Next to iterate over the list of objects returned by a
call to IVssBackupComponents::Query.

As its members are filled by a COM interface, prior to deleting the
property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the
memory they contain must be released by calling CoTaskMemFree for
every string and byte array value contained in each structure.

In the case of VSS_SNAPSHOT_PROP, this can be done manually, or the
utility function VssFreeSnapshotProperties can be used.


>
>> +
>> +        if (!volume) {
>> +            hr =3D E_OUTOFMEMORY;
>> +            goto out;
>> +        }
>> +        memcpy(volume, e.volume_name.c_str(), len);
>> +
>> +        /* not a real snapshot: no device object, exposure or timestamp=
 */
>> +        memset(prop, 0, sizeof(*prop));
>> +        prop->m_SnapshotId =3D e.snapshot_id;
>> +        prop->m_SnapshotSetId =3D e.set_id;
>> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
>> +            m_entries.end(), [&](const Entry &o) {
>> +                return IsEqualGUID(o.set_id, e.set_id);
>> +            });
>> +        prop->m_pwszOriginalVolumeName =3D volume;
>> +        prop->m_ProviderId =3D g_gProviderId;
>> +        prop->m_lSnapshotAttributes =3D e.context;
>> +        prop->m_eStatus =3D VSS_SS_CREATED;
>> +    }
>> +
>> +out:
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
>> @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lConte=
xt)
>>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
>>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
>>  {
>> -    return S_OK;
>> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
>>  }
>>
>>  STDMETHODIMP CQGAVssProvider::Query(
>> @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
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
>> @@ -295,6 +438,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(
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
>> @@ -411,6 +561,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnapsho=
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

