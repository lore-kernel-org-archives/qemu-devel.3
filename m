Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E369CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGxwy-0001lb-SC; Wed, 14 Oct 2026 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGxwo-0001kE-JR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:19:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGxwl-0005Pc-4J
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:19:06 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso6556461a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 05:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791980340; cv=none;
 d=google.com; s=arc-20260327;
 b=BE3jHjPuio3K8UyfWCWkFuhUPuEeycYKKcQVmjHMGY3Gmzl3V0d1rWprvuOYfDRUFz
 zD0ghBpyDYslPl/TeV1MAb/6N0SfuL0uJbGDzy3ZiJCwonkPHz3kOePWOSrouECPH8CA
 sD7Ire2d5SpPCpIeAZtLU6Nbd9/gK8G8gVsYmww4t5t7AsiJ5b6y8XgaxAU07xvmV/T6
 uDMODkFpFvB/oPVPgtWUYb9YfFfdLXqmCjm5bFRwzFGCZPW3EUILy2Zvr/Afdnie3ri2
 zxbssu9pCnr3PHQpAC/f9HNyl7F23OnfYjAEtgYNxmHdPJgY/JQojHGUkAWplCdXK22n
 rLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ssRl3kbqja2TBFr7DxtKqnpuftUarLL3G3B+v9cQ3R4=;
 fh=KHw9iF04fvy5z7z7dwUgjCo82utv7gMqh2Et/7WCUxE=;
 b=cSQXZGJx9tT6Z0CeTxnhMG9ptcHvxT8v11Y9A73jxeUYvYV342cO1uiSK/kicMc8n5
 kkOwwb99V/YVjTOe2feg2B+AMi7skf6TWAmsV5E3yVKLDI98+PZh5PeTwR+V+wYl/uTA
 9vDFtMwCFCQ07q3nxyWyhtG2KzboVb+4TqMjmh7mWcGzynphMHlpye8Odbi6AeBIXbcO
 hnB/nh86/D3sjjAVyS5d4tMKlj89g8fizLyL8XE306LlTYgDq4MxseN580X/ucrjjpGy
 /Zb2rLmJFZpSzSUY6LbS65i3PGZmXOhSD1UYFge1Y/BVw4BKPbjQYD2neCrBlk2x7KGz
 U2LA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791980340; x=1792585140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ssRl3kbqja2TBFr7DxtKqnpuftUarLL3G3B+v9cQ3R4=;
 b=sLEkmvREnoI8bbLrgd7HDgQL6iqhILvbpTA/RUE8+eCN2eCNDksiuvczOBn4Wy82fX
 zPgRNPU74BTmcOHPYQXqszW6a8HWsjpUOoMeTi5bw6ax9VyOANeRCAR6pfm3M0Be7g2D
 w0t3Msp/YTy1xo0n5CSqkB2ln4ztAG3YesazvS0PawWz5Mf7CPvrhg36ah2oh7Mq5Unz
 CFIFU9kQxWBwPOr29PadzVIoa6Mw4CRAEnZz6JdoKdqgEW1q10Jw4667mcb2pEp68QQj
 yLkdZCpW+xxNvg5/Ck+/3YwxopdvQ1NETaCtzCZQn4VMLoGM+/OYGRprrCq9tdnn/JUz
 e8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980340; x=1792585140;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssRl3kbqja2TBFr7DxtKqnpuftUarLL3G3B+v9cQ3R4=;
 b=Repnp070eCtHCIO4fyp/PHzXzNYpR5ylsFUW1nGJT3WfIgWWvlDBMJ8ZbfXX0pEOxK
 Ye7HoPy+c+EX0qPS6mJ6GhB0a27UV3YNdxUqPLKIvTbruTcZQ1DdeSMyoxzKD+fbRFl3
 Iz01e53eoUES66TPS7OZho63qoB2R7mofdnvTlVFu8lFERRwLepzFjzu+daIjqfpdvAK
 KwTL5nYr0sY95lTJJrZDLjkz6BsxDyu7QnfhXU9GfdNQ8JaOXx4Dqzzscf3PQHK+dk7I
 r04mbUZ+wNKngCLlefymWR0Mh3F3SBwoA7SxR6vwkU6DK5+rkXvijnvjk077p0w7o0rM
 vesw==
X-Gm-Message-State: AFq9FYKDJ2PI5+bRozdXIsUxlS/kA+DcO6LCng3lGAxKWi/w5i2LTSzS
 Wv8yHgGV+4Y4ioF8NHhQsedkHs9IBm1AUQ2RxbO8LjU3RZqyzDoF9QRPvGAAsL/vCQke7TA7uYJ
 HK/bv8xmGYg6SFCGa7A8qVhz62QxuavM=
X-Gm-Gg: AYBFou3wM+sfCZcUGaaHVlF4YLfokPJ7CQTOLnL6/3QXvNe3BXb2hbiXCidRryfDv+o
 iuGlYcROX0wrlBDY7XmM8+7jMjHF30ztYI2YFLSpMtwajHaDmZs0K96FTTYDqzwhFI7P1RuVuHj
 w9ToGRjHdZMBut5RNKdfDSHup1omJ22rITYHuSW7sjhk2UccFvoAkvfYNjPfY7JvLm1/EOR+0m3
 Hwtf0a355Me2uqmiS9+m9s9NPQxNFNQP8nURX/Oh7Wh74sEryEjq5GY0dKGiN0RzuAtUvJ8KrdD
 64ai1Y+hmFRplermWVNEGjy4qF5Zt9ueYPWgxWKRzXBkW1RH24aAVqg=
X-Received: by 2002:a05:6402:401c:b0:6b1:bb19:de98 with SMTP id
 4fb4d7f45d1cf-6b1bb19e440mr8365980a12.1.1791980339890; Wed, 14 Oct 2026
 05:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-5-luoyonggang@gmail.com>
 <87ecdscyoz.fsf@pond.sub.org>
In-Reply-To: <87ecdscyoz.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 20:18:47 +0800
X-Gm-Features: AclHuK_hLX6fS2anu37HyXXnIlCZfmtNKhy61ehqdJR6WqkDWHSlRaw__mjX-k4
Message-ID: <CAE2XoE_OReOLTzfeEPAUS7doy94M-V=fVzRTrwD190obxn4ZYg@mail.gmail.com>
Subject: Re: [PATCH 04/34] qapi: rename SysEmuTarget to EmuTarget
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 qemu-arm@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 7:24=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > As now it's also expressing user-mode targets.
> >
> > This changes the type name exposed by query-qmp-schema; enum values and
> > serialized target values remain unchanged.
>
> Are you sure?  query-qmp-schema masks the type names.
Thanks, I'll remove this.




>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> [...]
>
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 9b145c635ba..07fac4f0764 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -14,7 +14,7 @@
> >  { 'include': 'machine-common.json' }
> >
> >  ##
> > -# @SysEmuTarget:
> > +# @EmuTarget:
> >  #     The comprehensive enumeration of QEMU system emulation
> >  #     ("softmmu") targets.  Run "./configure --help" in the project
> >  #     root directory, and look for the \*-softmmu targets near the
>    #     "--target-list" option.  The individual target constants are not
>    #     documented here, for the time being.
>
> Is this still correct?
This is a grep rename. I'll update it later, thanks.
>
> > @@ -35,7 +35,7 @@
> >  #
> >  # Since: 3.0
> >  ##
> > -{ 'enum' : 'SysEmuTarget',
> > +{ 'enum' : 'EmuTarget',
> >    'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i38=
6',
> >               'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
> >               'mips64el', 'mipsel', 'or1k', 'ppc',
> > @@ -95,7 +95,7 @@
> >                        'qom-path'     : 'str',
> >                        'thread-id'    : 'int',
> >                        '*props'       : 'CpuInstanceProperties',
> > -                      'target'       : 'SysEmuTarget' },
> > +                      'target'       : 'EmuTarget' },
> >    'discriminator' : 'target',
> >    'data'          : { 's390x'        : 'CpuInfoS390' } }
> >
> > @@ -281,7 +281,7 @@
> >  # Since: 1.2
> >  ##
> >  { 'struct': 'QemuTargetInfo',
> > -  'data': { 'arch': 'SysEmuTarget' } }
> > +  'data': { 'arch': 'EmuTarget' } }
> >
> >  ##
> >  # @query-target:
> > diff --git a/qapi/pragma.json b/qapi/pragma.json
> > index 342cedc42e7..93a710ee937 100644
> > --- a/qapi/pragma.json
> > +++ b/qapi/pragma.json
> > @@ -72,7 +72,7 @@
> >          'SsidSizeMode',
> >          'String',
> >          'StringWrapper',
> > -        'SysEmuTarget',
> > +        'EmuTarget',
> >          'ThrottleGroupProperties',
> >          'VncPrimaryAuth',
> >          'VncVencryptSubAuth',
> > @@ -109,7 +109,7 @@
> >          'QKeyCode',                 # send-key, input-sent-event
> >          'QapiErrorClass',           # QMP error replies
> >          'SshHostKeyCheckMode',      # blockdev-add, -blockdev
> > -        'SysEmuTarget',             # query-cpu-fast, query-target
> > +        'EmuTarget',                # query-cpu-fast, query-target
> >          'UuidInfo',                 # query-uuid
> >          'VncClientInfo',            # query-vnc, query-vnc-servers, ..=
.
> >          'X86CPURegister32'          # qom-get of x86 CPU properties
>
> [...]
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

