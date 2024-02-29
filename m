Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB08C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmTt-00063w-CN; Thu, 29 Feb 2024 14:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>) id 1rfmTq-000608-NG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:54:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>) id 1rfmTb-0006ll-Lj
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:53:57 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id 51E785C005D;
 Thu, 29 Feb 2024 14:53:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 29 Feb 2024 14:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to; s=fm2; t=1709236432; x=
 1709322832; bh=M6rbw+n+N/w7eLH273TiruvrBg5kCYrlH64w/wGT6BE=; b=M
 RCduglQ26s2yEjvTWgEx6I1ewsYbU+20i4Z1Fx8vBy3oeMwZGTJsJ1+U994l+jkz
 ++L+pcn8/y4qSpBlFBNzj6Gfrnir/WEIz/GDN18PEjRzKJHO2r77JA9fNcNOQiZy
 //BvVlFPwGxQuiUfd4FEQQk2hyz62f38PT+El97C1JsD0s2XuEf3rtmBjEKvg4Gj
 guem2TQ3+p2/2S96IJljZvvDoU3WZgRgjpLP7phbSCgmA/XeP+NusQCyvLVbcZ3J
 OOy2ihFl1GLtDUj5ERXtQWYyojAVRRPugvE/Gq23ZRAR3Z0GB57lFZLWvveVFmeY
 s+ZD0RhrOoHvYeWE6CDlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709236432; x=
 1709322832; bh=M6rbw+n+N/w7eLH273TiruvrBg5kCYrlH64w/wGT6BE=; b=O
 CqkEO0DvDTpEFyxxN1l26pty9a/06rQgGuKiB+F7L2R2aUPZjJ9BafSWil98zPij
 pNTb09Lw0CTca1fSMX5Ldee60EIDdCo4X3+wHnTs8j4/8YYYBW+EahliDj8hQ1e3
 f3dVVUvWfd6eH/TSY2hfzO/wvDhr7hOirE5SHwXzBdkOC4TR4DgDkLQNjmyasglS
 mVpSIFXIuJFu00Le4C2fuRuDitAZISVOtr6+ojCE3AwyYnMcaBeh09HGgDWa7pGX
 zRQySiyeP5tdDMvTIRA2aBmrL8eHJFD3KpgUC6vogO+0/Sjcswzjqw5QxnHoA0Ls
 5t1qIlkKdP9Xxy4DdOobA==
X-ME-Sender: <xms:0ODgZYhQJiJZ8e8CxidGqvAUQvWY2uP42x_FpRpmC8qfe7spo4qt4Q>
 <xme:0ODgZRCWAGwMurvef3OvjOAwD4JywlxqmiVR-cECLzxdiyPc0eRwv8A9h3wcizRfC
 AM7E7XsGaKoU7RU500>
X-ME-Received: <xmr:0ODgZQGdMrH1sbmw07PB1Mv506CikCgtFNo7DHQzgStY_wa-dTPTNeY5qvzlJ4k0uMlHkz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftd
 dmnecujfgurhephfgtgfggufffjgevfhfkofesthhqmhdthhdtjeenucfhrhhomheprfgv
 thgvrhcuffgvlhgvvhhorhihrghsuceophgvthgvrhesphhjugdruggvvheqnecuggftrf
 grthhtvghrnhepledvleeijedtteffudfhkeduheeludefgfeuveekheekvefhfffhffeh
 ieeifeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epphgvthgvrhesphhjugdruggvvh
X-ME-Proxy: <xmx:0ODgZZQra8s9NrKYILgCsPHGziVk5PK6CQUEYLNT3jOGF55DZA5xcQ>
 <xmx:0ODgZVxKfKaJXuS9nQ9pNluWXLInu-7dM2Bar0Syb-suaMEs_P6b_Q>
 <xmx:0ODgZX7tcGNY2ZTDdXgg4EwnoQNqCkZS0_9nh897giTD31Op3Wu-Qw>
 <xmx:0ODgZcnnaCFXPoYGS5hc8uT3M-zpslxBKte70xWrye0IsH1TXnmWng>
Feedback-ID: i9e814621:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 14:53:51 -0500 (EST)
From: Peter Delevoryas <peter@pjd.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [q&a] Status of IOMMU virtualization for nested virtualization
 (userspace PCI drivers in VMs)
Date: Thu, 29 Feb 2024 11:53:39 -0800
In-Reply-To: <20240228123810.70663da2.alex.williamson@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, suravee.suthikulpanit@amd.com,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, Peter Delevoryas <peter@pjd.dev>
References: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
 <20240228123810.70663da2.alex.williamson@redhat.com>
Message-Id: <D4DDA526-5E5D-40DB-86EF-B4B6D7692663@pjd.dev>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=66.111.4.28; envelope-from=peter@pjd.dev;
 helo=out4-smtp.messagingengine.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On Feb 28, 2024, at 11:38=E2=80=AFAM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> On Wed, 28 Feb 2024 10:29:32 -0800
> Peter Delevoryas <peter@pjd.dev> wrote:
>=20
>> Hey guys,
>>=20
>> I=E2=80=99m having a little trouble reading between the lines on =
various
>> docs, mailing list threads, KVM presentations, github forks, etc, so
>> I figured I=E2=80=99d just ask:
>>=20
>> What is the status of IOMMU virtualization, like in the case where I
>> want a VM guest to have a virtual IOMMU?
>=20
> It works fine for simply nested assignment scenarios, ie. guest
> userspace drivers or nested VMs.
>=20
>> I found this great presentation from KVM Forum 2021: [1]
>>=20
>> 1. I=E2=80=99m using -device intel-iommu right now. This has =
performance
>> implications and large DMA transfers hit the vfio_iommu_type1
>> dma_entry_limit on the host because of how the mappings are made.
>=20
> Hugepages for the guest and mappings within the guest should help both
> the mapping performance and DMA entry limit.  In general the type1 =
vfio
> IOMMU backend is not optimized for dynamic mapping, so =
performance-wise
> your best bet is still to design the userspace driver for static DMA
> buffers.

Yep, huge pages definitely help, will probably switch to allocating them =
at boot for better guarantees.

>=20
>> 2. -device virtio-iommu is an improvement, but it doesn=E2=80=99t =
seem
>> compatible with -device vfio-pci? I was only able to test this with
>> cloud-hypervisor, and it has a better vfio mapping pattern (avoids
>> hitting dma_entry_limit).
>=20
> AFAIK it's just growing pains, it should work but it's working through
> bugs.

Oh really?? Ok: I might even be configuring things incorrectly, or
Maybe I need to upgrade from QEMU 7.1 to 8. I was relying on whatever
libvirt does by default, which seems to just be:

    -device virtio-iommu -device vfio-pci,host=3D<bdf>

But maybe I need some other options?

>=20
>> 3. -object iommufd [2] I haven=E2=80=99t tried this quite yet, =
planning to:
>> if it=E2=80=99s using iommufd, and I have all the right kernel =
features in
>> the guest and host, I assume it=E2=80=99s implementing the =
passthrough mode
>> that AMD has described in their talk? Because I imagine that would be
>> the best solution for me, I=E2=80=99m just having trouble =
understanding if
>> it=E2=80=99s actually related or orthogonal.
>=20
> For now iommufd provides a similar DMA mapping interface to type1, but
> it does remove the DMA entry limit and improves locked page =
accounting.
>=20
> To really see a performance improvement relative to dynamic mappings,
> you'll need nesting support in the IOMMU, which is under active
> development.  =46rom this aspect you will want iommufd since similar
> features will not be provided by type1.  Thanks,

I see, thanks! That=E2=80=99s great to hear.

>=20
> Alex
>=20


