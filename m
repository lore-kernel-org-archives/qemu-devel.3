Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EBACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7rB-0006qN-OE; Mon, 01 Sep 2025 12:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7rA-0006pu-Gr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:58:12 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7r8-0005i2-4b
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:58:12 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e970f3c06b5so2921103276.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756745888; x=1757350688; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YU/e9dtVdR2UeTNrsZclYhQdygp0+Bvgp2RaMZh/uno=;
 b=PgkzgvovtbWtZ+wETxaqCtR5AMtmiXeiAcHVpJ4+X+U3PZPcQvQsGcVw8l6wYzohQ2
 Y50Aa0YIz6WriUSQdCdBu7ODNG9Qzur4yC1j74xozTv4ytUBE8oqF7aQj4lRaF/4tOy3
 GeGgOfcqL93khN0YKqxE0gJBW/1gimehYbn+jTwVQE509P62RkQAUoAY736/7GmAmko5
 HDSzxtJn+AsNr9qhL1Y05UEhrfRLGtVFRa0+BmDpZ6vP0pwFvmMRDukK1IONoWWRwTBV
 VT8E9isasIxGFRkTslVkULm7jB8IVhLMBqBe+NArbBRLg/1MsCQjeKxfRWMW70wJsqlK
 YFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756745888; x=1757350688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YU/e9dtVdR2UeTNrsZclYhQdygp0+Bvgp2RaMZh/uno=;
 b=tLX2VlnxkAUE8cNNVdHkE/owHaJ0NmZYO/qBEwighBNCbRKFk64cBvvtLNWYRnOiIv
 hjbSeNcMRYMsAdQ5xX5xMdLj8slxMciImqZBbFF/YeQJCw4vPS24unNX5b7GaRQFTJa9
 NVOEcFKuFL+DgsAHfk28pmg8NW7PU55ILf5Zee4zNKWuOCLZpf91xCighzy5mVQgYbtR
 RijqrnDUmDNTFWfWvK1xnyL31KCNInf8MVvCsa7Od3yaAzef+Pwz7hdctj/UsMa6v9xi
 JoFBU+hVkm3DYgSO7M+qbFkc8ieqaZ9tLtRHPc9J+scXrbhUg63bZNI7XH4FRCkUX3ip
 /VAA==
X-Gm-Message-State: AOJu0YxuWHzRs+mj3oPHyRhIBI3iU2kHWb+Sye5P2HuHsl5uO3nS1r+0
 YJClLk3HQVwmRwTWTn3IYT9ZLTHfhkDsVhkmwtJC0KC3E1R19x4UOlNA9U8gGILRNWoNrneSrsi
 oK5FqH+0qa2K08wBZ5xU3Mb/OGveIDuU/mhw3WSjhtw==
X-Gm-Gg: ASbGncsYj0rO6gXcnWUepf5W3laVqH9DGYAFnieKlo2cv90G4FlzfYNq5qutbBoC7uj
 FS6ENTt9Rbp4pQp75gNG/IRLNyHQxTmoF/R+HUW8VGRfyWgN8l1wMGQHnj9KxL14bscDjYtKIjO
 B70Q5ma33f4L9N1Y6r6Ac5wrntYIPmOnew310dSetogo/F23A6p02jamnmnmx/Mw/VrDx8EpcCY
 Nf03TdQGDaXpivDytE=
X-Google-Smtp-Source: AGHT+IFyzPXN+xyR+Z3sNFk3pdxT+5CjrdNH6EnQySo7LIoj3JpurlQUcoHrfDgYbfQwgrlCjcL17PkjXBzhcBFX8dA=
X-Received: by 2002:a05:690c:630e:b0:720:b0b0:e4fa with SMTP id
 00721157ae682-72276546fc6mr106970267b3.45.1756745888389; Mon, 01 Sep 2025
 09:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-10-cjchen@igel.co.jp>
In-Reply-To: <20250822092410.25833-10-cjchen@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:57:57 +0100
X-Gm-Features: Ac12FXxr0nvbv9k30UN1IHCqFoxib_0NEE8IDO_Rw3P8DbFnm9X6Hm2DWWEd-Jk
Message-ID: <CAFEAcA-r5DdZj-+BxBkN+XqWJ3QrN6g+RshjShVoD-Zf1weYPg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 9/9] tests/qtest: add test for memory region access
To: CJ Chen <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Aug 2025 at 10:26, CJ Chen <cjchen@igel.co.jp> wrote:
>
> From: Tomoyuki Hirose <hrstmyk811m@gmail.com>
>
> This commit adds a qtest for accessing various memory regions. The
> qtest checks the correctness of handling the access to memory regions
> by using 'memaccess-testdev'.
>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Co-developed-by: CJ Chen <cjchen@igel.co.jp>
> Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> ---
>  tests/qtest/memaccess-test.c | 597 +++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |   9 +
>  2 files changed, 606 insertions(+)
>  create mode 100644 tests/qtest/memaccess-test.c

There seems to be a lot of duplication in these test functions
(for instance, aren't all of little_b_valid(), little_b_invalid(),
big_b_valid() and big_b_invalid() identical?  and the various
_invalid functions seem to have if() blocks where the code in
the if and the else halves is the same).

But also, I feel like we could improve what we're testing.
If I understand the memaccess-testdev correctly, it has
one underlying block of memory, and it exposes access to that
via various memory regions with the different possible
valid/impl/etc configurations. So I think the way to
test that our memory access handling code is correct would be:

 * for testing reads, we first fill the test device's memory
   with a known pattern, always using the "just permit byte
   accesses" memory region. Then the test of each of the
   "some particular config" MemoryRegions only does reads,
   and checks that reads from various offsets do what we
   expect
 * for testing writes, we first clear the test device's
   memory to a known pattern, and then the test of each
   "some config" MR only does writes. We check that the
   writes did what we expect by doing reads from the
   "just permit byte accesses" region.

If you only test e.g. word writes by doing word reads,
then it's possible to have bugs which cancel each other
out in the read and write paths, especially in the
"aligned access only" case.

thanks
-- PMM

