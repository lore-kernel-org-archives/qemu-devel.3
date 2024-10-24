Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4DCD0BB78
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tjl-00039V-R2; Thu, 24 Oct 2024 05:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tjk-00039L-Qa
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tjg-0005FZ-F0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729760545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwt1vIzeZTKR6VVfRiNHBAmEXrRAoFftvHkOWWJOhO4=;
 b=Qxe0sPwhYywi915svTPAgV4ZfoBNDoAJvJQXs59hV1BvtXMcnwAfwBxK9U7omD5I2JWXcH
 AcapvjNbiXzRi8WucEI/pFSZK4pN3/V10zufyixyQKsxuGccSvipE5bxmhjpXkm9pkpv5p
 NUw2QTHXUL4QffbFBh6VLUwwQUMdUw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-6s0ctPRGPKKRZMwAweptYQ-1; Thu, 24 Oct 2024 05:02:19 -0400
X-MC-Unique: 6s0ctPRGPKKRZMwAweptYQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so1072847f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729760538; x=1730365338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwt1vIzeZTKR6VVfRiNHBAmEXrRAoFftvHkOWWJOhO4=;
 b=HR8BnxcuqtY3PrnBeqHr+BtabKEdlSC2IQFzoqLPmkgYH8ttcrtukH0MZKAJTxxL5B
 zRASc9oWs7J2AF9mU2CcAGFzU5/+mV+xUK65fbSirMYxajRaQ6ecClqgIeiK5tkAxAR/
 Db2BP+YgnNz5LrW840Bz/wp9UCc0R3FUH4y5iZGzXOdCSNImIuZXpYMrA1EdY3MiPmOk
 80vH4Jibb/RBj089Ovzoi/Lgo9llAO93xgPG8uZQyJ1K5VqChZQ2JQTsthk/76kC+VLf
 PDC17Iu3vaZvncU8Vrc1ymK6SXFVK8JPH98FknPKP83DfogaKg55M7Q9d2qXqf8HQILN
 aPAw==
X-Gm-Message-State: AOJu0YzLoJ05iPJXND3kp+OTHoOTRhDLESxIVh4ea7oJiGpQBxxDgll4
 0OHbFS5UEnEgMgSUnXv3q1x5R/UfxOsWH5e7OODZ0P9Dv0QPlnMizcpYYJjtH+hrHbE5j7pLXHh
 uRIYXD3TDMERt0LeGXK9qiv81HhMdlWNSMRfOlZuSZzzIq9ef98/lpAIO7Mwu/XakGmfu18bd0g
 P+nAyS4/5Do6kq/lCNsJ6rbGBGHT4=
X-Received: by 2002:a5d:4248:0:b0:374:c1ea:2d40 with SMTP id
 ffacd0b85a97d-3803abc523bmr858554f8f.1.1729760537586; 
 Thu, 24 Oct 2024 02:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQNgUyOZ2dYNsnNpnjkbml58XdCsrT2FN9FKTBH0WrbjxaadfSAHVKkUb5PXCr8C5u9ZvqFfcPNO13+o5j8nY=
X-Received: by 2002:a5d:4248:0:b0:374:c1ea:2d40 with SMTP id
 ffacd0b85a97d-3803abc523bmr858495f8f.1.1729760537174; Thu, 24 Oct 2024
 02:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-3-pbonzini@redhat.com>
 <SY0P300MB102639B5E87A78ADE3CCA650954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB102639B5E87A78ADE3CCA650954E2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 24 Oct 2024 11:02:05 +0200
Message-ID: <CABgObfaJmB31ibFwf1eaxN4ve_FAF2huNX-oHQsLe39ednSDTw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] rust: fix cfgs of proc-macro2 for 1.63.0
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 24, 2024 at 4:35=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Replay the configuration that would be computed by build.rs when compil=
ing
> > on a 1.63.0 compiler.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
>
> One question below.
>
> > ---
> >  subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/su=
bprojects/packagefiles/proc-macro2-1-rs/meson.build
> > index 818ec59336b..8e601b50ccc 100644
> > --- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> > +++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> > @@ -15,7 +15,9 @@ _proc_macro2_rs =3D static_library(
> >    rust_abi: 'rust',
> >    rust_args: [
> >      '--cfg', 'feature=3D"proc-macro"',
> > -    '--cfg', 'span_locations',
>
> 'span_locations' is not subject to any version check in build.rs. Is it
> removed because of its performance penalty and the fact that we are not
> using it anywhere?

The docs say "When executing in a procedural macro context, the
returned line/column are only meaningful if compiled with a nightly
toolchain. The stable toolchain does not have this information
available. When executing outside of a procedural macro, such as
main.rs or build.rs, the line/column are always meaningful regardless
of toolchain". So for our case it seems useless.

Paolo


