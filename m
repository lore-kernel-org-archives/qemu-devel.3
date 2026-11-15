Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A443606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wfp/YTil
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSbmd-0007uY-N6; Sun, 15 Nov 2026 10:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbmb-0007tl-Ik
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 10:04:41 -0500
Received: from out-221.mta0.migadu.com ([2001:41d0:1004:224b::dd]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbma-0003Uc-2T
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 10:04:41 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=D0MZnHog1A8EE4Bm1aHHU0xGqK8HZGz7uIjWlkiBHIw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794755078; v=1; x=1795359878;
 b=wfp/YTilzaW0aDtB3gn4FyDG4Kpck6bi1Wz4yrAJWDm+6KB1+V8+y+F6DAR86cdpT8pA2dqA
 2eYUOvRf/Ue9CUmdBjMIi0K+++TrKo13nD4i9K2fbRKJfkEPxsUPG9pzd7+CkViz8rRwvL2M9wL
 yi2BwHCOI+XXmhSIcN7q/rFM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id d079f2d505d062ac;
 Sun, 15 Nov 2026 15:04:37 +0000
X-Mizu-Trace-ID: d079f2d505d062ac
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com
Cc: berrange@redhat.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 clg@kaod.org, pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 kane_chen@aspeedtech.com, philmd@oss.qualcomm.com, kfting@nuvoton.com,
 wuhaotsh@google.com, zhao1.liu@intel.com, richard.henderson@linaro.org,
 deller@gmx.de, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, troy_lee@aspeedtech.com,
 junjie.cao@linux.dev
Subject: Re: [PATCH v9 15/19] hw/usb/redirect-server: Send device and
 interface information
Date: Sun, 15 Nov 2026 09:04:19 -0600
Message-ID: <20261115150419.1309675-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110072818.2883349-16-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-16-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::dd;
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With usb-storage exported from ast2600-evb, usb-redir's VID:PID and
interface-class filters accept and reject as expected.

A local test device exercised NAK retries, asynchronous completion,
malformed descriptors and timeouts. Reset, disconnect and unplug
during an asynchronous descriptor read cancelled the pending request
before cleanup. Configuration and alternate-setting changes update
interface_info and ep_info, including configuration 0.

Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>

