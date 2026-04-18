Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFB4F8E49F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE5Te-00024o-H3; Sat, 18 Apr 2026 09:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wE5Tc-00024P-Pk
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:12:49 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wE5Ta-0002aC-OY
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:12:48 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DF65C140007E;
 Sat, 18 Apr 2026 09:12:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 18 Apr 2026 09:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776517965; x=1776604365; bh=+9GK8TIa0RGJkfNThVKDhbJKrFGv1bXO
 aXXF8PWoFRw=; b=AWKgBhzvC3Wr/PG9d36gpNu2HiNSJZYlk7PxalCwxhYmp7Rg
 NkHRy2h3mNi/Z64kgGkwV/rn0hnWAZ+cYxnxRYaaNdv4eee2d1G59cO/oJcXbXfu
 PVfX1wx9AF1qcr0BPT8CE0jXLosgpPMpvrdbcSisnyWbyDirpkL0tNnQJBhELdJm
 DIAOyWffAIiVmSrxoGUrh2zaa05OOrxKtGLkaAFDmhlJPusENGU477TfLOD2hJd6
 G+cSCYz9s910tjXbm0DToQlg0lpeyIadgj5ZrAWlerzcin9NXtg5u+rq6MPccsiw
 IqdfbJCGxhBNNTwIwVWZ7w2WqR7rrWfwAAKBFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776517965; x=
 1776604365; bh=+9GK8TIa0RGJkfNThVKDhbJKrFGv1bXOaXXF8PWoFRw=; b=m
 CDWqpnmyh5gDojPzRMCCn95S4sMZ1y8VRQCl9+fdALjEldXsW9R7wQY2PhviVxNM
 0k2vrdc8BofjR5a/ZzGKL457TlRXDd14e5qSAtkpmypGVXbF/c2Jl+cyZEGujrF3
 5/dkg5KZhWJhmEGrsQidL8ueK8cSD2UrDzZn/kdRoYp9kd+JqukfhJpTRLaf/N3C
 jKTlYjt2XD5YnqBzlM0LPQSlJz8bsf3zKbVMwqmiZ1v4VLtvh2nsSET14ZBVFoGe
 39R+kW+mIq3XfExR78YXkvvK6oWIhuZpLPoO+DrTthH+i3++J7GwZjkc3zUDRmwt
 ibfk9jjmETu8RaHNbYrNA==
X-ME-Sender: <xms:TYPjafmBSw8B-D_Yf3gORUJ3VhZzDOmN26MscT3O0IHu8dhiF_DXzg>
 <xme:TYPjaZvzpDRC1KsQNIg67DZsmQRikrEY0FS9wUg1TihuDamPIjga47sgjI45Iua_V
 3qRnv51LL3AOMdxdnOhnatzWLZRySnzjIxcbQR9mB9gm3lCJTvwmjI>
X-ME-Received: <xmr:TYPjad-NDz2kdb1tLgq8WzAnmcGHPqsId2iCQewOOQhfKE7ymU4GUFii94uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehvdekhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdefhedmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepudduhfeivdevudfftddvgfeitdfh
 heduteethefgkefggeefhfehfefghfetteehnecuffhomhgrihhnpehnohhnghhnuhdroh
 hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
 hhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohephedpmhhouggvpe
 hsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvggu
 hhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohep
 sggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepkhhrrgigvghlsehrvg
 guhhgrthdrtghomh
X-ME-Proxy: <xmx:TYPjaTPsSqqq54yq2kOWYSbHccn84Y1OdiTiejioEHPgYM6oivKK8w>
 <xmx:TYPjabEgNgDvvQisg8oUr7ndHz6KPw4fXOWMDdsJYCKe2-ZMDd4uBg>
 <xmx:TYPjaRRLk11PCI4BvDNuvDDMKrXli8_uCNSuZ5G4tJUa8CbyAuxbag>
 <xmx:TYPjaYs31BFTovOGcD7x-2kp4Os988UF4yTrpL9K94GX8Jt0RILRDw>
 <xmx:TYPjaWIjV2OSZ-5pBRiFb0Lf3sf8WcJhA69Nu_j9VcCbsNHX0VzNjlyC>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 09:12:44 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e838d967;
 Sat, 18 Apr 2026 13:12:43 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 09:12:43 -0400
Message-Id: <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
In-Reply-To: <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
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
> I guess this is to fix chars not appearing in xterm when a virtual deskto=
p=20
> is panned that you noticed here?
> https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00785.html
>

Yep! I should have mentioned this.

>> The second is that a bounds check was also being performed to ensure
>> that the dirty memory was within the visible screen. With the virtual
>> desktop this isn't actually what we want. Updates can and will happen
>> outside of the visible screen area. Those should be marked dirty.
>
> But I still think only the visible area should need marking dirty because=
 it=20
> is used to update display so marking non visible parts should have no=20
> effect. I'm not sure if it has any performance impact but just seems=20
> unnecessary so that's why this tried to limit it to visible area. I've=20
> added to cc some people who could maybe enlighten us on this.
>

After digging into this deeper I think you're right that the
non-visible dirty marking isn't necessary. Looking at vga_draw_graphic
in hw/display/vga.c it looks like anytime the screen pans, a full screen
update is triggered. But from what I can tell the full screen update doesn'=
t
clear the dirty map. Only partial updates do that. So setting non-visible
regions dirty could cause the non-visible regions to be updated later
when it isn't necessary. Meaning the user could pan over the region, do
an unrelated blit and the stale dirty regions would also be updated. I'm
not sure what sort of perfomance implications this has though.

I think if we want to avoid this the way to do it may be to just take
the intersection of the currently visible screen area and the
destination area and mark just that as dirty. Even fixing the unit issue
the old bounds check would miss blits that began outside of the visible
screen and continued onto the visible screen.

Another thought, we could clear dirty bits on full screen updates. But
that's a change with a much larger blast radius and I would be nervous to
make it.

