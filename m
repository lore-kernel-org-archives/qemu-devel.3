Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE560A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=JXBW4IXB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULUF-0004XC-74; Fri, 20 Nov 2026 05:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULUB-0004VO-VF; Fri, 20 Nov 2026 05:04:52 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULU9-0000F5-S9; Fri, 20 Nov 2026 05:04:51 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.231.200])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jW9tN4Jq4z3wld;
 Fri, 20 Nov 2026 10:04:44 +0000 (UTC)
Received: from [10.46.51.33] (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:04:43 +0100
Message-ID: <9ff4cadf-6b9f-4a1c-adc9-cfd3b7e5869f@ovhcloud.com>
Date: Fri, 20 Nov 2026 11:04:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] block/nbd: Fix block resize on idle device
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
 <vsementsov@yandex-team.ru>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <stefanha@redhat.com>, <fam@euphon.net>, <nbd@other.debian.org>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <av8d_ufYpxKMw4qk@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <av8d_ufYpxKMw4qk@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 1962725012993753555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE90AG2HKq0vCvcgKPKyRtw45+rzULZHgHYvuxE8+VULTHzeS4XWqHsjg/xMVv0BncnxhjFAfEJPT7SC+UhTOQun2vZXx6/wLumBoE6B9ol9Uo88p1TCWVLfMKY4jkgQnisNyfFY+L/J9tRwGLhRI7xup8VWPNqkHQUI0fezBCTCd/EoLw0h5rX0b2mcWS7FvfXlSW3Nfqi/4nBJp0S0ewvOMebt2p9S5lf7yP2WACQeLlvHEOGPZj/vofxcwE1sJ5Mmae0Y7UQ+KGSo010Lcn/EwliB6u4PuVsbt4YM3Ik2JfmxsMDOatTIsnCT1/scWhW/1BUjYWhhQ+wh4iwNvL1gr3rI4JMqvTxrgNZoamRlqxSZ5uBLBIc3XpAkVHbST920R4uI/6xjZmTtiy0IUg+F/Hbq4QEv9zs30F7nI9jIfVBeGoqwxRAEf6ToSyIR7HSkRTK3pDNoeWyHN6hiFCW8ZgOff/MsCATR4ihhUgnYGHZNAdSPI43bZzX2LXkeg5WKFjwvm8Cum5wpdvMserBpKbHSM3n9OqITfY0u1+2retq2m9ToaBrxhzhjTX6HUj5i08/uXzqzIqsSXlBU59EoWY0owIcIYfDlgfKXrSPdAuEJLE6lX2Lr1O6Yqgt7/m5++WRg7fsw1KKDNQcU1mpTgtJX7CgADpME689lbvzVQ
DKIM-Signature: a=rsa-sha256; bh=lq0JYQdcknoXG3sxvlWAEH1ZJO1AcDiJ/71IzwdrvYE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795169085; v=1; 
 b=JXBW4IXBbudVOpN1j9Zy6J45prmFAunUzJrJkzlAdgnQ1Llo/BZqpsk98mH9MBwSs12ankvt
 CMrPdyQL2EmfT1OONQ7/tJJnrlIZ5XfoIzbxU+LiXD8Kb2S+gPFvqvtASKCN6Ype9LQAObncFlO
 oHHY8g4XZ/oHGJatHjyKz04g=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 17:20, Eric Blake wrote:
> [cc NBD list for a protocol discussion]
> 
> On Thu, Nov 19, 2026 at 03:46:27PM +0100, Guillaume Vincke wrote:
>> When using an NBD backed device, the size is exchanged during
>> handshake. Therefore, when a volume gets resized on the target, it
>> closes its clients' connections to force a new handshake. Then,
>> management like OpenStack calls the block_resize QMP command to update
>> the node size.
>> This method works on active devices but, considering the NBD client
>> reconnection is lazy, the handshake does not happen on idle ones which
>> leads to a "Cannot grow NBD nodes" error when calling block_resize.
>>
>> This patchset adds a function to manually trigger reconnection on an
>> NBD device and calls it in the block_resize QMP command to make sure
>> the new size gets exchanged before trying to update the device
>> internals. It also implements the refresh callback in the raw and luks
>> drivers, which forward it to their file child.
> 
> Before I even review this series, I wonder if it is time to consider
> reviving discussion on the upstream NBD protocol mailing list about an
> extension to allow NBD to optionally support resize messages.
> 
> If I recall the last time it was discussed several years ago, there
> are competing needs: some scenarios want resize to be driven by the
> server (for example, in response to a high-water write event done by
> the client, the server detects that storage should grow; now the
> server needs to advertise to the client that the exported volume is
> larger); and some want it to be driven by the client (the client wants
> to specifically ask the server for the export size to grow; the server
> may or may not be able to comply).  NBD is normally client-driven, so
> a client asking the server for a new size is easy to implement by
> documenting a new NBD_CMD_RESIZE (in fact, opcode 8 is already
> reserved for this in the NBD protocol document).
> 
> But the server being able to advertise a new size to the client is an
> event-driven task, not client-driven.  Here, structured commands and
> the fact that the protocol allows out-of-order responses appears to
> provide a nice solution - the idea was that a new command initiated by
> the client requests an open-ended registration of resize events, and
> the server can reply with as many chunks as wanted over a long length
> of time reusing the client's cookie, and not using the
> NBD_REPLY_FLAG_DONE flag to end the stream of reply chunks until the
> client deregisters from the request (either two new NBD_CMD to
> register/deregister, or one command with a client flag to request
> registration or deregistration).
> 
> Ultimately, having NBD able to support live resizes will be even nicer
> than forcing client reconnections just to learn a new server size.
> That said, your series probably still has merit, because even if we
> extend the NBD protocol to allow live resize, it may take a while
> before both client and server ends are upgraded to understand the new
> protocol extension, while this reconnection should work with older
> protocol.
> 

I suppose you're talking about the resize extension
https://github.com/NetworkBlockDevice/nbd/blob/extension-resize/doc/proto.md?plain=1#L1366
It would cover my use case nicely.  Since management grows the volume
first, sending the NBD_CMD_RESIZE in block_resize would work.  The
reason why I decided not to go that route is because getting the
extension accepted looked like a lot more than the current changes.
Moreover, the two approaches can coexist.  Handling resizes done on the
server through a reconnection does not prevent the integration of the
client-side solution in the future.
Live resize would indeed be a nicer option.  If you back it up, I would
be happy to submit a patch to QEMU with the client-initiated live
resize.

If I get it right, your suggestion for server-side initiated resize has
a lot in common with NVMe's Asynchronous Event Request.  That pattern
could help with other events like the server going away or space
running low.


