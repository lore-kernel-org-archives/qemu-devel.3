Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE759C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXbRZ-00050m-Bm; Wed, 07 Feb 2024 01:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXbRX-0004wn-KQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:29:59 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXbRN-0001sQ-9U
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:29:59 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 3ED3540F1DE2;
 Wed,  7 Feb 2024 06:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3ED3540F1DE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707287384;
 bh=4L174Ro+Ao8jvDVkYqfFwNB3XHQw4Yfm0Ze1QRrufgQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=g0utwsW/YkjTyIcBDHplojIDxRashFZFMj/03/Uet3/GEvIh1mpyapUNqiEUvcEHu
 Dv/gWbUXo8kPsRu3ohbpi94GOqpYbRtT/H4C19hMSePUVEPgc9nBYJGnZnJyZu0FXg
 KFk1PY8vxYrfW/N6g6tRh+UsatxA5OEVyRg0P/ao=
Date: Wed, 7 Feb 2024 09:29:44 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Elena Ufimtseva <ufimtseva@gmail.com>
cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/6] util/bufferiszero: remove AVX512 variant
In-Reply-To: <CAEr7rXiMEm12YqUJ5r+Nur7iJxcvfxLKmasJKJ2QGmFhZL7-5Q@mail.gmail.com>
Message-ID: <c0037199-a9c1-3d6b-4627-9d3cf49010d3@ispras.ru>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-4-amonakov@ispras.ru>
 <CAEr7rXiMEm12YqUJ5r+Nur7iJxcvfxLKmasJKJ2QGmFhZL7-5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-593109963-1707287384=:6052"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-593109963-1707287384=:6052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Tue, 6 Feb 2024, Elena Ufimtseva wrote:

> Hello Alexander
> 
> On Tue, Feb 6, 2024 at 12:50 PM Alexander Monakov <amonakov@ispras.ru>
> wrote:
> 
> > Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
> > routines are invoked much more rarely in normal use when most buffers
> > are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
> > frequency and voltage transition periods during which the CPU operates
> > at reduced performance, as described in
> > https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html
> 
> 
> I would like to point out that the frequency scaling is not currently an
> issue on AMD Zen4 Genoa CPUs, for example.
> And microcode architecture description here:
> https://www.amd.com/system/files/documents/4th-gen-epyc-processor-architecture-white-paper.pdf
> Although, the cpu frequency downscaling mentioned in the above document is
> only in relation to floating point operations.
> But from other online discussions I gather that the data path for the
> integer registers in Zen4 is also 256 bits and it allows to avoid
> frequency downscaling for FP and heavy instructions.

Yes, that's correct: in particular, on Zen 4 512-bit vector loads occupy load
ports for two consecutive cycles, so from load throughput perspective there's
no difference between 256-bit vectors and 512-bit vectors. Generally AVX-512
still has benefits on Zen 4 since it's a richer instruction set (it also reduces
pressure in the CPU front-end and is more power-efficient), but as the new AVX2
buffer_is_zero is saturating load ports I would expect that AVX512 can exceed
its performance only by a small margin if at all, not anywhere close to 2x.

> And looking at the optimizations for AVX2 in your other patch, would
> unrolling the loop for AVX512 ops benefit from the speedup taken that the
> data path has the same width?

No, 256-bit datapath on Zen 4 means that it's easier to saturate it with
512-bit loads than with 256-bit loads, so an AVX512 loop is roughly comparable
to a similar AVX-256 loop unrolled twice.

Aside: AVX512 variant needs a little more thought to use VPTERNLOG properly.

> If the frequency downscaling is not observed on some of the CPUs, can
> AVX512 be maintained and used selectively for some
> of the CPUs?

Please note that a properly optimized buffer_is_zero is limited by load
throughput, not ALUs. On Zen 4 AVX2 is sufficient to saturate L1 cache load
bandwidth in buffer_is_zero. For data outside of L1 cache, the benefits
of AVX-512 diminish more and more.

I don't have Zen 4 based machines at hand to see if AVX-512 is beneficial
there for buffer_is_zero for reasons like reaching higher turbo clocks or
higher memory parallelism.

Finally, let's consider a somewhat broader perspective. Let's suppose
buffer_is_zero takes 50% of overall application runtime, and 9 out of
10 buffers are found out to be non-zero in the inline wrapper that samples
three bytes. Then the vectorized routine takes about 5% of application
time, and speeding it up even by 20% only shaves off 1% from overall
execution time.

Alexander
--8323328-593109963-1707287384=:6052--

