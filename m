Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBCCC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aUP-0000m5-Up; Thu, 10 Sep 2026 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aUN-0000lr-W4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:50:36 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aUM-0008Fu-HA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:50:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CEC8429F7;
 Thu, 10 Sep 2026 08:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86DD1F000FF;
 Thu, 10 Sep 2026 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030233;
 bh=Ve9ehCy83moIAk2apJME5DpZMln8LcY79rbWi1b15KA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UrK0dGBJ3uqFG293E9aBTOP5aCkF03sAUD5cohtISsHykJOKlE4kkAwPJ5sPuL5KA
 0CzpaYIE+FA9WrRk6PvmiVYMXT3MULi+dwZsBuUCAwXGOHG0dFx9pakP6yJd1pXQQh
 2p8+qQC6l8+LRPgimZsGeQNci+qoglgY2KH2gkE1ob2QR4GDzJxpLCL1JMjkeRG3ce
 Y1K5AGJdakqzeSJL/DjInAK+ir9TBmE8Gh++WxtYCYEOLA2IJxgspQHrtoOjx1u+6Z
 A8C+cLqlMKpdyCeiXJbJWmC3TV54YEJn9INheAlcKZbKaKER9/CbbNvwb/egUF2ZlM
 tcQ7ls+I0TuVQ==
Message-ID: <6b309cc5-6525-497a-af5d-74adb5fbaf69@kernel.org>
Date: Thu, 10 Sep 2026 10:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-6-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-6-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
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
> This name is too generic, and can conflict with support for using
> guest-memfd for shared memory. Add a _PRIVATE suffix to show what it
> really means: it is using guest_memfd specifically for private memory;
> whether or not guest_memfd is being used for shared memory is something
> to be configured/determined separately.
> 
> This also paves way for in-place guest-memfd, which means we can have a
> ramblock that allocates pages completely from guest-memfd (private or
> shared).
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


