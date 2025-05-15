Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772CDC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 09:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFV1k-0002tV-8A; Thu, 15 May 2025 05:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1uFV1i-0002oL-6d; Thu, 15 May 2025 05:37:18 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1uFV1e-0002WM-TN; Thu, 15 May 2025 05:37:17 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 35C26114016D;
 Thu, 15 May 2025 05:37:10 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-01.internal (MEProxy); Thu, 15 May 2025 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1747301830;
 x=1747388230; bh=f7JU1N8nDEcqUiWuL/Ma7Ba9P4F1HNuCEp55qeNoPJQ=; b=
 ElNrg9HNNNW2XbFOfOmYBa4nYcuo+I7SSE5+0f0bdLZ+0oYdjz/GB90pFsSi9lzM
 Uk3qy3SgpBGzoFmbDX+/P8si61H2qk4oMh0aGJfKiFEDOR0SlxQXL7FlXXcuNy+x
 bRHLJ8JOrZ8g+kYmBX/YHJFjhIKrWy2BvgCFuh9423luKVd6k9H7uefk0ixj5vWZ
 i6BZV1N9R79m0DIjptGUtPDQUpOxPFBuJY1D2IeGEbYgyZSbC+SenrslmwR/ZzfM
 47WW45HjVPtzmc7dEHpFxRgscs6PpgPPiKqVFAZhr6mpOdJcQCZXfQES7GpyDp/e
 PlSCKRIVXp1qQ3okDbykiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747301830; x=
 1747388230; bh=f7JU1N8nDEcqUiWuL/Ma7Ba9P4F1HNuCEp55qeNoPJQ=; b=s
 Yim/W7y6rzgR8ulpKrfup+Fav75FeuKy7KmMSMD0Bn274TFMOnpes6AKReON2bmZ
 eG69PYYKqt5Z5tbPA73pStT43r+69sXNH7dMICGkmxkJcUzTd6d8T8a+x9oklPPq
 smKQiFQYWLmPDaAq7nfDcrraGmKJ3obHHQnIZhyuy1VpHv0Z+BtLqIyVXcAMxo7i
 K+Y/mAIzKjh55YF12Yn7D4CyjXZ0JVilmBnAd0qKc6qdjfaVLyFn+sFKvbctsJ/Q
 c5X3UsgL+/NIEIngl0249TLnZNHhku5TfAF5KRbibu4JbsPjsBBx6PvPp5GOp9YG
 SCFm+YPdXFOeSlZyp+wXw==
X-ME-Sender: <xms:xLUlaMR94dYODZszcXJ2xX8D48ZkNXFd5Qc9TbjTQqmHa7qpB-VfkA>
 <xme:xLUlaJzApkXrN_zqRUEpxfIWxG01rkekfdGhaToGZG-6EgIKU7Fe63WPKg88YHPpf
 3FU_nDjOTc2MfjnhHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelhedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
 tddtnecuhfhrohhmpedftehlvgigvgihucfmrghruggrshhhvghvshhkihihfdcuoegrih
 hksehoiihlrggsshdrrhhuqeenucggtffrrghtthgvrhhnpeejffegffdtleeljeevheet
 geeigfelhfehleekkedvteeugffgtdeghfeltefgkeenucffohhmrghinhepphgrthgthh
 gvfidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpegrihhksehoiihlrggsshdrrhhupdhnsggprhgtphhtthhopeeipdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgt
 phhtthhopegurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnh
 hpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrshhhphgssehlihhn
 uhigrdhisghmrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuh
 drohhrghdprhgtphhtthhopehqvghmuhdqphhptgesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:xLUlaJ2CPEghmjBIxfUZA1euMVbnVxaA8qnjIv96PpRE7lrO3jEUZA>
 <xmx:xLUlaAAXvPK3rs2y30DS2BxLguIJ7TeLUJUZsYA49u6s_Zb_-ZjHNQ>
 <xmx:xLUlaFiPA8du9a9msfitmRr4GngY81fKkg9Q9RE06zxpj8a2fvxn4Q>
 <xmx:xLUlaMq0U-XeJQ5d7faUOYJUU39YkAc6RjbWhvapbb5LxV9zgaxf_Q>
 <xmx:xrUlaH_FxtN2MXuI2N76qoB9xUZVDMSMzAQgEtGvPn3Ux0DTgjDwxFQv>
Feedback-ID: i6e394913:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8650D106005E; Thu, 15 May 2025 05:37:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T172d9715ceaaf74c
Date: Thu, 15 May 2025 19:36:48 +1000
From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Message-Id: <57b2a28d-b0b9-4618-b3a6-032ca49672ed@app.fastmail.com>
In-Reply-To: <a947a1c1-c4cc-d2bd-9a59-f5ce97c6ea1d@eik.bme.hu>
References: <20250423101931.A0A6B55D23A@zero.eik.bme.hu>
 <cacfd877-8a93-1a1f-21c6-43743cc1bfc4@eik.bme.hu>
 <2bdfcf77-ff5d-4c26-839e-23f831f4abe1@app.fastmail.com>
 <a947a1c1-c4cc-d2bd-9a59-f5ce97c6ea1d@eik.bme.hu>
Subject: Re: [PATCH v3] ppc/vof: Make nextprop behave more like Open Firmware
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=aik@ozlabs.ru;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



On Tue, 13 May 2025, at 22:00, BALATON Zoltan wrote:
> On Tue, 13 May 2025, Alexey Kardashevskiy wrote:
> > On Wed, 30 Apr 2025, at 21:21, BALATON Zoltan wrote:
> >> On Wed, 23 Apr 2025, BALATON Zoltan wrote:
> >>> The FDT does not normally store name properties but reconstructs it
> >>> from path but Open Firmware specification says each node should at
> >>> least have this property. This is correctly handled in getprop but
> >>> nextprop should also return it even if not present as a property.
> >>>
> >>> Explicit name properties are still allowed because they are needed
> >>> e.g. on the root node that guests expect to have specific names as
> >>> seen on real machines instead of being empty so sometimes the node
> >>> name may need to be overriden. For example on pegasos MorphOS checks
> >>> the name of "/" and expects to find bplan,Pegasos2 which is how it
> >>> identifies the machine.
> >>>
> >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>> ---
> >>> v3:
> >>> Keep phandle properties
> >>> Changed commit message
> >>
> >> Ping?
> >>
> >
> > sorry for the delay, looks okay to me but (probably was answered but I 
> > forgot because I am slow) I still do not understand what is adding the 
> > explicit property called "name" so vof_nextprop() needs to check if it 
> > is the actual property. Thanks,
> 
> Look at this series where this is used (I also included this patch there 
> as patch 2 which is identical to this v3 standalone patch):
> 
> https://patchew.org/QEMU/cover.1746139668.git.balaton@eik.bme.hu/
> 
> This patch allows removing explicit name properties in patch 3 and move 
> the static parts into a dtb file in patch 4. Dtb does not allow to set 
> name property and will use the path name for it but e.g. the root of the 
> device tree on some machines must have a specific name. On Apple it's 
> called device-tree and on pegasos it's bPlan,Pegasos and some guests (e.g. 
> MorphOS) checks this to detect what machine they run on so will fail it we 
> return / or no name for the name of the root node. Therefore in patch 4 I 
> still have a
> 
> qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
> 
> to make this work, and for some nodes it may still be needed although for 
> most the path name from dtb will be correct so no need to add a name 
> property for those. But becuase of these nodes that need a name different 
> from their path we still need to allow explicit name properties.

Well I guess that ok then.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> 
> Regards,
> BALATON Zoltan
> 

