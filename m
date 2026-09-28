Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9BC98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB30w-00058L-Ru; Mon, 28 Sep 2026 00:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xB1aQ-0003ou-9i; Sun, 27 Sep 2026 22:59:26 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xB1aO-0002g7-L0; Sun, 27 Sep 2026 22:59:26 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 70BCD21B01;
 Mon, 28 Sep 2026 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1790564359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0w2pWuTPdfsKrtXIlLJwRkP5AEM0VR0FGtfcN7xq20=;
 b=XeHQX3L6X+4WWs1fl+tYuHjRBtp+i8QB7ZTgtApDg8EO0uJfDQEFORJLrgEu0535QBso0h
 AJCpAdREnF8Q2czJstdx/xx8rpddrU1oQR0+3tzTYFRdNGEyuICH8rqkfkAQQeWnAzTjKV
 9v8AT0EkiNfAWxq1RRifbzUEWEnx8U2/5tlsKYJKJQFttSYDyMdgirOcDNlR6mfcSUzYnB
 AJzXrIGuJHrj1AKfbMcUU1bboFxr6AYqJ8uMkFkkJ/Rv6LG+0D00D38yGd9KT4DMkZt9v9
 eylNzA2Xqox55Xwl0WCVzE+rnjka2TV4m/5Odktr5IcG52rThI3NqbnP1FLnUw==
Received: from [192.168.1.131] (OPNsense.thinking.duckdns.org [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id 96017E0F;
 Sun, 27 Sep 2026 19:59:18 -0700 (PDT)
Message-ID: <9dd3c99c-5f57-43b6-b591-84e10b425443@sloservers.com>
Date: Sun, 27 Sep 2026 19:59:15 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [Stable-11.1.2 v2 64/92] linux-user/riscv: invalidate
 reservations after stores
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
 <20260927104821.196183-8-mjt@tls.msk.ru>
Content-Language: en-US
From: Rick <rick@sloservers.com>
In-Reply-To: <20260927104821.196183-8-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 00:30:48 -0400
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

On 9/27/2026 3:47 AM, Michael Tokarev wrote:
 > From: wangyang <wangyang25@otcaix.iscas.ac.cn>
 >
 > In linux-user parallel execution, AMO and ordinary integer stores do not
 > invalidate load reservations held by another hart.
[...]
 > Use the existing EXCP_ATOMIC path to re-execute LR, SC, AMO, and ordinary
 > integer store instructions in a serial context.
[...]

Please hold this patch out of 11.1.2. It makes riscv64 user-mode
emulation much slower, and multi-threaded guests can stall.

Once a guest has a second thread (CF_PARALLEL), gen_store() exits
through EXCP_ATOMIC on every ordinary integer store, so each store
stops all other vCPUs (cpu_exec_step_atomic -> start_exclusive).
LR, SC and AMOs take the same path. In addition, every store,
single-threaded or not, calls helper_riscv_invalidate_reservations(),
which walks all CPUs.

xz compressing 2 MB at -6, without and with the patch:

                 without patch    with patch
   xz -T1        5 s              122 s   (identical output)
   xz -T8        1 s              no output after 600 s

Measured with bsd-user on a FreeBSD 15.1/amd64 host running a FreeBSD
riscv64 userland. The only difference between the two builds is
reverting 5089493e45. The code involved is target/riscv under
CONFIG_USER_ONLY, which linux-user shares, but I have not measured
linux-user yet. I found this today while investigating riscv64 hangs
in bsd-user.

I'm not disputing the correctness fix for work item 4149 (a same-value
store by another hart must break an LR reservation), only the cost of
serializing every store to get it. That issue was found by a synthetic
test, while this regression hits ordinary multi-threaded programs, so
I'd suggest leaving the patch out of stable until master has a cheaper
approach.

Rick Richard

