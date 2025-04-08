Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C951C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Fr8-0006aV-EO; Tue, 08 Apr 2025 16:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u2Fqp-0006Za-Io
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u2Fqk-0000GJ-IT
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744145229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RYqrZJncs9LKCQrBI7QsMu0kFF0jJnXmAq5SymzfZ8=;
 b=BXry9718ip9dk25hXjI8efTeIg6vo+a9J29Q7EoiRUIPZujLBYHTFu2fSc7rCxaVt2HeM8
 nDjDQP0KY9106Xb7nga7vkVCQA3ZF5mQl4N3A5Ga0FjVZy/dHGIGm5LukUE58kTC6tr/jx
 bkXcoYHonYutiTH82Qc0r2lRDXlK4tU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ioq64YJJPt2S8UHkORYoow-1; Tue, 08 Apr 2025 16:47:07 -0400
X-MC-Unique: ioq64YJJPt2S8UHkORYoow-1
X-Mimecast-MFC-AGG-ID: ioq64YJJPt2S8UHkORYoow_1744145226
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff82dd6de0so4525535a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 13:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744145226; x=1744750026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RYqrZJncs9LKCQrBI7QsMu0kFF0jJnXmAq5SymzfZ8=;
 b=bYSBNerKNYfQakhjH31rlJG1mX+iWPJPSPn9Te34WCh3QfScOjfLYYZ/wlSTxZzrSC
 5X1/XX7ceezNdNql7Samt5TrQu7ndpSD5BaYA3brJXisyvk5y1tIIOKxZyaKw6F80zhx
 lj500rx2Y/S35f/lgH82ft83NfL0JYfbt3/cuXVUndi7pkLpXW6k56Ixa6Tge0kSRges
 G92MP1hXzyQ3hmjn9KUmLnL/+86a7Ek1bnkfoGsOl/RN7C8zBVzHzGJw/MtjX9W8xCyX
 Y0R85ZgOwm5MP4cSn5GcKUNaiIU+yAfbEYaLN1I++W0ZARcUSQvSwo8ry43gWvvtW84e
 lRtQ==
X-Gm-Message-State: AOJu0YyUm/3SYXIuN5huF667Ww6dHgBB+7rWcZ6q4p766rM9GYZnM8S7
 bLnIB9mAlnOuF6jwkqIT4gHOAV7tUWYWeJ9C8oeN43sJh8eVbXFxx8ET/vZ+U3A7ojq3S3uJJrb
 DQtOU6wLuwhQROshS8zV0tSDdzpsMvry62KxcVZwG97zGqVACGYFnBiJslPvn3pUMvH8ZtBKEfR
 B3+Faul4IdjKOkGjum/S568UfPAsI=
X-Gm-Gg: ASbGncvdr7A8IWpLRZxHXDa/Di0rlkvqujMDXQ7HMil7L/sWPDXIXUU7AOnc2paPHQS
 Nk/owU4DJPuTaT0Y1+V90oXJuDt0/jJZvw/9VyjUI2JCLc95LPT8AUzTBMeSb2xgZW0fnuNmXTy
 P+QIQpXM9/fCAbHIx5NsDEM7Vo4r19
X-Received: by 2002:a17:90b:270c:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-306dbc2ee79mr788702a91.27.1744145225940; 
 Tue, 08 Apr 2025 13:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu9cKlli/j3gRLpITIV1GaxQ56LPeds1kt+JYobRJ0LrGSmlnyvfbky3AFbxybFuz48Np6YZlTucZ8S5UfwE0=
X-Received: by 2002:a17:90b:270c:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-306dbc2ee79mr788681a91.27.1744145225614; Tue, 08 Apr 2025
 13:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250404121413.1743790-1-armbru@redhat.com>
 <20250404121413.1743790-7-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-7-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 8 Apr 2025 16:46:53 -0400
X-Gm-Features: ATxdqUF2S1KZ9J4c4wHD5c4Kb5EhPN58NdVBs9XWTcb7I2p9yUwXulaDg9sESjY
Message-ID: <CAFn=p-bFk=+fuVaDY=oVs4TJ3YCfo97xE=s=865bnrPh1cyGyw@mail.gmail.com>
Subject: Re: [PATCH 06/11] docs/sphinx/qmp_lexer: Generalize elision syntax
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com, 
 kwolf@redhat.com, peter.maydell@linaro.org, eblake@redhat.com, 
 jiri@resnulli.us, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009c1be206324a7422"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009c1be206324a7422
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 8:14=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Accept "... lorem ipsum ..."  in addition to "...".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst    | 6 ++++--
>  docs/sphinx/qmp_lexer.py        | 2 +-
>  tests/qapi-schema/doc-good.json | 2 +-
>  tests/qapi-schema/doc-good.out  | 2 +-
>  tests/qapi-schema/doc-good.txt  | 2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 25a46fafb6..231cc0fecf 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1029,7 +1029,9 @@ used.
>  QMP Examples can be added by using the ``.. qmp-example::`` directive.
>  In its simplest form, this can be used to contain a single QMP code
>  block which accepts standard JSON syntax with additional server
> -directionality indicators (``->`` and ``<-``), and elisions (``...``).
> +directionality indicators (``->`` and ``<-``), and elisions.  An
> +elision is commonly ``...``, but it can also be or a pair of ``...``
> +with text in between.
>
>  Optionally, a plaintext title may be provided by using the ``:title:``
>  directive option.  If the title is omitted, the example title will
> @@ -1062,7 +1064,7 @@ For example::
>    #               "device": "ide0-hd0",
>    #               ...
>    #             }
> -  #             ...
> +  #             ... more ...
>    #          ] }
>    #
>    #    Above, lengthy output has been omitted for brevity.
> diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
> index a59de8a079..1bd1b81b70 100644
> --- a/docs/sphinx/qmp_lexer.py
> +++ b/docs/sphinx/qmp_lexer.py
> @@ -24,7 +24,7 @@ class QMPExampleMarkersLexer(RegexLexer):
>          'root': [
>              (r'-> ', token.Generic.Prompt),
>              (r'<- ', token.Generic.Prompt),
> -            (r' ?\.{3} ?', token.Generic.Prompt),
> +            (r'\.{3}( .* \.{3})?', token.Generic.Prompt),
>          ]
>      }
>
> diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> index 0a4f139f83..14b808f909 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -212,7 +212,7 @@
>  #
>  #    -> "this example"
>  #
> -#    <- "has no title"
> +#    <- ... has no title ...
>  ##
>  { 'command': 'cmd-boxed', 'boxed': true,
>    'data': 'Object',
> diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> index 5773f1dd6d..dc8352eed4 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -217,7 +217,7 @@ another feature
>
>     -> "this example"
>
> -   <- "has no title"
> +   <- ... has no title ...
>  doc symbol=3DEVT_BOXED
>      body=3D
>
> diff --git a/tests/qapi-schema/doc-good.txt
> b/tests/qapi-schema/doc-good.txt
> index cb37db606a..17a1d56ef1 100644
> --- a/tests/qapi-schema/doc-good.txt
> +++ b/tests/qapi-schema/doc-good.txt
> @@ -264,7 +264,7 @@ Example::
>
>     -> "this example"
>
> -   <- "has no title"
> +   <- ... has no title ...
>
>
>  "EVT_BOXED" (Event)
> --
> 2.48.1
>
>
Cool, sure!

ACK (Who is responsible for this now? Me?)

--0000000000009c1be206324a7422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 4, =
2025 at 8:14=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Accept &quot;... lorem ipsum ...&quot;=C2=A0 in ad=
dition to &quot;...&quot;.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/devel/qapi-code-gen.rst=C2=A0 =C2=A0 | 6 ++++--<br>
=C2=A0docs/sphinx/qmp_lexer.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0tests/qapi-schema/doc-good.json | 2 +-<br>
=C2=A0tests/qapi-schema/doc-good.out=C2=A0 | 2 +-<br>
=C2=A0tests/qapi-schema/doc-good.txt=C2=A0 | 2 +-<br>
=C2=A05 files changed, 8 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst<br=
>
index 25a46fafb6..231cc0fecf 100644<br>
--- a/docs/devel/qapi-code-gen.rst<br>
+++ b/docs/devel/qapi-code-gen.rst<br>
@@ -1029,7 +1029,9 @@ used.<br>
=C2=A0QMP Examples can be added by using the ``.. qmp-example::`` directive=
.<br>
=C2=A0In its simplest form, this can be used to contain a single QMP code<b=
r>
=C2=A0block which accepts standard JSON syntax with additional server<br>
-directionality indicators (``-&gt;`` and ``&lt;-``), and elisions (``...``=
).<br>
+directionality indicators (``-&gt;`` and ``&lt;-``), and elisions.=C2=A0 A=
n<br>
+elision is commonly ``...``, but it can also be or a pair of ``...``<br>
+with text in between.<br>
<br>
=C2=A0Optionally, a plaintext title may be provided by using the ``:title:`=
`<br>
=C2=A0directive option.=C2=A0 If the title is omitted, the example title wi=
ll<br>
@@ -1062,7 +1064,7 @@ For example::<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
device&quot;: &quot;ide0-hd0&quot;,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br=
>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
+=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... more ...<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ] }<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 Above, lengthy output has been omitted for brev=
ity.<br>
diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py<br>
index a59de8a079..1bd1b81b70 100644<br>
--- a/docs/sphinx/qmp_lexer.py<br>
+++ b/docs/sphinx/qmp_lexer.py<br>
@@ -24,7 +24,7 @@ class QMPExampleMarkersLexer(RegexLexer):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;root&#39;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(r&#39;-&gt; &#39;, token.G=
eneric.Prompt),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(r&#39;&lt;- &#39;, token.G=
eneric.Prompt),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (r&#39; ?\.{3} ?&#39;, token.Gen=
eric.Prompt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (r&#39;\.{3}( .* \.{3})?&#39;, t=
oken.Generic.Prompt),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son<br>
index 0a4f139f83..14b808f909 100644<br>
--- a/tests/qapi-schema/doc-good.json<br>
+++ b/tests/qapi-schema/doc-good.json<br>
@@ -212,7 +212,7 @@<br>
=C2=A0#<br>
=C2=A0#=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
=C2=A0#<br>
-#=C2=A0 =C2=A0 &lt;- &quot;has no title&quot;<br>
+#=C2=A0 =C2=A0 &lt;- ... has no title ...<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;cmd-boxed&#39;, &#39;boxed&#39;: true,<br>
=C2=A0 =C2=A0&#39;data&#39;: &#39;Object&#39;,<br>
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t<br>
index 5773f1dd6d..dc8352eed4 100644<br>
--- a/tests/qapi-schema/doc-good.out<br>
+++ b/tests/qapi-schema/doc-good.out<br>
@@ -217,7 +217,7 @@ another feature<br>
<br>
=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
<br>
-=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
+=C2=A0 =C2=A0&lt;- ... has no title ...<br>
=C2=A0doc symbol=3DEVT_BOXED<br>
=C2=A0 =C2=A0 =C2=A0body=3D<br>
<br>
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.tx=
t<br>
index cb37db606a..17a1d56ef1 100644<br>
--- a/tests/qapi-schema/doc-good.txt<br>
+++ b/tests/qapi-schema/doc-good.txt<br>
@@ -264,7 +264,7 @@ Example::<br>
<br>
=C2=A0 =C2=A0 -&gt; &quot;this example&quot;<br>
<br>
-=C2=A0 =C2=A0&lt;- &quot;has no title&quot;<br>
+=C2=A0 =C2=A0&lt;- ... has no title ...<br>
<br>
<br>
=C2=A0&quot;EVT_BOXED&quot; (Event)<br>
-- <br>
2.48.1<br>
<br></blockquote><div><br></div><div>Cool, sure!</div><div><br></div><div>A=
CK (Who is responsible for this now? Me?) <br></div></div></div>

--0000000000009c1be206324a7422--


