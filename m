Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A1CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2SQ-0002hw-M3; Tue, 23 Jun 2026 10:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wc2SE-0002gm-5J; Tue, 23 Jun 2026 10:50:24 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wc2S7-00037C-9Z; Tue, 23 Jun 2026 10:50:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BAF0601F5;
 Tue, 23 Jun 2026 14:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838241F000E9;
 Tue, 23 Jun 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782226210;
 bh=WEfmUDFs554s8Hu1S1ODLwmZkIGEPox3ftCakezFu0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YTvTbq+j25vxKkc1DWU7TMn15EG17AryTOYGL/OggO/AZmdZP4PCea+QLscFtLKRi
 CVUt7yFsgpvJ/LUs6ZkVMZEh8ETas8SD1S2iydFgIikOxFTzNmo/XreyKcDaFQdOSl
 E8dzSP9YFBdMxHoHcrQa0uhTlCyb+zjNwiAGik5Faq5miiyqTDg1PYr0QgvdTxfscx
 LTv3e/eiErm1SaMpjyNuIkDQMznJjtbcAHOGkBqlPvnkdn3Pjk8X5dTsGYzmozajJC
 LHahlouupPKI1UAYVrSiEtaj+AUJjc/M2pgexNAw9Yb2k4AEjchDwdcKNFu0MSv3gf
 zft/wFizIIsOg==
Date: Tue, 23 Jun 2026 08:50:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Utkarsh Singh <utsingh@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maurizio Lombardi <mlombard@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH] hw/nvme: add user controlled 'vid' property
Message-ID: <ajqdIS-BZeyV3lnA@kbusch-mbp>
References: <20260623131946.46879-1-utsingh@redhat.com>
 <CAFEAcA-nrh63fWvnVSSJExspOw28WkZyn69=YMdb5=ZA8m95uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-nrh63fWvnVSSJExspOw28WkZyn69=YMdb5=ZA8m95uA@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 23, 2026 at 03:01:12PM +0100, Peter Maydell wrote:
> Should we also have a "device-id" property here? Being able
> to set the vendor-ID only seems unnecessarily limited, since
> PCI IDs are a (vendor,device) tuple.

Yes, the quirks are usually based off the same tuple, so there should be
a way to set both when that's the justification for the patch.

