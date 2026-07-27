Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA93C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woS4D-0006f1-4S; Mon, 27 Jul 2026 16:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1woS4A-0006ee-IU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 16:36:50 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1woS47-0001r4-PC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 16:36:50 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 3AF54EC0189;
 Mon, 27 Jul 2026 16:36:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 27 Jul 2026 16:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1785184605;
 x=1785271005; bh=J8BiR++sWpmRo0+Ma8hdOdL7jqLp5CPsyYFAHkmkLvw=; b=
 X7JBDbcBDZXcCeqCtUFsa8N4wsSndNSigh14QSNK/LMb7X4q7BpyRxyGPG1pPhxd
 52N4OpoxpPHUXt8jn+oJ2oxhk1ZM8pTQB0JqYoOQ4Z+reR/ftuWdULZFC3T9kzGY
 slgaTxsttakQYkMfrlWDtSzjaFjjJVTfeb6LeMVDAgw/f58jebRwaWWnxw6bDvSP
 3wMvM14FTkYMyBltv9f9rRObf9onMsdvdgRxfLwtlCw4FPfc/Jl40XpNMvXmCs3i
 4Wa7x3T/XkSAQQpRctYS9eIdP1m+iTpBV+k3A6OMBYTLgRej5KLznDgaHhzYG03D
 7MewmPa92GJ07oQr7mQcYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785184605; x=
 1785271005; bh=J8BiR++sWpmRo0+Ma8hdOdL7jqLp5CPsyYFAHkmkLvw=; b=e
 qdtPzC27nkh7ltiPdNWelf79XT6jiv0f5GUhsEVeOOykQu6ckmLlGbfXJnUmquoe
 ISS/opp49OoXumYFuKp+dYBXcFJLA/t/00XlHmuXrSjTEqguAthlasTDOUaK2Pmq
 EKQ1Yf2DLS4cGZErBL5bOzlCF/EyYZxFhU1xcBfXcqvM+6m8LHiwGVexZmoYJibh
 0r/uwdlU/3WzezCbxYfnGf25SR0RLQ9wM46e+OckLemH6+66+xZQ4sC4C1EcLnLr
 srLu06IPKZUlwOAv98ZemgQhFDV0/MLcn8BDzzlPA2wzEYXDSHpkkDjW1zGsmD5L
 878Lho1jwXX4Tw3Uyn3lA==
X-ME-Sender: <xms:XMFnarlAEhfAryWDU4eRymj7ThD8rwMJsRL5Fm7NvnAebJGidaAxMw>
 <xme:XMFnararQ8mQ_HRDo0LF5Z4bDNW8WBmSNpgiBDOpWnU6d95wC7V3P2BvlolpjYP6l
 YAhwzfSxg6zl5XLsOrZFKr3ZRkSaSaJKXCiSb_2Ti6fbagflAjIng>
X-ME-Received: <xmr:XMFnamHZgxEqTTG24rR4o7vs7jRPm06wKjHy1zAUppAJ83i7iZ6jfhLoxf4Yjw>
X-ME-Proxy-Cause: dmFkZTGFHfIgA9YEKhondsTPWoymwpnlBeOG7+S3knpjaMWaDm8vAb5mHihATcdpe1DV85
 TPcJEtqYkDOFtAqjGzmGWs4KQ3qPn+VNT5HigJeE55iaQ6ElERNVUTx9VYKHPNev1cluUC
 hK6fa0iXNMpMaKOxZ0B1CZ6oHyptAt4UTGb7uOXtiuATTnBDcyQKMIsDjj/d/3WSwRLp+p
 MIuVge09YveehSHXWXzqzKMyHhp1/TeUzbuG4PIsy33Cty8CUfKYNht/VCoRSmJumEwvPb
 f3BvgKA4EKOZmiyAI+Q8bAEszz4QfeIdH6dQ95e6HXAftiYYZozHs8Y3fQZKe/TO6j2cN7
 13aff78lWRnvt+g56FPwXiI41pfoOnDTu6lrtyd4V/S0tdHtDgarPhQHT3WDlMUlvLAsE0
 AwcVoY7HhL52f08Nct9f7CKLxw3EfH1LZi+gNfMiuNk3IushPysGi7Qgq3MOVb4Mknlict
 CQobColmda0XVDnDmMNJyNR/j2LM7h/bVhM8YwIonJSGL+ar7UpZHKyCE1ja7PVdI++KtW
 xDal2m5ruwYLnfPfPRsJsTXthBkP3zNQYvE/KbevqHjMMhihpXKIcAYSRo4E48ZNz3Miyy
 PKMr0ekqiq/HB9DfQEeqAhgS86D5PdQHPOgpHnw552iSbZikVw+3f1qCbSTQ
X-ME-Proxy: <xmx:XMFnaqa1UZ6EZiAC9QI08qrMGbM_mebGJQ27Jj87OJmmWPmmAS0zdg>
 <xmx:XMFnaqxTI5comYSMoMqt3d8GUD9i_-UOiuuceW5n_fnI7fsKBtUZeA>
 <xmx:XMFnasSfyTqPHcua8OeFzL86_cAKazoyswPa8ObFf2U0WTH3aXfGcw>
 <xmx:XMFnanKH0wGQkqW14GvLtj6kgLjG7Kmd89p4g1kLqqXNDJvnyt4vfQ>
 <xmx:XcFnatp1f5hgwsTBIj2SObAPl884FzEmnc3j5oa17F-mUMK0_XI06Ene>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 16:36:43 -0400 (EDT)
Date: Mon, 27 Jul 2026 14:36:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jason Wang
 <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu
 <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>, alex@shazbot.org
Subject: Re: [RFC PATCH 00/11] igb: Add experimental VF live migration support
Message-ID: <20260727143641.66b3799a@shazbot.org>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.148; envelope-from=alex@shazbot.org;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 27 Jul 2026 07:39:24 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Hello,
>=20
> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
> growing requirement, but real hardware with migration support is
> scarce and hard to debug. An emulated device provides a fully
> controlled testbed for developing and validating the entire software
> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
> QEMU, libvirt - and for tuning complex migration policies such as
> downtime convergence. It also serves as an educational reference for
> understanding VFIO migration end-to-end, from device state
> serialization to dirty page tracking.
>=20
> This series adds an experimental VF live migration interface to the
> emulated igb (82576) device. It enables a vfio-pci variant driver
> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
> protocol with stop-copy and pre-copy support.
>=20
> The target scenario is nested virtualization:
>=20
>   L0 QEMU (these patches)
>     igb PF with x-vf-migration=3Don
>     =E2=94=94=E2=94=80=E2=94=80 VFs with migration BAR + vendor cap
>=20
>   L1 kernel
>     igb-vfio-pci variant driver [1]
>     translates VFIO migration v2 ioctls =E2=86=92 BAR2 MMIO
>=20
>   L1 QEMU (stock, unmodified)
>     vfio-pci device model, standard migration fd
>=20
>   L2 guest
>     standard igbvf driver, unaware of migration
>=20
> The L1 QEMU is completely unmodified -- it sees a standard VFIO
> migratable device and uses the normal migration fd path.
>=20
> * Design
>=20
> The migration interface is exposed through a hidden 64KB PCI BAR
> (BAR2) on each VF, discovered via a vendor-specific PCI capability
> ("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
> machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
> RESUMING, PRE_COPY).

I think you're placing the migration BAR on the VF in order to
implement this in a small footprint, QEMU + vfio-pci variant driver,
without PF guest driver changes.  A model that better matches real
world hardware might be to put the migration BAR on the PF, segmented
per VF, and then have the PF driver vend those segments out to the VF
drivers.  That would remove the BAR always mapped problem, but expands
the footprint to include the PF driver.  However, we're not exactly
clean with respect to the PF driver as implemented here when we're
going around the PF driver's back to setup DMA mappings.

Can we take advantage of the fact that this is a virtual device to
avoid all these warts?

For example, do we really need MMIO BAR space for the register set
exposed or can we prune that down to some key registers and doorbells
and move the rest to memory?  We can put the vendor capability in
extended config space to give ourselves more room to work with if
necessary.  We also don't really need to play by the physical rules for
access, the variant driver in the L1 kernel can allocate contiguous
ranges and write GPAs into config space registers.  L0 QEMU can just
write migration data and dirty bitmaps directly to those GPAs,
bypassing any pretense of DMA mapping.

There might be some tricks we can steal from virtio as it seems to
optionally honor things like vIOMMUs as well.  Anyway, if we want to
confine the implementation to the virtual VF, avoiding dependencies on
the PF driver, both at the cross-driver API and device DMA state, I
think we can probably lean harder on QEMU being able to push data into
an arbitrary GPA regardless of the IO topology we're exposing.  Thanks,

Alex

