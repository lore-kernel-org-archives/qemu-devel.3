Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF34D19511
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYuF-0002sP-CP; Mon, 26 Jan 2026 21:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkYu8-0002oo-2o; Mon, 26 Jan 2026 21:34:08 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkYu6-0000ec-EK; Mon, 26 Jan 2026 21:34:07 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 37184EC04E0;
 Mon, 26 Jan 2026 21:34:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 21:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1769481245; x=1769567645; bh=caDPRDgLChyzJGS6BMBPV3yp4zNq24VS
 L5ShuQM++5A=; b=hGBVm6J4bWhWlPbKUmUfA2F8Yv+R5n14Uj5SaCXKPqz6fPA2
 lQJBCkj/7GiY+956xL06Ir90eOPTZiuDWfAXMBk9Qfes+FZWfKtQ0b3vDRmSamr5
 ljU5yoNbBvM/mK2Q3j1avRIflxcJ2KR+wvUlxEyRWIn8TfMUW2PliHLGPSarYNti
 SC8oYQsstunHcqbI7xC9FCMciOJRrcrgIwd9796QriwpCMja+w46l5Rk5b7mfThq
 w0VV3pGYl9Alk+bXfzbneQmJ2ud0SVI5ldbxtDiifgugpKAEA5RUTH/ndlcCnUSi
 A1mIivKBZLiT6wrACWM2A3w35VpIo+4jupg/NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769481245; x=
 1769567645; bh=caDPRDgLChyzJGS6BMBPV3yp4zNq24VSL5ShuQM++5A=; b=U
 TGth114gzn/y3CcWZgITunMVKgaw4LrlhZaHtWkR0/aIwZz3/3QlJIbZjd/XpVAG
 uzyRZd9HeQMH9sWj1DGviaOUbCb4kejveaYuBiE4EoFXfS/LzkHexPkaV5RPmVog
 heHbcKITNmCJXL9ydLNb/Nx134KZBeZZffNJ6ls4sQbZ/VP3l7kpmZOoh2c55B9g
 BMnXhXOSnZJ+N5Shoeme9NsajjJEIoFlV/Z/Q2Iqh+RFY1TMELz60uorqZezV83T
 Tb+FynANKy3vd/x1YbEBF5Lk7JmOxXD+wjTl80+eoggJ8QttAI4+j0R6QK2jSEI1
 y0ndI3BJnveQ/u2WLO4Dw==
X-ME-Sender: <xms:HSR4aSZZ1VmulPjFKsYRMQOevX_hAmN9d0XIUbbat1r50CVLy-6Nmg>
 <xme:HSR4acbZJXSyemsgHN4UZKslP3NBDH1CvuDV7oGkwQuQphgd0-4OMtIOtkK1cOsZO
 zQCNHGW7lWsnD4nnXxnoYESWPLzgln6gJVll9wKAccNNCl1IeMv8Ouo>
X-ME-Received: <xmr:HSR4aR-rN1rOBt0iy58F3ketdlAaPgdzGYnSaHdx_00nSckNG8yoPj51Lm25>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlqdgs
 ohhunhgtvghsodgthhgrugepjhgrsghlohhnshhkihdrgiihiiesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohep
 qhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:HSR4aTjEJemDGfPtHmyyzmbA3MI4Qy0iU3CMPMoZtwBIqUIOrqyShg>
 <xmx:HSR4aZcRQFSU2H9QzobwvjfIkcSFuujaD31kNIz-L9EXWEo4BQyWWA>
 <xmx:HSR4aSp13-b4Xe7V5D9i8I3vYfxSlku44UZ2fWUy1FpPG7Y9qz3JHQ>
 <xmx:HSR4aWCyCwdtA2ot_F6hPHw_gdS7IVrYVckAcDlts5oa6p3IIRbPPw>
 <xmx:HSR4aagTqI5EegTBThJOoaXFNIpdUzqkeKgqWJwwW-EECLHeXFIlK7dK>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 21:34:04 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id fac0b7fe;
 Tue, 27 Jan 2026 02:34:03 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 21:34:03 -0500
Message-Id: <DFZ0R1EMPYIZ.1323WYF0N6LIZ@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v5 10/12] ati-vga: Implement scissor rectangle clipping
 for 2D operations
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-11-chad@jablonski.xyz>
 <9fd1e0dd-a8e1-6548-d62b-cac163e621ce@eik.bme.hu>
In-Reply-To: <9fd1e0dd-a8e1-6548-d62b-cac163e621ce@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.146; envelope-from=chad@jablonski.xyz;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>
> Is there a bit somewhere that enables clipping that needs to be checked=
=20
> here? Or are the sc regs always expected to have meaningful values and=20
> clipping is always done?
>

There isn't an enable bit for the primary scissor registers. There are howe=
ver
enable bits for the aux clipping registers in AUX_SC_CNTL. In fact the xorg
r128 driver when initialized sets AUX_SC_CNTL to 0x0 (all aux clipping
disabled) just before also setting DEFAULT_SC_BOTTOM_RIGHT and SC_BOTTOM_RI=
GHT
to their max values.

We will need to handle the aux clipping eventually but this patch only
implements the primary clipping registers.

>> +    if (!vis_dst.height || !vis_dst.width) {
>> +        /* Nothing to do, completely clipped */
>
> It's less clear what vis means so maybe this comment could clarify by=20
> saying Nothing is visible, completely clipped.
>

I'll make this more clear!

