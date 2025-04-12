Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE0C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 10:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3YGE-0004BF-Ff; Sat, 12 Apr 2025 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3YGA-0004AE-Az; Sat, 12 Apr 2025 06:38:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3YG8-0006iX-8S; Sat, 12 Apr 2025 06:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=cosF4cLG3559+ZAOzHp/RB0TPGm6onnaZsU/QKhSE3M=; b=jdn/E8317fF0Im23TcxV6tPIqL
 GvmVCQSKUC/KOvv7Kg8vNSqLpC4LkjgXNiN+G0F2IlTc21iRAlx6RdaPu3oXHQkjmofu2mQ3NJBDW
 U6sDZfPyeP3MpyBBh6kpR5nrzVFVah0cheaWfIRmO0V57dpasVfgHtHhlqsroID90FPnUZZSQ1vnK
 Q84pYx1NDDv+AVA+jflpp7vbZ1khzRHSf0Jr2ZkR7yNywWUa3gXsOvT11dt5sGh2L4UqUonVUqs99
 2D1w7oxz5xNOYYL8K0nV5FFW/yMm9mcOwiFLWJLlJXD002rfei4xTibSTLnzbqdqPISNaNzRdjUyN
 tZ1y4M+IZcfBqzVuxEsVCh/ghLkr17QJYnmbkk64Hn9+lovClGmQPpTuovi2rnItzyXAHgQR99NyJ
 lKcDd/VJyiLAwzGrWk46BHb2iimIZ9N3f7hIHp2gfnJil5g1qAn3Pq0H/DcfZo2clSQUEoGB6PHjL
 BPGKi019w4pmryrglo9IGRGtmXslHrK14qB07l3xFGBAWuyH2fZKp9roUWD/VbKEUW0JhzMNsSZGt
 zZKa33rA8Mv1UOwfW7dh1PcLk21b6OCPC6VEHwge3RT43A0yD8EHSxhMdoznmjq1pd3jf6hX4+DyY
 kwMScqfxHSwI5DA2Di5WoN3CuMxc0LBVOAVSJuXyw=;
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
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
Date: Sat, 12 Apr 2025 12:38:34 +0200
Message-ID: <2555565.yjhJSkacHZ@silver>
In-Reply-To: <1881242.gqbg26PhFk@silver>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2441396.svyq9LpYvz@silver> <1881242.gqbg26PhFk@silver>
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

On Saturday, April 12, 2025 12:21:47 PM CEST Christian Schoenebeck wrote:
> On Saturday, April 12, 2025 10:21:47 AM CEST Christian Schoenebeck wrote:
> > On Friday, April 11, 2025 12:47:29 PM CEST Kohei Tokunaga wrote:
[...]
> Let my answer my own question: I just checked the wasi sources. The errno
> values are hard coded by the wasi API, consistent over systems. So the current
> mapping of this patch is wrong. macOS uses a different mapping than the wasi
> API.
> 
> https://github.com/WebAssembly/wasi-libc/blob/main/libc-bottom-half/headers/public/__errno_values.h
> 
> https://github.com/emscripten-core/emscripten/blob/4af36cf80647f9a82be617a0ff32f3e56f220e41/system/include/wasi/api.h#L116
> 
> So please use a correct mapping as defined in that header file.
> 
> /Christian
> 
> > Alternatively 9p2000.u protocol variant could be used for Emscripten. Not
> > ideal, as this 9p protocol version is somewhat a legacy protocol from QEMU
> > perspective, reduced performance, less reliable, but it transmits error
> > strings to client which it can map to correct errno values by itself. Linux 9p
> > client uses a hash map for this errno translation of 9p2000.u error strings.

Stupid me. That's host errno -> Linux errno translation. So your values are
obviously correct, sorry!

However still worth comparing the Linux vs. wasi header files on this.

And I would avoid duplicating the macOS translation code. Instead I would just
do a one-line change:

#elif defined(CONFIG_DARWIN) || defined(EMSCRIPTEN)
...

And probably leave a comment with a link to the wasi API header file there, so
in case new errno translations are added for macOS, that people also check
whether those macros exist in the wasi header file as well.

/Christian



