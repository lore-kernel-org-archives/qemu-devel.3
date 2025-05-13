Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A3BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEn3E-0001b9-Ut; Tue, 13 May 2025 06:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1uEn3C-0001ax-Pu; Tue, 13 May 2025 06:39:55 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1uEn3A-0002Ru-1p; Tue, 13 May 2025 06:39:54 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id E128D138012F;
 Tue, 13 May 2025 06:39:47 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1747132787;
 x=1747219187; bh=2m/qLciOSGGfLMM3ptceEsdf8jAHZ2b9ZfvD9YqixO4=; b=
 SEjsmc87imh9toPgc4XPc+GImFYzZ4g4hDd3a37WWVZlecjDxevVlntffKkD/QeT
 I64Gk/2KNY/PxmIErPysnUx+KBFvtIzgojwfKiw4XCCNnblNcxeet9h8k+9kQVDA
 7Qj/qhJRhNuC3dRv9EKbm/q0iC6Td7bTKkQqa2pYmbZcuzwbf+G4aGZ5ZEjT8fzj
 /Nis20eqpWPzWKHt6NRTzZFk/SDdqmMTlkl4Ixlr6XNDyvXWjJRjT31Lm0BykqKN
 SV636n5dWgc+u3CHzhS8a2MiKVQxhgsjWLHJZRYwKbsBin/Dx+mX41Od8GokTeWn
 SFd0Pje/ttNQBNGYQWt61g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747132787; x=
 1747219187; bh=2m/qLciOSGGfLMM3ptceEsdf8jAHZ2b9ZfvD9YqixO4=; b=Z
 oulVq6IyhjAd4OnUslga1mLcUMxtQ88Zzn/696+SnPZxe36xk7JD1yLlELcE0nTE
 1vWXtcKh6bV/GYwfuX1HOOR0sV7p+NJztUkdG5E9/PDjkkuSfYWN6xsaghXVRss8
 8wM7c6zLBxbg/cS6eWSc0wWglXCC50WRqw9Yjn+HtXvJIJJu8KCZqNSf1uNWmeQK
 k8yey4fFTxIu2siQRd2ESCjaK7lpYgmF5cKzhPo8zXcqcP+6t39IhDU1ngAanQbc
 xd77FfNDKdhdZvOy6xM3UqZZu174owP+PPxX7UTSrhZTCzy0rJRmcXuj8ers1f11
 9sSW1rc533fZt7jeV4ZCw==
X-ME-Sender: <xms:ciEjaEqKtiKfRQjhkiruMDdSuJZGJ8yXoEQv12aFPoUMtwjYxxxFSg>
 <xme:ciEjaKp5Jbjo4CPO0Zd5BXSckfTkny5BjmHJCfjDQmL1E417YsdFvbJxCUUTr4ZOB
 AEAcoPYJ8I1okE-6jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
 tddtnecuhfhrohhmpedftehlvgigvgihucfmrghruggrshhhvghvshhkihihfdcuoegrih
 hksehoiihlrggsshdrrhhuqeenucggtffrrghtthgvrhhnpeefvdeikeegkeeiieevleeh
 feejgfetveetvddvhfeuleeuhfduieelieelieehieenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrihhksehoiihlrggsshdrrhhupdhnsggp
 rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegurghnihgvlhhhsgegudefsehgmhgr
 ihhlrdgtohhmpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtph
 htthhopehhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepqhgv
 mhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqphhptg
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:ciEjaJPhW599u5SpwOnUjSt0IbSKrys-HfAEtxRaeRltKfghDASnqQ>
 <xmx:ciEjaL6JMBlyFUJa4h4iAiix_zEjtxsFjQAYq-pqzmG0F7Tz3TNavw>
 <xmx:ciEjaD4e11CjvCWblx4ILDPfxMcvn-izlV0fOgFdK4tlcaibqeUiYQ>
 <xmx:ciEjaLgw0tbU5o8RqfmEHjja8Inki2kpDkmaHmL3xt4rhyUqK5ZF2w>
 <xmx:cyEjaH3bkhuFnvBSfNjKuV_rdEbk1gST6GRX3VZIVlF9Jr0ybbzVU-KH>
Feedback-ID: i6e394913:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B44781C20067; Tue, 13 May 2025 06:39:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T172d9715ceaaf74c
Date: Tue, 13 May 2025 20:39:25 +1000
From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Nicholas Piggin" <npiggin@gmail.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Message-Id: <2bdfcf77-ff5d-4c26-839e-23f831f4abe1@app.fastmail.com>
In-Reply-To: <cacfd877-8a93-1a1f-21c6-43743cc1bfc4@eik.bme.hu>
References: <20250423101931.A0A6B55D23A@zero.eik.bme.hu>
 <cacfd877-8a93-1a1f-21c6-43743cc1bfc4@eik.bme.hu>
Subject: Re: [PATCH v3] ppc/vof: Make nextprop behave more like Open Firmware
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=aik@ozlabs.ru;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On Wed, 30 Apr 2025, at 21:21, BALATON Zoltan wrote:
> On Wed, 23 Apr 2025, BALATON Zoltan wrote:
> > The FDT does not normally store name properties but reconstructs it
> > from path but Open Firmware specification says each node should at
> > least have this property. This is correctly handled in getprop but
> > nextprop should also return it even if not present as a property.
> >
> > Explicit name properties are still allowed because they are needed
> > e.g. on the root node that guests expect to have specific names as
> > seen on real machines instead of being empty so sometimes the node
> > name may need to be overriden. For example on pegasos MorphOS checks
> > the name of "/" and expects to find bplan,Pegasos2 which is how it
> > identifies the machine.
> >
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> > v3:
> > Keep phandle properties
> > Changed commit message
> 
> Ping?
>

sorry for the delay, looks okay to me but (probably was answered but I forgot because I am slow) I still do not understand what is adding the explicit property called "name" so vof_nextprop() needs to check if it is the actual property. Thanks,


> Regards,
> BALATON Zoltan
> 
> > v2:
> > Fixed a typo in commit message
> > Simplified loop to get next property name
> >
> > hw/ppc/vof.c | 50 +++++++++++++++++++++++++++++++++-----------------
> > 1 file changed, 33 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > index 09cb77de93..10bafd011e 100644
> > --- a/hw/ppc/vof.c
> > +++ b/hw/ppc/vof.c
> > @@ -353,34 +353,50 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
> > {
> >     int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
> >     char prev[OF_PROPNAME_LEN_MAX + 1];
> > -    const char *tmp;
> > +    const char *tmp = NULL;
> > +    bool match = false;
> >
> >     if (readstr(prevaddr, prev, sizeof(prev))) {
> >         return PROM_ERROR;
> >     }
> > -
> > -    fdt_for_each_property_offset(offset, fdt, nodeoff) {
> > -        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> > -            return 0;
> > +    /*
> > +     * "name" may or may not be present in fdt but we should still return it.
> > +     * Do that first and then skip it if seen later.
> > +     */
> > +    if (prev[0] == '\0') {
> > +        tmp = "name";
> > +    } else {
> > +        if (strcmp(prev, "name") == 0) {
> > +            prev[0] = '\0';
> >         }
> > -        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
> > -            if (prev[0] != '\0') {
> > -                offset = fdt_next_property_offset(fdt, offset);
> > -                if (offset < 0) {
> > -                    return 0;
> > -                }
> > -            }
> > +        fdt_for_each_property_offset(offset, fdt, nodeoff) {
> >             if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> >                 return 0;
> >             }
> > -
> > -            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> > -                return PROM_ERROR;
> > +            if (strcmp(tmp, "name") == 0) {
> > +                continue;
> > +            }
> > +            if (match) {
> > +                break;
> >             }
> > -            return 1;
> > +            if (strcmp(prev, tmp) == 0) {
> > +                match = true;
> > +                continue;
> > +            }
> > +            if (prev[0] == '\0') {
> > +                break;
> > +            }
> > +        }
> > +        if (offset < 0) {
> > +            return 0;
> >         }
> >     }
> > -
> > +    if (tmp) {
> > +        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> > +            return PROM_ERROR;
> > +        }
> > +        return 1;
> > +    }
> >     return 0;
> > }
> >
> >
> 

