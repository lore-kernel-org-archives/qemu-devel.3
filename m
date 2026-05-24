Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE20CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREgQ-0006MZ-8k; Sun, 24 May 2026 15:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREgN-0006Gi-VR; Sun, 24 May 2026 15:40:20 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREgL-0001pf-Vt; Sun, 24 May 2026 15:40:19 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2012A140010B;
 Sun, 24 May 2026 15:40:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 24 May 2026 15:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779651617; x=1779738017; bh=E+0j3GiW0cE7+sw5g7GQar51PGx8bTEZ
 0/2YDrLRP/4=; b=vF6F8mZnf7oNRhnwTfsDvMAn2u4nnxeuR7E1Di3fpIUqOK8b
 kzthBQapD+7vAsReNi2DuHWDvqRu7QDxzrtPrmRghObRisXLi9YTOYJsgLG9mw8Z
 o0+UrG+MVnedHQF8h/oofJGcmwelvcWNyVEduzwxyyL8tj58QZZe+Loerv5+smJg
 YjLmNGUOXNpySZlDAbIFVWYlHO1nxmClyGKQiTrZuADhP6XMCx4oUJJSM1kgp1ce
 OFQ4c5pAcqWK7TrpWmXYHHTkRuOdEMWyVXohthY0e15RxsTEpvbEjUAfsS6wBCE1
 H7mdpmwRt9t+IgM95EL0o9e+ok13EJHHr00Y9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779651617; x=
 1779738017; bh=E+0j3GiW0cE7+sw5g7GQar51PGx8bTEZ0/2YDrLRP/4=; b=f
 L8XqGAeVa69Pdc041bvYWZr+YyLcAW+obxBixzZXDDomeG472UamJtHZm+b+2qXb
 Ioeg5Xx3awg73A/I6bJhn/8upmORcUXJ3/59QN9GqwvmxRC1AGfdO24DsY5f8++a
 yFDjQiVVQiyRsuS/hmq3Rzyf5c9lsJ+vZlgQdfQdMu/A5bu2vilq0Bj6Mt/Tm9Nr
 TPaS11KIblsNf7Bpterk2d1eeG9IgBFBtNpYbAmstFJFdZBSVnscER5oDapT/wyM
 eXGgoH4tnpDwREWBhsrugJjtf4UNzQCbup8eqw3vV12qzcgO73chmrahDWzXML2z
 tMz28JSjKY989F6QAz9GQ==
X-ME-Sender: <xms:IVQTarLAbL1LH4FgnbPPFBT0RXpeF60nuS_Vn6B-HuOGX94bBpZaXg>
 <xme:IVQTamK4tL-I_LWxZIsPn853ZZfF1uH9g0JZQjY8qPXXz12ow4HJ3Zn6MWjKxKKk1
 hkzowOluE-xRQ7AZXaESk514ewtCO2fW6-r39PaatypbxKuB5TJqRQF>
X-ME-Received: <xmr:IVQTaoub3GGIgPsGvYx_ZHKdIqcIAtvjwemTZ319luQ4bqd86COAHF4FiZr6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheeijeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegtfffkvefuhffvggfgofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeffiedvledtveefjeejhefhvdeg
 lefhkeeuieetfeeivedtgfeiveevuedvhfffveenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhdqsghouhhntggvshdotghhrggupehjrggslhhonhhskhhirdighiiisehnohhnghhnuh
 drohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphht
 thhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:IVQTajQq8aUf5aifAlleJ1YYlfuaiUkEQJNd07BqJUma0QF0veFMhQ>
 <xmx:IVQTauPlygDrnMzeubCfGfv3lToyLC0MAcbPA8HKybv9ssrlMzErgg>
 <xmx:IVQTaoYhyLaZoE-fExhqPrrh_k47sB3pJfVRjykhjP_2uUSQJFJYVw>
 <xmx:IVQTaoy9x0TLG3VySaetJVN_F8cDbAS6HFh4cS0gwQS4NaZh77XNyA>
 <xmx:IVQTarTW__NlFTZO87BThdKEAWZ9mRgITcytirXoWqO45HzH9Vd-vD_b>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 15:40:16 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 54ea24df;
 Sun, 24 May 2026 19:40:16 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 May 2026 15:40:16 -0400
Message-Id: <DIR5UHUDHR6Y.1XFA4FB32DHMQ@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v2 3/7] ati-vga: Implement PM4_BUFFER_CNTL register
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-4-chad@jablonski.xyz>
 <06149317-8f88-7424-ebe9-c226cee1f711@eik.bme.hu>
In-Reply-To: <06149317-8f88-7424-ebe9-c226cee1f711@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>> The PM4_BUFFER_CNTL register is used to set up the CCE FIFO. These are
>> straightforward reads and writes. Future CCE patches make use of this
>> state.
>
> This register does not seem to be documented in Rage 128 Pro register=20
> reference and the ATI M6/RV100 seems to have different bits. Since the CC=
E=20
> is mostly used by Radeon drivers and there seem to be differences I wonde=
r=20
> if it's worth implementing CCE for Rage 128 when it's not the same as the=
=20
> Radeon one and should we insted target Radeon CCE instead? I only know=20
> about the MacOS driver that uses CCE with Rage128 (maybe some Windows and=
=20
> more advanced Linux drivers exist) but all almost all Radeon drivers use=
=20
> CCE so that seems more important to me. What do you think? Did you=20
> consider the differences between Radeon CCE?
>

Yeah, this register isn't documented in the register reference. This was ba=
sed
on the Rage128 Software Development Guide (Starting the CCE Microengine), a=
s
well as the linux r128 driver (r128_cce.c). It seems to roughly correspond =
to
CP_RB_CNTL in the M6 Register Reference but you're right, the bits are
different.

The Linux r128 driver does use CCE by default. In fact in order to use
that driver under QEMU I've had to recompile it with CCE disabled.

I don't have a great sense for just how different CCE setup for the two wou=
ld
end up. We do have places already where we conditionally change behavior
based on the chip. It makes me a bit nervous that things will get out of ha=
nd
if there are large differences. But this may be a larger issue that we
need to tackle as we understand the differences a bit more.

My thinking was that r128 is likely to be simpler and has a documented proc=
ess
for initializing CCE. It would create a framework for CCE work on Radeon to
follow.

I'm not totally opposed to jumping to Radeon if it makes more sense though.=
 Are
there specific OSes/targets that you're thinking of for Radeon?

