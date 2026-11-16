Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sFuDzw+d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSyF8-0004lt-N5; Mon, 16 Nov 2026 10:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSyF4-0004le-0B
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 10:03:34 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSyF2-0007pR-Au
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 10:03:33 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67bee1f693bso2979742d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 07:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794841409; cv=none;
 d=google.com; s=arc-20260327;
 b=YP19ikc9vCsfGypl1X2YnLQObgjugKF4VOGNDS6sxhWq+sC5hs0U3Butk/MGA9T4zT
 4uNq2jEUIQXyBmJyYis/FdwwCeedQEu8xXn9SrxCRfPV/bl9fmdqH4y/AvPqvSnL9mOX
 KSzG19HV+Ilisz15PHjBK3mO9t9kentsIy1BFqT1W42/GyfQeSAm8VixB8l5UXzX+Kh6
 LmzPaa2+OaExs6HzQuv6gbrpnL6oOLQ0Jt6LXuRVyvJUFpmt/Aygri85QHFL/Q9THCoB
 6UhHghTyuoeHLRoVTsZ80hPQzj/miQe4GnqjE5IS4r3ejeAmB3x8POpA+yh1HG+a0Mzi
 rfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=USC2HzXhMm7gUvDh4qi+O5SvnCMzFSAYxYLQ9xom+fs=;
 fh=fD7D10OYhga5S6sFXOfoU7oKAvi9BDzpECUX6+b8H8M=;
 b=q7JH0kpv6PVHpeIKU7hbAVcCKkea7A0cLNuYvn6Lb41LddqEOxrBH6gW8Az0Q8rBKb
 9+W9gyqYQ8hzGi1lUeIYsZWdHnZNbxFsfsXowQgKSdUEyG3VdnKYuPwWqcbDon6SynnX
 x+g+bLxzm1+eT+DWb3FGKFA1BFEA6blWch3ntwxM7W7NPijmFllfaiXutXBkgxm4CAdu
 P4S0MRDphqi9OOYgdSMyT7a/+PrToPUxcczP3JGStitQEm91Umzqg5LR6xz7mwgzmKWi
 fVKWqcOydHxiYU+2rVyLwZylfuO5zp9CgHc8eV+6S6vKuTgMY0NhzVLeXjijoA7UccWO
 6gWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794841409; x=1795446209; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=USC2HzXhMm7gUvDh4qi+O5SvnCMzFSAYxYLQ9xom+fs=;
 b=sFuDzw+d3dWAiqxtZfoozG8F4NB/XC6WeV1c8ZLyTq7Ap+naoQRMKAWaHmMtGztiKI
 cH5B4lcU6KnGR0Qx7RN2wya09PrTyY+EhZdpvJxw+ijTDFzvzblrtRMehk9ZwA3Jfl2j
 ZuFWAVgOPwOWwAHezZU4CXYBxNKMoEOPHmEq2ha/kCjs0fKfHCVK0+ZByflx2pvjSyUp
 PtF0KdSxGOG3Gib3yFg/eraET5Qm0lUAbmnaRZfQoA/AWnziH0skZiFkEZFZm+5q5CI1
 crwtrd3SchBYoKZadyMugfJ0yZaoiKgk70oh62qvurtKTEAtoLHi5lO9tY7lhJZ5oM2/
 P6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841409; x=1795446209;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=USC2HzXhMm7gUvDh4qi+O5SvnCMzFSAYxYLQ9xom+fs=;
 b=KlKTZvWBzCnCTFSwM6tcc4XVxXHl9tOg5mkHZDyN21qbmIo7idfyXW2PU9Bz2+dlRc
 +whHjYRN6AvL9zbCD6/6HlOkBxV+ilU6JYDVt4M8dzQELKDpgh1VxWdMTr/eCS7iWGb5
 nYAqOEVZIYYz6u7wdva3kArIRhfW2cCtGGFVSOPkMyqDv8LNlW+n+Gmc9Wp/7UWneIl5
 1smEI651QD6czemDjPdzK15kcS4Z/l2PJnS850vfvSpH5Gcux0Z++mIWvjbHr52hL75J
 TJZZtFb179rIBOKhEyNuAucKRVfTPaWAMAd6s+Sho69GffD7CVm7DEEtS3ZZ9svOzfQ+
 AkFw==
X-Gm-Message-State: APuU4Z+/7lV4CiUKHHsyOiRlchHDltP+2ncleSjmitwUeuxNWxl5c7lL
 h8G92cuUeDhA3VznItFkjspAvs1Krw7Np6h7juDDheS24ODMzMg0rJiLQnmq9L6NHx8cIAd8F/2
 tXiVcJmEJzq/2pwjxBRCMdV9otAacWUuzhvb1Uv7ahSsEdwp/24TQ4kGpyg==
X-Gm-Gg: AZFdTZd0JQ6iOd8rcKgAYNF7EF2NyzsNBUXOhdD929KwsjVzsI2djz1q7KAcfYMx6p1
 BiAYPqYOD/fRbXjPPqJ8jgyorNhn3Ku3mokNp3uKIwUYKOgspTFZmDIch8CrACM1AQljOs4vUDA
 s/4IrjlpA95oQn20b7NgFUjINf/ovdCGMLPMcxexvfAit0Er2iY4Xc+1hXnYHlm/Fj1cIpyfvIg
 o7UQpIN14/BHCkTrj7o9wCF+3G6TwBOJzmFG/lS+bf7JPW+V48LR9u7s8k/1YrnWg4LyKC1jfO8
 LXeit1fIcEyz5KYpY240LanuQQFOjkzhDLkrnhb+36eYrOgawuAMgqk48iOo7qaN9JZBSTEOee9
 d+ImZ+2JMu2zpcbFdP9xar0xHnpWvaKHm019Dtsy9hnRcntGX2XAvPZqbqyHJN7fojuoHhW8Wmz
 QD2evApDWFG70pA0fZOWq7
X-Received: by 2002:a05:690e:13ce:b0:67d:b84d:5bc5 with SMTP id
 956f58d0204a3-67db84d5ed2mr1395536d50.3.1794841409235; Mon, 16 Nov 2026
 07:03:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 15:03:16 +0000
X-Gm-Features: AclHuK_4SxFLG4mAFqtRDLRJdp4ikswX5qyJO0CJ2km7nro7Szg0qDKchOB2Kk4
Message-ID: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
Subject: memory_region_init_ram_ptr() handling of sizes that are less than a
 page
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
create a MemoryRegion backed by a lump of memory provided by the caller.
They do this by calling qemu_ram_alloc_from_ptr(), passing the size
and pointer along. However, qemu_ram_alloc_from_ptr() does this,
regardless of whether it was given a host pointer or not:

    align = qemu_real_host_page_size();
    align = MAX(align, TARGET_PAGE_SIZE);
    size = ROUND_UP(size, align);
    max_size = ROUND_UP(max_size, align);

The result is that if the caller passed us a lump of memory that's
not a multiple of both the host and target page sizes then we create
a RAMBlock whose used_length and max_length fields claim that it's
larger than the actual backing memory. Any user of RAMBlocks that
trusts that information (such as the migration code) will then
happily read or write off the end of the backing memory.

This obviously isn't right, but is the problem:
 * that qemu_ram_alloc_from_ptr() shouldn't align if it's given
   a host pointer, and all users of RAMBlock need to be able to
   cope with unaligned base pointers and sizes?
 * that qemu_ram_alloc_from_ptr() should complain (assert?) about
   unaligned base pointers and sizes, and all callers trying to
   use it for smaller MRs need to be fixed?

This came to my attention via
 https://gitlab.com/qemu-project/qemu/-/work_items/4877
which reports that trying to migrate the AVR 'uno' machine runs
into this because it creates an "sram-as-io" MemoryRegion backed
by a local allocation which is less than a page.

Related is
 https://gitlab.com/qemu-project/qemu/-/work_items/4663
which reports that the tpm-tis-device doesn't work under hvf, because
that device creates a non-aligned RAM MR with memory_region_init_ram_ptr(),
and the hvf code fails with an error when it sees a non-aligned
lump of RAM.

I'm not sure which direction we should be going in trying to fix these.

thanks
-- PMM

