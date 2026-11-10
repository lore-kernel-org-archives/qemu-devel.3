Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1735606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=H/p+Ylen
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnS3-0003PX-Ue; Tue, 10 Nov 2026 10:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQnRw-0003EX-Tl
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:07:53 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQnRt-0000dd-9w
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:07:52 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.254.253])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jP94c6P3jz43c5;
 Tue, 10 Nov 2026 15:07:44 +0000 (UTC)
Received: from [10.46.75.159] (109.190.254.5) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 16:07:44 +0100
Message-ID: <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com>
Date: Tue, 10 Nov 2026 16:07:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd: Add an unstable query for the client state
To: <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, <eblake@redhat.com>,
 <vsementsov@yandex-team.ru>, <kwolf@redhat.com>, <hreitz@redhat.com>
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
 <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
 <87v764yhjg.fsf@pond.sub.org>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <87v764yhjg.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 3693233170106302759
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTESHH/DdLfSZ/uN9RX19mRZGwkzQbqeUNfrYBf/XeAy+pzdAupcFKhODUCn3RVTob/4RgVHY8+NetDNkDkc2lD3oVE5ksu9JHEva+6MVLc5PRwXk+mtAqkCs0HmxtBMKTSM5k8DKADhaulZA8Y480kx5FqTFYDItzdOIUuc0Pp0vfX4GWVs7dfByp8aKDgu2DNPSSjw2C9yUpkIMh2BoRIcUbqwUostJCr30oVgrOV8xN9uW1DlMxOttYP7WxsO+fuh+J5D7WSnmUzONa1tjQiXYF88ezzHWN62V5TX0l37+O8LyUrHzdUP1zEZdpL9SvqUPSkOoYM9ZyhGt5VpVhIiqplKoqkLB+WtD4mnbJfTOj89ZQd1YHWEWD36LyV1UBx3i3yAP+SVFHjbHaOlTKQhCaXhC569MdKsquZh3z/nqykhjlSFlzKciDwLZsa+CaDzLTnC85Zwm7D8U/8CX9OLePpKitZVA43/qUgdYy8JiSXnoTzvyah8LznCSO0uXCVkpA5YtABsWrW29Wf5YvbIY9KiennAkzRHgZ/DBF1AHzxT4P1TPEcc/ZtVmDyk5lZYJGkUj1l8PEmH/pZQgMtGtEzB1ZRJMiKk3vdu4F/xfQp7uElTgq1nGY+8EWnkCOqkga9BXUPMxOagCCHaRiAM9MNerEkUGwjv/kbbEWsawA
DKIM-Signature: a=rsa-sha256; bh=Z/K00ub2JqEq1+AumFQzfjd2uReQk73T3FQuE2ug0gc=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794323265; v=1; 
 b=H/p+Ylenz2LTXby/4Dm4pQgFp5PD0cm4VmE6aSsFtW79/u7Vpxy9i9F1FXVFh2CE+X350SRD
 3Drn0ips7eNd1cZSBCW/D8+jtDeeBIaPqoT3WgkGuIRc1kb7Bz6ROPBgCrzLO1ZeyT2/Mg2VTuI
 DAgSG0AfgleFkBwE+wtdZbf8=
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 13:53, Markus Armbruster wrote:

Thanks for the review. Let me clarify before posting a v2.

> 
> Why block-core.json and not block-export.json?

If I get this right, block-export.json covers the server part. I
thought adding this next to BlockdevOptionsNbd was a better fit. I can
change that in v2 if you think block-export.json is a better match.

> 
>> +#
>> +# @connecting-wait: No active connection.  A request waits for the
>> +#     connection attempt to finish, while reconnect-delay has not
>> +#     expired.
>> +#
>> +# @connecting-nowait: No active connection.  A request fails at once
>> +#     if no channel is ready.
>> +#
>> +# @connected: Client has a valid connection.
> 
> Double-checking: when we're in this state, there is a client connected.
> Correct?

Yes. This is a client state that describes the connection as valid: the
channel got negotiated and is ready to process requests.

> 
>> +#
>> +# @quit: Client will not reconnect.
> 
> What does this one mean exactly?

The client stopped for good. Requests fail and it never reconnects.
This state is reached on fatal error or teardown.

> 
>> +#
>> +# Since: 11.2
> 
> Making 11.2 seems unlikely.

Sure. Would updating this to 12.0 make more sense ?

>> +#
>> +# @running: Connection attempt is in progress.
>> +#
>> +# @parked: Connection was successful and channel is kept for the next
>> +#     request.
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'enum': 'XDbgNbdClientConnectorState',
>> +  'data': [ 'running', 'parked' ] }
>> +
>> +##
>> +# @XDbgNbdClientConnector:
>> +#     The NBD connector information.
>> +#
>> +# @state: State of the connector.
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'XDbgNbdClientConnector',
>> +  'data': { 'state': 'XDbgNbdClientConnectorState' } }
>> +
>> +##
>> +# @XDbgNbdClient:
>> +#     The NBD connection state of the client and its connector.
>> +#     The two members are read independently and may not reflect a
>> +#     single point in time.
> 
> That's unfortunate.  It'll do for debugging.  Could it create robustness
> issues in tests?

On the nbd-stale-connection test it is not a problem but I can try to
take the locks together in v2.

> 
>> +#
>> +# @state: The client state.
>> +#
>> +# @connector: The connector details.  Only present while a connection
>> +#     attempt is running or its channel is parked.
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'XDbgNbdClient',
>> +  'data': { 'state': 'XDbgNbdClientState',
>> +            '*connector': 'XDbgNbdClientConnector' } }
> 
> How the combined state machine works is not clear to me.  Is it
> documented anywhere?

I did not find a proper documentation. I found the comments on the code
to be quite explicit though. The connector only runs in a connecting-*
state. In that state, when processing a request, the client tries to
get the channel from the connector. When the connector has a valid
channel but the client did not request it, the connector is in parked
state. Do you think this command should document that behavior?

> 
>> +
>> +##
>> +# @x-debug-query-nbd-client:
>> +#     Get the NBD client state.
>> +#
>> +# @node-name: node name of the NBD client to query.
> 
> How would I find the valid node names?  query-block-exports?

The node-name is listed by query-named-block-nodes or is the one passed
to blockdev-add. I will add a reference to those commands in the
docstring to clarify.

