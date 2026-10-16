Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE08CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdbK-00078w-9v; Fri, 16 Oct 2026 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdbE-00078c-TN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:47:38 -0400
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHdbB-0001AX-0r
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:47:35 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.234])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4j5dqP73gWz40ZD;
 Fri, 16 Oct 2026 08:47:29 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 10:47:29 +0200
Message-ID: <94331b70-1c3c-40a8-af10-70bb0c87d197@ovhcloud.com>
Date: Fri, 16 Oct 2026 10:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iotests: Add coverage for NBD connect thread start
 delay
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
 <atFJWVulA_nF13Ht@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <atFJWVulA_nF13Ht@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 16474730391137960231
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF3XI2Vey79yxpeI7Q22EfpcImFW+HSIxkRcHM8ND37zzKr/KSI8h+OzKjya48BYvtdj9pvV8rl9xcC2h/pIeHYvZdNdO08+7EtACF1rS4cR99b59Yr8/qJCKFlWm1tK1CYc3Yrn58DBpjZPtpqxn57cRJYQkXWNg6S1q+hHYV2mb2EOBi8TtdwDxYyyaJ46w7io6NT5PNkqFy0P7CjG4rJaQnSUN8g8hJ8unmL77QpxfpYYaFaUgBSKYxciK0mqgyL3QWe2PiTjMZtO6jj948Kgn2PgCpQdGRVGF0/GBREMFoO5WpG5XaqF3cxiS22UWN2YeLA+njgHCqmneXoqNlIXDqZpnOJiYirCsDki0NlGyEu6n79CL6KhnjxptYyhn+s92AA2aattsv32efXHenbEoOOZvUUF6A93QeD3RWqQAaU91krw3uOy6opZSR6Oq9kKaTSnYURS7ipDZyKJ0bXDBuaz11pxzidApKPBqDD8IUcyTJ+j9xh1lNjRmSaa+/ISG29TI3h8oXRTkHQpumPHp+Id3LxV9SrTWt3inW2j3VmVpXwTyzQ3Bb3UrOYq8aNzKYaZmfeWwa3xdYbjzpRgWtGnSyb2cnvob/BCRTPo0ZK/aKlnP4TAwekLHSlfghNEopD2tx2bW2dcWrnBrqf/cq+g/PtAeLssAlffAuaNw
DKIM-Signature: a=rsa-sha256; bh=J/5aKbGOioV6bp8njAsDeLNwGxhjZYR2h9WboKDMbSw=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1792140450; v=1; 
 b=R5YxcbZnVTIdh+hCwfRwWUwBi++NOr7P9LLIxYCcaAhx6NaUAXshBlxW4g/1VLDRS+qswlZ2
 jHC8Yd6oST3j/1hho2EoN79to4QdDNHduHrCxulQRLdbxyNTW6SYyGyzHM7swZqk/ZGabK4eSxz
 ++icINRpVp/Y9Vh8E6YILsjY=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/15/26 23:46, Eric Blake wrote:
> On Fri, Sep 25, 2026 at 05:53:46PM +0200, Guillaume Vincke wrote:
>> Test the connect thread starting condition with reconnect-delay=0 when
>> the server disconnects after a successful handshake but before running
>> operations. Prior to the change to nbd_co_establish_connection(), this
>> test would demonstrate two I/O errors. The tests 264 and 277 covering
>> reconnection do not use reconnect-delay=0 so this case is not exercised.
>>
>> Add a test that provokes multiple errors in order to put an NBD client
>> in the above-mentioned situation and shows that the first operation
>> starts the connect thread and leads to successful subsequent I/O.
>>
>> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> 
> Guillaume, this is passing for me locally but failing under CI:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17192659287
> 
>> ▶ 137/150 qcow2 nbd-stale-connection                                                  FAIL
>> 137/150 block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-stale-connection          FAIL             2.39s   exit status 1
>>>>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3.12 MALLOC_PERTURB_=65 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 LD_LIBRARY_PATH=/builds/qemu-project/qemu/build/subprojects/libvfio-user/lib RUST_BACKTRACE=1 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /builds/qemu-project/qemu/build/pyvenv/bin/python3.12 /builds/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 nbd-stale-connection --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds/qemu-project/qemu/build/tests/qemu-iotests
>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> WARNING: iotests is being run from outside of the configure-time python virtual environment
>> current python: /builds/qemu-project/qemu/build/pyvenv/bin/python3.12
>> pyvenv python:  /builds/qemu-project/qemu/build/pyvenv/bin/python3
>> Individual python tests will be executed inside the pyvenv,
>> but the test runner will continue to run outside.
>> Please use the meson run script:
>> 	/builds/qemu-project/qemu/build/run /builds/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 nbd-stale-connection --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds/qemu-project/qemu/build/tests/qemu-iotests
>> --- /builds/qemu-project/qemu/tests/qemu-iotests/tests/nbd-stale-connection.out
>> +++ /builds/qemu-project/qemu/build/scratch/qcow2-file-nbd-stale-connection/nbd-stale-connection.out.bad
>> @@ -13,5 +13,5 @@
>>   === NBD server up. Restart the connect thread ===
>>   {"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>>   === Wait for the connect thread to park the new channel. Subsequent operations are successful ===
>> -{"return": {}}
>> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>>   Kill NBD server
>> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> Can you take a look? I'm also playing with it, but I may revert your
> series from my current pull request if it takes too long to get to
> root cause.

The failure comes from the parking step. I reproduced the exact CI diff
locally by shortening the test's wait for the parked channel to a value
around 950ms. The test only leaves 500ms for the reconnection which
appears to be too small on CI.

Starting the connect thread after the NBD server is up removes the
dependency on the 1s retry, so the wait only has to cover the
connection itself. That allows raising it to 1s while keeping the same
test duration. The test still fails without patch 1.

I have sent a v2 with that change:
https://lore.kernel.org/qemu-devel/20261016084136.233836-1-guillaume.vincke@ovhcloud.com

> 
> 


