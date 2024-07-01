Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F2FC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOImP-0002HF-Cg; Mon, 01 Jul 2024 11:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1sOIdI-00015t-T1; Mon, 01 Jul 2024 11:07:58 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1sOIdG-0003C9-IY; Mon, 01 Jul 2024 11:07:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8B3A761465;
 Mon,  1 Jul 2024 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8A3C116B1;
 Mon,  1 Jul 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1719846471;
 bh=IaVrXv8g1Lq8KZCnnOvGq4C5oSxDo+ejYrXmrdCjB64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gbExNuGJs8uAQrM8hbxZozTP+F2herYJvIHE7M5XinuFLJN/lhU6/1rdf8TQACofx
 JLO/3acAKCuVCzwksuE2ewypHPIiwsJAxyxdxE8QjzScVTGAa7ooRu6i5IyJpIJ3Ri
 FjPd8kU0R1hu68nMGS+aQMJarFkOJ04E80C2M8w4=
Date: Mon, 1 Jul 2024 11:07:43 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
Message-ID: <20240701-vehement-eggplant-bison-a3c1a4@lemur>
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <CAFEAcA88ALQNOrdCmMV5z8mNN2hydarMwSx1P-43Hn7hEzca8A@mail.gmail.com>
 <4a83ba64-accd-41db-9d88-2c02a8ce541f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a83ba64-accd-41db-9d88-2c02a8ce541f@daynix.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=konstantin@linuxfoundation.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Jul 2024 11:17:17 -0400
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

On Mon, Jul 01, 2024 at 09:00:48PM GMT, Akihiko Odaki wrote:
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > PS: you don't need to put a signed-off-by line on the cover
> > letter, only in the individual patches.
> 
> I have been using b4 (https://b4.docs.kernel.org/en/latest/) these days and
> it automatically appends Signed-off-by to the cover letter.

Many subsystems use cover letters as templates for merge commits, which is why
b4 puts the Signed-off-by there. It has no impact on subsystems that don't do
that.

-K

