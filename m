Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1827C5AD44
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 17:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUcQ-00024k-Ea; Fri, 20 Feb 2026 12:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noodles@earth.li>)
 id 1vtU9V-0004yg-F5; Fri, 20 Feb 2026 12:18:53 -0500
Received: from the.earth.li ([2a00:1098:86:4d:c0ff:ee:15:900d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noodles@earth.li>)
 id 1vtU9T-0004Fo-S1; Fri, 20 Feb 2026 12:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
 s=the; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:
 Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EgmhS3ziW7td1p+9iFIUL8zNf+sBNzWX4OOYspE10Zs=; b=Y
 oNx6QlZkzAQRuqg++noFz2UyoAdljByLC0krMxEnPhGRYC9aKvxeSoXDE+yqlWVPPVomERtL7/oc+
 SPzBYPRGkMWOKyr0DvF+4rtszH/koF82BJrxEojtt/SpA9wZnf3dH8ub90+o4FtOAr0MROJAKIwnQ
 mY/JmzpqaU6U6NLpXMUXJE0Pc8TGgK5aULyRIYLsK5BoE+UNybLicSoCROpTDfpNmgtFWHa5sZqOh
 I8XudFMIWEF3NbhIwjh/M7gWTKJvAQavObmlDjm/qK4/rPAKn7T4EtXOoMlrwnSUE+Q+V/8bwxxwk
 7sB5QVPGeGkjI+jiEfC4n6XaPd0azvGkQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
 (envelope-from <noodles@earth.li>) id 1vtU9P-005bbe-0T;
 Fri, 20 Feb 2026 17:18:47 +0000
Date: Fri, 20 Feb 2026 17:18:47 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: NVMe: Add SPDM over the storage transport support
Message-ID: <aZiXdwyWO6MMsnXA@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=2a00:1098:86:4d:c0ff:ee:15:900d;
 envelope-from=noodles@earth.li; helo=the.earth.li
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 12:48:44 -0500
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

On Fri, 3 Oct 2025 21:39:41 +1000, you wrote:

> This series extends the existing SPDM support in QEMU to support the 
> DSP0286 SPDM Storage Transport [1] for NVMe. SPDM Storage Transport 
> uses the NVMe Admin Security Send/Receive commands, as such, support 
> for these commands have also been added.

> With the addition of a new `spdm-trans` CLI argument for NVMe 
> controllers, users can specify `spdm_trans=nvme` or `spdm_trans=doe`.  
> This allows for the selection of the SPDM transport. The `doe` option 
> is the current default, `nvme` would select SPDM Storage Transport for 
> the controller, where SPDM communication happens over the NVMe Admin 
> Security Send/Receive commands.

> Support for DSP0286 already exists in `libspdm` [2] and support for 
> the QEMU SPDM server is being upstreamed for `spdm-utils` [3]. This 
> series was tested by using `spdm-utils` as the qemu SPDM server with 
> SPDM Storage Transport support built with `libspdm` v3.8.0, and 
> `spdm-utils` also as the SPDM requester.

Do you have a pointer to the correct spdm-utils version/branch to use 
for testing this? I tried wilfred/spdm-storage-v4, which appears to be 
the latest, but it fails to build, and the footnote in your mail is 
dangling.

Thanks,
J.

-- 
If I could, I would, but I can't, so I won't.

