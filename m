Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D70C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aZv-0002q9-JM; Thu, 10 Sep 2026 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aZt-0002pf-Fx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:56:17 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aZs-0000rO-0c
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:56:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1868C4378B;
 Thu, 10 Sep 2026 08:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70771F000FF;
 Thu, 10 Sep 2026 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030575;
 bh=zLPMpgcC9a/XKJ9nrZBpa2ScmZHpm0Mqmfrasgf07Iw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SbZm2k9Lwbevll9zMeSENV1a0Q6royKZSXhkdA0wRnsR1IYSzYdra9l+g5R/XJsXV
 a3P7jK7nhYSqCSUhQg4JofoVoSXM+JVxsTAZbyi3JLtjPNyMHvdCzk1fPhdaY++CPD
 2PzQSIKvGoeFlWA0SZBiS4wrDzlaFf8ozVF9ZkHut51MCMmRqL01kheLEIYU+vQNEE
 eZoGr5BnPmQlt9CMdFeR1NESR3iYmmuxLBFiV6tqQAPZ9fRiLTyG44IseOIteiYw19
 ZKY/dWOQ3PFbyjmmRHZcaAMqQqBa/yV2c1LDsNMW0O3GBYeyO9GSMOKHmeRIoiUgFb
 /nh6+gQlNexLA==
Message-ID: <bc1afd29-cdfd-445c-8f87-cc12d0519691@kernel.org>
Date: Thu, 10 Sep 2026 10:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] memory: Rename
 memory_region_init_ram_guest_memfd() to *_private()
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, Peter Xu <peterx@redhat.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-11-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-11-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=david@kernel.org; helo=sea.source.kernel.org
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

On 9/8/26 15:31, Michael Roth wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Differenciate it from fully shared guest-memfd use cases.

s/Differenciate/Differentiate/

Same question regarding patch ordering.

Reviewed-by: David Hildenbrand <david@kernel.org>

-- 
Cheers,

David


