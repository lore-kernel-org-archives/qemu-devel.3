Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C77C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YBi-0005xY-Ol; Thu, 02 May 2024 11:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2YBg-0005wj-B3
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:17:32 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2YBQ-0003PR-1N
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:17:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a58d0aea14cso889634466b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714663034; x=1715267834; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns/Y6jcBMq/6ppFGA8OE+q4lxdsnlIwI1QMHL2O6Ll4=;
 b=jD8tvXZj4qCMMlZC9UcZXl5CbhONpwjxjxGlSI9HIPxjSWmscb56G2qW+8dMoKxopQ
 aXGM+yT39zJ4GH2qhrh6QYitZj3JfH0l0V/7VVC8+D3ckYyJMXEll1tZlVHYvh1/6t/H
 gYa5tWMOr2Hrk9oDGTU0p2Cnc1BWqJbRVm1SF/9zecVe/6tQBZm1JRvGTZN4gm1L5wiS
 uFfsIPxNka7w0sE63m8CK5xtcCTgldaUS26PjgBJ2fgzauFExtZxsSWXj52602nVb8IK
 3pmHdXWshOmiazseesARm+4d2gSHVTPWYteZyvesFYXHK49bp6Ov+ngazL76qDe6tSs1
 iH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663034; x=1715267834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ns/Y6jcBMq/6ppFGA8OE+q4lxdsnlIwI1QMHL2O6Ll4=;
 b=i+Irv/AN5k7mxiqnxG6nWfD7F317MVqbrL7lOyEdVQB/+LRpZdsFCIGac7dLYz9a3Y
 yNKugjAUcv5oWrR3WzE5F475DvClFb+LTEAzz0QRlSifjL+uQy//HPSHHy4ziV0dUcYm
 RnplhTwoTxw5y7Zp1QNSS+D+ffDU0K+v3hvllf9J8F60dX7EtVxe5+G/uUpWgJwDNtuI
 eOUJPALgYPCljWCp94YgKjHQuIR7dyt3rb7xOeftcef4SOrht4Fx4dfa46OmwG6Jrhr7
 9yfPqR7BMuHc3XGL3X/P7UXj9tlcZJ7tb7sU3YxZN6T+DnrdQ1bwJ4lqWGt0kSF8FPuf
 goAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvZDDZ+VB9CL9a99Ade0lwDtzFJbsIOTn3wTHyo7CRCTIqsQNvKqhBbVOz7lHRWre6HF8F3s0iEMDsrlSXqfeQwdRcJ8s=
X-Gm-Message-State: AOJu0YxcC6mwmJprumCPaevOzOKAEqXUx9BlMrOaTU0AeVFLK2i8EuHp
 OgAYy5bh1NCDOHcLA3BJDqyuQvFpSb/9aZ6zy7TLt3arPK/Y8esrRpRzY/owwuwbJ/qooGTfhWn
 xSn55HCJ3Fc6RDX26q66o4Mdghbkf9k9lGO3DNA==
X-Google-Smtp-Source: AGHT+IHAH37QLDRekVelhBwQ0vrT6EBE64rfIwJnwfG2tVstGF/F+o5cZA2w1Y6nqXL2Fa728I1lX6rDv3tlkG0Wg7o=
X-Received: by 2002:a50:d71b:0:b0:572:2f0d:d165 with SMTP id
 t27-20020a50d71b000000b005722f0dd165mr3976028edi.4.1714663033977; Thu, 02 May
 2024 08:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeq+Wu9wiBj+tF0PJHMZS-F4KnVBOXCyXhYQsm+REyLUpg@mail.gmail.com>
 <ZjNIOfJdmLGAJnKh@redhat.com>
In-Reply-To: <ZjNIOfJdmLGAJnKh@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 16:17:02 +0100
Message-ID: <CAFEAcA_k5GUY5meTzpXXSDF3xFMrP-rpY6srbK=JZmay=BHTuA@mail.gmail.com>
Subject: Re: QEMU headers in C++
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 2 May 2024 at 09:02, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Wed, May 01, 2024 at 09:40:16PM -0700, Roman Kiryanov wrote:
> > Hi QEMU,
> >
> > I work in Android Studio Emulator and we would like to develop devices
> > in C++. Unfortunately, QEMU headers cannot be used with C++ as is
> > (e.g. they use C++ keywords as variable names or implicitly cast void*
> > to T*).
>
> NB, in recent past QEMU explicitly eliminated almost[1] all C++ code from
> the tree, because the consensus was to be exlcusively a C project.
>
> > Will QEMU be open to accept patches from us to make QEMU headers C++
> > compatible?
>
> Personally I think that'd be a retrograde step. Any downstream developmen=
t
> fork that made use of that facility would be not be able to feed changes
> / additions back into upstream QEMU codebase at a later date, without QEM=
U
> accepting C++ code once again.
>
> We'll never control what forks can do, and many will never feed back code
> regardless, but IMHO we should be steering external developers in a way
> that keeps open the door for their changes to be merged back upstream.

Yes, I agree. If you try to write device models in C++ then you're
pretty heavily committing to never being able to upstream this stuff,
plus you'll have a chunk of your codebase which is entirely
"nobody else in the world does this this way". I really wouldn't
recommend that.

thanks
-- PMM

