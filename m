Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9076BCA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofP1-0000kc-Tp; Wed, 20 Aug 2025 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uofOt-0000iI-FF
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uofOr-0004F4-TN
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755683193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0n6QiEUk0O+pbnScdXsdwLWxqOpG7igYLMgRtd0bdIk=;
 b=e3gva+xEFhBiqj9vM7CWBLOz5BYC64gl+89Asm+UMqLsnYLIwgnyuZJwt5mZTueCBNidXx
 5lv19+uG21wFPjLgjaYYL39uPCAga6e8Eux+JRUNPe0bpXBZb3WHUwyfr3yJLGCiR4iUuG
 H5jWKyIM+TAbT8NDJ+7JwTaiD8rB020=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-FWenLIcjN5uL89Cwd9YU3A-1; Wed, 20 Aug 2025 05:46:29 -0400
X-MC-Unique: FWenLIcjN5uL89Cwd9YU3A-1
X-Mimecast-MFC-AGG-ID: FWenLIcjN5uL89Cwd9YU3A_1755683188
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59cso39383335e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 02:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755683188; x=1756287988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0n6QiEUk0O+pbnScdXsdwLWxqOpG7igYLMgRtd0bdIk=;
 b=RFHrmH1T/kk6vocicb0WPx1eD1FDJcsBNWGvWrGlALgBkmVCaGswfE+08szuf9Yau5
 83XG4YS7XJYj71JPFmJFt+eh0TSZa9dHFg9fFUGVOJVZ5Zt3eLPK6bNjquS4He3z97F0
 BIY2lphIjuiyKJsyqIsi7FaL+X5HksE+kvD8vTcBxuUOiAJkTzEzZijKijLZGBNX90Jz
 oZWTr2VmY1Tlafe+F6jOlzeF4Cj2g2RXIj8DUQALBr4He/+axY2tDWbODSTDv53kAVyL
 btJnEW1xqSdDNluRFZUbQ3EuiU7gp0bRhXd9ORzgL294PZlKKoXZgly7+8JTHCY0K/OS
 3fEA==
X-Gm-Message-State: AOJu0YzNMR1vQsJZ0CrbxgHLKTbKlNCQjERuXRA8KqVvsjsom+ODYENE
 gYjslycxUJ01D2nnAXbANJPhgaQPc78h3BgTWc+xebIO4PwnQ3/OtaBE4jQ5e7Xiu2bqL6EbTZo
 MUGt4ojxFOJArmL/VTcu2oUNh/wHQ2DAXaX7fTWm+LiarbCMNzRv2E8m/zoXLUnnr5m0MDobLjv
 VHKFD5fSVtwa85XocYJ9Hvl3242xMPsNY=
X-Gm-Gg: ASbGnctGyBRbfrVdr8d6HdULWt7G+/GloQyfOmKz4xrE+ZiOkJ9HQHHIwv69HfDdeIG
 6+nWXe8NfKVEa0teqTuLgc2e/QA4lYC+KHzsT+Kg5W0ulVF/Fo+hXW/0B1af6qctU9Oi6ES92ip
 L7E+K6Vb6YVesseBvGYXY=
X-Received: by 2002:a5d:5f42:0:b0:3b7:dd87:d741 with SMTP id
 ffacd0b85a97d-3c32e709c46mr1626722f8f.42.1755683187676; 
 Wed, 20 Aug 2025 02:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD/gI2fN8MmMGzAOtT3of1uapUDSTo3DXBAlSNaAUxBb32pEG2Dv+p3002GQKfHJsS/jrKNW0XNBrYMxxTR8M=
X-Received: by 2002:a5d:5f42:0:b0:3b7:dd87:d741 with SMTP id
 ffacd0b85a97d-3c32e709c46mr1626705f8f.42.1755683187298; Wed, 20 Aug 2025
 02:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154237.793315-1-pbonzini@redhat.com>
 <CAFEAcA-JDHPZaayuQQE-rcASP78E5UPL4UP-mHbrJAB+Um3L3g@mail.gmail.com>
In-Reply-To: <CAFEAcA-JDHPZaayuQQE-rcASP78E5UPL4UP-mHbrJAB+Um3L3g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Aug 2025 11:46:14 +0200
X-Gm-Features: Ac12FXwOi6e81w1aSheLpKBlvK-fi35JfuHsanyDITlcxQnFotMFE6Rv5cH49Fg
Message-ID: <CABgObfa8TPcZNVkq2S1aRWLVjAt1-VeLT14CK=xc2jkqxfAktg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add a few more files to "Top Level Makefile
 and configure"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 6:08=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 19 Aug 2025 at 16:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > A few files in scripts, and the list of packages in pythondeps.toml, ar=
e
> > strictly related to the toplevel build scripts.  Add them to the
> > MAINTAINERS file stanza.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a07086ed762..3979cffb042 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4403,6 +4403,9 @@ R: Thomas Huth <thuth@redhat.com>
> >  S: Maintained
> >  F: Makefile
> >  F: configure
> > +F: pythondeps.toml
> > +F: scripts/git-submodule.sh
> > +F: scripts/meson-buildoptions.py
>
> This is already covered by the line in the "Meson" section:
> F: scripts/meson-buildoptions.*

Yes, that's intentional. I can change that one from py to sh, but the
Python script that generates the option parser has more to do with
configure/Makefile than Meson.

Paolo


Paolo


