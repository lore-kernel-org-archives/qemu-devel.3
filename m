Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3AC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmzM-0006Mx-2Q; Thu, 28 Mar 2024 06:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rpmzK-0006Mn-LD
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rpmzI-0000Jr-VA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711621679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0x2mVVEtILP+AOEXkJlL41uasi6rXYEHqOzFs+8sqyg=;
 b=IpJeW5cS2mMFU6ProevO+ffTPHIN8y4eIO/gWhCruh1eXdZ4W+g04X2I8ntHdPtDG71MhS
 v1pHHxS3enW/V5kbR3lwSr0pBvOrXqD//8uIlMTt2MmXngW8N5YnMA9pNd2v/ol9mmqHhN
 QowzUi0uSBZPJxkEfM+G6O2aIamjdhk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-7HKTihoaOm-gFi5ggwaraA-1; Thu, 28 Mar 2024 06:27:58 -0400
X-MC-Unique: 7HKTihoaOm-gFi5ggwaraA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5a1d14ca2abso657625eaf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 03:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621677; x=1712226477;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0x2mVVEtILP+AOEXkJlL41uasi6rXYEHqOzFs+8sqyg=;
 b=KzUW7D8kP3JkM0Kd7IviWWTooTqFBbl7RE3Qyt7BHGgHoRDENoMbJYpu8EW6b+gcBt
 oqSmg51leJjDpDKwSt8Or6gXhTk05DkB3WSyzkJeTLpkeP0vgnQRmixBEU54dnpyHCx1
 X8Lg5CaiO1sB2nc17KsodgHsuMVlLg3TwOdR0or4Kh+HW6fCtyggCnzdJkjfH0MyAuw8
 V7KxnVCxj/5DGXqTDO+7PgNab5D9ReQ15HrcYdwH23SL70g0x4ZOd9iM4cAR5YarOxD6
 6+rgcdupcKn/f+hrqHJSd5gvZWbV89Z1wVXjFnbSHz9ea3WNT4Vc1u9h36M69hs+xLkC
 MdnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+apde99joEhFba2wyj3MaxbRcc3BeOoMMldwz0PJXOhYyiS2dmZDD6jft6GmiaB6k0i58IQdatMYajL6yWywowXPjFGE=
X-Gm-Message-State: AOJu0YxjSZaoLfH5klvr+577BFl37wSn69SibAg39znneF7IrZKCkpr2
 2bJXn5M/YKdTCNTW7lJ+dqhwUvE9HcYp/xxOSgz6Xn0y/qbAUGuOtaLVxCMYCTkMXN2mRK4106a
 80h2cO0jlWnQE4Rl/W4dmK2OgOpJNrMgjxSKGJP6CAy0XCcnRkmcD
X-Received: by 2002:a05:6358:63aa:b0:17e:a9b7:2636 with SMTP id
 k42-20020a05635863aa00b0017ea9b72636mr2304345rwh.22.1711621677314; 
 Thu, 28 Mar 2024 03:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnj+dD5C32e73KyVYA2p4fjU2S1DJjOpFUQk92emH97b+JrbNUC0OQM6hXcQ1VZJYAxrNFvQ==
X-Received: by 2002:a05:6358:63aa:b0:17e:a9b7:2636 with SMTP id
 k42-20020a05635863aa00b0017ea9b72636mr2304329rwh.22.1711621676963; 
 Thu, 28 Mar 2024 03:27:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a635054000000b005dc120fa3b2sm975747pgl.18.2024.03.28.03.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:27:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 11:27:50 +0100
Message-Id: <D05B8SENZ5MO.52MU1G4SOBY0@fedora>
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v4 2/3] tools: build qemu-vmsr-helper
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240318151216.32833-1-aharivel@redhat.com>
 <20240318151216.32833-3-aharivel@redhat.com> <ZfwbIywC504XWxkl@redhat.com>
In-Reply-To: <ZfwbIywC504XWxkl@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Daniel,=20

My apologies for all the missed feedback in v2.=20
I'll be more organized for my next iteration.=20

For this specific comment below, I would like to make sure I'm testing=20
the right way.=20

> > diff --git a/meson.build b/meson.build
> > index b375248a7614..376da49b60ab 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4052,6 +4052,11 @@ if have_tools
> >                 dependencies: [authz, crypto, io, qom, qemuutil,
> >                                libcap_ng, mpathpersist],
> >                 install: true)
> > +
> > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.=
c'),
> > +               dependencies: [authz, crypto, io, qom, qemuutil,
> > +                              libcap_ng, mpathpersist],
> > +               install: true)
> >    endif
>
> Missed feedback from v2 saying this must /only/ be built
> on x86 architectures. It fails to build on others due
> to the ASM usage eg
>
> https://gitlab.com/berrange/qemu/-/jobs/6445384073
>

To recreate your build system, I need to, for example, compile with the=20
following configuration for arm64 (aarch64):

../configure --enable-werror --disable-docs --enable-fdt=3Dsystem=20
--disable-user --cross-prefix=3Daarch64-linux-gnu-=20
--target-list-exclude=3D"arm-softmmu cris-softmmu i386-softmmu=20
microblaze-softmmu mips-softmmu mipsel-softmmu mips64-softmmu=20
ppc-softmmu riscv32-softmmu sh4-softmmu sparc-softmmu xtensa-softmmu"

This is cross-compiling on x86 right?
Because on my laptop I've got the following error:=20

WARNING: unrecognized host CPU, proceeding with 'uname -m' output 'x86_64'
python determined to be '/usr/bin/python3'
python version: Python 3.12.2
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=3D0.63.0

ERROR: Unrecognized host OS (uname -s reports 'Linux')

It looks like it wants to build natively on aarch64.
Maybe I need to create a VM with aarch64 Debian and compile natively?
Might take a long time but I'm not sure this is the best way.

Regards,
Anthony


