Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BBFC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29C-0006NF-Gl; Tue, 10 Jun 2025 12:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOz6i-0007xn-NJ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOz6d-0007TF-E0
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749562412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSXqtXBWmabqZNaGhAVEch3+5fzLdlsgiXpUhNnshS0=;
 b=fIr7ChoDsojO+cBu8Wn43Le8VsiXySRGDmSOz4AYnE0q1hZHHDieqkVzEAFLIbTjblljDN
 pN82IHSDYTIO6ePfhPBSYuO3pMNlMRtgFeIFB/vZCwI8GAr04RialVc7rgLnrl4+TQ+mVA
 TehFmQEtkp1bbobWR72PybRwKuTVpqQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-6nKnSMbXOjeISHSuDOSMog-1; Tue, 10 Jun 2025 09:33:31 -0400
X-MC-Unique: 6nKnSMbXOjeISHSuDOSMog-1
X-Mimecast-MFC-AGG-ID: 6nKnSMbXOjeISHSuDOSMog_1749562411
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fb1c6b5ea7so35370196d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 06:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749562410; x=1750167210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RSXqtXBWmabqZNaGhAVEch3+5fzLdlsgiXpUhNnshS0=;
 b=oqnQWQBw6enpM52X8IkBBBJ2f7U7CL21r+ZQlCg7SqJRUwUGs3pQdbQoo3qP9STAni
 63Ek7UjJLRNy1lF9fab6uKDj9rGg3mKQ5kPO26I/h0p1SYbAT3BlEisUYLSPq57ojFgp
 BhLVW01LVn+WI0MWFQdad5G9j4ja/YDA3Gy4TPYP49y2SvAKrxAAJ2okAU5YewBTV7gk
 QU6AGwAossee2ECmRJY1R+KF4scFjbMwVPFZdvQgRGPatxUcA+DM7pwcMePFXL6A6d4u
 wEMnxtIx27Zbpn8cIKGb+d3PTls0B52GQCC3THp3qfeOHnAlpCI5dwOzI/MHiEktUV19
 LZcQ==
X-Gm-Message-State: AOJu0YysIsw/HZq/7ZudVfYGLwDLYmBr1aowT1IROw800YWZUTSzxwLV
 oGV9XSoR6kIR4yIFdKp9QUxjtq4KsFajrw6WSZ3oHQ6mORrV2XIFxzDIVHD/Ou6FoCs2uqzREet
 u6EXDhsebW8BtniLtNzuvT3L+ET0+A0T6+sYXrcoFeKHAOdxLAdLtTa4PUyrVQ3lZuqwCAk/C6a
 68ILozbfqVs/wmZCSDhc0N+gaBYQgpmnA=
X-Gm-Gg: ASbGncs/GLGA+/FF8aLnA72TSR7GLAEj+wZbo6gr07E3x8784QLVjrdqDyZ5HgrtA50
 D/4B4QnurHNvlmVwSw+WQCcVVrQj+OZ4N5MKQiuFEfgEChRVCD7e1jdnxJt4GzfHsExElZnoKQT
 +fi9/+pErUIBN40xoETwIhx+D4vDRjYSSn1JUH
X-Received: by 2002:ad4:5c4c:0:b0:6fa:c5be:dac3 with SMTP id
 6a1803df08f44-6fb08f4f61fmr254505946d6.3.1749562410677; 
 Tue, 10 Jun 2025 06:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSLTPJ+7/qxAZBKn8MlMuwFnIje6aEXcdxvTRWyHrbuwuignJ7x5Qn2xqlGIIAejOrttK+Pxa/2QoIOzwIsw=
X-Received: by 2002:ad4:5c4c:0:b0:6fa:c5be:dac3 with SMTP id
 6a1803df08f44-6fb08f4f61fmr254505626d6.3.1749562410186; Tue, 10 Jun 2025
 06:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <20250605101124.367270-3-pbonzini@redhat.com>
In-Reply-To: <20250605101124.367270-3-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jun 2025 17:33:19 +0400
X-Gm-Features: AX0GCFsKoXLKD-1URwHVR9ssAlxpgjXHiZxOR8vklkrbfa4q0CZNuTkT_9wDuvI
Message-ID: <CAMxuvawr=a1RsKXxijZby=1=ru8rNUui7T+Db2P+n5jAeckn3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] scripts/qapi: add QAPISchemaIfCond.rsgen()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com, 
 mkletzan@redhat.com
Content-Type: multipart/alternative; boundary="000000000000f8ed6f063737bd6c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

--000000000000f8ed6f063737bd6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate Rust #[cfg(...)] guards from QAPI 'if' conditions.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link:
> https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redh=
at.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 16 ++++++++++++++++
>  scripts/qapi/schema.py |  4 ++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d7c8aa3365c..a8ea5792c11 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -199,6 +199,22 @@ def guardend(name: str) -> str:
>                   name=3Dc_fname(name).upper())
>
>
> +def rsgen_ifcond(ifcond: Union[str, Dict[str, Any]]) -> str:
>

def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:

to make type checking happy.

+
> +    def cfg(ifcond: Union[str, Dict[str, Any]]):
> +        if isinstance(ifcond, str):
> +            return ifcond
> +        if isinstance(ifcond, list):
> +            return ', '.join([cfg(c) for c in ifcond])
> +        oper, operands =3D next(iter(ifcond.items()))
> +        operands =3D cfg(operands)
> +        return f'{oper}({operands})'
> +
> +    if not ifcond:
> +        return ''
> +    return '#[cfg(%s)]' % cfg(ifcond)
> +
> +
>  def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
>                 cond_fmt: str, not_fmt: str,
>                 all_operator: str, any_operator: str) -> str:
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index cbe3b5aa91e..0fb151b5d89 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -39,6 +39,7 @@
>      docgen_ifcond,
>      gen_endif,
>      gen_if,
> +    rsgen_ifcond,
>  )
>  from .error import QAPIError, QAPISemError, QAPISourceError
>  from .expr import check_exprs
> @@ -65,6 +66,9 @@ def gen_endif(self) -> str:
>      def docgen(self) -> str:
>          return docgen_ifcond(self.ifcond)
>
> +    def rsgen(self) -> str:
> +        return rsgen_ifcond(self.ifcond)
> +
>      def is_present(self) -> bool:
>          return bool(self.ifcond)
>
> --
> 2.49.0
>
>

--000000000000f8ed6f063737bd6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 5, 20=
25 at 2:11=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.c=
om">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:m=
arcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</=
a>&gt;<br>
<br>
Generate Rust #[cfg(...)] guards from QAPI &#39;if&#39; conditions.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Link: <a href=3D"https://lore.kernel.org/r/20210907121943.3498701-15-marcan=
dre.lureau@redhat.com" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com</a><br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qapi/common.py | 16 ++++++++++++++++<br>
=C2=A0scripts/qapi/schema.py |=C2=A0 4 ++++<br>
=C2=A02 files changed, 20 insertions(+)<br>
<br>
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py<br>
index d7c8aa3365c..a8ea5792c11 100644<br>
--- a/scripts/qapi/common.py<br>
+++ b/scripts/qapi/common.py<br>
@@ -199,6 +199,22 @@ def guardend(name: str) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3Dc_fna=
me(name).upper())<br>
<br>
<br>
+def rsgen_ifcond(ifcond: Union[str, Dict[str, Any]]) -&gt; str:<br></block=
quote><div><br></div><div>def rsgen_ifcond(ifcond: Optional[Union[str, Dict=
[str, Any]]]) -&gt; str:</div><div><br></div><div>to make type checking=C2=
=A0happy.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
+<br>
+=C2=A0 =C2=A0 def cfg(ifcond: Union[str, Dict[str, Any]]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(ifcond, str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ifcond<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(ifcond, list):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;, &#39;.join([cfg(c)=
 for c in ifcond])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 oper, operands =3D next(iter(ifcond.items()))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 operands =3D cfg(operands)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&#39;{oper}({operands})&#39;<br>
+<br>
+=C2=A0 =C2=A0 if not ifcond:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;&#39;<br>
+=C2=A0 =C2=A0 return &#39;#[cfg(%s)]&#39; % cfg(ifcond)<br>
+<br>
+<br>
=C2=A0def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond_fmt: str, not_=
fmt: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_operator: str, =
any_operator: str) -&gt; str:<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index cbe3b5aa91e..0fb151b5d89 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -39,6 +39,7 @@<br>
=C2=A0 =C2=A0 =C2=A0docgen_ifcond,<br>
=C2=A0 =C2=A0 =C2=A0gen_endif,<br>
=C2=A0 =C2=A0 =C2=A0gen_if,<br>
+=C2=A0 =C2=A0 rsgen_ifcond,<br>
=C2=A0)<br>
=C2=A0from .error import QAPIError, QAPISemError, QAPISourceError<br>
=C2=A0from .expr import check_exprs<br>
@@ -65,6 +66,9 @@ def gen_endif(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0def docgen(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return docgen_ifcond(self.ifcond)<br>
<br>
+=C2=A0 =C2=A0 def rsgen(self) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rsgen_ifcond(self.ifcond)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def is_present(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bool(self.ifcond)<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000f8ed6f063737bd6c--


