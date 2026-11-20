Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B70606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Amx22ubW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ici4ycw8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSrq-0001bE-L5; Fri, 20 Nov 2026 12:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUSrn-0001a2-2W
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUSrj-00049v-C3
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795197458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4c78hwQ0y8GMZku2QTHnvaiIYcjN2HxjLeMy3EwF7iA=;
 b=Amx22ubWNoYJUvVIOZmj/xDXFhln3UQvtUu/mYsQ6YbqDuRcvBI0hhAvOwHUFytgv1DPsj
 OEM87UrJ8ak6dKl8dE4mi6ex4nxST0+HifPGpNZ36pydochQZHDTFFWPhhOi3d3RdYwP0x
 SuX1Z4w3Fc/7bU7Mpd+jzXmGsdCr8KY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-IV3bawX4OyeKatOgQaJjyg-1; Fri, 20 Nov 2026 17:57:32 +0000
X-MC-Unique: IV3bawX4OyeKatOgQaJjyg-1
X-Mimecast-MFC-AGG-ID: IV3bawX4OyeKatOgQaJjyg_1795197452
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae19907a31so1271139a91.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795197452; cv=none;
 d=google.com; s=arc-20260327;
 b=UFud5iWKokDk/xMmcDFo+jOyszil5Fo3qVYrOTP+k4X6/qDmd4LPLAi+9rCOikLbaO
 GHRPbMq2Mvp+52+MmB/0mbeli4W8WFQS8hFgQZUKf1ZDDm03hhFSNQyS9cOKtupNFX0H
 m2uI1ls9IQgEjuYwREba/i1uPmb2aJNJWKebsIw0dio4awi8yXMVePm4DG5dKe15OIBX
 TPT+0n2WBdzQo/H5Hg+FmX+GvE9LfVeNywaOjfw2XBDyb6Q2d2G+rS94F+rQ0nqClIKv
 DmWU/JgJ7HFFclWtKgqsljh9WnPneVozQtUQ+XMp+sJsopp9Rtjt40bWBXwTJwLx2Kgf
 cBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4c78hwQ0y8GMZku2QTHnvaiIYcjN2HxjLeMy3EwF7iA=;
 fh=pbThSgoZttl6YHHuO9KQpl1t16R3eq6ml6vnzY3/Gzc=;
 b=YExOj3GVcG6RBdF8q1SG8z/NQCOh9A2E2OWV8U0OHfl378avfcIOnqBoIuA8+PAReH
 dKU/0DCepaD4pCUewDCtah4J2H8YuHc/6L30a3s//uYodVZykaY4G5MJB/ijBU2LgPm+
 hb7sNqZ04l6m5+yoc+T7i1hOfXhWdEih7VXyQRnNSQfpeVXQnILaBlacSG4EHYEQSMC6
 D/KepWxHS6nSVRQGEGHLgId/e0ua1KBRg8+P1aCNONgLk/BNQPBZSIEgGoOSdtlJL31i
 L7ygLjPC1AZZjvSvEQpwqH773M8Wy5BOXjAG+Gi84gg0VHB7WRLJPll4rHFW2nQA/1C3
 Uxwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795197452; x=1795802252; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4c78hwQ0y8GMZku2QTHnvaiIYcjN2HxjLeMy3EwF7iA=;
 b=Ici4ycw8L8I6+/QZraUiEvUMzgg5cRRjHj2G+VDGzBDeUIFOQ66CnNkl41jnU9+GVY
 ih6ah+4x6QX7bcxkmVr8GTM4I8SD82k8AKjcBERcXNdRnMWG83c7klj33q/6nWejIMFd
 gpL3uJ9WU8ghFHaD7vpopvEzthVf/scsd7ydaQlzEK+iIKuqYDzcFlfWSagcN97fHWZ+
 ftUp3ekCHMBqb4xBVXMMWqWkY62AOkl1gEzqTR6ZYyLXJ6TnHbiGNeLufiQ3rbF/WpxB
 /d/tqpgHqKALw9hANgCjiq7u99UYpNNtBQBnJb/TqzSN6T0VH4lUbHZWqOQHYKjfn8qx
 y9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795197452; x=1795802252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4c78hwQ0y8GMZku2QTHnvaiIYcjN2HxjLeMy3EwF7iA=;
 b=0elbeywk7zSS8/M9g1OLfLfwcZ1m6epeajAG6cekUD6gzNjypTDEzCLdhdVYEizqpi
 eD4zJj0ESO2DHNTfERCRwN4eWnDDatflyaB+WlTsXwxistL9cijwukcLixBDVQyful99
 BGd3KokDd+YKayKbyfjLa2EHBKtnwDfoHhd6nQwEC4YlMi1sGOVQMnFKj3mF/56eC2I6
 72ZJ5u4cmbs+u5fH2DTY0dWmHwAiOrLlomcmRx1WV6Uhc3YTNOP+mWEJPFVmsgYU1oPu
 KyzHhSZ1wWKDrOncpgr5blbLAUVrRVHFOORa11yIt322RsA9jFNhtNDG7CL+b3E6l24N
 MqKg==
X-Forwarded-Encrypted: i=1;
 AL+hErEm8UwNU6TNXYKU9wp2wb0olIROMgdO0KLJcMqgpzo18PkpRUBt1xyiVbLzNV+38L575CzsIz1yafwK@nongnu.org
X-Gm-Message-State: APuU4Z/O7eN0u+W+AhSQHRrrSM9FecyzXmu6LsrRyd/XSQfdkpYztQKM
 k5bSa82AQzVWPMsflQ2JcXCTDKPF6gZC0yx3sY1CKAYjTJZgPLF3od75fkD8cOgemUN+GLlAvp/
 ZV2w9HTexvY4gUXvyHCuZqLx7FtClLAb3acaD3BCiPVqbuIsu0sGKdXVWhnV6mp5oIYzlRGkWiu
 1S0sw084W7mNxoO6MZkW0vFrcRSXA98e8=
X-Gm-Gg: AZFdTZc4GOfupYp+w2QNGH01jBNcWi+qW6HKpmLOUVhVTrRaFBBB45x23U9In5zEUVh
 vWBmOP5h18aCTabThCazFwKjQzBPHOExpIOygNQWPstBihAGFOVLfSwwxZkHSarE9f8okMpshTt
 eHinUjrNPw8ipRhFkk/qpH9uHuF37Z1BJMcrCUeCg0LZdrgjKjIiWl0vrMCLti3tQp1sYctfAVp
 ea9SSHI+ozhf1DgiO1tI2HWRZ5IYW+sOnmTcoQlmJ+wV2cny3mjkSbxtLMWjykwbJVr24tNuZAP
 3g62i8Qrk5er0r9iBg4h
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id
 98e67ed59e1d1-3b41c908147mr2689707a91.21.1795197451650; 
 Fri, 20 Nov 2026 09:57:31 -0800 (PST)
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id
 98e67ed59e1d1-3b41c908147mr2689687a91.21.1795197451165; Fri, 20 Nov 2026
 09:57:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260915203455.580999-1-den@openvz.org>
 <awBz2AP3W6-XNQ9U@redhat.com>
In-Reply-To: <awBz2AP3W6-XNQ9U@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Nov 2026 18:57:20 +0100
X-Gm-Features: AclHuK8Z6fBe_hpVHTV3o5LL-SfBfPp6TLcxho_oUCCajjBDK-NT1t1rSiJjNUQ
Message-ID: <CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU55pcQphR5s81aQ@mail.gmail.com>
Subject: Re: [PATCH 0/10] system: add a watchdog for the Big QEMU Lock
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="00000000000060fca30660b8faef"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000060fca30660b8faef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 20 nov 2026, 17:22 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > Denis V. Lunev (10):
> >   util/qemu-thread: track bql_locked across the timed condvar wait
> >   oslib: add qemu_debugger_attached()
> >   oslib: add qemu_thread_states()
> >   oslib: report kernel stacks in qemu_thread_states()
> >   util/qemu-thread: reserve a signal for thread introspection
> >   oslib: report each thread's program counter
> >   system/cpus: report a BQL held past a deadline
> >   system/cpus: hold off the BQL watchdog under a debugger
> >   system/cpus: add bql-watchdog-abort
> >   tests/functional: cover the BQL watchdog
> >
> >  host/include/aarch64/host/signal-pc.h         |  20 ++
> >  host/include/generic/host/signal-pc.h         |  11 +
> >  host/include/loongarch64/host/signal-pc.h     |  20 ++
> >  host/include/ppc64/host/signal-pc.h           |  22 ++
> >  host/include/riscv64/host/signal-pc.h         |  20 ++
> >  host/include/s390x/host/signal-pc.h           |  20 ++
> >  host/include/x86_64/host/signal-pc.h          |  20 ++
> >  hw/core/machine.c                             |  44 +++
> >  include/qemu/osdep.h                          |  29 ++
> >  include/system/cpus.h                         |   8 +
> >  meson.build                                   |   2 +
> >  qemu-options.hx                               |  11 +
> >  system/cpus.c                                 | 143 ++++++++
> >  tests/functional/generic/meson.build          |   1 +
> >  tests/functional/generic/test_bql_watchdog.py |  60 ++++
> >  util/oslib-posix.c                            | 316 ++++++++++++++++++
>
> As a general point that doesn't fit any single patch, IMHO
> it is undesirable to be putting all this logic into the
> oslib-posix.c file.
>
> It likely justifies being put into a standalone file eg a
> new 'debug.c'
>

Also, this cover letter text is blatantly AI-generated. Neither the
existing nor the in-progress policy allow cut and paste from LLMs.

I am generally in favor of AI use, but not of cut and paste. If you didn't
put any effort in writing it, and don't even bother to say so, I won't put
any effort in reading it.

Paolo


>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--00000000000060fca30660b8faef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 20 nov 2026, 17:22 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer"=
>berrange@redhat.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; Denis V. Lunev (10):<br>
&gt;=C2=A0 =C2=A0util/qemu-thread: track bql_locked across the timed condva=
r wait<br>
&gt;=C2=A0 =C2=A0oslib: add qemu_debugger_attached()<br>
&gt;=C2=A0 =C2=A0oslib: add qemu_thread_states()<br>
&gt;=C2=A0 =C2=A0oslib: report kernel stacks in qemu_thread_states()<br>
&gt;=C2=A0 =C2=A0util/qemu-thread: reserve a signal for thread introspectio=
n<br>
&gt;=C2=A0 =C2=A0oslib: report each thread&#39;s program counter<br>
&gt;=C2=A0 =C2=A0system/cpus: report a BQL held past a deadline<br>
&gt;=C2=A0 =C2=A0system/cpus: hold off the BQL watchdog under a debugger<br=
>
&gt;=C2=A0 =C2=A0system/cpus: add bql-watchdog-abort<br>
&gt;=C2=A0 =C2=A0tests/functional: cover the BQL watchdog<br>
&gt; <br>
&gt;=C2=A0 host/include/aarch64/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 20 ++<br>
&gt;=C2=A0 host/include/generic/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 11 +<br>
&gt;=C2=A0 host/include/loongarch64/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 20 ++<br>
&gt;=C2=A0 host/include/ppc64/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 22 ++<br>
&gt;=C2=A0 host/include/riscv64/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 20 ++<br>
&gt;=C2=A0 host/include/s390x/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 20 ++<br>
&gt;=C2=A0 host/include/x86_64/host/signal-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 20 ++<br>
&gt;=C2=A0 hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 44 +++<b=
r>
&gt;=C2=A0 include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 29 ++<br>
&gt;=C2=A0 include/system/cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +<=
br>
&gt;=C2=A0 system/cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 143 =
++++++++<br>
&gt;=C2=A0 tests/functional/generic/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 tests/functional/generic/test_bql_watchdog.py |=C2=A0 60 ++++<br=
>
&gt;=C2=A0 util/oslib-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 316 ++++++++++++++++=
++<br>
<br>
As a general point that doesn&#39;t fit any single patch, IMHO<br>
it is undesirable to be putting all this logic into the<br>
oslib-posix.c file.<br>
<br>
It likely justifies being put into a standalone file eg a<br>
new &#39;debug.c&#39;<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Also, this cover letter text is blatantly AI-generated=
. Neither the existing nor the in-progress policy allow cut and paste from =
LLMs.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I am generally in =
favor of AI use, but not of cut and paste. If you didn&#39;t put any effort=
 in writing it, and don&#39;t even bother to say so, I won&#39;t put any ef=
fort in reading it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paol=
o=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://hachyderm.i=
o/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.=
org" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://ent=
angle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer n=
oreferrer" target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0=
~~=C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer=
 noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange.com</a>=
 :|<br>
<br>
</blockquote></div></div></div>

--00000000000060fca30660b8faef--


