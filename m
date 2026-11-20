Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=ddJNDlS5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULh0-0007Iy-BV; Fri, 20 Nov 2026 05:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULgx-0007IZ-Sb
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:18:04 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULgv-00050m-US
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:18:03 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.254.31])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jWB9f6vMHz3wlX;
 Fri, 20 Nov 2026 10:17:58 +0000 (UTC)
Received: from [10.46.51.33] (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:17:58 +0100
Message-ID: <88682d3c-4558-4476-8e0c-98eb9a5b3cd4@ovhcloud.com>
Date: Fri, 20 Nov 2026 11:17:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iotests: Add coverage for NBD resize
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
 <vsementsov@yandex-team.ru>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <stefanha@redhat.com>, <fam@euphon.net>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-5-guillaume.vincke@ovhcloud.com>
 <av98gYPX3Wsoiq7N@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <av98gYPX3Wsoiq7N@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 2186216145230447069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE/hR4A0vyRHqlOtw0z5l4eZd3AOCw6m/piKftbB1168Fkn6Z3rGjM8CdBaeqnOuGcV0hX4O6sMd9ImLeWXg9UWAvjC0J/9RFIu5h+0ExRvMfwcGTs6f6M9GWCh9FH4ZTzQ3E3s5/ZgwuoZnxL9U0U3u7l9MbblR1dL/HsNpoReGFe7LuU2WaHafBwjTBgzmwj0WoISiEC0WrAzGNTYZBv6uw2c1ddNFODDhdkB8RUxALXB3DYrWibzDKvWmOYO0byg8dE54oVmnwq64n4RZsSfPwBwxHCdlPVeSlOOc5T4p5HpoYfm7MnINBMedEbWZXUw/UVZyBpEDX8gTpC0o/pvhOVnxoQWEqBrEb9mSgYyDbmxkHIcdeotB79kk4Gu7DbVkM6I2udG4bBN3dME0x8UJXdStM/4mD3FzsqEzdRGBoXq1wiPTRgDCRBngoms4mfcXYolejVVMkwGxZVspdxuMNy9wsav1u8JMnl+mlPwvBLYrDxcLMYmM7Bod3eZ62cjArbW9IMZMiFwjhQtftlupYsicmSRxopK93Qi+87odWPsXp7d5f7N03gw6OHSzMBIQFvO9ZfzdLZLLs5ux5yJ7I3EQTHO6lOw9P1ZLa3zD9E6+q3+GcQ1pAP8XI/2g9W4aGSJbXWAXR7q9Z1E/Ery0U3AzZllHaau9npS/mk21w
DKIM-Signature: a=rsa-sha256; bh=i8zGyEn1arO7DP0k0SA7gO2PsrX2furf++vsaLteOsY=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795169879; v=1; 
 b=ddJNDlS5P7Jw6DhPlAFRHGBuc7AHk0MFlbNL6DHLuWEEe+FyPHdoGm9rq2NSfpM2IMrXK4wS
 lEiQ7RprLdPUqf3xeTEfOS4uHRaWga1klKCYywqEgLDyJ0R1al4bkmDzmiiWplCX8j3SwlOGTcy
 1oJ+BNNfo/Zsjuu/bbv5AMFk=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 23:51, Eric Blake wrote:
> On Thu, Nov 19, 2026 at 03:46:31PM +0100, Guillaume Vincke wrote:
>> Test the block_resize QMP function on an NBD device. Prior to the
>> addition of bdrv_co_refresh_connection(), running block_resize on a
>> node that did not process any requests between the device size
>> update and the function call failed with "Cannot grow NBD nodes".
>>
>> Add a test that updates an NBD node size and verifies that the
>> block_resize behaves as expected. The first part configures a reconnect
>> delay and asserts that the call succeeds. The second uses the default
>> reconnect-delay=0 and asserts that, even though the function returns an
>> error, the reconnection routine gets started and that retrying succeeds
>> once the node has successfully reconnected.
>>
>> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
>> ---
>>   tests/qemu-iotests/tests/nbd-resize     | 81 +++++++++++++++++++++++++
>>   tests/qemu-iotests/tests/nbd-resize.out | 24 ++++++++
>>   2 files changed, 105 insertions(+)
>>   create mode 100755 tests/qemu-iotests/tests/nbd-resize
>>   create mode 100644 tests/qemu-iotests/tests/nbd-resize.out
>>
>> diff --git a/tests/qemu-iotests/tests/nbd-resize b/tests/qemu-iotests/tests/nbd-resize
>> new file mode 100755
>> index 0000000000..4f305eaebf
>> --- /dev/null
>> +++ b/tests/qemu-iotests/tests/nbd-resize
>> @@ -0,0 +1,81 @@
>> +#!/usr/bin/env python3
>> +# group: quick
> 
> Can this also go in the 'auto' group?
> 

I believe it can.  Will add it in v2.

>> +
>> +for reconnect_delay in [10, 0]:
>> +    iotests.log(f"=== Resize with reconnect-delay={reconnect_delay} ===")
>> +    with iotests.VM() as vm:
>> +        vm.launch()
>> +
>> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1M')
>> +        with iotests.qemu_nbd_popen('-k',
>> +                                    nbd_sock,
>> +                                    '-f',
>> +                                    iotests.imgfmt,
>> +                                    disk):
>> +            vm.cmd('blockdev-add', {
>> +                'driver': 'nbd',
>> +                'node-name': node_name,
>> +                'server': { 'type': 'unix', 'path': nbd_sock },
>> +                'reconnect-delay': reconnect_delay,
>> +            })
>> +
>> +            iotests.log('Size before resize:')
>> +            iotests.log(node_size(vm))
>> +
>> +        iotests.qemu_img('resize', '-f', iotests.imgfmt, disk, '2M')
>> +        with iotests.qemu_nbd_popen('-k',
>> +                                    nbd_sock,
>> +                                    '-f',
>> +                                    iotests.imgfmt,
>> +                                    disk):
>> +            iotests.log(vm.qmp('block_resize', {
>> +                'node-name': node_name,
>> +                'size': 2097152,
>> +            }))
>> +            iotests.log('Size after resize:')
>> +            iotests.log(node_size(vm))
> 
> After growing the image from 1M to 2M, is it also worth doing IO to
> offsets in the newly-expanded part of the file to prove the resized
> region is accessible?
> 

Doing I/O does not exercise the current patchset but you are right that
we can expect it out of a proper resize test.  Will add this in v2.


