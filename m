Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21DED1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89BJ-0003cT-Pl; Mon, 04 Nov 2024 21:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1t89BI-0003cC-Dk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:20:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patchwork-bot+netdevbpf@kernel.org>)
 id 1t89BG-0001f9-G6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:20:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B685E5C56E0;
 Tue,  5 Nov 2024 02:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49996C4CECE;
 Tue,  5 Nov 2024 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730773226;
 bh=H7DITtRwtsNLWdS6hpi1Dq1VgEaFbuMZ06KvxC6YoWs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=BpFh/7Ehgn9ARUYp1fdOf8SxLiBRY2aBW0N7E1q9IzeEZIOt7K4hEJdyp+pe6US8Z
 uIyNHtDk4FANEE6YLIIWaqyy2WSAMBucrhSdie4jQJqi5CI6+gvS2RTiEw6/2F3m5H
 MaUIe+x0XFTN/YfVkfHLg84xg6XCqVop8eUycfERc2fJrF05xDsfxslKnSMQoMkbYF
 Uxa4eZ+hJuELXSKtHaX2Jf2azkq+aC0FP8IlyixSRgqtudHMwDHXit5qi0fTWlCMpL
 jZo34LnPV8ZdXr1T7q8TSW1kBpNOw9XkK4noVxRP/qylQMnK1+j0r0+hO9nM1oe1LS
 cGZU2YX9017Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33F203809A80; Tue,  5 Nov 2024 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp: Remove 'default y' for VMCLOCK PTP device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <173077323501.89867.2401311053737596737.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:20:35 +0000
References: <89955b74d225129d6e3d79b53aa8d81d1b50560f.camel@infradead.org>
In-Reply-To: <89955b74d225129d6e3d79b53aa8d81d1b50560f.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kuba@kernel.org, richardcochran@gmail.com, peter.hilber@opensynergy.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 ridouxj@amazon.com, virtio-dev@lists.linux.dev, rluu@amazon.com,
 chashper@amazon.com, abuehaze@amazon.com, pabeni@redhat.com,
 christopher.s.hall@intel.com, jasowang@redhat.com, jstultz@google.com,
 mst@redhat.com, netdev@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
 xuanzhuo@linux.alibaba.com, maz@kernel.org, mark.rutland@arm.com,
 daniel.lezcano@linaro.org, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com, qemu-devel@nongnu.org, horms@kernel.org
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 02 Nov 2024 16:52:17 -0500 you wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The VMCLOCK device gives support for accurate timekeeping even across
> live migration, unlike the KVM PTP clock. To help ensure that users can
> always use ptp_vmclock where it's available in preference to ptp_kvm,
> set it to 'default PTP_1588_CLOCK_VMCLOCK' instead of 'default y'.
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: Remove 'default y' for VMCLOCK PTP device
    https://git.kernel.org/netdev/net-next/c/18ec5491a495

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



