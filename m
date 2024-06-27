Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D451BC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpA4-0003XF-T4; Thu, 27 Jun 2024 09:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMpA3-0003Wh-Nd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMpA2-0002jP-2F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719494856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/Rbeb6bBrJh9RdgWZ1LVcEw1GsAcQBGaXJ7HYlZH5k=;
 b=C6MrI2zd+43aVSCSlbqr3ID8KO6AoVvhA44g0So605M/Fl+lwT4mUgaUrUiCuqNOWKiF72
 smjn0uJKJPpuH7gKJ8Kp7OwsfWaixtD3K26+omId6UDjkdMhXu2hqqEcQklMmK2LDTc2no
 JFezAR+bAzPvJ7IEptPOZuyuXMHiXSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-_Ho6MGyvMoWJ-GLD9gOf4g-1; Thu, 27 Jun 2024 09:27:34 -0400
X-MC-Unique: _Ho6MGyvMoWJ-GLD9gOf4g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-424fb2df2bdso16782825e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719494853; x=1720099653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/Rbeb6bBrJh9RdgWZ1LVcEw1GsAcQBGaXJ7HYlZH5k=;
 b=UlUpDrI2KvMK8Iqgd2Yk31rEftqqgCpzIMNF49d4pDOJ+KbTuClG2i5wZoZ1WElgHv
 esUtlIcM5uDw4xDObgO82ygg67N2kH0UHlk/mzkMSO/sC99tw1CFSnSG2slOO7Oc3f3k
 piNb4kJ27H0yNHqe0lyCQBvCcJOIo0ZdtcwVExITWMjQ40qJJA2436rDJ2sCS8t6/kJR
 VnZMA8rd3XHyzRiLsTa+66PAy6rR7PD24ZT91NDXwMVadiQJOoI3pTC3orPezU4001OA
 eftphtRLkHb1K2Hh21Xd6gyzjbpmrfg/H7IOq1ZtDNy5l44fO/WrU5Yi59K/P752EGBr
 bGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcKxQv6zS745BDGuP2+3DUMbI9i7hdkzY4dmcSfrl8WsU9Ooh7wQ+cSJxlvdAPff0xv7F1UibsBDrrQYKOaHKQjP9PLY8=
X-Gm-Message-State: AOJu0YwDERvJq4ljUMSxTbovlSPKjwaHZ/cWXn+o2TdUUYhMYmYNr7mO
 6QCMjsFmrtmkO/HANs2HLFBUvsrsOIcxbA3waQkypcMrn1XYff1baedkPweH7xq+5CkN7OCt0mz
 hpp0nx7am59Bp6SnHFDm/vXeOp/TS3vu5fAn5iItkhulOeXAwNAmO4tW8a+KPM3y66qYrNpiXE0
 DDRoNWb7XKV4iKXCGrjQjwtyyuIyc=
X-Received: by 2002:a5d:47a5:0:b0:35f:2667:8b4d with SMTP id
 ffacd0b85a97d-366e94db4c5mr13681355f8f.40.1719494853560; 
 Thu, 27 Jun 2024 06:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUzNdGdej9ZsGHNKsa61ukgisdZe4LxoIn2VJX8QJuP5od2cVQhSLAt//6+tEDwFrJfYWASZ5xiVsZ8elHt4E=
X-Received: by 2002:a5d:47a5:0:b0:35f:2667:8b4d with SMTP id
 ffacd0b85a97d-366e94db4c5mr13681333f8f.40.1719494853195; Thu, 27 Jun 2024
 06:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
In-Reply-To: <20240627003134.3447175-1-rkir@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Jun 2024 15:27:20 +0200
Message-ID: <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Roman Kiryanov <rkir@google.com>
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 27, 2024 at 2:32=E2=80=AFAM Roman Kiryanov <rkir@google.com> wr=
ote:
> +        if (qatomic_read(&ts->cb_running)) {
> +            qemu_event_wait(&timer_list->timers_done_ev);
> +        }

qemu_event_wait() already has the right atomic magic, and
ts->cb_running is both redundant (in general), and I think racy (as
implemented in this patch). This stuff is really hard to get right. At
the very least you need a store-release when clearing the flag, and I
think it also has to be read under the mutex (I'm not sure if there's
anything else, I haven't done a full analysis).

But especially, you haven't justified in the commit message _why_ you
need this. Since this problem is not timer-specific, using
aio_bh_schedule_oneshot() or aio_wait_bh_oneshot() to synchronize
everything with the AioContext thread seems like a superior solution
to me.

Paolo

>      }
>  }
>
> @@ -571,9 +576,15 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>          cb =3D ts->cb;
>          opaque =3D ts->opaque;
>
> +        /* prevent timer_del from returning while cb(opaque)
> +         * is still running (by waiting for timers_done_ev).
> +         */
> +        qatomic_set(&ts->cb_running, true);
> +
>          /* run the callback (the timer list can be modified) */
>          qemu_mutex_unlock(&timer_list->active_timers_lock);
>          cb(opaque);
> +        qatomic_set(&ts->cb_running, false);
>          qemu_mutex_lock(&timer_list->active_timers_lock);
>
>          progress =3D true;
> --
> 2.45.2.741.gdbec12cfda-goog
>


