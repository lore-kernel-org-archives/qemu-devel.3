Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C56CCF9FE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYN0-0002EP-H9; Thu, 30 Oct 2025 15:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYMu-0002Ca-En
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYMl-0005cJ-K6
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAbYVwRcarBDX/vkEKyB7UWcZC+bH4ku/qdXMMoXhfA=;
 b=Ht6Svf2XhznbmM8y7AuvArQ1f07TWe2iuNvxOV+vinAiEUzCQzyfVMC4DK6RDW6+/y7m/I
 BDsBKEISBYazC/3TueZzE6YpbLfCdOe0aBFnok0Ga3pE50Z0gEEnktrIBMgef8vFa+rB7g
 kGVeeOJvFKp8rxLmoYoPqUxT+diYd78=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-RcQbfu7dObiYF0d6uN-BRw-1; Thu, 30 Oct 2025 15:31:12 -0400
X-MC-Unique: RcQbfu7dObiYF0d6uN-BRw-1
X-Mimecast-MFC-AGG-ID: RcQbfu7dObiYF0d6uN-BRw_1761852671
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-295093f614cso8740145ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852671; x=1762457471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iAbYVwRcarBDX/vkEKyB7UWcZC+bH4ku/qdXMMoXhfA=;
 b=a2CD+JQo+aeHmUz66ibcklOoedzhTyrtF6TXKrxubyC4TdofF8Z8kBLWNr4CleQwyx
 sbobXRTJljYJ38o+Qv5Nf4SZqD0stlHRw3a0Dpnwj7AyxuD7Bsgq7SV325NcIMK3dzfg
 Euu39WnbykA8dxuxfnJFKIJJauuMSP+UOXWUtAhVZrsYYQXaM6Me5oIyDx4mlkb7PisC
 HY7eGiVxO6XgkVBA6lPfEN0/uT5SisRcXC8pdgdU9ccYW1pepg7zOA+h++7dN3UwJ0WR
 eu6OD9yj6Q5PjUU8kyefh2m/IbwKT0fliujgYFwzyWoxiKwwswB1RL9oWyX7QyE4sW+d
 048A==
X-Gm-Message-State: AOJu0Yxs11CLSDi0fldkG+1k57y4iv6wHZM1iWeJrQkivbh6aKguCc0F
 rU9tfilYQ5a/nIWnVOw2u08CsnrEW4Q5qrSg4fBnqq/ippvz/Ncbfsxs5aHPA7pkIDoi5CD84yR
 JDzduY3HnvodHiT9hf8QnEWT2dPMcj84H6bPqflWuRsukvwV7Tp35LxtbkwchAOWXLGI2KR3apM
 NGTbDf7gXsjnxDfus0JVjKvny9+lcSurE=
X-Gm-Gg: ASbGncvbIuGqLi4SsOs2SoUAxs/+Ed5+pFLppmYcMitib92yZTVsKFtMtX2KeL3BfXl
 ydPysS8X49wv0O9NtvBUl7Vp9SASbmieBS2xNyJZnbUNDRiHS6VxA4uGsJhR/u7ra33pqZSqxaG
 ktUZmwbMRgH08J6gxlNB/L0voPhe7pC2Z/m5pJE//bNwl88CxQSSj91ZzNXkbVbNkqvt3f9g2+b
 UnV2V8OUJfleH0=
X-Received: by 2002:a17:902:e891:b0:24b:1585:6350 with SMTP id
 d9443c01a7336-295185b3b01mr12532835ad.11.1761852670869; 
 Thu, 30 Oct 2025 12:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnswZo0jArx4LFDSxo/Cevv3kAV9UqBuEn/luWw0ZytMgVawTVAzioL9K6TZLVp3crj+MlTSCtdd6yQ1LmvJM=
X-Received: by 2002:a17:902:e891:b0:24b:1585:6350 with SMTP id
 d9443c01a7336-295185b3b01mr12532495ad.11.1761852670316; Thu, 30 Oct 2025
 12:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-2-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:30:58 +0400
X-Gm-Features: AWmQ_blVCslhJCSpn_Z4c8QDjrMvRjbE8dTE2xykKuTXElnVUwaY-tKLpByfEyQ
Message-ID: <CAMxuvawkgPHcV1ts9SbcRELCS871tRgRy3zVHfkNov3mdiEUxw@mail.gmail.com>
Subject: Re: [PATCH 01/21] crypto: remove redundant parameter checking CA certs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000008fa6380642654a2e"
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

--0000000000008fa6380642654a2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The only caller of qcrypto_tls_creds_check_authority_chain always
> passes 'true' for the 'isCA' parameter. The point of this method
> is to check the CA chani, so no other value would ever make sense.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index db2b74bafa..847fd4d9fa 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -315,7 +315,6 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>                                          unsigned int ncacerts,
>                                          const char *cacertFile,
>                                          bool isServer,
> -                                        bool isCA,
>                                          Error **errp)
>  {
>      gnutls_x509_crt_t cert_to_check =3D certs[ncerts - 1];
> @@ -356,7 +355,7 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>               */
>              return qcrypto_tls_creds_check_cert(
>                  creds, cert_to_check, cacertFile,
> -                isServer, isCA, errp);
> +                isServer, true, errp);
>          }
>          for (int i =3D 0; i < ncacerts; i++) {
>              if (gnutls_x509_crt_check_issuer(cert_to_check,
> @@ -370,7 +369,7 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>          }
>
>          if (qcrypto_tls_creds_check_cert(creds, cert_issuer, cacertFile,
> -                                         isServer, isCA, errp) < 0) {
> +                                         isServer, true, errp) < 0) {
>              return -1;
>          }
>
> @@ -534,7 +533,7 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>                                                  certs, ncerts,
>                                                  cacerts, ncacerts,
>                                                  cacertFile, isServer,
> -                                                true, errp) < 0) {
> +                                                errp) < 0) {
>          goto cleanup;
>      }
>
> --
> 2.51.1
>
>

--0000000000008fa6380642654a2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxi
cj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0
dHIiPk9uIFRodSwgT2N0IDMwLCAyMDI1IGF0IDY6NDjigK9QTSBEYW5pZWwgUC4gQmVycmFuZ8Op
ICZsdDs8YSBocmVmPSJtYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmJlcnJhbmdlQHJlZGhhdC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlRoZSBv
bmx5IGNhbGxlciBvZiBxY3J5cHRvX3Rsc19jcmVkc19jaGVja19hdXRob3JpdHlfY2hhaW4gYWx3
YXlzPGJyPg0KcGFzc2VzICYjMzk7dHJ1ZSYjMzk7IGZvciB0aGUgJiMzOTtpc0NBJiMzOTsgcGFy
YW1ldGVyLiBUaGUgcG9pbnQgb2YgdGhpcyBtZXRob2Q8YnI+DQppcyB0byBjaGVjayB0aGUgQ0Eg
Y2hhbmksIHNvIG5vIG90aGVyIHZhbHVlIHdvdWxkIGV2ZXIgbWFrZSBzZW5zZS48YnI+DQo8YnI+
DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgUC4gQmVycmFuZ8OpICZsdDs8YSBocmVmPSJtYWlsdG86
YmVycmFuZ2VAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmJlcnJhbmdlQHJlZGhhdC5jb208
L2E+Jmd0Ozxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5SZXZpZXdlZC1ieTog
TWFyYy1BbmRyw6kgTHVyZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWFyY2FuZHJlLmx1cmVhdUBy
ZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPC9h
PiZndDs8L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KLS0tPGJyPg0KwqBjcnlwdG8vdGxzY3Jl
ZHN4NTA5LmMgfCA3ICsrKy0tLS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2NyeXB0by90bHNjcmVk
c3g1MDkuYyBiL2NyeXB0by90bHNjcmVkc3g1MDkuYzxicj4NCmluZGV4IGRiMmI3NGJhZmEuLjg0
N2ZkNGQ5ZmEgMTAwNjQ0PGJyPg0KLS0tIGEvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jPGJyPg0KKysr
IGIvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jPGJyPg0KQEAgLTMxNSw3ICszMTUsNiBAQCBxY3J5cHRv
X3Rsc19jcmVkc19jaGVja19hdXRob3JpdHlfY2hhaW4oUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3Jl
ZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbmNhY2VydHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBjaGFy
ICpjYWNlcnRGaWxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYm9vbCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYm9vbCBpc0NB
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgRXJyb3IgKiplcnJwKTxicj4NCsKgezxicj4NCsKgIMKgIMKgZ251dGxzX3g1
MDlfY3J0X3QgY2VydF90b19jaGVjayA9IGNlcnRzW25jZXJ0cyAtIDFdOzxicj4NCkBAIC0zNTYs
NyArMzU1LDcgQEAgcWNyeXB0b190bHNfY3JlZHNfY2hlY2tfYXV0aG9yaXR5X2NoYWluKFFDcnlw
dG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgICovPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcWNyeXB0b190bHNfY3JlZHNfY2hlY2tfY2VydCg8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNyZWRzLCBjZXJ0X3RvX2NoZWNrLCBjYWNl
cnRGaWxlLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpc1NlcnZlciwgaXNDQSwgZXJy
cCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlzU2VydmVyLCB0cnVlLCBlcnJwKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoGZvciAoaW50IGkgPSAwOyBp
ICZsdDsgbmNhY2VydHM7IGkrKykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGdudXRs
c194NTA5X2NydF9jaGVja19pc3N1ZXIoY2VydF90b19jaGVjayw8YnI+DQpAQCAtMzcwLDcgKzM2
OSw3IEBAIHFjcnlwdG9fdGxzX2NyZWRzX2NoZWNrX2F1dGhvcml0eV9jaGFpbihRQ3J5cHRvVExT
Q3JlZHNYNTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoGlmIChxY3J5cHRvX3Rsc19jcmVkc19jaGVja19jZXJ0KGNyZWRzLCBjZXJ0X2lzc3Vl
ciwgY2FjZXJ0RmlsZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgaXNDQSwgZXJycCkgJmx0OyAwKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaXNTZXJ2ZXIsIHRydWUsIGVycnApICZsdDsgMCkgezxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCjxicj4NCkBA
IC01MzQsNyArNTMzLDcgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9zYW5pdHlfY2hlY2soUUNy
eXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjZXJ0cywgbmNl
cnRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FjZXJ0cywgbmNhY2VydHMsPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjYWNlcnRGaWxlLCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHJ1
ZSwgZXJycCkgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVycnApICZsdDsgMCkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4N
Ci0tIDxicj4NCjIuNTEuMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCjwv
ZGl2Pg0K
--0000000000008fa6380642654a2e--


