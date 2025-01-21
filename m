Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA3C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taC2p-0006yN-Dd; Tue, 21 Jan 2025 06:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1taC2n-0006xs-0d; Tue, 21 Jan 2025 06:03:41 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1taC2l-0005iz-8M; Tue, 21 Jan 2025 06:03:40 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 48F9C254019D;
 Tue, 21 Jan 2025 06:03:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 21 Jan 2025 06:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1737457416;
 x=1737543816; bh=q1ZP9/03USQz16X2Ct+K2f6P+e4Ndh+3J3jfR/ShJ38=; b=
 IUiHO5S67Po3QIyXk7mvhQ7y/yvZXS72j9RCKEb1vJQ5pTohP8UPKQlFVG/7HWoh
 OKmZ9Ci6l+HJsMPlIoAghQKNFZnidFX27XgwF9s3SQwlShiNC2FWPriPjenTr36Q
 4TJCDpJWDfDu9xMq8uOCUYs7vAgWl8xB4vbUU2oOHBqIscmcZYwvXzavp1HHgpI3
 nlCeDBIwlENbCCEnHLIcHUQcZ5iTNZoBFiCstX3NLxUWMQCVgRTA4iqfS5iiw5C4
 xzJCqikmkV2srQ3tgMu2bVaA8lY4tDdCGY9LUA0LfkLV4qRJt4C9gb5TEztvar9I
 H7OUIhCmFs6ZQ1002zNGmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737457416; x=
 1737543816; bh=q1ZP9/03USQz16X2Ct+K2f6P+e4Ndh+3J3jfR/ShJ38=; b=e
 kP7Wm/i+nTJ6KFTAsvfEkHo4TScJiEW+98KtLwQfaA64H+OM1H32P5b9MfG1qCy0
 z77Uv47dRloVtyotab1z0ox9k/50/EV+SqomOvDmFdM1UeN/dauGolrNrNIsGMl1
 zzmo8J4A4mdtycMq70HF/2OnCo8TnKr0iAAxgV7MoOkzwvXSyCvxb7O8Uo+Ugg77
 Fixxi9+uxjhe4FtVOxFh1KWKdqPwtbWu2ELKnIPXY8WA5Eyk8gceJ2pGNjevG8C8
 dMl7cGA3vf7Un4FbZC6KcA5mGJDXwMuoZqwN2v9v1idRkpEAJS+58ft/Tiab9shv
 HMNi1jbOQXeaek0uuclhg==
X-ME-Sender: <xms:B3-PZ8XmQ6-xgl6bGD4gezfnxGwjwaCyEskkTkrBh-wYCSrmFRRRHA>
 <xme:B3-PZwlc0HwTLraGmXFL5uyqFRAiZIw_1r7RUTkm0Fi5N1CQD5YGe_pc_j3mhO6eT
 IpXDwo_IkMYyKQImlk>
X-ME-Received: <xmr:B3-PZwaeE_X64UhANoWoXdSZ_2_IFXT-kC5ZFc4y838gHw80DJfu9z2WB2Qo0YYyQ-CGRiARZaIpzpIMpFyMMJ6JiDzNBa6vBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejuddgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
 necuhfhrohhmpeflvghsphgvrhcuhggvnhguvghlucffvghvrghnthhivghruceofhhosh
 hsseguvghfmhgrtghrohdrihhtqeenucggtffrrghtthgvrhhnpeekteekueelkeduueeh
 vdekvefgheeigfdvfffhgfejheeivdegfffhueelfffggfenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfohhsshesuggvfhhmrggtrhhordhi
 thdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:B3-PZ7UYvx9WquMT3NEylqn1kIgi9mZQ10Pogb3CfDV-XqNTwOi26g>
 <xmx:B3-PZ2nnry00BL-VvvbbUS3mZgENWbCm6sqmeWa_HwhbO-vselgK9g>
 <xmx:B3-PZwd6gGGoJgd25XVQm_aaD1rvAlNtqpl3t15JTWGRL8L18J08_w>
 <xmx:B3-PZ4HQZ_TVzJqh_B2zPUfUU1gDQgP-W26z3ooFul4CZIU6-Y2lKg>
 <xmx:CH-PZ9s71lC-ut-KaFFLxDVZFCzlbHqQCOKOsRUHBEGyF52gKyGZ7W7v>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 06:03:34 -0500 (EST)
Message-ID: <49517f53-d2f7-4143-858f-7400bbf7e6f2@defmacro.it>
Date: Tue, 21 Jan 2025 12:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/nvme: refactor/cleanup
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
Content-Language: en-US
From: Jesper Wendel Devantier <foss@defmacro.it>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=foss@defmacro.it;
 helo=fhigh-b7-smtp.messagingengine.com
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

On 12/16/24 13:53, Klaus Jensen wrote:
> Apart from some random small fixes here and there, the major thing here
> is cleaning up how we handle command sets. Prior to this series, the
> controller would not correctly validate namespace command sets against
> CC.CSS. This is fixed here.
>
> The most clean way of doing this (as far as I could tell) was to make
> sure an nvme-subsys device exists (creating it if necessary). This
> allows us to "store" the namespaces in the subsystem, using existing
> functionality, and attach supported namespaces when the device is
> started (instead of when the device is created/realized).
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Klaus Jensen (9):
>        hw/nvme: always initialize a subsystem
>        hw/nvme: make oacs dynamic
>        hw/nvme: add knob for doorbell buffer config support
>        nvme: fix iocs status code values
>        hw/nvme: be compliant wrt. dsm processing limits
>        hw/nvme: rework csi handling
>        hw/nvme: only set command abort requested when cancelled due to Abort
>        hw/nvme: set error status code explicitly for misc commands
>        hw/nvme: remove nvme_aio_err()
>
>   hw/nvme/ctrl.c       | 430 ++++++++++++++++++++++++++++-----------------------
>   hw/nvme/ns.c         |  62 ++------
>   hw/nvme/nvme.h       |  10 +-
>   include/block/nvme.h |  22 ++-
>   4 files changed, 276 insertions(+), 248 deletions(-)
> ---
> base-commit: ca80a5d026a280762e0772615f1988db542b3ade
> change-id: 20241216-nvme-queue-f4151c5d7507
>
> Best regards,

Read, looks good to me.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


