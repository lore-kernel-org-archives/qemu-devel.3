Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89B2CA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 00:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoAY5-00083U-Ue; Mon, 18 Aug 2025 20:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uo8kh-0002rB-EM; Mon, 18 Aug 2025 18:54:55 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernd@bsbernd.com>)
 id 1uo8kf-0003pr-Au; Mon, 18 Aug 2025 18:54:55 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 2C4F6EC085F;
 Mon, 18 Aug 2025 18:54:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 18 Aug 2025 18:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1755557690;
 x=1755644090; bh=EC5uivRIWkXk1oTvFdHFsOxYCuh7stVexQ3xJ9xmwB4=; b=
 ABhZR4MOAhYQG/80WZX4CBNrMLaepdABIWVVJB6AcxRifG6icNYtNnhb3JlIdH0t
 J+SMln/aF2s0WClZkRpxFAMXtcdpSpgMJxcSsrCMEeL+JEcI0V3ycqLrCnezgD35
 2C6sbNRcRuXjT4q+mH55oks0oU2pihv88FT2qh4oQ2Yuig8ZmCs/b2Nz8Fd/7AVU
 n/+/89K9JgtFY4a3lj2EXYjFKQ8cZq8q0W47gTts9c8bIjfN+32j+5dyH9tvsaC7
 rW1Qk2IwjFdNbRcNACrioNBGnW/yBaydU7NJv1b0bTU3yrAuwpQsjnyutDsdMOSK
 QvbtysdAdvJLXBOEdJ6jYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755557690; x=
 1755644090; bh=EC5uivRIWkXk1oTvFdHFsOxYCuh7stVexQ3xJ9xmwB4=; b=R
 GvCqI56uy6T4/rt/iihB7zyr557iyB+bE/CPDErYsz49aokDyGB+AEk4d3ilxECW
 mDM4TPC22SU++vUhH2xzvedvy8u6pWoqZonbxfXETcXDlSQGdORKsBwuMXjLtRPj
 bfaHZrtSd2ZbRCU+CS+aZtqeR9UMiYUd0gP7MKLIhRxKTRKhq06hnp88UT6WM/RG
 mwDMsuZxegq8xxvs30uj0iy03/0MF7uIWE+rH89h9RIxI/ttk8MTCUN6UmDACj5s
 Jcf6GcRGt0wCzYk5DRe4KNrk3WRPOjDyml/Gsp/OqUEdWLbL/06q1bIfgGuCYn30
 H56hEtV4fDlTOGUsshTvA==
X-ME-Sender: <xms:Oa-jaA3tUasxsZyu9pxBHyrLNtYR2w77cQACN_zX8TtUz7iRarOkEw>
 <xme:Oa-jaCv4sc7H6LMR4cnbAcFTxpmX93AUk7nL5ONNKpGZFDqi6ysYK7AjpXEauYSoX
 uWz7L8k4PFJ3ff2>
X-ME-Received: <xmr:Oa-jaGhHyoZ-wIgbhYBmzGHe17hNpmSYPwxoErm0FVpJ3ge1AWx3w4RyUzmaO7w2vda5uPQtjjc-ev08gIvqVXZSbvTbtHUc1chFUd027Rfhb4xhr9EK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefkeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
 ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
 htthgvrhhnpedtgefhgfeuuddvueeuuddtudfhveetieeihfdtvdeufffhvefffeeiueeh
 udekvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
 segsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohephhhisghrihgrnhhsohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehqvghmuh
 dqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohephhhrvghi
 thiisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtg
 homh
X-ME-Proxy: <xmx:Oa-jaD-VtLcSkXoPLSoHd-4ZFUJG1nRXQasJEJrGqU3onhCr7PH-_Q>
 <xmx:Oa-jaJtD9yKC2gZJa_DYD1pq7CJuNaK0P4R4rnQpA-xEqFtZ4kPkxA>
 <xmx:Oa-jaHqZJ-9F9C9h1hiybBsaJRJ0kKs0TQ1-aMx8WBknmiBQ6s4L3g>
 <xmx:Oa-jaNry75B7Z6zsnzKr9n7Ab051LpgMK9ihvLjRsjxWDJKlpVeOlw>
 <xmx:Oq-jaE_hOiPWYoWAYSvCmcLZk56fvJZLNHZeCb6qpvwzEfdc01LEyZUn>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 18:54:48 -0400 (EDT)
Message-ID: <a30f7931-b20c-4a5f-846f-62de61545942@bsbernd.com>
Date: Tue, 19 Aug 2025 00:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] block/export: Add FUSE-over-io_uring for Storage
 Exports
To: Stefan Hajnoczi <stefanha@redhat.com>, Zhi Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250817134527.GA321129@fedora>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250817134527.GA321129@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=bernd@bsbernd.com;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 Aug 2025 20:50:00 -0400
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



On 8/17/25 15:45, Stefan Hajnoczi wrote:
> On Thu, Aug 14, 2025 at 11:46:16PM -0400, Zhi Song wrote:
>> Due to kernel limitations, when the FUSE-over-io_uring option is
>> enabled,
>> you must create and assign nr_cpu IOThreads. For example:
> 
> While it would be nice for the kernel to support a more flexible queue
> mapping policy, userspace can work around this.
> 
> I think Kevin suggested creating the number of FUSE queues required by
> the kernel and configuring them across the user's IOThreads. That way
> the number of IOThreads can be smaller than the number of FUSE queues.

Sorry, had been another week off last week and I'm only slowly catching
up.

Regarding more flexible queues, see here

https://lore.kernel.org/r/20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com

And actually forgot to mention the corresponding libfuse branch for that:
https://github.com/bsbernd/libfuse/tree/uring-reduce-nr-queues


Bernd

