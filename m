Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4ACCE7B1E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaNj-0000H4-Fx; Fri, 06 Sep 2024 10:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smaNg-0000GQ-1s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:56:12 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smaNZ-0001mH-Ji
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:56:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0E9D6A43595;
 Fri,  6 Sep 2024 14:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D28C4CEC4;
 Fri,  6 Sep 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="XI42mrDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725634561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=LGnZDMfJU884B2YPkVPeudaYSKIzukkErVdTwkER1r8=;
 b=XI42mrDWgxG4+GGrNaLclZ2jvIdN/SsSWelDdUSEcxWg9YzPEpcOHm0WjKDOgicpF2pDpA
 TsS2lgB67NhGC6sFXtfK7jf5eEBsf2DKHrX47sqk3TAKK/Dza38SIoSin+lVEIVuBwIeJN
 8k+F9hSQ5ezexArMKhJCdYEpO5SZSnI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82d7cc8d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 6 Sep 2024 14:56:01 +0000 (UTC)
Date: Fri, 6 Sep 2024 16:55:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: LoongArch without CONFIG_ACPI and CONFIG_EFI
Message-ID: <ZtsX_tcEuOjktUl9@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

It appears that as of QEMU 9.1, it's possible to boot LoongArch machines
that don't provide EFI or ACPI.

Would you consider removing the `select ACPI` and `select EFI` from the
arch Kconfig, so that kernels built for this minimal QEMU environment
can be a bit leaner and quicker to build?

Jason

