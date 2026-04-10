Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3096FF459E9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDaL-0007LP-Gp; Fri, 10 Apr 2026 11:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wBDaE-0007KU-Lh
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:15:48 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wBDaD-0005gc-5N
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:15:46 -0400
Received: from example.com (unknown [167.220.208.74])
 by linux.microsoft.com (Postfix) with ESMTPSA id EC62720B710C;
 Fri, 10 Apr 2026 08:15:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC62720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775834143;
 bh=TjmSR5ot8qnJB+7P8gdzM3ES2sXgm7IPqX+SRJryobY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lILJrZXUflKUl6MZd4wPHHprqxNQXLAB4qH3iKZzNQkgsHpwIScEnXE7xz7BnnpNt
 /LpA45Z6WhjbmzdzhOVT2+rSU4sARoacVgjtPBWp7Om27USIc0x/vVMC4kP/rZegnS
 Y7E+pBZMlF/4b1Aj+Y9UaCfGdDzz1AmDE1eFFhUQ=
Date: Fri, 10 Apr 2026 17:15:39 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 1/2] accel/mshv: fix ioeventfd deassignment to forward
 correct datamatch value
Message-ID: <adkUGzhat6PuqphX@example.com>
References: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
 <20260409-fix_ioevent-v1-1-053b810ae6fb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-fix_ioevent-v1-1-053b810ae6fb@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 09, 2026 at 11:53:06AM +0000, Aastha Rawat wrote:
> unregister_ioevent() is not forwarding the datamatch (queue index) to
> the mshv driver, causing only the first VirtIO-MMIO queue to be
> deassigned correctly. Subsequent queues fail with `-ENOENT`, triggering
> a fatal abort().
> 
> This failure was discovered while booting arm64 EDK2 firmware with mshv
> accel.
> 

Looks good, I tested the patch on x86 w/ virtio queues.

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

