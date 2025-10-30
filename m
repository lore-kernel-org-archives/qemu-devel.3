Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C55CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYNI-0002MI-7G; Thu, 30 Oct 2025 15:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNB-0002LM-WA
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYN9-0005gI-69
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6IcnYc+1ftIJiQzZtMqdrxRtvF40xlfaRtpF5vrY7Zw=;
 b=eg0H+vCQ8hwX63eD6Kb5Tzt/WaBdB6pNAQAF5NP5FSCG+YHo/4RFoaQRbWBstL7fQB3paF
 Cm6b2zUBjPmPCep8Dg4tj/d78gBG8YTliVNj4CCazcw8Stb2GH3ucSul7hT4a+B1n9Ao0V
 HvFIZVLq3lzc531WUMFZncu7J18PfLY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-fJCDA6UIO3yEF_NVeJxqmw-1; Thu, 30 Oct 2025 15:31:35 -0400
X-MC-Unique: fJCDA6UIO3yEF_NVeJxqmw-1
X-Mimecast-MFC-AGG-ID: fJCDA6UIO3yEF_NVeJxqmw_1761852695
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-340299e05easo1331927a91.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852694; x=1762457494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IcnYc+1ftIJiQzZtMqdrxRtvF40xlfaRtpF5vrY7Zw=;
 b=NRrTcTboj2B/HuuSG5z2fR7gvc0oPkMu8y+wblfSTxt5kzwGq/JSPRUwZhD4j6mnYX
 dUYhu9ywW5uog0vlVQWgRMQkGyXTNX168jWJBeXq03rQXthRRGlFf7vly8kOwGctI3D2
 yXqshzth+65/MBxA6kV5qJ7gJ2c4A9o2jYtyhF1w06J1MGDpxfq6fxibJ1X8QNF0wpuz
 Ze+Ao9fGUKqxy1bW1PqvPcR+688Ypct9Ly63m0+L3KI/PMw4+eF0MDyRYtWse5EDhSfj
 dmFRpholhZKbwZoS5NmbUNRF+5uzCyeG8xjQlNvOwNB+3KEG+G85ibLEkJq87TkCMBfW
 yaEg==
X-Gm-Message-State: AOJu0YxCXPy74Rvf4DLPaEaZtm7PLTrkyQYExCEz0BuginHeb+lLJHTP
 XooNHQCk8k2wKIsY3ogjB4eIl4u15eKFGPPLdJLIxfxLireZ1qpHM7G6CLVXIb//8Dd8SiQuj7D
 cJXPmNtYIw6d5orQHO7qSKetSnyOQZfMRe2YYXUnzt8K91e1+oukVexy1Op2agZu5I0rpZs1QDC
 g/tqxKsKSfh3POT6YUn3uRDkukoGn+dhA=
X-Gm-Gg: ASbGnctdvpTt6pYQt11RjGY6/SnwC0iaLGDszT/DXNuHwjg3MgUv23tmpSU37UcTcpk
 sVLTlQADxZ3dwhSpLx15298gYsdpO164ZR9dugBOOsVW3P0SINMlc4cUQOaBcLgL7+stvVanRR8
 /9OY0xETXTIbORCaUwCNRFiDDUXnSydhhR+Ckd0cAravK2YvJCBQBPF8G6lbA2ePN0mNEx5iKDJ
 Ci57bsjc+gsbuI=
X-Received: by 2002:a17:90b:2583:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-34083074f10mr1260675a91.23.1761852694633; 
 Thu, 30 Oct 2025 12:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+4FQQRHpryd/DpbF/TVGOSXuV8gP8f5Cl+XvKS30pv7fB7JcEUGt96hAFJCpG1nC34tVp0KgQm2sEXMRgwQ=
X-Received: by 2002:a17:90b:2583:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-34083074f10mr1260636a91.23.1761852694086; Thu, 30 Oct 2025
 12:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-5-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-5-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:22 +0400
X-Gm-Features: AWmQ_bm4yJ0aD7W2f3ag6yF5jH2nHcZQDc6e8SvgthlTELWNWTvlIrIEj7r8bmc
Message-ID: <CAMxuvawJGA5P0uJ9a0i=LZMso6LMRjzhRAZ2Tzheg8MuJ5bCfg@mail.gmail.com>
Subject: Re: [PATCH 04/21] crypto: remove redundant access() checks before
 loading certs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000fa52460642654baa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--000000000000fa52460642654baa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qcrypto_tls_creds_get_path method will perform an access()
> check on the file and return a NULL path if it fails. By the
> time we get to loading the cert files we know they must exist
> on disk and thus the second access() check is redundant.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 75c70af522..0acb17b6ec 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -496,8 +496,7 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>      size_t i;
>      int ret =3D -1;
>
> -    if (certFile &&
> -        access(certFile, R_OK) =3D=3D 0) {
> +    if (certFile) {
>          if (qcrypto_tls_creds_load_cert_list(creds,
>                                               certFile,
>                                               &certs,
> @@ -508,16 +507,15 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>              goto cleanup;
>          }
>      }
> -    if (access(cacertFile, R_OK) =3D=3D 0) {
> -        if (qcrypto_tls_creds_load_cert_list(creds,
> -                                             cacertFile,
> -                                             &cacerts,
> -                                             &ncacerts,
> -                                             isServer,
> -                                             true,
> -                                             errp) < 0) {
> -            goto cleanup;
> -        }
> +
> +    if (qcrypto_tls_creds_load_cert_list(creds,
> +                                         cacertFile,
> +                                         &cacerts,
> +                                         &ncacerts,
> +                                         isServer,
> +                                         true,
> +                                         errp) < 0) {
> +        goto cleanup;
>      }
>
>      for (i =3D 0; i < ncerts; i++) {
> --
> 2.51.1
>
>

--000000000000fa52460642654baa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaTwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwg
T2N0IDMwLCAyMDI1IGF0IDY6NDjigK9QTSBEYW5pZWwgUC4gQmVycmFuZ8OpICZsdDs8YSBocmVm
PSJtYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmJlcnJhbmdlQHJl
ZGhhdC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlRoZSBxY3J5cHRvX3Rsc19j
cmVkc19nZXRfcGF0aCBtZXRob2Qgd2lsbCBwZXJmb3JtIGFuIGFjY2VzcygpPGJyPg0KY2hlY2sg
b24gdGhlIGZpbGUgYW5kIHJldHVybiBhIE5VTEwgcGF0aCBpZiBpdCBmYWlscy4gQnkgdGhlPGJy
Pg0KdGltZSB3ZSBnZXQgdG8gbG9hZGluZyB0aGUgY2VydCBmaWxlcyB3ZSBrbm93IHRoZXkgbXVz
dCBleGlzdDxicj4NCm9uIGRpc2sgYW5kIHRodXMgdGhlIHNlY29uZCBhY2Nlc3MoKSBjaGVjayBp
cyByZWR1bmRhbnQuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFAuIEJlcnJhbmfD
qSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5iZXJyYW5nZUByZWRoYXQuY29tPC9hPiZndDs8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+UmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSAmbHQ7PGEgaHJlZj0ibWFp
bHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbTwvYT4mZ3Q7PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCi0t
LTxicj4NCsKgY3J5cHRvL3Rsc2NyZWRzeDUwOS5jIHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0t
LTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9jcnlwdG8vdGxzY3JlZHN4NTA5LmMgYi9jcnlwdG8v
dGxzY3JlZHN4NTA5LmM8YnI+DQppbmRleCA3NWM3MGFmNTIyLi4wYWNiMTdiNmVjIDEwMDY0NDxi
cj4NCi0tLSBhL2NyeXB0by90bHNjcmVkc3g1MDkuYzxicj4NCisrKyBiL2NyeXB0by90bHNjcmVk
c3g1MDkuYzxicj4NCkBAIC00OTYsOCArNDk2LDcgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9z
YW5pdHlfY2hlY2soUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqAgwqAgwqBzaXpl
X3QgaTs8YnI+DQrCoCDCoCDCoGludCByZXQgPSAtMTs8YnI+DQo8YnI+DQotwqAgwqAgaWYgKGNl
cnRGaWxlICZhbXA7JmFtcDs8YnI+DQotwqAgwqAgwqAgwqAgYWNjZXNzKGNlcnRGaWxlLCBSX09L
KSA9PSAwKSB7PGJyPg0KK8KgIMKgIGlmIChjZXJ0RmlsZSkgezxicj4NCsKgIMKgIMKgIMKgIMKg
aWYgKHFjcnlwdG9fdGxzX2NyZWRzX2xvYWRfY2VydF9saXN0KGNyZWRzLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGNlcnRGaWxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7Y2VydHMsPGJyPg0KQEAgLTUwOCwx
NiArNTA3LDE1IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfc2FuaXR5X2NoZWNrKFFDcnlwdG9U
TFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbGVhbnVw
Ozxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgfTxicj4NCi3CoCDCoCBpZiAoYWNj
ZXNzKGNhY2VydEZpbGUsIFJfT0spID09IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgaWYgKHFjcnlw
dG9fdGxzX2NyZWRzX2xvYWRfY2VydF9saXN0KGNyZWRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhY2Vy
dEZpbGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtjYWNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZh
bXA7bmNhY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXNTZXJ2ZXIsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dHJ1ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJwKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgZ290byBjbGVhbnVwOzxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDC
oCBpZiAocWNyeXB0b190bHNfY3JlZHNfbG9hZF9jZXJ0X2xpc3QoY3JlZHMsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y2FjZXJ0RmlsZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2NhY2VydHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtuY2Fj
ZXJ0cyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cnVlLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVy
cnApICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCBnb3RvIGNsZWFudXA7PGJyPg0KwqAgwqAg
wqB9PGJyPg0KPGJyPg0KwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgbmNlcnRzOyBpKyspIHs8
YnI+DQotLSA8YnI+DQoyLjUxLjE8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+
DQo8L2Rpdj4NCg==
--000000000000fa52460642654baa--


