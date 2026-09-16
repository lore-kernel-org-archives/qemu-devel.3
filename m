Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D73BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 04:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6hWz-0001Rr-BZ; Wed, 16 Sep 2026 00:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6hWy-0001RG-01; Wed, 16 Sep 2026 00:46:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6hWw-00013Q-CN; Wed, 16 Sep 2026 00:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789533913; bh=p+N4rR/mBVjdf2W27VwmAYQhVVMgwZTyfXg2SzzUXik=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YDRjU+mjWGXhlFfF6BzTucxX4l8LZprbju2EvuBlh07yDRki6AvEmNw+s22CFV8mu
 mJJU3C9TONcWoxN+E7BIyXM8x6hea7TFVsq4J+AFv+e8oU2b0PoYAn0eg/7NS28k+c
 yoopbH3z9lw1M28Z5hEgyj1xhYh7PRdTL4PaWW5hWcJF/Mf+6H71WJscESAWalHnix
 j97/7Vi6xd6s7LrnYdzOoq929PalkamiefaoANbdg/MfGr76sIVtsPPdbKJ/sqgxi1
 c+EaL0EAR3r9QGIqQCCLWcUCaHlXVAbRYaQhmPgpwXLpOMefnE54z+nh9+oN2OrGIn
 xmDHe9P+HB6NA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEF1A1D54B4;
 Wed, 16 Sep 2026 07:45:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0472142996A;
 Wed, 16 Sep 2026 07:45:56 +0300 (MSK)
Message-ID: <dece0a0d-e4af-46aa-91cf-d79ef510b739@tls.msk.ru>
Date: Wed, 16 Sep 2026 07:45:55 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/20/26 03:30, Doug Cook (WINDOWS) wrote:
> ARM_CP_CONST registers ignore writes, so readback assertion fails.
> 
> Not asserting now because all entries in the whpx_sreg_match table are
> invalid. Needs to be fixed now so that we can fix the table entries.
> 
> Signed-off-by: Doug Cook <dcook@microsoft.com>
> ---
>   target/arm/whpx/whpx-all.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

I'm picking this series:

  1/3 target/arm/whpx: Don't try to sync ARM_CP_CONST registers
  2/3 target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
  3/3 target/arm/whpx: fix whpx-arm post-reset CPU state

for 11.0.x and 11.1.x stable qemu series.
Please let me know if I shouldn't.

Also, in the future, please consider marking changes which are possible
relevant for the older/stable qemu series, with Cc: qemu-stable@, and
consider adding a cover letter for multi-patch series, so whole series
comes as a single email thread with a description in front.

Thanks,

/mjt

