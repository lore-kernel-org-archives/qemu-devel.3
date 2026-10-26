Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94090606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=HbhseeL5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNj1-00087y-M5; Mon, 26 Oct 2026 12:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xLNiy-00086c-H0; Mon, 26 Oct 2026 12:39:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1xLNiw-00027y-HR; Mon, 26 Oct 2026 12:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=hF47tVBhb2pH+Ul7GPt4CqRpe5mMUx+wEYNreQ/UmYM=; b=HbhseeL5CqtoNyzKbdczsR+6KZ
 32V/m1CgKx6VqHJDoak18JGLv3vYXdH6xIpYmc57hWykZrHlCNmW+lGwdPA+EQ/ZGtohGnE50SvFM
 VfzXDhvf+DyIMxuOWEpchIsLoik2JmJ5r7ScM7jYaMigUX+OweFZnXtyeK6dLDKO2zooSi8mnzFRP
 1XGic3IYdzupsSTj8mZm9oj7knxp4C5ORV0gRDpy5w+8fWwM6i2SA4UrmbrY3zCLfDDyCVTR7Zm2E
 moNyx7UZCzspll5EWoePs2icGKpqahtplSgBhSeh5NbarZrrP2a5kzatWW1MLcFfmkPyiGBCBMEaA
 XIbOzxAovafmYG23h2vxr+D8Xn/0EvSHVP+D7y4LV6uFoVkxsTOdRQ+HiRfC11jqtoYU2Q+c9bsra
 peULMtS6xlKDra0Vu7ycUiRm3ov17VYpLA8UeXA2n/Pu05QAuV6MfCfgIcRvSmm7C5VWn7jP6f5aF
 EwafzglvkHp1p5oLYL6hLDHqNZCXCpPH5YWfGzUxJupctrMO05eg+7Wx5aJFpFzWkDGXEmy5vObZL
 eLCGbgMAjjIaPlKdvfbgOPZerkXIj4teSDXIN7CF12ZQsfWWof0u5c0sG5bvMG3Ew4yQC7k/A5iG0
 8wHyyvYMU0NW2CzLIljYPDCJRfhzS/aT1jDzRkSts=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Subject: Re: [PULL 2/9] tests/9p-race: add 9p race test suite (race FID-path
 mutations)
Date: Mon, 26 Oct 2026 17:38:58 +0100
Message-ID: <24565308.6Emhk5qWAg@weasel>
In-Reply-To: <97f60010-c6fb-4d21-92fd-754d2c791928@redhat.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
 <cf0650c4-e6ed-4dda-9b8f-fed5a2762251@redhat.com>
 <97f60010-c6fb-4d21-92fd-754d2c791928@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, 26 October 2026 10:35:12 CET Thomas Huth wrote:
> On 26/10/2026 09.44, Thomas Huth wrote:
> > On 19/10/2026 16.27, Christian Schoenebeck wrote:
> >> Add a qtest-based stress test suite racing 9pfs server-side state.
> >> 
> >> This patch adds the first race test "race/fid-path" for this new
> >> test suite: it races (per round) one Tlcreate (which is mutating
> >> the FID path) against a number of reader requests (Twalk and
> >> Txattrwalk) on the same FID.
> >> 
> >> This very first 9pfs race test guards CVE-2026-93834 (fixed by
> >> commit fe9e30899f "hw/9pfs: Use read-write lock for protecting fid
> >> path.").
> >> 
> >> Hitting the small race window is timing dependant, so this is a
> >> probabilistic test, not a deterministic one. During my tests the
> >> (unpatched) vulnerability triggered sometimes after few hundred
> >> rounds, and sometimes after >100k rounds. Furthermore, it expects
> >> QEMU being compiled with a sanitizer (e.g. ASan) which is
> >> supposed to detect the actual race (e.g. by memory violation):
> >> 
> >>    ../configure --enable-virtfs --enable-debug \
> >>    --extra-cflags="-fsanitize=address -fno-omit-frame-pointer" \
> >>    --extra-ldflags="-fsanitize=address" ...
> >> 
> >> Even though this is a new test suite, in the codebase separate
> >> from the already existing deterministic 9pfs test cases (while
> >> 9p test client code being shared between the two test suites),
> >> this new race test suite is run with the same binary as the
> >> other qtests. However being a very slow test, it is registered
> >> as such, so the -m slow argument is required for this race test
> >> to run (as it is skipped by default):
> >> 
> >>    ASAN_OPTIONS=detect_leaks=0 \
> >>    tests/qtest/qos-test -m slow
> >> 
> >> Or if you only want to run this single race test (e.g. on x86_64):
> >> 
> >>    ASAN_OPTIONS=detect_leaks=0 \
> >>    tests/qtest/qos-test -m slow -p \
> >>    /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/
> >> virtio-9p-tests/race/fid-path
> >> 
> >> On other systems, use `tests/qtest/qos-test -l` to get the correct
> >> (arch dependent) full test name.
> >> 
> >> `ASAN_OPTIONS=detect_leaks=0` is currently required, it suppresses
> >> a memory leak error at the end of each race test, which is a known
> >> QEMU shutdown memory leak, unrelated to 9p server or this race test
> >> suite. The official QEMU CI pipeline sets
> >> `ASAN_OPTIONS=detect_leaks=0` by default for this reason.
> >> 
> >> There are some knobs that can be controlled via environment
> >> variables:
> >> 
> >>    V9FS_RACE: skip test suite by setting to 0 or force running by
> >>               setting to 1
> >> 
> >>    V9FS_RACE_ROUNDS: total amount of rounds to run
> >>                      (default: 20000)
> >> 
> >>    V9FS_RACE_NCONCURRENT: amount of concurrent reader requests
> >>                           (default: 4)
> >> 
> >> A full run with 20000 rounds took around 7 minutes on my test
> >> machine. If you can't hit the (narrow) race window with
> >> unpatched QEMU, it might help to either add some load on the
> >> host system and/or turning the two knobs above.
> >> 
> >> Link: https://lore.kernel.org/qemu-> >> devel/4a0eff0539f16434b48728cd8e5a89f906c293d8.1791368962.git.qemu_oss@cr
> >> udebyte.com Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >> ---
> >>   MAINTAINERS                       |   1 +
> >>   tests/qtest/meson.build           |   1 +
> >>   tests/qtest/virtio-9p-race-test.c | 575 ++++++++++++++++++++++++++++++
> >>   3 files changed, 577 insertions(+)
> >>   create mode 100644 tests/qtest/virtio-9p-race-test.c
> >> 
> >   Hi Christian!
> > 
> > Since this has been merged, I'm now seeing timeouts of the qos-test when I
> > run "make -j8 check-qtest SPEED=thorough" ... can we please fix this
> > somehow, e.g. by increasing the timeout setting of the qos-test, or by
> > decreasing the default number of rounds that this test is trying to do?
> > WDYT?
> FWIW, when I allow the tests to run longer, these are the current testing
> times on my machine:
> 
>   qemu:qtest-arm/qos-test               : 373.06s   167 subtests passed
>   qemu:qtest-aarch64/qos-test           : 391.52s   148 subtests passed
>   qemu:qtest-i386/qos-test              : 407.43s   154 subtests passed
>   qemu:qtest-loongarch64/qos-test       : 405.79s   146 subtests passed
>   qemu:qtest-ppc64/qos-test             : 407.26s   134 subtests passed
>   qemu:qtest-x86_64/qos-test            : 393.14s   154 subtests passed
>   qemu:qtest-riscv32/qos-test           : 767.21s   216 subtests passed
>   qemu:qtest-riscv64/qos-test           : 684.54s   216 subtests passed

Right, I missed when you run the thorough/slow tests trough make, then the 
meson wrapped qos-test call is guarded by a timeout, which currently is set to 
120s for the *entire* qos-test suite (tests/qtest/meson.build), which is fine 
for regular tests, but insufficient for these new slow 9p race tests.

I thought timeouts were just a thing for the official in-cloud QEMU CI 
pipeline - which doesn't run any slow test at all, so no problem there.
That was actually the point why I explictly registered these new race tests as 
"slow" ones in the first place.

This is more of a project management question; should these extremely slow 9p 
race tests either:

a) be skipped entirely on `make check-qtest SPEED=thorough` or
b) run shorter (i.e. less rounds, very low probability to hit) or
c) increase the meson timeout for qos-test binary?

Personally I don't care too much. These 9p race tests are useful for me, but I 
also understand if other unrelated developers don't want to spend like 10+ 
mins on each test run for this. I still run them directly via `tests/qtest/
qos-test -m slow` ; last line of defense, etc.

Technically it is easy to address:

a) -> set envvar V9FS_RACE=0
b) -> set envvar V9FS_RACE_ROUNDS=n
c) -> s/'qos-test': 120/'qos-test': n/

all in tests/qtest/meson.build. Your call.

/Christian



