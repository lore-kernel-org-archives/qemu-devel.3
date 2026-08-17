Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EAEC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxCP-0007DJ-8Y; Mon, 17 Aug 2026 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wvxCF-0007Cg-5R; Mon, 17 Aug 2026 09:16:15 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wvxCC-0002Fy-N7; Mon, 17 Aug 2026 09:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=WM5Qg2fz5gyzVZtSx0JD1Pdg7Dz4XydVVrgn+GcMwkc=; b=jwcfKHP42+2
 eI2Bid4xdCkKIgD/8QNEwcnay+ZC00yUDCP/P4wlriVTOzJqULEPwcLZkkjekjIlEvUN42UVvYOI0
 LZQ3MqVIokG6IX6NwOhbHqyCGbvoUaDm1zPrC+I9RpEyYTDosfncg+CNwRKKaZqqBgI4HrU2Z7tMA
 OBgLHHsqzaqAeSXq9Dv6b9RqqsRsh9FLL0EjkgF+LfJn9fZ0umMsPbh3bNPEyu+qcDHQs1EkrRf8M
 DL7s2dMaBB2EYqOOteZAo38zFeJT5IKx8spkdTAm3OUuImuUE5RjUEekOdR8AihChV3egfijT4VvX
 aTboCKbY0p0/CQ96ecmgpjg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvxBz-004SjH-BB; Mon, 17 Aug 2026 15:15:55 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1wvxBy-00AuAg-Ih; Mon, 17 Aug 2026 15:15:55 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1wvxBy-002tk8-1L;
 Mon, 17 Aug 2026 13:15:54 +0000
Date: Mon, 17 Aug 2026 15:15:54 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/sd/sdcard: Register device ops in drives without media
Message-ID: <aoMJijNhyBxemov4@igalia.com>
References: <20260723205847.137001-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723205847.137001-1-berto@igalia.com>
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

ping

On Thu, Jul 23, 2026 at 10:58:39PM +0200, Alberto Garcia wrote:
> This patch moves the blk_set_perm() and blk_set_dev_ops() calls
> outside of the 'if (blk_size >= 0)' block so the device ops and
> permissions are registered when a drive is attached.

