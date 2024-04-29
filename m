Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13ECC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Nxt-0006nw-Kw; Mon, 29 Apr 2024 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s1Nxf-0006lS-Sf
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s1Nxd-0005sR-UI
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714385413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdvMBGWE0yNJfobP3ympOhnHaSassbYD1VdudymPSsI=;
 b=dtB9YxNXMuDbGEwXiSwKFimivvRzUQIFA3DAoz3sTyN1AcXyMS7viLjcv1U6AtdBlcgumO
 ZwqokhRNLtbZS6IFdjOb1w2v3np45BOnm8N+bYLgQ074c/EedEjBIv0iPX/9046c3LAFpO
 HlMADypZemxGFGDBUxI84ChuQFep/00=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-vqViO0FrOr6LvnaZnAqnJw-1; Mon, 29 Apr 2024 06:10:11 -0400
X-MC-Unique: vqViO0FrOr6LvnaZnAqnJw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61b2abd30f9so81164957b3.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714385410; x=1714990210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdvMBGWE0yNJfobP3ympOhnHaSassbYD1VdudymPSsI=;
 b=S+Msy4eQtV/z6+nvfD2oNLoKBtyZUmex5YUK00WNSl5PMfehJMwws+R9hRW1w5tIlU
 JVZbk2HyjvYS5t3B2WcfJsd/ww0cCyyXylpmYjmJo3g5uFgEg0Wvn76rHaQLCbiQyo47
 FvKQeTiYXz6Eflt7R42Cqof45zZmVEhDeLqaCg9PSDmlF1o+Efbaa3laWzKJFSuiUsB5
 sr1BVd6W+K+GBZzkm+CiGNcxrNuDeUeZ5YJD+PPbKTgIgT2rMRO6C3E4+E3ust+wiuSh
 G147j7JqnUpaNWjJUys0ulpDXPxIoZHIUloVOGoED09twYlplTme0CCygKpENh1Pgey+
 PQDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtsokcI0/AR2KtLl9l6dbhTN88/puNlNwcgszWlYIdXtA5DxMeEWEIAGyrKGZvVlqBJpeQsracvt1T4nIielf6gZKU7Wo=
X-Gm-Message-State: AOJu0YzWrnBe8rPrrvbSvhRvUBR8np+j2qUDGrl42Vkf5JonZIW9J0iQ
 hJHd8BZtChubj8DaKfaXTHYLXbSAPZvkIVmuX3kjkx3MDw8XzxYyzfaHBtcsTMczbjs6fR+A69j
 Db93FI2rqDTrPBagS9Jc3fdK3K5F7Rhi8b39P5nysHLOf62kEtA54rd125vMkNRy6bxuJIR3/hr
 oj9x+eAp0xAnbrxEiABcDITCs69C0=
X-Received: by 2002:a05:690c:387:b0:61a:999f:e499 with SMTP id
 bh7-20020a05690c038700b0061a999fe499mr10495467ywb.22.1714385410745; 
 Mon, 29 Apr 2024 03:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElfCqvtE+KE4LcVdRO2NWilDRegHoTLMOcLNiRCb/55T1TxmCIbFfWQHsQwlpYDWljW0WoflHy/97nMaSBcb0=
X-Received: by 2002:a05:690c:387:b0:61a:999f:e499 with SMTP id
 bh7-20020a05690c038700b0061a999fe499mr10495452ywb.22.1714385410532; Mon, 29
 Apr 2024 03:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240426121347.18843-1-kkostiuk@redhat.com>
 <20240426121347.18843-2-kkostiuk@redhat.com>
In-Reply-To: <20240426121347.18843-2-kkostiuk@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 29 Apr 2024 13:09:59 +0300
Message-ID: <CAPMcbCrVguBjQzoYNt5ooeU+rBm+dBF8e845uf=H7W8+wVe-FQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] stubs: Add missing qga stubs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000673d2106173975de"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--000000000000673d2106173975de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Are you ok if I merge this patch with other QGA patches?
Or don't you agree with this version of the patch?

Best Regards,
Konstantin Kostiuk.


On Fri, Apr 26, 2024 at 3:15=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Compilation QGA without system and user fails
> ./configure --disable-system --disable-user --enable-guest-agent
>
> Link failure:
>   /usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function
> `os_host_main_loop_wait':
>    ../util/main-loop.c:303: undefined reference to `replay_mutex_unlock'
>    /usr/bin/ld: ../util/main-loop.c:307: undefined reference to
> `replay_mutex_lock'
>    /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
> `error_printf':
>    ../util/error-report.c:38: undefined reference to `error_vprintf'
>    /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
> `vreport':
>    ../util/error-report.c:225: undefined reference to `error_vprintf'
>    /usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function
> `timerlist_run_timers':
>    ../util/qemu-timer.c:562: undefined reference to `replay_checkpoint'
>    /usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to
> `replay_checkpoint'
>    /usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to
> `replay_checkpoint'
>    ninja: build stopped: subcommand failed.
>
> Fixes: 3a15604900 ("stubs: include stubs only if needed")
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  stubs/meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 8ee1fd5753..3b9d42023c 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -21,12 +21,12 @@ if have_block
>    stub_ss.add(files('migr-blocker.c'))
>    stub_ss.add(files('physmem.c'))
>    stub_ss.add(files('ram-block.c'))
> -  stub_ss.add(files('replay-tools.c'))
>    stub_ss.add(files('runstate-check.c'))
>    stub_ss.add(files('uuid.c'))
>  endif
>
>  if have_block or have_ga
> +  stub_ss.add(files('replay-tools.c'))
>    # stubs for hooks in util/main-loop.c, util/async.c etc.
>    stub_ss.add(files('cpus-get-virtual-clock.c'))
>    stub_ss.add(files('icount.c'))
> @@ -45,6 +45,10 @@ if have_block or have_ga
>    stub_ss.add(files('qmp-quit.c'))
>  endif
>
> +if have_ga
> +  stub_ss.add(files('error-printf.c'))
> +endif
> +
>  if have_block or have_user
>    stub_ss.add(files('qtest.c'))
>    stub_ss.add(files('vm-stop.c'))
> --
> 2.44.0
>
>
>

--000000000000673d2106173975de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Paolo,</div><div><br></div><div>Are you ok if I me=
rge this patch with other QGA patches?=C2=A0</div><div>Or don&#39;t you agr=
ee with this version of the patch?</div><div><br></div><div><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></d=
iv></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Apr 26, 2024 at 3:15=E2=80=AFPM Konstantin Kosti=
uk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Compilatio=
n QGA without system and user fails<br>
./configure --disable-system --disable-user --enable-guest-agent<br>
<br>
Link failure:<br>
=C2=A0 /usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function<br>
`os_host_main_loop_wait&#39;:<br>
=C2=A0 =C2=A0../util/main-loop.c:303: undefined reference to `replay_mutex_=
unlock&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/main-loop.c:307: undefined reference to<b=
r>
`replay_mutex_lock&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in functio=
n<br>
`error_printf&#39;:<br>
=C2=A0 =C2=A0../util/error-report.c:38: undefined reference to `error_vprin=
tf&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in functio=
n<br>
`vreport&#39;:<br>
=C2=A0 =C2=A0../util/error-report.c:225: undefined reference to `error_vpri=
ntf&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function<=
br>
`timerlist_run_timers&#39;:<br>
=C2=A0 =C2=A0../util/qemu-timer.c:562: undefined reference to `replay_check=
point&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to<=
br>
`replay_checkpoint&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to<=
br>
`replay_checkpoint&#39;<br>
=C2=A0 =C2=A0ninja: build stopped: subcommand failed.<br>
<br>
Fixes: 3a15604900 (&quot;stubs: include stubs only if needed&quot;)<br>
<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.=
org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com=
" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
---<br>
=C2=A0stubs/meson.build | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/stubs/meson.build b/stubs/meson.build<br>
index 8ee1fd5753..3b9d42023c 100644<br>
--- a/stubs/meson.build<br>
+++ b/stubs/meson.build<br>
@@ -21,12 +21,12 @@ if have_block<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;migr-blocker.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;physmem.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;ram-block.c&#39;))<br>
-=C2=A0 stub_ss.add(files(&#39;replay-tools.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;runstate-check.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;uuid.c&#39;))<br>
=C2=A0endif<br>
<br>
=C2=A0if have_block or have_ga<br>
+=C2=A0 stub_ss.add(files(&#39;replay-tools.c&#39;))<br>
=C2=A0 =C2=A0# stubs for hooks in util/main-loop.c, util/async.c etc.<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;cpus-get-virtual-clock.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;icount.c&#39;))<br>
@@ -45,6 +45,10 @@ if have_block or have_ga<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;qmp-quit.c&#39;))<br>
=C2=A0endif<br>
<br>
+if have_ga<br>
+=C2=A0 stub_ss.add(files(&#39;error-printf.c&#39;))<br>
+endif<br>
+<br>
=C2=A0if have_block or have_user<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;qtest.c&#39;))<br>
=C2=A0 =C2=A0stub_ss.add(files(&#39;vm-stop.c&#39;))<br>
--<br>
2.44.0<br>
<br>
<br>
</blockquote></div>

--000000000000673d2106173975de--


