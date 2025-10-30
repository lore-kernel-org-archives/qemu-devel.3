Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D329CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYMz-0002Dz-In; Thu, 30 Oct 2025 15:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYMs-0002BY-NE
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYMp-0005dQ-Pb
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=55ns2Mzh6/J8lyxJnlWCJ3ZuM14xKTHwKoZk2ILqPM8=;
 b=IR30EYaDpOYupsohQzG1mcQSEiMugfMkOK+ibTOvQIyJsYavRFdc0rtOG1niDagLEpVOIB
 yGtdFGkgW8maMHngA662EU4So/zodM7wE/86GrzpitoONOMoUJY8VUqjvvDfvwcASjlhDF
 UD6rV6uWXZy4SVYbBIsKYZuNivodH/Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-C3mmoSWTOy6K6s7KnCnRvw-1; Thu, 30 Oct 2025 15:31:20 -0400
X-MC-Unique: C3mmoSWTOy6K6s7KnCnRvw-1
X-Mimecast-MFC-AGG-ID: C3mmoSWTOy6K6s7KnCnRvw_1761852679
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34029b3dbfeso1683096a91.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852679; x=1762457479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55ns2Mzh6/J8lyxJnlWCJ3ZuM14xKTHwKoZk2ILqPM8=;
 b=NRTQViYrxi5WrA0ixOgq1COHLXGfB9zHnVCWrbbVxo87d/S0L6lAbq7oyRlhWMyHt2
 5ZtG8Z/SEkzqkSbhagcDZZzW8ilxrEwtbEmW41EaA2uTITeTZGPYPI5QXD3r3hIT/pY2
 9heD2TuZpxpGs5pg2w1BiXwEc1mVQpZbPicJT7UJyl6pm+u3hNIJ0QIl+S3aTT3TaP1I
 /5hd6NepV09MLTeBiS85g4Rj76NV1qc1qTswTKC5BDfo3ZeqTdF6/6UNc4rx8EGtAxmP
 J5oTFG0sHGaOOJaLSD7BUgZvi2sM00J+Z3plc9UOlUdk9TfCiI1xCNYW3sXRgK7M4/3x
 ZgdA==
X-Gm-Message-State: AOJu0YxBYsSeWZczTmYTnlA/MmxrXHTvm2Bo5HiRZJHNxDkUSBuFjTow
 2xoqnFqtQSkrAkcstf/vB11Pkgx7Xba+ZPGJsjvq66svAeprXZDUiFvWIfChs4hDIvkfJS7RY44
 dqWidCWUqVQsnUaj+Bk8r2KHB27Ny2J2A6dbMhwAK+VoNVbPuEouNXbhYOL7VaPP/aTvtxj6RA8
 KVmImOSX9IC5vGg5sJV9+vVfKsJqmX0Yw=
X-Gm-Gg: ASbGncs1okE5FA+kjpAojbf8B3mppS7BjkvJE7DoIbahrtKwfnTYRSn/uJuPGxmGgj/
 x6rHkF4baaeC5dsNR4EiIhKjkhzCr14dTrJMa/fkA8aI0tBeGMFoVd/jq07sMMdESjZoYTyOFIv
 jN4Z5kVOAx8C+cXr/uyPGfdJXUXEF4vJfBiUMipyj7xtPwcxgQT4FvF9HZZ3HfGABzwN+RloVbo
 DvdCreK8EpmT9I=
X-Received: by 2002:a17:902:ec86:b0:268:15f:8358 with SMTP id
 d9443c01a7336-2951a51e6b1mr9743595ad.42.1761852678766; 
 Thu, 30 Oct 2025 12:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrSozkt/xL7JmTNvdr5aPx0vhlHVuV9XYfqVyf148tiJUHhZEABLsbtaXmN74WJBRSq5Hobuo+pVej7HWlRtY=
X-Received: by 2002:a17:902:ec86:b0:268:15f:8358 with SMTP id
 d9443c01a7336-2951a51e6b1mr9743255ad.42.1761852678191; Thu, 30 Oct 2025
 12:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-3-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:07 +0400
X-Gm-Features: AWmQ_bk6Gp0AtbUtGBKf_9LvryHhKaXZSV317wHJVCCUhkz5zy4kY2LwA4lM-Pc
Message-ID: <CAMxuvayvt_2AEc-h2XFE3Zvs7TCB3+XMj9beE4r8G+3OP8t3UA@mail.gmail.com>
Subject: Re: [PATCH 02/21] crypto: add missing free of certs array
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="00000000000007d3b20642654b37"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000007d3b20642654b37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 847fd4d9fa..75c70af522 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -550,6 +550,7 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>      for (i =3D 0; i < ncerts; i++) {
>          gnutls_x509_crt_deinit(certs[i]);
>      }
> +    g_free(certs);
>      for (i =3D 0; i < ncacerts; i++) {
>          gnutls_x509_crt_deinit(cacerts[i]);
>      }
> --
> 2.51.1
>
>

--00000000000007d3b20642654b37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:48=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" ta=
rget=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Signed-off-by: Daniel P. Berrang=C3=A9 &=
lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat=
.com</a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_bl=
ank">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscredsx509.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 847fd4d9fa..75c70af522 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -550,6 +550,7 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509=
 *creds,<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ncerts; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutls_x509_crt_deinit(certs[i]);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 g_free(certs);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ncacerts; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutls_x509_crt_deinit(cacerts[i]);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--00000000000007d3b20642654b37--


