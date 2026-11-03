Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B1606A331
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RNDu8mGY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFQh-0005vJ-El; Tue, 03 Nov 2026 09:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQd-0005sZ-IM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:24:01 -0500
Received: from out-19.mta1.migadu.com ([95.215.58.19] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOFQZ-0003ZM-M2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:23:58 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=thSjGA6wOead7YqHEZ5eHt15E3jrEy1d9zA7U1Xp35o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793715833; v=1; x=1794320633;
 b=RNDu8mGY9N8V/vcDfiQw43S17UBm1hVMRXEikMKU8MPZOZ174x5wrWYjoe9YNEWe3z0dimQ5
 3oaYM+g3V+52R/6TvA0JCBm8fs1Z2Vj+3RBDVW02oJ7782WOSodPJMr1qxGzQLFzS+/7tiwX5kU
 lPu7RGHr5dkIWWAiYAUZ5n5I=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 90e5dc68535ae2f0;
 Tue, 03 Nov 2026 14:23:53 +0000
X-Mizu-Trace-ID: 90e5dc68535ae2f0
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
Subject: Re: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic hub
 change
Date: Tue,  3 Nov 2026 08:23:22 -0600
Message-ID: <20261103142327.1348025-4-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102092201.1729245-11-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-11-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.19; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
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

Hi Jamin,

On Mon, Nov 02, 2026 at 09:22:17AM +0000, Jamin Lin wrote:
> +A machine type older than 11.2 plugs a virtual USB hub into the last
> +free port, so that more devices fit. A newer one does not, and a
> +device that finds no free port fails.

With the series going into 12.0 this becomes "older than 12.0".

It would also help to say how to get a hub back. piix3-usb-uhci has two
ports, so -usb with usb-kbd, usb-mouse and usb-tablet already fails on
the newest machine type (pc-i440fx-11.2 on v8). Either of these fixes
it here:

  -device usb-hub                     (ahead of the other devices)
  -global piix3-usb-uhci.auto-hub=on

Junjie

