Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF35C61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpcA-0002PV-0D; Fri, 28 Aug 2026 01:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpc8-0002P6-NE; Fri, 28 Aug 2026 01:58:56 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpc7-0007az-62; Fri, 28 Aug 2026 01:58:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9131940DFE;
 Fri, 28 Aug 2026 05:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939A71F000E9;
 Fri, 28 Aug 2026 05:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787896725;
 bh=dy9m52vIe2kxwW14CcJm6vKDOe4xTWLVJtQzJF2vDDw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RM09vPAaOSOrPCmFQWT3lP/Jahbgv6vqMMCIf46ScIuQ3jp4UnR0tTatjMM44i0C9
 i5bKThTaWjbzRUfaOb4dcQv3EhJ20L77hp37euREsr9kkXJSz22ikyKy5fTn3JaEq5
 67LL7Uawxy7BVS0Ix9qYhvqRqTH0kixf485pWxW1iy7ARQ3dB+vxwrHT3a8Dp5NVS0
 2vgpxw1P3yCQV02zfndrkbhs+v91PN3SceSzQLeiWEqoaWv85GeKHO7H1GLTpOIS2o
 bj2YAywtl6/ubCI0CNLRSAxVz4t4Xnh8zrtfpqwFqYG8NbkLYtuhUYdM9Irp3rzGwB
 M4A1GIqZQJG4w==
Message-ID: <4fe373f3-6910-4122-ae0a-13880ad3e6cf@kernel.org>
Date: Fri, 28 Aug 2026 14:58:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] block: widen BlockLimits.zone_size to uint64_t
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/26 05:57, Niklas Cassel wrote:
> From: Sam Li <faithilikerun@gmail.com>
> 
> The zone-size field in BlockLimits is currently uint32_t, capping
> expressible zone sizes at 4 GiB. Real zoned-device protocols
> like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
> uint64_t to match.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

