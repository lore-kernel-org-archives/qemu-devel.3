Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DF5C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYX5-0007hs-8S; Tue, 17 Jun 2025 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>)
 id 1uRYJK-0002D3-KZ; Tue, 17 Jun 2025 11:33:19 -0400
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>)
 id 1uRX7m-0007kO-Qm; Tue, 17 Jun 2025 10:17:21 -0400
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailflow.stl.internal (Postfix) with ESMTP id 2864C1D40CC4;
 Tue, 17 Jun 2025 10:17:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 17 Jun 2025 10:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1750169834; x=1750177034; bh=U/eUk/pXF2
 CFz/D+Hh9dfKdR+cTGZ/QsgERBZmy8ZSQ=; b=oFAa0xyyTNhlWF6xV+i9DVRzoh
 /MXFKI3wKeaAyUaZWattU/0fq1YAFaejyS9xHX6uzjpIIevFd2tduIwPvJWHU0qM
 B54Yg9vKP8w5BO9XhkKcSaS0t4XzrQlEL0Nz5dzqFQEH4jVvCw6d/AuK1ys8JRmy
 kWlVNZRqF/46pyG+culnfuOkKEKWMdaNbdUF1xBnTf2DV73JRuW3VjKaF17YGGkR
 hd42EhSbPBrBQiyj5/bNxUmkvUArrkZH2QhTLOVo6jGfHnSD9QrCG83pOxnhzcux
 x3szAmq6e8so2Zv7d7AwAttgh0dWtHOuvfRZS8GcSc8TFKbKXK993CLuXIqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1750169834; x=1750177034; bh=U/eUk/pXF2CFz/D+Hh9dfKdR+cTGZ/QsgER
 BZmy8ZSQ=; b=YMvfhkey2NfM2EGMafKlz3AhpZJ5371ud8Sy8CPVtEISXD+FdoY
 mFbYyVQi7avVbmoBz0UWZB7tWNUEYp98GoogH/PJ0fZvjROHG/HBJRid6KwvEAAn
 54WzJ1kUkw9ZDiqVCteZmNN1sL0h7GnB/b2VrgwZ8FxLUjeoFX1LqLMig/xdtni5
 Jh68tpDwqVefvj/8j19HzGXUV3bZRR+mJ0D0/biAyJUP6fa85AGyi5Y/L5mmV74t
 935RH8ckxJqFg/8WCwJrJYdLHVCqKyJ6Ui+qzjdYzQturEAh6Atb5jhgyHo44MEG
 QHslv3BX7z1NPB00jPDwf8LwfPd9u84rVjw==
X-ME-Sender: <xms:6XhRaFmjygYZXaPDM3oL3bjfGchAVQuHgE1STNN0zALbmJfhaKjTsA>
 <xme:6XhRaA2fC_9vmA5_kceJHLQ1tbkaYXb85IKMO-ZdsKHVKCiyy4TI0lw_0X2AukeOZ
 0EUrfYMGm8N9TbsgQ>
X-ME-Received: <xmr:6XhRaLq-NOZrSKgfN50Dcl9Gj1QXpo5eC3ZunOuNQgE-iYLxpaHf3c5XrYpvpnot8ZnRQkVLw3YGjwPCiYnQxneCwPFsiuBjsLvdWAQHQA1dejBsmmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdegtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvffujghffffkgggtsehgtderredttddtnecuhfhr
 ohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrg
 htthgvrhhnpedvuedviedvhefhieektddvvdehgfehffelveeuiefggfdtffffueejudej
 jeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehgkhhulhhkrghrnhhisegrmhhpvghrvggtohhmphhuthhinh
 hgrdgtohhmpdhrtghpthhtohepvghrihgtrdgruhhgvghrrdhprhhosehgmhgrihhlrdgt
 ohhmpdhrtghpthhtohepmhgriieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvth
 gvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghr
 ugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqd
 grrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhluhhishesohhrrggtlhgvrd
 gtohhmpdhrtghpthhtohepghgrnhhkuhhlkhgrrhhnihesohhsrdgrmhhpvghrvggtohhm
 phhuthhinhhgrdgtohhm
X-ME-Proxy: <xmx:6XhRaFm9K8x-lw0RmQihB-_6JI-0Z0E0x6ZVCjQ0lcIeDhM3bQpbRA>
 <xmx:6XhRaD1ZDTMtD8UpA0xSKCYA8V_nEXX1OcKdj0mGv5JdPZOsdNDxQw>
 <xmx:6XhRaEtp_mWoiJq2JC2hp9ouEi9q9n0WTIZMHjKkzqn3vn5KKI_gAw>
 <xmx:6XhRaHXIrY25aTUU20c-ZJ4yRlwDnuj53eQynrNGxQWiqDrEUiOm2A>
 <xmx:6XhRaD9-CimvMiSeZA8vmWB2M3yL6yqTZ8yEtQwMYfBXaDE8I-dPNc-X>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 10:17:13 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id BC3469A0A3C; Tue, 17 Jun 2025 16:17:11 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
In-Reply-To: <20250527062534.1186004-6-eric.auger@redhat.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com>
Date: Tue, 17 Jun 2025 16:17:10 +0200
Message-ID: <875xgutpuh.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=202.12.124.141; envelope-from=hi@alyssa.is;
 helo=flow-b6-smtp.messagingengine.com
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

--=-=-=
Content-Type: text/plain

Eric Auger <eric.auger@redhat.com> writes:

> From: Haibo Xu <haibo.xu@linaro.org>
>
> Up to now virt support on guest has been only supported with TCG.
> Now it becomes feasible to use it with KVM acceleration.
>
> Also check only in-kernel GICv3 is used along with KVM EL2.
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Hi!  From what I can tell, this will produce an error on hosts that
don't support nested virtualization when QEMU is invoked with -accel
kvm:tcg -machine virtualization=on, but I don't think that's the ideal
behaviour.  It would make more sense for it to fall back to the first
permitted accel option that does support running the machine as
configured, so if hardware nested virtualization is not supported, it
should fall back to TCG.

I maintain an OS development environment that includes scripts for
running images in QEMU, where running KVM on those images is a
requirement.  Currently, those scripts simply force TCG on aarch64.
With this change, to take advantage of KVM NV support, I'd have to try
to identify in the script whether NV would be supported.  QEMU would be
in a much better position to determine this and fall back to TCG if it's
unsupported, like how the -accel option with multiple values usually
works.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaFF45gAKCRBbRZGEIw/w
ok1AAP9QNkNFkNaw759IJnKaFhV3vMLiygMqSLbpUJkI0ubCOwEAm2MNXUbMBfet
VqLAlJOhXL1IH8VLug590GWzT3HJaAo=
=5p9U
-----END PGP SIGNATURE-----
--=-=-=--

