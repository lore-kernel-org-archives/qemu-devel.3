Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A77CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 12:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxuf-0006Mr-Po; Thu, 07 May 2026 08:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wKxue-0006Mf-5j
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:33:08 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wKxub-0001jT-KF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:33:07 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id A058D1D000BF;
 Thu,  7 May 2026 08:33:02 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 08:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778157182;
 x=1778243582; bh=TDH6awK/W1SlFosih5e+kU69WuS+owE46coh6meoOrE=; b=
 cEhes4AnMCzdnPrdxCFN2XLKP2vZ2EyYd1kFJ0ZFy4vcRySnRcJsfaHg3ODzOgT/
 tPBymP+5t+yvtIE5zlatRQKcA7oRe8GxGnNeoFMeMnXPOsc7Ci091kdf2WmT+xaL
 516pRVj3H4PrDfOSGfzXgZL0xVvqrYsM4ruVGVLeULdpmvcBFD2V9FvbiR3SJiDv
 +9nv/Wuwxfyywm0RRsF8zF/ZuWuIlNL+rGk2BlXCcfhXvD9pR3WepKH8jzcXeEHM
 6QB5sKiueAF21UvWayNo9/RXGFyPnc3KLmN/GHoyx/Pl6l6F/r2x5B7Qe2kus3JL
 IjcgSSNRdFvVZ3h3Co5a+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778157182; x=1778243582; bh=T
 DH6awK/W1SlFosih5e+kU69WuS+owE46coh6meoOrE=; b=WMR3aSpRkpHIlHr36
 Oh6kvj9N8VzD8QnfOiZSTwAO6U/yT881/0i1rmobCAMiuW4xs+L+WAz4a0ZEbuiQ
 1bMB4O7ExL70iKBZDchmiiQNzEXGFxQeH8gUyljMoSKxh5PnA8qJcrVu5Bi4LMQW
 ZVi0fMnNy/6u0jT+Q09jHzGAUgirY9emdGbFXkQNhnAM3rvnGhP31z2PLnU7mE7b
 llCpA6W5CjGgbtu6lUbdfO7SwsSMqdlkK61NzCUj0vpmKkhv+1akP1TnGtq58xIk
 qRLMwxl7TrFBPlQaP+mx23Tn+N6O2Bbr0ddh7JhJs5d7YQ8eslSxanYo6gQ/ipap
 /DpWw==
X-ME-Sender: <xms:fob8ac9z02RLmt7YsiI4ZFkXydSXz8OSDl8vH2K3umJ0-hfVkYMAGQ>
 <xme:fob8afgcdwilsU-tTjfKh8kpiQyHgkHeztOdhBGR2_MAkoDpN-fP7Ics-kZnvmML-
 hqTEfNgdintX3MAJlQlrL7T-nWVGoC8H_36553nrMO1WhsfcZTV_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
 ertdejnecuhfhrohhmpedftehlvgigucghihhllhhirghmshhonhdfuceorghlvgigsehs
 hhgriigsohhtrdhorhhgqeenucggtffrrghtthgvrhhnpeegvdffleehudetveffvdeihf
 fgvdefudetueffteehheeigeeifeeiueehgfekveenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnh
 gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhu
 qdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegtlhhgsehrvgguhhgrth
 drtghomh
X-ME-Proxy: <xmx:fob8aY8h8ZgfkTwl88DA2kei0aqgixcyibJI57ONChSqoK0w8gVrkQ>
 <xmx:fob8aWtjOY3bbgrACNbwSQku9obbxC2V8sHt_Izv749mSYJNU19TSQ>
 <xmx:fob8abpsrlXKBmhbi6FT6wmfi_2B5AreYBqmqrRKJdzyMW8h4m8CjQ>
 <xmx:fob8aTmwReBVoT2vKIWNwy4Se4WIQWLP9yo12FwuTqkzd5l3YXjM_w>
 <xmx:fob8aadKEQgeqG-M2oRrvpbLZ1Y4b1ZOpca5HrDkwwx3SXMnNY8A8iSm>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 1108C15C008C; Thu,  7 May 2026 08:33:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AQvuwMoLp7xZ
Date: Thu, 07 May 2026 06:32:41 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Message-Id: <56dbaf32-f18a-4f53-90cb-3ce65a3952b7@app.fastmail.com>
In-Reply-To: <20260506152353.1657838-1-clg@redhat.com>
References: <20260506152353.1657838-1-clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: Replace abort() with g_assert_not_reached()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.144; envelope-from=alex@shazbot.org;
 helo=fout-b1-smtp.messagingengine.com
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



On Wed, May 6, 2026, at 9:23 AM, C=C3=A9dric Le Goater wrote:
> This check was originally introduced in commit b3ebc10c373e
> ("vfio-pci: Add debug config options to disable MSI/X KVM support") as
> part of a debug block to retrieve the MSI/MSIX message, and was later
> moved by commit 0de70dc7bab1 ("vfio/pci: Rename MSI/X functions for
> easier tracing") into the main interrupt handling path, becoming
> production code.
>
> Under normal conditions, this code path cannot be reached because the
> BQL serializes all handler registration, vdev->interrupt updates, and
> handler removal. Replace abort() with g_assert_not_reached(), which is
> preferred nowdays, and add a comment clarifying the purpose.
>
> Cc: Alex Williamson <alex@shazbot.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index=20
> 09acd3f6082b0a9c5223780bf7e9847b57424cf7..7ca2ff4e7c1cb570cd60d35454b3=
3b5506dae36e=20
> 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -453,7 +453,12 @@ static void vfio_msi_interrupt(void *opaque)
>          get_msg =3D msi_get_message;
>          notify =3D msi_notify;
>      } else {
> -        abort();
> +        /*
> +         * Interrupt state transitions (MSI/MSI-X -> NONE/INTx) are
> +         * protected by the BQL, and eventfd handlers are strictly
> +         * unregistered before vdev->interrupt is modified.
> +         */
> +        g_assert_not_reached();
>      }
>=20
>      msg =3D get_msg(pdev, nr);
> --=20
> 2.54.0

Acked-by: Alex Williamson <alex@shazbot.org>

