Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58304C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ToN-00070j-Oj; Thu, 17 Apr 2025 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5To7-0006lQ-KY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5To3-0004Tp-EO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744913866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wRC2FtIJrxlZog4Rd2GDFKZ3EONccmgYGAEEMv5D+nE=;
 b=gis8JhQiZ+JJWvJwm1rNDTr/f0Vvm+2ohGZokxt2cLaRr/BznS7fJ/aTMEnCUN698l4FIr
 /VD3xQueZOIfVe+gLh8TVdjRzqm2ruTxavI2w0WJhvOsWnuUvs+oPEYP2oNXRUBYn75/X5
 fvcVYmtnMIEIDr4+HiXKNHUXth3fOxs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-Iy0juWNmPfaUnTfps4lqSw-1; Thu, 17 Apr 2025 14:17:44 -0400
X-MC-Unique: Iy0juWNmPfaUnTfps4lqSw-1
X-Mimecast-MFC-AGG-ID: Iy0juWNmPfaUnTfps4lqSw_1744913862
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff58318acaso1439473a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913862; x=1745518662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRC2FtIJrxlZog4Rd2GDFKZ3EONccmgYGAEEMv5D+nE=;
 b=g+vkcLIG/IYrbNPp4cfQYzHNSde5gBWTgBTCpWs4WZxRMnYtGbWkyMKZMGHYB7ESFw
 hT4kjexffGS+PY8r0Fv8d0mDmWKCd/tRbAUAOBMqI7jMXx9ZVw6MbNfP4kUJYFLzKSEn
 qb8WzW4EzFw0CGEgffHuvE0NwrLDXkbGrvkiJjyY3HhRFc9NXyM98VPAFrxXORjSN8XI
 IS+DZypBmhXkU3sjEby5oJj48J35mGA0TXTCtxIZOHFYJ4sTPkI7hr8uhe8Mf/q+LxdX
 h75XbS/6Kpv/NwMs7nSgeY3l+e2FznmI15ArzydKIAompY6rV2NGL57hGvzgYfDguVyX
 O0DQ==
X-Gm-Message-State: AOJu0YydWQJbYkLKmiDshyVtZRlI9qGkmXdFe0VNvmVN5lEYRq1i47Ax
 Hcv5kL+DS8LQPoZoc023zR9ONCX+sNHTxIhw1fA+dIFhTqLVCkERE6vzRehd4ygnLzxcbXRjXB3
 70h+gFL1jyoQxV9KSEUwA3iyUcLSGK9kx/HS/rmf5CGibMaG2W71yZ6R4jWqZCoK+xwrO+bo5+X
 6hHiYUmW1ElBWVgzJkPnnJtF+haSg=
X-Gm-Gg: ASbGncvoXr0Y9UPzRsT/2fc3c6QTsp43ih6d7vu9FcRJWJpMuoCWlJnP66Xsfz9BMHI
 jYsLU1/iOFNow53WC7J9zragBp0Ap0RfisTwPLl15N9EAMHCraFr9BHXYx+NX81KD7tdpcbliMD
 lzJANivAuahTdzFmn5R5qvKpdM
X-Received: by 2002:a17:90a:d44d:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-30863d257c3mr11798004a91.2.1744913862040; 
 Thu, 17 Apr 2025 11:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDyRAmLHttVDpXijgvf2hrl5gRlqqC3Wtby2CsWuXBMl+d8nF2+K7kxR+eJsmKG2fh3zOsklf17+Ases8ryII=
X-Received: by 2002:a17:90a:d44d:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-30863d257c3mr11797973a91.2.1744913861780; Thu, 17 Apr 2025
 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250404121413.1743790-1-armbru@redhat.com>
 <20250404121413.1743790-10-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-10-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Apr 2025 14:17:29 -0400
X-Gm-Features: ATxdqUGi77iEHcVt5ib9Czl73wEYqleeFed8zkQBgCcFOyPDPmO6b6g3kGlLvVI
Message-ID: <CAFn=p-bqvkkD5sgdgEVP4cAnCNyTuOFXWJvGBWwiWVVCthZFGQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] qapi/qapi-schema: Address the introduction's bit rot
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com, 
 kwolf@redhat.com, peter.maydell@linaro.org, eblake@redhat.com, 
 jiri@resnulli.us, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e53f520632fd6a41"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000e53f520632fd6a41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 8:14=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Cut the crap that stopped making sense years ago.  Adjust the
> remainder.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qapi-schema.json | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 0d027d5017..7bc600bb76 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -3,37 +3,24 @@
>  ##
>  # =3D Introduction
>  #
> -# This document describes all commands currently supported by QMP.
> +# This manual describes the commands and events supported by the QEMU
> +# Monitor Protocol (QMP).
>  #
>  # For locating a particular item, please see the `qapi-qmp-index`.
>  #
> -# Most of the time their usage is exactly the same as in the user
> -# Monitor, this means that any other document which also describe
> -# commands (the manpage, QEMU's manual, etc) can and should be
> -# consulted.
> -#
> -# QMP has two types of commands: regular and query commands.  Regular
> -# commands usually change the Virtual Machine's state someway, while
> -# query commands just return information.  The sections below are
> -# divided accordingly.
> -#
> -# It's important to observe that all communication examples are
> -# formatted in a reader-friendly way, so that they're easier to
> -# understand.  However, in real protocol usage, they're emitted as a
> -# single line.
> -#
> -# Also, the following notation is used to denote data flow:
> -#
> -# Example:
> +# The following notation is used in examples:
>  #
>  # .. qmp-example::
>  #
>  #   -> ... text sent by client (commands) ...
>  #   <- ... text sent by server (command responses and events) ...
>  #
> +# Example text is formatted for readability.  However, in real
> +# protocol usage, its commonly emitted as a single line.
> +#
>  # Please refer to the
>  # :doc:`QEMU Machine Protocol Specification </interop/qmp-spec>`
> -# for detailed information on the Server command and response formats.
> +# for the general format of commands, responses, and events.
>  ##
>
>  { 'include': 'pragma.json' }
> --
> 2.48.1


Thanks for this one :)

--000000000000e53f520632fd6a41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 4, =
2025 at 8:14=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Cut the crap that stopped making sense years ago.=
=C2=A0 Adjust the<br>
remainder.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/qapi-schema.json | 27 +++++++--------------------<br>
=C2=A01 file changed, 7 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json<br>
index 0d027d5017..7bc600bb76 100644<br>
--- a/qapi/qapi-schema.json<br>
+++ b/qapi/qapi-schema.json<br>
@@ -3,37 +3,24 @@<br>
=C2=A0##<br>
=C2=A0# =3D Introduction<br>
=C2=A0#<br>
-# This document describes all commands currently supported by QMP.<br>
+# This manual describes the commands and events supported by the QEMU<br>
+# Monitor Protocol (QMP).<br>
=C2=A0#<br>
=C2=A0# For locating a particular item, please see the `qapi-qmp-index`.<br=
>
=C2=A0#<br>
-# Most of the time their usage is exactly the same as in the user<br>
-# Monitor, this means that any other document which also describe<br>
-# commands (the manpage, QEMU&#39;s manual, etc) can and should be<br>
-# consulted.<br>
-#<br>
-# QMP has two types of commands: regular and query commands.=C2=A0 Regular=
<br>
-# commands usually change the Virtual Machine&#39;s state someway, while<b=
r>
-# query commands just return information.=C2=A0 The sections below are<br>
-# divided accordingly.<br>
-#<br>
-# It&#39;s important to observe that all communication examples are<br>
-# formatted in a reader-friendly way, so that they&#39;re easier to<br>
-# understand.=C2=A0 However, in real protocol usage, they&#39;re emitted a=
s a<br>
-# single line.<br>
-#<br>
-# Also, the following notation is used to denote data flow:<br>
-#<br>
-# Example:<br>
+# The following notation is used in examples:<br>
=C2=A0#<br>
=C2=A0# .. qmp-example::<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0-&gt; ... text sent by client (commands) ...<br>
=C2=A0#=C2=A0 =C2=A0&lt;- ... text sent by server (command responses and ev=
ents) ...<br>
=C2=A0#<br>
+# Example text is formatted for readability.=C2=A0 However, in real<br>
+# protocol usage, its commonly emitted as a single line.<br>
+#<br>
=C2=A0# Please refer to the<br>
=C2=A0# :doc:`QEMU Machine Protocol Specification &lt;/interop/qmp-spec&gt;=
`<br>
-# for detailed information on the Server command and response formats.<br>
+# for the general format of commands, responses, and events.<br>
=C2=A0##<br>
<br>
=C2=A0{ &#39;include&#39;: &#39;pragma.json&#39; }<br>
-- <br>
2.48.1</blockquote><div><br></div><div>Thanks for this one :) <br></div></d=
iv></div>

--000000000000e53f520632fd6a41--


