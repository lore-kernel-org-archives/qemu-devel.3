Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC06CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 18:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw2jH-0000Ux-Eh; Tue, 09 Sep 2025 14:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uw2j8-0000OH-Gm; Tue, 09 Sep 2025 14:05:59 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uw2iz-0000kX-DB; Tue, 09 Sep 2025 14:05:56 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4F0027A017B;
 Tue,  9 Sep 2025 14:05:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1757441135;
 x=1757527535; bh=rsrmaA/2Sw9blmQNNoUwYKcvgyF0P5AHgdHtXX6Nnws=; b=
 fSeSaNgnexl5FatF5G4+OE+/JaYXv66vBOxvX5vEu3yZuVwHdAW56z4OF10Sd3H4
 WeWauTRYtr3FALIpyWWzf69wMgiO53HYGX+wuRxflE7980hkzMniHuCjT9ssR5GD
 QNpyXFOxiDjXCAtJF1iJMPggLcYxfNYIgDZDR+hypuN3NAkNIJ8g2hqkX8ihvUH6
 UbKbmg0BhjFmdKhj8V1YR9EEVLxVRWacrjuXSlq4cAkGUhYsBpi2kKZnudWeKZB+
 OZPvA5fGpR/LNdNXnfBDV03j673+V0/UQ+I9AevCMSI/W82lQM81sAlA3Zd51LSo
 ojqzJN/xLXeV6U3JgFhBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757441135; x=
 1757527535; bh=rsrmaA/2Sw9blmQNNoUwYKcvgyF0P5AHgdHtXX6Nnws=; b=C
 TiT1UnWvqDsK3omMmZTB1HeeFTOyYPIAoUPJRKrMJoqm/oIDKJEcaf0LsgQNgL8h
 yYFkXmFTaUYmMGVXv1pryTDRLPKCpggE+ENepJxdYuUbXpmE5JvCJI/sZEQGkAOd
 C3w53qxNy4fogJ60TTL5ssUBTmhIJN048kl5mjb1rDLDrsIRjAxb3TAzJ6PI2P0F
 6euW3757VqSplsGRzfHulxM1KUCLBdoFzgoudVk+Ks/CO2SXGWXmAIGTnBK7DZUt
 WyjcHaw91+9trcOMb24fD5U/Cn45f/Bc5TXbQhpX1xBnIdtk7hG0/lppoCNmymJb
 iY0tCXJrOSkWgfnHjR6hA==
X-ME-Sender: <xms:bmzAaI-BqC9ozYufjp-yd_mVE9I27uFO1hqdS8iYvR1RSKXo2qmaSg>
 <xme:bmzAaIX_05RXRfLj0rvyOn0eyw1RWWOVwtIM581EK3grq9aHy3JSMwxIiydQtUld6
 iG6piW2G4XPb5aS>
X-ME-Received: <xmr:bmzAaLpE2kihNS_ChSTbQv4EORe-7xzjv3oS-N-hnK4uwfq8ge0T6vUcSb_2PC4XStgAxcPWnTJscNT6yneftpU_Ao4AgNoekWsHeaDm0Su_xm-3HPGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:bmzAaCkds1knHdfM1lyxh3iXvNqVF_ijs6txwyz6Z-AMNbaY1TsPPQ>
 <xmx:bmzAaD1eKwKAgl1ZtyhqKnVMEprV1q_4iP8JV-UVcNAI6Chf5OiwLA>
 <xmx:bmzAaHR8nNGjH_SpUHBidPh7A0i1zkxgocbrLrWt9oLp5Bgd2HXaLw>
 <xmx:bmzAaEwzGQsW7ghhvoHJWjI6Wx4DjjCcV6eta3Pnqw75AIYctNbQMQ>
 <xmx:b2zAaGrFSn3LFSIkr46xzpwyZdeKX0XoFc6hmpSZzZaqpIdDx-kR35d5>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 14:05:33 -0400 (EDT)
Message-ID: <ef01a7a4-57f9-454f-8ba3-85a9e4152d0b@bsbernd.com>
Date: Tue, 9 Sep 2025 20:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
To: Brian Song <hibriansong@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
 <20250903105325.GB106431@fedora>
 <da5f4b75-2543-4f33-97d9-360c409c6079@gmail.com>
 <20250909144804.GC218449@fedora>
 <ae10f5c3-af86-4102-a7c6-bc582133464d@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <ae10f5c3-af86-4102-a7c6-bc582133464d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=bernd@bsbernd.com;
 helo=fhigh-b3-smtp.messagingengine.com
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



On 9/9/25 19:46, Brian Song wrote:
> 
> 
> On 9/9/25 10:48 AM, Stefan Hajnoczi wrote:
>> On Wed, Sep 03, 2025 at 02:00:55PM -0400, Brian Song wrote:
>>>
>>>
>>> On 9/3/25 6:53 AM, Stefan Hajnoczi wrote:
>>>> On Fri, Aug 29, 2025 at 10:50:22PM -0400, Brian Song wrote:
>>>>> This patch adds a new export option for storage-export-daemon to enable
>>>>> FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
>>>>> It also implements the protocol handshake with the Linux kernel
>>>>> during the FUSE-over-io_uring initialization phase.
>>>>>
>>>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>>
>>>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>>>> works. This patch implements the Initial SQE stage shown in thediagram:
>>>>> it initializes one queue per IOThread, each currently supporting a
>>>>> single submission queue entry (SQE). When the FUSE driver sends the
>>>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>>>> fuse_uring_start() to complete initialization, ultimately submitting
>>>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>>>> successful initialization with the kernel.
>>>>>
>>>>> We also added support for multiple IOThreads. The current Linux kernel
>>>>> requires registering $(nproc) queues when setting up FUSE-over-io_uring
>>>>> To let users customize the number of FUSE Queues (i.e., IOThreads),
>>>>> we first create nproc Ring Queues as required by the kernel, then
>>>>> distribute them in a round-robin manner to the FUSE Queues for
>>>>> registration. In addition, to support multiple in-flight requests,
>>>>> we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
>>>>> entries/requests.
>>>>
>>>> The previous paragraph says "each currently supporting a single
>>>> submission queue entry (SQE)" whereas this paragraph says "we configure
>>>> each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH entries/requests".
>>>> Maybe this paragraph was squashed into the commit description in a later
>>>> step and the previous paragraph can be updated to reflect that multiple
>>>> SQEs are submitted?
>>>>
>>>>>
>>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>>> ---
>>>>>    block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
>>>>>    docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>>>    qapi/block-export.json               |   5 +-
>>>>>    storage-daemon/qemu-storage-daemon.c |   1 +
>>>>>    util/fdmon-io_uring.c                |   5 +-
>>>>>    5 files changed, 309 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>>> index c0ad4696ce..19bf9e5f74 100644
>>>>> --- a/block/export/fuse.c
>>>>> +++ b/block/export/fuse.c
>>>>> @@ -48,6 +48,9 @@
>>>>>    #include <linux/fs.h>
>>>>>    #endif
>>>>> +/* room needed in buffer to accommodate header */
>>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>>
>>>> Is it possible to write this in a way that shows how the constant is
>>>> calculated? That way the constant would automatically adjust on systems
>>>> where the underlying assumptions have changed (e.g. page size, header
>>>> struct size). This approach is also self-documenting so it's possible to
>>>> understand where the magic number comes from.
>>>>
>>>> For example:
>>>>
>>>>     #define FUSE_BUFFER_HEADER_SIZE DIV_ROUND_UP(sizeof(struct fuse_uring_req_header), qemu_real_host_page_size())
>>>>
>>>> (I'm guessing what the formula you used is, so this example may be
>>>> incorrect...)
>>>>
>>>
>>> In libfuse, the way to calculate the bufsize (for req_payload) is the same
>>> as in this patch. For different requests, the request header sizes are not
>>> the same, but they should never exceed a certain value. So is that why
>>> libfuse has this kind of magic number?
>>
>>  From <linux/fuse.h>:
>>
>>    #define FUSE_URING_IN_OUT_HEADER_SZ 128
>>    #define FUSE_URING_OP_IN_OUT_SZ 128
>>    ...
>>    struct fuse_uring_req_header {
>>            /* struct fuse_in_header / struct fuse_out_header */
>>            char in_out[FUSE_URING_IN_OUT_HEADER_SZ];
>>
>>            /* per op code header */
>>            char op_in[FUSE_URING_OP_IN_OUT_SZ];
>>
>>            struct fuse_uring_ent_in_out ring_ent_in_out;
>>    };
>>
>> The size of struct fuse_uring_req_header is 128 + 128 + (4 * 8) = 288
>> bytes. A single 4 KB page easily fits this. I guess that's why 0x1000
>> was chosen in libfuse.
>>
> 
> Yes, the two iovecs in the ring entry: one refers to the general request 
> header (fuse_uring_req_header) and the other refers to the payload. The 
> variable bufsize represents the space for these two objects and is used 
> to calculate the payload size in case max_write changes.
> 
> Alright, let me document the buffer usage. It's been a while since I 
> started this, so I don’t fully remember how the buffer works here.

For current kernel code we could make this 288 allocations for the header. 
This just does not work with page pinning, which we are using at DDN
(kernel patches not upstreamed yet).

Maybe I should make the header allocation way dependent if page pinning,
there is a bit overhead with 4K headers, although 4K doesn't sound too bad,
even with many queues.


Thanks,
Bernd

