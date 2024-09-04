Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B188BCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnvk-0003aY-Dz; Wed, 04 Sep 2024 07:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slnvi-0003Tz-MM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slnvf-0005G1-Om
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725448322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS16SBFRIbwGnw27rCxlUwxfBNme/FfKdQkuuQEsyPU=;
 b=OEkmwtfvIpCxN3r9qfq6mhwem/pDOhyRsFUrNX8MU3N2/Q+Tds4PkbiioHgvU38p8I8kYZ
 HN9qObhmxRUwp2I5o0/pwFU41obft8hWATGIykAv46sFhyjC5E8ENmn0dROKeUXngOlfa3
 XYMN2KOBxZJsK3UNCvFu2yNsxn9Oi34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-LtCizFuOMEWZQ5fLzmXoDA-1; Wed, 04 Sep 2024 07:05:03 -0400
X-MC-Unique: LtCizFuOMEWZQ5fLzmXoDA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3771b6da3ceso665977f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725447902; x=1726052702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YS16SBFRIbwGnw27rCxlUwxfBNme/FfKdQkuuQEsyPU=;
 b=WBelau5peWOMmUuNLl3DWTlmiLyGbWNDjm2oPHLQ59CoMUH/nOu3ZU2rBSNI86+8ik
 r7eyGlp2dqj/5CyJwIFyIqflE/tWhJ0p0l2HmpC0h0oX+LGncF3timGJrG4ePyAsrZXP
 Xp7QZVot7dARgOSyM9zvzhaKeyzDcyoNgdqtZvm+bfm3jli1Aon1MXnIR/DetO4Gsepg
 l0jZGI1tChmrBXxI2OwetUYmZ3JtiWqwehGxnTIR3RhYryOS8GUl2ijBMEdprBiCDSM4
 djJaJ5caDl79bl42p0k56CSiRmQNnudIhe6yWM4hhqeWaetQaeWM6178VRpm4k5Kybs+
 zAEw==
X-Gm-Message-State: AOJu0YxofwIFogh4POmG4CAMtUEe8rE30aa4VnF1HR//kEBybBW02aik
 eJUe8MPxGxPhgmvLJh68v8rDwH80ScCT457DtLl10PFjCUqbp9USwUP4qXsd3m7jYh+2y9RWWSs
 FQEuoSvZGe2k7ld3BedhZlVCyRjsEmnpZY5LH029w++JrYG0AGACxihVNdj316wtL1TWlJFZGbP
 sKOoIP0y2n1XW/aKYVz0CKP2M9GLU=
X-Received: by 2002:adf:fd92:0:b0:374:c694:903a with SMTP id
 ffacd0b85a97d-374c6949220mr6191596f8f.41.1725447902634; 
 Wed, 04 Sep 2024 04:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuqpwFbItfrPiNyqdaSDOOXWgD1+H3yw3X4lgmBODQEj6GW0/hrwXmAFZPQMoqc0Fc3n+se7uveAakvVbD+n8=
X-Received: by 2002:adf:fd92:0:b0:374:c694:903a with SMTP id
 ffacd0b85a97d-374c6949220mr6191574f8f.41.1725447902082; Wed, 04 Sep 2024
 04:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-9-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-9-35579191f17c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 13:04:50 +0200
Message-ID: <CABgObfY2-8J+x+Tn9cNNu47jM-pHxywaVEP8nxBfCDhYpo4spw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 9/9] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>  subprojects/packagefiles/either-1-rs/meson.build   |  24 +
>  .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
>  .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
>  .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
>  .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
>  subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
>  subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
>  .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
>  subprojects/proc-macro-error-1-rs.wrap             |   7 +
>  subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
>  subprojects/proc-macro2-1-rs.wrap                  |   7 +
>  subprojects/quote-1-rs.wrap                        |   7 +
>  subprojects/syn-2-rs.wrap                          |   7 +
>  subprojects/unicode-ident-1-rs.wrap                |   7 +
>  45 files changed, 2043 insertions(+), 13 deletions(-)

Some of these subprojects should be moved to patch 8, for the macro to comp=
ile.

Paolo


