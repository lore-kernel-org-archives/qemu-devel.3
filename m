Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E65C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUHO-0004rf-1m; Tue, 04 Jun 2024 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEUHM-0004qe-4X
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:32:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEUHK-0005Wp-49
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:32:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so1128865a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717507960; x=1718112760; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aLV13V/SE1BVPvsvVFmV+VFL5dOMY1DvKcOT3vr4kw=;
 b=fJNIBcXAc7lSHeY+NNxGJkt/6Z7PDCVIEvvg1zKhDiifhcr4uclfYUbIGXbE1A5BvE
 wWce/Df8Pk/QcXITImyFMPQWGL7z5aDdZUR+0zv7FieEti3LDpodMfDbZyRQ+hi3s7JS
 PF+WWCI+gF20ebxCUlWwG2WZsMcGLgBW5efZz8VWLk5JARlYxqBGD3keU7GO/DTfVwTJ
 s/pJh6ZHQoso1B1nWFJeaIPjO5cFBMJN65eQBAEZAVNSvvA073FBE9woqol51IeFkTn9
 ngRRBpWZeMghO0tliEeCj3lDUZfXtu905mUCi0IRAPMJN47jRW87DraChc2InzvE+idq
 4Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507960; x=1718112760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aLV13V/SE1BVPvsvVFmV+VFL5dOMY1DvKcOT3vr4kw=;
 b=bTaX2/RhDI/6IGE9L/fcWX8gUGnT0SxOWi7QawP1grFhElFKoWV9bZr2pA/jA//Hn2
 peUlvSuzmj64L37RehBQ0MiU8WZwDtF/YaDCHM2IQ+iU7RivJ8aLohsQcKrNKNKHhFQ6
 oZsaor1gmm+LAU23oXlmgDg8SpJOwCUGcA4PsfUEL9najfOri/uH+bdKySr8Kxfk9IhB
 ly04ri5IdGx8q44+141zfpbZCz85gCwW1BeivaSu0GKQaC2ooWX+b5F2C6v7pn4zmS7t
 t/NNR/9u++R/hTBmtQdzRhIzdWAxopTKW8W/F1DsYPcHq+Sz1M4G7uezya2DhoTE9R2p
 G1Nw==
X-Gm-Message-State: AOJu0Yzzv/TqP7G930uHcUUQRMKp4RhzY38bTyIa+L71cjy8bnkiyq1J
 SJfpp9MaFnjT8Y7rRpFDVUHNggaz1iDkcNdDiqXUwtp8TiQIMfgRwW8TPrpe8axJoVfTOQWocry
 3ruOsJFFnfc9j7CJSSwv6YrVSgeEXfyiVJAShjw==
X-Google-Smtp-Source: AGHT+IFFqpFbWpp/R7i0Dcba80kUmt+uKiom4Jz1Lb01SEUIkp3yoY8fYN5woLoG74Lj8Y6B1C15kgw8mys7+YUl3j8=
X-Received: by 2002:a50:d541:0:b0:579:edac:df13 with SMTP id
 4fb4d7f45d1cf-57a36357dfemr8313921a12.8.1717507959942; Tue, 04 Jun 2024
 06:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240531142145.482361-1-peter.maydell@linaro.org>
 <77a5f792-6caa-4dd9-9de7-e13224573f30@linaro.org>
In-Reply-To: <77a5f792-6caa-4dd9-9de7-e13224573f30@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jun 2024 14:32:28 +0100
Message-ID: <CAFEAcA8Wv5YCpdee5GZzsAj824WRUxPb6mmLLSQvXV6S68aLkQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/coverity-scan/COMPONENTS.md: Update paths to
 match gitlab CI
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 31 May 2024 at 16:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 31/5/24 16:21, Peter Maydell wrote:

> > If there are any other changes we want to make to our component
> > regexes, now would be a great time to suggest them, because this
> > change is going to involve "delete every existing component and
> > recreate"...
> > ---
> >   scripts/coverity-scan/COMPONENTS.md | 104 ++++++++++++++-------------=
-
> >   1 file changed, 52 insertions(+), 52 deletions(-)
>
>
> > diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-sca=
n/COMPONENTS.md
> > index 1537e49cd5a..98d4bcd6a50 100644
> > --- a/scripts/coverity-scan/COMPONENTS.md
> > +++ b/scripts/coverity-scan/COMPONENTS.md
> > @@ -1,157 +1,157 @@
> >   This is the list of currently configured Coverity components:
>
>
> >   block
> > -  ~ (/qemu)?(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)=
?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
> > +  ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?=
/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
>
> util/block-helpers.[ch]
>
> I'd put hw/block/ to another bucket that the block subsystem.

MAINTAINERS considers both block/ and hw/block/ to be part of the
"block layer core".

> >   char
> > -  ~ (/qemu)?(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char=
/.*)
> > +  ~ .*/qemu(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/=
.*)
>
> Is 'char' the same as 'chardev'?

Good question. It looks like we don't cover chardev at all currently.
I guess we should probably prefer to track chardev separately.
qemu-char.c and include/sysemu/char.h don't exist any more.


> >   crypto
> > -  ~ (/qemu)?((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|=
/backends)/cryptodev.*)
> > +  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/=
backends)/cryptodev.*)
>
> Maybe worth covering host/include/*/host/crypto/?

Seems reasonable.

> >   disas
> > -  ~ (/qemu)?((/include)?/disas.*)
> > +  ~ .*/qemu((/include)?/disas.*)
>
> Missing:
>
> target/avr/disas.c
> target/loongarch/disas.c
> target/openrisc/disas.c
> target/rx/disas.c

Why do these targets not put their disassembler in disas/
like all the others? We can't really catch them with a
wildcard, because the target entry earlier will match first.
I'm kind of inclined to leave these as-is, because if
somebody put the disassembler in target/ then having it
appear in the component for that target is fine for it being
basically classified to get the attention of the right person.

> >   migration
> > -  ~ (/qemu)?((/include)?/migration/.*)
> > +  ~ .*/qemu((/include)?/migration/.*)
>
> Not sure about:
>
> hw/vfio/migration.c

I think that's correctly classified under vfio.

> >   monitor
> > -  ~ (/qemu)?(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
> > +  ~ .*/qemu(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
>
> Apparently the pattern is now foo-[hq]mp-cmds.[ch].
>
> Not matched:
> hmp-commands-info.hx
> hmp-commands.hx

These aren't C, and because hxtool doesn't try to preserve
file-and-line-number info for them I don't think Coverity
will ever report an issue in them.

> hw/virtio/virtio-qmp.[ch]
  correctly matched under "virtio"

> include/qapi/qmp-event.h
> job-qmp.c
> monitor/qemu-config-qmp.c

Yeah, these should all be monitor.

> python/qemu/qmp/events.py
> scripts/python_qmp_updater.py

No point in caring much about the classification for non-C
files, since Coverity is only scanning C code.

> tests/unit/test-qmp-event.c
>
> Not sure about (not covered in testlibs):
>
> tests/qtest/libqmp.c
> tests/qtest/libqmp.h

Yes, we should expand testlibs to cover these.

> >   trace
> > -  ~ (/qemu)?(/.*trace.*\.[ch])
> > +  ~ .*/qemu(/.*trace.*\.[ch])
>
> >   user
> > -  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/incl=
ude/user/.*)
> > +  ~ .*/qemu(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/inclu=
de/user/.*)
>
> >   xen
> > -  ~ (/qemu)?(.*/xen.*)
> > +  ~ .*/qemu(.*/xen.*)
>
> We could match .*xen.* like trace (ditto other accelerators).

That would produce mis-hits on audio/mixeng.c. The
wide match on trace actually also has mis-hits because
it matches on os-strace.h in the bsd-user subdirectories.
So I think it would be better to make the trace component
look only for trace.*\.[ch] rather than to change this.

> >   hvf
> > -  ~ (/qemu)?(.*/hvf.*)
> > +  ~ .*/qemu(.*/hvf.*)
> >
> >   kvm
> > -  ~ (/qemu)?(.*/kvm.*)
> > +  ~ .*/qemu(.*/kvm.*)
> >
> >   tcg
> > -  ~ (/qemu)?(/accel/tcg|/replay|/tcg)/.*
> > +  ~ .*/qemu(/accel/tcg|/replay|/tcg)/.*
> >
> >   sysemu
> > -  ~ (/qemu)?(/system/.*|/accel/.*)
> > +  ~ .*/qemu(/system/.*|/accel/.*)

thanks
-- PMM

