Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93298606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G24u1cdW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFQg-0005uU-5s; Tue, 03 Nov 2026 09:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQS-0005oc-LA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:23:48 -0500
Received: from out-205.mta0.migadu.com ([2001:41d0:1004:224b::cd]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQQ-0003Xd-GA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:23:47 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=TnIL01EYzJL8JJTpVq6O/937dbzj+ZPigqvXodpgbHc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793715824; v=1; x=1794320624;
 b=G24u1cdW1aRdOwL/H0En74GiM9tv+4Yj1xDV1bhmhYVYzhaU8DCgTXcVAwiUY/0e/5y2MhDV
 OdT8F76pyaT5awoya3ciaWSL21dwcNd17Sk+zHd6lj0ZnQDFRC4NY68lskHMtL8RleJPkn5Nu36
 R6NM9Z12QOuKDifLlX0qWmH4=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 8d5e30092c84e0cb;
 Tue, 03 Nov 2026 14:23:44 +0000
X-Mizu-Trace-ID: 8d5e30092c84e0cb
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, clg@kaod.org,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 kane_chen@aspeedtech.com, philmd@oss.qualcomm.com, kfting@nuvoton.com,
 wuhaotsh@google.com, zhao1.liu@intel.com, richard.henderson@linaro.org,
 deller@gmx.de, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, troy_lee@aspeedtech.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, junjie.cao@linux.dev
Subject: Re: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
Date: Tue,  3 Nov 2026 08:23:21 -0600
Message-ID: <20261103142327.1348025-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::cd;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 09:22:15AM +0000, Jamin Lin wrote:
> npcm7xx has no versioned machine type, so compat cannot reach it. Turn
> the property on here instead. The companion shares the EHCI bus, so
> the EHCI carries the property.

Checked quanta-gsj and npcm750-evb: a second HID device still fits,
through the hub.

Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>

