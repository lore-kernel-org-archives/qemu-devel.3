Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF8C3601E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqYoL-0006zT-Fz; Tue, 17 Sep 2024 10:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sqYSA-0002rb-0L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sqYS7-0002xA-Rj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726580470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nv3DoGqc8y9fBG9LGMiYslh5LNFFdsbAyUx2/jBXVXQ=;
 b=iy7ENu0ze7eaFxKPkj6KgzHN/d7TLLsdAnYgqCJPA4FfgFI8MMeY41MgTBExzsCHIVWFQ/
 amzUH7JMF9M14CtMzDbiNIOLCGfvIqlRoDqUe4g3lNr8y+4TTCDJIcFKyulc5nWFZw9+RU
 RwEE7kQ+WPGK8ClX5LoNb8C8UH5azoQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-TyzTyno2NTebirwWLZGgCA-1; Tue, 17 Sep 2024 09:40:00 -0400
X-MC-Unique: TyzTyno2NTebirwWLZGgCA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2db24468f94so6414078a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 06:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726580399; x=1727185199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nv3DoGqc8y9fBG9LGMiYslh5LNFFdsbAyUx2/jBXVXQ=;
 b=ab09xUZTKNGkVE0xlvEBmOtRupNWV5pTf/ZyLVxjhTxPy3/8Ijt6+2J3gL35IIsy95
 I9UeASLcYEL2z9ZrM5GEhHEYfdEYZxY40khwNOmwjxGNbtq6JRLcn7PzCKKb1oi/Pb98
 BJA7R6GaVmP8iStGlSlWLVmMi0FD5gdRZh6sOb/ewFYkg8/cgii7wO03xCNceBdiM4T3
 Fth3u0NDsmG81V9U+kOND+zpJJkHzmRto44mlQ+NnXlhVCYgGis1C3p9O8vbz2dXvvgF
 /XRMOM3ibWaeY9hLMiZTKYEVW/NQQYV/bw/vi9VpUU3fvW/Nx7kM4XnHymClIqhJyZl8
 BVfA==
X-Gm-Message-State: AOJu0YwxUKLRVUKvTSHukxZQlpWMsXq0ayd+8MHztWzz6D4cm/0VOtyP
 vvozNAYvE5uJTGDXlljtL7QHk77/Enpe2M+8k5m5pYctxGGcBMJeeH8FA9YafVbMmtGfjJQ4Maq
 Pg82sHRDpKf06c6flI8mnATkaTT88YWja+rXKrI+yuBTpkN+QUo2ZIf263h9c17sKGucIgWJwvW
 LvokKpt+SrYKubMCASEZ9JfehZ5nk=
X-Received: by 2002:a17:90b:4d91:b0:2d8:d094:9725 with SMTP id
 98e67ed59e1d1-2db9fe8d9aemr20123811a91.0.1726580399563; 
 Tue, 17 Sep 2024 06:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkZPtFVfTw9ib4t3cLhxXMU8xTgTRTt9Ph4rHMk7FsLxA+ZxZZK0rhi2u8wwEYl9Vtv4OAgkjXAGU2XTmcbn4=
X-Received: by 2002:a17:90b:4d91:b0:2d8:d094:9725 with SMTP id
 98e67ed59e1d1-2db9fe8d9aemr20123788a91.0.1726580399077; Tue, 17 Sep 2024
 06:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725607795.git.mvogt@redhat.com>
In-Reply-To: <cover.1725607795.git.mvogt@redhat.com>
From: Michael Vogt <mvogt@redhat.com>
Date: Tue, 17 Sep 2024 15:39:47 +0200
Message-ID: <CAGAEagH0X-+8-Nbz5wjCdSmcv_9qv3SignxuF7X=8swimKyzag@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] linux-user: add openat2 support in linux-user
To: Michael Vogt <michael.vogt@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000005d16c5062250d324"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Sep 2024 10:04:07 -0400
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

--0000000000005d16c5062250d324
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

friendly ping (see also
https://patchew.org/QEMU/cover.1725607795.git.mvogt@redhat.com/)

Please let me know if there is anything I can do to make this easier to
review or if I should split or help otherwise.

On Fri, Sep 6, 2024 at 9:39=E2=80=AFAM Michael Vogt <michael.vogt@gmail.com=
> wrote:

> Hi,
>
> This is v4 of the openat2 support in linux-user. Thanks again for the
> excellent second round of feedback from Richard Henderson.
>
> The code is identical to the previous v3 and I only fixed two typos in
> the commit message. I'm sending v4 because in v3 I forgot to add
> "--threaded" when generating the coverletter/patch which makes it a bit
> awkward to review and it does not show up properly on
> e.g. https://patchew.org/QEMU/. My apologies for this mistake.
>
> This version tries to be closer to the kernels behavior, i.e. now
> do_openat2() uses a new copy_struct_from_user() helper that is very
> similar to the kernels. This lead me to also drop incuding openat2.h
> (as was originally suggested in the v1 review). It now contains it as
> a copy named `struct open_how_ver0` and with that we can LOG_UNIMP if
> the struct ever grows and qemu-user needs updating.
>
> To answer the question why "maybe_do_fake_open()" uses a
> "use_returned_fd" bool instead of just returning "-1": I wanted to be
> as close as possible to the previous behavior and maybe_fake_open()
> could in theory return "-1" for failures in memfd_create() or
> mkstemp() or fake_open->fill(). In those cases the old code in
> do_guest_openat() failed and returned the error but the new code would
> just see a -1 and continue trying to open a special file that should
> have been faked. Maybe I did overthink this as it's very
> corner-case-y. Advise is welcome here, happy to change back or
> simplify in other ways.
>
> Thanks again,
>  Michael
>
> v3 -> v4:
> - fix typos in the commit message
>
> v2 -> v3:
> - fix coding style (braches)
> - improve argument args/naming in do_openat2()
> - merge do_openat2/do_guest_openat2
> - do size checks first in do_openat2
> - add "copy_struct_from_user" and use in "do_openat2()"
> - drop using openat2.h and create "struct open_how_v0"
> - log if open_how guest struct is bigger than our supported struct
>
> v1 -> v2:
> - do not include <sys/syscall.h>
> - drop do_guest_openat2 from qemu.h and make static
> - drop "safe" from do_guest_openat2
> - ensure maybe_do_fake_open() is correct about when the result should
>   be used or not
> - Extract do_openat2() helper from do_syscall1()
> - Call user_unlock* if a lock call fails
> - Fix silly incorrect use of "target_open_how" when "open_how" is require=
d
> - Fix coding style comments
> - Fix validation of arg4 in openat2
> - Fix missing zero initialization of open_how
> - Define target_open_how with abi_* types
> - Warn about unimplemented size if "size" of openat2 is bigger than
>   target_open_how
>
>
> Michael Vogt (1):
>   linux-user: add openat2 support in linux-user
>
>  linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
>  linux-user/syscall_defs.h |   7 +++
>  2 files changed, 119 insertions(+), 4 deletions(-)
>
> --
> 2.45.2
>
>

--0000000000005d16c5062250d324
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>friendly ping (see also <a href=3D"https://patchew.or=
g/QEMU/cover.1725607795.git.mvogt@redhat.com/">https://patchew.org/QEMU/cov=
er.1725607795.git.mvogt@redhat.com/</a>)</div><div><br></div><div>Please le=
t me know if there is anything I can do to make this easier to review or if=
 I should split or help otherwise.<br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 6, 2024 at 9:39=E2=
=80=AFAM Michael Vogt &lt;<a href=3D"mailto:michael.vogt@gmail.com">michael=
.vogt@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<br>
This is v4 of the openat2 support in linux-user. Thanks again for the<br>
excellent second round of feedback from Richard Henderson.<br>
<br>
The code is identical to the previous v3 and I only fixed two typos in<br>
the commit message. I&#39;m sending v4 because in v3 I forgot to add<br>
&quot;--threaded&quot; when generating the coverletter/patch which makes it=
 a bit<br>
awkward to review and it does not show up properly on<br>
e.g. <a href=3D"https://patchew.org/QEMU/" rel=3D"noreferrer" target=3D"_bl=
ank">https://patchew.org/QEMU/</a>. My apologies for this mistake.<br>
<br>
This version tries to be closer to the kernels behavior, i.e. now<br>
do_openat2() uses a new copy_struct_from_user() helper that is very<br>
similar to the kernels. This lead me to also drop incuding openat2.h<br>
(as was originally suggested in the v1 review). It now contains it as<br>
a copy named `struct open_how_ver0` and with that we can LOG_UNIMP if<br>
the struct ever grows and qemu-user needs updating.<br>
<br>
To answer the question why &quot;maybe_do_fake_open()&quot; uses a<br>
&quot;use_returned_fd&quot; bool instead of just returning &quot;-1&quot;: =
I wanted to be<br>
as close as possible to the previous behavior and maybe_fake_open()<br>
could in theory return &quot;-1&quot; for failures in memfd_create() or<br>
mkstemp() or fake_open-&gt;fill(). In those cases the old code in<br>
do_guest_openat() failed and returned the error but the new code would<br>
just see a -1 and continue trying to open a special file that should<br>
have been faked. Maybe I did overthink this as it&#39;s very<br>
corner-case-y. Advise is welcome here, happy to change back or<br>
simplify in other ways.<br>
<br>
Thanks again,<br>
=C2=A0Michael<br>
<br>
v3 -&gt; v4:<br>
- fix typos in the commit message<br>
<br>
v2 -&gt; v3:<br>
- fix coding style (braches)<br>
- improve argument args/naming in do_openat2()<br>
- merge do_openat2/do_guest_openat2<br>
- do size checks first in do_openat2<br>
- add &quot;copy_struct_from_user&quot; and use in &quot;do_openat2()&quot;=
<br>
- drop using openat2.h and create &quot;struct open_how_v0&quot;<br>
- log if open_how guest struct is bigger than our supported struct<br>
<br>
v1 -&gt; v2:<br>
- do not include &lt;sys/syscall.h&gt;<br>
- drop do_guest_openat2 from qemu.h and make static<br>
- drop &quot;safe&quot; from do_guest_openat2<br>
- ensure maybe_do_fake_open() is correct about when the result should<br>
=C2=A0 be used or not<br>
- Extract do_openat2() helper from do_syscall1()<br>
- Call user_unlock* if a lock call fails<br>
- Fix silly incorrect use of &quot;target_open_how&quot; when &quot;open_ho=
w&quot; is required<br>
- Fix coding style comments<br>
- Fix validation of arg4 in openat2<br>
- Fix missing zero initialization of open_how<br>
- Define target_open_how with abi_* types<br>
- Warn about unimplemented size if &quot;size&quot; of openat2 is bigger th=
an<br>
=C2=A0 target_open_how<br>
<br>
<br>
Michael Vogt (1):<br>
=C2=A0 linux-user: add openat2 support in linux-user<br>
<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 | 116 ++++++++++++++++++++++=
++++++++++++++--<br>
=C2=A0linux-user/syscall_defs.h |=C2=A0 =C2=A07 +++<br>
=C2=A02 files changed, 119 insertions(+), 4 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--0000000000005d16c5062250d324--


