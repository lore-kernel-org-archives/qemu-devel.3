Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOgj-0008E3-MC; Wed, 28 Feb 2024 13:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>) id 1rfOgh-0008Dl-Bs
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:29:51 -0500
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>) id 1rfOge-0006s2-4l
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:29:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id CF9481140084;
 Wed, 28 Feb 2024 13:29:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 28 Feb 2024 13:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to; s=fm2; t=1709144985; x=1709231385; bh=TsPjkHBJygap3
 7cRuTpCQBI1U2BypmTxAUkUzYlptt8=; b=OgxTX3qyRLfeRejawo+b1Jx1E79Mj
 rpJAYSMK4P+vjxCWRkc06HkM5UdZGsRSAKz/flI583jDolahfrivzWGIZYFjwc/Y
 DI+4zbBm47E/eQNfldO7S8++akk+Rb9AvIMC/O12HAZ1fGyk2T9LOVn6tYupdO/8
 4oXnaL/PmQiN8wlvat3qUBS/3DEooVV7jfaBZQEGfCvSVuv6eAsXcDH+6zgHruJV
 cnFvHcIyIZ1gfSwSBllFpb4/GU+cmqDurKDNPL+LdrCJUt+Rr8Dfef/0DlGER58k
 bqnB7NVyuoEZIxwQGlNxb9Ly3u6U04A6m2q6pSpvgq+APLcZYOFU3hBgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1709144985; x=1709231385; bh=TsPjkHBJygap3
 7cRuTpCQBI1U2BypmTxAUkUzYlptt8=; b=jWn0wqXwKPRHZCvPhztlSVq+OdzMU
 cdmH8zdtqFASFGM0Ay04zD/HgE1TB7qMCUVn9xcCC3jlf/XC91XnH08Dz2OoZ9W7
 0TQdkD3vmNliSAk0NDQRmofggu6v2164gVg3JCbA8jEYOjwBDGHeZukklYimnJe0
 dWKZzoQhjHaSl2xcywoA/wp8OZBSbUlFRRbgR+BPvshGm2ALQTN9WpID6e7DkJ12
 fHAMyE5pOR2Y4Ahb+ddp1/br+SCY3Z0TVd4Zmg9SBzwNDG6NvR67bAl30sEnaXdR
 dJLX4FqSc6U1SbH8ckkPi171J4kEH4hKAm+UkXIiqljZye9O8HYIrGX3w==
X-ME-Sender: <xms:mXvfZUm7Fd2vwXbSn-tWBoFRrdeE9L7M1XpMbHvJZWehnj0vlcXI9A>
 <xme:mXvfZT1wxuWHLQlRt2Iikqqkr6PrnkNLJ7KSGV6u40bwUwDXXKPEvI5OwJss2qVbR
 XbTI8nQyKSiImLo-SA>
X-ME-Received: <xmr:mXvfZSrw8HOY3JJi_1ufQHrl1P936uxHsDGhlICgxVM1pvnkijgN8LtUaR1T5zs5ykiRrQ7ySeaqFgxIAxB4-Ln5_QtKhMPRwN3AYYwPvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftd
 dmnecujfgurhephfgtgfgguffkffevofesthhqmhdthhdtjeenucfhrhhomheprfgvthgv
 rhcuffgvlhgvvhhorhihrghsuceophgvthgvrhesphhjugdruggvvheqnecuggftrfgrth
 htvghrnhepjeffvdeigfevgfefhfeutdeijeekieehfeefvdefhedtfefhhfdutdefieeh
 geevnecuffhomhgrihhnpehstghhvggurdgtohhmpdhqvghmuhdrohhrghdpghhithhhuh
 gsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehpvghtvghrsehpjhgurdguvghv
X-ME-Proxy: <xmx:mXvfZQlq9-xvJ4sbfiIGfDWaiXp0jkzNdWj_A_-TGveCZbdejRfQ8Q>
 <xmx:mXvfZS0ALPkaZQuibMXDcDwcLMkBKr_EAQlHqKhUUcdgeJdkOZpypg>
 <xmx:mXvfZXsdR1B7YT63VC3sJMJLcnAcSWqK60huyNC5TBZl377_qeMitA>
 <xmx:mXvfZcqEfDZnBoQsxsNqTNowBnj8eqcSB66nfJEtJx6sNW-szSFHjQ>
Feedback-ID: i9e814621:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 13:29:44 -0500 (EST)
From: Peter Delevoryas <peter@pjd.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: [q&a] Status of IOMMU virtualization for nested virtualization
 (userspace PCI drivers in VMs)
Message-Id: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
Date: Wed, 28 Feb 2024 10:29:32 -0800
Cc: qemu-devel <qemu-devel@nongnu.org>, suravee.suthikulpanit@amd.com,
 iommu@lists.linux.dev, alex.williamson@redhat.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=103.168.172.159; envelope-from=peter@pjd.dev;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hey guys,

I=E2=80=99m having a little trouble reading between the lines on various =
docs, mailing list threads, KVM presentations, github forks, etc, so I =
figured I=E2=80=99d just ask:

What is the status of IOMMU virtualization, like in the case where I =
want a VM guest to have a virtual IOMMU?

I found this great presentation from KVM Forum 2021: [1]

1. I=E2=80=99m using -device intel-iommu right now. This has performance =
implications and large DMA transfers hit the vfio_iommu_type1 =
dma_entry_limit on the host because of how the mappings are made.

2. -device virtio-iommu is an improvement, but it doesn=E2=80=99t seem =
compatible with -device vfio-pci? I was only able to test this with =
cloud-hypervisor, and it has a better vfio mapping pattern (avoids =
hitting dma_entry_limit).

3. -object iommufd [2] I haven=E2=80=99t tried this quite yet, planning =
to: if it=E2=80=99s using iommufd, and I have all the right kernel =
features in the guest and host, I assume it=E2=80=99s implementing the =
passthrough mode that AMD has described in their talk? Because I imagine =
that would be the best solution for me, I=E2=80=99m just having trouble =
understanding if it=E2=80=99s actually related or orthogonal. I see AMD =
has -device amd-viommu here [3], is that ever going to be upstreamed or =
is that what -object iommufd is abstracting? I also found this mailing =
list submission [4], and the context and changes there imply this is all =
about that (exposing iommu virtualization to the guest)

Thanks!
Peter
=20
[1] =
https://static.sched.com/hosted_files/kvmforum2021/da/vIOMMU%20KVM%20Forum=
%202021%20-%20v4.pdf
[2] https://www.qemu.org/docs/master/devel/vfio-iommufd.html
[3] =
https://github.com/AMDESE/qemu/commit/ee056455c411ee3369a47c65ba8a54783b5d=
2814
[4] =
https://lore.kernel.org/lkml/20230621235508.113949-1-suravee.suthikulpanit=
@amd.com/


