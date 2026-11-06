Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF1606A332
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPI9U-0003Wl-U1; Fri, 06 Nov 2026 06:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xPI9S-0003QU-El
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:30:34 -0500
Received: from out-177.mta1.migadu.com ([2001:41d0:203:375::b1]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xPI9Q-0001th-FX
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:30:34 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=XsI4CJ2an+tJXTOsJyS0x8/XxNKm4P+8FVw9XUcVmiY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793964627; v=1; x=1794569427;
 b=D/Yy7Ivzk5Esf10z8IA3huM8f4it3Y4DMptPt4+FzfwW+H57K39WkEkc5IUxunspu0wALl8+
 tFcVmKrBdGPYaSdJUMtyQOyJtoJrQ9sZtnxWgIfbkuJIj98VGvWOsl5FPxSXdGt9Wt8jVCN1guQ
 K7dhkC2ppLNv+Ml4G52qUt/k=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 1377caa7985a86b7;
 Fri, 06 Nov 2026 11:30:26 +0000
X-Mizu-Trace-ID: 1377caa7985a86b7
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: berrange@redhat.com,
	jamin_lin@aspeedtech.com
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, clg@kaod.org,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 kane_chen@aspeedtech.com, philmd@oss.qualcomm.com, kfting@nuvoton.com,
 wuhaotsh@google.com, zhao1.liu@intel.com, richard.henderson@linaro.org,
 deller@gmx.de, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, troy_lee@aspeedtech.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, junjie.cao@linux.dev
Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Date: Fri,  6 Nov 2026 05:30:21 -0600
Message-ID: <20261106113021.2841297-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au2ZDOY7MGdY74L9@redhat.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-1-junjie.cao@linux.dev>
 <SEZPR06MB73626D50E685F83DFB006D8DFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <SEZPR06MB7362D089282550D7585C16DEFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <au2ZDOY7MGdY74L9@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::b1;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, Daniel. I'd be happy to continue reviewing v9.

Hi Jamin, if you decide to split the series, patch 01 could stay with the
server: it keeps existing controllers unchanged while letting the server
disable auto-hub. Patches 02–10 could follow separately, with the compat
TODO Daniel suggested.

I checked that 01 plus 11–18 apply cleanly to current master.

Thanks,
Junjie

