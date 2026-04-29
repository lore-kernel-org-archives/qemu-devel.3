Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA53FFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI8sK-0000iK-0f; Wed, 29 Apr 2026 13:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI8sF-0000i1-Lx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:39:00 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI8sE-00088D-97
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:38:59 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id A9466EC0173;
 Wed, 29 Apr 2026 13:38:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 13:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777484337; x=1777570737; bh=Am/oLMBWtNf5BvWpjOv4hm0GPV17ex8b
 8T84V2D+xWM=; b=hIIivx788GFsOEu06qvsNCLZCZQJL3JllT2b33FvJAXnL4Xc
 W6+ew4L+9+Vll47rD5XLdO/pIl5qrGcVexbZE4sDnJ88odto2R8Vc5onmyfhvyHk
 QJAzN1wqulegcRctwD5MD08bU+FEithI2Ve1Ja0AMw7//Y+WEGYe6yx8VAarsb+s
 XjKt91RygED7EE9QAoLZhhdQ95iGdwryZVCyrLx4TKxlXKCkIR1O/PX5kK96NFTx
 Hak6Qo7vNIXmOiqRNOFpVRBXK5m9O0kROS4LTLSSKpNYsov8C9a0TtP23mQxwvEm
 vJMTg5EmiAcrvjczL2WQXe4M4WvNjAvPeDMaUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777484337; x=
 1777570737; bh=Am/oLMBWtNf5BvWpjOv4hm0GPV17ex8b8T84V2D+xWM=; b=h
 faXy+DS4CVG/HzZcJKfYEIiIktqE903Q9shTs7j+rpvxL5VyEd7uS2bz+i3Ed6jr
 Ee5poxLPhnQqtAqJv6J17/6pOBH8RqNwJmKKjZBycKlcU9y21qPPc+P2ruuAeEUb
 Is7Up0wSJMjKgOkn4lIAqL04+ng7pul2hBHIEviQHzhtS0Igc4ngLblB1p/H9aQJ
 mUV5jXVyUi9E5R1kpgluEiDio4ixANpfiWK0nQiwxoDUq1uqZ2RwYcPFutpYucIQ
 CrkPylhdffqvR5exzBo9W3CnZf+yuG4QDasbdDZSIfDrXSIr6ow0YKS4T11bIWQX
 BbKYvFhjZsxOXSCG89FqA==
X-ME-Sender: <xms:MULyafmr0QlL1_Rqoj48zfYeCEP3z7w1d5gBCvSNJKVDXtKpDaWtOw>
 <xme:MULyaeWBZqkc_eXHQGlFZQ8e1kVEJXyBYI1FE9WIeS6FHT2xAWIaYlCUjtsLR7fqf
 mLPY8EpAcT3i96OEK8hWON27ME_ktopqHYjMv8vW91iMhiEdC1G3Dc1>
X-ME-Received: <xmr:MULyacE2FhQR88QWOnPDpNQliVUFavcXjr5FUkZnoUMGJw5jo91ctBxLTth->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekhedtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepkeffkeduvddtheejudfhkeetteeg
 vdefffeiuefgfeffveehgefgtdekueetkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrug
 esjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehkrhgrgigvlhesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrth
 drtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:MULyaSdzqI-WJJD7ckwgd4r9fAyT6BgRh1OsZ1UD2USjy0eQpnqPsA>
 <xmx:MULyaVJrHoBUfqBmeFOZawXZfqOUH8I5zLZQ1IaqQfkAqrdfVFDv8A>
 <xmx:MULyafGlMEPmk8SMXPwaU9NAT9wLdYGHzliobcNul8gsA-GIT6FrNA>
 <xmx:MULyaQBvakCvyInwuG9QtGCBne20zf6PKJEOTSvbbIxFmb-1zu1igw>
 <xmx:MULyaaC-nKAuPRZTvsX3m2r5guxOgLonFfeGVtXtbKw03MLQ_sR7Wypj>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 13:38:56 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e356a92e;
 Wed, 29 Apr 2026 17:38:56 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:38:56 -0400
Message-Id: <DI5TLZB5BUHN.3EVV3B79DTS8A@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
 <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
 <6d7f3031-225b-31d9-dcca-45e34ba61783@eik.bme.hu>
In-Reply-To: <6d7f3031-225b-31d9-dcca-45e34ba61783@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=chad@jablonski.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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
> I've found a case which this patch seems to fix and does not involve=20
> panning (unfortunately I can't give a reproducer as it is with AmigaOS=20
> that isn't free) but I don't understand why and what exactly happens.=20
> Maybe updates are missed when guest updates display by directly writing t=
o=20
> VRAM? But such writes should cause region to become dirty due to=20
> vga_dirty_log_start() called at the end of vga_common_init() which we cal=
l=20
> from ati_vga_realize(). Without this patch after a mode change display is=
=20
> only updated around the mouse where it's explicitely marked dirty (with=
=20
> guest_hwcursor=3Don as guest_hwcursor=3Doff is bugged) but with this patc=
h=20
> updates correctly but I don't know if it's just a side effect or actual=
=20
> fix for something. Maybe it's just the calculation fix and not the off=20
> screen dirty marking part, I haven't try to test it with restricting to=
=20
> visible screen (maybe I wait for v2 of the patch).
>

Interesting! I haven't run into a case without panning yet so I'd
definitely be interested to hear if v2 still fixes this or if it behaves
any differently at all.

