Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA49CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjfD-000744-DY; Fri, 16 Oct 2026 11:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHjf4-00072t-IB; Fri, 16 Oct 2026 11:15:59 -0400
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xHjf1-00042s-E8; Fri, 16 Oct 2026 11:15:57 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.109.231.104])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4j5pRW1Tjzz7tDG;
 Fri, 16 Oct 2026 15:15:51 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 17:15:50 +0200
Message-ID: <6619cd60-3ead-4d6f-af38-b33a080c5810@ovhcloud.com>
Date: Fri, 16 Oct 2026 17:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iotests: Add coverage for NBD connect thread start
 delay
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20261016084136.233836-1-guillaume.vincke@ovhcloud.com>
 <20261016084136.233836-3-guillaume.vincke@ovhcloud.com>
 <atIvl0e9VddTigCO@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <atIvl0e9VddTigCO@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 4586634746325385511
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFNzxSLqpsXtmqO0t7Usga9piPM7NVieJQwPEC/gzZ/QmrEwINQY0QB+UCqLq7gtMINfessPw0ccNQtiD7tf4ErHiKO7MuJxq3y63GLk3KirrdVdWQ8jhwMT3YS95FoOy6DmF8BAGxp5F393FkLWyS/m2L/WfZ7Cf4DiyXUn42OvgtSxmyrAEcfH55XWdM8jctLIBQYqKCufYkOpCxrr0JB/KjTaIhPeumQwmm0Evi5zcg+MWOw61EBMhEaYVVmfeDIeQgKSHzl/pURAjwITB60j6bkAPeyCgCLWCwRXjUwkzfE5AdC2rdxeo6zJqhW3RDEEgk9SmbMvqyPKTzEybUGAadTlw/BQ3Us3cgkLtZvdye+pFuYyeYgy/zqKMCyBoG1ecCYPK7CEPuuvaw9sz5MI6kBtV/22SMZv4w/Ish28LNhVWjJLgPorzffUyM2KkG9Y13j1eWtQJSsA4vKz6EaY1WwosUFJ6USxJomurAC5N4aCeCAE1aBGZM4tMRMoqYidJTs+JoVN7dMteOh5IjaTZzhDvARuAGjh2imMktDCwaMrJ60MYVKvtB9acdbdgjIhZ/q7Tt2JDL09nic9bwH35EqM0nPg19Att3dnyFlQyqZbUzGHyTh6iGXDbWPGzjDZqEBFLbRV6FfN1XLDGsBbqayouvh7AWhi2VC4wG2Hw
DKIM-Signature: a=rsa-sha256; bh=nDlt8+KZ3FbWuvzXaaCq7Qo2CKKkY9bxIiuEHwrvUm8=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1792163751; v=1; 
 b=MoNqzBiu7A7LOfzkE90Qqyy7Kmaf+1SOffWcS5QSspTDoA6EfVFi48B2Pzy6jzOQwdj3vK3K
 aTrob8XYT+2sYO+QD2uHRziUrOxlEtRGQne9qFqP/xtY8jzUHuTFcwIhy1rdpyMaqf+rWMXd7EU
 xeCRlEI4JiHL9Extz6SC9luA=
Received-SPF: pass client-ip=5.135.90.177;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo508.mail-out.ovh.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/16/26 16:13, Eric Blake wrote:
> On Fri, Oct 16, 2026 at 10:41:36AM +0200, Guillaume Vincke wrote:
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
>> ---
>>   tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
>>   .../tests/nbd-stale-connection.out            | 17 ++++++
>>   2 files changed, 77 insertions(+)
>>   create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
>>   create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out
> 
>> +
>> +# estimated duration required by the connect thread to reach a running server
>> +MAX_NBD_CONNECT_DURATION = 1
>> +
> 
>> +
>> +    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
>> +        iotests.log('=== NBD server up. Wait for the connect thread to park '
>> +                    'the channel ===')
>> +        # in CONNECTING, the operation starts the connect thread
>> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
>> +        # wait for the connect thread to get a new channel and stop
>> +        time.sleep(MAX_NBD_CONNECT_DURATION)
> 
> Timeout-based tests are always risky for false negatives when the CI
> system has more load than the development system.  But comparing this
> version of the patch to v1, it looks like you managed to get much more
> reliable witness points.  I'll be running this through testing on my
> own branch of gitlab several times to see if I can tease out any more
> failures, but hopefully it is ready to use. I'll reply again once I've
> made a decision on whether to include it in my current pull request or
> defer it to my next batch of patches.
> 

Thanks. I agree that sleeping does not make the test very
deterministic. I have another series in preparation that relies on the
same kind of waiting, so I'd like to replace that.
I did not find a proper way to determine the NBD client connection
state. If you know one, let me know and I'd be happy to use it.

>> +
>> +    iotests.log('=== NBD server down. The parked channel is closed ===')
>> +
>> +    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
>> +        iotests.log('=== NBD server up. Restart the connect thread ===')
>> +        # operation will determine that the channel got closed and restart the
>> +        # connect thread
>> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
>> +        # Wait for it to succeed
>> +        iotests.log('=== Wait for the connect thread to park the new channel. '
>> +                    'Subsequent operations are successful ===')
>> +        time.sleep(MAX_NBD_CONNECT_DURATION)
>> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
>> diff --git a/tests/qemu-iotests/tests/nbd-stale-connection.out b/tests/qemu-iotests/tests/nbd-stale-connection.out
>> new file mode 100644
>> index 0000000000..065ba329e9
>> --- /dev/null
>> +++ b/tests/qemu-iotests/tests/nbd-stale-connection.out
>> @@ -0,0 +1,17 @@
>> +Start NBD server
>> +=== NBD Device connected ===
>> +{"return": {}}
>> +Kill NBD server
>> +=== NBD server down. Detect the break and start the connect thread ===
>> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>> +Start NBD server
>> +=== NBD server up. Wait for the connect thread to park the channel ===
>> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>> +Kill NBD server
>> +=== NBD server down. The parked channel is closed ===
>> +Start NBD server
>> +=== NBD server up. Restart the connect thread ===
>> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
>> +=== Wait for the connect thread to park the new channel. Subsequent operations are successful ===
>> +{"return": {}}
>> +Kill NBD server
>> -- 
>> 2.43.0
>>
> 


