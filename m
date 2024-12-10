Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61BBE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxX0-000249-Lw; Tue, 10 Dec 2024 05:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxWy-00023y-Ae
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:31:52 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxWw-0006Mz-MC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:31:52 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so6868749a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733826708; x=1734431508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6kofMo9BesDGeluhsgFdeNXBeCyGDZ0HyKXR+mIZqk=;
 b=fY3E5Wk8PHE21a/tqjlvCXMkV73obcVyXkr11y3XQwHACf+sFPxA/O09kX/cZNy683
 lpgKmvzTFjS0oKR0hM6cLu5Bk2EeKu/VMdQSpzwE4eacjezLavrJaf5MagsJlEUUvfAN
 usGdJBts4t2VSQA+u7BRcEUbYMt0lnbVtWgVBQPDN0PITBNVM5O9Vq1qeYgU+nnR4m6U
 P3fMtQzLsMHJB4ac0HH878/HSc1csMD4Vg2Nbgnwm0cdl/rt1C6T/ohkNKPbBD9if4tQ
 T05rbis4X+D18IXe9Mq8WSkWzz6ThjZ1/tsi7CgVneNrL9H0H9fdC9DzwZvCB1g+o54C
 xtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733826708; x=1734431508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6kofMo9BesDGeluhsgFdeNXBeCyGDZ0HyKXR+mIZqk=;
 b=hSq84nisUintyFF5Qe12mzQAj8qT1mtybzW6n5D40Tge7HpE5yK0GCoOrIw6Ibu3QJ
 MNPM1vaUx/LYfMRlZx3ZAuRKb8CDMUVL8Nxm/qhNOwIXMxDNDLfAgpmMnBxAi+wyBxXl
 qajrnYoAAKLh0wMpPweyr5DJ5B7jyYvnMzz1aklH8LB6LIlSGb/fVeH85hesNv5Uf1cC
 WA71nUbVnEpNUH9mGNNu8nddfZA2Um2U9XGAVs4a2NxXmjek8M4ynFG0qT2C+kLJPLEm
 jCGyvxGL9fmUw1RTetcX3VAQjilWlcL0sq9g2aEesNj5XjY3lh2127XViY1aNWAC/rOw
 oWZA==
X-Gm-Message-State: AOJu0YzpqJnC3YXJ4y3mazDL54Z8Rm62rqLtS2SGL7pTY6rUn6eY/QBu
 YPegJiypbbsVBnznDhK9cmIfr2aT49L76mSNnyrr5S4rKcut/8yxpEpbgF+s26Sv3G8lhs/D+a1
 3qv0Dqh1N6KH44gtaXJ7C8fsMwDVLYzX//7/XuA==
X-Gm-Gg: ASbGncts0YA5HI1Bd+wR9IEOjKu7IrkfXi4erLz5GRLZdxKzZoosV24lyXTzf3vSyUI
 nAhA40vzn5H6qfxO0SfDjfjFSnkS77jJciPJ0
X-Google-Smtp-Source: AGHT+IF5NwVqF1NPqJK4BGguhqPsBzJa6tFlumQiE7LD79dmT28h8CnqEfxMD8S6+lXdyGIxR2JHJAOi2utGdadnfY8=
X-Received: by 2002:a05:6402:2744:b0:5d1:22d2:8965 with SMTP id
 4fb4d7f45d1cf-5d41863b7e8mr4868514a12.30.1733826708254; Tue, 10 Dec 2024
 02:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20241127191914.34146-1-philmd@linaro.org>
 <CAFEAcA-H2kS0GdXpDpA3mFm1eOZnudZCn8REYNo34+PsvimfmQ@mail.gmail.com>
 <0406480e-29aa-4207-970c-818db3de0291@linaro.org>
In-Reply-To: <0406480e-29aa-4207-970c-818db3de0291@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 10:31:37 +0000
Message-ID: <CAFEAcA8WPNbk0GHfJykfb04_wrpWvar=_qEiGBNXw03jfq1VPA@mail.gmail.com>
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 10 Dec 2024 at 10:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/12/24 11:03, Peter Maydell wrote:
> > On Wed, 27 Nov 2024 at 19:20, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> There is no vCPU within the QTest accelerator (well, they
> >> are stubs doing nothing, see dummy_cpu_thread_fn).
> >> Directly use the cpu_physical_memory_rw() API -- which
> >> amusingly prefixed 'cpu_' does not use vCPU -- to access
> >> memory. This reduces accesses to the global 'first_cpu'.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   system/qtest.c | 42 ++++++++++++++----------------------------
> >>   1 file changed, 14 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/system/qtest.c b/system/qtest.c
> >> index 12703a20455..a2de9a7d5a4 100644
> >> --- a/system/qtest.c
> >> +++ b/system/qtest.c
> >> @@ -18,6 +18,7 @@
> >>   #include "chardev/char-fe.h"
> >>   #include "exec/ioport.h"
> >>   #include "exec/memory.h"
> >> +#include "exec/cpu-common.h"
> >>   #include "exec/tswap.h"
> >>   #include "hw/qdev-core.h"
> >>   #include "hw/irq.h"
> >> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend *c=
hr, gchar **words)
> >>
> >>           if (words[0][5] =3D=3D 'b') {
> >>               uint8_t data =3D value;
> >> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPE=
CIFIED,
> >> -                                &data, 1);
> >> +            cpu_physical_memory_write(addr, &data, 1);
> >
> > I'm not a huge fan of this, because cpu_physical_memory_write()
> > is one of those old APIs that it would be nice to see less
> > use of, not more. Ideally anything issuing memory transactions
> > should know what it's issuing them to, i.e. should be using
> > address_space_* functions and passing an AddressSpace.
>
> I totally agree with you. I'm chasing one problem at a time
> starting by first_cpu, and you are already seeing ahead :)
>
> Do you mind posting a documentation patch clarifying the
> cpu_physical_memory_*() methods we want to deprecate?

docs/devel/loads-stores.rst already says
"For new code they are better avoided" about all of
\<cpu_physical_memory_\(read\|write\|rw\)\>  :-)

> > If you don't want to use first_cpu, then you could use
> > address_space_write(address_space_memory, ...), which is
> > what cpu_physical_memory_write() is doing under the hood.
> > The qtest protocol assumes a single address space anyway.
>
> Correct, good idea.
>
> Next problem I have here is to understand what 'endianness'
> means for QTest framework. Use case: heterogeneous ZynqMP
> with ARM and MicroBlaze cores.

qtest itself doesn't care about endianness -- if the test
asks it to write a 32-bit value it writes a 32-bit value.
It does have an (undocumented!) "endianness" command to
which it will return either "big" or "little". On the test
side this is what determines the return value for
qtest_big_endian(). We currently use this only in the
virtio tests, where what we're trying to determine is
"are the values in the in-guest-memory virtio data
structures little endian or big endian?", so that we can
use the same test to test a virtio device in a big-endian
machine or a little-endian machine.

thanks
-- PMM

