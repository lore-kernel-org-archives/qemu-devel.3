Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2248CFD635
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdl83-0006to-0C; Thu, 08 Jan 2026 03:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdl7p-0006rZ-DY
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:12:09 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdl7n-0001jN-4I
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:12:09 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-88fcc71dbf4so18390646d6.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767859925; x=1768464725; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX97S9V/qSX2sT52wr4VXr30PRzptFPOhTtB/d5LOyg=;
 b=OpIZt7UNMu6TYy3SpidUqu7ZaYCBxxAx80ckWdGeN0mTPnRCiyAmJwBMSmElT35Aj3
 WlEVcmVYxh3YZQ6xwKyRavFSDry/uUR3cDz6CLgv5Klxfh5mtwr2vUZML3LzsR/uoXs1
 ifXx2I7fUq+Ak/NChf3E6OG+/WlwEor7tFH0DIcMOqDXGCdAgpNrNs/Rp31iz5oxzpWo
 t26NSJTZj16XN8Qsj8COgfXqluaCurSmRFFxDVdDjfqGSsNdwCvNtmJARuoB4fGgR3k/
 oJZUYOMv89Su7chXTZWpEzEQSTVO9eXj2ryMpwoP2PJP5XvyGY59SZ0P173Opi5Pd8gD
 jfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767859925; x=1768464725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QX97S9V/qSX2sT52wr4VXr30PRzptFPOhTtB/d5LOyg=;
 b=ANzwF4LMD5IJtD5OSFhExnN6a6dQZM7QIhJ+ziVddTHZpI8WzWsgIPbh8A8AjorvD5
 q5bB36KaqgiYITzUwKhh8ZQDdsfrqyollEbugkt/gy3Ex41eU0WReFft09/dDA6+aqFZ
 +HWAsFcK4nc03TVI7Q1I97D9/OnY93JL3h0RsD80dcZd3u9bWIYCilPOstXqvJP2Qhyy
 Ot1kOiODlquidMYwXwr+OcLdZwgHxdcnAfTG2Nwnae9Uehs8R05XkvTSQuRGCFKnHb4U
 1P8+GyjCexIz+tQ+lRUqdrQBQAR/RK3+RoX/aAWUuu1PYE2AfJxfa9L5l0c3sHCWFXaS
 MUcA==
X-Gm-Message-State: AOJu0YwFB4K2CgXXjYI6d2NvyodWWSuDorrclLf8+uvvxXwHe5kLMGgf
 6xf9LFLcdhAEHT4gU51dURlz6RUn2ctNck/BEdr8izHa1kSq9w7UR+ze2NH+0M9hcIAn+YFzyc+
 pncnRZ1hSzQSMfYRc1YivyNXE5xkNY00=
X-Gm-Gg: AY/fxX7d/jnktsX0TTYS8g6i5DLxIaWO8j6WBCBJcysaAOZmaDkcIbraNUaDRkF8sfu
 1/eqiBCoXG6UV4LIN4QgiCUn1ZyzaU7IE6PM1/g+T+N3WXlTOAM1vTe+bSVNSo27sQPXkNRsQK2
 EtWh1+GD6ga7tHB8vSJ81anht3QoR9/aueMBk0oMdmZlKJ5e3wKdGyaee2bIEMPYJr7YOSEJ3MI
 8U1qFXSrIwtU45t1Toip3FlqTa+tBVqwfFVsluuJAntqqZq8KiwEVjpWooPhgGMgl5KMpeVfYWm
 +T4yUcgEc4EB9Q+8Q8SNruiRwJc=
X-Google-Smtp-Source: AGHT+IGAhJOl2sYMcfNEcBUjE6JDu2mOh5k6tyji1xEQW84CJM+jmfXM9SXMYRNNDs8rihzEn8nWoFtKTHkSCptgECU=
X-Received: by 2002:ad4:5aa7:0:b0:88f:da24:37c4 with SMTP id
 6a1803df08f44-890842edd3dmr71266466d6.71.1767859925351; Thu, 08 Jan 2026
 00:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
 <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
In-Reply-To: <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 12:11:53 +0400
X-Gm-Features: AQt7F2oit2MxiTcTxwyau2znODxW-Ddh-KNhGBCglPvdB33aCWGQ4Mb8hkzkQaM
Message-ID: <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Denis V . Lunev" <den@virtuozzo.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Nikolai

On Wed, Sep 24, 2025 at 12:30=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Sep 11, 2025 at 4:37=E2=80=AFPM Nikolai Barybin <nikolai.barybin@=
virtuozzo.com> wrote:
>>
>> QMP query-dump-guest-memory-capability reports win dump as available for
>> any x86 VM, which is false.
>>
>> This patch implements proper query of vmcoreinfo and calculation of
>> guest note size. Based on that we can surely report whether win dump
>> available or not.
>>
>> To perform this I suggest to split dump_init() into dump_preinit() and
>> dump_init_complete() to avoid exausting copypaste in
>> win_dump_available().
>>
>> For further reference one may review this libvirt discussion:
>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/H=
J3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>
>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>

Have you looked at my review & updated the patches? thanks

> Could we split the patch for the generic dump refactoring and then the wi=
ndows specifics?
>
>>
>> ---
>>  dump/dump.c     | 129 +++++++++++++++++++++++++++---------------------
>>  dump/win_dump.c |  23 +++++++--
>>  dump/win_dump.h |   2 +-
>>  3 files changed, 95 insertions(+), 59 deletions(-)
>>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index b2f7ea7abd..ce8b43f819 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -1780,10 +1780,7 @@ static void vmcoreinfo_update_phys_base(DumpState=
 *s)
>>      g_strfreev(lines);
>>  }
>>
>> -static void dump_init(DumpState *s, int fd, bool has_format,
>> -                      DumpGuestMemoryFormat format, bool paging, bool h=
as_filter,
>> -                      int64_t begin, int64_t length, bool kdump_raw,
>> -                      Error **errp)
>> +static void dump_preinit(DumpState *s, Error **errp)
>>  {
>>      ERRP_GUARD();
>>      VMCoreInfoState *vmci =3D vmcoreinfo_find();
>> @@ -1791,16 +1788,6 @@ static void dump_init(DumpState *s, int fd, bool =
has_format,
>>      int nr_cpus;
>>      int ret;
>>
>> -    s->has_format =3D has_format;
>> -    s->format =3D format;
>> -    s->written_size =3D 0;
>> -    s->kdump_raw =3D kdump_raw;
>> -
>> -    /* kdump-compressed is conflict with paging and filter */
>> -    if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
>> -        assert(!paging && !has_filter);
>> -    }
>> -
>>      if (runstate_is_running()) {
>>          vm_stop(RUN_STATE_SAVE_VM);
>>          s->resume =3D true;
>> @@ -1817,41 +1804,10 @@ static void dump_init(DumpState *s, int fd, bool=
 has_format,
>>          nr_cpus++;
>>      }
>>
>> -    s->fd =3D fd;
>> -    if (has_filter && !length) {
>> -        error_setg(errp, "parameter 'length' expects a non-zero size");
>> -        goto cleanup;
>> -    }
>> -    s->filter_area_begin =3D begin;
>> -    s->filter_area_length =3D length;
>> -
>> -    /* First index is 0, it's the special null name */
>> -    s->string_table_buf =3D g_array_new(FALSE, TRUE, 1);
>> -    /*
>> -     * Allocate the null name, due to the clearing option set to true
>> -     * it will be 0.
>> -     */
>> -    g_array_set_size(s->string_table_buf, 1);
>> -
>>      memory_mapping_list_init(&s->list);
>> -
>>      guest_phys_blocks_init(&s->guest_phys_blocks);
>>      guest_phys_blocks_append(&s->guest_phys_blocks);
>> -    s->total_size =3D dump_calculate_size(s);
>> -#ifdef DEBUG_DUMP_GUEST_MEMORY
>> -    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size)=
;
>> -#endif
>>
>> -    /* it does not make sense to dump non-existent memory */
>> -    if (!s->total_size) {
>> -        error_setg(errp, "dump: no guest memory to dump");
>> -        goto cleanup;
>> -    }
>> -
>> -    /* get dump info: endian, class and architecture.
>> -     * If the target architecture is not supported, cpu_get_dump_info()=
 will
>> -     * return -1.
>> -     */
>
>
> Why drop that comment?
>
>>
>>      ret =3D cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
>>      if (ret < 0) {
>>          error_setg(errp,
>> @@ -1909,6 +1865,56 @@ static void dump_init(DumpState *s, int fd, bool =
has_format,
>>          }
>>      }
>>
>> +    s->nr_cpus =3D nr_cpus;
>> +    return;
>> +cleanup:
>> +    dump_cleanup(s);
>
>
> Is it intentional and safe to call dump_cleanup() two times from qmp_quer=
y_dump_guest_memory_capability()? Maybe it should only be called by the one=
 who allocated/init it, and thus dropped from this function.
>
>>
>> +}
>> +
>> +static void dump_init_complete(DumpState *s, int fd, bool has_format,
>> +                               DumpGuestMemoryFormat format, bool pagin=
g,
>> +                               bool has_filter, int64_t begin, int64_t =
length,
>> +                               bool kdump_raw, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +
>> +    s->has_format =3D has_format;
>> +    s->format =3D format;
>> +    s->written_size =3D 0;
>> +    s->kdump_raw =3D kdump_raw;
>> +
>> +    /* kdump-compressed is conflict with paging and filter */
>> +    if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
>> +        assert(!paging && !has_filter);
>> +    }
>> +
>> +    s->fd =3D fd;
>> +    if (has_filter && !length) {
>> +        error_setg(errp, "parameter 'length' expects a non-zero size");
>> +        goto cleanup;
>> +    }
>> +    s->filter_area_begin =3D begin;
>> +    s->filter_area_length =3D length;
>> +
>> +    /* First index is 0, it's the special null name */
>> +    s->string_table_buf =3D g_array_new(FALSE, TRUE, 1);
>> +    /*
>> +     * Allocate the null name, due to the clearing option set to true
>> +     * it will be 0.
>> +     */
>> +    g_array_set_size(s->string_table_buf, 1);
>> +
>> +    s->total_size =3D dump_calculate_size(s);
>> +#ifdef DEBUG_DUMP_GUEST_MEMORY
>> +    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size)=
;
>> +#endif
>> +
>> +    /* it does not make sense to dump non-existent memory */
>> +    if (!s->total_size) {
>> +        error_setg(errp, "dump: no guest memory to dump");
>> +        goto cleanup;
>> +    }
>> +
>>      /* get memory mapping */
>>      if (paging) {
>>          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, =
errp);
>> @@ -1919,8 +1925,6 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
>>          qemu_get_guest_simple_memory_mapping(&s->list, &s->guest_phys_b=
locks);
>>      }
>>
>> -    s->nr_cpus =3D nr_cpus;
>> -
>>      get_max_mapnr(s);
>>
>>      uint64_t tmp;
>> @@ -2150,11 +2154,6 @@ void qmp_dump_guest_memory(bool paging, const cha=
r *protocol,
>>      }
>>  #endif
>>
>> -    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
>> -        && !win_dump_available(errp)) {
>> -        return;
>> -    }
>> -
>>      if (strstart(protocol, "fd:", &p)) {
>>          fd =3D monitor_get_fd(monitor_cur(), p, errp);
>>          if (fd =3D=3D -1) {
>> @@ -2193,9 +2192,19 @@ void qmp_dump_guest_memory(bool paging, const cha=
r *protocol,
>>
>
> It may be worth adding an ERRP_GUARD since you check *errp.
>
> Why not make dump_preinit() return a bool, true on success, like recommen=
ded by error API docs?
>
>
>>
>>      s =3D &dump_state_global;
>>      dump_state_prepare(s);
>> +    dump_preinit(s, errp);
>> +    if (*errp) {
>> +        qatomic_set(&s->status, DUMP_STATUS_FAILED);
>> +        return;
>> +    }
>> +
>> +    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
>> +        && !win_dump_available(s, errp)) {
>> +        return;
>> +    }
>>
>> -    dump_init(s, fd, has_format, format, paging, has_begin,
>> -              begin, length, kdump_raw, errp);
>> +    dump_init_complete(s, fd, has_format, format, paging, has_begin,
>> +                       begin, length, kdump_raw, errp);
>>      if (*errp) {
>>          qatomic_set(&s->status, DUMP_STATUS_FAILED);
>>          return;
>> @@ -2218,6 +2227,13 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_m=
emory_capability(Error **errp)
>>                                    g_new0(DumpGuestMemoryCapability, 1);
>>      DumpGuestMemoryFormatList **tail =3D &cap->formats;
>
>
> Same for ERRP_GUARD
>
>>
>>
>> +    DumpState *s =3D g_new0(DumpState, 1);
>> +    dump_state_prepare(s);
>> +    dump_preinit(s, errp);
>> +    if (*errp) {
>> +        goto cleanup;
>> +    }
>> +
>>      /* elf is always available */
>>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);
>>
>> @@ -2237,9 +2253,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_m=
emory_capability(Error **errp)
>>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
>>  #endif
>>
>> -    if (win_dump_available(NULL)) {
>> +    if (win_dump_available(s, NULL)) {
>>          QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_WIN_DMP);
>>      }
>>
>> + cleanup:
>> +    dump_cleanup(s);
>> +    g_free(s);
>>      return cap;
>>  }
>> diff --git a/dump/win_dump.c b/dump/win_dump.c
>> index 3162e8bd48..d42427feb2 100644
>> --- a/dump/win_dump.c
>> +++ b/dump/win_dump.c
>> @@ -20,8 +20,25 @@
>>
>>  #if defined(TARGET_X86_64)
>>
>> -bool win_dump_available(Error **errp)
>> +static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
>> +
>> +bool win_dump_available(DumpState *s, Error **errp)
>>  {
>> +    WinDumpHeader *h =3D (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_H=
DR_SIZE);
>> +    Error *local_err =3D NULL;
>> +    bool x64 =3D true;
>> +
>> +    if (s->guest_note_size !=3D VMCOREINFO_WIN_DUMP_NOTE_SIZE32 &&
>> +            s->guest_note_size !=3D VMCOREINFO_WIN_DUMP_NOTE_SIZE64) {
>> +        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
>> +        return false;
>> +    }
>> +
>> +    if (!check_header(h, &x64, &local_err)) {
>> +        error_propagate(errp, local_err);
>> +        return false;
>> +    }
>>
>> +
>>      return true;
>>  }
>>
>> @@ -480,7 +497,7 @@ out_cr3:
>>
>>  #else /* !TARGET_X86_64 */
>>
>> -bool win_dump_available(Error **errp)
>> +bool win_dump_available(DumpState *s, Error **errp)
>>  {
>>      error_setg(errp, "Windows dump is only available for x86-64");
>>
>> @@ -489,7 +506,7 @@ bool win_dump_available(Error **errp)
>>
>>  void create_win_dump(DumpState *s, Error **errp)
>>  {
>> -    win_dump_available(errp);
>> +    win_dump_available(s, errp);
>>  }
>>
>>  #endif
>> diff --git a/dump/win_dump.h b/dump/win_dump.h
>> index 9d6cfa47c5..62e19c2527 100644
>> --- a/dump/win_dump.h
>> +++ b/dump/win_dump.h
>> @@ -14,7 +14,7 @@
>>  #include "system/dump.h"
>>
>>  /* Check Windows dump availability for the current target */
>> -bool win_dump_available(Error **errp);
>> +bool win_dump_available(DumpState *s, Error **errp);
>>
>>  void create_win_dump(DumpState *s, Error **errp);
>>
>> --
>> 2.43.5
>>
>
>
> Sadly we still don't have much testing for dump..
>
> thanks



--=20
Marc-Andr=C3=A9 Lureau

