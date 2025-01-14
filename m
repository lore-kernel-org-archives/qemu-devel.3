Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557A7C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgAg-0003UA-6H; Tue, 14 Jan 2025 07:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1tXgAd-0003Ts-FN; Tue, 14 Jan 2025 07:37:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1tXgAb-0005gF-NM; Tue, 14 Jan 2025 07:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gMRHXaXuORtPFdmoNZt+45T63EqxvhKVq+lNZZW1sJM=; b=ljaEyw6wy0NSsC6Q8kVwQv1sfq
 Wr16jsJsI/Vfz+b0kro2tjQYfdmceXGupCmQb9j313w9nb98JOb3fp8BTRQzCyN31jhhWMXX/7YR5
 PCocGZcbkdhoLXg0LIZ0dI3Kz32F9f0GktqM1m+gmA/UlYQiCLKihiScFkfjxAajqOtJ9WR+8joya
 bok0kz1PPUEtxEjeOwA2c5vGUbcNIXt1gDeIbOnjn9i+BpMZkUS7fN00qfD8ZuObIg5GJRXTE3sTT
 cRZ1kfE1Y+IeePXCBV4sIp6cxSAovPA6kVOL8cYerqlwUVk4kCfhgwLVmsdx2a15Q+rbHg/dN1nY0
 i+aNUa7Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tXgAL-00Fe8o-Dy; Tue, 14 Jan 2025 13:37:05 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1tXgAJ-00FL6L-CM; Tue, 14 Jan 2025 13:37:05 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1tXgAJ-00Dihm-0i;
 Tue, 14 Jan 2025 12:37:03 +0000
Date: Tue, 14 Jan 2025 13:37:03 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH v4] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
Message-ID: <Z4Zabw2H-ihONlV5@igalia.com>
References: <20240730141552.60404-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730141552.60404-1-berto@igalia.com>
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

On Tue, Jul 30, 2024 at 04:15:52PM +0200, Alberto Garcia wrote:
> This tool converts a disk image to qcow2, writing the result directly
> to stdout. This can be used for example to send the generated file
> over the network.

