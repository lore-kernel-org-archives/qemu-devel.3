Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E03D7308D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 15:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w92cx-0001yT-8j; Sat, 04 Apr 2026 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w92cv-0001y8-JU
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:09:33 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w92cs-0000ID-Qb
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:09:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C1B4460008;
 Sat,  4 Apr 2026 15:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5861C19421;
 Sat,  4 Apr 2026 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775315367;
 bh=AdSfTt51/4GujFKvAMeYTccukiZ6utcnghaF5tser08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t7FDkMKi8qwIkhDPO9UUw1jOWydlG/A+bIydTteLjtDvOcFMVdkcCR5jUdnUmsXw7
 5IqhZTJEeQumyHC13E43/rAZvLL9LNWdxPyclyHK/ePzlYzFghiV/pA4W3BIt55wxD
 VRofVqw4My90YZZ4eHG37a6Y2ZCnESOe3d7GOGRBf9SeMrrzKU41GBYAggmmFJOapi
 ugU7T0xVIm4Urfsmu8LJUsos7Z3VJqblH+L7/AIhbT1OXqkIelx7t7tIaP5c7mNrqe
 S3zD+UpweavR2e8FWP1U/bWUEutqKi0FhxcG0eoSCtWwY8ivzf3qyP4c7zvlf08I14
 xnCjBIMaj6BTw==
Date: Sat, 4 Apr 2026 17:09:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <20260404-auspacken-giftschlange-faa22ed667ee@brauner>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On Thu, Apr 02, 2026 at 11:19:15PM +0200, Christian Brauner wrote:
> QEMU supports runtime hotplug for chardevs, devices, block backends,
> and netdevs. Monitors are the only major subsystem that lacks this --
> all QMP monitors must be configured at launch via -mon or -qmp CLI
> options.
> 
> This series adds monitor-add, monitor-remove, and query-monitors QMP
> commands so that management tools can create independent QMP sessions
> on demand at runtime.

I'm going to send v2 soon as I've identified issues in this series I
want fixed first. Thanks!

