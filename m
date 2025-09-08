Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36789CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhoj-0002jT-9o; Mon, 08 Sep 2025 15:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uvhoe-0002hz-E8; Mon, 08 Sep 2025 15:46:18 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uvhoY-0000cc-Se; Mon, 08 Sep 2025 15:46:16 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 42CD71D00015;
 Mon,  8 Sep 2025 15:46:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 15:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1757360761;
 x=1757447161; bh=0j1MWwjUwfEbY+Ae+ca0MtYA+y6bx30gH2vZ5Vtlg9M=; b=
 F3YqIXzHxPv42ybvV1Lza/IEfk7LYBwz+ZJYcTTp6XMAXXK+V1u8fBbAmS2FMJT/
 W0BD8ou1QnUqANSqkYy6vfKGb/DC+TLgYvPm++bPMcyENY/s7rIJ/IXlRsA/G4gH
 YYbUxW6mWsb+TWNxYPhtJRwKyqURzHX//JQxuk4/VUm7po0aVbfMgIiLyIh7zG4z
 ZkSlIopnlI4sOiyrzbwLFfU2c434jTplCxqwp1ni0w2ZcZ/D6RJjU22HPo7Xq6ek
 LTFi4GP4fC5GMT8Ff/H+5+hSH9SdHTWI5RO8P9hpgMPZY0tpBqkFEuZC5o2dBRz+
 0M2HYcSO3IqwFJm42Uu/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757360761; x=
 1757447161; bh=0j1MWwjUwfEbY+Ae+ca0MtYA+y6bx30gH2vZ5Vtlg9M=; b=c
 NI/Suoge6qLXuJ/avVoxWqFRbDfSzQ7knhfV3NfKQz36RnOsn60QIYzWRgl5NLo1
 0nUZEuSKWIuXq/5NnHarj76Sp6u9M2yTFBk3uJhVx+c2L5OBtEyphoY/JUCILLRX
 AeUO7xjnsoGD8QY/9gyuyT2ofm1w1G7WGlLwF2ECNnl+NTHhleNGP86jycf4IeJg
 lEt14AKoe5AuzjYarWferAUbDOJSqzDzGKsxoLT0ROs3ufeAP0OBjLSSqc5nUHXm
 j9ERoZzATycqzB9JU6R+u8eIicX8kL1jBcLy8vlIVtUFcTeWLXYF5SKo2ngxCL+x
 2oqTDR+OaUFfw0Zcb4tOg==
X-ME-Sender: <xms:eDK_aBl8HwD8v0rwqdJAI426TltyS5lo_UVLOe34phKqvaDeURv4bQ>
 <xme:eDK_aEeozN-ckauokSL3dSPELbBlbmziNOqoVl2SBndmQH0iAXOHhh6LpDmODcX6e
 wSIssakj0rJo-0t>
X-ME-Received: <xmr:eDK_aFRrMGvftz72w3mQdX8IFuoZczRotaahLy56f5uETrKKbpndWh2U7dm9NqBbVErr0z__goIs7tIkIjyInLJZsPTTSQvx1m7cKzZ7vPkLTATPxDJa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
 ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
 htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
 ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
 pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhih
 gsrhhirghnshhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrghnhhgr
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnh
 hurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmh
 esvghuphhhohhnrdhnvghtpdhrtghpthhtohephhhrvghithiisehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:eDK_aLvoB4G64XfNQ1_NFYgjXfPiYU49IZ9ASPLi3EYaPi3-_g2szg>
 <xmx:eDK_aGc3wzbChTH8NQ1o90TnhmlNnLeKDRw22saguNbETuGv7T4Uuw>
 <xmx:eDK_aFavF0Lx0VgIqRoLqd4t4wnqKzK604thgLy6uPd36cYHAJRg4A>
 <xmx:eDK_aIbpnIO13UIZTXxP5Bbr8sxd2Vz3z9W4kUUnsXXqeqeeB4psYQ>
 <xmx:eTK_aPsp748E6Ti9UWXqjF50A8K9C-KjFj3BM_5fsoTpvKoWvxBYwwaX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 15:45:59 -0400 (EDT)
Message-ID: <f6ca7bc4-604c-43c8-ab81-7ef14762d8a1@bsbernd.com>
Date: Mon, 8 Sep 2025 21:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
To: Brian Song <hibriansong@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
 <20250903115108.GD106431@fedora>
 <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=bernd@bsbernd.com;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/8/25 21:09, Brian Song wrote:
> 
> 
> On 9/3/25 7:51 AM, Stefan Hajnoczi wrote:
>> On Fri, Aug 29, 2025 at 10:50:23PM -0400, Brian Song wrote:
>>> https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>
>>> As described in the kernel documentation, after FUSE-over-io_uring
>>> initialization and handshake, FUSE interacts with the kernel using
>>> SQE/CQE to send requests and receive responses. This corresponds to
>>> the "Sending requests with CQEs" section in the docs.
>>>
>>> This patch implements three key parts: registering the CQE handler
>>> (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
>>> process_request), and sending response results (fuse_uring_send_
>>> response). It also merges the traditional /dev/fuse request handling
>>> with the FUSE-over-io_uring handling functions.
>>>
>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>> ---
>>>   block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 309 insertions(+), 148 deletions(-)
>>>
>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>> index 19bf9e5f74..07f74fc8ec 100644
>>> --- a/block/export/fuse.c
>>> +++ b/block/export/fuse.c
>>> @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>   };
>>>   
>>>   #ifdef CONFIG_LINUX_IO_URING
>>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
>>> +
>>> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
>>
>> This function appears to handle exactly one cqe. A singular function
>> name would be clearer than a plural: co_fuse_uring_queue_handle_cqe().
>>
>>> +{
>>> +    FuseRingEnt *ent = opaque;
>>> +    FuseExport *exp = ent->rq->q->exp;
>>> +
>>> +    /* Going to process requests */
>>> +    fuse_inc_in_flight(exp);
>>
>> What is the rationale for taking a reference here? Normally something
>> already holds a reference (e.g. the request itself) and it will be
>> dropped somewhere inside a function we're about to call, but we still
>> need to access exp afterwards, so we temporarily take a reference.
>> Please document the specifics in a comment.
>>
>> I think blk_exp_ref()/blk_exp_unref() are appropriate instead of
>> fuse_inc_in_flight()/fuse_dec_in_flight() since we only need to hold
>> onto the export and don't care about drain behavior.
>>
> 
> Stefan:
> 
> When handling FUSE requests, we don’t want the FuseExport to be 
> accidentally deleted. Therefore, we use fuse_inc_in_flight in the CQE 
> handler to increment the in_flight counter, and when a request is 
> completed, we call fuse_dec_in_flight to decrement it. Once the last 
> request has been processed, fuse_dec_in_flight brings the in_flight 
> counter down to 0, indicating that the export can safely be deleted. The 
> usage of in_flight follows the same logic as in traditional FUSE request 
> handling.
> 
> Since submitted SQEs for FUSE cannot be canceled, once we register or 
> commit them we must wait for the kernel to return a CQE. Otherwise, the 
> kernel may deliver a CQE and invoke its handler after the export has 
> already been deleted. For this reason, we directly call blk_exp_ref and 
> blk_exp_unref when submitting an SQE and when receiving its CQE, to 
> explicitly control the export reference and prevent accidental deletion.
> 
> The doc/comment for co_fuse_uring_queue_handle_cqe:
> 
> Protect FuseExport from premature deletion while handling FUSE requests. 
> CQE handlers inc/dec the in_flight counter; when it reaches 0, the 
> export can be freed. This follows the same logic as traditional FUSE.
> 
> Since FUSE SQEs cannot be canceled, a CQE may arrive after commit even 
> if the export is deleted. To prevent this, we ref/unref the export 
> explicitly at SQE submission and CQE completion.
> 
>>> +
>>> +    /* A ring entry returned */
>>> +    fuse_uring_co_process_request(ent);
>>> +
>>> +    /* Finished processing requests */
>>> +    fuse_dec_in_flight(exp);
>>> +}
>>> +
>>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>>> +{
>>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>>> +    Coroutine *co;
>>> +    FuseExport *exp = ent->rq->q->exp;
>>> +
>>> +    if (unlikely(exp->halted)) {
>>> +        return;
>>> +    }
>>> +
>>> +    int err = cqe_handler->cqe.res;
>>> +
>>> +    if (err != 0) {
>>> +        /* -ENOTCONN is ok on umount  */
>>> +        if (err != -EINTR && err != -EAGAIN &&
>>> +            err != -ENOTCONN) {
>>> +            fuse_export_halt(exp);
>>> +        }
>>
>> How are EINTR and EAGAIN handled if they are silently ignored? When did
>> you encounter these error codes?
> 
> Bernd:
> 
> I have the same question about this. As for how the kernel returns 
> errors, I haven’t studied each case yet. In libfuse it’s implemented the 
> same way, could you briefly explain why we choose to ignore these two 
> errors, and under what circumstances we might encounter them?


I think I remember why I had added these. Initially the ring threads
didn't inherit the signal handlers libfuse worker threads have. I had
fixed that later and these error conditions are a left over.
In libfuse idea is that the main thread gets all signals and then sets
se->exited - worker thread, include ring threads are not supposed to get
or handle signals at all, but have to monitor se->exited.

Good catch Stefan, I think I can remove these conditions in libfuse.


Thanks,
Bernd


