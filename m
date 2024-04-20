Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F992C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 20:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryHHN-0006S5-TO; Sat, 20 Apr 2024 16:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1ryHH4-0006Pa-Rj
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 16:25:29 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1ryHH1-0005K5-0k
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 16:25:25 -0400
Received: from [192.168.178.59] (p5b151e52.dip0.t-ipconnect.de [91.21.30.82])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id CD626DA0C18;
 Sat, 20 Apr 2024 22:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim;
 t=1713644718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CHRjOFzroHE1fwaFVLCDJPiqoi5GbkGSATHcvcPwUQ0=;
 b=YDBho6XzJntxIoBq/mVlZDzVUX7GBKabHIAstBzlR5ZEP2OW4MXSUvJtOU3NfHbrvAkVH8
 QmghoCEh032zC8Zbu0KffT6p+LNjT4A+l1CtEJlQL3hHUxd8dCDOQevuINy1UAEKuOnzjq
 Mznwym74Zov6QMlngDFZrCisxnKGreYBDv4DzV+nAUN1a8YoM3ojbboENiJcxenizBV/9i
 L+fu8Xl+7NPjsNUmVWGcffrlFUIh89eBNeJ6RuYf1OzGEKc0JOyOKHRcJOmQB9ZgWH2uLR
 ab4AkmAjFvxGxUSnOHAiEFW+b+kzHHBKTQIGebbQxgPX9CGr8dHM6SBbBuKEaQ==
Message-ID: <9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de>
Date: Sat, 20 Apr 2024 22:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cross-i686-tci CI job is flaky again (timeouts): can somebody who
 cares about TCI investigate?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA92aivDF-LjSrtZH6o4UtgrtcWnM2wuPZA5VOiN6j7KMA@mail.gmail.com>
 <f5926850-670b-43fa-8011-c33ba45d8fc3@weilnetz.de>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <f5926850-670b-43fa-8011-c33ba45d8fc3@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 16.04.24 um 14:17 schrieb Stefan Weil:
> Am 16.04.24 um 14:10 schrieb Peter Maydell:
> 
>> The cross-i686-tci job is flaky again, with persistent intermittent
>> failures due to jobs timing out.
> [...]
>> Some of these timeouts are very high -- no test should be taking
>> 10 minutes, even given TCI and a slowish CI runner -- which suggests
>> to me that there's some kind of intermittent deadlock going on.
>>
>> Can somebody who cares about TCI investigate, please, and track
>> down whatever this is?
> 
> I'll have a look.

Short summary:

The "persistent intermittent failures due to jobs timing out" are not 
related to TCI: they also occur if the same tests are run with the 
normal TCG. I suggest that the CI tests should run single threaded.

But let's have a look on details of my results.

I have run `time make test` using different scenarios on the rather old 
and not so performant VM which I typically use for QEMU builds. I did 
not restrict the tests to selected architectures like it is done in the 
QEMU CI tests. Therefore I had more tests which all ended successfully:

Ok:                 848
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            68
Timeout:            0

---

1st test with normal TCG

`nohup time ../configure --enable-modules --disable-werror && nohup time 
make -j4 && nohup time make test`
[...]
Full log written to 
/home/stefan/src/gitlab/qemu-project/qemu/bin/ndebug/x86_64-linux-gnu/meson-logs/testlog.txt
2296.08user 1525.02system 21:49.78elapsed 291%CPU (0avgtext+0avgdata 
633476maxresident)k
1730448inputs+14140528outputs (11668major+56827263minor)pagefaults 0swaps

---

2nd test with TCI

`nohup time ../configure --enable-modules --disable-werror 
--enable-tcg-interpreter && nohup time make -j4 && nohup time make test`
[...]
Full log written to 
/home/stefan/src/gitlab/qemu-project/qemu/bin/ndebug/x86_64-linux-gnu/meson-logs/testlog.txt
3766.74user 1521.38system 26:50.51elapsed 328%CPU (0avgtext+0avgdata 
633012maxresident)k
32768inputs+14145080outputs (3033major+56121586minor)pagefaults 0swaps

---

So the total test time with TCI was 26:50.51 minutes while for the 
normal test it was 21:49.78 minutes.

These 10 single tests had the longest duration:

1st test with normal TCG

   94/916 qtest-arm / qtest-arm/qom-test                 373.41s
   99/916 qtest-aarch64 / qtest-aarch64/qom-test         398.43s
100/916 qtest-i386 / qtest-i386/bios-tables-test       188.06s
103/916 qtest-x86_64 / qtest-x86_64/bios-tables-test   228.33s
106/916 qtest-aarch64 / qtest-aarch64/migration-test   201.15s
119/916 qtest-i386 / qtest-i386/migration-test         253.58s
126/916 qtest-x86_64 / qtest-x86_64/migration-test     266.66s
143/916 qtest-arm / qtest-arm/test-hmp                 101.72s
144/916 qtest-aarch64 / qtest-aarch64/test-hmp         113.10s
163/916 qtest-arm / qtest-arm/aspeed_smc-test          256.92s

2nd test with TCI

   68/916 qtest-arm / qtest-arm/qom-test                 375.35s
   82/916 qtest-aarch64 / qtest-aarch64/qom-test         403.50s
   93/916 qtest-i386 / qtest-i386/bios-tables-test       192.22s
   99/916 qtest-aarch64 / qtest-aarch64/bios-tables-test 379.92s
100/916 qtest-x86_64 / qtest-x86_64/bios-tables-test   240.19s
103/916 qtest-aarch64 / qtest-aarch64/migration-test   223.49s
106/916 qtest-ppc64 / qtest-ppc64/pxe-test             418.42s
113/916 qtest-i386 / qtest-i386/migration-test         284.96s
118/916 qtest-arm / qtest-arm/aspeed_smc-test          271.10s
119/916 qtest-x86_64 / qtest-x86_64/migration-test     287.36s

---

Summary:

TCI is not much slower than the normal TCG. Surprisingly it was even 
faster for the tests 99 and 103. For other tests like test 106 TCI was 
about half as fast as normal TCG, but in summary it is not "factors" 
slower. A total test time of 26:50 minutes is also not so bad compared 
with the 21:49 minutes of the normal TCG.

No single test (including subtests) with TCI exceeded 10 minutes, the 
longest one was well below that margin with 418 seconds.

---

The tests above were running with x86_64, and I could not reproduce 
timeouts. The Gitlab CI tests were running with i686 and used different 
configure options. Therefore I made additional tests with 32 bit builds 
in a chroot environment (Debian GNU Linux bullseye i386) with the 
original configure options. As expected that reduced the number of tests 
to 250. All tests passed with `make test`:

3rd test with normal TCG

Ok:                 250
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            8
Timeout:            0

Full log written to 
/root/qemu/bin/ndebug/i586-linux-gnu/meson-logs/testlog.txt
855.30user 450.53system 6:45.57elapsed 321%CPU (0avgtext+0avgdata 
609180maxresident)k
28232inputs+4772968outputs (64944major+8328814minor)pagefaults 0swaps


4th test with TCI

Ok:                 250
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            8
Timeout:            0

Full log written to /root/qemu/build/meson-logs/testlog.txt
make[1]: Leaving directory '/root/qemu/build'
1401.64user 483.55system 9:03.25elapsed 347%CPU (0avgtext+0avgdata 
609244maxresident)k
24inputs+4690040outputs (70405major+7972385minor)pagefaults 0swaps

---

Summary:

Again TCI is not much slower than the normal TCG. The total test time 
for all 250 tests is below 10 minutes, even with TCI!

---

Could it be that the timeouts in Gitlab CI are caused by wrongly 
configured multithreading? Those tests are not started with `make test` 
which would run single threaded, but with meson and an argument 
`--num-processes 9`. I tested that with the normal TCG on my VM which 
only can run 4 threads simultaneously:

5th test with TCG

pyvenv/bin/meson test  --no-rebuild -t 1  --num-processes 9 
--print-errorlogs
Summary of Failures:

254/258 qemu:softfloat+softfloat-ops / fp-test-mul 
   TIMEOUT         30.12s   killed by signal 15 SIGTERM

Ok:                 249
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            8
Timeout:            1

Full log written to 
/root/qemu/bin/ndebug/i586-linux-gnu/meson-logs/testlog.txt

Repeating that test again fails, this time with 2 timeouts:

time pyvenv/bin/meson test  --no-rebuild -t 1  --num-processes 9 
--print-errorlogs
Summary of Failures:

253/258 qemu:softfloat+softfloat-ops / fp-test-mul 
   TIMEOUT         30.14s   killed by signal 15 SIGTERM
254/258 qemu:softfloat+softfloat-ops / fp-test-div 
   TIMEOUT         30.18s   killed by signal 15 SIGTERM

Ok:                 248
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            8
Timeout:            2

Full log written to 
/root/qemu/bin/ndebug/i586-linux-gnu/meson-logs/testlog.txt

real	7m51.102s
user	14m0.470s
sys	7m58.427s

Now I reduced the number of threads to 4:

time pyvenv/bin/meson test  --no-rebuild -t 1  --num-processes 4 
--print-errorlogs
Ok:                 250
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            8
Timeout:            0

Full log written to 
/root/qemu/bin/ndebug/i586-linux-gnu/meson-logs/testlog.txt

real	6m42.648s
user	13m52.271s
sys	7m35.643s

---

Summary:

I could reproduce persistent intermittent failures due to jobs timing 
out without TCI when I tried to run the tests with more threads than my 
machine supports. This result is expected because not all single tests 
can not run 100% of the time. They are interrupted because of 
scheduling, and it's normal that some (random) tests will have a longer 
duration. Some will even raise a timeout.

The final test shows that adjusting the number of threads to the hosts 
capabilities fixes the problem. But it also shows that 4 threads don't 
accelerate the whole test job compared to a single thread. Using 
multithreading obviously wastes a lot of user and sys CPU time.

Regards
Stefan

