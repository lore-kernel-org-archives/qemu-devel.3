Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2D5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8WlJ-0001dj-4q; Tue, 14 Oct 2025 00:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8WlI-0001dX-42
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8WlF-00006T-Sn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760416544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBk03cKYxLUpl9dq+C26Vstmxv7g1NJXs1bKjEGclYg=;
 b=Uw/DTfzewfm1gmwBLvpzy5WdfPKH7W3MMiS1pZpfXft/qkj1NF7LTpysyvuDpDQdyCaSi4
 xJ1EDFQ7n9PfAqW3cAzc8Rg9TEImSTO/WDBo5mcK2n5YgrCSacBTLQfrfqI8sg79yKwThk
 9Sj597Mswvg/wb5B51UtJAqsbectCSI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ho39Lo7rOBWKL-PmKv89Qg-1; Tue, 14 Oct 2025 00:35:42 -0400
X-MC-Unique: ho39Lo7rOBWKL-PmKv89Qg-1
X-Mimecast-MFC-AGG-ID: ho39Lo7rOBWKL-PmKv89Qg_1760416541
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32ee4998c50so9164267a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 21:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760416541; x=1761021341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBk03cKYxLUpl9dq+C26Vstmxv7g1NJXs1bKjEGclYg=;
 b=dMfYsyABVr8NyuBh3cI03Lg+j3vxj7v13t/XafbseU2Yp01lXYnmqQECRedXQ4wxYm
 a+8eTO5unM9pJ1FsE9mZ2UWOPY7z7Hc6txKkg3GgNbM3wA+JNwXSscNsZZ1k6f2Dpyq4
 HBU2s+vsBoIiyJpm652uPxMj28brxyf3oO1jpgq9zwSR2AVjfpXqKheay4yK8HBuxD9m
 Ad6iB/wTYbDYZn7aV98vWpBIrUtAH1rZDsdvqbjpi8i2GwGNKP3LLXT6AxomrGuLY7gI
 QcBxjT3UWPVu2FOJ7jS0CkLlta5Di+jmXhayElNXg/6o3vgDvuvjn6sOmvOwkIP6MxkM
 nk9g==
X-Gm-Message-State: AOJu0Yy70isrz4nHLzHoyg/RazGi6LlyMgOf5TUNuO6mizuxa26fgrEV
 tN5CzfJ29yja1dRjMVLDl1s2cqFi6icIPsUBw64SuOSrzQHKGttFwXdMIIRQTXJSjhbYKYakJ0H
 4+xW1asvpwVtdEXKlmkurwehgnSFWzxFEJRf8JPHFRcMP8Uq0Kl2Bp47K2zQopLGkyX73HXI5tB
 +AuaGCQqFt6buRxHqy8gbhm/wK4kKMJL91xNmMWBePTA==
X-Gm-Gg: ASbGncuK+eot8KlWnUeiqWbxC1Kq4MApbNmBRMKx4hsfiG2e8Pq+Z/I7TMvkueY5fk4
 wacJIeHF0YDYpecr+YAd/JslPpOVqk8kpUvrfLoaSnskxTG3GpWbxUkrBX+QkwWaa/GovYUqDRN
 WBaEP1eIT7LUT3fMcd68tcTA==
X-Received: by 2002:a17:90b:1b05:b0:32e:7270:94a0 with SMTP id
 98e67ed59e1d1-33b513990c7mr34544048a91.33.1760416540638; 
 Mon, 13 Oct 2025 21:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQmyW1q8h9njiH+XQqJ7VI4piZF2ODaiHLfFokZdVUM1TFfYHtvfU6cOIh8WIf4cbDMODx94jKn/v2krJj7YM=
X-Received: by 2002:a17:90b:1b05:b0:32e:7270:94a0 with SMTP id
 98e67ed59e1d1-33b513990c7mr34544025a91.33.1760416540202; Mon, 13 Oct 2025
 21:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
 <20250924-fix-win32-multiple-taps-v3-1-9335df866c14@gmail.com>
In-Reply-To: <20250924-fix-win32-multiple-taps-v3-1-9335df866c14@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 12:35:28 +0800
X-Gm-Features: AS18NWDEwP5XucjZElXAz9QJe7BgOSUK_CpEWGCORbT5_NOJfMdIUTgjqN_v6CQ
Message-ID: <CACGkMEtv=JyKKkcXegr2X1xnmEksCdrgD97LUM93Z+5fhMo7cA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tap-win32: cleanup leaked handles on tap close
To: Gal Horowitz <galush.horowitz@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 10:50=E2=80=AFPM Gal Horowitz <galush.horowitz@gmai=
l.com> wrote:
>
> Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> ---
>  net/tap-win32.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 38baf90e0b3f121f74eb32f1bff779c84ce03114..1a79e35c2708eae32ccdbc873=
908aa1ccc7a03f0 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -104,6 +104,7 @@ typedef struct tap_win32_overlapped {
>      HANDLE output_queue_semaphore;
>      HANDLE free_list_semaphore;
>      HANDLE tap_semaphore;
> +    HANDLE thread_handle;
>      CRITICAL_SECTION output_queue_cs;
>      CRITICAL_SECTION free_list_cs;
>      OVERLAPPED read_overlapped;
> @@ -604,7 +605,6 @@ static int tap_win32_open(tap_win32_overlapped_t **ph=
andle,
>          unsigned long debug;
>      } version;
>      DWORD version_len;
> -    DWORD idThread;
>
>      if (preferred_name !=3D NULL) {
>          snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name)=
;
> @@ -647,13 +647,31 @@ static int tap_win32_open(tap_win32_overlapped_t **=
phandle,
>
>      tap_win32_overlapped_init(&tap_overlapped, handle);
>
> +    tap_overlapped.thread_handle =3D CreateThread(NULL, 0,
> +        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);

Should we check the return value of CreateThread() ?

> +
>      *phandle =3D &tap_overlapped;
>
> -    CreateThread(NULL, 0, tap_win32_thread_entry,
> -                 (LPVOID)&tap_overlapped, 0, &idThread);
>      return 0;
>  }
>
> +static void tap_win32_close(tap_win32_overlapped_t *overlapped)
> +{
> +    TerminateThread(overlapped->thread_handle, 0);
> +
> +    CloseHandle(overlapped->tap_semaphore);
> +    CloseHandle(overlapped->free_list_semaphore);
> +    CloseHandle(overlapped->output_queue_semaphore);
> +
> +    DeleteCriticalSection(&overlapped->free_list_cs);
> +    DeleteCriticalSection(&overlapped->output_queue_cs);
> +
> +    CloseHandle(overlapped->write_event);
> +    CloseHandle(overlapped->read_event);
> +
> +    CloseHandle(overlapped->handle);
> +}
> +
>  /********************************************/
>
>   typedef struct TAPState {
> @@ -667,9 +685,8 @@ static void tap_cleanup(NetClientState *nc)
>
>      qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
>
> -    /* FIXME: need to kill thread and close file handle:
> -       tap_win32_close(s);
> -    */
> +    tap_win32_close(s->handle);
> +    s->handle =3D NULL;
>  }
>
>  static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_=
t size)
>
> --
> 2.34.1
>

Thanks


