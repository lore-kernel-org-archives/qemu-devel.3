Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85D606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7Jg/5p7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AeHm3Dkl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGKB-0000XQ-41; Mon, 26 Oct 2026 04:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLGK5-0000XF-Qb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLGK3-00016l-MX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793004289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eq3zGCSPpKK19sp/yM23Gch74+xErvW3lp3N59wqiQY=;
 b=A7Jg/5p74ukghI34s/8UXHVIAKONleldqFrh0679TZCMKkEWMKq9Cmd6feqlTzdgYfe3j7
 XZ45Dd8nfys60Bg6Ef7zaiefBIDWTtQQonIL7k99fWnbz3OjQ6Zrq55dZB+fbCAyUy/P/G
 3rZX30jYZpZjnd79A96/jncRiN6i90M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-4tL8IzZzMOqCziCiftiEzQ-1; Mon, 26 Oct 2026 04:44:47 -0400
X-MC-Unique: 4tL8IzZzMOqCziCiftiEzQ-1
X-Mimecast-MFC-AGG-ID: 4tL8IzZzMOqCziCiftiEzQ_1793004286
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dfaaea30cso1923935f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793004286; x=1793609086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Eq3zGCSPpKK19sp/yM23Gch74+xErvW3lp3N59wqiQY=;
 b=AeHm3DklecweQRaGfB8X/GC//vKUgi39g45yYKE5n0bqtz3Oid7Y7jYXqhVMwK/Ef1
 12Fx/YY4vjBGUjv65WTJqmmTDXIoxj3nj7e89VjzUxWePTs2qR4/cTW96QOnnSPEHfUc
 7L149ym34W9YvTbDzTuoIUyh77z6A5EXs0paWTlXt3YNHJwYFDEXhfOF1m0hE6X7KMnb
 N12ZXJ1RfklPYN29Aro/CJqyKW8yc5dxQkI5P8ZOBfBem2/cP+LdHHMwQkz5axSTvVht
 SW4uhinZkv/Skzm+0zj5ssugOdtrJpS0VWqurTKO6GybMb16Tcf5hc37z3N62wYU/ZkG
 jyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004286; x=1793609086;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eq3zGCSPpKK19sp/yM23Gch74+xErvW3lp3N59wqiQY=;
 b=bNpIq7dCk3Cz1AD85SJ46Tm2D7a80HGPRmZr1SOtFzS7olT7fcAzuH3VIBZBo7cSjJ
 83UYoK3INIBz+ENQbkBo++TiVnnljM40wZbbhtpfEBNecTDcPMNBuQAHHbjcSkoe1VnU
 VM+erudWGu0MKuCKwwbYcUsbBQayFR/HFUXXN/Gi8vfWsNOTWaRD0+mrSlAggWHNZPF/
 PYr+v6aBnhvBiIkOalPqKVgUBhgZfPJpY4canprLDR2E0unGMmPnGlYoGEhVjrKadcrt
 /r4kXK7auNeAMO4M04yzF81mahVuobq4UV7e6WnaasOiSPu7wAR5E81IDD4AAqab0HI1
 e4yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBze5HMLBJY2uf+0pMURrFPF6j5UA8bQvjM7wjBycqbKNUwrVR/I8arqK1QTQp3GH1yEO+Qwqbc70m2z@nongnu.org
X-Gm-Message-State: AFq9FYIxzNLH9hA/NVQsqomtwtUwlfB/jEQRK9sbJMT3XT8LUJ2WHovf
 uVrPKtvrngMSuJcrf4F6msSfnFwo7VcOlDQ7Rzs55Lihu+fgaHVIQDEMeWkMO7JCIMjZEAwDYIO
 UhPY05TMjibmIESx6vP0+82zfQaMdPA2ich/p7ak9vEsu2CApugGftWUlouRiwuMF
X-Gm-Gg: AYBFou1P/Lm9DSWwnJCQbQVPzITZYzhjikgcLpQeyENRO6u0LJyMT1zoDMBDSEu4blH
 4Skizcn0zwPuXLu0D45/SB2NoFvwx9rU0r3SztGfSyRUuc6U2y8UPYrfOxl3pBqdKk8/a7HJdB3
 fJhQGq72yDqJJxKHoHhpxg3VNfGQUT9I7qxH8dBHQq300re5Z+Nh8vVw3HvE6emDguUQiebw34d
 0U9ZKs7eW2PmRRNq4w9BC9qkcYWk1fUP85ChM42szFydP00jT/CrSS/dPWWNuc4D/Kb+fwmg7c0
 41pDb5zQbmcZNm5k+GR5qtycwcym5GEpoO0mCU7xbompmfugLTAdCSX8GN1VcXWnkI3YZ30=
X-Received: by 2002:a5d:44cc:0:b0:48e:23e1:35ec with SMTP id
 ffacd0b85a97d-48e3eb9c203mr7712508f8f.47.1793004286029; 
 Mon, 26 Oct 2026 01:44:46 -0700 (PDT)
X-Received: by 2002:a5d:44cc:0:b0:48e:23e1:35ec with SMTP id
 ffacd0b85a97d-48e3eb9c203mr7712481f8f.47.1793004285557; 
 Mon, 26 Oct 2026 01:44:45 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm15462322f8f.57.2026.10.26.01.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:44:44 -0700 (PDT)
Message-ID: <cf0650c4-e6ed-4dda-9b8f-fed5a2762251@redhat.com>
Date: Mon, 26 Oct 2026 09:44:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/9] tests/9p-race: add 9p race test suite (race FID-path
 mutations)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
 <2296ed61d2a38b5198d2fd9fe88056be4cd4adba.1792420035.git.qemu_oss@crudebyte.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2296ed61d2a38b5198d2fd9fe88056be4cd4adba.1792420035.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/2026 16.27, Christian Schoenebeck wrote:
> Add a qtest-based stress test suite racing 9pfs server-side state.
> 
> This patch adds the first race test "race/fid-path" for this new
> test suite: it races (per round) one Tlcreate (which is mutating
> the FID path) against a number of reader requests (Twalk and
> Txattrwalk) on the same FID.
> 
> This very first 9pfs race test guards CVE-2026-93834 (fixed by
> commit fe9e30899f "hw/9pfs: Use read-write lock for protecting fid
> path.").
> 
> Hitting the small race window is timing dependant, so this is a
> probabilistic test, not a deterministic one. During my tests the
> (unpatched) vulnerability triggered sometimes after few hundred
> rounds, and sometimes after >100k rounds. Furthermore, it expects
> QEMU being compiled with a sanitizer (e.g. ASan) which is
> supposed to detect the actual race (e.g. by memory violation):
> 
>    ../configure --enable-virtfs --enable-debug \
>    --extra-cflags="-fsanitize=address -fno-omit-frame-pointer" \
>    --extra-ldflags="-fsanitize=address" ...
> 
> Even though this is a new test suite, in the codebase separate
> from the already existing deterministic 9pfs test cases (while
> 9p test client code being shared between the two test suites),
> this new race test suite is run with the same binary as the
> other qtests. However being a very slow test, it is registered
> as such, so the -m slow argument is required for this race test
> to run (as it is skipped by default):
> 
>    ASAN_OPTIONS=detect_leaks=0 \
>    tests/qtest/qos-test -m slow
> 
> Or if you only want to run this single race test (e.g. on x86_64):
> 
>    ASAN_OPTIONS=detect_leaks=0 \
>    tests/qtest/qos-test -m slow -p \
>    /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/race/fid-path
> 
> On other systems, use `tests/qtest/qos-test -l` to get the correct
> (arch dependent) full test name.
> 
> `ASAN_OPTIONS=detect_leaks=0` is currently required, it suppresses
> a memory leak error at the end of each race test, which is a known
> QEMU shutdown memory leak, unrelated to 9p server or this race test
> suite. The official QEMU CI pipeline sets
> `ASAN_OPTIONS=detect_leaks=0` by default for this reason.
> 
> There are some knobs that can be controlled via environment
> variables:
> 
>    V9FS_RACE: skip test suite by setting to 0 or force running by
>               setting to 1
> 
>    V9FS_RACE_ROUNDS: total amount of rounds to run
>                      (default: 20000)
> 
>    V9FS_RACE_NCONCURRENT: amount of concurrent reader requests
>                           (default: 4)
> 
> A full run with 20000 rounds took around 7 minutes on my test
> machine. If you can't hit the (narrow) race window with
> unpatched QEMU, it might help to either add some load on the
> host system and/or turning the two knobs above.
> 
> Link: https://lore.kernel.org/qemu-devel/4a0eff0539f16434b48728cd8e5a89f906c293d8.1791368962.git.qemu_oss@crudebyte.com
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   MAINTAINERS                       |   1 +
>   tests/qtest/meson.build           |   1 +
>   tests/qtest/virtio-9p-race-test.c | 575 ++++++++++++++++++++++++++++++
>   3 files changed, 577 insertions(+)
>   create mode 100644 tests/qtest/virtio-9p-race-test.c
  Hi Christian!

Since this has been merged, I'm now seeing timeouts of the qos-test when I 
run "make -j8 check-qtest SPEED=thorough" ... can we please fix this 
somehow, e.g. by increasing the timeout setting of the qos-test, or by 
decreasing the default number of rounds that this test is trying to do? WDYT?

  Thanks,
   Thomas


