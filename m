Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB70CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYWI-00085a-Ic; Thu, 30 Oct 2025 15:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYWA-000844-Lc
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYVy-0007IB-1Z
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761853240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94R5nSxyTTc8Srb1b+KevFYvw/PICkEXew2eDmk3FEY=;
 b=K3vmvZo/6nGIzVf/ar3ULhEJ8gCyNOHOncMtnD8YXUe+bWsgi56R8G7Rjc76EDJ0cbJ282
 0E3VGBpH9pQtiuDsB015uQuysgus36KoviVO46YWQbssXCS7nJyHK0ZN5KUZ9Q6ynbODR8
 IbUVMXs9VpDKJE5KDSF5lzA5YqQGqVQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-sxSQNbjrMPGcGEgYFU1P8Q-1; Thu, 30 Oct 2025 15:40:38 -0400
X-MC-Unique: sxSQNbjrMPGcGEgYFU1P8Q-1
X-Mimecast-MFC-AGG-ID: sxSQNbjrMPGcGEgYFU1P8Q_1761853237
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6ce15aaa99so1068719a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761853236; x=1762458036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94R5nSxyTTc8Srb1b+KevFYvw/PICkEXew2eDmk3FEY=;
 b=uqGtQ4F0DXJDB+VGWRHDqD3lCIJMVTAqyq/uqaVFZ+aY/FOEBgJWy2H/CbLTlCK023
 NVvMVn5KKxvVmqRbUYZ6hntYzsx77VsPsjyEB5CRyk0ucO+LEdxfQmD7aSYb/mj9cHRD
 Sk9oWfBdS7iFpp8IWCxLXnPJ9IDLt8wo5aZ/GEyNcKgtyTKEJxLyo7veVpBrhR6x1nXR
 gW1NG9l0cmfJ1DuRsTahWgkrFU9uuTK8ynbHUDundyBJuxHN8ZCd19aV84J2jh27Y+6k
 +nz7oTHzqbliM1OZJqA+f6PTdRg2RhSVRXU7LR9obszmHHbViVZO6o4CxWD9g9nV2ZBQ
 ZP7w==
X-Gm-Message-State: AOJu0YxSmUAhoNg7DxhZyUEi1pey44xt/v6ZL/tqxgajGgZhYsNx85zo
 +XNLm5EXGb4Zo2dyl0AwwlW79c33zBluuBXmJdLY/7T7GBmQLc/AX1Hu1rcoDidbx2U2bFrC0e3
 2uya34xmLzZBbDyl3Ntp24daIPXxklzZkD9+b1tDQXyepw7VHTjNhw0wCaFjXbIpbrCFTpIFmBf
 aa3oPg8HyYAgUd3Uecdj1SvYA3DUng2AY/MDqsm+dUyw==
X-Gm-Gg: ASbGncuV+6bqsGwFa1mFBOL73S7rwC/lqucXjSyzbNoHLMySOhosuMlt+DCj6Zsfyfu
 xDcb83ClqH8FSEKaLq6XjdCK1UFfjQmgX/BuYog+isXCOjoIVv6XgD5THrH6Q7hciXIzKr9XW2f
 SI+A8auGbeZvJLomSDLgdCqzFPloTAe79oiUJ9eAfrZAJ41InWNSIvYFhuArHv02eRr7h2+OoZj
 6vbXEr3mARyvlk=
X-Received: by 2002:a17:903:2450:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-2951a388519mr12110455ad.15.1761853236255; 
 Thu, 30 Oct 2025 12:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlm3LSHRqNkUkA0kto/6JZ+XsyrwoRyT/IWLnKidVUKkNm5KMOm+LhNk+Dhj6wwA8UItEfsoQ4ULZA54i11gk=
X-Received: by 2002:a17:903:2450:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-2951a388519mr12110185ad.15.1761853235847; Thu, 30 Oct 2025
 12:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-12-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-12-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:40:21 +0400
X-Gm-Features: AWmQ_blHDNsyHmNY50k-jGTRRxA54HuuNybnr2btE0J-IEK1lhx_uaVYqZEASXo
Message-ID: <CAMxuvax37_RiP4kfK-Kawba1HdzdBW-rMjTuE5+9oenYvW7oDw@mail.gmail.com>
Subject: Re: [PATCH 11/21] crypto: reduce duplication in handling TLS priority
 strings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="00000000000044f8c90642656c2d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000044f8c90642656c2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The logic for setting the TLS priority string on a session object has a
> significant amount of logic duplication across the different credential
> types. By recording the extra priority string suffix against the
> credential class, we can introduce a common method for building the
> priority string. The TLS session can now set the priority string without
> caring about the credential type.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/tlscreds.c         | 15 ++++++++++
>  crypto/tlscredsanon.c     |  2 ++
>  crypto/tlscredspsk.c      |  2 ++
>  crypto/tlssession.c       | 60 ++++++---------------------------------
>  include/crypto/tlscreds.h | 13 +++++++++
>  5 files changed, 41 insertions(+), 51 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 1e39ee1141..49c7eb46a5 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -266,6 +266,21 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCred=
s
> *creds,
>      return true;
>  }
>
> +
> +char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds)
> +{
> +    QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_GET_CLASS(creds);
> +    const char *priorityBase =3D
> +        creds->priority ? creds->priority : CONFIG_TLS_PRIORITY;
> +
> +    if (tcc->prioritySuffix) {
> +        return g_strdup_printf("%s:%s", priorityBase,
> tcc->prioritySuffix);
> +    } else {
> +        return g_strdup(priorityBase);
> +    }
> +}
> +
> +
>  static const TypeInfo qcrypto_tls_creds_info =3D {
>      .parent =3D TYPE_OBJECT,
>      .name =3D TYPE_QCRYPTO_TLS_CREDS,
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index 1ddfe4eb31..5c55b07b2f 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -137,8 +137,10 @@ static void
>  qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)
>  {
>      UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_CLASS(oc);
>
>      ucc->complete =3D qcrypto_tls_creds_anon_complete;
> +    tcc->prioritySuffix =3D "+ANON-DH";
>  }
>
>
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index bf4efe2114..6c2feae077 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -240,8 +240,10 @@ static void
>  qcrypto_tls_creds_psk_class_init(ObjectClass *oc, const void *data)
>  {
>      UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_CLASS(oc);
>
>      ucc->complete =3D qcrypto_tls_creds_psk_complete;
> +    tcc->prioritySuffix =3D "+ECDHE-PSK:+DHE-PSK:+PSK";
>
>      object_class_property_add_str(oc, "username",
>                                    qcrypto_tls_creds_psk_prop_get_usernam=
e,
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 92fe4f0380..77f334add3 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -155,9 +155,6 @@ qcrypto_tls_session_pull(void *opaque, void *buf,
> size_t len)
>      }
>  }
>
> -#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
> -#define TLS_PRIORITY_ADDITIONAL_PSK "+ECDHE-PSK:+DHE-PSK:+PSK"
> -
>  QCryptoTLSSession *
>  qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>                          const char *hostname,
> @@ -167,6 +164,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>  {
>      QCryptoTLSSession *session;
>      int ret;
> +    g_autofree char *prio =3D NULL;
>
>      session =3D g_new0(QCryptoTLSSession, 1);
>      trace_qcrypto_tls_session_new(
> @@ -200,28 +198,17 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>          goto error;
>      }
>
> +    prio =3D qcrypto_tls_creds_get_priority(creds);
> +    ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
> +    if (ret < 0) {
> +        error_setg(errp, "Unable to set TLS session priority %s: %s",
> +                   prio, gnutls_strerror(ret));
> +        goto error;
> +    }
> +
>      if (object_dynamic_cast(OBJECT(creds),
>                              TYPE_QCRYPTO_TLS_CREDS_ANON)) {
>          QCryptoTLSCredsAnon *acreds =3D QCRYPTO_TLS_CREDS_ANON(creds);
> -        char *prio;
> -
> -        if (creds->priority !=3D NULL) {
> -            prio =3D g_strdup_printf("%s:%s",
> -                                   creds->priority,
> -                                   TLS_PRIORITY_ADDITIONAL_ANON);
> -        } else {
> -            prio =3D g_strdup(CONFIG_TLS_PRIORITY ":"
> -                            TLS_PRIORITY_ADDITIONAL_ANON);
> -        }
> -
> -        ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
> -        if (ret < 0) {
> -            error_setg(errp, "Unable to set TLS session priority %s: %s"=
,
> -                       prio, gnutls_strerror(ret));
> -            g_free(prio);
> -            goto error;
> -        }
> -        g_free(prio);
>          if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
>              ret =3D gnutls_credentials_set(session->handle,
>                                           GNUTLS_CRD_ANON,
> @@ -239,25 +226,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>      } else if (object_dynamic_cast(OBJECT(creds),
>                                     TYPE_QCRYPTO_TLS_CREDS_PSK)) {
>          QCryptoTLSCredsPSK *pcreds =3D QCRYPTO_TLS_CREDS_PSK(creds);
> -        char *prio;
> -
> -        if (creds->priority !=3D NULL) {
> -            prio =3D g_strdup_printf("%s:%s",
> -                                   creds->priority,
> -                                   TLS_PRIORITY_ADDITIONAL_PSK);
> -        } else {
> -            prio =3D g_strdup(CONFIG_TLS_PRIORITY ":"
> -                            TLS_PRIORITY_ADDITIONAL_PSK);
> -        }
> -
> -        ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
> -        if (ret < 0) {
> -            error_setg(errp, "Unable to set TLS session priority %s: %s"=
,
> -                       prio, gnutls_strerror(ret));
> -            g_free(prio);
> -            goto error;
> -        }
> -        g_free(prio);
>          if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
>              ret =3D gnutls_credentials_set(session->handle,
>                                           GNUTLS_CRD_PSK,
> @@ -275,17 +243,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>      } else if (object_dynamic_cast(OBJECT(creds),
>                                     TYPE_QCRYPTO_TLS_CREDS_X509)) {
>          QCryptoTLSCredsX509 *tcreds =3D QCRYPTO_TLS_CREDS_X509(creds);
> -        const char *prio =3D creds->priority;
> -        if (!prio) {
> -            prio =3D CONFIG_TLS_PRIORITY;
> -        }
>
> -        ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
> -        if (ret < 0) {
> -            error_setg(errp, "Cannot set default TLS session priority %s=
:
> %s",
> -                       prio, gnutls_strerror(ret));
> -            goto error;
> -        }
>          ret =3D gnutls_credentials_set(session->handle,
>                                       GNUTLS_CRD_CERTIFICATE,
>                                       tcreds->data);
> diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
> index 2a8a857010..afd1016088 100644
> --- a/include/crypto/tlscreds.h
> +++ b/include/crypto/tlscreds.h
> @@ -47,6 +47,7 @@ typedef bool (*CryptoTLSCredsReload)(QCryptoTLSCreds *,
> Error **);
>  struct QCryptoTLSCredsClass {
>      ObjectClass parent_class;
>      CryptoTLSCredsReload reload;
> +    const char *prioritySuffix;
>

sneaking camelCase to scare the snakes?

anyhow:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  };
>
>  /**
> @@ -64,4 +65,16 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds
> *creds,
>                                        QCryptoTLSCredsEndpoint endpoint,
>                                        Error **errp);
>
> +
> +/**
> + * qcrypto_tls_creds_get_priority:
> + * @creds: pointer to a TLS credentials object
> + *
> + * Get the TLS credentials priority string. The caller
> + * must free the returned string when no longer required.
> + *
> + * Returns: a non-NULL priority string
> + */
> +char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);
> +
>  #endif /* QCRYPTO_TLSCREDS_H */
> --
> 2.51.1
>
>

--00000000000044f8c90642656c2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2=
025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">The logic for setting the TLS priority st=
ring on a session object has a<br>
significant amount of logic duplication across the different credential<br>
types. By recording the extra priority string suffix against the<br>
credential class, we can introduce a common method for building the<br>
priority string. The TLS session can now set the priority string without<br=
>
caring about the credential type.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++++++++++<br=
>
=C2=A0crypto/tlscredsanon.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0crypto/tlssession.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 60 ++++++------------=
---------------------<br>
=C2=A0include/crypto/tlscreds.h | 13 +++++++++<br>
=C2=A05 files changed, 41 insertions(+), 51 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 1e39ee1141..49c7eb46a5 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -266,6 +266,21 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds =
*creds,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+<br>
+char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds)<br>
+{<br>
+=C2=A0 =C2=A0 QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_GET_CLASS(cr=
eds);<br>
+=C2=A0 =C2=A0 const char *priorityBase =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;priority ? creds-&gt;priority : CONF=
IG_TLS_PRIORITY;<br>
+<br>
+=C2=A0 =C2=A0 if (tcc-&gt;prioritySuffix) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup_printf(&quot;%s:%s&quot;, prio=
rityBase, tcc-&gt;prioritySuffix);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(priorityBase);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
=C2=A0static const TypeInfo qcrypto_tls_creds_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_OBJECT,<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_QCRYPTO_TLS_CREDS,<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index 1ddfe4eb31..5c55b07b2f 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -137,8 +137,10 @@ static void<br>
=C2=A0qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);<b=
r>
+=C2=A0 =C2=A0 QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_CLASS(oc);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0ucc-&gt;complete =3D qcrypto_tls_creds_anon_complete;<b=
r>
+=C2=A0 =C2=A0 tcc-&gt;prioritySuffix =3D &quot;+ANON-DH&quot;;<br>
=C2=A0}<br>
<br>
<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index bf4efe2114..6c2feae077 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -240,8 +240,10 @@ static void<br>
=C2=A0qcrypto_tls_creds_psk_class_init(ObjectClass *oc, const void *data)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);<b=
r>
+=C2=A0 =C2=A0 QCryptoTLSCredsClass *tcc =3D QCRYPTO_TLS_CREDS_CLASS(oc);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0ucc-&gt;complete =3D qcrypto_tls_creds_psk_complete;<br=
>
+=C2=A0 =C2=A0 tcc-&gt;prioritySuffix =3D &quot;+ECDHE-PSK:+DHE-PSK:+PSK&qu=
ot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_class_property_add_str(oc, &quot;username&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_psk_p=
rop_get_username,<br>
diff --git a/crypto/tlssession.c b/crypto/tlssession.c<br>
index 92fe4f0380..77f334add3 100644<br>
--- a/crypto/tlssession.c<br>
+++ b/crypto/tlssession.c<br>
@@ -155,9 +155,6 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_=
t len)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-#define TLS_PRIORITY_ADDITIONAL_ANON &quot;+ANON-DH&quot;<br>
-#define TLS_PRIORITY_ADDITIONAL_PSK &quot;+ECDHE-PSK:+DHE-PSK:+PSK&quot;<b=
r>
-<br>
=C2=A0QCryptoTLSSession *<br>
=C2=A0qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *hostname,<br>
@@ -167,6 +164,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSSession *session;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 g_autofree char *prio =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0session =3D g_new0(QCryptoTLSSession, 1);<br>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_session_new(<br>
@@ -200,28 +198,17 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 prio =3D qcrypto_tls_creds_get_priority(creds);<br>
+=C2=A0 =C2=A0 ret =3D gnutls_priority_set_direct(session-&gt;handle, prio,=
 NULL);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unable to set TLS sessi=
on priority %s: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prio,=
 gnutls_strerror(ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (object_dynamic_cast(OBJECT(creds),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_QCRYPTO_TLS_CREDS_ANON)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsAnon *acreds =3D QCRYPTO_T=
LS_CREDS_ANON(creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *prio;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;priority !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prio =3D g_strdup_printf(&quot;%=
s:%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;priority,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TLS_PRIORITY_ADDITIONAL=
_ANON);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prio =3D g_strdup(CONFIG_TLS_PRI=
ORITY &quot;:&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TLS_PRIORITY_ADDITIONAL_ANON);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_priority_set_direct(session-&gt=
;handle, prio, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unable to=
 set TLS session priority %s: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0prio, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(prio);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(prio);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (creds-&gt;endpoint =3D=3D QCRYPTO_TLS=
_CREDS_ENDPOINT_SERVER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_credentials_=
set(session-&gt;handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
NUTLS_CRD_ANON,<br>
@@ -239,25 +226,6 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0} else if (object_dynamic_cast(OBJECT(creds),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_QCRYPTO_TLS_CREDS=
_PSK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsPSK *pcreds =3D QCRYPTO_TL=
S_CREDS_PSK(creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *prio;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;priority !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prio =3D g_strdup_printf(&quot;%=
s:%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;priority,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TLS_PRIORITY_ADDITIONAL=
_PSK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prio =3D g_strdup(CONFIG_TLS_PRI=
ORITY &quot;:&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TLS_PRIORITY_ADDITIONAL_PSK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_priority_set_direct(session-&gt=
;handle, prio, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unable to=
 set TLS session priority %s: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0prio, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(prio);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(prio);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (creds-&gt;endpoint =3D=3D QCRYPTO_TLS=
_CREDS_ENDPOINT_SERVER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_credentials_=
set(session-&gt;handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
NUTLS_CRD_PSK,<br>
@@ -275,17 +243,7 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0} else if (object_dynamic_cast(OBJECT(creds),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_QCRYPTO_TLS_CREDS=
_X509)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsX509 *tcreds =3D QCRYPTO_T=
LS_CREDS_X509(creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *prio =3D creds-&gt;priority;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prio) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prio =3D CONFIG_TLS_PRIORITY;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_priority_set_direct(session-&gt=
;handle, prio, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot se=
t default TLS session priority %s: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0prio, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_credentials_set(session-&g=
t;handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GNUTLS_CRD_CERT=
IFICATE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcreds-&gt;data=
);<br>
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h<br>
index 2a8a857010..afd1016088 100644<br>
--- a/include/crypto/tlscreds.h<br>
+++ b/include/crypto/tlscreds.h<br>
@@ -47,6 +47,7 @@ typedef bool (*CryptoTLSCredsReload)(QCryptoTLSCreds *, E=
rror **);<br>
=C2=A0struct QCryptoTLSCredsClass {<br>
=C2=A0 =C2=A0 =C2=A0ObjectClass parent_class;<br>
=C2=A0 =C2=A0 =C2=A0CryptoTLSCredsReload reload;<br>
+=C2=A0 =C2=A0 const char *prioritySuffix;<br></blockquote><div><br></div><=
div>sneaking camelCase to scare the snakes?</div><div><br></div><div>anyhow=
:</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0};<br>
<br>
=C2=A0/**<br>
@@ -64,4 +65,16 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds *c=
reds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoTL=
SCredsEndpoint endpoint,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **e=
rrp);<br>
<br>
+<br>
+/**<br>
+ * qcrypto_tls_creds_get_priority:<br>
+ * @creds: pointer to a TLS credentials object<br>
+ *<br>
+ * Get the TLS credentials priority string. The caller<br>
+ * must free the returned string when no longer required.<br>
+ *<br>
+ * Returns: a non-NULL priority string<br>
+ */<br>
+char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);<br>
+<br>
=C2=A0#endif /* QCRYPTO_TLSCREDS_H */<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--00000000000044f8c90642656c2d--


