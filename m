Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350EECCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnFL-0003sq-S6; Fri, 31 Oct 2025 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnFG-0003qu-MG
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnF6-0000HG-0f
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761909865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wiiw4c4ugjgj22U3ggz9WGD0DMLJ35rRFtn6nfr/z6k=;
 b=Hj+n2Ea63BrMB7CBRiBvdmeCUgiwHYoa6yyZ5Qj0edxLqio+fiyOeE8cYKeSiDl3Lixa8g
 GwCW3rKs/XO0iF3CWQC6gDd8zPlxx9eX3CA0Tiu/IbPmhtbFJesHJ52j95bnQYmQJOu/nx
 bzvA9BIcS7EktXaDOdZtFRg230zeHSs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-StZrs-bbMPC-01Ftz4Ma3g-1; Fri, 31 Oct 2025 07:24:23 -0400
X-MC-Unique: StZrs-bbMPC-01Ftz4Ma3g-1
X-Mimecast-MFC-AGG-ID: StZrs-bbMPC-01Ftz4Ma3g_1761909862
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7a27ab05999so1631373b3a.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909862; x=1762514662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wiiw4c4ugjgj22U3ggz9WGD0DMLJ35rRFtn6nfr/z6k=;
 b=rcR8eS8SlMghah55IJ3ClVvtNKtuRBK9AolWL1u6zq/n6jzVoDzidYIJ5UCvaEaoka
 l8hSxRr7JeYIkm/XyVMexciEM21GLcI+vWy1TQD6iSblKsPS7yU+O57DgWARPHT6xU+g
 htb25eKtlNXz+a84CyJix+yGs/OgOQuASsFZvtFVKAeYudV3wI0oMv0mNdUk9VbZ4uSA
 pg8hq2JkK7e3KYAZJAjLZ8o4H9J3B7N2KitlZUa0GHm3ZAHz1q15Na1hLq3Gtz5RJoHj
 R0Vy40fjnwdfoJYjznP7Tocz6ruR0hguFBNprA/qUMiDkgiWpCsK3HApZaVITqCGtY2n
 TSjg==
X-Gm-Message-State: AOJu0Yx4DKta3eIlDWn9iqvBv8PJ6GGnN5op8GmCaaH1t2ZureSaofXb
 w4Q40o9O5xJCjSxvgX0aSlOq5ejpNefZaw0RxvxBHrlbm2cUCKtNBJRu08uKrjshnX4ioXp5q8q
 zG20+htP7kfQ9CCbLh4VUHoQ6gcJrzKFpHFQy8m9Ma00YUFEBsL+gX2CaiyVkMHJQFlC2nAMLf2
 +gh8+5iQ8zJtC0FvWnoR9wKm3EtulM8rU=
X-Gm-Gg: ASbGncuHT1cNbKU1F5Seozoc0AYupeEVCP5mV6ANOr5tDWJadzxyBak2Qg5+m32aks+
 sMFCHXbn/UgPDGOakxE9lDw/ebADxglhxJ8/jkcEJIzK2gnsFU7WZ00+M1af6nJPE5rtjN40NFw
 ksFmxwny4C5Z1o85fVRVGU3Hp02uBKbJCOWZ39vPZW7lqERtcAqm1j/6m51yVRYVRMjC0sRBB41
 dempKr2f7nyPXA=
X-Received: by 2002:a05:6a20:9186:b0:334:a901:5544 with SMTP id
 adf61e73a8af0-348c75c5d97mr4410172637.0.1761909862180; 
 Fri, 31 Oct 2025 04:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGba6R2IynQ6HgV+z7WU+294w6nqw6Xtqrj3uRX2GANjkj0K79lT2nRB6wg3tZrVjygSlubdPx8GMNDNVt33EQ=
X-Received: by 2002:a05:6a20:9186:b0:334:a901:5544 with SMTP id
 adf61e73a8af0-348c75c5d97mr4410118637.0.1761909861493; Fri, 31 Oct 2025
 04:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-15-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-15-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Oct 2025 15:24:09 +0400
X-Gm-Features: AWmQ_bkkXfbi_WPi-dmCnDDMWBcnNfq0tyrwQlAd_PC_H0eWpDStoSrphi1j76I
Message-ID: <CAMxuvazOF0jv8W8RyuDSnbio0c-cPb4mfu4+2Rbcets_R5j5fw@mail.gmail.com>
Subject: Re: [PATCH 14/21] crypto: fix lifecycle handling of gnutls
 credentials objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000006bc5c50642729b98"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000006bc5c50642729b98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> As described in the previous commit, the gnutls credentials need to
> be kept alive for as long as the gnutls session object exists. Convert
> the QCryptoTLSCreds objects to use QCryptoTLSCredsBox and holding the
> gnutls credential objects. When loading the credentials into a gnutls
> session, store a reference to the box into the QCryptoTLSSession object.
>
> This has the useful side effect that the QCryptoTLSSession code no
> longer needs to know about all the different credential types, it can
> use the generic pointer stored in the box.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c     |  5 +--
>  crypto/tlscredsanon.c | 48 +++++---------------------
>  crypto/tlscredspriv.h | 20 ++---------
>  crypto/tlscredspsk.c  | 46 ++++++++-----------------
>  crypto/tlscredsx509.c | 71 +++++++++++++-------------------------
>  crypto/tlssession.c   | 80 ++++++++++++++-----------------------------
>  6 files changed, 75 insertions(+), 195 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 9433b4c363..798c9712fb 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -246,10 +246,7 @@ qcrypto_tls_creds_finalize(Object *obj)
>  {
>      QCryptoTLSCreds *creds =3D QCRYPTO_TLS_CREDS(obj);
>
> -    if (creds->dh_params) {
> -        gnutls_dh_params_deinit(creds->dh_params);
> -    }
> -
> +    qcrypto_tls_creds_box_unref(creds->box);
>      g_free(creds->dir);
>      g_free(creds->priority);
>  }
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index 5c55b07b2f..0a728ccbf6 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -36,6 +36,7 @@ static int
>  qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
>                              Error **errp)
>  {
> +    g_autoptr(QCryptoTLSCredsBox) box =3D NULL;
>      g_autofree char *dhparams =3D NULL;
>      int ret;
>
> @@ -43,6 +44,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
>              creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
>
>      if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> +        box =3D qcrypto_tls_creds_box_new_server(GNUTLS_CRD_ANON);
> +
>          if (creds->parent_obj.dir &&
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_DH_PARAMS,
> @@ -50,7 +53,7 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
>              return -1;
>          }
>
> -        ret =3D
> gnutls_anon_allocate_server_credentials(&creds->data.server);
> +        ret =3D
> gnutls_anon_allocate_server_credentials(&box->data.anonserver);
>          if (ret < 0) {
>              error_setg(errp, "Cannot allocate credentials: %s",
>                         gnutls_strerror(ret));
> @@ -58,42 +61,26 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *cred=
s,
>          }
>
>          if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj,
> dhparams,
> -
>  &creds->parent_obj.dh_params,
> -                                                 errp) < 0) {
> +                                                 &box->dh_params, errp) =
<
> 0) {
>              return -1;
>          }
>
> -        gnutls_anon_set_server_dh_params(creds->data.server,
> -                                         creds->parent_obj.dh_params);
> +        gnutls_anon_set_server_dh_params(box->data.anonserver,
> +                                         box->dh_params);
>      } else {
> -        ret =3D
> gnutls_anon_allocate_client_credentials(&creds->data.client);
> +        ret =3D
> gnutls_anon_allocate_client_credentials(&box->data.anonclient);
>          if (ret < 0) {
>              error_setg(errp, "Cannot allocate credentials: %s",
>                         gnutls_strerror(ret));
>              return -1;
>          }
>      }
> +    creds->parent_obj.box =3D g_steal_pointer(&box);
>
>      return 0;
>  }
>
>
> -static void
> -qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds)
> -{
> -    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_CLI=
ENT) {
> -        if (creds->data.client) {
> -            gnutls_anon_free_client_credentials(creds->data.client);
> -            creds->data.client =3D NULL;
> -        }
> -    } else {
> -        if (creds->data.server) {
> -            gnutls_anon_free_server_credentials(creds->data.server);
> -            creds->data.server =3D NULL;
> -        }
> -    }
> -}
> -
>  #else /* ! CONFIG_GNUTLS */
>
>
> @@ -105,13 +92,6 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *cred=
s
> G_GNUC_UNUSED,
>  }
>
>
> -static void
> -qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds G_GNUC_UNUSED)
> -{
> -    /* nada */
> -}
> -
> -
>  #endif /* ! CONFIG_GNUTLS */
>
>
> @@ -124,15 +104,6 @@ qcrypto_tls_creds_anon_complete(UserCreatable *uc,
> Error **errp)
>  }
>
>
> -static void
> -qcrypto_tls_creds_anon_finalize(Object *obj)
> -{
> -    QCryptoTLSCredsAnon *creds =3D QCRYPTO_TLS_CREDS_ANON(obj);
> -
> -    qcrypto_tls_creds_anon_unload(creds);
> -}
> -
> -
>  static void
>  qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)
>  {
> @@ -148,7 +119,6 @@ static const TypeInfo qcrypto_tls_creds_anon_info =3D=
 {
>      .parent =3D TYPE_QCRYPTO_TLS_CREDS,
>      .name =3D TYPE_QCRYPTO_TLS_CREDS_ANON,
>      .instance_size =3D sizeof(QCryptoTLSCredsAnon),
> -    .instance_finalize =3D qcrypto_tls_creds_anon_finalize,
>      .class_size =3D sizeof(QCryptoTLSCredsAnonClass),
>      .class_init =3D qcrypto_tls_creds_anon_class_init,
>      .interfaces =3D (const InterfaceInfo[]) {
> diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
> index df9815a286..4e6dffa22f 100644
> --- a/crypto/tlscredspriv.h
> +++ b/crypto/tlscredspriv.h
> @@ -22,6 +22,7 @@
>  #define QCRYPTO_TLSCREDSPRIV_H
>
>  #include "crypto/tlscreds.h"
> +#include "crypto/tlscredsbox.h"
>
>  #ifdef CONFIG_GNUTLS
>  #include <gnutls/gnutls.h>
> @@ -31,39 +32,22 @@ struct QCryptoTLSCreds {
>      Object parent_obj;
>      char *dir;
>      QCryptoTLSCredsEndpoint endpoint;
> -#ifdef CONFIG_GNUTLS
> -    gnutls_dh_params_t dh_params;
> -#endif
>      bool verifyPeer;
>      char *priority;
> +    QCryptoTLSCredsBox *box;
>  };
>
>  struct QCryptoTLSCredsAnon {
>      QCryptoTLSCreds parent_obj;
> -#ifdef CONFIG_GNUTLS
> -    union {
> -        gnutls_anon_server_credentials_t server;
> -        gnutls_anon_client_credentials_t client;
> -    } data;
> -#endif
>  };
>
>  struct QCryptoTLSCredsPSK {
>      QCryptoTLSCreds parent_obj;
>      char *username;
> -#ifdef CONFIG_GNUTLS
> -    union {
> -        gnutls_psk_server_credentials_t server;
> -        gnutls_psk_client_credentials_t client;
> -    } data;
> -#endif
>  };
>
>  struct QCryptoTLSCredsX509 {
>      QCryptoTLSCreds parent_obj;
> -#ifdef CONFIG_GNUTLS
> -    gnutls_certificate_credentials_t data;
> -#endif
>      bool sanityCheck;
>      char *passwordid;
>  };
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index 6c2feae077..5568f1ad0c 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -71,6 +71,7 @@ static int
>  qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
>                             Error **errp)
>  {
> +    g_autoptr(QCryptoTLSCredsBox) box =3D NULL;
>      g_autofree char *pskfile =3D NULL;
>      g_autofree char *dhparams =3D NULL;
>      const char *username;
> @@ -87,6 +88,8 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
>      }
>
>      if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> +        box =3D qcrypto_tls_creds_box_new_server(GNUTLS_CRD_PSK);
> +
>          if (creds->username) {
>              error_setg(errp, "username should not be set when
> endpoint=3Dserver");
>              goto cleanup;
> @@ -101,7 +104,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
>              goto cleanup;
>          }
>
> -        ret =3D gnutls_psk_allocate_server_credentials(&creds->data.serv=
er);
> +        ret =3D
> gnutls_psk_allocate_server_credentials(&box->data.pskserver);
>          if (ret < 0) {
>              error_setg(errp, "Cannot allocate credentials: %s",
>                         gnutls_strerror(ret));
> @@ -109,20 +112,23 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *cred=
s,
>          }
>
>          if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj,
> dhparams,
> -
>  &creds->parent_obj.dh_params,
> +                                                 &box->dh_params,
>                                                   errp) < 0) {
>              goto cleanup;
>          }
>
> -        ret =3D gnutls_psk_set_server_credentials_file(creds->data.serve=
r,
> pskfile);
> +        ret =3D gnutls_psk_set_server_credentials_file(box->data.pskserv=
er,
> +                                                     pskfile);
>          if (ret < 0) {
>              error_setg(errp, "Cannot set PSK server credentials: %s",
>                         gnutls_strerror(ret));
>              goto cleanup;
>          }
> -        gnutls_psk_set_server_dh_params(creds->data.server,
> -                                        creds->parent_obj.dh_params);
> +        gnutls_psk_set_server_dh_params(box->data.pskserver,
> +                                        box->dh_params);
>      } else {
> +        box =3D qcrypto_tls_creds_box_new_client(GNUTLS_CRD_PSK);
> +
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_PSKFILE,
>                                         true, &pskfile, errp) < 0) {
> @@ -138,14 +144,14 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *cred=
s,
>              goto cleanup;
>          }
>
> -        ret =3D gnutls_psk_allocate_client_credentials(&creds->data.clie=
nt);
> +        ret =3D
> gnutls_psk_allocate_client_credentials(&box->data.pskclient);
>          if (ret < 0) {
>              error_setg(errp, "Cannot allocate credentials: %s",
>                         gnutls_strerror(ret));
>              goto cleanup;
>          }
>
> -        ret =3D gnutls_psk_set_client_credentials(creds->data.client,
> +        ret =3D gnutls_psk_set_client_credentials(box->data.pskclient,
>                                                  username, &key,
> GNUTLS_PSK_KEY_HEX);
>          if (ret < 0) {
>              error_setg(errp, "Cannot set PSK client credentials: %s",
> @@ -153,6 +159,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
>              goto cleanup;
>          }
>      }
> +    creds->parent_obj.box =3D g_steal_pointer(&box);
>
>      rv =3D 0;
>   cleanup:
> @@ -160,23 +167,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds=
,
>      return rv;
>  }
>
> -
> -static void
> -qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)
> -{
> -    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_CLI=
ENT) {
> -        if (creds->data.client) {
> -            gnutls_psk_free_client_credentials(creds->data.client);
> -            creds->data.client =3D NULL;
> -        }
> -    } else {
> -        if (creds->data.server) {
> -            gnutls_psk_free_server_credentials(creds->data.server);
> -            creds->data.server =3D NULL;
> -        }
> -    }
> -}
> -
>  #else /* ! CONFIG_GNUTLS */
>
>
> @@ -188,13 +178,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds
> G_GNUC_UNUSED,
>  }
>
>
> -static void
> -qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED)
> -{
> -    /* nada */
> -}
> -
> -
>  #endif /* ! CONFIG_GNUTLS */
>
>
> @@ -212,7 +195,6 @@ qcrypto_tls_creds_psk_finalize(Object *obj)
>  {
>      QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
>
> -    qcrypto_tls_creds_psk_unload(creds);
>      g_free(creds->username);
>  }
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index f2f1aa2815..ef31ea664c 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -562,6 +562,7 @@ static int
>  qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
>                              Error **errp)
>  {
> +    g_autoptr(QCryptoTLSCredsBox) box =3D NULL;
>      g_autofree char *cacert =3D NULL;
>      g_autofree char *cacrl =3D NULL;
>      g_autofree char *cert =3D NULL;
> @@ -578,6 +579,19 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>
>      trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
>
> +    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> +        box =3D qcrypto_tls_creds_box_new_server(GNUTLS_CRD_CERTIFICATE)=
;
> +    } else {
> +        box =3D qcrypto_tls_creds_box_new_client(GNUTLS_CRD_CERTIFICATE)=
;
> +    }
> +
> +    ret =3D gnutls_certificate_allocate_credentials(&box->data.cert);
> +    if (ret < 0) {
> +        error_setg(errp, "Cannot allocate credentials: '%s'",
> +                   gnutls_strerror(ret));
> +        return -1;
> +    }
> +
>      if (qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                     QCRYPTO_TLS_CREDS_X509_CA_CERT,
>                                     true, &cacert, errp) < 0) {
> @@ -616,14 +630,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>          return -1;
>      }
>
> -    ret =3D gnutls_certificate_allocate_credentials(&creds->data);
> -    if (ret < 0) {
> -        error_setg(errp, "Cannot allocate credentials: '%s'",
> -                   gnutls_strerror(ret));
> -        return -1;
> -    }
> -
> -    ret =3D gnutls_certificate_set_x509_trust_file(creds->data,
> +    ret =3D gnutls_certificate_set_x509_trust_file(box->data.cert,
>                                                   cacert,
>                                                   GNUTLS_X509_FMT_PEM);
>      if (ret < 0) {
> @@ -641,7 +648,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>                  return -1;
>              }
>          }
> -        ret =3D gnutls_certificate_set_x509_key_file2(creds->data,
> +        ret =3D gnutls_certificate_set_x509_key_file2(box->data.cert,
>                                                      cert, key,
>                                                      GNUTLS_X509_FMT_PEM,
>                                                      password,
> @@ -655,7 +662,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>      }
>
>      if (cacrl !=3D NULL) {
> -        ret =3D gnutls_certificate_set_x509_crl_file(creds->data,
> +        ret =3D gnutls_certificate_set_x509_crl_file(box->data.cert,
>                                                     cacrl,
>                                                     GNUTLS_X509_FMT_PEM);
>          if (ret < 0) {
> @@ -667,28 +674,18 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>
>      if (isServer) {
>          if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj,
> dhparams,
> -
>  &creds->parent_obj.dh_params,
> +                                                 &box->dh_params,
>                                                   errp) < 0) {
>              return -1;
>          }
> -        gnutls_certificate_set_dh_params(creds->data,
> -                                         creds->parent_obj.dh_params);
> +        gnutls_certificate_set_dh_params(box->data.cert, box->dh_params)=
;
>      }
> +    creds->parent_obj.box =3D g_steal_pointer(&box);
>
>      return 0;
>  }
>
>
> -static void
> -qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds)
> -{
> -    if (creds->data) {
> -        gnutls_certificate_free_credentials(creds->data);
> -        creds->data =3D NULL;
> -    }
> -}
> -
> -
>  #else /* ! CONFIG_GNUTLS */
>
>
> @@ -700,13 +697,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds G_GNUC_UNUSED,
>  }
>
>
> -static void
> -qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds G_GNUC_UNUSED)
> -{
> -    /* nada */
> -}
> -
> -
>  #endif /* ! CONFIG_GNUTLS */
>
>
> @@ -769,29 +759,17 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds
> *creds, Error **errp)
>  {
>      QCryptoTLSCredsX509 *x509_creds =3D QCRYPTO_TLS_CREDS_X509(creds);
>      Error *local_err =3D NULL;
> -    gnutls_certificate_credentials_t creds_data =3D x509_creds->data;
> -    gnutls_dh_params_t creds_dh_params =3D creds->dh_params;
> +    QCryptoTLSCredsBox *creds_box =3D creds->box;
>
> -    x509_creds->data =3D NULL;
> -    creds->dh_params =3D NULL;
> +    creds->box =3D NULL;
>      qcrypto_tls_creds_x509_load(x509_creds, &local_err);
>      if (local_err) {
> -        qcrypto_tls_creds_x509_unload(x509_creds);
> -        if (creds->dh_params) {
> -            gnutls_dh_params_deinit(creds->dh_params);
> -        }
> -        x509_creds->data =3D creds_data;
> -        creds->dh_params =3D creds_dh_params;
> +        creds->box =3D creds_box;
>          error_propagate(errp, local_err);
>          return false;
>      }
>
> -    if (creds_data) {
> -        gnutls_certificate_free_credentials(creds_data);
> -    }
> -    if (creds_dh_params) {
> -        gnutls_dh_params_deinit(creds_dh_params);
> -    }
> +    qcrypto_tls_creds_box_unref(creds_box);
>      return true;
>  }
>
> @@ -824,7 +802,6 @@ qcrypto_tls_creds_x509_finalize(Object *obj)
>      QCryptoTLSCredsX509 *creds =3D QCRYPTO_TLS_CREDS_X509(obj);
>
>      g_free(creds->passwordid);
> -    qcrypto_tls_creds_x509_unload(creds);
>  }
>
>
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 77f334add3..a1dc3b3ce0 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -38,6 +38,7 @@
>
>  struct QCryptoTLSSession {
>      QCryptoTLSCreds *creds;
> +    QCryptoTLSCredsBox *credsbox;
>      gnutls_session_t handle;
>      char *hostname;
>      char *authzid;
> @@ -78,6 +79,7 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
>      g_free(session->hostname);
>      g_free(session->peername);
>      g_free(session->authzid);
> +    qcrypto_tls_creds_box_unref(session->credsbox);
>      object_unref(OBJECT(session->creds));
>      qemu_mutex_destroy(&session->lock);
>      g_free(session);
> @@ -206,63 +208,31 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>          goto error;
>      }
>
> -    if (object_dynamic_cast(OBJECT(creds),
> -                            TYPE_QCRYPTO_TLS_CREDS_ANON)) {
> -        QCryptoTLSCredsAnon *acreds =3D QCRYPTO_TLS_CREDS_ANON(creds);
> -        if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
> -            ret =3D gnutls_credentials_set(session->handle,
> -                                         GNUTLS_CRD_ANON,
> -                                         acreds->data.server);
> -        } else {
> -            ret =3D gnutls_credentials_set(session->handle,
> -                                         GNUTLS_CRD_ANON,
> -                                         acreds->data.client);
> -        }
> -        if (ret < 0) {
> -            error_setg(errp, "Cannot set session credentials: %s",
> -                       gnutls_strerror(ret));
> -            goto error;
> -        }
> -    } else if (object_dynamic_cast(OBJECT(creds),
> -                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
> -        QCryptoTLSCredsPSK *pcreds =3D QCRYPTO_TLS_CREDS_PSK(creds);
> -        if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
> -            ret =3D gnutls_credentials_set(session->handle,
> -                                         GNUTLS_CRD_PSK,
> -                                         pcreds->data.server);
> -        } else {
> -            ret =3D gnutls_credentials_set(session->handle,
> -                                         GNUTLS_CRD_PSK,
> -                                         pcreds->data.client);
> -        }
> -        if (ret < 0) {
> -            error_setg(errp, "Cannot set session credentials: %s",
> -                       gnutls_strerror(ret));
> -            goto error;
> -        }
> -    } else if (object_dynamic_cast(OBJECT(creds),
> -                                   TYPE_QCRYPTO_TLS_CREDS_X509)) {
> -        QCryptoTLSCredsX509 *tcreds =3D QCRYPTO_TLS_CREDS_X509(creds);
> +    ret =3D gnutls_credentials_set(session->handle,
> +                                 creds->box->type,
> +                                 creds->box->data.any);
> +    if (ret < 0) {
> +        error_setg(errp, "Cannot set session credentials: %s",
> +                   gnutls_strerror(ret));
> +        goto error;
> +    }
>
> -        ret =3D gnutls_credentials_set(session->handle,
> -                                     GNUTLS_CRD_CERTIFICATE,
> -                                     tcreds->data);
> -        if (ret < 0) {
> -            error_setg(errp, "Cannot set session credentials: %s",
> -                       gnutls_strerror(ret));
> -            goto error;
> -        }
> +    /*
> +     * creds->box->data.any must be kept alive for as long
> +     * as the gnutls_session_t is alive, so acquire a ref
> +     */
> +    qcrypto_tls_creds_box_ref(creds->box);
> +    session->credsbox =3D creds->box;
>
> -        if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
> -            /* This requests, but does not enforce a client cert.
> -             * The cert checking code later does enforcement */
> -            gnutls_certificate_server_set_request(session->handle,
> -                                                  GNUTLS_CERT_REQUEST);
> -        }
> -    } else {
> -        error_setg(errp, "Unsupported TLS credentials type %s",
> -                   object_get_typename(OBJECT(creds)));
> -        goto error;
> +    if (object_dynamic_cast(OBJECT(creds),
> +                            TYPE_QCRYPTO_TLS_CREDS_X509) &&
> +        creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
> +        /*
> +         * This requests, but does not enforce a client cert.
> +         * The cert checking code later does enforcement
> +         */
> +        gnutls_certificate_server_set_request(session->handle,
> +                                              GNUTLS_CERT_REQUEST);
>      }
>
>      gnutls_transport_set_ptr(session->handle, session);
> --
> 2.51.1
>
>

--0000000000006bc5c50642729b98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">As described in the previous commit, th=
e gnutls credentials need to<br>
be kept alive for as long as the gnutls session object exists. Convert<br>
the QCryptoTLSCreds objects to use QCryptoTLSCredsBox and holding the<br>
gnutls credential objects. When loading the credentials into a gnutls<br>
session, store a reference to the box into the QCryptoTLSSession object.<br=
>
<br>
This has the useful side effect that the QCryptoTLSSession code no<br>
longer needs to know about all the different credential types, it can<br>
use the generic pointer stored in the box.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +--<br>
=C2=A0crypto/tlscredsanon.c | 48 +++++---------------------<br>
=C2=A0crypto/tlscredspriv.h | 20 ++---------<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 | 46 ++++++++-----------------<br>
=C2=A0crypto/tlscredsx509.c | 71 +++++++++++++-------------------------<br>
=C2=A0crypto/tlssession.c=C2=A0 =C2=A0| 80 ++++++++++++++------------------=
-----------<br>
=C2=A06 files changed, 75 insertions(+), 195 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 9433b4c363..798c9712fb 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -246,10 +246,7 @@ qcrypto_tls_creds_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds *creds =3D QCRYPTO_TLS_CREDS(obj);<br>
<br>
-=C2=A0 =C2=A0 if (creds-&gt;dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&gt;dh_params);<=
br>
-=C2=A0 =C2=A0 }<br>
-<br>
+=C2=A0 =C2=A0 qcrypto_tls_creds_box_unref(creds-&gt;box);<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;dir);<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;priority);<br>
=C2=A0}<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index 5c55b07b2f..0a728ccbf6 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -36,6 +36,7 @@ static int<br>
=C2=A0qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 g_autoptr(QCryptoTLSCredsBox) box =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *dhparams =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
@@ -43,6 +44,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;parent_obj.dir ? =
creds-&gt;parent_obj.dir : &quot;&lt;nodir&gt;&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CR=
EDS_ENDPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D qcrypto_tls_creds_box_new_server(GNUTL=
S_CRD_ANON);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.dir &amp;&amp;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(=
&amp;creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_DH_PARAMS,<br>
@@ -50,7 +53,7 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_anon_allocate_server_credential=
s(&amp;creds-&gt;data.server);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_anon_allocate_server_credential=
s(&amp;box-&gt;data.anonserver);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot allocate credentials: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
@@ -58,42 +61,26 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_dh_params_file(=
&amp;creds-&gt;parent_obj, dhparams,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;creds-&gt;parent_obj.dh_params,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0errp) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;box-&gt;dh_params, errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_set_server_dh_params(creds-&gt;dat=
a.server,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cr=
eds-&gt;parent_obj.dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_set_server_dh_params(box-&gt;data.=
anonserver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
x-&gt;dh_params);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_anon_allocate_client_credential=
s(&amp;creds-&gt;data.client);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_anon_allocate_client_credential=
s(&amp;box-&gt;data.anonclient);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot allocate credentials: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 creds-&gt;parent_obj.box =3D g_steal_pointer(&amp;box);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds)<br>
-{<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_E=
NDPOINT_CLIENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;data.client) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_free_client_credenti=
als(creds-&gt;data.client);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;data.client =3D NULL;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;data.server) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_free_server_credenti=
als(creds-&gt;data.server);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;data.server =3D NULL;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
=C2=A0#else /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -105,13 +92,6 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds =
G_GNUC_UNUSED,<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds G_GNUC_UNUSED)<br=
>
-{<br>
-=C2=A0 =C2=A0 /* nada */<br>
-}<br>
-<br>
-<br>
=C2=A0#endif /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -124,15 +104,6 @@ qcrypto_tls_creds_anon_complete(UserCreatable *uc, Err=
or **errp)<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_anon_finalize(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 QCryptoTLSCredsAnon *creds =3D QCRYPTO_TLS_CREDS_ANON(obj);<=
br>
-<br>
-=C2=A0 =C2=A0 qcrypto_tls_creds_anon_unload(creds);<br>
-}<br>
-<br>
-<br>
=C2=A0static void<br>
=C2=A0qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)<=
br>
=C2=A0{<br>
@@ -148,7 +119,6 @@ static const TypeInfo qcrypto_tls_creds_anon_info =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_QCRYPTO_TLS_CREDS,<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_QCRYPTO_TLS_CREDS_ANON,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(QCryptoTLSCredsAnon),<br>
-=C2=A0 =C2=A0 .instance_finalize =3D qcrypto_tls_creds_anon_finalize,<br>
=C2=A0 =C2=A0 =C2=A0.class_size =3D sizeof(QCryptoTLSCredsAnonClass),<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D qcrypto_tls_creds_anon_class_init,<br>
=C2=A0 =C2=A0 =C2=A0.interfaces =3D (const InterfaceInfo[]) {<br>
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h<br>
index df9815a286..4e6dffa22f 100644<br>
--- a/crypto/tlscredspriv.h<br>
+++ b/crypto/tlscredspriv.h<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#define QCRYPTO_TLSCREDSPRIV_H<br>
<br>
=C2=A0#include &quot;crypto/tlscreds.h&quot;<br>
+#include &quot;crypto/tlscredsbox.h&quot;<br>
<br>
=C2=A0#ifdef CONFIG_GNUTLS<br>
=C2=A0#include &lt;gnutls/gnutls.h&gt;<br>
@@ -31,39 +32,22 @@ struct QCryptoTLSCreds {<br>
=C2=A0 =C2=A0 =C2=A0Object parent_obj;<br>
=C2=A0 =C2=A0 =C2=A0char *dir;<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsEndpoint endpoint;<br>
-#ifdef CONFIG_GNUTLS<br>
-=C2=A0 =C2=A0 gnutls_dh_params_t dh_params;<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0bool verifyPeer;<br>
=C2=A0 =C2=A0 =C2=A0char *priority;<br>
+=C2=A0 =C2=A0 QCryptoTLSCredsBox *box;<br>
=C2=A0};<br>
<br>
=C2=A0struct QCryptoTLSCredsAnon {<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds parent_obj;<br>
-#ifdef CONFIG_GNUTLS<br>
-=C2=A0 =C2=A0 union {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_server_credentials_t server;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_client_credentials_t client;<br>
-=C2=A0 =C2=A0 } data;<br>
-#endif<br>
=C2=A0};<br>
<br>
=C2=A0struct QCryptoTLSCredsPSK {<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds parent_obj;<br>
=C2=A0 =C2=A0 =C2=A0char *username;<br>
-#ifdef CONFIG_GNUTLS<br>
-=C2=A0 =C2=A0 union {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_server_credentials_t server;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_client_credentials_t client;<br>
-=C2=A0 =C2=A0 } data;<br>
-#endif<br>
=C2=A0};<br>
<br>
=C2=A0struct QCryptoTLSCredsX509 {<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds parent_obj;<br>
-#ifdef CONFIG_GNUTLS<br>
-=C2=A0 =C2=A0 gnutls_certificate_credentials_t data;<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0bool sanityCheck;<br>
=C2=A0 =C2=A0 =C2=A0char *passwordid;<br>
=C2=A0};<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index 6c2feae077..5568f1ad0c 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -71,6 +71,7 @@ static int<br>
=C2=A0qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 g_autoptr(QCryptoTLSCredsBox) box =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *pskfile =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *dhparams =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *username;<br>
@@ -87,6 +88,8 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CR=
EDS_ENDPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D qcrypto_tls_creds_box_new_server(GNUTL=
S_CRD_PSK);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (creds-&gt;username) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;user=
name should not be set when endpoint=3Dserver&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
@@ -101,7 +104,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_allocate_server_credentials=
(&amp;creds-&gt;data.server);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_allocate_server_credentials=
(&amp;box-&gt;data.pskserver);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot allocate credentials: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
@@ -109,20 +112,23 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_dh_params_file(=
&amp;creds-&gt;parent_obj, dhparams,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;creds-&gt;parent_obj.dh_params,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;box-&gt;dh_params,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_set_server_credentials_file=
(creds-&gt;data.server, pskfile);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_set_server_credentials_file=
(box-&gt;data.pskserver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pskfile);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot set PSK server credentials: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_set_server_dh_params(creds-&gt;data=
.server,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&g=
t;parent_obj.dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_set_server_dh_params(box-&gt;data.p=
skserver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box-&gt;=
dh_params);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D qcrypto_tls_creds_box_new_client(GNUTL=
S_CRD_PSK);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_PSKFILE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true, &a=
mp;pskfile, errp) &lt; 0) {<br>
@@ -138,14 +144,14 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_allocate_client_credentials=
(&amp;creds-&gt;data.client);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_allocate_client_credentials=
(&amp;box-&gt;data.pskclient);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot allocate credentials: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_set_client_credentials(cred=
s-&gt;data.client,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_psk_set_client_credentials(box-=
&gt;data.pskclient,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0username, &amp;key, GNUTLS_PSK_KEY_HEX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot set PSK client credentials: %s&quot;,<br>
@@ -153,6 +159,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 creds-&gt;parent_obj.box =3D g_steal_pointer(&amp;box);<br>
<br>
=C2=A0 =C2=A0 =C2=A0rv =3D 0;<br>
=C2=A0 cleanup:<br>
@@ -160,23 +167,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<=
br>
=C2=A0 =C2=A0 =C2=A0return rv;<br>
=C2=A0}<br>
<br>
-<br>
-static void<br>
-qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)<br>
-{<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_E=
NDPOINT_CLIENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;data.client) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_free_client_credentia=
ls(creds-&gt;data.client);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;data.client =3D NULL;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;data.server) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_free_server_credentia=
ls(creds-&gt;data.server);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;data.server =3D NULL;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
=C2=A0#else /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -188,13 +178,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds G=
_GNUC_UNUSED,<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED)<br>
-{<br>
-=C2=A0 =C2=A0 /* nada */<br>
-}<br>
-<br>
-<br>
=C2=A0#endif /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -212,7 +195,6 @@ qcrypto_tls_creds_psk_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj=
);<br>
<br>
-=C2=A0 =C2=A0 qcrypto_tls_creds_psk_unload(creds);<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;username);<br>
=C2=A0}<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index f2f1aa2815..ef31ea664c 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -562,6 +562,7 @@ static int<br>
=C2=A0qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 g_autoptr(QCryptoTLSCredsBox) box =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *cacert =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *cacrl =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *cert =3D NULL;<br>
@@ -578,6 +579,19 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_creds_x509_load(creds, creds-&gt;pare=
nt_obj.dir);<br>
<br>
+=C2=A0 =C2=A0 if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_E=
NDPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D qcrypto_tls_creds_box_new_server(GNUTL=
S_CRD_CERTIFICATE);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 box =3D qcrypto_tls_creds_box_new_client(GNUTL=
S_CRD_CERTIFICATE);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D gnutls_certificate_allocate_credentials(&amp;box-&gt=
;data.cert);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot allocate credent=
ials: &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutl=
s_strerror(ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds-&gt;parent_ob=
j,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_TLS_CREDS_X509=
_CA_CERT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true, &amp;cacert, err=
p) &lt; 0) {<br>
@@ -616,14 +630,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D gnutls_certificate_allocate_credentials(&amp;creds-&=
gt;data);<br>
-=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot allocate credent=
ials: &#39;%s&#39;&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutl=
s_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_trust_file(creds-&gt;dat=
a,<br>
+=C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_trust_file(box-&gt;data.=
cert,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cacert,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 GNUTLS_X509_FMT_PEM);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
@@ -641,7 +648,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_key_file2(=
creds-&gt;data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_key_file2(=
box-&gt;data.cert,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cert, key,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GNUTLS_X509_FMT_PEM,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0password,<br>
@@ -655,7 +662,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cacrl !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_crl_file(c=
reds-&gt;data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_certificate_set_x509_crl_file(b=
ox-&gt;data.cert,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cacrl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GNUTLS_X509_FMT_PEM);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
@@ -667,28 +674,18 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (isServer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_dh_params_file(=
&amp;creds-&gt;parent_obj, dhparams,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;creds-&gt;parent_obj.dh_params,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;box-&gt;dh_params,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_set_dh_params(creds-&gt;dat=
a,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cr=
eds-&gt;parent_obj.dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_set_dh_params(box-&gt;data.=
cert, box-&gt;dh_params);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 creds-&gt;parent_obj.box =3D g_steal_pointer(&amp;box);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds)<br>
-{<br>
-=C2=A0 =C2=A0 if (creds-&gt;data) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_free_credentials(creds-&gt;=
data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;data =3D NULL;<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-<br>
=C2=A0#else /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -700,13 +697,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds=
 G_GNUC_UNUSED,<br>
=C2=A0}<br>
<br>
<br>
-static void<br>
-qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds G_GNUC_UNUSED)<br=
>
-{<br>
-=C2=A0 =C2=A0 /* nada */<br>
-}<br>
-<br>
-<br>
=C2=A0#endif /* ! CONFIG_GNUTLS */<br>
<br>
<br>
@@ -769,29 +759,17 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds,=
 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsX509 *x509_creds =3D QCRYPTO_TLS_CREDS_X=
509(creds);<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 gnutls_certificate_credentials_t creds_data =3D x509_creds-&=
gt;data;<br>
-=C2=A0 =C2=A0 gnutls_dh_params_t creds_dh_params =3D creds-&gt;dh_params;<=
br>
+=C2=A0 =C2=A0 QCryptoTLSCredsBox *creds_box =3D creds-&gt;box;<br>
<br>
-=C2=A0 =C2=A0 x509_creds-&gt;data =3D NULL;<br>
-=C2=A0 =C2=A0 creds-&gt;dh_params =3D NULL;<br>
+=C2=A0 =C2=A0 creds-&gt;box =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_load(x509_creds, &amp;local_err)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_x509_unload(x509_creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&g=
t;dh_params);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 x509_creds-&gt;data =3D creds_data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;dh_params =3D creds_dh_params;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;box =3D creds_box;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (creds_data) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_free_credentials(creds_data=
);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (creds_dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds_dh_params);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qcrypto_tls_creds_box_unref(creds_box);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
@@ -824,7 +802,6 @@ qcrypto_tls_creds_x509_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsX509 *creds =3D QCRYPTO_TLS_CREDS_X509(o=
bj);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;passwordid);<br>
-=C2=A0 =C2=A0 qcrypto_tls_creds_x509_unload(creds);<br>
=C2=A0}<br>
<br>
<br>
diff --git a/crypto/tlssession.c b/crypto/tlssession.c<br>
index 77f334add3..a1dc3b3ce0 100644<br>
--- a/crypto/tlssession.c<br>
+++ b/crypto/tlssession.c<br>
@@ -38,6 +38,7 @@<br>
<br>
=C2=A0struct QCryptoTLSSession {<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds *creds;<br>
+=C2=A0 =C2=A0 QCryptoTLSCredsBox *credsbox;<br>
=C2=A0 =C2=A0 =C2=A0gnutls_session_t handle;<br>
=C2=A0 =C2=A0 =C2=A0char *hostname;<br>
=C2=A0 =C2=A0 =C2=A0char *authzid;<br>
@@ -78,6 +79,7 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)<br>
=C2=A0 =C2=A0 =C2=A0g_free(session-&gt;hostname);<br>
=C2=A0 =C2=A0 =C2=A0g_free(session-&gt;peername);<br>
=C2=A0 =C2=A0 =C2=A0g_free(session-&gt;authzid);<br>
+=C2=A0 =C2=A0 qcrypto_tls_creds_box_unref(session-&gt;credsbox);<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(session-&gt;creds));<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_destroy(&amp;session-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0g_free(session);<br>
@@ -206,63 +208,31 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (object_dynamic_cast(OBJECT(creds),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_QCRYPTO_TLS_CREDS_ANON)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoTLSCredsAnon *acreds =3D QCRYPTO_TLS_CR=
EDS_ANON(creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;endpoint =3D=3D QCRYPTO_TLS_CRED=
S_ENDPOINT_SERVER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_credentials_set(s=
ession-&gt;handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GN=
UTLS_CRD_ANON,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ac=
reds-&gt;data.server);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_credentials_set(s=
ession-&gt;handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GN=
UTLS_CRD_ANON,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ac=
reds-&gt;data.client);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot se=
t session credentials: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if (object_dynamic_cast(OBJECT(creds),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_QCRYPTO_TLS_CREDS_=
PSK)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoTLSCredsPSK *pcreds =3D QCRYPTO_TLS_CRE=
DS_PSK(creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;endpoint =3D=3D QCRYPTO_TLS_CRED=
S_ENDPOINT_SERVER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_credentials_set(s=
ession-&gt;handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GN=
UTLS_CRD_PSK,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pc=
reds-&gt;data.server);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_credentials_set(s=
ession-&gt;handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GN=
UTLS_CRD_PSK,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pc=
reds-&gt;data.client);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot se=
t session credentials: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if (object_dynamic_cast(OBJECT(creds),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_QCRYPTO_TLS_CREDS_=
X509)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoTLSCredsX509 *tcreds =3D QCRYPTO_TLS_CR=
EDS_X509(creds);<br>
+=C2=A0 =C2=A0 ret =3D gnutls_credentials_set(session-&gt;handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;box-&gt;type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;box-&gt;data.any);<b=
r>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot set session cred=
entials: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutl=
s_strerror(ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_credentials_set(session-&gt;han=
dle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GNUTLS_CRD_CERTI=
FICATE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcreds-&gt;data)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot se=
t session credentials: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* creds-&gt;box-&gt;data.any must be kept alive for as=
 long<br>
+=C2=A0 =C2=A0 =C2=A0* as the gnutls_session_t is alive, so acquire a ref<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 qcrypto_tls_creds_box_ref(creds-&gt;box);<br>
+=C2=A0 =C2=A0 session-&gt;credsbox =3D creds-&gt;box;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;endpoint =3D=3D QCRYPTO_TLS_CRED=
S_ENDPOINT_SERVER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This requests, but does not e=
nforce a client cert.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The cert checking code l=
ater does enforcement */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_server_set_re=
quest(session-&gt;handle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 GNUTLS_CERT_REQUEST);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unsupported TLS credent=
ials type %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0objec=
t_get_typename(OBJECT(creds)));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 if (object_dynamic_cast(OBJECT(creds),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_QCRYPTO_TLS_CREDS_X509) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;endpoint =3D=3D QCRYPTO_TLS_CREDS_EN=
DPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This requests, but does not enforce a =
client cert.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The cert checking code later does enfo=
rcement<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_server_set_request(session-=
&gt;handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 GNUTLS_CERT_REQUEST);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0gnutls_transport_set_ptr(session-&gt;handle, session);<=
br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--0000000000006bc5c50642729b98--


