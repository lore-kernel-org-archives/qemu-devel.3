Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A405D2F34F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfieH-00048f-6k; Tue, 13 Jan 2026 12:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vfide-0003y8-KF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:57:08 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vfidc-0005l9-SW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:57:06 -0500
Received: from example.com (p3e9c06ce.dip0.t-ipconnect.de [62.156.6.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1F83A20B716D;
 Tue, 13 Jan 2026 09:57:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F83A20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1768327023;
 bh=7idDqj56L/qVydakVryjoibq9RuMpR3bCCknc2ZO3xQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HaHNDqyamA764PvMg796OSpGaLp2NO4ClRX0BfgePr+Jsb7AwMqWBHJOmOA2kZlQQ
 r+V0yy9EvVbNzE/caCjD7NKwmqu9cbEsYgt4eyaREvkKzbZK1GAje2XPLjwXc6E7xa
 M7bHvc4b0Uj5ibsxo0sc06yVw+WlokmtVAhXVOPA=
Date: Tue, 13 Jan 2026 18:56:57 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
Message-ID: <aWaHadZujN8AIHMA@example.com>
References: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
 <b302b2d9-16aa-4f79-83b3-ea749696af0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b302b2d9-16aa-4f79-83b3-ea749696af0c@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Jan 13, 2026 at 06:24:01PM +0100, Paolo Bonzini wrote:
> 
> What other changes are needed?
> 

on QEMU there are no further changes required. The commit has been
authored in a way that it would be easy to undo later.

L1VH testers have been using QEMU's master branch with the remap commit
reverted.

On the kernel side it looks like the basic L1VH enablement patches were
introduced in 6.18 already (f26c930), but there are a few more relevant
fixes in 6.19 for some aspects like device PT, soft reboot and xsave
provisioning.

> I'll leave the code in for a while until 6.19 is released.

yes, this makes sense. thanks,

magnus

