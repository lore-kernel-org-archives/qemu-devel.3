Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1273DC369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 08:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3W7s-00050L-6K; Sat, 12 Apr 2025 04:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3W7q-0004zt-9c; Sat, 12 Apr 2025 04:22:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3W7o-0002ZX-Ai; Sat, 12 Apr 2025 04:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=EyyvU26WyWKZPrjnU2aSEB0k5vWB94xWPRhX4O3z5BM=; b=X0PHKkwiOKMRj4NvkXHZOEICQO
 IU5nERcHuk3T6uPDUcXFOLwOe/xgDoCzBUOxX7dy8d45+2GoR//cYecZfgMsMvdkNsrR1shm9oI8D
 7bteA0D/SK+GkQ7tgk0bTKMWzRv9VEr1f1Et+A0/E/VeHN/LxSxExgEGBBuNR8Mms8TBG8oK2xbtE
 fxCXSHc7zT0oyUMRHbLuWCpSDt0TjeNXl7CSWeURF89WHAHV4CqJVfS/Y18RhT/qhF/ryo5kuXHGS
 VgYNHtyHkvVY0CedsT5xcnfXgrEJfg/pp3Arz2lNS6g1+8xVjVcoMY7bnzw2ztHxALuUp+iXhdyoi
 6yar6q4XNB/+5p0jX1uAUIVq9GHa0bLmnOVp2+gJyMWstLdxs9YnRT2AlwdQx5IudXstbXJF5XIpm
 NZqeFMhD6S8gyWePDtW7HH8CQz6xy9PtkYc/jHsqpIoOjh4e0Unbt10Ik2SzdaFa3nG2F8DVnsGYr
 xxBfVOGzIu00yzh0xdDuyuRY2iE9FxM8DMzrNYabg+xddQufqR8Tyj6f+bOwazAGS0xV9se4nSI0K
 rlnHXzomHa4xGaauyAF7qpChLB58HEHrmmGtm4kK3arxnhbJGm0RKCB3pvVPw2d9BbHPtt/gFc8RU
 fO9C8Gbo2j2hj0D+3ce6dVeuYuPA9mIJOZtr9ckAk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?ISO-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
Date: Sat, 12 Apr 2025 10:21:47 +0200
Message-ID: <2441396.svyq9LpYvz@silver>
In-Reply-To: <CAEDrbUakVwwn228nSb0rD1C9qiZ-tpcHBzLRDVyGRNsim97=JQ@mail.gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2533109.DitPQcejgS@silver>
 <CAEDrbUakVwwn228nSb0rD1C9qiZ-tpcHBzLRDVyGRNsim97=JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Friday, April 11, 2025 12:47:29 PM CEST Kohei Tokunaga wrote:
> Hi Christian,
> 
> > > Emscripten's fiber does not support submitting coroutines to other
> > > threads. So this commit modifies hw/9pfs/coth.h to disable this behavior
> > > when compiled with Emscripten.
> >
> > The lack of being able to dispatch a coroutine to a worker thread is one
> > thing, however it would probably still make sense to use fibers in 9pfs as
> > replacement of its coroutines mechanism.
> >
> > In 9pfs coroutines are used to dispatch blocking fs I/O syscalls from main
> > thread to worker thread(s):
> >
> > https://wiki.qemu.org/Documentation/9p#Control_Flow
> >
> > If you just remove the coroutine code entirely, 9p server might hang for
> good,
> > and with it QEMU's main thread.
> >
> > By using fibers instead, it would not hang, as it seems as if I/O
> syscalls are
> > emulated in Emscripten, right?
> 
> Thank you for the feedback. Yes, it would be great if Emscripten's fiber
> could be used to address this limitation. Since Emscripten's fiber is
> cooperative, I believe a blocking code_block can still block the 9pfs server
> unless an explicit yield occurs within it. I'll continue exploring better
> solutions for this. Please let me know if I'm missing anything.

As far as I understand it, the I/O syscalls are emulated, and when being
called by fibers, blocking syscalls would imply to yield under the hood,
without explicit yield by application that is.

If that's true, it would only require little code changes for this to work.

> > Missing
> >
> >     errno = ENOTSUP;
> 
> Sure, I'll fix this in the next version of the series.
> 
> > Looks like you just copied the macOS errno translation code. That probably
> > doesn't make sense.
> 
> Errno values differ between Emscripten and Linux, so conversion is required
> here. I've used the same mappings as macOS for now, but I'm happy to add
> more conversions if needed.

OK, but why have you chosen macOS errno mapping exactly? Are you testing on a
macOS host machine? Are errno values of emscripten machine dependent?

The errno mapping must be correct, otherwise funny things will happen on guest
side if 9p2000.L client is used, as it blindly expects errno numbers sent by
9p server to be in native Linux errno number presentation.

Alternatively 9p2000.u protocol variant could be used for Emscripten. Not
ideal, as this 9p protocol version is somewhat a legacy protocol from QEMU
perspective, reduced performance, less reliable, but it transmits error
strings to client which it can map to correct errno values by itself. Linux 9p
client uses a hash map for this errno translation of 9p2000.u error strings.

/Christian



