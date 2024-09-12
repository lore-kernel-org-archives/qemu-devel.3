Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D46EEB560
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofBD-0005Cv-MW; Thu, 12 Sep 2024 04:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sofBB-00053F-Ep; Thu, 12 Sep 2024 04:27:53 -0400
Received: from flow5-smtp.messagingengine.com ([103.168.172.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sofB8-0006kh-U2; Thu, 12 Sep 2024 04:27:53 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 38F432001AC;
 Thu, 12 Sep 2024 04:27:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 04:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1726129666; x=
 1726136866; bh=Xsf9ae63fQV1tLsIn2cFPWGsIOLkkinD3TZg82l4IaU=; b=v
 te8cmle/zMi5ovvDxUYfo6aV1sThzymxGhlvDMlHhXH2Vxvr3nw3rtMWIBw6Y+vX
 d+XdcM2M7+RoH4/vgSYx2Fm8rK7Tmf0Rh6n6+VNlth2u8W3IfeHRiA6NHPcZgsxo
 juDO2XLKZ2ybbz0aUtrmJLJvVqvNLyc/+JyfsACZxDrlfICTStJietYJK9PM7z8z
 /PasONfwU9eceGwH0d7oJqLNoZNn5AD6d+4PQ8hO096QeWfAIznxnJoYu4QqNqTn
 EF+5EqbT8dhfBRt2RZjeHIeEHBURT/WFpo9Q3VkZcqno9WpyXk0u4EZNdjvSNcJX
 QnzTVTKwrB21x098t6Y0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1726129666; x=1726136866; bh=Xsf9ae63fQV1tLsIn2cFPWGsIOLk
 kinD3TZg82l4IaU=; b=kxzadh44Ag7Sg+wWD5sgxEE7VKM0hAH0n1vkUXwBO/R3
 R0rxP2xCTXkC2hMGlUgofpHu++z8KJR3KvUpSWEplHU94xQojvQbE2kuiUQwPi5F
 GmfKh91skz4cYaNk06regQ767449fD5YbmCGZBb+3hSEdxQj4QcKkNDCszG9+PXB
 u7kF6wUMcyUdx00566GnM2JO+jDpL2purxWNlzH/dJ5iJ/YL8DHUAHygEk2ikVxI
 jmRe4T1YX4NdAElwxv/ym+Yusv5JR4S927yLsLI0sRDxDfK9PzvDdsr5+XXSXiew
 MXzGZlju/sihZ3wm87eyfcHxVM5SA88HYu0tNw3tmw==
X-ME-Sender: <xms:_KXiZgG6H0I3zOZWTojHw1H_OHbn3t0236rww4TTf-_9s5rlQPG12g>
 <xme:_KXiZpU0gUc5Hmb8lfylhX8rHXEg0I_CeOymtK2BHlJBJchionaewikUqERn_Y2o0
 p_laacxOzQMcvfLWlA>
X-ME-Received: <xmr:_KXiZqKZ_S2s_Bkb5lS2zhDUXrPkhVko1wiO9bFScvyOlaUNaF88Vjr4-5RIOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgtdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepveejtdejteevfefhffehiedvffdvudelvdeigfek
 feevledtieetffehgeeggfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepieehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpihgvrhhrihgtkhdrsg
 houhhvihgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrd
 gtohhmpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhtoh
 hsrghtthhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
 ihhlrdgtohhmpdhrtghpthhtohepghhithesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtoh
 epphgrshhitgeslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:_KXiZiFiPc8R1rYhcfi8lBa8w9onIaCYENkAzORPkX-mhtnnk_N1pw>
 <xmx:_KXiZmUy_LNrz3YrYxScEUQ6j3JBmCaRwtXADraQScbRsIUPPHwoRA>
 <xmx:_KXiZlPPqsP_QOKnb8J5PKDziMCewAWhVZP-Ve9DEhjBd72f8_joag>
 <xmx:_KXiZt1pIFNJBbrQ_ZsiOUqX1-5wuIrUc86SpQRRmm5eP_O7bgvt5A>
 <xmx:AqbiZve8YRRpE8YPHhV39Vayh3sF8c3gzhOWNAmYPtBtsl3f9tK91htv>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 04:27:39 -0400 (EDT)
Date: Thu, 12 Sep 2024 10:27:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, WANG Xuerui <git@xen0n.name>,
 Halil Pasic <pasic@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 Michael Rolnik <mrolnik@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Corey Minyard <minyard@acm.org>,
 Keith Busch <kbusch@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,	Hyman Huang <yong.huang@smartx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>,	"Michael S. Tsirkin" <mst@redhat.com>,
 Helge Deller <deller@gmx.de>,	Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Joel Stanley <joel@jms.id.au>,	Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,	Fam Zheng <fam@euphon.net>,
 Weiwei Li <liwei1518@gmail.com>,	Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 18/48] hw/nvme: replace assert(false) with
 g_assert_not_reached()
Message-ID: <ZuKl-vucvRaV1hU3@AALNPWKJENSEN.aal.scsc.local>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-19-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912073921.453203-19-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=103.168.172.140; envelope-from=its@irrelevant.dk;
 helo=flow5-smtp.messagingengine.com
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

On Sep 12 00:38, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/nvme/ctrl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

