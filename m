Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6251BC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aTY-0000FN-8k; Thu, 10 Sep 2026 04:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aTX-0000F7-3X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:49:43 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aTV-000818-MN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:49:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F2BB600C8;
 Thu, 10 Sep 2026 08:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541121F000FF;
 Thu, 10 Sep 2026 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030180;
 bh=gf9TPAr8r4rL1DipDW4gjlVrefNEg0Ux0vmCwWe++YA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CvVo1joFPykD64rzxOSh0Ra3UatBRa1PRBDOfS0+l89xZYj4WtwhsfIWCMm8mBuXl
 Nipc70hYcGJUncMfelvobNr/SXkY9pExut49CS0BTi91aY9gJ2gddAbqzgsNHVz7aq
 Oqzm25Zz3JypN1DquVyEKVyytBqXZ59phk+Rqh+G6DiAFsC8Z+NkVYUWNfLbzQxLGh
 LJ8Em8oled9D/XKy9O6/yPmn0vvXfBW/vxi3lS7AgR2y+AfEmf87NDun/lFjQ5FrSB
 Psx/mec8uj8V9oLa+ZVNAsGF64Hpa02bz2Ec82HDhSjHffIuXO75aDwhCcmQVmHUjT
 7nPVOG++C3rTQ==
Message-ID: <4da336c9-bff9-4d84-8ad9-f2ffdcf3bc54@kernel.org>
Date: Thu, 10 Sep 2026 10:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] ramblock: Rename guest_memfd to
 guest_memfd_private
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-5-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-5-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
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

On 9/8/26 15:30, Michael Roth wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Rename the field to reflect the fact that the guest_memfd in this case only
> backs private portion of the ramblock rather than all of it.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---

Reviewed-by: David Hildenbrand <david@kernel.org>
-- 
Cheers,

David


