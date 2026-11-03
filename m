Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E87606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QboAiju9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFQT-0005ob-UR; Tue, 03 Nov 2026 09:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQO-0005nx-RE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:23:44 -0500
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQM-0003Wz-Ro
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:23:44 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=NTV+1o9uyf+zEu0ODQ9KkP1B/rZrf/y6VMKSqc5Ax4I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793715817; v=1; x=1794320617;
 b=QboAiju9IWD/dscQhRzlARGmJXJd9PiEjLOWQn6FfJRqb52IMvX2e/vKlawpZcaFMXneOaEU
 qMcMhIhexIJQNyAULgH6wDkf3U/JYkBd4DZanIIw96ieWysxvydi0uWJTqLBv1hFImBk43k0Ia2
 iZ0+2WGH8eldQ2b43IugzeMo=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 8b8233e03e8ecb06;
 Tue, 03 Nov 2026 14:23:37 +0000
X-Mizu-Trace-ID: 8b8233e03e8ecb06
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
Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Date: Tue,  3 Nov 2026 08:23:19 -0600
Message-ID: <20261103142327.1348025-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::bd;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jamin,

On Mon, Nov 02, 2026 at 09:22:05AM +0000, Jamin Lin wrote:
> Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older
> machine type keeps the hub it has today and a guest saved by an older
> QEMU still loads.

Reran the migration check from v7: with pc-q35-11.1, a guest saved
without the series loads on v8 with the hub in place, for qemu-xhci
with four HID devices and for q35 -usb with six.

But this missed the 11.2 soft freeze, so in 12.0 pc-q35-11.2 is an old
machine type too, and hw_compat_11_1 (my suggestion on v7) doesn't
cover it. Saved with pc-q35-11.2 on master, both cases fail on v8:

  Unknown section or instance '0000:00:01.0/4/usb-hub' 0
  Unknown section or instance '0000:00:1d.7/6/usb-hub' 0

The entries from 02-05 want hw_compat_11_2 once the 12.0 machine types
are in.

Junjie

