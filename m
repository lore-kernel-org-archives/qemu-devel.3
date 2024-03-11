Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D855C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdda-00011n-LV; Mon, 11 Mar 2024 07:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1rjddZ-00010u-47; Mon, 11 Mar 2024 07:16:09 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1rjddV-00037H-B0; Mon, 11 Mar 2024 07:16:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 643C75C003E;
 Mon, 11 Mar 2024 07:16:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 11 Mar 2024 07:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1710155761; x=1710242161; bh=pQLwKWb+Ts
 wF4N2JYtQIl1oBy1JEtChg9rKkfoidsU8=; b=UCZ3NS1ia0s0+Yo2Tvw2j7PNts
 m4ZbtxGCrvJRAj3XCZWQhy4UHV9QT4ogBK07TqHfhaVnJ+MUs0B62jpCBQBHvrq3
 DzG98hhRT9IXzfZYIDKAIo3O/1TrfuEfz3Omp1LVcf4jmfmHPZNGSte7kVRfHAvt
 0EZsRmHfX451QxHBcdclCKXInxXC8j4UbpwRVZH09r9Y0cw8qfOqcj/6RvFuHdr9
 XyUsfvlYDgG7O+mQlNbOXCuqNw2P+CkUcQt8u5DVAe0aAf/n99NV3Ylv6BX0AVB0
 pzVIj/nmufJW3N4B7jnGOKXefGg8kfqLAxf032SO3JqtPq7RrN6K+0SJAfhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1710155761; x=1710242161; bh=pQLwKWb+TswF4N2JYtQIl1oBy1JE
 tChg9rKkfoidsU8=; b=QVGaWPlIxZh9X070t4a/yk4NTvAPKdyw6SSePefcfYa7
 viM5uOPqkzIOCeYsZIQZ2UTOyIyf6JaclMCKepq0ZF0fQkkS3/Kmmy5qA443BKN5
 ihY270mpfId+EVF1bBM7+D8EgZJyZt8Ujoml5Y5k5MqNcChKOjQWyfbYI83brRAo
 sayG1daZ5tkFzU7ojqiVT/l50CMsgyjvlE2/qlHI8ELtDoNXtOrYDNpKbIFZBRnB
 0gG3brqfztVjRvaRNZFJdI2Pi0d4J96/lh0mGoHKYRU75Rssmt+zRUvG9w3DLQ0M
 f6x5tbk+XAhGe7v72KD4OhWmBfp1Gjw5IFkylj90rw==
X-ME-Sender: <xms:8OfuZYpK9Lrb2xoxlkpr9vvu01ZvZF6o4uw_3X_QdEon9RrK8IZu4Q>
 <xme:8OfuZerUKcAoc0BoTOFgedUC_19gAwSkYi4qyJnPV7nfzjUP9YsgOb2txHpiPjkQl
 Ls5CgLMy-WipkA4cnk>
X-ME-Received: <xmr:8OfuZdM7MpJlexrDdQP4IwwVeoE6sQw9smC4RQD9dz-RoiOz9l3Jw3dd0y3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugddviecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflvghsphgv
 rhcuhggvnhguvghlucffvghvrghnthhivghruceofhhoshhsseguvghfmhgrtghrohdrih
 htqeenucggtffrrghtthgvrhhnpedujeejjeehiedttdegvedtheejhfeiudetgfdtueeg
 vefgtdeltdefkeejlefgffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehfohhsshesuggvfhhmrggtrhhordhith
X-ME-Proxy: <xmx:8OfuZf52isagSpP20Hs_GWpMFPZLrvoHlU3FCL6q2g5WiNbgZbmIqw>
 <xmx:8OfuZX6iSCL8O5PGXiUOiMetfpKdr_FYrPlUxBdm5R78Y9uGojYFdA>
 <xmx:8OfuZfj_-Gt32jFMh0r4owuQwij7wreUJsVUsQLQbp2i31jI6bdeOQ>
 <xmx:8efuZUFTQ8Zao3aTD4QmUbem5qx-Wll4g5dhfqtEIBAT9rAOVsCYRQ>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 07:15:59 -0400 (EDT)
Date: Mon, 11 Mar 2024 12:15:58 +0100
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Julien Grall <julien@xen.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 0/2] hw/nvme: fix hibernation-based migration
Message-ID: <20240311111558.snthb4nvfaie4fcg@jwdssdr>
References: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
Received-SPF: pass client-ip=66.111.4.26; envelope-from=foss@defmacro.it;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Sun, Mar 10, 2024 at 12:07:24PM +0100, Klaus Jensen wrote:
> Julien Grall, in #2184, reported that hibernation-based migration with
> hw/nvme is broken when suspending on a pre 6.0 QEMU and resuming on a
> more recent one. This is because the BAR layout was changed in 6.0.
> 
> Fix this by adding a machine compatibility parameter that restores the
> old behavior.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Klaus Jensen (2):
>       hw/nvme: generalize the mbar size helper
>       hw/nvme: add machine compatibility parameter to enable msix exclusive bar
> 
>  hw/core/machine.c |  1 +
>  hw/nvme/ctrl.c    | 73 ++++++++++++++++++++++++++++++++++++-------------------
>  hw/nvme/nvme.h    |  1 +
>  3 files changed, 50 insertions(+), 25 deletions(-)
> ---
> base-commit: f901bf11b3ddf852e591593b09b8aa7a177f9a0b
> change-id: 20240310-fix-msix-exclusive-bar-d65564414a2c
> 
> Best regards,
> -- 
> Klaus Jensen <k.jensen@samsung.com>
> 
> 

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


