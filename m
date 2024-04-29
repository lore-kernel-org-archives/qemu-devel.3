Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C147C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Nw7-0005sF-6k; Mon, 29 Apr 2024 06:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s1Nw4-0005rr-Vz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s1Nw2-0005cr-Qi
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714385312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVcDQkog+vdLU143HYkdf3JAghOQDbvNwkEsr83xIoQ=;
 b=a0tX0BG20jh2aiRnDTvuN9vZ0K44CKSOEr1WZU2CSxF0Mo/TYHU2xjnaLIXAoWM5CNwrFN
 73qfKqH7MD8kJnkl9hKWFmjMZptp+QawuaQmCNQcMAiUtAfbE30Ru8siQa6GCQFH9SazkG
 H3uyesqd9nPgbBt+TtlDWDmKi7fHWxI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-B59ng42KOEG6PmhAwuTO0A-1; Mon, 29 Apr 2024 06:08:30 -0400
X-MC-Unique: B59ng42KOEG6PmhAwuTO0A-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-61b3518eb6bso86354947b3.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714385310; x=1714990110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NVcDQkog+vdLU143HYkdf3JAghOQDbvNwkEsr83xIoQ=;
 b=r0qRYZDgit5qGCZF+gL00edJFXiOwPzMmfLr4EY7D/ky8lFqxTp1V+TVGTxDPKHH6Z
 WjOkt0KOzgnKpLXx3FzYa5QoAFJMpdU6IJZ98xflN2MgMok++WAeyuj18bLOTJL3ugIf
 Mhiou23Rg0b4lr830WIA46hwEOVjxJqJSZcuWjSMYsOvEHT/j5iotJC1yfDh1O1MycvN
 b+rpXScxCY3zx9/YnkCucfqrBq3dZAmtgqBYLqHNQS0GKFvB3b9ZretNBjOChvFL0e+R
 8x7cQvkilUnWYeYgHYCE+IxC0nsVcyeu8oSePttvyQUCsN65qJHFSbPZJ+cK1yr/f7uW
 7x5A==
X-Gm-Message-State: AOJu0YwekMgh+ZKXMAWPL0SLyXxN5LbV8xZ6hVO9QdY/ni8Plmh/A2Is
 eFcDd8AOdDpsZjyTzkTghxYmDu8lJX4chuQae9Az0Wi9ASQO7DmWcLr0ggzvVUe7TCMd62ZFFXw
 Mwo+UlMaoWoyOV7LifFLb6Di+TUqC1TxWFog9+njQuaaKbr4LI/2ef2oJMpR3T0j6gKg1iCclrr
 c/3lDdFUxNSL18rE28HmV6zUrjBz4=
X-Received: by 2002:a05:690c:28f:b0:61a:e48c:38b7 with SMTP id
 bf15-20020a05690c028f00b0061ae48c38b7mr7215654ywb.41.1714385310373; 
 Mon, 29 Apr 2024 03:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSPgTCNUZxV8ELEpIDhO6AfUpOWcjcsbiJzs7Ph9C0Ajz//1vNFMcpWukJUeW5WyDXAaegGmTOl01ZHdhJCJg=
X-Received: by 2002:a05:690c:28f:b0:61a:e48c:38b7 with SMTP id
 bf15-20020a05690c028f00b0061ae48c38b7mr7215641ywb.41.1714385310127; Mon, 29
 Apr 2024 03:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240426162348.684143-1-thuth@redhat.com>
In-Reply-To: <20240426162348.684143-1-thuth@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 29 Apr 2024 13:08:19 +0300
Message-ID: <CAPMcbCrbcqwPfmbLX-DysAnG2wORYCdW9pr_14Xq3DGXr6y9cg@mail.gmail.com>
Subject: Re: [PATCH] qga: Re-enable the qga-ssh-test when running without
 fuzzing
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006b31330617396f11"
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

--0000000000006b31330617396f11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>



On Fri, Apr 26, 2024 at 7:23=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> According to the comment in qga/meson.build, the test got disabled
> since there were problems with the fuzzing job. But instead of
> disabling this test completely, we should still be fine running
> it when fuzzing is disabled.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qga/meson.build | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/qga/meson.build b/qga/meson.build
> index 1c3d2a3d1b..46c1d83d7f 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -181,12 +181,11 @@ test_env =3D environment()
>  test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
>  test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
>
> -# disable qga-ssh-test for now. glib's G_TEST_OPTION_ISOLATE_DIRS trigge=
rs
> +# disable qga-ssh-test with fuzzing: glib's G_TEST_OPTION_ISOLATE_DIRS
> triggers
>  # the leak detector in build-oss-fuzz Gitlab CI test. we should re-enabl=
e
>  # this when an alternative is implemented or when the underlying glib
>  # issue is identified/fix
> -#if host_os !=3D 'windows'
> -if false
> +if host_os !=3D 'windows' and not get_option('fuzzing')
>    srcs =3D [files('commands-posix-ssh.c')]
>    i =3D 0
>    foreach output: qga_qapi_outputs
> --
> 2.44.0
>
>

--0000000000006b31330617396f11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;<div><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><br></=
div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri, Apr 26, 2024 at 7:23=E2=80=AFPM Thomas Huth &lt=
;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">According to the comme=
nt in qga/meson.build, the test got disabled<br>
since there were problems with the fuzzing job. But instead of<br>
disabling this test completely, we should still be fine running<br>
it when fuzzing is disabled.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/meson.build | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 1c3d2a3d1b..46c1d83d7f 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -181,12 +181,11 @@ test_env =3D environment()<br>
=C2=A0test_env.set(&#39;G_TEST_SRCDIR&#39;, meson.current_source_dir())<br>
=C2=A0test_env.set(&#39;G_TEST_BUILDDIR&#39;, meson.current_build_dir())<br=
>
<br>
-# disable qga-ssh-test for now. glib&#39;s G_TEST_OPTION_ISOLATE_DIRS trig=
gers<br>
+# disable qga-ssh-test with fuzzing: glib&#39;s G_TEST_OPTION_ISOLATE_DIRS=
 triggers<br>
=C2=A0# the leak detector in build-oss-fuzz Gitlab CI test. we should re-en=
able<br>
=C2=A0# this when an alternative is implemented or when the underlying glib=
<br>
=C2=A0# issue is identified/fix<br>
-#if host_os !=3D &#39;windows&#39;<br>
-if false<br>
+if host_os !=3D &#39;windows&#39; and not get_option(&#39;fuzzing&#39;)<br=
>
=C2=A0 =C2=A0srcs =3D [files(&#39;commands-posix-ssh.c&#39;)]<br>
=C2=A0 =C2=A0i =3D 0<br>
=C2=A0 =C2=A0foreach output: qga_qapi_outputs<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div>

--0000000000006b31330617396f11--


