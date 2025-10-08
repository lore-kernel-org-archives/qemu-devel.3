Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42DFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 19:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ZbZ-0004A9-F9; Wed, 08 Oct 2025 15:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1v6ZbS-00049v-CI
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:13:34 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1v6ZbE-0000gN-BO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:13:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F4B2458E8;
 Wed,  8 Oct 2025 19:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34121C4CEE7;
 Wed,  8 Oct 2025 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759950791;
 bh=m/A0eV+ZBKqXV1MdOleiu/NIzcJwVTqXPBdIqk5vM/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sTeCSIKh1uKAInaS56ojh4FqIxTiPu6juj2ZHNXDMu5rwrQO0VuwpeD4rzdYjgDu2
 y7Sh1h1zQ0DqoH0hfJ/Rrkp5QfnupR2uANVZgbNtl8Sp2NJa1L5jDC4RcfJL9CfnZ5
 gjpgV3fePkMsfeV6Taxw+iy1rpW3+SYUmp7h32/5Gyw9UdruE5wi6V4MqSk8mtmu6R
 kLXGQqvcVb/u1SkY4cdAuuUF03ZjvE1dW8LUkV+UdGaNia0j3DHtAyQrxg6kam8wlI
 Rr/luCkOS+9dQnkA7O+7McIh6j3Cu2UM62M1RCREDgCl0ulEo4e5lSuUuMzV5poIXZ
 G5bzdqyhMKthQ==
Date: Wed, 8 Oct 2025 19:13:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: Re: [PATCH 26/27] docs: Add mshv to documentation
Message-ID: <20251008191309.GA2474240@liuwe-devbox-debian-v2.local>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
 <20251002171536.1460049-27-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002171536.1460049-27-pbonzini@redhat.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 02, 2025 at 07:15:35PM +0200, Paolo Bonzini wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
[...]
>  
>  In the context of QEMU, an hypervisor is an API, provided by the Host OS,
> -allowing to execute virtual machines. Linux implementation is KVM (and supports
> -Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
> -NVMM.
> +allowing to execute virtual machines.  Linux provides a choice of KVM, Xen
> +or MSHV; MacOS provides HVF; Windows provides WPHX; NetBSD provides NVMM.

Typo here. It should be WHPX.

Wei

