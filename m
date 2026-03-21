Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C71099B54
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3pEg-0000y6-MN; Sat, 21 Mar 2026 01:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1w3pEa-0000xI-Ue; Sat, 21 Mar 2026 01:50:54 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1w3pEX-0007BS-70; Sat, 21 Mar 2026 01:50:52 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id A0D0EEC0113;
 Sat, 21 Mar 2026 01:50:44 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Sat, 21 Mar 2026 01:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1774072244;
 x=1774158644; bh=RRtfR5e2ZlMbp50vZXrBUCW0kymEC/MrW4PG2X1HoKM=; b=
 VFYAWh7wQ+t4dsNVDkN6Iw+BwNf38B4qFDy9GjPdggYBuH7knI5LjSmUp7KvPNok
 D2GnjiYe+FIu1MYU18VrR2hN7kdtcaNNm3GHXx2tmKwHVWu4C7vnOmw8pmYsmve8
 kV0lZU/NgfN9Oy83TGAgA02LC2NRcp5jXsgW6aTqvRDHG6l7fM07lVJEZzASnDxP
 yq+5QnTONQklHWOKMcfVTG1UUGJwSg1C5dq1bsVyYxDd4m/a1aMA3ANrb0j3nChH
 1OjllUW4TfXD4ryOQgwpI/SaUIg7ruN14tPixR9KoiZ+4JIQZVdVobaSDMTqee84
 Jxi/oEUk0YVqcC2qz4qVKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774072244; x=
 1774158644; bh=RRtfR5e2ZlMbp50vZXrBUCW0kymEC/MrW4PG2X1HoKM=; b=2
 +3bruGF/uIoj9ur2whpKKRLcxqPUeh8IyDS7oKms+6eDl5xHUYRuewmLtN9nuf90
 gkXfoSAQz+vkVbHPukNlWZ14wYrlF1KsM0eViTCJE7oxx8Wk4eu+BU5P5wVsZfZy
 rFLLpfYeADvYyt18vODQy+wBbU0IUkBUFCKynI3mws8DIOVF0e6tD6IFfKGKphId
 b0O+vUaLPNkXRXx4PK/uODWetftRUW8gthI9PQHK+Rn3olSkWSwlYOUv5OAJMaq3
 fKgdEHQ02slaBe5qEFZdc4RUDMX5dZAfT7mUmyScqcpUjc29avHRx5LnpDi0CT1Q
 BuY8wfYjSlQx1ZfLXauBA==
X-ME-Sender: <xms:sjG-aYCtAu6tX5TAPP-xlBsp6dZZhRhoHmv4Z25Hd5ELHSEuppVX2A>
 <xme:sjG-aVWzk4y73Qwkkzxm89Hb4ey6uWaAjWuhX3iMLeQYTikNJbhSusJGSpvoKH876
 EkbWs6xX1nTMZ_e5hH30XZTxRU08EpWdJq5i46q1fq4bsCns2EicQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddvtddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlvgig
 ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
 frrghtthgvrhhnpefgfeeflefggfffveffteetiedvtedtgfdvieevfeejfeefffevteej
 tedufffgveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
 htohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopehl
 rghnughonhgtlhhiphhpsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrghhnuhhsrd
 gurghmmhesghhmrghilhdrtghomhdprhgtphhtthhopehlrghurhgvnhhtrdhpihhntghh
 rghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepphgvthgvrhdrmh
 grhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgvnhigihgrohhfsehl
 ihhnuhigrdhvnhgvthdrihgsmhdrtghomhdprhgtphhtthhopehqvghmuhdqrghrmhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdr
 ohhrgh
X-ME-Proxy: <xmx:sjG-aUy-oYcGoovuYKPKnQM_po2oS_CnaTvadegDVPvPXsub5R28eg>
 <xmx:sjG-ab9BrAQIcdsVsATWyPXypUxRsnCp_xcZ_mFfxroIAsHdJBvusw>
 <xmx:sjG-ae_l9MXNq132DL2chdiHIV6ikHr1thGkuJ5lhxlAuFHtVBV0mg>
 <xmx:sjG-aT7orrrDgeRMYF4_nI2qZCjKQ3b86ikJEme2EiJMXXfL6HlTBg>
 <xmx:tDG-aXqCjn3gbMnei31EhyAoc0qBGRO3h5t51wc_6Dxogn8m4SA1ACv8>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C274215C008C; Sat, 21 Mar 2026 01:50:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AC0Qvsrv4yKJ
Date: Fri, 20 Mar 2026 23:50:22 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Landon Clipp" <landonclipp@gmail.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Auger Eric" <eric.auger@redhat.com>,
 "Xiao Feng Ren" <renxiaof@linux.vnet.ibm.com>,
 "Arnd Bergmann" <arnd@arndb.de>, "Alexander Graf" <agraf@suse.de>,
 "Magnus Damm" <magnus.damm@gmail.com>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org
Message-Id: <3b8c2bbe-72dc-4425-8381-c0323c692933@app.fastmail.com>
In-Reply-To: <DH807PW5SQCW.3AA422QQRGVAH@gmail.com>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
 <1518189456-2873-5-git-send-email-geert+renesas@glider.be>
 <20180209085024.004b6f9e@w520.home> <DH807PW5SQCW.3AA422QQRGVAH@gmail.com>
Subject: Re: [Qemu-arm] [PATCH/RFC 4/5] vfio: No-IOMMU mode support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=alex@shazbot.org;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026, at 5:38 PM, Landon Clipp wrote:
> On Fri Feb 9, 2018 at 9:50 AM CST, Alex Williamson wrote:
>> On Fri,  9 Feb 2018 16:17:35 +0100
>> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>
>>> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>>> 
>>> Add qemu support for the newly introduced VFIO No-IOMMU driver.
>>> 
>>> We need to add special handling for:
>>> - Group character device is /dev/vfio/noiommu-$GROUP.
>>> - No-IOMMU does not rely on a memory listener.
>>> - No IOMMU will be set for its group, so no need to call
>>>   vfio_kvm_device_add_group.
>>> 
>>> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>>> [geert: Rebase]
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>  hw/vfio/common.c              | 61 ++++++++++++++++++++++++++++++++++---------
>>>  include/hw/vfio/vfio-common.h |  2 ++
>>>  2 files changed, 50 insertions(+), 13 deletions(-)
>>
>> NAK.  I'm opposed to no-iommu support in QEMU in general, but accepting
>> vfio devices with no-iommu (which provide no DMA translation!!!)
>> transparently as if they might actually work like a regular vfio device
>> is absolutely unacceptable.  Without DMA translation and isolation, you
>> might want to think about another interface, I'm not keen on the idea
>> of corrupting vfio support in order to blink some LEDs.  Thanks,
>>
>> Alex
>>
>
> 8 years later, I was wondering if we could revisit this. I found myself in a
> need to use enable_unsafe_noiommu_mode due to some systems I'm using not having
> a usable IOMMU. QEMU is being used as part of a single-tenant workload
> sandboxing environment, and given the specific circumstances, both the users and
> the administrators understand that enabling the noiommu mode is unsafe and
> cannot be used where security matters. Regardless, it's still something we want.
>
> As the administrator of my system, it's under my control whether VFIO is put
> into this mode, and if it is, I would expect the remaning software components
> to respect that decision. As is, the system is unusable because of a lack of
> support in QEMU.
>
> I'm happy to elucidate more of my use-case if it is helpful, but I 
> first wanted to
> gauge your willingness to reconsider this under a different context.

I'm not aware of anything that's improved the chances of accepting something like this.

In fact, a vfio-platform motivated feature is arguably on worse footing now.

More importantly, QEMU now has support for vfio-user, so I believe you can already do this.  The model would be a vfio-noiommu userspace driver that exposes a vfio-user interface for QEMU.

All of the previous issues with security and virtualization still remain with implementing this support directly in QEMU.  Providing a DMA capable no-iommu device to a QEMU sandbox negates any isolation it might otherwise provide.  With the vfio-user no-iommu driver model, you take on the security burden to use only non-DMA capable devices, or mediate the access, rather than asking the QEMU community to assume that risk.  Thanks,

Alex

