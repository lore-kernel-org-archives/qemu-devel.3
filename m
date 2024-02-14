Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDFCC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFmW-00023T-OC; Wed, 14 Feb 2024 08:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1raFmV-00023H-J0; Wed, 14 Feb 2024 08:58:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1raFmS-0005s8-Ou; Wed, 14 Feb 2024 08:58:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFAFB4D443;
 Wed, 14 Feb 2024 16:58:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 681597ED9F;
 Wed, 14 Feb 2024 16:58:25 +0300 (MSK)
Content-Type: multipart/mixed; boundary="------------M7tiwF4vTLzjnayFGLraha2u"
Message-ID: <d3c4506f-0dbd-4171-944d-0aeb040153ad@tls.msk.ru>
Date: Wed, 14 Feb 2024 16:58:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/34] migration/multifd: Join the TLS thread
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20240208030528.368214-1-peterx@redhat.com>
 <20240208030528.368214-27-peterx@redhat.com>
 <d60ddc11-b4b4-4fee-b9c0-08bea513f8d3@tls.msk.ru>
 <0e5720f4-63c1-4f71-ab6b-26c07614ba33@tls.msk.ru> <8734tvqipk.fsf@suse.de>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <8734tvqipk.fsf@suse.de>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------M7tiwF4vTLzjnayFGLraha2u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.02.2024 16:27, Fabiano Rosas :
> Michael Tokarev <mjt@tls.msk.ru> writes:
..>>> This change, which is suggested for -stable, while simple by its own, seems
>>> to depend on the previous changes in this series, which are not for -stable.
>>> In particular, whole "Finally recycle all the threads" loop in multifd_send_terminate_threads()
>>> (to which the join is being added by this change) is moved from elsewhere by
>>> 12808db3b8 "migration/multifd: Cleanup multifd_save_cleanup()" (patch 24 in
>>> this same series).
>>>
>> We can probably add the missing join right into the previous location of this
>> loop (before 12808db3b8).  I did this in the attached variant for 8.2, is
>> this correct?

I forgot to attach the patch.  It just moves the join from multifd_send_terminate_threads()
back to multifd_save_cleanup.  Attached now.

> It should work. This was originally developed without the rest of the
> changes on this PR.
> 
>> And this does not pass even the basic tests, so it's not that simple :)
> 
> Do you have a log of what failed?

Re-running it again...  I haven't even tried to push it somewhere for CI to run,
I run local `ninja test', which painted some migration tests in red.  Here:

202/844 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test   ERROR   70.26s   killed by signal 6 SIGABRT
330/844 qemu:qtest+qtest-i386 / qtest-i386/migration-test         ERROR   85.33s   killed by signal 6 SIGABRT
454/844 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test     ERROR  101.02s   killed by signal 6 SIGABRT

Unfortunately I don't see anything interesting in the log:

# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-463614.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-463614.qmp,id=char0 
-mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-8.2, -name target,debug-threads=on -m 150M -serial 
file:/tmp/migration-test-SPJTI2/dest_serial -incoming defer -drive if=none,id=d0,file=/tmp/migration-test-SPJTI2/bootsect,format=raw -device 
ide-hd,drive=d0,secs=1,cyls=1,heads=1    2>/dev/null -accel qtest
----------------------------------- stderr -----------------------------------
../../build/qemu/8.2/tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from signal 6 (Aborted)
(test program exited with status code -6)

Without the attached patch it works.

> Anyway, I could prepare a backport on top of 8.2 for you.

Well, that would definitely be helpful, if you think it's worth to
provide backports for 8.2 for these.   As my attempt apparently isn't
very successful :)

>> The following patch (27/34) is more questionable than this one.

Thank you!

/mjt

--------------M7tiwF4vTLzjnayFGLraha2u
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-migration-multifd-Join-the-TLS-thread.patch"
Content-Disposition: attachment;
 filename="0001-migration-multifd-Join-the-TLS-thread.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZDRhYWU4NGEwNmZjN2UyNmRjYjFkOTg2YTRkZTNjNmQ2NWViMDY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpYW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGU+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxODo1MToxMyAtMDMwMApTdWJqZWN0OiBbUEFUQ0hd
IG1pZ3JhdGlvbi9tdWx0aWZkOiBKb2luIHRoZSBUTFMgdGhyZWFkCgpXZSdyZSBjdXJyZW50
bHkgbGVha2luZyB0aGUgcmVzb3VyY2VzIG9mIHRoZSBUTFMgdGhyZWFkIGJ5IG5vdCBqb2lu
aW5nCml0IGFuZCBhbHNvIG92ZXJ3cml0aW5nIHRoZSBwLT50aHJlYWQgcG9pbnRlciBhbHRv
Z2V0aGVyLgoKRml4ZXM6IGExYWY2MDViZDUgKCJtaWdyYXRpb24vbXVsdGlmZDogZml4IGhh
bmd1cCB3aXRoIFRMUy1NdWx0aWZkIGR1ZSB0byBibG9ja2luZyBoYW5kc2hha2UiKQpDYzog
cWVtdS1zdGFibGUgPHFlbXUtc3RhYmxlQG5vbmdudS5vcmc+ClJldmlld2VkLWJ5OiBQZXRl
ciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IEZhYmlhbm8gUm9zYXMg
PGZhcm9zYXNAc3VzZS5kZT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0
MDIwNjIxNTExOC42MTcxLTItZmFyb3Nhc0BzdXNlLmRlClNpZ25lZC1vZmYtYnk6IFBldGVy
IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4KKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgZTE5
MjFmMTBkOWFmZTY1MWY0ODg3Mjg0ZTg1ZjY3ODliMzdlNjdkMykKU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4KKE1qdDogZml4dXAgZm9yIGJlZm9y
ZSB2OC4yLjAtMTE0Mi1nMTI4MDhkYjNiOAogIm1pZ3JhdGlvbi9tdWx0aWZkOiBDbGVhbnVw
IG11bHRpZmRfc2F2ZV9jbGVhbnVwKCkiKQotLS0KIG1pZ3JhdGlvbi9tdWx0aWZkLmMgfCA4
ICsrKysrKystCiBtaWdyYXRpb24vbXVsdGlmZC5oIHwgMiArKwogMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9taWdyYXRp
b24vbXVsdGlmZC5jIGIvbWlncmF0aW9uL211bHRpZmQuYwppbmRleCA0MDk0NjA2ODRmLi4z
MTgzYWE5ZTgyIDEwMDY0NAotLS0gYS9taWdyYXRpb24vbXVsdGlmZC5jCisrKyBiL21pZ3Jh
dGlvbi9tdWx0aWZkLmMKQEAgLTUyNSw2ICs1MjUsMTAgQEAgdm9pZCBtdWx0aWZkX3NhdmVf
Y2xlYW51cCh2b2lkKQogICAgIGZvciAoaSA9IDA7IGkgPCBtaWdyYXRlX211bHRpZmRfY2hh
bm5lbHMoKTsgaSsrKSB7CiAgICAgICAgIE11bHRpRkRTZW5kUGFyYW1zICpwID0gJm11bHRp
ZmRfc2VuZF9zdGF0ZS0+cGFyYW1zW2ldOwogCisgICAgICAgIGlmIChwLT50bHNfdGhyZWFk
X2NyZWF0ZWQpIHsKKyAgICAgICAgICAgIHFlbXVfdGhyZWFkX2pvaW4oJnAtPnRsc190aHJl
YWQpOworICAgICAgICB9CisKICAgICAgICAgaWYgKHAtPnJ1bm5pbmcpIHsKICAgICAgICAg
ICAgIHFlbXVfdGhyZWFkX2pvaW4oJnAtPnRocmVhZCk7CiAgICAgICAgIH0KQEAgLTgyNiw3
ICs4MzAsOSBAQCBzdGF0aWMgYm9vbCBtdWx0aWZkX3Rsc19jaGFubmVsX2Nvbm5lY3QoTXVs
dGlGRFNlbmRQYXJhbXMgKnAsCiAgICAgdHJhY2VfbXVsdGlmZF90bHNfb3V0Z29pbmdfaGFu
ZHNoYWtlX3N0YXJ0KGlvYywgdGlvYywgaG9zdG5hbWUpOwogICAgIHFpb19jaGFubmVsX3Nl
dF9uYW1lKFFJT19DSEFOTkVMKHRpb2MpLCAibXVsdGlmZC10bHMtb3V0Z29pbmciKTsKICAg
ICBwLT5jID0gUUlPX0NIQU5ORUwodGlvYyk7Ci0gICAgcWVtdV90aHJlYWRfY3JlYXRlKCZw
LT50aHJlYWQsICJtdWx0aWZkLXRscy1oYW5kc2hha2Utd29ya2VyIiwKKworICAgIHAtPnRs
c190aHJlYWRfY3JlYXRlZCA9IHRydWU7CisgICAgcWVtdV90aHJlYWRfY3JlYXRlKCZwLT50
bHNfdGhyZWFkLCAibXVsdGlmZC10bHMtaGFuZHNoYWtlLXdvcmtlciIsCiAgICAgICAgICAg
ICAgICAgICAgICAgIG11bHRpZmRfdGxzX2hhbmRzaGFrZV90aHJlYWQsIHAsCiAgICAgICAg
ICAgICAgICAgICAgICAgIFFFTVVfVEhSRUFEX0pPSU5BQkxFKTsKICAgICByZXR1cm4gdHJ1
ZTsKZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9tdWx0aWZkLmggYi9taWdyYXRpb24vbXVsdGlm
ZC5oCmluZGV4IGE4MzU2NDNiNDguLjhmYmZmYmFhNWEgMTAwNjQ0Ci0tLSBhL21pZ3JhdGlv
bi9tdWx0aWZkLmgKKysrIGIvbWlncmF0aW9uL211bHRpZmQuaApAQCAtNzUsNiArNzUsOCBA
QCB0eXBlZGVmIHN0cnVjdCB7CiAgICAgY2hhciAqbmFtZTsKICAgICAvKiBjaGFubmVsIHRo
cmVhZCBpZCAqLwogICAgIFFlbXVUaHJlYWQgdGhyZWFkOworICAgIFFlbXVUaHJlYWQgdGxz
X3RocmVhZDsKKyAgICBib29sIHRsc190aHJlYWRfY3JlYXRlZDsKICAgICAvKiBjb21tdW5p
Y2F0aW9uIGNoYW5uZWwgKi8KICAgICBRSU9DaGFubmVsICpjOwogICAgIC8qIGlzIHRoZSB5
YW5rIGZ1bmN0aW9uIHJlZ2lzdGVyZWQgKi8KLS0gCjIuMzkuMgoK

--------------M7tiwF4vTLzjnayFGLraha2u--

