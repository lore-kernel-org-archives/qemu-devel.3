Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E271606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=hfc0hKI0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYaQ-0008EH-7c; Thu, 12 Nov 2026 12:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRYaN-0008De-9m; Thu, 12 Nov 2026 12:27:43 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRYaK-0004UG-L8; Thu, 12 Nov 2026 12:27:42 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.254.33])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jQS4w3fMlz7tCZ;
 Thu, 12 Nov 2026 17:27:28 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 12 Nov
 2026 18:27:27 +0100
Message-ID: <16e512eb-a365-49b1-a4e2-e376d5697b19@ovhcloud.com>
Date: Thu, 12 Nov 2026 18:27:26 +0100
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
 <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com>
 <87h5hntpls.fsf@pond.sub.org>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <87h5hntpls.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17798225729283375399
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEg9JgLHizBLjlf6zMx6xBhIY8Cl6ifIdOCROV6D9igrJyYEQokxXDFBF/E+29cuF42SZWwrsBO2UjZBnDhG23NVuys50cenPWCtoknMP1iLwFY3nczz3Wh8pLveyaBeQ4EIAeYv8nN1CrbhN2InL+iwYQEQwDnBP4oQUkHCon8G1s9HsViJS07hgCEUyE/TIOG/iIeuoSQFpPqFixdhjwqtnNKZic6NV6wivIZUM3l0iD4sWfVBbdk2NJLCfiitjbydWVja7Iyovkb9CYcVSVOjNHWRruAhfTS0n07LeAnWHU4PoMFDB/ohl+6kuPtz2XEDwnfHlHgowNV3FOJ7C7gEnIMY7fZA+nei+pIIh8xfqaySusBnBSaUWD/Fc4+k689r3uVgwCTBJMNW+WYyOdhvssH75wVVhVrGX5c/yKz6/UCQaK2M/yllbIgznrPBhsTgKQRuDqqJiodxSCpdI0kuG3gUGQbCuE4wfRfcd06pPGPnOvXS9zmKL890dOBi0BqcMmj673dGzc9/pZYYaa+/zFq12u9Fa/cpJnG6z8W+YskPYt5IyCTyS5S69P0OhLE4UgHeAEb8SkBmLczA1ZNXkLkk6NOrB+TpyHT4TBWtPIqhkS0crLcGIJLYSlQekbI6X5g6U5D3LNR82jTdontwrrVUkKGMFdJuD7vE5PwMA
DKIM-Signature: a=rsa-sha256; bh=meRBY+o6NcIsMsGq6sGHCuJI+2Aq8ZR3QcmF9w56nsY=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794504448; v=1; 
 b=hfc0hKI03kqL/g9JsyGxkE3RDf0cHiF8BO1NTQpLhilI/CSKi/Ahry8cisjJmW1YybYf2Nvj
 cY3poFFsk53om/OmZRNTgcqkiPumpBrI2ad2oadxDZK2fP93sIVe7T5xw1hLBtArxhwvma/i7Zx
 mYtZHBlA36lU0SwzpTIdRfoE=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
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

On 11/11/26 15:22, Markus Armbruster wrote:
> guillaume vincke <guillaume.vincke@ovhcloud.com> writes:
> 
>> On 11/10/26 13:53, Markus Armbruster wrote:
>>
>> Thanks for the review. Let me clarify before posting a v2.
>>
>>> Why block-core.json and not block-export.json?
>>
>> If I get this right, block-export.json covers the server part. I
>> thought adding this next to BlockdevOptionsNbd was a better fit. I can
>> change that in v2 if you think block-export.json is a better match.
> 
> My question was a question, not a change request :)
> 

I was a bit too eager there :) I will keep it where it stands for now.

>>>> +#
>>>> +# @connecting-wait: No active connection.  A request waits for the
>>>> +#     connection attempt to finish, while reconnect-delay has not
>>>> +#     expired.
>>>> +#
>>>> +# @connecting-nowait: No active connection.  A request fails at once
>>>> +#     if no channel is ready.
>>>> +#
>>>> +# @connected: Client has a valid connection.
>>>
>>> Double-checking: when we're in this state, there is a client connected.
>>> Correct?
>>
>> Yes. This is a client state that describes the connection as valid: the
>> channel got negotiated and is ready to process requests.
>>
>>>
>>>> +#
>>>> +# @quit: Client will not reconnect.
>>>
>>> What does this one mean exactly?
>>
>> The client stopped for good. Requests fail and it never reconnects.
>> This state is reached on fatal error or teardown.
> 
> Work some of that into the description?
> 

Will do!
>>>> +#
>>>> +# @running: Connection attempt is in progress.
>>>> +#
>>>> +# @parked: Connection was successful and channel is kept for the next
>>>> +#     request.
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'enum': 'XDbgNbdClientConnectorState',
>>>> +  'data': [ 'running', 'parked' ] }
>>>> +
>>>> +##
>>>> +# @XDbgNbdClientConnector:
>>>> +#     The NBD connector information.
>>>> +#
>>>> +# @state: State of the connector.
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'struct': 'XDbgNbdClientConnector',
>>>> +  'data': { 'state': 'XDbgNbdClientConnectorState' } }
>>>> +
>>>> +##
>>>> +# @XDbgNbdClient:
>>>> +#     The NBD connection state of the client and its connector.
>>>> +#     The two members are read independently and may not reflect a
>>>> +#     single point in time.
>>>
>>> That's unfortunate.  It'll do for debugging.  Could it create robustness
>>> issues in tests?
>>
>> On the nbd-stale-connection test it is not a problem but I can try to
>> take the locks together in v2.
> 
> Worth a try, I guess.
> 

Will add that in v2.

>>>> +#
>>>> +# @state: The client state.
>>>> +#
>>>> +# @connector: The connector details.  Only present while a connection
>>>> +#     attempt is running or its channel is parked.
> 
> When exactly is this member present?
> 
> Is it always present when @state has certain values, and never present
> when it doesn't?  Or is it more complicated?
> 

It is never present when @state is connected. on connecting-* it is
absent until lazy reconnection is triggered (first request after a
failure). In quit, a running attempt or a parked channel stays until
the node is closed, so the connector can be absent, running or parked.

>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'struct': 'XDbgNbdClient',
>>>> +  'data': { 'state': 'XDbgNbdClientState',
>>>> +            '*connector': 'XDbgNbdClientConnector' } }
>>>
>>> How the combined state machine works is not clear to me.  Is it
>>> documented anywhere?
>>
>> I did not find a proper documentation. I found the comments on the code
>> to be quite explicit though. The connector only runs in a connecting-*
>> state. In that state, when processing a request, the client tries to
>> get the channel from the connector. When the connector has a valid
>> channel but the client did not request it, the connector is in parked
>> state. Do you think this command should document that behavior?
> 
> Perhaps the doc comments are good enough for a debugging command to be
> used by people who know how the state machine works.
> 
> I don't, I've read the doc comments several times, and the state machine
> is still a mystery to me.  Can we do better with reasonable effort?
> 

would something like this help:

1- the connector is absent while connected
2- a failure moves the client to connecting-wait. It gets to Nowait
    when the configured reconnect-delay is reached.
3- In connecting-* states, the next request starts the connector which
    gets into running.
4- On wait, the request blocks and takes the channel when it's ready.
    On nowait, the request fails at once if no parked channel is
    available.
5- on successful connection, the connector parks the channel.
6- when the channel gets picked up by the client, it gets to connected
    and the connector is cleared.
7- on fatal error or when teardown is requested, the state gets to
    quit.


>>>> +
>>>> +##
>>>> +# @x-debug-query-nbd-client:
>>>> +#     Get the NBD client state.
>>>> +#
>>>> +# @node-name: node name of the NBD client to query.
>>>
>>> How would I find the valid node names?  query-block-exports?
>>
>> The node-name is listed by query-named-block-nodes or is the one passed
>> to blockdev-add. I will add a reference to those commands in the
>> docstring to clarify.
> 
> What exactly makes such a node name an "NBD client"?

It's a node whose driver is NBD. It gets added with blockdev-add with
"driver": "nbd". Any other node gets the error "is not an NBD client".
Would changing the doc to "node name of a block node using the nbd
driver" with a reference to the query-named-block-nodes be better ?


