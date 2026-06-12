Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCABCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3zT-00063c-CE; Fri, 12 Jun 2026 11:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wY3zR-00063E-Pi
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:40:13 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wY3zP-0002qT-UL
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:40:13 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 596A2EC018C;
 Fri, 12 Jun 2026 11:40:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 12 Jun 2026 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781278807;
 x=1781365207; bh=sGuxrTjuh3TSJebZuQHTiuZjkiERsjhaBexx6E/upJc=; b=
 M9xL2GXPemMCW5pJAgDKw52lYY6lVXjeXSdZjFSZfEv9gx7+/W9RmKTBIuwlPm0e
 OPsHfpVu4LpBalm9CJObDacZg0grzsIP4jG5zqAFxQ1zweR7/y37s0I1CYrsCOPm
 GTLRyDGl/A+FgWsl5xu5QqWyBSMGgpH4xMVxH6n+0lS48mLWg3EYZcf2eDE5LNcq
 NNJmseHcgBEBlyOXX1+Zv+6xJ5TNvGTqcL5v7mDBCrCsDsC8cGrwAPeok1e1V9uG
 1mW6PHBrBlTwRpLaX1fPTLFDFPpjGYq9bDogBAW+0IorV/FqcRJMyVn4wzI0+NUb
 m4ep6SCqoTNk0l4o/qz38Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781278807; x=
 1781365207; bh=sGuxrTjuh3TSJebZuQHTiuZjkiERsjhaBexx6E/upJc=; b=E
 uvOAkRKyKXL0b5HX0fqaj97z5CyOA/bTVwxkYVyutj1TbgaWAnOKfBw3Dk2GDYpZ
 AmSH25cG9RBhsSIPo4BAT3a3cXFNMLgpTNEYgEFSYABc4L5/xAIuWpLkAMemQd/w
 pi5+irbIx2Sh1rEj8HomwqX8wLqkbhfIN/57RMY96VojygND17cA69MteH9Ldv+P
 IkTjHIOxpVHgm8N6DcOiLBuligiP+g0cklkTZbLtZ/pzxE6RSDSRjQY58ZtSLB3u
 LacgR4cJqyHv0xoAAqFNb4HoiKMDEyCasB/tqxvTfTG55XxU3mvciD+Npxdl1Zvv
 8ryPmvimZ3/zRIKsr66IQ==
X-ME-Sender: <xms:VygsaimPS8XY0QvdMm6mERMdG21iLAz5D6lmH3Pgoy2gZ0om0X1a1A>
 <xme:VygsauK1LgnC5nv6rL2NYoar-B_MmYDpX7Qcljw98k3HEzEz0rwZngt96zd8xb9gr
 ZEvZI2_FmBCFbhvrsv-f6C3AqkvI_LzUH7Li3qDiw10xuwzEZjixw>
X-ME-Received: <xmr:VygsavwvOWRLucecY7zjnxeMGV_9W3RC10mflsXbtiex2iulj49icdSBRbg>
X-ME-Proxy-Cause: dmFkZTGpTARreE7ymm2K4FpvbdJX1xeLP96X7f0ttXzlA9Sjmu/3VZylkxLmskxpp34A2u
 YCibG2ah3CGxOWELqqumGt3/3oU0zHTr9BF1tdmISlWBhvhxLpXZu27n6Nn6jN4DXhJvJ0
 jfREFJwp+kYbI6jhNj3AjMlzYeIuQFCf1WWaZJYIpYvdFc9DeGnMdALjnGroLGstkaUWuN
 OQi7YkLbua4vrCYv0IFTSP0CwYAz60TdSMY/p2iDjB7+7r4jv+cnwkoCz/4Pim3xOdzO9n
 QjfHLctguhLrFdNlyvPui3GVKgzJjUvmnCrzTCmyhsPQq+BACPTWziI5lWReRV5Suc7zYN
 eQTh9rNmtvQdp9UEgcZeZhurwQitYwtEqyMycdO5Vm0SS410OCH/vdgK8b9mJX1/3T+BZ/
 2aVt+i3hVLda8LTX9n0ltiEuvAiXZZto/a4Ojb/kQ42Rj8I8PycOGeeVAUJaNadoH41nZG
 k3YxSkxsh9/8Tl5KrDkNxKe+fjzzTxYdK3fqT14fL+EL+UPpQrmEGR9c3vtwx/GOz7ctzv
 gMYa2Ni1QAuTZ8mFAH64/IpzC70yd2f2dCl24CsCicQCXaAFrmjwcETfr0Bi5QeDRaQt/d
 6MbIF0a0IgbfWapPVN3M+WZA3Gg4C83KpSxv7SCll05x5j6OZhsriy2G/xAw
X-ME-Proxy: <xmx:VygsauvNl4NlgYtqxHGvYt7w7lIEMiE918DMGWOxCIlzb7c17Jejmw>
 <xmx:VygsamvXxT0lxIY4EzSi4fzZBKbHzecF3_DKWcyrnq8F7abF0VBaPw>
 <xmx:VygsajNeNVYp7-q4aNjCrWWi3iHLdaO0rsBnb06JR7mlP83Z6gdYaw>
 <xmx:Vygsak1pwCKL6mP-Xv9-1x4heceU94tDW5iXqqMdz0i9d-8sqOHgTw>
 <xmx:VygsagzK3H1jAahCzyGWp2Pb_2kWM2p9vGmSUweyiz9O85eAM4pTinP9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:40:06 -0400 (EDT)
Date: Fri, 12 Jun 2026 09:40:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/iommufd: Merge .dma_map_file() into .dma_map()
Message-ID: <20260612094003.44eb3cb6@shazbot.org>
In-Reply-To: <20260608055758.359002-1-clg@redhat.com>
References: <20260608055758.359002-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147; envelope-from=alex@shazbot.org;
 helo=fout-a4-smtp.messagingengine.com
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

On Mon,  8 Jun 2026 07:57:58 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Simplify the VFIOIOMMUClass interface by removing the dma_map_file
> handler. Move the logic to decide between the standard virtual and
> file-backed mapping into the IOMMUFD backend, utilizing the
> MemoryRegion already passed to the dma_map handler.
>=20
> This removes redundant dispatch logic from the generic container layer
> and let backends to manage their own mapping strategies. This is
> similar to the vfio-user implementation.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-container.h | 15 ----------
>  hw/vfio/container.c              | 38 ------------------------
>  hw/vfio/iommufd.c                | 50 +++++++++++++++++++++++---------
>  3 files changed, 37 insertions(+), 66 deletions(-)

Reviewed-by: Alex Williamson <alex@shazbot.org>

