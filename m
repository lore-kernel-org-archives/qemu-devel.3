Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2ABC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3d4-00012Q-05; Mon, 04 Mar 2024 03:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3cz-00011t-Lj
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3cx-0003us-UZ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8zP3MSIF7Wk4V7+B21ehutqPA24cLlvS0BIdYF2dRdE=;
 b=XWeUqbqQXWAsSgB5+I6PeTmU+6fUaiqHJ86r7ReGUxdgj/55dW9lqKoQoBrQzPiP7fbNjj
 Q/RLweKFTxQY0C2hh0+BWa32NwH8/KDtj60S9e/NHBGR35McCNfUeoRnfa9yR4vcB/zaWv
 w5D3pTdHDGwTlBfOmhmEbg0bpyzevpg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-6ziJkz4CPxWUvc_Zm7aa0w-1; Mon, 04 Mar 2024 03:24:48 -0500
X-MC-Unique: 6ziJkz4CPxWUvc_Zm7aa0w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513297a755dso5216804e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540687; x=1710145487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8zP3MSIF7Wk4V7+B21ehutqPA24cLlvS0BIdYF2dRdE=;
 b=sI1xQX4rUkdajPBYIQwPlpVYvqTMbtycDyws8J/omoREpv/MaNhl/6F9Yi9HjnslUc
 iCWDRyzglrjLj2OJsmMuccNd5A3Qt/x8ENCkFdpTB9hGeo06tlevZNY2GbUv+Jbr4yJ+
 JTiWkQ2qRymMFucNb/sYEldAuMW4FOoEKOkcWytMoFMFnVuIPo43sHc5Mmcn6ti3y/zt
 5hh311Pq4l0AODyVstHcxGn+1u2w2u3wt8JbWeMsT5NrjWP8AE2rWxWOZmM+u4rJVg1b
 bu9z7m5rEKmcH+6jq0eFiaFsUra6JM4MWpNcA3pLYtjHkdouYMOmzaUVE2nPqWa1X7Je
 pPQg==
X-Gm-Message-State: AOJu0YwA9/PtsG/6gWF/whnZMnCkOqnwOyytFjuOZZb3bdT+g0OH2Awm
 mYSYEh/KzgT+C7vA/D+oaewkMa0mlMnF3iSvYIVkyamCXCasK++PtqHdgKRU4cJ9SVY+hchv1P0
 /tfqxrCLGjGIoGxs1YYRroiFT1vCG1TYhRx6ONRhDhRGbS0sj9EmCR/TCXPimDZR/E/Df6m5ba4
 kRZcHBoKynHNUkWr5TDr2wn26ZXSM=
X-Received: by 2002:ac2:5dc7:0:b0:513:22d3:c9a9 with SMTP id
 x7-20020ac25dc7000000b0051322d3c9a9mr5266524lfq.27.1709540687034; 
 Mon, 04 Mar 2024 00:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7HCzftyfoM41IscbSzHVAHGlGim/lw0mcJh7lVzve2gwo9y4TrQ48jQqONi65ALPahbUu0EE5DU50jrlVDu8=
X-Received: by 2002:ac2:5dc7:0:b0:513:22d3:c9a9 with SMTP id
 x7-20020ac25dc7000000b0051322d3c9a9mr5266510lfq.27.1709540686740; Mon, 04 Mar
 2024 00:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
 <20240227113921.236097-11-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-11-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 10:24:36 +0200
Message-ID: <CAPMcbCqUNQu4euaSCmD56Hou_VCYxVh9JoaSM-OsdHy1ivwmNw@mail.gmail.com>
Subject: Re: [PATCH 10/13] qga/qapi-schema: Clean up "Returns" sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005ccf960612d175ee"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000005ccf960612d175ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Drop "on success" where it is redundant with "Returns:".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 636c2c5697..326d324901 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -228,7 +228,7 @@
>  #
>  # @mode: open mode, as per fopen(), "r" is the default.
>  #
> -# Returns: Guest file handle on success.
> +# Returns: Guest file handle
>  #
>  # Since: 0.15.0
>  ##
> @@ -277,7 +277,7 @@
>  # @count: maximum number of bytes to read (default is 4KB, maximum is
>  #     48MB)
>  #
> -# Returns: @GuestFileRead on success.
> +# Returns: @GuestFileRead
>  #
>  # Since: 0.15.0
>  ##
> @@ -312,7 +312,7 @@
>  # @count: bytes to write (actual bytes, after base64-decode), default
>  #     is all content in buf-b64 buffer after base64 decoding
>  #
> -# Returns: @GuestFileWrite on success.
> +# Returns: @GuestFileWrite
>  #
>  # Since: 0.15.0
>  ##
> @@ -379,7 +379,7 @@
>  #
>  # @whence: Symbolic or numeric code for interpreting offset
>  #
> -# Returns: @GuestFileSeek on success.
> +# Returns: @GuestFileSeek
>  #
>  # Since: 0.15.0
>  ##
> @@ -723,7 +723,7 @@
>  #
>  # Get list of guest IP addresses, MAC addresses and netmasks.
>  #
> -# Returns: List of GuestNetworkInterface on success.
> +# Returns: List of GuestNetworkInterface
>  #
>  # Since: 1.1
>  ##
> @@ -1247,7 +1247,7 @@
>  #
>  # @pid: pid returned from guest-exec
>  #
> -# Returns: GuestExecStatus on success.
> +# Returns: GuestExecStatus
>  #
>  # Since: 2.5
>  ##
> @@ -1315,7 +1315,7 @@
>  # @capture-output: bool flag to enable capture of stdout/stderr of
>  #     running process.  defaults to false.
>  #
> -# Returns: PID on success.
> +# Returns: PID
>  #
>  # Since: 2.5
>  ##
> @@ -1344,7 +1344,7 @@
>  # or even present in DNS or some other name service at all.  It need
>  # not even be unique on your local network or site, but usually it is.
>  #
> -# Returns: the host name of the machine on success
> +# Returns: the host name of the machine
>  #
>  # Since: 2.10
>  ##
> --
> 2.43.0
>
>

--0000000000005ccf960612d175ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 2=
7, 2024 at 1:39=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Drop &quot;on success&quot; where it is redunda=
nt with &quot;Returns:&quot;.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 16 ++++++++--------<br>
=C2=A01 file changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 636c2c5697..326d324901 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -228,7 +228,7 @@<br>
=C2=A0#<br>
=C2=A0# @mode: open mode, as per fopen(), &quot;r&quot; is the default.<br>
=C2=A0#<br>
-# Returns: Guest file handle on success.<br>
+# Returns: Guest file handle<br>
=C2=A0#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
@@ -277,7 +277,7 @@<br>
=C2=A0# @count: maximum number of bytes to read (default is 4KB, maximum is=
<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A048MB)<br>
=C2=A0#<br>
-# Returns: @GuestFileRead on success.<br>
+# Returns: @GuestFileRead<br>
=C2=A0#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
@@ -312,7 +312,7 @@<br>
=C2=A0# @count: bytes to write (actual bytes, after base64-decode), default=
<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0is all content in buf-b64 buffer after base64 de=
coding<br>
=C2=A0#<br>
-# Returns: @GuestFileWrite on success.<br>
+# Returns: @GuestFileWrite<br>
=C2=A0#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
@@ -379,7 +379,7 @@<br>
=C2=A0#<br>
=C2=A0# @whence: Symbolic or numeric code for interpreting offset<br>
=C2=A0#<br>
-# Returns: @GuestFileSeek on success.<br>
+# Returns: @GuestFileSeek<br>
=C2=A0#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
@@ -723,7 +723,7 @@<br>
=C2=A0#<br>
=C2=A0# Get list of guest IP addresses, MAC addresses and netmasks.<br>
=C2=A0#<br>
-# Returns: List of GuestNetworkInterface on success.<br>
+# Returns: List of GuestNetworkInterface<br>
=C2=A0#<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
@@ -1247,7 +1247,7 @@<br>
=C2=A0#<br>
=C2=A0# @pid: pid returned from guest-exec<br>
=C2=A0#<br>
-# Returns: GuestExecStatus on success.<br>
+# Returns: GuestExecStatus<br>
=C2=A0#<br>
=C2=A0# Since: 2.5<br>
=C2=A0##<br>
@@ -1315,7 +1315,7 @@<br>
=C2=A0# @capture-output: bool flag to enable capture of stdout/stderr of<br=
>
=C2=A0#=C2=A0 =C2=A0 =C2=A0running process.=C2=A0 defaults to false.<br>
=C2=A0#<br>
-# Returns: PID on success.<br>
+# Returns: PID<br>
=C2=A0#<br>
=C2=A0# Since: 2.5<br>
=C2=A0##<br>
@@ -1344,7 +1344,7 @@<br>
=C2=A0# or even present in DNS or some other name service at all.=C2=A0 It =
need<br>
=C2=A0# not even be unique on your local network or site, but usually it is=
.<br>
=C2=A0#<br>
-# Returns: the host name of the machine on success<br>
+# Returns: the host name of the machine<br>
=C2=A0#<br>
=C2=A0# Since: 2.10<br>
=C2=A0##<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000005ccf960612d175ee--


