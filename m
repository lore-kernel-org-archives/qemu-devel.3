Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4QvLAcI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bP7QUS2S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLbad-0004GP-2d; Tue, 27 Oct 2026 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLbaX-0004Fz-JN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLbaU-0005AE-WD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793086034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hutGR+cJLkN8t93O7y7h/orEEg1YTQ/T36VS5FfF5Lo=;
 b=b4QvLAcIMA/oaF+LURxWLd/FQtUxGbY3vkHjnpsNKSPT2WO8/+/4VBJK5+5LgzwxD9yUnN
 AqW7OqXpiebMghMYcveUseBlieUzHS7bU3v+eh0l8karVsFTNSMZHzmJOzFwI7xN/ZoI8L
 4rRfy0WUmxKzI9dAc/md/z3Yu+fsq5M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-46YBzIb-MD-Bqc9OBzW8Fw-1; Tue, 27 Oct 2026 03:27:11 -0400
X-MC-Unique: 46YBzIb-MD-Bqc9OBzW8Fw-1
X-Mimecast-MFC-AGG-ID: 46YBzIb-MD-Bqc9OBzW8Fw_1793086030
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2063be13dso32176915e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793086030; x=1793690830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hutGR+cJLkN8t93O7y7h/orEEg1YTQ/T36VS5FfF5Lo=;
 b=bP7QUS2SB17JCeC9GGD9dqXtpf14vrLczEH8KB13ukAkX0V9KCMBUFHgDhDoWNg8W0
 KnWrRKtNjSQZbtzvH/f8MmpTjGMEn/YyDK3QkfkhwWlMuaR0KcqMACxZnnuABqUGC56V
 ysQNmS7zFdunpI0mVPbjbupzRKNPVLXy/JjF+2s/uVPWZy5MmjgfGU9Un2V3ol7OW6i3
 YDJP0+xC1z9XuQfiVwAajbYrTaZanmv1npSQ5is0OQ0+pntsMAPD8mwIINgfoehZL3Dq
 hYie0eMAfZEC5piuYebho6DtmIglmnl1qKKCMoW6U92VSu5xanjSIr6sNI5EYNE5DSjL
 Np3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793086030; x=1793690830;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hutGR+cJLkN8t93O7y7h/orEEg1YTQ/T36VS5FfF5Lo=;
 b=JvVrgrRFWbs9p7YduCte2iim2/n+DdVBUnRQMFFoZbgPV3sz59G+qCNzZPsQRfushd
 HJ0UdIe9kh/5DHoXW6DYX+hFHVqZv6k90b+WxVq6fpfhTC3B6+rFPM5Ysndll1+swEKC
 1fXSmwrEi/K5TPtG8aqDe9Q7m9p4XnjQxBZK1cmWueDj32Qnv11XoueWvSL+CjUbAhp6
 hJgIDplOA/A0jOylzEV5cuuFgqsAxGfMjlVjxBrDgFpYZhKTlfhR3LSr5Y1Bsr7guTBz
 coZ8XpA0NFaCnn0Rw/NqYI6etabY3MkU1/+QYDgKSJISEVL/BteGxGXx6UiKhDQ0BQfC
 +RfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2phrNG+cuG1wxLjU7ZtLl/7zu0JVZ1MAAAD/N8CNztzTMG06qZ7+mifCU07vCSnqoIR97u1qGQ+Pz@nongnu.org
X-Gm-Message-State: AFq9FYIb43lRRq2fF01yUEIJj/qa+HZKVWeAYn9yKEQcff+m0l3NkPKl
 VTELphcU/u0OS76nU8o4P1oJLGhHJjW38TO5fErWHM+IB37vinBuSOJzNWl2VxlsQazcDwI5j4Q
 zKQReR9eiso4zoxMsPTVGF4EuzLk+r4JI3N/ra+RIayRYER7SQhnz4HNJwreE/5sf
X-Gm-Gg: AYBFou3deynWOy5SkRvS5XVcC7d/FeW65wAMVZJ+YcSltKVRbCtRCojPTsL8YOg9lcb
 /rQ6qZTx7PrCF1e13/KTEnR0QtOJS90Vm1BUOE8DlQZvInWaTAolC32ExuBKJnWKX97dzMAgb8v
 Iz4TrJ6BcCfkjXFNqqDKyrDPrnDZm7tvZnK8MxG1zN8q8dN3JtfTCHR/dAr+03F8sbGETK+rqid
 wAJmCxeQhvt2ZuXblf9pq0FOs2Zf3JrXkbfMSJV4BggRdiC4btu2WiKmiHBAYBOCEugWIqzjgiv
 eQyZoiclOHaJCUl+2+PEeGQSREjF3MkdwAL/MySEZ9F+jaXVfTFKykyGTGREIeiKZb+zVeg=
X-Received: by 2002:a05:600c:e547:20b0:4a7:4697:dae3 with SMTP id
 5b1f17b1804b1-4a74697dafamr44080445e9.24.1793086030289; 
 Tue, 27 Oct 2026 00:27:10 -0700 (PDT)
X-Received: by 2002:a05:600c:e547:20b0:4a7:4697:dae3 with SMTP id
 5b1f17b1804b1-4a74697dafamr44080145e9.24.1793086029857; 
 Tue, 27 Oct 2026 00:27:09 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a56992dsm234122345e9.6.2026.10.27.00.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 00:27:08 -0700 (PDT)
Message-ID: <c0cf4c97-6d1e-4550-a567-a84ce3ff7b43@redhat.com>
Date: Tue, 27 Oct 2026 08:27:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/9] tests/9p-race: add 9p race test suite (race FID-path
 mutations)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
 <cf0650c4-e6ed-4dda-9b8f-fed5a2762251@redhat.com>
 <97f60010-c6fb-4d21-92fd-754d2c791928@redhat.com>
 <24565308.6Emhk5qWAg@weasel>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <24565308.6Emhk5qWAg@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/2026 17.38, Christian Schoenebeck wrote:
> On Monday, 26 October 2026 10:35:12 CET Thomas Huth wrote:
>> On 26/10/2026 09.44, Thomas Huth wrote:
>>> On 19/10/2026 16.27, Christian Schoenebeck wrote:
>>>> Add a qtest-based stress test suite racing 9pfs server-side state.
>>>>
>>>> This patch adds the first race test "race/fid-path" for this new
>>>> test suite: it races (per round) one Tlcreate (which is mutating
>>>> the FID path) against a number of reader requests (Twalk and
>>>> Txattrwalk) on the same FID.
>>>>
>>>> This very first 9pfs race test guards CVE-2026-93834 (fixed by
>>>> commit fe9e30899f "hw/9pfs: Use read-write lock for protecting fid
>>>> path.").
>>>>
>>>> Hitting the small race window is timing dependant, so this is a
>>>> probabilistic test, not a deterministic one. During my tests the
>>>> (unpatched) vulnerability triggered sometimes after few hundred
>>>> rounds, and sometimes after >100k rounds. Furthermore, it expects
>>>> QEMU being compiled with a sanitizer (e.g. ASan) which is
>>>> supposed to detect the actual race (e.g. by memory violation):
>>>>
>>>>     ../configure --enable-virtfs --enable-debug \
>>>>     --extra-cflags="-fsanitize=address -fno-omit-frame-pointer" \
>>>>     --extra-ldflags="-fsanitize=address" ...
>>>>
>>>> Even though this is a new test suite, in the codebase separate
>>>> from the already existing deterministic 9pfs test cases (while
>>>> 9p test client code being shared between the two test suites),
>>>> this new race test suite is run with the same binary as the
>>>> other qtests. However being a very slow test, it is registered
>>>> as such, so the -m slow argument is required for this race test
>>>> to run (as it is skipped by default):
>>>>
>>>>     ASAN_OPTIONS=detect_leaks=0 \
>>>>     tests/qtest/qos-test -m slow
>>>>
>>>> Or if you only want to run this single race test (e.g. on x86_64):
>>>>
>>>>     ASAN_OPTIONS=detect_leaks=0 \
>>>>     tests/qtest/qos-test -m slow -p \
>>>>     /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/
>>>> virtio-9p-tests/race/fid-path
>>>>
>>>> On other systems, use `tests/qtest/qos-test -l` to get the correct
>>>> (arch dependent) full test name.
>>>>
>>>> `ASAN_OPTIONS=detect_leaks=0` is currently required, it suppresses
>>>> a memory leak error at the end of each race test, which is a known
>>>> QEMU shutdown memory leak, unrelated to 9p server or this race test
>>>> suite. The official QEMU CI pipeline sets
>>>> `ASAN_OPTIONS=detect_leaks=0` by default for this reason.
>>>>
>>>> There are some knobs that can be controlled via environment
>>>> variables:
>>>>
>>>>     V9FS_RACE: skip test suite by setting to 0 or force running by
>>>>                setting to 1
>>>>
>>>>     V9FS_RACE_ROUNDS: total amount of rounds to run
>>>>                       (default: 20000)
>>>>
>>>>     V9FS_RACE_NCONCURRENT: amount of concurrent reader requests
>>>>                            (default: 4)
>>>>
>>>> A full run with 20000 rounds took around 7 minutes on my test
>>>> machine. If you can't hit the (narrow) race window with
>>>> unpatched QEMU, it might help to either add some load on the
>>>> host system and/or turning the two knobs above.
>>>>
>>>> Link: https://lore.kernel.org/qemu-> >> devel/4a0eff0539f16434b48728cd8e5a89f906c293d8.1791368962.git.qemu_oss@cr
>>>> udebyte.com Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>> ---
>>>>    MAINTAINERS                       |   1 +
>>>>    tests/qtest/meson.build           |   1 +
>>>>    tests/qtest/virtio-9p-race-test.c | 575 ++++++++++++++++++++++++++++++
>>>>    3 files changed, 577 insertions(+)
>>>>    create mode 100644 tests/qtest/virtio-9p-race-test.c
>>>>
>>>    Hi Christian!
>>>
>>> Since this has been merged, I'm now seeing timeouts of the qos-test when I
>>> run "make -j8 check-qtest SPEED=thorough" ... can we please fix this
>>> somehow, e.g. by increasing the timeout setting of the qos-test, or by
>>> decreasing the default number of rounds that this test is trying to do?
>>> WDYT?
>> FWIW, when I allow the tests to run longer, these are the current testing
>> times on my machine:
>>
>>    qemu:qtest-arm/qos-test               : 373.06s   167 subtests passed
>>    qemu:qtest-aarch64/qos-test           : 391.52s   148 subtests passed
>>    qemu:qtest-i386/qos-test              : 407.43s   154 subtests passed
>>    qemu:qtest-loongarch64/qos-test       : 405.79s   146 subtests passed
>>    qemu:qtest-ppc64/qos-test             : 407.26s   134 subtests passed
>>    qemu:qtest-x86_64/qos-test            : 393.14s   154 subtests passed
>>    qemu:qtest-riscv32/qos-test           : 767.21s   216 subtests passed
>>    qemu:qtest-riscv64/qos-test           : 684.54s   216 subtests passed
> 
> Right, I missed when you run the thorough/slow tests trough make, then the
> meson wrapped qos-test call is guarded by a timeout, which currently is set to
> 120s for the *entire* qos-test suite (tests/qtest/meson.build), which is fine
> for regular tests, but insufficient for these new slow 9p race tests.
> 
> I thought timeouts were just a thing for the official in-cloud QEMU CI
> pipeline - which doesn't run any slow test at all, so no problem there.
> That was actually the point why I explictly registered these new race tests as
> "slow" ones in the first place.
> 
> This is more of a project management question; should these extremely slow 9p
> race tests either:
> 
> a) be skipped entirely on `make check-qtest SPEED=thorough` or
> b) run shorter (i.e. less rounds, very low probability to hit) or
> c) increase the meson timeout for qos-test binary?
> 
> Personally I don't care too much. These 9p race tests are useful for me, but I
> also understand if other unrelated developers don't want to spend like 10+
> mins on each test run for this. I still run them directly via `tests/qtest/
> qos-test -m slow` ; last line of defense, etc.
> 
> Technically it is easy to address:
> 
> a) -> set envvar V9FS_RACE=0
> b) -> set envvar V9FS_RACE_ROUNDS=n
> c) -> s/'qos-test': 120/'qos-test': n/
> 
> all in tests/qtest/meson.build. Your call.
I think it's maybe best to go with option b), i.e. to (radically) reduce the 
amount of rounds that is run by default. That way the code still gets at 
least a little bit exercised when running all tests in thorough mode, 
without extending the test time too much for everybody.
Could you send a patch, or want me to do it?

  Thomas


