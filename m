Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56066C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURzh-0003xv-K7; Mon, 29 Jan 2024 08:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURzc-0003ub-Ip
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURza-0003oW-EF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706536085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HovcD8/jOZZwL/zn1fTZKW46Jh5GadXXfHFogyqyAg=;
 b=g4avl8dCRIKgw77mEvgfqleZWcLq6C6xndOdrj7y+G1HQx/Me0fTnb5XAxQn5X5T76hX3n
 2mTjpxSw2ykzTf6a26dGeGj1A+gjBKRudbD/53vJLY9dbvJYo6dQjxU0xMYg9kML6Pnkru
 sDKjHs8AFu84FKFrf4J/NbtmZS3T/ZY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-d_SiIUtSMxq3yjC-e_VmZg-1; Mon, 29 Jan 2024 08:48:03 -0500
X-MC-Unique: d_SiIUtSMxq3yjC-e_VmZg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-46b3b76a6c5so139429137.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706536083; x=1707140883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HovcD8/jOZZwL/zn1fTZKW46Jh5GadXXfHFogyqyAg=;
 b=xCZ2e6WZ7KCtzrbvDewgJejEBmG6tLe9DXIicfqx5KXyQ3CbEreiqh3MW4VSg4s6Hq
 5wkQvrcqcWTx4Zw4CJaKMbh4I+hrqcqyo3SvRq5yvIIxKNSQMK6n+ugYTi+HDUJSMAYD
 oZsVucgCTHgt1tFDqcrn0jHH7AEQSkm3Kk39pUK5mK86Gred5yGOUaR413fsdE9D6F/T
 v7iyQQcZa3GOG9+3pE6WGZTOFvPLbc2fTmlILrL4Ema5QmZ9l8HZU4mSbgWFmFe7LA+s
 8daSUS9UVUS20WDMfjyI21cmAaKPhX/z7ibjTfYt6PeECNKkGq2GranKlU/uGsaxyOJd
 33Yg==
X-Gm-Message-State: AOJu0YzEao7bGr7nyYpszyfDtXOnXfGT9WqClNpHNvc3sEoDRCaZvKSr
 w+impP9ZZ7g+gaPloNyOLyzxt2PbwAoZePcH060abM1taUIbW4it1czrllGm0W+w7GpXqyJ2J6s
 24aGvn9usd/NU366z3qIeOOOapPuJgGHgBKKU5W+Ko/ZHrdecekCTs+N2NoGf9XaWktzqTOxLsh
 nGvVWELZWrH6eX4zi1ykiKkUoL7/jaVk1FcAk=
X-Received: by 2002:a67:fbc2:0:b0:468:112b:3cd0 with SMTP id
 o2-20020a67fbc2000000b00468112b3cd0mr2238262vsr.28.1706536082488; 
 Mon, 29 Jan 2024 05:48:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUqVNI8Qzcqt34USrKbn1KxwYlHnlwf3lqSxtJHp8txnLXzFj8XyciHDisVEvPGLJmdMiQooL3iX8G+MtdYQc=
X-Received: by 2002:a67:fbc2:0:b0:468:112b:3cd0 with SMTP id
 o2-20020a67fbc2000000b00468112b3cd0mr2238245vsr.28.1706536081978; Mon, 29 Jan
 2024 05:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20240129133651.1106552-1-pbonzini@redhat.com>
 <eceaa81d-48a3-44da-a74e-b62210c43fd0@redhat.com>
In-Reply-To: <eceaa81d-48a3-44da-a74e-b62210c43fd0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 14:47:50 +0100
Message-ID: <CABgObfZNDTUGU-Q07YOTnt0Djsi40xjKkJbwoVqRcDFbogbzpA@mail.gmail.com>
Subject: Re: [PATCH] configure: do not create legacy symlinks
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 2:46=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 29/01/2024 14.36, Paolo Bonzini wrote:
> > With more than three years since Meson was introduced in the build syst=
em, people
> > have had quite some time to move away from the foo-softmmu/qemu-system-=
* and
> > foo-linux-user/qemu-* symbolic links.  Remove them, and with them anoth=
er
> > instance of the "softmmu" name for system emulators.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   configure | 10 ----------
> >   1 file changed, 10 deletions(-)
> >
> > diff --git a/configure b/configure
> > index ff058d6c486..9cdb5a6818b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1605,21 +1605,11 @@ echo "GENISOIMAGE=3D$genisoimage" >> $config_ho=
st_mak
> >   echo "MESON=3D$meson" >> $config_host_mak
> >   echo "NINJA=3D$ninja" >> $config_host_mak
> >   echo "EXESUF=3D$EXESUF" >> $config_host_mak
> > -
>
> Maybe keep the empty line here?

Even better, the "if" can be moved with the other creation of symlinks from
$source_path to the build tree.

Paolo

> >   # use included Linux headers for KVM architectures
> >   if test "$host_os" =3D "linux" && test -n "$linux_arch"; then
> >     symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/=
asm
> >   fi
> >
> > -for target in $target_list; do
> > -    target_dir=3D"$target"
> > -    target_name=3D$(echo $target | cut -d '-' -f 1)$EXESUF
> > -    case $target in
> > -        *-user) symlink "../qemu-$target_name" "$target_dir/qemu-$targ=
et_name" ;;
> > -        *) symlink "../qemu-system-$target_name" "$target_dir/qemu-sys=
tem-$target_name" ;;
> > -    esac
> > -done
> > -
>
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>


